-- 마스네 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 167개(묶음 46, 다악장 9, 낱곡 112),
-- 새 작품 44개, part 265개, 그 아래 404개.
-- seed 151개 중 123개를 작품·part 에 잇고, 18개를 숨기고, 10개는 그대로 둔다.
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

-- Op. 2 2 Duos Op. 2

UPDATE pieces piece
SET piece.title = '2 Duos Op. 2', piece.title_en = '2 Duos, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10039 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Marine', part.name_en = 'Deux Duos, op. 2: No. 1. Marine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10039 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a9460e8e-1481-4c27-a3a3-586a1c2926fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9460e8e-1481-4c27-a3a3-586a1c2926fd', 1, NULL, 'Marine', 'Deux Duos, op. 2: No. 1. Marine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10039 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9460e8e-1481-4c27-a3a3-586a1c2926fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Joie !', part.name_en = 'Deux Duos, op. 2: No. 2. Joie !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10039 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f6ade550-6fcc-4aea-8bfd-f448008f3077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6ade550-6fcc-4aea-8bfd-f448008f3077', 2, NULL, 'Joie !', 'Deux Duos, op. 2: No. 2. Joie !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10039 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ade550-6fcc-4aea-8bfd-f448008f3077'
);


-- None 가곡 <Amoureuse>

UPDATE pieces piece
SET piece.title = '가곡 <Amoureuse>', piece.title_en = 'Amoureuse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8437 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Année passée I

UPDATE pieces piece
SET piece.title = 'Année passée I', piece.title_en = 'Année passée I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11070 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Année passée I: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11070 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f4dc1be2-99e1-4d03-8b3f-087a0178f0af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4dc1be2-99e1-4d03-8b3f-087a0178f0af', 1, NULL, 'No. 1', 'Année passée I: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11070 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4dc1be2-99e1-4d03-8b3f-087a0178f0af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Année passée I: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11070 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c2d2d1b5-33f1-4f42-886c-4b41bf3ae95d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2d2d1b5-33f1-4f42-886c-4b41bf3ae95d', 2, NULL, 'No. 2', 'Année passée I: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11070 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d2d1b5-33f1-4f42-886c-4b41bf3ae95d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Année passée I: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11070 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:07e42ff4-fa72-43c6-a79c-c5a0e146e7de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e42ff4-fa72-43c6-a79c-c5a0e146e7de', 3, NULL, 'No. 3', 'Année passée I: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11070 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e42ff4-fa72-43c6-a79c-c5a0e146e7de'
);


-- None Année passée II

UPDATE pieces piece
SET piece.title = 'Année passée II', piece.title_en = 'Année passée II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9091 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Année passée II: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9091 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b8f851d0-f5e0-4767-acf3-e469fa6500d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8f851d0-f5e0-4767-acf3-e469fa6500d4', 1, NULL, 'No. 1', 'Année passée II: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9091 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f851d0-f5e0-4767-acf3-e469fa6500d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Année passée II: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9091 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:126058f2-8fe1-4606-b98d-974cdb1416dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:126058f2-8fe1-4606-b98d-974cdb1416dd', 2, NULL, 'No. 2', 'Année passée II: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9091 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126058f2-8fe1-4606-b98d-974cdb1416dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Année passée II: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9091 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:16e584bb-bff1-4e21-8f27-582dec756565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e584bb-bff1-4e21-8f27-582dec756565', 3, NULL, 'No. 3', 'Année passée II: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9091 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e584bb-bff1-4e21-8f27-582dec756565'
);


-- None Année passée III

UPDATE pieces piece
SET piece.title = 'Année passée III', piece.title_en = 'Année passée III',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9026 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Année passée III: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9026 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:46a30370-9cb1-4d03-b013-3ca3a3325cee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46a30370-9cb1-4d03-b013-3ca3a3325cee', 1, NULL, 'No. 1', 'Année passée III: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9026 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46a30370-9cb1-4d03-b013-3ca3a3325cee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Année passée III: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9026 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f68a3f9d-0179-4934-a38c-338376c34889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f68a3f9d-0179-4934-a38c-338376c34889', 2, NULL, 'No. 2', 'Année passée III: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9026 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f68a3f9d-0179-4934-a38c-338376c34889'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Année passée III: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9026 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:82b997f8-a279-4109-a68e-e8ba5e37df4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b997f8-a279-4109-a68e-e8ba5e37df4a', 3, NULL, 'No. 3', 'Année passée III: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9026 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b997f8-a279-4109-a68e-e8ba5e37df4a'
);


-- None Année passée IV

UPDATE pieces piece
SET piece.title = 'Année passée IV', piece.title_en = 'Année passée IV',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9382 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Année passée IV: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9382 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b718d0c1-e428-4652-b1c6-4e083bc8534d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b718d0c1-e428-4652-b1c6-4e083bc8534d', 1, NULL, 'No. 1', 'Année passée IV: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9382 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b718d0c1-e428-4652-b1c6-4e083bc8534d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Année passée IV: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9382 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:65a77d9e-068a-47d8-914d-6e03ca875364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65a77d9e-068a-47d8-914d-6e03ca875364', 2, NULL, 'No. 2', 'Année passée IV: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9382 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65a77d9e-068a-47d8-914d-6e03ca875364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Année passée IV: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9382 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1fb0f0fc-75d3-4fc5-9ca6-e5c813ea3f2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb0f0fc-75d3-4fc5-9ca6-e5c813ea3f2e', 3, NULL, 'No. 3', 'Année passée IV: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9382 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb0f0fc-75d3-4fc5-9ca6-e5c813ea3f2e'
);


-- None 오페라 <Ariane>

UPDATE pieces piece
SET piece.title = '오페라 <Ariane>', piece.title_en = 'Ariane',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8798 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Ah ! Le Cruel » (Ariane)', part.name_en = 'Ariane : Acte III. « Ah ! Le Cruel » (Ariane)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8798 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1064b069-7ce9-46c0-afa1-085143ec6449' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1064b069-7ce9-46c0-afa1-085143ec6449', 1, NULL, 'Acte III. « Ah ! Le Cruel » (Ariane)', 'Ariane : Acte III. « Ah ! Le Cruel » (Ariane)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8798 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1064b069-7ce9-46c0-afa1-085143ec6449'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. « La Fine Grâce » (Ariane)', part.name_en = 'Ariane : Acte III. « La Fine Grâce » (Ariane)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8798 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:10bb7b4e-4dba-4a47-844c-77041b43d00b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10bb7b4e-4dba-4a47-844c-77041b43d00b', 2, NULL, 'Acte III. « La Fine Grâce » (Ariane)', 'Ariane : Acte III. « La Fine Grâce » (Ariane)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8798 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10bb7b4e-4dba-4a47-844c-77041b43d00b'
);


-- None 가곡 <Avril est amoureux>

UPDATE pieces piece
SET piece.title = '가곡 <Avril est amoureux>', piece.title_en = 'Avril est amoureux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10507 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Bacchus>

UPDATE pieces piece
SET piece.title = '오페라 <Bacchus>', piece.title_en = 'Bacchus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8521 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les Mystères dionysiaques', part.name_en = 'Bacchus: Les Mystères dionysiaques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37', 1, NULL, 'Les Mystères dionysiaques', 'Bacchus: Les Mystères dionysiaques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato - Nocturne. Lento sostenuto', part.name_en = 'Bacchus: Les Mystères dionysiaques: I. Allegro moderato - Nocturne. Lento sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:257427db-f496-4e64-a0aa-17010f772de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:257427db-f496-4e64-a0aa-17010f772de6', 1, NULL, 'Allegro moderato - Nocturne. Lento sostenuto', 'Bacchus: Les Mystères dionysiaques: I. Allegro moderato - Nocturne. Lento sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:257427db-f496-4e64-a0aa-17010f772de6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Faunes et satyres', part.name_en = 'Bacchus: Les Mystères dionysiaques: II. Faunes et satyres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fc9e482f-28cc-4c7d-b318-cc8fcdd111b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc9e482f-28cc-4c7d-b318-cc8fcdd111b3', 2, NULL, 'Faunes et satyres', 'Bacchus: Les Mystères dionysiaques: II. Faunes et satyres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9e482f-28cc-4c7d-b318-cc8fcdd111b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Procession de offrandes. Andante lento sostenuto', part.name_en = 'Bacchus: Les Mystères dionysiaques: III. La Procession de offrandes. Andante lento sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:53a41ca0-b11f-48f2-88f9-64229836287a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53a41ca0-b11f-48f2-88f9-64229836287a', 3, NULL, 'La Procession de offrandes. Andante lento sostenuto', 'Bacchus: Les Mystères dionysiaques: III. La Procession de offrandes. Andante lento sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53a41ca0-b11f-48f2-88f9-64229836287a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Chasseresses et bacchantes', part.name_en = 'Bacchus: Les Mystères dionysiaques: IV. Chasseresses et bacchantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c4e3f01f-4d6d-493e-8cc3-bc700e25d275' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4e3f01f-4d6d-493e-8cc3-bc700e25d275', 4, NULL, 'Chasseresses et bacchantes', 'Bacchus: Les Mystères dionysiaques: IV. Chasseresses et bacchantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4e3f01f-4d6d-493e-8cc3-bc700e25d275'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Initiations: I. Allegretto moderato', part.name_en = 'Bacchus: Les Mystères dionysiaques: V. Initiations: I. Allegretto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a1de3845-4f0c-43a5-9f78-2fc60ce7166e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1de3845-4f0c-43a5-9f78-2fc60ce7166e', 5, NULL, 'Initiations: I. Allegretto moderato', 'Bacchus: Les Mystères dionysiaques: V. Initiations: I. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1de3845-4f0c-43a5-9f78-2fc60ce7166e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Initiations: II. Lento sostenuto - Andantino con moto - Lento', part.name_en = 'Bacchus: Les Mystères dionysiaques: V. Initiations: II. Lento sostenuto - Andantino con moto - Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aede3919-464c-4683-81fb-31073a0572c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aede3919-464c-4683-81fb-31073a0572c7', 6, NULL, 'Initiations: II. Lento sostenuto - Andantino con moto - Lento', 'Bacchus: Les Mystères dionysiaques: V. Initiations: II. Lento sostenuto - Andantino con moto - Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aede3919-464c-4683-81fb-31073a0572c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Initiations: III. Allegro', part.name_en = 'Bacchus: Les Mystères dionysiaques: V. Initiations: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c6e73059-8f56-40fb-a9b0-233da88c634d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6e73059-8f56-40fb-a9b0-233da88c634d', 7, NULL, 'Initiations: III. Allegro', 'Bacchus: Les Mystères dionysiaques: V. Initiations: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6e73059-8f56-40fb-a9b0-233da88c634d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Initiations: IV. Allegro', part.name_en = 'Bacchus: Les Mystères dionysiaques: V. Initiations: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:844bb551-60b1-40b1-8527-7ae5ff9d533e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:844bb551-60b1-40b1-8527-7ae5ff9d533e', 8, NULL, 'Initiations: IV. Allegro', 'Bacchus: Les Mystères dionysiaques: V. Initiations: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:844bb551-60b1-40b1-8527-7ae5ff9d533e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Le Baptême par le vin. Allegro moderato - Allegro maestoso', part.name_en = 'Bacchus: Les Mystères dionysiaques: VI. Le Baptême par le vin. Allegro moderato - Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c7289754-98c0-4841-8f5a-fc1522c71441' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7289754-98c0-4841-8f5a-fc1522c71441', 9, NULL, 'Le Baptême par le vin. Allegro moderato - Allegro maestoso', 'Bacchus: Les Mystères dionysiaques: VI. Le Baptême par le vin. Allegro moderato - Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7289754-98c0-4841-8f5a-fc1522c71441'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Bacchanale. Allegro', part.name_en = 'Bacchus: Les Mystères dionysiaques: VII. Bacchanale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8521 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0589da4a-758f-4e32-be35-13c0e3d05cf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0589da4a-758f-4e32-be35-13c0e3d05cf8', 10, NULL, 'Bacchanale. Allegro', 'Bacchus: Les Mystères dionysiaques: VII. Bacchanale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed9a8500-f5dd-4a3b-affe-1864cff27d37'
WHERE p.id = 8521 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0589da4a-758f-4e32-be35-13c0e3d05cf8'
);


-- None 가곡 <Baiser-Impromptu>

UPDATE pieces piece
SET piece.title = '가곡 <Baiser-Impromptu>', piece.title_en = 'Baiser-Impromptu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8373 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ballet Suite from "Hérodiade"

UPDATE pieces piece
SET piece.title = 'Ballet Suite from "Hérodiade"', piece.title_en = 'Ballet Suite from "Hérodiade"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8880 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Les Égyptiennes', part.name_en = 'Ballet Suite from "Hérodiade": I. Les Égyptiennes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8880 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e384ac10-f06c-4a3d-aa12-49285a8a7336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e384ac10-f06c-4a3d-aa12-49285a8a7336', 1, 'I', 'Les Égyptiennes', 'Ballet Suite from "Hérodiade": I. Les Égyptiennes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8880 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e384ac10-f06c-4a3d-aa12-49285a8a7336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Les Babyloniennes', part.name_en = 'Ballet Suite from "Hérodiade": II. Les Babyloniennes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8880 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f3fb30a7-6e3d-421a-9931-8b5292de8821' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3fb30a7-6e3d-421a-9931-8b5292de8821', 2, 'II', 'Les Babyloniennes', 'Ballet Suite from "Hérodiade": II. Les Babyloniennes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8880 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3fb30a7-6e3d-421a-9931-8b5292de8821'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les Gauloises', part.name_en = 'Ballet Suite from "Hérodiade": III. Les Gauloises',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8880 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7d4cfaa7-f60f-4e53-ad7b-0566427c2b53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d4cfaa7-f60f-4e53-ad7b-0566427c2b53', 3, 'III', 'Les Gauloises', 'Ballet Suite from "Hérodiade": III. Les Gauloises', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8880 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d4cfaa7-f60f-4e53-ad7b-0566427c2b53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Les Phéniciennes', part.name_en = 'Ballet Suite from "Hérodiade": IV. Les Phéniciennes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8880 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:30336cae-32e6-4ce5-b522-275594c4f569' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30336cae-32e6-4ce5-b522-275594c4f569', 4, 'IV', 'Les Phéniciennes', 'Ballet Suite from "Hérodiade": IV. Les Phéniciennes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8880 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30336cae-32e6-4ce5-b522-275594c4f569'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Final', part.name_en = 'Ballet Suite from "Hérodiade": V. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8880 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f001f4ec-e5ca-458f-b696-e3c4104d108b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f001f4ec-e5ca-458f-b696-e3c4104d108b', 5, 'V', 'Final', 'Ballet Suite from "Hérodiade": V. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8880 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f001f4ec-e5ca-458f-b696-e3c4104d108b'
);


-- None Brumaire

UPDATE pieces piece
SET piece.title = 'Brumaire', piece.title_en = 'Brumaire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8394 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ce que disent les cloches>

UPDATE pieces piece
SET piece.title = '가곡 <Ce que disent les cloches>', piece.title_en = 'Ce que disent les cloches',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8110 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Cendrillon>

UPDATE pieces piece
SET piece.title = '오페라 <Cendrillon>', piece.title_en = 'Cendrillon',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8783 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Cendrillon : Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:556c1cfc-ea86-4dab-ac2e-740d44180ffb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:556c1cfc-ea86-4dab-ac2e-740d44180ffb', 1, NULL, 'Introduction', 'Cendrillon : Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:556c1cfc-ea86-4dab-ac2e-740d44180ffb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Cendrillon : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67', 2, NULL, 'Acte I', 'Cendrillon : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Madame, ce sont les modistes »', part.name_en = 'Cendrillon : Acte I. « Madame, ce sont les modistes »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:180bfb9c-0cca-482f-8d41-39ea73eebe00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:180bfb9c-0cca-482f-8d41-39ea73eebe00', 1, NULL, 'Acte I. « Madame, ce sont les modistes »', 'Cendrillon : Acte I. « Madame, ce sont les modistes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180bfb9c-0cca-482f-8d41-39ea73eebe00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Du côte de la barbe »', part.name_en = 'Cendrillon : Acte I. « Du côte de la barbe »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2b72f1a5-e881-465d-8a93-06370f826e86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b72f1a5-e881-465d-8a93-06370f826e86', 2, NULL, 'Acte I. « Du côte de la barbe »', 'Cendrillon : Acte I. « Du côte de la barbe »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b72f1a5-e881-465d-8a93-06370f826e86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Enfin, je connaîtrai »', part.name_en = 'Cendrillon : Acte I. « Enfin, je connaîtrai »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2f70f5ce-22ba-4f89-bcaa-d48b211b238c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f70f5ce-22ba-4f89-bcaa-d48b211b238c', 3, NULL, 'Acte I. « Enfin, je connaîtrai »', 'Cendrillon : Acte I. « Enfin, je connaîtrai »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f70f5ce-22ba-4f89-bcaa-d48b211b238c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ah ! Que mes sœurs sont heureuses ! »', part.name_en = 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3f491aeb-fc4a-471c-9a21-4d04f385140c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f491aeb-fc4a-471c-9a21-4d04f385140c', 4, NULL, 'Acte I. « Ah ! Que mes sœurs sont heureuses ! »', 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f491aeb-fc4a-471c-9a21-4d04f385140c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Faites‐vous très belles »', part.name_en = 'Cendrillon : Acte I. « Faites‐vous très belles »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc', 5, NULL, 'Acte I. « Faites‐vous très belles »', 'Cendrillon : Acte I. « Faites‐vous très belles »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Félicitez‐moi donc »', part.name_en = 'Cendrillon : Acte I. « Félicitez‐moi donc »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d8a03b03-baab-4ea4-86f3-a9428f75c1ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8a03b03-baab-4ea4-86f3-a9428f75c1ae', 6, NULL, 'Acte I. « Félicitez‐moi donc »', 'Cendrillon : Acte I. « Félicitez‐moi donc »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a03b03-baab-4ea4-86f3-a9428f75c1ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. « On appelle, on sonne ! »', part.name_en = 'Cendrillon : Acte I. « On appelle, on sonne ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e8b8594f-59c5-4ae5-9005-1ba9e61467b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8b8594f-59c5-4ae5-9005-1ba9e61467b1', 7, NULL, 'Acte I. « On appelle, on sonne ! »', 'Cendrillon : Acte I. « On appelle, on sonne ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b8594f-59c5-4ae5-9005-1ba9e61467b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ah ! Douce enfant »', part.name_en = 'Cendrillon : Acte I. « Ah ! Douce enfant »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e95fe990-4c9a-4854-b0e3-b4a46d5d03da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e95fe990-4c9a-4854-b0e3-b4a46d5d03da', 8, NULL, 'Acte I. « Ah ! Douce enfant »', 'Cendrillon : Acte I. « Ah ! Douce enfant »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e95fe990-4c9a-4854-b0e3-b4a46d5d03da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Pour en faire un tissu »', part.name_en = 'Cendrillon : Acte I. « Pour en faire un tissu »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ef4624b2-a536-4e5a-8f2f-3cc1b94fec83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef4624b2-a536-4e5a-8f2f-3cc1b94fec83', 9, NULL, 'Acte I. « Pour en faire un tissu »', 'Cendrillon : Acte I. « Pour en faire un tissu »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef4624b2-a536-4e5a-8f2f-3cc1b94fec83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Prenez un maintien gracieux »', part.name_en = 'Cendrillon : Acte I. « Prenez un maintien gracieux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ff2fc95b-064a-41c6-92f5-f1206999ed6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff2fc95b-064a-41c6-92f5-f1206999ed6f', 10, NULL, 'Acte I. « Prenez un maintien gracieux »', 'Cendrillon : Acte I. « Prenez un maintien gracieux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6f83f18-565c-4e42-a605-a13269ec8d67'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2fc95b-064a-41c6-92f5-f1206999ed6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Cendrillon : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79', 3, NULL, 'Acte II', 'Cendrillon : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entrée du Roi et de la Cour', part.name_en = 'Cendrillon : Acte II. Entrée du Roi et de la Cour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:193e8361-44d6-4a82-8259-9762458dbc61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:193e8361-44d6-4a82-8259-9762458dbc61', 1, NULL, 'Acte II. Entrée du Roi et de la Cour', 'Cendrillon : Acte II. Entrée du Roi et de la Cour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193e8361-44d6-4a82-8259-9762458dbc61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Toi qui m’es apparue »', part.name_en = 'Cendrillon : Acte II. « Toi qui m’es apparue »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:273ef9c4-9e71-4e58-a723-28cdf8455f88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:273ef9c4-9e71-4e58-a723-28cdf8455f88', 2, NULL, 'Acte II. « Toi qui m’es apparue »', 'Cendrillon : Acte II. « Toi qui m’es apparue »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:273ef9c4-9e71-4e58-a723-28cdf8455f88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. Troisième Entrée : Les Mandores', part.name_en = 'Cendrillon : Acte II. Troisième Entrée : Les Mandores',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:376a7d95-4214-43ed-b138-83cb9588bd15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:376a7d95-4214-43ed-b138-83cb9588bd15', 3, NULL, 'Acte II. Troisième Entrée : Les Mandores', 'Cendrillon : Acte II. Troisième Entrée : Les Mandores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:376a7d95-4214-43ed-b138-83cb9588bd15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Allez, laissez‐moi seul »', part.name_en = 'Cendrillon : Acte II. « Allez, laissez‐moi seul »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:41bb3c5b-31f3-4b89-88cc-68690df96d8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41bb3c5b-31f3-4b89-88cc-68690df96d8e', 4, NULL, 'Acte II. « Allez, laissez‐moi seul »', 'Cendrillon : Acte II. « Allez, laissez‐moi seul »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41bb3c5b-31f3-4b89-88cc-68690df96d8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. Cinquième Entrée : Le Rigodon du Roy', part.name_en = 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:77183f24-dec4-4354-9722-b580f1e2c627' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77183f24-dec4-4354-9722-b580f1e2c627', 5, NULL, 'Acte II. Cinquième Entrée : Le Rigodon du Roy', 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77183f24-dec4-4354-9722-b580f1e2c627'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Que les doux pensers »', part.name_en = 'Cendrillon : Acte II. « Que les doux pensers »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7cefcfe0-0cbb-4826-bd64-c270ab574a1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7cefcfe0-0cbb-4826-bd64-c270ab574a1f', 6, NULL, 'Acte II. « Que les doux pensers »', 'Cendrillon : Acte II. « Que les doux pensers »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cefcfe0-0cbb-4826-bd64-c270ab574a1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. « O la surprenante aventure » / « O la décevante aventure »', part.name_en = 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7f72777a-4d8f-4986-9c3c-a46923ea704e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f72777a-4d8f-4986-9c3c-a46923ea704e', 7, NULL, 'Acte II. « O la surprenante aventure » / « O la décevante aventure »', 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f72777a-4d8f-4986-9c3c-a46923ea704e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. Deuxième Entrée : Les Fiancés', part.name_en = 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d1da3460-5b65-422c-999e-c02ae7550155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1da3460-5b65-422c-999e-c02ae7550155', 8, NULL, 'Acte II. Deuxième Entrée : Les Fiancés', 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1da3460-5b65-422c-999e-c02ae7550155'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. Quatrième Entrée : La Florentine', part.name_en = 'Cendrillon : Acte II. Quatrième Entrée : La Florentine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d47ee0ad-b54c-4af0-a67d-b69699905261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d47ee0ad-b54c-4af0-a67d-b69699905261', 9, NULL, 'Acte II. Quatrième Entrée : La Florentine', 'Cendrillon : Acte II. Quatrième Entrée : La Florentine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47ee0ad-b54c-4af0-a67d-b69699905261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. Première Entrée : Les Filles de Noblesse', part.name_en = 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d8b839dd-5503-48d2-8fb2-9668cb5dc6cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8b839dd-5503-48d2-8fb2-9668cb5dc6cf', 10, NULL, 'Acte II. Première Entrée : Les Filles de Noblesse', 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89bae1e9-32ff-465e-a05d-57aad1e13b79'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b839dd-5503-48d2-8fb2-9668cb5dc6cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Cendrillon : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628', 4, NULL, 'Acte III', 'Cendrillon : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. « C’est vrai ! »', part.name_en = 'Cendrillon : Acte III. « C’est vrai ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1ead01c2-285f-427e-bfd6-aef32764a804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ead01c2-285f-427e-bfd6-aef32764a804', 1, NULL, 'Acte III. « C’est vrai ! »', 'Cendrillon : Acte III. « C’est vrai ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ead01c2-285f-427e-bfd6-aef32764a804'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Seule, je partirai »', part.name_en = 'Cendrillon : Acte III. « Seule, je partirai »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2ddc3cc9-15a0-460f-b203-6e27690abe54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ddc3cc9-15a0-460f-b203-6e27690abe54', 2, NULL, 'Acte III. « Seule, je partirai »', 'Cendrillon : Acte III. « Seule, je partirai »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ddc3cc9-15a0-460f-b203-6e27690abe54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Ma pauvre enfant chérie ! »', part.name_en = 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb', 3, NULL, 'Acte III. « Ma pauvre enfant chérie ! »', 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Ah ! Fugitives chimères »', part.name_en = 'Cendrillon : Acte III. « Ah ! Fugitives chimères »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8955c2f8-06ac-40f0-9c2d-febc7e45d6aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8955c2f8-06ac-40f0-9c2d-febc7e45d6aa', 4, NULL, 'Acte III. « Ah ! Fugitives chimères »', 'Cendrillon : Acte III. « Ah ! Fugitives chimères »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8955c2f8-06ac-40f0-9c2d-febc7e45d6aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. « À deux genoux » / « Je viens à vous »', part.name_en = 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a5cccd05-88bf-4a77-b983-b87206f76bda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5cccd05-88bf-4a77-b983-b87206f76bda', 5, NULL, 'Acte III. « À deux genoux » / « Je viens à vous »', 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5cccd05-88bf-4a77-b983-b87206f76bda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Enfin, je suis ici »', part.name_en = 'Cendrillon : Acte III. « Enfin, je suis ici »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bdf678db-a3d6-4d24-9249-488f93664269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bdf678db-a3d6-4d24-9249-488f93664269', 6, NULL, 'Acte III. « Enfin, je suis ici »', 'Cendrillon : Acte III. « Enfin, je suis ici »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdf678db-a3d6-4d24-9249-488f93664269'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Lorsqu’on a plus de vingt quartiers »', part.name_en = 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:db9e0094-6c48-4395-a6ae-37c0f6ae8ad0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db9e0094-6c48-4395-a6ae-37c0f6ae8ad0', 7, NULL, 'Acte III. « Lorsqu’on a plus de vingt quartiers »', 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cd3de037-1855-48db-8c4f-fbca1bb45628'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db9e0094-6c48-4395-a6ae-37c0f6ae8ad0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Cendrillon : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe', 5, NULL, 'Acte IV', 'Cendrillon : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. Marche des Princesses', part.name_en = 'Cendrillon : Acte IV. Marche des Princesses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:00ed5cd2-01d3-45e9-ad5d-78fb3326beed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00ed5cd2-01d3-45e9-ad5d-78fb3326beed', 1, NULL, 'Acte IV. Marche des Princesses', 'Cendrillon : Acte IV. Marche des Princesses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00ed5cd2-01d3-45e9-ad5d-78fb3326beed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Posez dans son écrin »', part.name_en = 'Cendrillon : Acte IV. « Posez dans son écrin »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:37a38294-ad8d-4126-8b74-fd647dd60038' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37a38294-ad8d-4126-8b74-fd647dd60038', 2, NULL, 'Acte IV. « Posez dans son écrin »', 'Cendrillon : Acte IV. « Posez dans son écrin »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a38294-ad8d-4126-8b74-fd647dd60038'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « O pauvre enfant ! »', part.name_en = 'Cendrillon : Acte IV. « O pauvre enfant ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5160662c-fad4-4b26-a2cd-33e478e1f5f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5160662c-fad4-4b26-a2cd-33e478e1f5f4', 3, NULL, 'Acte IV. « O pauvre enfant ! »', 'Cendrillon : Acte IV. « O pauvre enfant ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5160662c-fad4-4b26-a2cd-33e478e1f5f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Ah ! Ouvre ta porte »', part.name_en = 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b72abcc6-7947-49c0-a30f-c0be5cdf43c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b72abcc6-7947-49c0-a30f-c0be5cdf43c8', 4, NULL, 'Acte IV. « Ah ! Ouvre ta porte »', 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b72abcc6-7947-49c0-a30f-c0be5cdf43c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Avancez ! Reculez ! »', part.name_en = 'Cendrillon : Acte IV. « Avancez ! Reculez ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cdc14b84-6ca5-4ab4-b99d-ad81814ca207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cdc14b84-6ca5-4ab4-b99d-ad81814ca207', 5, NULL, 'Acte IV. « Avancez ! Reculez ! »', 'Cendrillon : Acte IV. « Avancez ! Reculez ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36022320-1859-4d81-9209-a195880b87fe'
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc14b84-6ca5-4ab4-b99d-ad81814ca207'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = 'Cendrillon : Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8783 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:75512b14-e746-4a52-ace5-a2edb06a37a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75512b14-e746-4a52-ace5-a2edb06a37a9', 6, NULL, 'Valse', 'Cendrillon : Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8783 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75512b14-e746-4a52-ace5-a2edb06a37a9'
);


-- None 가곡 <Chanson pour elle>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson pour elle>', piece.title_en = 'Chanson pour elle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10077 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chansons des bois d'Amaranthe

UPDATE pieces piece
SET piece.title = 'Chansons des bois d''Amaranthe', piece.title_en = 'Chansons des bois d''Amaranthe',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10758 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O bon printemps', part.name_en = 'Chansons des bois d''Amaranthe: No. 1. O bon printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10758 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:411a8780-382f-4a8c-a0cd-792446b25b7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411a8780-382f-4a8c-a0cd-792446b25b7e', 1, NULL, 'O bon printemps', 'Chansons des bois d''Amaranthe: No. 1. O bon printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10758 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411a8780-382f-4a8c-a0cd-792446b25b7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Oiseau de bois', part.name_en = 'Chansons des bois d''Amaranthe: No. 2. Oiseau de bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10758 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9669187c-b7fe-4d98-8e3c-05ba3ba59041' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9669187c-b7fe-4d98-8e3c-05ba3ba59041', 2, NULL, 'Oiseau de bois', 'Chansons des bois d''Amaranthe: No. 2. Oiseau de bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10758 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9669187c-b7fe-4d98-8e3c-05ba3ba59041'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chères fleurs', part.name_en = 'Chansons des bois d''Amaranthe: No. 3. Chères fleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10758 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:75080d28-1814-4a03-abf2-4ac98b148284' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75080d28-1814-4a03-abf2-4ac98b148284', 3, NULL, 'Chères fleurs', 'Chansons des bois d''Amaranthe: No. 3. Chères fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10758 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75080d28-1814-4a03-abf2-4ac98b148284'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O ruisseau', part.name_en = 'Chansons des bois d''Amaranthe: No. 4. O ruisseau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10758 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:085a7c4e-afb8-4968-b6c1-9b81592bc7f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:085a7c4e-afb8-4968-b6c1-9b81592bc7f1', 4, NULL, 'O ruisseau', 'Chansons des bois d''Amaranthe: No. 4. O ruisseau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10758 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:085a7c4e-afb8-4968-b6c1-9b81592bc7f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Chantez!', part.name_en = 'Chansons des bois d''Amaranthe: No. 5. Chantez!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10758 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9ba32072-1ec5-4a0d-a0bc-ba83b4f33b4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba32072-1ec5-4a0d-a0bc-ba83b4f33b4d', 5, NULL, 'Chantez!', 'Chansons des bois d''Amaranthe: No. 5. Chantez!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10758 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba32072-1ec5-4a0d-a0bc-ba83b4f33b4d'
);


-- None 가곡 <Chansons des bois d’Amaranthe: I. Ô bon printemps>

UPDATE pieces piece
SET piece.title = '가곡 <Chansons des bois d’Amaranthe: I. Ô bon printemps>', piece.title_en = 'Chansons des bois d’Amaranthe: I. Ô bon printemps',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10595 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chansons des bois d’Amaranthe: II. Oiseau des bois>

UPDATE pieces piece
SET piece.title = '가곡 <Chansons des bois d’Amaranthe: II. Oiseau des bois>', piece.title_en = 'Chansons des bois d’Amaranthe: II. Oiseau des bois',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8433 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chansons des bois d’Amaranthe: III. Chères fleurs>

UPDATE pieces piece
SET piece.title = '가곡 <Chansons des bois d’Amaranthe: III. Chères fleurs>', piece.title_en = 'Chansons des bois d’Amaranthe: III. Chères fleurs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9200 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chansons des bois d’Amaranthe: IV. Ô ruisseau>

UPDATE pieces piece
SET piece.title = '가곡 <Chansons des bois d’Amaranthe: IV. Ô ruisseau>', piece.title_en = 'Chansons des bois d’Amaranthe: IV. Ô ruisseau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8609 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chansons des bois d’Amaranthe: V. Chantez !>

UPDATE pieces piece
SET piece.title = '가곡 <Chansons des bois d’Amaranthe: V. Chantez !>', piece.title_en = 'Chansons des bois d’Amaranthe: V. Chantez !',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10499 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant provençal

UPDATE pieces piece
SET piece.title = 'Chant provençal', piece.title_en = 'Chant provençal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10856 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Chérubin>

UPDATE pieces piece
SET piece.title = '오페라 <Chérubin>', piece.title_en = 'Chérubin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9702 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Aubade « Vive amour qui rêve »', part.name_en = 'Chérubin : Acte III. Aubade « Vive amour qui rêve »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:66807e58-323f-4a8a-a3fa-6fd7808acb7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66807e58-323f-4a8a-a3fa-6fd7808acb7e', 1, NULL, 'Acte III. Aubade « Vive amour qui rêve »', 'Chérubin : Acte III. Aubade « Vive amour qui rêve »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66807e58-323f-4a8a-a3fa-6fd7808acb7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. Entr''acte', part.name_en = 'Chérubin : Acte III. Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7fd513b2-e147-402b-b285-0ed9e7e56c7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd513b2-e147-402b-b285-0ed9e7e56c7e', 2, NULL, 'Acte III. Entr''acte', 'Chérubin : Acte III. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd513b2-e147-402b-b285-0ed9e7e56c7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Chérubin : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27', 3, NULL, 'Acte I', 'Chérubin : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Je suis gris ! » (Chérubin)', part.name_en = 'Chérubin : Acte I. « Je suis gris ! » (Chérubin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a69eb66e-2fc7-47cd-832f-b97585d423f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a69eb66e-2fc7-47cd-832f-b97585d423f2', 1, NULL, 'Acte I. « Je suis gris ! » (Chérubin)', 'Chérubin : Acte I. « Je suis gris ! » (Chérubin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a69eb66e-2fc7-47cd-832f-b97585d423f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ces vers qu’on fait pour moi » (Nina)', part.name_en = 'Chérubin : Acte I. « Ces vers qu’on fait pour moi » (Nina)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aaea6d8a-2eaf-4355-bf6b-298f8663df57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aaea6d8a-2eaf-4355-bf6b-298f8663df57', 2, NULL, 'Acte I. « Ces vers qu’on fait pour moi » (Nina)', 'Chérubin : Acte I. « Ces vers qu’on fait pour moi » (Nina)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaea6d8a-2eaf-4355-bf6b-298f8663df57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Lorsque vous n’aurez rien à faire » (Nina)', part.name_en = 'Chérubin : Acte I. « Lorsque vous n’aurez rien à faire » (Nina)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9702 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d234be69-5f87-4aeb-a880-5b765dfac253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d234be69-5f87-4aeb-a880-5b765dfac253', 3, NULL, 'Acte I. « Lorsque vous n’aurez rien à faire » (Nina)', 'Chérubin : Acte I. « Lorsque vous n’aurez rien à faire » (Nina)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8018b167-60fc-4a91-9c70-c8301ad90d27'
WHERE p.id = 9702 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d234be69-5f87-4aeb-a880-5b765dfac253'
);


-- None 발레 <Cigale. Ballet en deux actes>

UPDATE pieces piece
SET piece.title = '발레 <Cigale. Ballet en deux actes>', piece.title_en = 'Cigale. Ballet en deux actes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10672 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Cléopâtre>

UPDATE pieces piece
SET piece.title = '오페라 <Cléopâtre>', piece.title_en = 'Cléopâtre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10426 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« J’ai versé le poison » (Cléopâtre)', part.name_en = 'Cléopâtre : « J’ai versé le poison » (Cléopâtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10426 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:103d3a63-e758-4c47-a2fe-7b4576cc15bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:103d3a63-e758-4c47-a2fe-7b4576cc15bd', 1, NULL, '« J’ai versé le poison » (Cléopâtre)', 'Cléopâtre : « J’ai versé le poison » (Cléopâtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10426 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:103d3a63-e758-4c47-a2fe-7b4576cc15bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « A‐t‐il dit vrai ? Solitaire sur ma terrasse » (Marc-Antoine)', part.name_en = 'Cléopâtre : Acte I. « A‐t‐il dit vrai ? Solitaire sur ma terrasse » (Marc-Antoine)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10426 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3bb3f667-603f-4ef7-982b-e7ecf1d9a498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bb3f667-603f-4ef7-982b-e7ecf1d9a498', 2, NULL, 'Acte I. « A‐t‐il dit vrai ? Solitaire sur ma terrasse » (Marc-Antoine)', 'Cléopâtre : Acte I. « A‐t‐il dit vrai ? Solitaire sur ma terrasse » (Marc-Antoine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10426 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bb3f667-603f-4ef7-982b-e7ecf1d9a498'
);


-- None Deux berceuses

UPDATE pieces piece
SET piece.title = 'Deux berceuses', piece.title_en = 'Deux berceuses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8498 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Deux berceuses: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8498 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d33291a3-2aee-454e-b45a-0a03d0e3dfa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d33291a3-2aee-454e-b45a-0a03d0e3dfa9', 1, NULL, 'No. 1', 'Deux berceuses: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8498 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d33291a3-2aee-454e-b45a-0a03d0e3dfa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Deux berceuses: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8498 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bfcd4978-fe52-47d4-a551-af4e56e91766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfcd4978-fe52-47d4-a551-af4e56e91766', 2, NULL, 'No. 2', 'Deux berceuses: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8498 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfcd4978-fe52-47d4-a551-af4e56e91766'
);


-- None Deux impromptus

UPDATE pieces piece
SET piece.title = 'Deux impromptus', piece.title_en = 'Deux impromptus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9613 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Eau dormante. Lent et calme', part.name_en = 'Deux impromptus: I. Eau dormante. Lent et calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9613 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d0066198-7acc-4b21-ab23-11c601555d58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0066198-7acc-4b21-ab23-11c601555d58', 1, 'I', 'Eau dormante. Lent et calme', 'Deux impromptus: I. Eau dormante. Lent et calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9613 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0066198-7acc-4b21-ab23-11c601555d58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Eau courante. Vite', part.name_en = 'Deux impromptus: II. Eau courante. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9613 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1117ecb6-9851-4739-b66f-9fd6fc589290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1117ecb6-9851-4739-b66f-9fd6fc589290', 2, 'II', 'Eau courante. Vite', 'Deux impromptus: II. Eau courante. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9613 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1117ecb6-9851-4739-b66f-9fd6fc589290'
);


-- None Deux pièces pour piano

UPDATE pieces piece
SET piece.title = 'Deux pièces pour piano', piece.title_en = 'Deux pièces pour piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10618 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Papillons noirs. Allegro agitato molto', part.name_en = 'Deux pièces pour piano: I. Papillons noirs. Allegro agitato molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10618 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:277b7a33-4667-4324-ac4a-a4b4e13c1484' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277b7a33-4667-4324-ac4a-a4b4e13c1484', 1, 'I', 'Papillons noirs. Allegro agitato molto', 'Deux pièces pour piano: I. Papillons noirs. Allegro agitato molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10618 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277b7a33-4667-4324-ac4a-a4b4e13c1484'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Papillons blancs. Allegro (alerte)', part.name_en = 'Deux pièces pour piano: II. Papillons blancs. Allegro (alerte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10618 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b4448040-5a5b-444c-889c-c6ebb435b3c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4448040-5a5b-444c-889c-c6ebb435b3c7', 2, 'II', 'Papillons blancs. Allegro (alerte)', 'Deux pièces pour piano: II. Papillons blancs. Allegro (alerte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10618 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4448040-5a5b-444c-889c-c6ebb435b3c7'
);


-- None Devant la Madonne

UPDATE pieces piece
SET piece.title = 'Devant la Madonne', piece.title_en = 'Devant la Madonne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8655 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 10 Dix pièces de genre Op. 10

UPDATE pieces piece
SET piece.title = 'Dix pièces de genre Op. 10', piece.title_en = 'Dix pièces de genre, op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8332 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Dix pièces de genre, op. 10: No. 1. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3ad8fe0e-2382-4e82-92d8-b4fbb0a0dbbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad8fe0e-2382-4e82-92d8-b4fbb0a0dbbf', 1, NULL, 'Nocturne', 'Dix pièces de genre, op. 10: No. 1. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad8fe0e-2382-4e82-92d8-b4fbb0a0dbbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marche', part.name_en = 'Dix pièces de genre, op. 10: No. 2. Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:02ce80c7-4144-4344-a3e5-b9155fe53b96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02ce80c7-4144-4344-a3e5-b9155fe53b96', 2, NULL, 'Marche', 'Dix pièces de genre, op. 10: No. 2. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02ce80c7-4144-4344-a3e5-b9155fe53b96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Barcarolle', part.name_en = 'Dix pièces de genre, op. 10: No. 3. Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d9613b03-50ab-48f8-a87c-27edf239952b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9613b03-50ab-48f8-a87c-27edf239952b', 3, NULL, 'Barcarolle', 'Dix pièces de genre, op. 10: No. 3. Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9613b03-50ab-48f8-a87c-27edf239952b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rigodon', part.name_en = 'Dix pièces de genre, op. 10: No. 4. Rigodon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2a037b4a-db3f-44c3-bbed-0006d0ec47ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a037b4a-db3f-44c3-bbed-0006d0ec47ca', 4, NULL, 'Rigodon', 'Dix pièces de genre, op. 10: No. 4. Rigodon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a037b4a-db3f-44c3-bbed-0006d0ec47ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Élégie jouée par les Erinnyes', part.name_en = 'Dix pièces de genre, op. 10: No. 5. Élégie jouée par les Erinnyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:14bbbe63-2d8c-4f45-aa90-377af0781939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14bbbe63-2d8c-4f45-aa90-377af0781939', 5, NULL, 'Élégie jouée par les Erinnyes', 'Dix pièces de genre, op. 10: No. 5. Élégie jouée par les Erinnyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bbbe63-2d8c-4f45-aa90-377af0781939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Saltarello', part.name_en = 'Dix pièces de genre, op. 10: No. 6. Saltarello',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3779234f-8808-4672-8916-ee428c34faef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3779234f-8808-4672-8916-ee428c34faef', 6, NULL, 'Saltarello', 'Dix pièces de genre, op. 10: No. 6. Saltarello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3779234f-8808-4672-8916-ee428c34faef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vieille chanson', part.name_en = 'Dix pièces de genre, op. 10: No. 7. Vieille chanson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:35fb4312-62f7-41b2-b926-de22f7cfb469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35fb4312-62f7-41b2-b926-de22f7cfb469', 7, NULL, 'Vieille chanson', 'Dix pièces de genre, op. 10: No. 7. Vieille chanson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35fb4312-62f7-41b2-b926-de22f7cfb469'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Légende', part.name_en = 'Dix pièces de genre, op. 10: No. 8. Légende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f722e9bb-d827-4f69-906d-eae760e17bdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f722e9bb-d827-4f69-906d-eae760e17bdb', 8, NULL, 'Légende', 'Dix pièces de genre, op. 10: No. 8. Légende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f722e9bb-d827-4f69-906d-eae760e17bdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Fughetta', part.name_en = 'Dix pièces de genre, op. 10: No. 9. Fughetta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cbdd9c7a-c053-4da4-bfe9-3306370852ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbdd9c7a-c053-4da4-bfe9-3306370852ee', 9, NULL, 'Fughetta', 'Dix pièces de genre, op. 10: No. 9. Fughetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbdd9c7a-c053-4da4-bfe9-3306370852ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Carillon', part.name_en = 'Dix pièces de genre, op. 10: No. 10. Carillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8332 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1250d324-907d-4962-9674-58a52310e71e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1250d324-907d-4962-9674-58a52310e71e', 10, NULL, 'Carillon', 'Dix pièces de genre, op. 10: No. 10. Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8332 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1250d324-907d-4962-9674-58a52310e71e'
);


-- None 오페라 <Don César de Bazan>

UPDATE pieces piece
SET piece.title = '오페라 <Don César de Bazan>', piece.title_en = 'Don César de Bazan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8171 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Don César de Bazan : Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:19e811af-0ef7-458c-9a07-ded0657fe8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e811af-0ef7-458c-9a07-ded0657fe8dd', 1, NULL, 'Ouverture', 'Don César de Bazan : Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e811af-0ef7-458c-9a07-ded0657fe8dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Don César de Bazan : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e', 2, NULL, 'Acte I', 'Don César de Bazan : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 6. « Le voilà ! »', part.name_en = 'Don César de Bazan : Acte I, scène 6. « Le voilà ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:25197bd4-3a98-4883-aab8-e81f958d3b6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25197bd4-3a98-4883-aab8-e81f958d3b6b', 1, NULL, 'scène 6. « Le voilà ! »', 'Don César de Bazan : Acte I, scène 6. « Le voilà ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25197bd4-3a98-4883-aab8-e81f958d3b6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Dès que ton tambour sonne »', part.name_en = 'Don César de Bazan : Acte I, scène 1. « Dès que ton tambour sonne »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3609fc6d-bf80-4047-9ff2-bebe606794a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3609fc6d-bf80-4047-9ff2-bebe606794a2', 2, NULL, 'scène 1. « Dès que ton tambour sonne »', 'Don César de Bazan : Acte I, scène 1. « Dès que ton tambour sonne »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3609fc6d-bf80-4047-9ff2-bebe606794a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Partout où l’on chante »', part.name_en = 'Don César de Bazan : Acte I, scène 2. « Partout où l’on chante »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:392ad77a-c17f-40bb-8db4-0375a1aef0fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:392ad77a-c17f-40bb-8db4-0375a1aef0fb', 3, NULL, 'scène 2. « Partout où l’on chante »', 'Don César de Bazan : Acte I, scène 2. « Partout où l’on chante »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:392ad77a-c17f-40bb-8db4-0375a1aef0fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 8. « Bohème charmante »', part.name_en = 'Don César de Bazan : Acte I, scène 8. « Bohème charmante »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3e7de140-fcdf-4aa3-8737-d0d290e73665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e7de140-fcdf-4aa3-8737-d0d290e73665', 4, NULL, 'scène 8. « Bohème charmante »', 'Don César de Bazan : Acte I, scène 8. « Bohème charmante »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e7de140-fcdf-4aa3-8737-d0d290e73665'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 1. « C’est elle ! »', part.name_en = 'Don César de Bazan : Acte I, scène 1. « C’est elle ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d16b8227-bc91-4991-9dc4-e80fbde6ff8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d16b8227-bc91-4991-9dc4-e80fbde6ff8a', 5, NULL, 'scène 1. « C’est elle ! »', 'Don César de Bazan : Acte I, scène 1. « C’est elle ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c83d05f-a07e-4d3f-a8f4-aa953d7b364e'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d16b8227-bc91-4991-9dc4-e80fbde6ff8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Don César de Bazan : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650', 3, NULL, 'Acte II', 'Don César de Bazan : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 6. Berceuse « Dors, ami »', part.name_en = 'Don César de Bazan : Acte II. No. 6. Berceuse « Dors, ami »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0010e56a-f84d-465f-b1aa-6f526b398ada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0010e56a-f84d-465f-b1aa-6f526b398ada', 1, NULL, 'Acte II. No. 6. Berceuse « Dors, ami »', 'Don César de Bazan : Acte II. No. 6. Berceuse « Dors, ami »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0010e56a-f84d-465f-b1aa-6f526b398ada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Me marier ! »', part.name_en = 'Don César de Bazan : Acte II, scène 2. « Me marier ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:314d44a1-4970-4e2e-88ea-1a2a45386438' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:314d44a1-4970-4e2e-88ea-1a2a45386438', 2, NULL, 'scène 2. « Me marier ! »', 'Don César de Bazan : Acte II, scène 2. « Me marier ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:314d44a1-4970-4e2e-88ea-1a2a45386438'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 10. « Grand Dieu ! »', part.name_en = 'Don César de Bazan : Acte II, scène 10. « Grand Dieu ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4d03d2e7-6435-483e-a4f2-b35c01464f39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d03d2e7-6435-483e-a4f2-b35c01464f39', 3, NULL, 'scène 10. « Grand Dieu ! »', 'Don César de Bazan : Acte II, scène 10. « Grand Dieu ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d03d2e7-6435-483e-a4f2-b35c01464f39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 9. « Rien ne peut le défendre »', part.name_en = 'Don César de Bazan : Acte II, scène 9. « Rien ne peut le défendre »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5bbaa14b-1af0-4f91-b469-9b70e0fa2944' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5bbaa14b-1af0-4f91-b469-9b70e0fa2944', 4, NULL, 'scène 9. « Rien ne peut le défendre »', 'Don César de Bazan : Acte II, scène 9. « Rien ne peut le défendre »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bbaa14b-1af0-4f91-b469-9b70e0fa2944'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Dors, ami »', part.name_en = 'Don César de Bazan : Acte II, scène 1. « Dors, ami »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6042f1ce-639f-4697-8ce3-dfd9173637b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6042f1ce-639f-4697-8ce3-dfd9173637b9', 5, NULL, 'scène 1. « Dors, ami »', 'Don César de Bazan : Acte II, scène 1. « Dors, ami »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6042f1ce-639f-4697-8ce3-dfd9173637b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 6. « À boire, amis »', part.name_en = 'Don César de Bazan : Acte II, scène 6. « À boire, amis »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8e15842f-2071-4c02-a44c-073497933b09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e15842f-2071-4c02-a44c-073497933b09', 6, NULL, 'scène 6. « À boire, amis »', 'Don César de Bazan : Acte II, scène 6. « À boire, amis »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e15842f-2071-4c02-a44c-073497933b09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Riche, j’ai semé les richesses »', part.name_en = 'Don César de Bazan : Acte II, scène 1. « Riche, j’ai semé les richesses »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:becf497d-93e0-41ac-9839-8500686f6254' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:becf497d-93e0-41ac-9839-8500686f6254', 7, NULL, 'scène 1. « Riche, j’ai semé les richesses »', 'Don César de Bazan : Acte II, scène 1. « Riche, j’ai semé les richesses »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:becf497d-93e0-41ac-9839-8500686f6254'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entr’acte', part.name_en = 'Don César de Bazan : Acte II. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f6797e0d-1395-4aa4-9e13-af3350694c3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6797e0d-1395-4aa4-9e13-af3350694c3d', 8, NULL, 'Acte II. Entr’acte', 'Don César de Bazan : Acte II. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1bb136a-d86e-4683-905f-7d7c9bfcd650'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6797e0d-1395-4aa4-9e13-af3350694c3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Don César de Bazan : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec', 4, NULL, 'Acte III', 'Don César de Bazan : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Que de ta lèvre en fleur »', part.name_en = 'Don César de Bazan : Acte III, scène 2. « Que de ta lèvre en fleur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0c33c7bf-f8c0-4205-aef2-e769897cf22b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c33c7bf-f8c0-4205-aef2-e769897cf22b', 1, NULL, 'scène 2. « Que de ta lèvre en fleur »', 'Don César de Bazan : Acte III, scène 2. « Que de ta lèvre en fleur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c33c7bf-f8c0-4205-aef2-e769897cf22b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. « À Séville, belles señoras » (Maritana)', part.name_en = 'Don César de Bazan : Acte III. « À Séville, belles señoras » (Maritana)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:43f8d641-fa8e-492f-acc4-a5f0f6ea43ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43f8d641-fa8e-492f-acc4-a5f0f6ea43ee', 2, NULL, 'Acte III. « À Séville, belles señoras » (Maritana)', 'Don César de Bazan : Acte III. « À Séville, belles señoras » (Maritana)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f8d641-fa8e-492f-acc4-a5f0f6ea43ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Cette splendeur »', part.name_en = 'Don César de Bazan : Acte III, scène 1. « Cette splendeur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:503cb154-c3d1-45b9-9188-fae3dbcf9a89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:503cb154-c3d1-45b9-9188-fae3dbcf9a89', 3, NULL, 'scène 1. « Cette splendeur »', 'Don César de Bazan : Acte III, scène 1. « Cette splendeur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:503cb154-c3d1-45b9-9188-fae3dbcf9a89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. Entr''acte. Sevillana', part.name_en = 'Don César de Bazan : Acte III. Entr''acte. Sevillana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5d9d5132-b45a-4fa5-add3-69eede41d5fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d9d5132-b45a-4fa5-add3-69eede41d5fc', 4, NULL, 'Acte III. Entr''acte. Sevillana', 'Don César de Bazan : Acte III. Entr''acte. Sevillana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d9d5132-b45a-4fa5-add3-69eede41d5fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 3. « Qui je suis ? »', part.name_en = 'Don César de Bazan : Acte III, scène 3. « Qui je suis ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6fe3e31c-4df5-4a96-a071-8e7911ae7023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6fe3e31c-4df5-4a96-a071-8e7911ae7023', 5, NULL, 'scène 3. « Qui je suis ? »', 'Don César de Bazan : Acte III, scène 3. « Qui je suis ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe3e31c-4df5-4a96-a071-8e7911ae7023'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 5. « Je m’en souviens »', part.name_en = 'Don César de Bazan : Acte III, scène 5. « Je m’en souviens »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c238675e-8232-4790-b2c3-83fff77f4ba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c238675e-8232-4790-b2c3-83fff77f4ba1', 6, NULL, 'scène 5. « Je m’en souviens »', 'Don César de Bazan : Acte III, scène 5. « Je m’en souviens »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b7571295-197b-4a0b-a1cc-adeadaf781ec'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c238675e-8232-4790-b2c3-83fff77f4ba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Don César de Bazan : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025', 5, NULL, 'Acte IV', 'Don César de Bazan : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. Entr’acte', part.name_en = 'Don César de Bazan : Acte IV. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1631afe6-216d-4c0d-bbb1-a616dc8e47aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1631afe6-216d-4c0d-bbb1-a616dc8e47aa', 1, NULL, 'Acte IV. Entr’acte', 'Don César de Bazan : Acte IV. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1631afe6-216d-4c0d-bbb1-a616dc8e47aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Aux cœurs les plus troublés »', part.name_en = 'Don César de Bazan : Acte IV, scène 1. « Aux cœurs les plus troublés »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8724f5ca-2bed-4e82-9b53-ce5a209a674d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8724f5ca-2bed-4e82-9b53-ce5a209a674d', 2, NULL, 'scène 1. « Aux cœurs les plus troublés »', 'Don César de Bazan : Acte IV, scène 1. « Aux cœurs les plus troublés »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8724f5ca-2bed-4e82-9b53-ce5a209a674d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 3. « Je pénétrai »', part.name_en = 'Don César de Bazan : Acte IV, scène 3. « Je pénétrai »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8171 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d4776c03-c3b5-404b-a324-7264719d3085' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4776c03-c3b5-404b-a324-7264719d3085', 3, NULL, 'scène 3. « Je pénétrai »', 'Don César de Bazan : Acte IV, scène 3. « Je pénétrai »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02b99802-0c6f-4bff-bcee-ee5e0c900025'
WHERE p.id = 8171 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4776c03-c3b5-404b-a324-7264719d3085'
);


-- None 오페라 <Don Quichotte. Opéra. Poème de Henri Cain, d'après Le Lorrain>

UPDATE pieces piece
SET piece.title = '오페라 <Don Quichotte. Opéra. Poème de Henri Cain, d''après Le Lorrain>', piece.title_en = 'Don Quichotte. Opéra. Poème de Henri Cain, d''après Le Lorrain',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11067 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Don Quichotte : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c', 1, NULL, 'Acte I', 'Don Quichotte : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Alza ! Alza ! Olé ! » (Chœur, Pedro, Garcias, Rodriguez, Juan, Dulcinée)', part.name_en = 'Don Quichotte : Acte I. « Alza ! Alza ! Olé ! » (Chœur, Pedro, Garcias, Rodriguez, Juan, Dulcinée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:324d7567-8887-4928-af18-6be96fe96ec1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:324d7567-8887-4928-af18-6be96fe96ec1', 1, NULL, 'Acte I. « Alza ! Alza ! Olé ! » (Chœur, Pedro, Garcias, Rodriguez, Juan, Dulcinée)', 'Don Quichotte : Acte I. « Alza ! Alza ! Olé ! » (Chœur, Pedro, Garcias, Rodriguez, Juan, Dulcinée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:324d7567-8887-4928-af18-6be96fe96ec1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Quand la femme a vingt ans » (Dulcinée, chœur)', part.name_en = 'Don Quichotte : Acte I. « Quand la femme a vingt ans » (Dulcinée, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7b43ab1e-18ab-4ff7-b53b-1e870ba4e0b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b43ab1e-18ab-4ff7-b53b-1e870ba4e0b2', 2, NULL, 'Acte I. « Quand la femme a vingt ans » (Dulcinée, chœur)', 'Don Quichotte : Acte I. « Quand la femme a vingt ans » (Dulcinée, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b43ab1e-18ab-4ff7-b53b-1e870ba4e0b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Dulcinée est certes jolie » (Rodriguez, Juan)', part.name_en = 'Don Quichotte : Acte I. « Dulcinée est certes jolie » (Rodriguez, Juan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e8267adc-490a-4699-b5fa-53ca274cecc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8267adc-490a-4699-b5fa-53ca274cecc4', 3, NULL, 'Acte I. « Dulcinée est certes jolie » (Rodriguez, Juan)', 'Don Quichotte : Acte I. « Dulcinée est certes jolie » (Rodriguez, Juan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8267adc-490a-4699-b5fa-53ca274cecc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Allégresse ! Allégresse ! » (Chœur)', part.name_en = 'Don Quichotte : Acte I. « Allégresse ! Allégresse ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5d127d35-3cda-4c1a-8210-5e386020c40a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d127d35-3cda-4c1a-8210-5e386020c40a', 4, NULL, 'Acte I. « Allégresse ! Allégresse ! » (Chœur)', 'Don Quichotte : Acte I. « Allégresse ! Allégresse ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d127d35-3cda-4c1a-8210-5e386020c40a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. « C''est merveille de voir » (Don Quichotte, Sancho, chœur)', part.name_en = 'Don Quichotte : Acte I. « C''est merveille de voir » (Don Quichotte, Sancho, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d21e34d8-5ac5-4b53-8cce-d545f767d012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d21e34d8-5ac5-4b53-8cce-d545f767d012', 5, NULL, 'Acte I. « C''est merveille de voir » (Don Quichotte, Sancho, chœur)', 'Don Quichotte : Acte I. « C''est merveille de voir » (Don Quichotte, Sancho, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d21e34d8-5ac5-4b53-8cce-d545f767d012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. « O Dulcinée ! » … « Ah !!! Vous allez ameuter alcade » (Don Quichotte, Sancho)', part.name_en = 'Don Quichotte : Acte I. « O Dulcinée ! » … « Ah !!! Vous allez ameuter alcade » (Don Quichotte, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:040b8539-2bc3-4477-9a8a-6028988f1abd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:040b8539-2bc3-4477-9a8a-6028988f1abd', 6, NULL, 'Acte I. « O Dulcinée ! » … « Ah !!! Vous allez ameuter alcade » (Don Quichotte, Sancho)', 'Don Quichotte : Acte I. « O Dulcinée ! » … « Ah !!! Vous allez ameuter alcade » (Don Quichotte, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040b8539-2bc3-4477-9a8a-6028988f1abd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. Sérénade « Quand apparaissent les étoiles » (Don Quichotte, Juan, Dulcinée)', part.name_en = 'Don Quichotte : Acte I. Sérénade « Quand apparaissent les étoiles » (Don Quichotte, Juan, Dulcinée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9b4ad44b-f8b2-4d60-ae95-f625e79d7c85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b4ad44b-f8b2-4d60-ae95-f625e79d7c85', 7, NULL, 'Acte I. Sérénade « Quand apparaissent les étoiles » (Don Quichotte, Juan, Dulcinée)', 'Don Quichotte : Acte I. Sérénade « Quand apparaissent les étoiles » (Don Quichotte, Juan, Dulcinée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b4ad44b-f8b2-4d60-ae95-f625e79d7c85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ah ! Ah ! C''est vous qui lanciez » (Dulcinée, Don Quichotte, Juan)', part.name_en = 'Don Quichotte : Acte I. « Ah ! Ah ! C''est vous qui lanciez » (Dulcinée, Don Quichotte, Juan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dd834d65-6816-40ea-942c-a4649a521614' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd834d65-6816-40ea-942c-a4649a521614', 8, NULL, 'Acte I. « Ah ! Ah ! C''est vous qui lanciez » (Dulcinée, Don Quichotte, Juan)', 'Don Quichotte : Acte I. « Ah ! Ah ! C''est vous qui lanciez » (Dulcinée, Don Quichotte, Juan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd834d65-6816-40ea-942c-a4649a521614'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Vous êtes monseigneur » (Dulcinée, Don Quichotte, Pedro, Garcias, Rodriguez, Juan)', part.name_en = 'Don Quichotte : Acte I. « Vous êtes monseigneur » (Dulcinée, Don Quichotte, Pedro, Garcias, Rodriguez, Juan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6e0d3b5d-3354-493c-bc36-12bce9166411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e0d3b5d-3354-493c-bc36-12bce9166411', 9, NULL, 'Acte I. « Vous êtes monseigneur » (Dulcinée, Don Quichotte, Pedro, Garcias, Rodriguez, Juan)', 'Don Quichotte : Acte I. « Vous êtes monseigneur » (Dulcinée, Don Quichotte, Pedro, Garcias, Rodriguez, Juan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e0d3b5d-3354-493c-bc36-12bce9166411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Elle m''aime et va me revenir » (Don Quichotte, Dulcinée)', part.name_en = 'Don Quichotte : Acte I. « Elle m''aime et va me revenir » (Don Quichotte, Dulcinée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6bf7c53d-3c0a-4a21-95aa-bca04cd777b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6bf7c53d-3c0a-4a21-95aa-bca04cd777b2', 10, NULL, 'Acte I. « Elle m''aime et va me revenir » (Don Quichotte, Dulcinée)', 'Don Quichotte : Acte I. « Elle m''aime et va me revenir » (Don Quichotte, Dulcinée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8a460fde-7f56-4aef-b5c0-f1550c7e650c'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bf7c53d-3c0a-4a21-95aa-bca04cd777b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Don Quichotte : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09', 2, NULL, 'Acte II', 'Don Quichotte : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Chanson « C''est vers ton amour » (Don Quichotte, Sancho)', part.name_en = 'Don Quichotte : Acte II. Chanson « C''est vers ton amour » (Don Quichotte, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d95bd08a-e5c2-47d0-aaa6-6f6e2e132921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d95bd08a-e5c2-47d0-aaa6-6f6e2e132921', 1, NULL, 'Acte II. Chanson « C''est vers ton amour » (Don Quichotte, Sancho)', 'Don Quichotte : Acte II. Chanson « C''est vers ton amour » (Don Quichotte, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d95bd08a-e5c2-47d0-aaa6-6f6e2e132921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Comment peut-on penser du bien » (Sancho)', part.name_en = 'Don Quichotte : Acte II. « Comment peut-on penser du bien » (Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1d548713-c7e8-4f32-83e8-f826501c9242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d548713-c7e8-4f32-83e8-f826501c9242', 2, NULL, 'Acte II. « Comment peut-on penser du bien » (Sancho)', 'Don Quichotte : Acte II. « Comment peut-on penser du bien » (Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d548713-c7e8-4f32-83e8-f826501c9242'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Regarde ! Quoi, quoi ? » (Don Quichotte, Sancho)', part.name_en = 'Don Quichotte : Acte II. « Regarde ! Quoi, quoi ? » (Don Quichotte, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c27b1532-1e64-49c1-bcd1-6eb7c14020c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c27b1532-1e64-49c1-bcd1-6eb7c14020c3', 3, NULL, 'Acte II. « Regarde ! Quoi, quoi ? » (Don Quichotte, Sancho)', 'Don Quichotte : Acte II. « Regarde ! Quoi, quoi ? » (Don Quichotte, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abc23fd-c9d7-47cd-8f6b-afdf647bad09'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c27b1532-1e64-49c1-bcd1-6eb7c14020c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Don Quichotte : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27', 3, NULL, 'Acte III', 'Don Quichotte : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Entr''acte', part.name_en = 'Don Quichotte : Acte III. Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ca17a081-ba2f-472e-b4d3-2d1f720117e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca17a081-ba2f-472e-b4d3-2d1f720117e3', 1, NULL, 'Acte III. Entr''acte', 'Don Quichotte : Acte III. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca17a081-ba2f-472e-b4d3-2d1f720117e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. « C''est ici le chemin » (Don Quichotte, Sancho)', part.name_en = 'Don Quichotte : Acte III. « C''est ici le chemin » (Don Quichotte, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1718f1fb-4240-4f35-83c9-fa5197df0e08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1718f1fb-4240-4f35-83c9-fa5197df0e08', 2, NULL, 'Acte III. « C''est ici le chemin » (Don Quichotte, Sancho)', 'Don Quichotte : Acte III. « C''est ici le chemin » (Don Quichotte, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1718f1fb-4240-4f35-83c9-fa5197df0e08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Quand apparaissent les étoiles … Ô mes rêves divins » (Don Quichotte, Le chef des bandits, quatre bandits, chœur)', part.name_en = 'Don Quichotte : Acte III. « Quand apparaissent les étoiles … Ô mes rêves divins » (Don Quichotte, Le chef des bandits, quatre bandits, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:12b979bb-b382-4d5c-8578-fb88dd13acc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12b979bb-b382-4d5c-8578-fb88dd13acc8', 3, NULL, 'Acte III. « Quand apparaissent les étoiles … Ô mes rêves divins » (Don Quichotte, Le chef des bandits, quatre bandits, chœur)', 'Don Quichotte : Acte III. « Quand apparaissent les étoiles … Ô mes rêves divins » (Don Quichotte, Le chef des bandits, quatre bandits, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b979bb-b382-4d5c-8578-fb88dd13acc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Ah ! Voir un corps long » (Chœur des bandits)', part.name_en = 'Don Quichotte : Acte III. « Ah ! Voir un corps long » (Chœur des bandits)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9715ff59-a88d-4fd9-8f77-59485a70409b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9715ff59-a88d-4fd9-8f77-59485a70409b', 4, NULL, 'Acte III. « Ah ! Voir un corps long » (Chœur des bandits)', 'Don Quichotte : Acte III. « Ah ! Voir un corps long » (Chœur des bandits)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9715ff59-a88d-4fd9-8f77-59485a70409b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. Prière « Seigneur, reçois mon âme » (Don Quichotte, Le chef des bandits, premier bandit, chœur)', part.name_en = 'Don Quichotte : Acte III. Prière « Seigneur, reçois mon âme » (Don Quichotte, Le chef des bandits, premier bandit, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:81109ada-f324-47aa-a8d6-c74bce41d840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81109ada-f324-47aa-a8d6-c74bce41d840', 5, NULL, 'Acte III. Prière « Seigneur, reçois mon âme » (Don Quichotte, Le chef des bandits, premier bandit, chœur)', 'Don Quichotte : Acte III. Prière « Seigneur, reçois mon âme » (Don Quichotte, Le chef des bandits, premier bandit, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3fd1481a-8be8-4040-9b78-f82cfca6fc27'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81109ada-f324-47aa-a8d6-c74bce41d840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Don Quichotte : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553', 4, NULL, 'Acte IV', 'Don Quichotte : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Alors, traîtresse » (Juan, Dulcinée, Rodriguez, Garcias, Pedro)', part.name_en = 'Don Quichotte : Acte IV. « Alors, traîtresse » (Juan, Dulcinée, Rodriguez, Garcias, Pedro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:53130a01-e9ab-4cb7-8ca2-451f78a742f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53130a01-e9ab-4cb7-8ca2-451f78a742f4', 1, NULL, 'Acte IV. « Alors, traîtresse » (Juan, Dulcinée, Rodriguez, Garcias, Pedro)', 'Don Quichotte : Acte IV. « Alors, traîtresse » (Juan, Dulcinée, Rodriguez, Garcias, Pedro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53130a01-e9ab-4cb7-8ca2-451f78a742f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Lorsque le temps d’amour a fui » (Dulcinée)', part.name_en = 'Don Quichotte : Acte IV. « Lorsque le temps d’amour a fui » (Dulcinée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ce711d40-617e-4646-aa3e-4579f62d6a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce711d40-617e-4646-aa3e-4579f62d6a47', 2, NULL, 'Acte IV. « Lorsque le temps d’amour a fui » (Dulcinée)', 'Don Quichotte : Acte IV. « Lorsque le temps d’amour a fui » (Dulcinée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce711d40-617e-4646-aa3e-4579f62d6a47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Par fortune, par fortune » (Rodriguez, Dulcinée, Juan)', part.name_en = 'Don Quichotte : Acte IV. « Par fortune, par fortune » (Rodriguez, Dulcinée, Juan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a2289b8f-a767-49d7-a7d4-fc5091ea9a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2289b8f-a767-49d7-a7d4-fc5091ea9a45', 3, NULL, 'Acte IV. « Par fortune, par fortune » (Rodriguez, Dulcinée, Juan)', 'Don Quichotte : Acte IV. « Par fortune, par fortune » (Rodriguez, Dulcinée, Juan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2289b8f-a767-49d7-a7d4-fc5091ea9a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Ah ! J’ai en ce moment le désir d’autre chose » (Dulcinée, Juan, Rodriguez, Garcias, Pedro, chœur)', part.name_en = 'Don Quichotte : Acte IV. « Ah ! J’ai en ce moment le désir d’autre chose » (Dulcinée, Juan, Rodriguez, Garcias, Pedro, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e737e613-ac8f-48be-9e25-fc7d51894a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e737e613-ac8f-48be-9e25-fc7d51894a47', 4, NULL, 'Acte IV. « Ah ! J’ai en ce moment le désir d’autre chose » (Dulcinée, Juan, Rodriguez, Garcias, Pedro, chœur)', 'Don Quichotte : Acte IV. « Ah ! J’ai en ce moment le désir d’autre chose » (Dulcinée, Juan, Rodriguez, Garcias, Pedro, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e737e613-ac8f-48be-9e25-fc7d51894a47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Alza ! Ne pensons qu’au plaisir d’aimer » (Dulcinée, chœur)', part.name_en = 'Don Quichotte : Acte IV. « Alza ! Ne pensons qu’au plaisir d’aimer » (Dulcinée, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a772abb6-c6b9-4d01-8b42-7af817102050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a772abb6-c6b9-4d01-8b42-7af817102050', 5, NULL, 'Acte IV. « Alza ! Ne pensons qu’au plaisir d’aimer » (Dulcinée, chœur)', 'Don Quichotte : Acte IV. « Alza ! Ne pensons qu’au plaisir d’aimer » (Dulcinée, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a772abb6-c6b9-4d01-8b42-7af817102050'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Annonce le grand Don Quichotte » (Sancho, deux valets, Don Quichotte)', part.name_en = 'Don Quichotte : Acte IV. « Annonce le grand Don Quichotte » (Sancho, deux valets, Don Quichotte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3be404af-c10a-439b-8f14-5eba350f3bd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3be404af-c10a-439b-8f14-5eba350f3bd1', 6, NULL, 'Acte IV. « Annonce le grand Don Quichotte » (Sancho, deux valets, Don Quichotte)', 'Don Quichotte : Acte IV. « Annonce le grand Don Quichotte » (Sancho, deux valets, Don Quichotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3be404af-c10a-439b-8f14-5eba350f3bd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « L’aube bientôt blanchira l’horizon » … « Mais voilà Dulcinée » (Chœur, Don Quichotte, Dulcinée)', part.name_en = 'Don Quichotte : Acte IV. « L’aube bientôt blanchira l’horizon » … « Mais voilà Dulcinée » (Chœur, Don Quichotte, Dulcinée)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e503c5a0-6329-4d1c-ad78-e42720a000b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e503c5a0-6329-4d1c-ad78-e42720a000b2', 7, NULL, 'Acte IV. « L’aube bientôt blanchira l’horizon » … « Mais voilà Dulcinée » (Chœur, Don Quichotte, Dulcinée)', 'Don Quichotte : Acte IV. « L’aube bientôt blanchira l’horizon » … « Mais voilà Dulcinée » (Chœur, Don Quichotte, Dulcinée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e503c5a0-6329-4d1c-ad78-e42720a000b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « On ne s’explique pas » (Rodriguez, Juan, Pedro, Garcias, Sancho, Dulcinée, Don Quichotte, chœur)', part.name_en = 'Don Quichotte : Acte IV. « On ne s’explique pas » (Rodriguez, Juan, Pedro, Garcias, Sancho, Dulcinée, Don Quichotte, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dd5638e8-8745-4160-a50b-92c2b7e194f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd5638e8-8745-4160-a50b-92c2b7e194f6', 8, NULL, 'Acte IV. « On ne s’explique pas » (Rodriguez, Juan, Pedro, Garcias, Sancho, Dulcinée, Don Quichotte, chœur)', 'Don Quichotte : Acte IV. « On ne s’explique pas » (Rodriguez, Juan, Pedro, Garcias, Sancho, Dulcinée, Don Quichotte, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd5638e8-8745-4160-a50b-92c2b7e194f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Marchez dans mon chemin » (Don Quichotte)', part.name_en = 'Don Quichotte : Acte IV. « Marchez dans mon chemin » (Don Quichotte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:94d0001a-9cf2-4a0a-8259-bd6b2e61a43f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94d0001a-9cf2-4a0a-8259-bd6b2e61a43f', 9, NULL, 'Acte IV. « Marchez dans mon chemin » (Don Quichotte)', 'Don Quichotte : Acte IV. « Marchez dans mon chemin » (Don Quichotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d0001a-9cf2-4a0a-8259-bd6b2e61a43f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Me marier, moi ! » (Dulcinée, Don Quichotte, chœur)', part.name_en = 'Don Quichotte : Acte IV. « Me marier, moi ! » (Dulcinée, Don Quichotte, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d05a1851-f47f-45e7-b0c9-b623ed6eb0dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d05a1851-f47f-45e7-b0c9-b623ed6eb0dc', 10, NULL, 'Acte IV. « Me marier, moi ! » (Dulcinée, Don Quichotte, chœur)', 'Don Quichotte : Acte IV. « Me marier, moi ! » (Dulcinée, Don Quichotte, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d05a1851-f47f-45e7-b0c9-b623ed6eb0dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Oui, je souffre votre tristesse » (Dulcinée, Don Quichotte)', part.name_en = 'Don Quichotte : Acte IV. « Oui, je souffre votre tristesse » (Dulcinée, Don Quichotte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:71e3bc52-20c9-47c3-9f37-77d6c484525f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71e3bc52-20c9-47c3-9f37-77d6c484525f', 11, NULL, 'Acte IV. « Oui, je souffre votre tristesse » (Dulcinée, Don Quichotte)', 'Don Quichotte : Acte IV. « Oui, je souffre votre tristesse » (Dulcinée, Don Quichotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e3bc52-20c9-47c3-9f37-77d6c484525f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Enfin, te revoilà ! » (Chœur, Dulcinée, Rodriguez, Juan, Sancho)', part.name_en = 'Don Quichotte : Acte IV. « Enfin, te revoilà ! » (Chœur, Dulcinée, Rodriguez, Juan, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f57e1013-41ff-448f-b2d7-fd8966e71e10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f57e1013-41ff-448f-b2d7-fd8966e71e10', 12, NULL, 'Acte IV. « Enfin, te revoilà ! » (Chœur, Dulcinée, Rodriguez, Juan, Sancho)', 'Don Quichotte : Acte IV. « Enfin, te revoilà ! » (Chœur, Dulcinée, Rodriguez, Juan, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f57e1013-41ff-448f-b2d7-fd8966e71e10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Riez, allez riez du pauvre idéologue » (Sancho)', part.name_en = 'Don Quichotte : Acte IV. « Riez, allez riez du pauvre idéologue » (Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cbe9b414-7384-4156-a163-3b60704fabc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbe9b414-7384-4156-a163-3b60704fabc1', 13, NULL, 'Acte IV. « Riez, allez riez du pauvre idéologue » (Sancho)', 'Don Quichotte : Acte IV. « Riez, allez riez du pauvre idéologue » (Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098098af-bcbe-4553-abf9-dc2eb37ca553'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbe9b414-7384-4156-a163-3b60704fabc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V', part.name_en = 'Don Quichotte : Acte V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714', 5, NULL, 'Acte V', 'Don Quichotte : Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte V. Entr’acte', part.name_en = 'Don Quichotte : Acte V. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:db1bd13b-1ebb-44ee-bb74-0fde6a17c527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db1bd13b-1ebb-44ee-bb74-0fde6a17c527', 1, NULL, 'Acte V. Entr’acte', 'Don Quichotte : Acte V. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db1bd13b-1ebb-44ee-bb74-0fde6a17c527'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte V. « Ô mon maître ! » (Sancho, Don Quichotte)', part.name_en = 'Don Quichotte : Acte V. « Ô mon maître ! » (Sancho, Don Quichotte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e3eac810-e21e-45fa-b343-d56a63b5f199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3eac810-e21e-45fa-b343-d56a63b5f199', 2, NULL, 'Acte V. « Ô mon maître ! » (Sancho, Don Quichotte)', 'Don Quichotte : Acte V. « Ô mon maître ! » (Sancho, Don Quichotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3eac810-e21e-45fa-b343-d56a63b5f199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte V. « Oui ! Je fus le chef » (Don Quichotte, Sancho)', part.name_en = 'Don Quichotte : Acte V. « Oui ! Je fus le chef » (Don Quichotte, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e790780b-d624-4bd6-b823-153dd3ecac13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e790780b-d624-4bd6-b823-153dd3ecac13', 3, NULL, 'Acte V. « Oui ! Je fus le chef » (Don Quichotte, Sancho)', 'Don Quichotte : Acte V. « Oui ! Je fus le chef » (Don Quichotte, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e790780b-d624-4bd6-b823-153dd3ecac13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte V. « L’Étoile ! » (Don Quichotte, Dulcinée, Sancho)', part.name_en = 'Don Quichotte : Acte V. « L’Étoile ! » (Don Quichotte, Dulcinée, Sancho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8de5bdb9-1801-4044-98e7-7f1758111bca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8de5bdb9-1801-4044-98e7-7f1758111bca', 4, NULL, 'Acte V. « L’Étoile ! » (Don Quichotte, Dulcinée, Sancho)', 'Don Quichotte : Acte V. « L’Étoile ! » (Don Quichotte, Dulcinée, Sancho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8de5bdb9-1801-4044-98e7-7f1758111bca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V. « Écoute, mon ami, je me sens bien malade » (Don Quichotte)', part.name_en = 'Don Quichotte : Acte V. « Écoute, mon ami, je me sens bien malade » (Don Quichotte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11067 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:32a16aa1-3786-4ff7-ba87-150965bd037e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32a16aa1-3786-4ff7-ba87-150965bd037e', 5, NULL, 'Acte V. « Écoute, mon ami, je me sens bien malade » (Don Quichotte)', 'Don Quichotte : Acte V. « Écoute, mon ami, je me sens bien malade » (Don Quichotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01b4eb6c-fb74-485f-bbac-4ddc9e109714'
WHERE p.id = 11067 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32a16aa1-3786-4ff7-ba87-150965bd037e'
);


-- None 가곡 <Départ>

UPDATE pieces piece
SET piece.title = '가곡 <Départ>', piece.title_en = 'Départ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9731 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Elle s’en est allée>

UPDATE pieces piece
SET piece.title = '가곡 <Elle s’en est allée>', piece.title_en = 'Elle s’en est allée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10928 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Esclarmonde. Opéra romanesque en quatre actes>

UPDATE pieces piece
SET piece.title = '오페라 <Esclarmonde. Opéra romanesque en quatre actes>', piece.title_en = 'Esclarmonde. Opéra romanesque en quatre actes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9313 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue. « Dignitaires ! Guerriers ! »', part.name_en = 'Esclarmonde : Prologue. « Dignitaires ! Guerriers ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e3a3b6ca-f6d5-4bad-ad94-a0a160eea8f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3a3b6ca-f6d5-4bad-ad94-a0a160eea8f9', 1, NULL, 'Prologue. « Dignitaires ! Guerriers ! »', 'Esclarmonde : Prologue. « Dignitaires ! Guerriers ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3a3b6ca-f6d5-4bad-ad94-a0a160eea8f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Esclarmonde : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9', 2, NULL, 'Acte I', 'Esclarmonde : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Roland ! Roland ! Comme ce nom me trouble »', part.name_en = 'Esclarmonde : Acte I. « Roland ! Roland ! Comme ce nom me trouble »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7cff3e17-03d4-498a-a1dc-400c035c9a2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7cff3e17-03d4-498a-a1dc-400c035c9a2c', 1, NULL, 'Acte I. « Roland ! Roland ! Comme ce nom me trouble »', 'Esclarmonde : Acte I. « Roland ! Roland ! Comme ce nom me trouble »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cff3e17-03d4-498a-a1dc-400c035c9a2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Parséis » – « O ma sœur »', part.name_en = 'Esclarmonde : Acte I. « Parséis » – « O ma sœur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d42dc155-5049-4fc5-8b70-3dbebd1fc7d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d42dc155-5049-4fc5-8b70-3dbebd1fc7d7', 2, NULL, 'Acte I. « Parséis » – « O ma sœur »', 'Esclarmonde : Acte I. « Parséis » – « O ma sœur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d42dc155-5049-4fc5-8b70-3dbebd1fc7d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ah ! trop malheureuse Esclarmonde ! »', part.name_en = 'Esclarmonde : Acte I. « Ah ! trop malheureuse Esclarmonde ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:18726045-f70b-4c82-b057-f51173708298' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18726045-f70b-4c82-b057-f51173708298', 3, NULL, 'Acte I. « Ah ! trop malheureuse Esclarmonde ! »', 'Esclarmonde : Acte I. « Ah ! trop malheureuse Esclarmonde ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18726045-f70b-4c82-b057-f51173708298'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. « On vient, ma sœur ! »', part.name_en = 'Esclarmonde : Acte I. « On vient, ma sœur ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a585a74d-03a7-4090-92ae-87a89796625b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a585a74d-03a7-4090-92ae-87a89796625b', 4, NULL, 'Acte I. « On vient, ma sœur ! »', 'Esclarmonde : Acte I. « On vient, ma sœur ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a585a74d-03a7-4090-92ae-87a89796625b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. « C’en est fait ! »', part.name_en = 'Esclarmonde : Acte I. « C’en est fait ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6fe8b75c-28bd-4c67-b612-e5d5d09d3b0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6fe8b75c-28bd-4c67-b612-e5d5d09d3b0a', 5, NULL, 'Acte I. « C’en est fait ! »', 'Esclarmonde : Acte I. « C’en est fait ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe8b75c-28bd-4c67-b612-e5d5d09d3b0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Esprits de l’air ! Esprits de onde ! »', part.name_en = 'Esclarmonde : Acte I. « Esprits de l’air ! Esprits de onde ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9f180d8a-81c8-4218-807d-e79b41bc16e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f180d8a-81c8-4218-807d-e79b41bc16e4', 6, NULL, 'Acte I. « Esprits de l’air ! Esprits de onde ! »', 'Esclarmonde : Acte I. « Esprits de l’air ! Esprits de onde ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f180d8a-81c8-4218-807d-e79b41bc16e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Roland ! Roland ! Roland ! »', part.name_en = 'Esclarmonde : Acte I. « Roland ! Roland ! Roland ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b6e65926-6b7e-4988-80a2-a71a553c145b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6e65926-6b7e-4988-80a2-a71a553c145b', 7, NULL, 'Acte I. « Roland ! Roland ! Roland ! »', 'Esclarmonde : Acte I. « Roland ! Roland ! Roland ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5402c33-a5e2-4a5d-beb6-ddff13869bd9'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6e65926-6b7e-4988-80a2-a71a553c145b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Esclarmonde : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6', 3, NULL, 'Acte II', 'Esclarmonde : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Hélas ! Ma bien‐aimée ! »', part.name_en = 'Esclarmonde : Acte II, scène 2. « Hélas ! Ma bien‐aimée ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0d035f02-b7b9-4cb1-a14c-6da785d6d3dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d035f02-b7b9-4cb1-a14c-6da785d6d3dc', 1, NULL, 'scène 2. « Hélas ! Ma bien‐aimée ! »', 'Esclarmonde : Acte II, scène 2. « Hélas ! Ma bien‐aimée ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d035f02-b7b9-4cb1-a14c-6da785d6d3dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Sois bénie, ô magie »', part.name_en = 'Esclarmonde : Acte II, scène 1. « Sois bénie, ô magie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:188a248d-db83-40f2-a022-3aee2dadfa62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:188a248d-db83-40f2-a022-3aee2dadfa62', 2, NULL, 'scène 1. « Sois bénie, ô magie »', 'Esclarmonde : Acte II, scène 1. « Sois bénie, ô magie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:188a248d-db83-40f2-a022-3aee2dadfa62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 2. « O glaive, à ton aspect »', part.name_en = 'Esclarmonde : Acte II, scène 2. « O glaive, à ton aspect »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:28be06f9-3d0b-41f0-a175-79d0b98fc317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28be06f9-3d0b-41f0-a175-79d0b98fc317', 3, NULL, 'scène 2. « O glaive, à ton aspect »', 'Esclarmonde : Acte II, scène 2. « O glaive, à ton aspect »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28be06f9-3d0b-41f0-a175-79d0b98fc317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Ah ! Ah ! »', part.name_en = 'Esclarmonde : Acte II, scène 1. « Ah ! Ah ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:31e508ec-789e-4bcb-9e72-c1fa019d8bf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31e508ec-789e-4bcb-9e72-c1fa019d8bf4', 4, NULL, 'scène 1. « Ah ! Ah ! »', 'Esclarmonde : Acte II, scène 1. « Ah ! Ah ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e508ec-789e-4bcb-9e72-c1fa019d8bf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Voici le divin moment »', part.name_en = 'Esclarmonde : Acte II, scène 1. « Voici le divin moment »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:59cacb5f-64f6-4e24-bf1d-2b673b036a1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59cacb5f-64f6-4e24-bf1d-2b673b036a1d', 5, NULL, 'scène 1. « Voici le divin moment »', 'Esclarmonde : Acte II, scène 1. « Voici le divin moment »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cacb5f-64f6-4e24-bf1d-2b673b036a1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Écoute encor ! »', part.name_en = 'Esclarmonde : Acte II, scène 2. « Écoute encor ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:837eb2b3-f05d-4732-a59e-3973821d24d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:837eb2b3-f05d-4732-a59e-3973821d24d3', 6, NULL, 'scène 2. « Écoute encor ! »', 'Esclarmonde : Acte II, scène 2. « Écoute encor ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837eb2b3-f05d-4732-a59e-3973821d24d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Où suis‐je ? »', part.name_en = 'Esclarmonde : Acte II, scène 1. « Où suis‐je ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:de90d80d-01e0-4528-a491-5bda8767e541' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de90d80d-01e0-4528-a491-5bda8767e541', 7, NULL, 'scène 1. « Où suis‐je ? »', 'Esclarmonde : Acte II, scène 1. « Où suis‐je ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37629b28-c6a4-45ec-9089-ddb74dfe9fb6'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de90d80d-01e0-4528-a491-5bda8767e541'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Esclarmonde : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5', 4, NULL, 'Acte III', 'Esclarmonde : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Gloire ! Chantons notre victoire ! Gloire à Roland ! »', part.name_en = 'Esclarmonde : Acte III, scène 2. « Gloire ! Chantons notre victoire ! Gloire à Roland ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1bbbae6f-9d3b-47b8-88e0-5ad3ed29fbf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bbbae6f-9d3b-47b8-88e0-5ad3ed29fbf0', 1, NULL, 'scène 2. « Gloire ! Chantons notre victoire ! Gloire à Roland ! »', 'Esclarmonde : Acte III, scène 2. « Gloire ! Chantons notre victoire ! Gloire à Roland ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bbbae6f-9d3b-47b8-88e0-5ad3ed29fbf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Non ! Tu ne seras pas à mes transports ravie ! »', part.name_en = 'Esclarmonde : Acte III, scène 2. « Non ! Tu ne seras pas à mes transports ravie ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:23a13f53-0cd4-41f4-aced-30b4486872f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23a13f53-0cd4-41f4-aced-30b4486872f2', 2, NULL, 'scène 2. « Non ! Tu ne seras pas à mes transports ravie ! »', 'Esclarmonde : Acte III, scène 2. « Non ! Tu ne seras pas à mes transports ravie ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23a13f53-0cd4-41f4-aced-30b4486872f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Dieu de miséricorde »', part.name_en = 'Esclarmonde : Acte III, scène 1. « Dieu de miséricorde »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:291c50f7-6ca9-46a9-840b-217a81825289' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:291c50f7-6ca9-46a9-840b-217a81825289', 3, NULL, 'scène 1. « Dieu de miséricorde »', 'Esclarmonde : Acte III, scène 1. « Dieu de miséricorde »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:291c50f7-6ca9-46a9-840b-217a81825289'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 2. « La nuit bientôt sera venue »', part.name_en = 'Esclarmonde : Acte III, scène 2. « La nuit bientôt sera venue »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2e5c1942-f917-4c40-a7d2-890183801045' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e5c1942-f917-4c40-a7d2-890183801045', 4, NULL, 'scène 2. « La nuit bientôt sera venue »', 'Esclarmonde : Acte III, scène 2. « La nuit bientôt sera venue »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e5c1942-f917-4c40-a7d2-890183801045'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Kyrie eleison »', part.name_en = 'Esclarmonde : Acte III, scène 1. « Kyrie eleison »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4bbc523f-f069-4542-9265-7bb54bd13004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bbc523f-f069-4542-9265-7bb54bd13004', 5, NULL, 'scène 1. « Kyrie eleison »', 'Esclarmonde : Acte III, scène 1. « Kyrie eleison »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbc523f-f069-4542-9265-7bb54bd13004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Noble héros ! »', part.name_en = 'Esclarmonde : Acte III, scène 1. « Noble héros ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:59dd8353-4250-4947-8755-737d7fbc227e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59dd8353-4250-4947-8755-737d7fbc227e', 6, NULL, 'scène 1. « Noble héros ! »', 'Esclarmonde : Acte III, scène 1. « Noble héros ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59dd8353-4250-4947-8755-737d7fbc227e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Ah ! Roland ! »', part.name_en = 'Esclarmonde : Acte III, scène 2. « Ah ! Roland ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:80a6963d-90c8-48d9-a202-9cb64e95c430' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80a6963d-90c8-48d9-a202-9cb64e95c430', 7, NULL, 'scène 2. « Ah ! Roland ! »', 'Esclarmonde : Acte III, scène 2. « Ah ! Roland ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a6963d-90c8-48d9-a202-9cb64e95c430'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Je ne m’appartiens plus »', part.name_en = 'Esclarmonde : Acte III, scène 2. « Je ne m’appartiens plus »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:85f59e85-a006-4890-b412-cca51a661ada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85f59e85-a006-4890-b412-cca51a661ada', 8, NULL, 'scène 2. « Je ne m’appartiens plus »', 'Esclarmonde : Acte III, scène 2. « Je ne m’appartiens plus »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f59e85-a006-4890-b412-cca51a661ada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Gloire ! Chantons notre victoire ! À toi, Roland »', part.name_en = 'Esclarmonde : Acte III, scène 1. « Gloire ! Chantons notre victoire ! À toi, Roland »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8e26c81c-5214-42f2-9c05-13d85060bd5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e26c81c-5214-42f2-9c05-13d85060bd5d', 9, NULL, 'scène 1. « Gloire ! Chantons notre victoire ! À toi, Roland »', 'Esclarmonde : Acte III, scène 1. « Gloire ! Chantons notre victoire ! À toi, Roland »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e26c81c-5214-42f2-9c05-13d85060bd5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Mon fils, je te bénis ! »', part.name_en = 'Esclarmonde : Acte III, scène 2. « Mon fils, je te bénis ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:96573849-e1c7-4051-b31f-4aa214c78afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96573849-e1c7-4051-b31f-4aa214c78afa', 10, NULL, 'scène 2. « Mon fils, je te bénis ! »', 'Esclarmonde : Acte III, scène 2. « Mon fils, je te bénis ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96573849-e1c7-4051-b31f-4aa214c78afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'scène 2. « À genoux ! »', part.name_en = 'Esclarmonde : Acte III, scène 2. « À genoux ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b66bcea6-9a90-4a7c-8e07-6ac51bd5a8fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b66bcea6-9a90-4a7c-8e07-6ac51bd5a8fc', 11, NULL, 'scène 2. « À genoux ! »', 'Esclarmonde : Acte III, scène 2. « À genoux ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66bcea6-9a90-4a7c-8e07-6ac51bd5a8fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Regarde‐les, ces yeux plus purs » (Esclarmonde)', part.name_en = 'Esclarmonde : Acte III, scène 2. « Regarde‐les, ces yeux plus purs » (Esclarmonde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d75a43e9-9b76-45b3-816c-c69edbc4c17a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d75a43e9-9b76-45b3-816c-c69edbc4c17a', 12, NULL, 'scène 2. « Regarde‐les, ces yeux plus purs » (Esclarmonde)', 'Esclarmonde : Acte III, scène 2. « Regarde‐les, ces yeux plus purs » (Esclarmonde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75a43e9-9b76-45b3-816c-c69edbc4c17a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'scène 1. « O Blois ! Misérable cité ! »', part.name_en = 'Esclarmonde : Acte III, scène 1. « O Blois ! Misérable cité ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e4b1e99a-9743-46ea-ad8a-651c86b0e03c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4b1e99a-9743-46ea-ad8a-651c86b0e03c', 13, NULL, 'scène 1. « O Blois ! Misérable cité ! »', 'Esclarmonde : Acte III, scène 1. « O Blois ! Misérable cité ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea7dc15-191a-4191-8e24-646bc890d1f5'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b1e99a-9743-46ea-ad8a-651c86b0e03c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Esclarmonde : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47', 5, NULL, 'Acte IV', 'Esclarmonde : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Donc, pour sauver la vie »', part.name_en = 'Esclarmonde : Acte IV. « Donc, pour sauver la vie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0d94d25b-7394-49ce-aece-bffdc17e4a2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d94d25b-7394-49ce-aece-bffdc17e4a2a', 1, NULL, 'Acte IV. « Donc, pour sauver la vie »', 'Esclarmonde : Acte IV. « Donc, pour sauver la vie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d94d25b-7394-49ce-aece-bffdc17e4a2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Où suis‐je maintenant ? »', part.name_en = 'Esclarmonde : Acte IV. « Où suis‐je maintenant ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2a65df4c-2aec-46f6-815d-34d4c9e4c67f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a65df4c-2aec-46f6-815d-34d4c9e4c67f', 2, NULL, 'Acte IV. « Où suis‐je maintenant ? »', 'Esclarmonde : Acte IV. « Où suis‐je maintenant ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a65df4c-2aec-46f6-815d-34d4c9e4c67f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Entendez tous »', part.name_en = 'Esclarmonde : Acte IV. « Entendez tous »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3f0942b7-af24-435e-aff4-9f38f43924f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f0942b7-af24-435e-aff4-9f38f43924f8', 3, NULL, 'Acte IV. « Entendez tous »', 'Esclarmonde : Acte IV. « Entendez tous »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0942b7-af24-435e-aff4-9f38f43924f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Oui, le délai marqué s’avance »', part.name_en = 'Esclarmonde : Acte IV. « Oui, le délai marqué s’avance »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4f1f2991-d410-41a0-a65c-10c38688990d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f1f2991-d410-41a0-a65c-10c38688990d', 4, NULL, 'Acte IV. « Oui, le délai marqué s’avance »', 'Esclarmonde : Acte IV. « Oui, le délai marqué s’avance »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f1f2991-d410-41a0-a65c-10c38688990d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Il vient ! Ah ! quel supplice ! »', part.name_en = 'Esclarmonde : Acte IV. « Il vient ! Ah ! quel supplice ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:63ca20f8-2a50-4b3e-a3e9-6fc8378202d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63ca20f8-2a50-4b3e-a3e9-6fc8378202d7', 5, NULL, 'Acte IV. « Il vient ! Ah ! quel supplice ! »', 'Esclarmonde : Acte IV. « Il vient ! Ah ! quel supplice ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63ca20f8-2a50-4b3e-a3e9-6fc8378202d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « D’une longue torpeur »', part.name_en = 'Esclarmonde : Acte IV. « D’une longue torpeur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d2f63582-d61f-4d7e-942b-0c9e196fc575' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2f63582-d61f-4d7e-942b-0c9e196fc575', 6, NULL, 'Acte IV. « D’une longue torpeur »', 'Esclarmonde : Acte IV. « D’une longue torpeur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f63582-d61f-4d7e-942b-0c9e196fc575'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Les temps vont s’accomplir »', part.name_en = 'Esclarmonde : Acte IV. « Les temps vont s’accomplir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d3400ff7-b3ea-495f-8745-378049fe1b5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3400ff7-b3ea-495f-8745-378049fe1b5c', 7, NULL, 'Acte IV. « Les temps vont s’accomplir »', 'Esclarmonde : Acte IV. « Les temps vont s’accomplir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3400ff7-b3ea-495f-8745-378049fe1b5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Ne plus te voir ! »', part.name_en = 'Esclarmonde : Acte IV. « Ne plus te voir ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d512cee6-54e7-4543-a2a5-188ad2ca31e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d512cee6-54e7-4543-a2a5-188ad2ca31e2', 8, NULL, 'Acte IV. « Ne plus te voir ! »', 'Esclarmonde : Acte IV. « Ne plus te voir ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d512cee6-54e7-4543-a2a5-188ad2ca31e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Elle a voulu choisir »', part.name_en = 'Esclarmonde : Acte IV. « Elle a voulu choisir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f46469f6-b52c-49a6-b549-c9a7d2d5c3ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f46469f6-b52c-49a6-b549-c9a7d2d5c3ba', 9, NULL, 'Acte IV. « Elle a voulu choisir »', 'Esclarmonde : Acte IV. « Elle a voulu choisir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ea3c989-b3ec-4bcd-8063-4f54cc5fcf47'
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f46469f6-b52c-49a6-b549-c9a7d2d5c3ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Épilogue. "Dignitaires! Guerriers!"', part.name_en = 'Esclarmonde : Épilogue. "Dignitaires! Guerriers!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9313 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9afcf850-fc27-4c7c-8d0e-fb90183c76ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9afcf850-fc27-4c7c-8d0e-fb90183c76ff', 6, NULL, 'Épilogue. "Dignitaires! Guerriers!"', 'Esclarmonde : Épilogue. "Dignitaires! Guerriers!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9313 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9afcf850-fc27-4c7c-8d0e-fb90183c76ff'
);


-- None 발레 <Espada>

UPDATE pieces piece
SET piece.title = '발레 <Espada>', piece.title_en = 'Espada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8170 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Expressions lyriques>

UPDATE pieces piece
SET piece.title = '연가곡집 <Expressions lyriques>', piece.title_en = 'Expressions lyriques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10267 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dialogue', part.name_en = 'Expressions lyriques: No. 1. Dialogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10267 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9fb7cb10-eb8c-4776-825e-69c850aa3811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fb7cb10-eb8c-4776-825e-69c850aa3811', 1, NULL, 'Dialogue', 'Expressions lyriques: No. 1. Dialogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10267 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fb7cb10-eb8c-4776-825e-69c850aa3811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les Nuages', part.name_en = 'Expressions lyriques: No. 2. Les Nuages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10267 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:078a4c73-0b51-4ccf-a0b8-3ed8156b6ecc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:078a4c73-0b51-4ccf-a0b8-3ed8156b6ecc', 2, NULL, 'Les Nuages', 'Expressions lyriques: No. 2. Les Nuages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10267 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:078a4c73-0b51-4ccf-a0b8-3ed8156b6ecc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Battements d’ailes', part.name_en = 'Expressions lyriques: No. 4. Battements d’ailes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10267 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2cef6dca-31e6-40a6-9754-71f2e6d5ad7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cef6dca-31e6-40a6-9754-71f2e6d5ad7a', 3, NULL, 'Battements d’ailes', 'Expressions lyriques: No. 4. Battements d’ailes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10267 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cef6dca-31e6-40a6-9754-71f2e6d5ad7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Expressions lyriques: No. 7. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10267 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:84a80bf7-649a-402b-a0a8-3139686e4ca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a80bf7-649a-402b-a0a8-3139686e4ca8', 4, NULL, 'Nocturne', 'Expressions lyriques: No. 7. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10267 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a80bf7-649a-402b-a0a8-3139686e4ca8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mélancolie', part.name_en = 'Expressions lyriques: No. 8. Mélancolie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10267 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bf113001-fc1a-49b9-bb7a-2756148526ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf113001-fc1a-49b9-bb7a-2756148526ea', 5, NULL, 'Mélancolie', 'Expressions lyriques: No. 8. Mélancolie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10267 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf113001-fc1a-49b9-bb7a-2756148526ea'
);


-- None Grande fantaisie de concert sur "Le pardon de Ploërmel"

UPDATE pieces piece
SET piece.title = 'Grande fantaisie de concert sur "Le pardon de Ploërmel"', piece.title_en = 'Grande fantaisie de concert sur "Le pardon de Ploërmel"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7766 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Grisélidis>

UPDATE pieces piece
SET piece.title = '오페라 <Grisélidis>', piece.title_en = 'Grisélidis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10370 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Mélodrame « Eh bien ! C’est du joli ! »', part.name_en = 'Grisélidis : Acte III. Mélodrame « Eh bien ! C’est du joli ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:040d3fe6-121a-4552-8d6e-2dd64154e249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:040d3fe6-121a-4552-8d6e-2dd64154e249', 1, NULL, 'Acte III. Mélodrame « Eh bien ! C’est du joli ! »', 'Grisélidis : Acte III. Mélodrame « Eh bien ! C’est du joli ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040d3fe6-121a-4552-8d6e-2dd64154e249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prologue. Arioso « Toi qui portes la paix du ciel »', part.name_en = 'Grisélidis : Prologue. Arioso « Toi qui portes la paix du ciel »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:098d28ec-4d24-4314-bbaa-760afebb0bf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:098d28ec-4d24-4314-bbaa-760afebb0bf5', 2, NULL, 'Prologue. Arioso « Toi qui portes la paix du ciel »', 'Grisélidis : Prologue. Arioso « Toi qui portes la paix du ciel »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:098d28ec-4d24-4314-bbaa-760afebb0bf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. Duo « Grisélidis ! »', part.name_en = 'Grisélidis : Acte I. Duo « Grisélidis ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1522d7c7-5029-456b-9798-c365b5a2f131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1522d7c7-5029-456b-9798-c365b5a2f131', 3, NULL, 'Acte I. Duo « Grisélidis ! »', 'Grisélidis : Acte I. Duo « Grisélidis ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1522d7c7-5029-456b-9798-c365b5a2f131'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. Mélodrame « Bertrade, reprenons »', part.name_en = 'Grisélidis : Acte I. Mélodrame « Bertrade, reprenons »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:17535ea6-4b87-41ca-97e1-550404121f0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17535ea6-4b87-41ca-97e1-550404121f0d', 4, NULL, 'Acte I. Mélodrame « Bertrade, reprenons »', 'Grisélidis : Acte I. Mélodrame « Bertrade, reprenons »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17535ea6-4b87-41ca-97e1-550404121f0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. Air « Grisélidis ! Grisélidis ! »', part.name_en = 'Grisélidis : Acte I. Air « Grisélidis ! Grisélidis ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:18d5d1ba-4f11-4278-9934-86f5e0f58394' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18d5d1ba-4f11-4278-9934-86f5e0f58394', 5, NULL, 'Acte I. Air « Grisélidis ! Grisélidis ! »', 'Grisélidis : Acte I. Air « Grisélidis ! Grisélidis ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d5d1ba-4f11-4278-9934-86f5e0f58394'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo – suite « Loin qu’elle te pardonne »', part.name_en = 'Grisélidis : Acte III. Duo – suite « Loin qu’elle te pardonne »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1f65143b-80ad-4c58-abea-c803266157e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f65143b-80ad-4c58-abea-c803266157e9', 6, NULL, 'Acte III. Duo – suite « Loin qu’elle te pardonne »', 'Grisélidis : Acte III. Duo – suite « Loin qu’elle te pardonne »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f65143b-80ad-4c58-abea-c803266157e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prologue. Prélude et Arioso « Ouvrez‐vous sur mon front »', part.name_en = 'Grisélidis : Prologue. Prélude et Arioso « Ouvrez‐vous sur mon front »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2372ccb1-f1aa-4f81-a0f2-1350cf953d38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2372ccb1-f1aa-4f81-a0f2-1350cf953d38', 7, NULL, 'Prologue. Prélude et Arioso « Ouvrez‐vous sur mon front »', 'Grisélidis : Prologue. Prélude et Arioso « Ouvrez‐vous sur mon front »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2372ccb1-f1aa-4f81-a0f2-1350cf953d38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. Trio – fin « La volonté du Ciel étant la vôtre »', part.name_en = 'Grisélidis : Acte II. Trio – fin « La volonté du Ciel étant la vôtre »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:296984b0-6e8e-47c9-8637-2a545c07f2fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296984b0-6e8e-47c9-8637-2a545c07f2fa', 8, NULL, 'Acte II. Trio – fin « La volonté du Ciel étant la vôtre »', 'Grisélidis : Acte II. Trio – fin « La volonté du Ciel étant la vôtre »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296984b0-6e8e-47c9-8637-2a545c07f2fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte III. Arioso « Dieu ! C’est elle ! Elle revient ! »', part.name_en = 'Grisélidis : Acte III. Arioso « Dieu ! C’est elle ! Elle revient ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2d6f71b1-c674-4d8b-a9e6-9d08ef231595' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d6f71b1-c674-4d8b-a9e6-9d08ef231595', 9, NULL, 'Acte III. Arioso « Dieu ! C’est elle ! Elle revient ! »', 'Grisélidis : Acte III. Arioso « Dieu ! C’est elle ! Elle revient ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d6f71b1-c674-4d8b-a9e6-9d08ef231595'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. Chœur « Je vous salue, Marie, pleine de grâce »', part.name_en = 'Grisélidis : Acte II. Chœur « Je vous salue, Marie, pleine de grâce »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:34ec03d3-139d-4bae-8f2f-59fab12d8636' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ec03d3-139d-4bae-8f2f-59fab12d8636', 10, NULL, 'Acte II. Chœur « Je vous salue, Marie, pleine de grâce »', 'Grisélidis : Acte II. Chœur « Je vous salue, Marie, pleine de grâce »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ec03d3-139d-4bae-8f2f-59fab12d8636'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte II. Scène et reprise du Duo « Elle a le diable au corps ! »', part.name_en = 'Grisélidis : Acte II. Scène et reprise du Duo « Elle a le diable au corps ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:380aabac-c404-4e0e-825a-7a05e38de2cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:380aabac-c404-4e0e-825a-7a05e38de2cc', 11, NULL, 'Acte II. Scène et reprise du Duo « Elle a le diable au corps ! »', 'Grisélidis : Acte II. Scène et reprise du Duo « Elle a le diable au corps ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:380aabac-c404-4e0e-825a-7a05e38de2cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. Scène « Va, la marquise ici doit venir »', part.name_en = 'Grisélidis : Acte I. Scène « Va, la marquise ici doit venir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3aa99396-c4fb-44be-beae-a4a7b65b2ea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aa99396-c4fb-44be-beae-a4a7b65b2ea7', 12, NULL, 'Acte I. Scène « Va, la marquise ici doit venir »', 'Grisélidis : Acte I. Scène « Va, la marquise ici doit venir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa99396-c4fb-44be-beae-a4a7b65b2ea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte I. Duo – fin « La douceur des baisers »', part.name_en = 'Grisélidis : Acte I. Duo – fin « La douceur des baisers »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3ce456cc-13c4-4ac1-af46-c66e901a1974' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ce456cc-13c4-4ac1-af46-c66e901a1974', 13, NULL, 'Acte I. Duo – fin « La douceur des baisers »', 'Grisélidis : Acte I. Duo – fin « La douceur des baisers »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce456cc-13c4-4ac1-af46-c66e901a1974'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte I. Scène « Le Marquis ! »', part.name_en = 'Grisélidis : Acte I. Scène « Le Marquis ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3e92e611-1162-4d3e-a945-720b6c76b1f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e92e611-1162-4d3e-a945-720b6c76b1f2', 14, NULL, 'Acte I. Scène « Le Marquis ! »', 'Grisélidis : Acte I. Scène « Le Marquis ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e92e611-1162-4d3e-a945-720b6c76b1f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Acte I. Scène « Monseigneur, me voilà! »', part.name_en = 'Grisélidis : Acte I. Scène « Monseigneur, me voilà! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:402d71ba-2805-450b-8a1f-749634eb526c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:402d71ba-2805-450b-8a1f-749634eb526c', 15, NULL, 'Acte I. Scène « Monseigneur, me voilà! »', 'Grisélidis : Acte I. Scène « Monseigneur, me voilà! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:402d71ba-2805-450b-8a1f-749634eb526c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo – suite « Des armes ! Des armes ! »', part.name_en = 'Grisélidis : Acte III. Duo – suite « Des armes ! Des armes ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:413c8f24-63f2-40fe-91f1-df3f39656378' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:413c8f24-63f2-40fe-91f1-df3f39656378', 16, NULL, 'Acte III. Duo – suite « Des armes ! Des armes ! »', 'Grisélidis : Acte III. Duo – suite « Des armes ! Des armes ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:413c8f24-63f2-40fe-91f1-df3f39656378'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo « Madame à vos ordres »', part.name_en = 'Grisélidis : Acte III. Duo « Madame à vos ordres »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:456c1838-0b39-45b6-bc3d-1f7c410ceea5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:456c1838-0b39-45b6-bc3d-1f7c410ceea5', 17, NULL, 'Acte III. Duo « Madame à vos ordres »', 'Grisélidis : Acte III. Duo « Madame à vos ordres »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:456c1838-0b39-45b6-bc3d-1f7c410ceea5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Acte II. Scène « Pardon ! Les chats sont là »', part.name_en = 'Grisélidis : Acte II. Scène « Pardon ! Les chats sont là »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:45cb0ead-5248-4eac-b8bb-9f7b7bf66ae1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45cb0ead-5248-4eac-b8bb-9f7b7bf66ae1', 18, NULL, 'Acte II. Scène « Pardon ! Les chats sont là »', 'Grisélidis : Acte II. Scène « Pardon ! Les chats sont là »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cb0ead-5248-4eac-b8bb-9f7b7bf66ae1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Prologue. Scène « Ah ! Voyez… le marquis »', part.name_en = 'Grisélidis : Prologue. Scène « Ah ! Voyez… le marquis »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:47705b7a-7ba9-4cc4-9108-965b9772c0eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47705b7a-7ba9-4cc4-9108-965b9772c0eb', 19, NULL, 'Prologue. Scène « Ah ! Voyez… le marquis »', 'Grisélidis : Prologue. Scène « Ah ! Voyez… le marquis »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47705b7a-7ba9-4cc4-9108-965b9772c0eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Acte III. Prière « À l’heure où le Malin »', part.name_en = 'Grisélidis : Acte III. Prière « À l’heure où le Malin »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:49c963fc-5279-4ad3-bbfb-081f4a2335ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c963fc-5279-4ad3-bbfb-081f4a2335ae', 20, NULL, 'Acte III. Prière « À l’heure où le Malin »', 'Grisélidis : Acte III. Prière « À l’heure où le Malin »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c963fc-5279-4ad3-bbfb-081f4a2335ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Acte I. Air et Scène « Que dis‐tu ? Traiter en prisonnière »', part.name_en = 'Grisélidis : Acte I. Air et Scène « Que dis‐tu ? Traiter en prisonnière »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4e18d22c-28b9-4d73-bd03-d35d07649810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e18d22c-28b9-4d73-bd03-d35d07649810', 21, NULL, 'Acte I. Air et Scène « Que dis‐tu ? Traiter en prisonnière »', 'Grisélidis : Acte I. Air et Scène « Que dis‐tu ? Traiter en prisonnière »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e18d22c-28b9-4d73-bd03-d35d07649810'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Acte II. Air « Jusqu’ici, sans dangers »', part.name_en = 'Grisélidis : Acte II. Air « Jusqu’ici, sans dangers »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5005f13d-f28c-4ed4-8e84-7106a8eff8e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5005f13d-f28c-4ed4-8e84-7106a8eff8e7', 22, NULL, 'Acte II. Air « Jusqu’ici, sans dangers »', 'Grisélidis : Acte II. Air « Jusqu’ici, sans dangers »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5005f13d-f28c-4ed4-8e84-7106a8eff8e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Acte II. Incantation « Des bois obscurs »', part.name_en = 'Grisélidis : Acte II. Incantation « Des bois obscurs »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:511dc6f4-8e80-474b-9e51-ad2e50c89520' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:511dc6f4-8e80-474b-9e51-ad2e50c89520', 23, NULL, 'Acte II. Incantation « Des bois obscurs »', 'Grisélidis : Acte II. Incantation « Des bois obscurs »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:511dc6f4-8e80-474b-9e51-ad2e50c89520'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo « C’est vrai, nous n’avons pas l’honneur »', part.name_en = 'Grisélidis : Acte III. Duo « C’est vrai, nous n’avons pas l’honneur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:56aa8d83-2eca-441c-a4e1-44622554f4ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56aa8d83-2eca-441c-a4e1-44622554f4ea', 24, NULL, 'Acte III. Duo « C’est vrai, nous n’avons pas l’honneur »', 'Grisélidis : Acte III. Duo « C’est vrai, nous n’avons pas l’honneur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56aa8d83-2eca-441c-a4e1-44622554f4ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Acte II. Duo « Elle !… Tout mon être a frémi »', part.name_en = 'Grisélidis : Acte II. Duo « Elle !… Tout mon être a frémi »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:58f52047-94b9-408e-b754-2f87a7f5b3f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f52047-94b9-408e-b754-2f87a7f5b3f2', 25, NULL, 'Acte II. Duo « Elle !… Tout mon être a frémi »', 'Grisélidis : Acte II. Duo « Elle !… Tout mon être a frémi »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f52047-94b9-408e-b754-2f87a7f5b3f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Acte I. Prélude', part.name_en = 'Grisélidis : Acte I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5cb16aba-daf8-4ee7-b9d9-5003c99f9ed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb16aba-daf8-4ee7-b9d9-5003c99f9ed0', 26, NULL, 'Acte I. Prélude', 'Grisélidis : Acte I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb16aba-daf8-4ee7-b9d9-5003c99f9ed0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Acte II. Duo – suite « Grisélidis, écoute‐moi ! »', part.name_en = 'Grisélidis : Acte II. Duo – suite « Grisélidis, écoute‐moi ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5ce10ead-2f0c-4e39-8ecb-9836620553b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce10ead-2f0c-4e39-8ecb-9836620553b4', 27, NULL, 'Acte II. Duo – suite « Grisélidis, écoute‐moi ! »', 'Grisélidis : Acte II. Duo – suite « Grisélidis, écoute‐moi ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce10ead-2f0c-4e39-8ecb-9836620553b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo « Avant de vous parler »', part.name_en = 'Grisélidis : Acte III. Duo « Avant de vous parler »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5d45d0c8-8194-4aee-861f-5141c6af4e0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d45d0c8-8194-4aee-861f-5141c6af4e0a', 28, NULL, 'Acte III. Duo « Avant de vous parler »', 'Grisélidis : Acte III. Duo « Avant de vous parler »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d45d0c8-8194-4aee-861f-5141c6af4e0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Acte II. Trio « Madame, un étranger »', part.name_en = 'Grisélidis : Acte II. Trio « Madame, un étranger »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5ddd647b-6e5e-494b-9716-55344901c855' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ddd647b-6e5e-494b-9716-55344901c855', 29, NULL, 'Acte II. Trio « Madame, un étranger »', 'Grisélidis : Acte II. Trio « Madame, un étranger »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ddd647b-6e5e-494b-9716-55344901c855'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Prologue. Scène « Prieur, de ces côtés on l’aura vu peut‐être »', part.name_en = 'Grisélidis : Prologue. Scène « Prieur, de ces côtés on l’aura vu peut‐être »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5edca6bf-25bf-49e3-ab76-0ee36ff79d05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5edca6bf-25bf-49e3-ab76-0ee36ff79d05', 30, NULL, 'Prologue. Scène « Prieur, de ces côtés on l’aura vu peut‐être »', 'Grisélidis : Prologue. Scène « Prieur, de ces côtés on l’aura vu peut‐être »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5edca6bf-25bf-49e3-ab76-0ee36ff79d05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entrée de Grisélidis « Le rêve a fui mon front »', part.name_en = 'Grisélidis : Acte II. Entrée de Grisélidis « Le rêve a fui mon front »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:60c4b214-0ded-43eb-a5e4-f9e769cedea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60c4b214-0ded-43eb-a5e4-f9e769cedea6', 31, NULL, 'Acte II. Entrée de Grisélidis « Le rêve a fui mon front »', 'Grisélidis : Acte II. Entrée de Grisélidis « Le rêve a fui mon front »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60c4b214-0ded-43eb-a5e4-f9e769cedea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Acte III. Scène « S’il n’avait pas menti »', part.name_en = 'Grisélidis : Acte III. Scène « S’il n’avait pas menti »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:61722f11-f95d-42c2-a2b0-bf5198c6d51c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61722f11-f95d-42c2-a2b0-bf5198c6d51c', 32, NULL, 'Acte III. Scène « S’il n’avait pas menti »', 'Grisélidis : Acte III. Scène « S’il n’avait pas menti »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61722f11-f95d-42c2-a2b0-bf5198c6d51c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Acte II. Floraison des roses', part.name_en = 'Grisélidis : Acte II. Floraison des roses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7b5b1bb6-ef19-4b88-9bf6-dfec02980ce8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b5b1bb6-ef19-4b88-9bf6-dfec02980ce8', 33, NULL, 'Acte II. Floraison des roses', 'Grisélidis : Acte II. Floraison des roses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b5b1bb6-ef19-4b88-9bf6-dfec02980ce8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Prologue. Air « Voir Grisélidis, c’est connaître »', part.name_en = 'Grisélidis : Prologue. Air « Voir Grisélidis, c’est connaître »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:81970f2a-3743-408b-b814-6f4ce96d6a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81970f2a-3743-408b-b814-6f4ce96d6a0b', 34, NULL, 'Prologue. Air « Voir Grisélidis, c’est connaître »', 'Grisélidis : Prologue. Air « Voir Grisélidis, c’est connaître »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81970f2a-3743-408b-b814-6f4ce96d6a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Acte II. Air « Je suis l’oiseau » (Alain)', part.name_en = 'Grisélidis : Acte II. Air « Je suis l’oiseau » (Alain)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:826407e0-daaf-46d0-92e4-767bef877f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:826407e0-daaf-46d0-92e4-767bef877f19', 35, NULL, 'Acte II. Air « Je suis l’oiseau » (Alain)', 'Grisélidis : Acte II. Air « Je suis l’oiseau » (Alain)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:826407e0-daaf-46d0-92e4-767bef877f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Acte III. Scène finale « Magnificat anima mea Dominum »', part.name_en = 'Grisélidis : Acte III. Scène finale « Magnificat anima mea Dominum »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8db86ebc-6ef8-45cb-acbd-5904b65227ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db86ebc-6ef8-45cb-acbd-5904b65227ad', 36, NULL, 'Acte III. Scène finale « Magnificat anima mea Dominum »', 'Grisélidis : Acte III. Scène finale « Magnificat anima mea Dominum »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db86ebc-6ef8-45cb-acbd-5904b65227ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Prologue. Arioso « La volonté du ciel sans doute étant la vôtre »', part.name_en = 'Grisélidis : Prologue. Arioso « La volonté du ciel sans doute étant la vôtre »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:915f637d-3a0c-474a-bc85-1b89810a7a60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:915f637d-3a0c-474a-bc85-1b89810a7a60', 37, NULL, 'Prologue. Arioso « La volonté du ciel sans doute étant la vôtre »', 'Grisélidis : Prologue. Arioso « La volonté du ciel sans doute étant la vôtre »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:915f637d-3a0c-474a-bc85-1b89810a7a60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Acte I. Couplets « En Avignon, pays d’amour »', part.name_en = 'Grisélidis : Acte I. Couplets « En Avignon, pays d’amour »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:92dbd056-d565-46ac-8c6f-0f834cc521be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92dbd056-d565-46ac-8c6f-0f834cc521be', 38, NULL, 'Acte I. Couplets « En Avignon, pays d’amour »', 'Grisélidis : Acte I. Couplets « En Avignon, pays d’amour »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92dbd056-d565-46ac-8c6f-0f834cc521be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Acte II. Scène et Prière « Mon enfant, viens prier »', part.name_en = 'Grisélidis : Acte II. Scène et Prière « Mon enfant, viens prier »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:984c058a-db56-433a-8f9a-19ca6ae330d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984c058a-db56-433a-8f9a-19ca6ae330d5', 39, NULL, 'Acte II. Scène et Prière « Mon enfant, viens prier »', 'Grisélidis : Acte II. Scène et Prière « Mon enfant, viens prier »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984c058a-db56-433a-8f9a-19ca6ae330d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Acte I. Scène « Chut ! Les chansons d’amour ont fait leur temps »', part.name_en = 'Grisélidis : Acte I. Scène « Chut ! Les chansons d’amour ont fait leur temps »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9db74e7e-b4c8-4130-921d-17a05e2fe057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9db74e7e-b4c8-4130-921d-17a05e2fe057', 40, NULL, 'Acte I. Scène « Chut ! Les chansons d’amour ont fait leur temps »', 'Grisélidis : Acte I. Scène « Chut ! Les chansons d’amour ont fait leur temps »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db74e7e-b4c8-4130-921d-17a05e2fe057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Acte I. Trio « J’avais fait, comme on dit, le diable »', part.name_en = 'Grisélidis : Acte I. Trio « J’avais fait, comme on dit, le diable »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a8ea5dcc-cece-4c24-b8ef-e7730ecfa3aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8ea5dcc-cece-4c24-b8ef-e7730ecfa3aa', 41, NULL, 'Acte I. Trio « J’avais fait, comme on dit, le diable »', 'Grisélidis : Acte I. Trio « J’avais fait, comme on dit, le diable »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8ea5dcc-cece-4c24-b8ef-e7730ecfa3aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Acte II. Danse des Esprits', part.name_en = 'Grisélidis : Acte II. Danse des Esprits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b251544b-2a98-4f9f-8558-318a181a6f15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b251544b-2a98-4f9f-8558-318a181a6f15', 42, NULL, 'Acte II. Danse des Esprits', 'Grisélidis : Acte II. Danse des Esprits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b251544b-2a98-4f9f-8558-318a181a6f15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entracte – Idylle', part.name_en = 'Grisélidis : Acte II. Entracte – Idylle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b4bbf1f1-5f65-44d9-b4eb-540296624f06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4bbf1f1-5f65-44d9-b4eb-540296624f06', 43, NULL, 'Acte II. Entracte – Idylle', 'Grisélidis : Acte II. Entracte – Idylle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4bbf1f1-5f65-44d9-b4eb-540296624f06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Acte III. Scène « Mais, sacrebleu ! Je vous le dis »', part.name_en = 'Grisélidis : Acte III. Scène « Mais, sacrebleu ! Je vous le dis »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bd6728d5-10a1-4027-aee7-9c4ea95d4cdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6728d5-10a1-4027-aee7-9c4ea95d4cdb', 44, NULL, 'Acte III. Scène « Mais, sacrebleu ! Je vous le dis »', 'Grisélidis : Acte III. Scène « Mais, sacrebleu ! Je vous le dis »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6728d5-10a1-4027-aee7-9c4ea95d4cdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Prologue. Scène finale « Au château par la main »', part.name_en = 'Grisélidis : Prologue. Scène finale « Au château par la main »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bf6a07ea-21af-46c8-af94-c81fb2c68d3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf6a07ea-21af-46c8-af94-c81fb2c68d3e', 45, NULL, 'Prologue. Scène finale « Au château par la main »', 'Grisélidis : Prologue. Scène finale « Au château par la main »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf6a07ea-21af-46c8-af94-c81fb2c68d3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Acte II. Incantation – suite « Accourez ! »', part.name_en = 'Grisélidis : Acte II. Incantation – suite « Accourez ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c04f8b17-417b-4cd1-9e04-eaaae1cdbb19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c04f8b17-417b-4cd1-9e04-eaaae1cdbb19', 46, NULL, 'Acte II. Incantation – suite « Accourez ! »', 'Grisélidis : Acte II. Incantation – suite « Accourez ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c04f8b17-417b-4cd1-9e04-eaaae1cdbb19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Acte II. Duo « Non ! Vous cherchiez ici »', part.name_en = 'Grisélidis : Acte II. Duo « Non ! Vous cherchiez ici »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c218ae5d-a1c4-44aa-b96d-ba433ca4110f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c218ae5d-a1c4-44aa-b96d-ba433ca4110f', 47, NULL, 'Acte II. Duo « Non ! Vous cherchiez ici »', 'Grisélidis : Acte II. Duo « Non ! Vous cherchiez ici »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c218ae5d-a1c4-44aa-b96d-ba433ca4110f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo « L’heure cruelle, hélas ! »', part.name_en = 'Grisélidis : Acte III. Duo « L’heure cruelle, hélas ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ca8ee92c-3a2d-48e9-b684-c0b9d7d77364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca8ee92c-3a2d-48e9-b684-c0b9d7d77364', 48, NULL, 'Acte III. Duo « L’heure cruelle, hélas ! »', 'Grisélidis : Acte III. Duo « L’heure cruelle, hélas ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca8ee92c-3a2d-48e9-b684-c0b9d7d77364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Acte II. Air « La mer ! Et sur les flots toujours bleus »', part.name_en = 'Grisélidis : Acte II. Air « La mer ! Et sur les flots toujours bleus »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ce4446b3-03a6-4b77-98e5-c211a56259b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce4446b3-03a6-4b77-98e5-c211a56259b4', 49, NULL, 'Acte II. Air « La mer ! Et sur les flots toujours bleus »', 'Grisélidis : Acte II. Air « La mer ! Et sur les flots toujours bleus »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce4446b3-03a6-4b77-98e5-c211a56259b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Acte I. Arioso et suite du Duo « Devant le soleil clair »', part.name_en = 'Grisélidis : Acte I. Arioso et suite du Duo « Devant le soleil clair »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d89745a7-80ff-48e3-b446-10fe4e78a087' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d89745a7-80ff-48e3-b446-10fe4e78a087', 50, NULL, 'Acte I. Arioso et suite du Duo « Devant le soleil clair »', 'Grisélidis : Acte I. Arioso et suite du Duo « Devant le soleil clair »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89745a7-80ff-48e3-b446-10fe4e78a087'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Acte III. Prélude', part.name_en = 'Grisélidis : Acte III. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e76878ab-0748-459a-a92c-d70f531777ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e76878ab-0748-459a-a92c-d70f531777ed', 51, NULL, 'Acte III. Prélude', 'Grisélidis : Acte III. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76878ab-0748-459a-a92c-d70f531777ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Acte III. Air « Loÿs ! Loÿs ! »', part.name_en = 'Grisélidis : Acte III. Air « Loÿs ! Loÿs ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e94d7937-57c1-4f49-b587-27566afd8ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e94d7937-57c1-4f49-b587-27566afd8ac6', 52, NULL, 'Acte III. Air « Loÿs ! Loÿs ! »', 'Grisélidis : Acte III. Air « Loÿs ! Loÿs ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e94d7937-57c1-4f49-b587-27566afd8ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Acte II. Scène « Mon cher époux »', part.name_en = 'Grisélidis : Acte II. Scène « Mon cher époux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:edf5160a-b7e8-4861-962e-18ffc84eea1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf5160a-b7e8-4861-962e-18ffc84eea1e', 53, NULL, 'Acte II. Scène « Mon cher époux »', 'Grisélidis : Acte II. Scène « Mon cher époux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf5160a-b7e8-4861-962e-18ffc84eea1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Acte II. Duo – fin « Dans tout mon être, quel émoi ! »', part.name_en = 'Grisélidis : Acte II. Duo – fin « Dans tout mon être, quel émoi ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ef6daf2c-ddaa-4ba3-9c25-da3674fba626' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef6daf2c-ddaa-4ba3-9c25-da3674fba626', 54, NULL, 'Acte II. Duo – fin « Dans tout mon être, quel émoi ! »', 'Grisélidis : Acte II. Duo – fin « Dans tout mon être, quel émoi ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef6daf2c-ddaa-4ba3-9c25-da3674fba626'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Acte II. Scène finale « Ah ! Loÿs ! Où donc es‐tu ? »', part.name_en = 'Grisélidis : Acte II. Scène finale « Ah ! Loÿs ! Où donc es‐tu ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:efbb87b9-50a2-4847-8900-bdc1af1a4feb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efbb87b9-50a2-4847-8900-bdc1af1a4feb', 55, NULL, 'Acte II. Scène finale « Ah ! Loÿs ! Où donc es‐tu ? »', 'Grisélidis : Acte II. Scène finale « Ah ! Loÿs ! Où donc es‐tu ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efbb87b9-50a2-4847-8900-bdc1af1a4feb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Acte II. Sortie des Esprits « Vous qui portez »', part.name_en = 'Grisélidis : Acte II. Sortie des Esprits « Vous qui portez »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f97bc7ba-ef2f-420c-8913-482f3db60707' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f97bc7ba-ef2f-420c-8913-482f3db60707', 56, NULL, 'Acte II. Sortie des Esprits « Vous qui portez »', 'Grisélidis : Acte II. Sortie des Esprits « Vous qui portez »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f97bc7ba-ef2f-420c-8913-482f3db60707'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Acte III. Duo – suite « Soit ! j’irai donc »', part.name_en = 'Grisélidis : Acte III. Duo – suite « Soit ! j’irai donc »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fb25fa0e-afd2-4416-a8f7-84576cd3b4c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb25fa0e-afd2-4416-a8f7-84576cd3b4c4', 57, NULL, 'Acte III. Duo – suite « Soit ! j’irai donc »', 'Grisélidis : Acte III. Duo – suite « Soit ! j’irai donc »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb25fa0e-afd2-4416-a8f7-84576cd3b4c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Acte II. Trio – suite « Nos goûts ne se ressemblent guère »', part.name_en = 'Grisélidis : Acte II. Trio – suite « Nos goûts ne se ressemblent guère »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10370 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fd2d4793-634d-4978-addc-a2a0c274d59f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd2d4793-634d-4978-addc-a2a0c274d59f', 58, NULL, 'Acte II. Trio – suite « Nos goûts ne se ressemblent guère »', 'Grisélidis : Acte II. Trio – suite « Nos goûts ne se ressemblent guère »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10370 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd2d4793-634d-4978-addc-a2a0c274d59f'
);


-- None 가곡 <Heure vécue>

UPDATE pieces piece
SET piece.title = '가곡 <Heure vécue>', piece.title_en = 'Heure vécue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11121 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymne d’amour

UPDATE pieces piece
SET piece.title = 'Hymne d’amour', piece.title_en = 'Hymne d’amour',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7895 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Hérodiade>

UPDATE pieces piece
SET piece.title = '오페라 <Hérodiade>', piece.title_en = 'Hérodiade',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10346 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Hérodiade : Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:09ad227c-fe6d-485c-acc3-4c19897a7856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09ad227c-fe6d-485c-acc3-4c19897a7856', 1, NULL, 'Introduction', 'Hérodiade : Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ad227c-fe6d-485c-acc3-4c19897a7856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Hérodiade: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320', 2, NULL, 'Acte III', 'Hérodiade: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 9. « Hérode ! À toi ces palmes ! » (Chœur, Salomé)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 9. « Hérode ! À toi ces palmes ! » (Chœur, Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:15724467-23af-41dc-a91c-99dc1c085832' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15724467-23af-41dc-a91c-99dc1c085832', 1, NULL, 'Acte III, tableau 2, scène 9. « Hérode ! À toi ces palmes ! » (Chœur, Salomé)', 'Hérodiade : Acte III, tableau 2, scène 9. « Hérode ! À toi ces palmes ! » (Chœur, Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15724467-23af-41dc-a91c-99dc1c085832'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 11. Scène religieuse. « Schemâh Israël ! » (Une voix, Chœur, Le Grand Prêtre)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 11. Scène religieuse. « Schemâh Israël ! » (Une voix, Chœur, Le Grand Prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1ab05bea-b2bb-43bc-9b3b-d544f4b422cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ab05bea-b2bb-43bc-9b3b-d544f4b422cb', 2, NULL, 'Acte III, tableau 2, scène 11. Scène religieuse. « Schemâh Israël ! » (Une voix, Chœur, Le Grand Prêtre)', 'Hérodiade : Acte III, tableau 2, scène 11. Scène religieuse. « Schemâh Israël ! » (Une voix, Chœur, Le Grand Prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab05bea-b2bb-43bc-9b3b-d544f4b422cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 1, scène 8. « Dors, ô cité perverse ! » (Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 1, scène 8. « Dors, ô cité perverse ! » (Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:221616dd-988a-4a11-a00e-2ac352b4dca2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:221616dd-988a-4a11-a00e-2ac352b4dca2', 3, NULL, 'Acte III, tableau 1, scène 8. « Dors, ô cité perverse ! » (Phanuel)', 'Hérodiade : Acte III, tableau 1, scène 8. « Dors, ô cité perverse ! » (Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:221616dd-988a-4a11-a00e-2ac352b4dca2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 11. Danse sacrée', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 11. Danse sacrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2cf9aef1-d27e-482a-befb-e4de1b4c4cf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cf9aef1-d27e-482a-befb-e4de1b4c4cf7', 4, NULL, 'Acte III, tableau 2, scène 11. Danse sacrée', 'Hérodiade : Acte III, tableau 2, scène 11. Danse sacrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cf9aef1-d27e-482a-befb-e4de1b4c4cf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 11. Marche sainte', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 11. Marche sainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:371b2edf-37f0-44eb-b373-0e90f11cd85f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:371b2edf-37f0-44eb-b373-0e90f11cd85f', 5, NULL, 'Acte III, tableau 2, scène 11. Marche sainte', 'Hérodiade : Acte III, tableau 2, scène 11. Marche sainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:371b2edf-37f0-44eb-b373-0e90f11cd85f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. « Voilà donc ce mortel » … « Comme il est beau dans sa misère ! » (Hérode, Chœur, Phanuel, Vitellius, Hérodiade, Jean)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. « Voilà donc ce mortel » … « Comme il est beau dans sa misère ! » (Hérode, Chœur, Phanuel, Vitellius, Hérodiade, Jean)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6163d631-bc0d-4b8a-afe4-f9ed122b7c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6163d631-bc0d-4b8a-afe4-f9ed122b7c6e', 6, NULL, 'Acte III, tableau 2, scène 12. « Voilà donc ce mortel » … « Comme il est beau dans sa misère ! » (Hérode, Chœur, Phanuel, Vitellius, Hérodiade, Jean)', 'Hérodiade : Acte III, tableau 2, scène 12. « Voilà donc ce mortel » … « Comme il est beau dans sa misère ! » (Hérode, Chœur, Phanuel, Vitellius, Hérodiade, Jean)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6163d631-bc0d-4b8a-afe4-f9ed122b7c6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. « Frappez donc ! Frappez les apôtres » … « Qu’ils meurent ! » (Jean, Chœur, Hérode, Salomé, Hérodiade, Vitellius, Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. « Frappez donc ! Frappez les apôtres » … « Qu’ils meurent ! » (Jean, Chœur, Hérode, Salomé, Hérodiade, Vitellius, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:64c76b8a-bc12-4d5f-9ec8-b2fab0ebdc61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64c76b8a-bc12-4d5f-9ec8-b2fab0ebdc61', 7, NULL, 'Acte III, tableau 2, scène 12. « Frappez donc ! Frappez les apôtres » … « Qu’ils meurent ! » (Jean, Chœur, Hérode, Salomé, Hérodiade, Vitellius, Phanuel)', 'Hérodiade : Acte III, tableau 2, scène 12. « Frappez donc ! Frappez les apôtres » … « Qu’ils meurent ! » (Jean, Chœur, Hérode, Salomé, Hérodiade, Vitellius, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c76b8a-bc12-4d5f-9ec8-b2fab0ebdc61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 1, scène 8. « Si Dieu l’avait voulu… » (Hérodiade, Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 1, scène 8. « Si Dieu l’avait voulu… » (Hérodiade, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:75a5d1ce-81b8-4d0f-a049-b6662d2ac110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75a5d1ce-81b8-4d0f-a049-b6662d2ac110', 8, NULL, 'Acte III, tableau 1, scène 8. « Si Dieu l’avait voulu… » (Hérodiade, Phanuel)', 'Hérodiade : Acte III, tableau 1, scène 8. « Si Dieu l’avait voulu… » (Hérodiade, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a5d1ce-81b8-4d0f-a049-b6662d2ac110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2. Prélude. Andante sostenuto religioso', part.name_en = 'Hérodiade : Acte III, tableau 2. Prélude. Andante sostenuto religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:81530b2f-9871-4ff4-8229-c5d103155eac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81530b2f-9871-4ff4-8229-c5d103155eac', 9, NULL, 'Acte III, tableau 2. Prélude. Andante sostenuto religioso', 'Hérodiade : Acte III, tableau 2. Prélude. Andante sostenuto religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81530b2f-9871-4ff4-8229-c5d103155eac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 10. « C’en est fait ! La Judée appartient à Tibère ! » (Hérode, Salomé)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 10. « C’en est fait ! La Judée appartient à Tibère ! » (Hérode, Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b14d243b-5b0b-4620-9c56-542f64e70b0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b14d243b-5b0b-4620-9c56-542f64e70b0c', 10, NULL, 'Acte III, tableau 2, scène 10. « C’en est fait ! La Judée appartient à Tibère ! » (Hérode, Salomé)', 'Hérodiade : Acte III, tableau 2, scène 10. « C’en est fait ! La Judée appartient à Tibère ! » (Hérode, Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b14d243b-5b0b-4620-9c56-542f64e70b0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. « Peuple juif ! » (Vitellius, Hérode, Chœur)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. « Peuple juif ! » (Vitellius, Hérode, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:be4ea3d2-b3d5-4f99-9e6b-25185d850774' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be4ea3d2-b3d5-4f99-9e6b-25185d850774', 11, NULL, 'Acte III, tableau 2, scène 12. « Peuple juif ! » (Vitellius, Hérode, Chœur)', 'Hérodiade : Acte III, tableau 2, scène 12. « Peuple juif ! » (Vitellius, Hérode, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be4ea3d2-b3d5-4f99-9e6b-25185d850774'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 1, scène 8. « Ah ! Phanuel ! » (Hérodiade, Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 1, scène 8. « Ah ! Phanuel ! » (Hérodiade, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cf011333-464c-4ce5-894e-bbfa204451b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf011333-464c-4ce5-894e-bbfa204451b9', 12, NULL, 'Acte III, tableau 1, scène 8. « Ah ! Phanuel ! » (Hérodiade, Phanuel)', 'Hérodiade : Acte III, tableau 1, scène 8. « Ah ! Phanuel ! » (Hérodiade, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf011333-464c-4ce5-894e-bbfa204451b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. Interrogatoire « Homme quel est‐ton nom ? » (Hérode, Jean, Hérodiade, Chœur, Vitellius, Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. Interrogatoire « Homme quel est‐ton nom ? » (Hérode, Jean, Hérodiade, Chœur, Vitellius, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d0f0d388-108b-4ed6-8017-79755fc8ca73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0f0d388-108b-4ed6-8017-79755fc8ca73', 13, NULL, 'Acte III, tableau 2, scène 12. Interrogatoire « Homme quel est‐ton nom ? » (Hérode, Jean, Hérodiade, Chœur, Vitellius, Phanuel)', 'Hérodiade : Acte III, tableau 2, scène 12. Interrogatoire « Homme quel est‐ton nom ? » (Hérode, Jean, Hérodiade, Chœur, Vitellius, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f0d388-108b-4ed6-8017-79755fc8ca73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. « Prêtres, vous disiez vrai ! » (Hérode, Chœur, Hérodiade, Phanuel)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. « Prêtres, vous disiez vrai ! » (Hérode, Chœur, Hérodiade, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d2e30296-e061-49f2-8095-dd38ea68b610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2e30296-e061-49f2-8095-dd38ea68b610', 14, NULL, 'Acte III, tableau 2, scène 12. « Prêtres, vous disiez vrai ! » (Hérode, Chœur, Hérodiade, Phanuel)', 'Hérodiade : Acte III, tableau 2, scène 12. « Prêtres, vous disiez vrai ! » (Hérode, Chœur, Hérodiade, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e30296-e061-49f2-8095-dd38ea68b610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 9. « Charme des jours passés » (Salomé)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 9. « Charme des jours passés » (Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eadea3b2-c3e5-4601-941e-c6244b47e79f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eadea3b2-c3e5-4601-941e-c6244b47e79f', 15, NULL, 'Acte III, tableau 2, scène 9. « Charme des jours passés » (Salomé)', 'Hérodiade : Acte III, tableau 2, scène 9. « Charme des jours passés » (Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eadea3b2-c3e5-4601-941e-c6244b47e79f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 12. « J’ai vécu de sa vie et mourrai de sa mort » … « C’est Dieu que l’on te nomme ! » (Salomé, Hérode, Hérodiade, Vitellius, Phanuel, Chœur)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 12. « J’ai vécu de sa vie et mourrai de sa mort » … « C’est Dieu que l’on te nomme ! » (Salomé, Hérode, Hérodiade, Vitellius, Phanuel, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:faca2b4e-6f32-43f3-afc2-2d80b2ed68cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:faca2b4e-6f32-43f3-afc2-2d80b2ed68cf', 16, NULL, 'Acte III, tableau 2, scène 12. « J’ai vécu de sa vie et mourrai de sa mort » … « C’est Dieu que l’on te nomme ! » (Salomé, Hérode, Hérodiade, Vitellius, Phanuel, Chœur)', 'Hérodiade : Acte III, tableau 2, scène 12. « J’ai vécu de sa vie et mourrai de sa mort » … « C’est Dieu que l’on te nomme ! » (Salomé, Hérode, Hérodiade, Vitellius, Phanuel, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faca2b4e-6f32-43f3-afc2-2d80b2ed68cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Acte III, tableau 2, scène 10. « Que m’oses tu dire ? » (Salomé, Hérode, Chœur)', part.name_en = 'Hérodiade : Acte III, tableau 2, scène 10. « Que m’oses tu dire ? » (Salomé, Hérode, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fd5f9395-f7fa-45c3-a64e-ac5f74fb269e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd5f9395-f7fa-45c3-a64e-ac5f74fb269e', 17, NULL, 'Acte III, tableau 2, scène 10. « Que m’oses tu dire ? » (Salomé, Hérode, Chœur)', 'Hérodiade : Acte III, tableau 2, scène 10. « Que m’oses tu dire ? » (Salomé, Hérode, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a9a86c5-192a-4406-a0b8-fc11155ce320'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd5f9395-f7fa-45c3-a64e-ac5f74fb269e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Hérodiade: Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf', 3, NULL, 'Acte IV', 'Hérodiade: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 1, scène 13. « Ami, la mort n’est pas cruelle » (Salomé, Jean)', part.name_en = 'Hérodiade : Acte IV, tableau 1, scène 13. « Ami, la mort n’est pas cruelle » (Salomé, Jean)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:04251960-1388-4a3a-b130-4c3610ef96aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04251960-1388-4a3a-b130-4c3610ef96aa', 1, NULL, 'Acte IV, tableau 1, scène 13. « Ami, la mort n’est pas cruelle » (Salomé, Jean)', 'Hérodiade : Acte IV, tableau 1, scène 13. « Ami, la mort n’est pas cruelle » (Salomé, Jean)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04251960-1388-4a3a-b130-4c3610ef96aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 1: Prélude. Andante sostenuto', part.name_en = 'Hérodiade : Acte IV, tableau 1: Prélude. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6e0f4934-0b93-4304-a867-6b380dcbfba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e0f4934-0b93-4304-a867-6b380dcbfba0', 2, NULL, 'Acte IV, tableau 1: Prélude. Andante sostenuto', 'Hérodiade : Acte IV, tableau 1: Prélude. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e0f4934-0b93-4304-a867-6b380dcbfba0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 2, scène 14. « Romains ! Romains ! Nous sommes Romains ! » (Chœur)', part.name_en = 'Hérodiade : Acte IV, tableau 2, scène 14. « Romains ! Romains ! Nous sommes Romains ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:72d39163-5eac-4582-bf8e-efa363386a0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72d39163-5eac-4582-bf8e-efa363386a0e', 3, NULL, 'Acte IV, tableau 2, scène 14. « Romains ! Romains ! Nous sommes Romains ! » (Chœur)', 'Hérodiade : Acte IV, tableau 2, scène 14. « Romains ! Romains ! Nous sommes Romains ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d39163-5eac-4582-bf8e-efa363386a0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 1, scène 13. « Salomé ! Jean ! » (Jean, Salomé, Chœur)', part.name_en = 'Hérodiade : Acte IV, tableau 1, scène 13. « Salomé ! Jean ! » (Jean, Salomé, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9ccd796a-c2b2-4be2-ad53-c968bb64b870' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ccd796a-c2b2-4be2-ad53-c968bb64b870', 4, NULL, 'Acte IV, tableau 1, scène 13. « Salomé ! Jean ! » (Jean, Salomé, Chœur)', 'Hérodiade : Acte IV, tableau 1, scène 13. « Salomé ! Jean ! » (Jean, Salomé, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ccd796a-c2b2-4be2-ad53-c968bb64b870'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 1, scène 13. « Ne pouvant réprimer les élans de la foi » … « Adieu donc » (Jean)', part.name_en = 'Hérodiade : Acte IV, tableau 1, scène 13. « Ne pouvant réprimer les élans de la foi » … « Adieu donc » (Jean)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cc125070-f667-475d-8e5e-0b648f9a66e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc125070-f667-475d-8e5e-0b648f9a66e4', 5, NULL, 'Acte IV, tableau 1, scène 13. « Ne pouvant réprimer les élans de la foi » … « Adieu donc » (Jean)', 'Hérodiade : Acte IV, tableau 1, scène 13. « Ne pouvant réprimer les élans de la foi » … « Adieu donc » (Jean)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc125070-f667-475d-8e5e-0b648f9a66e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 2, scène 15. « Ah ! Le Prophète est mort ! » (Salomé, Chœur, Hérodiade, Hérode, Vitellius, Phanuel)', part.name_en = 'Hérodiade : Acte IV, tableau 2, scène 15. « Ah ! Le Prophète est mort ! » (Salomé, Chœur, Hérodiade, Hérode, Vitellius, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d1888bc9-783a-4f3d-85d5-da2ab480c05c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1888bc9-783a-4f3d-85d5-da2ab480c05c', 6, NULL, 'Acte IV, tableau 2, scène 15. « Ah ! Le Prophète est mort ! » (Salomé, Chœur, Hérodiade, Hérode, Vitellius, Phanuel)', 'Hérodiade : Acte IV, tableau 2, scène 15. « Ah ! Le Prophète est mort ! » (Salomé, Chœur, Hérodiade, Hérode, Vitellius, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1888bc9-783a-4f3d-85d5-da2ab480c05c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 2, scène 15. « Pourquoi me retirer cette faveur suprême ? » (Salomé, Hérode, Hérodiade, Phanuel, Chœur, Vitellius)', part.name_en = 'Hérodiade : Acte IV, tableau 2, scène 15. « Pourquoi me retirer cette faveur suprême ? » (Salomé, Hérode, Hérodiade, Phanuel, Chœur, Vitellius)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d99145b3-11af-4368-838a-ca563a7d0426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d99145b3-11af-4368-838a-ca563a7d0426', 7, NULL, 'Acte IV, tableau 2, scène 15. « Pourquoi me retirer cette faveur suprême ? » (Salomé, Hérode, Hérodiade, Phanuel, Chœur, Vitellius)', 'Hérodiade : Acte IV, tableau 2, scène 15. « Pourquoi me retirer cette faveur suprême ? » (Salomé, Hérode, Hérodiade, Phanuel, Chœur, Vitellius)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99145b3-11af-4368-838a-ca563a7d0426'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte IV, tableau 1, scène 13. « Quand nos jours s’éteindront comme une chaste flamme » (Jean, Salomé, Le Grand Prêtre)', part.name_en = 'Hérodiade : Acte IV, tableau 1, scène 13. « Quand nos jours s’éteindront comme une chaste flamme » (Jean, Salomé, Le Grand Prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eb6995a4-f1d6-462d-92ef-665a054e900a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eb6995a4-f1d6-462d-92ef-665a054e900a', 8, NULL, 'Acte IV, tableau 1, scène 13. « Quand nos jours s’éteindront comme une chaste flamme » (Jean, Salomé, Le Grand Prêtre)', 'Hérodiade : Acte IV, tableau 1, scène 13. « Quand nos jours s’éteindront comme une chaste flamme » (Jean, Salomé, Le Grand Prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5437b8ac-286a-4188-9514-9741fe0db4bf'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb6995a4-f1d6-462d-92ef-665a054e900a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Hérodiade: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d', 4, NULL, 'Acte II', 'Hérodiade: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 6. « Voilà l’homme qui fait trembler tout un empire ! » (Phanuel, Hérode)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 6. « Voilà l’homme qui fait trembler tout un empire ! » (Phanuel, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:08eeedcd-f383-4be5-847a-070ae0af44cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08eeedcd-f383-4be5-847a-070ae0af44cf', 1, NULL, 'Acte II, tableau 1, scène 6. « Voilà l’homme qui fait trembler tout un empire ! » (Phanuel, Hérode)', 'Hérodiade : Acte II, tableau 1, scène 6. « Voilà l’homme qui fait trembler tout un empire ! » (Phanuel, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08eeedcd-f383-4be5-847a-070ae0af44cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 2, scène 7. « Vous qui tenez conseil sur les places publiques… » (Hérodiade, Hérode, Phanuel, Chœur)', part.name_en = 'Hérodiade : Acte II, tableau 2, scène 7. « Vous qui tenez conseil sur les places publiques… » (Hérodiade, Hérode, Phanuel, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:107f7a78-3507-4f56-8ee5-3e22aa4bcf52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:107f7a78-3507-4f56-8ee5-3e22aa4bcf52', 2, NULL, 'Acte II, tableau 2, scène 7. « Vous qui tenez conseil sur les places publiques… » (Hérodiade, Hérode, Phanuel, Chœur)', 'Hérodiade : Acte II, tableau 2, scène 7. « Vous qui tenez conseil sur les places publiques… » (Hérodiade, Hérode, Phanuel, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:107f7a78-3507-4f56-8ee5-3e22aa4bcf52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 2, scène 7. « Aux Romains orgueilleux de nous avoir soumis ! » (Chœur, Hérode, Phanuel)', part.name_en = 'Hérodiade : Acte II, tableau 2, scène 7. « Aux Romains orgueilleux de nous avoir soumis ! » (Chœur, Hérode, Phanuel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5c325b36-42b3-48e8-b6ac-648d26b6180c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c325b36-42b3-48e8-b6ac-648d26b6180c', 3, NULL, 'Acte II, tableau 2, scène 7. « Aux Romains orgueilleux de nous avoir soumis ! » (Chœur, Hérode, Phanuel)', 'Hérodiade : Acte II, tableau 2, scène 7. « Aux Romains orgueilleux de nous avoir soumis ! » (Chœur, Hérode, Phanuel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c325b36-42b3-48e8-b6ac-648d26b6180c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 2, scène 7. « Roi ! Que ta superbe vaillance » (Chœur, Hérode)', part.name_en = 'Hérodiade : Acte II, tableau 2, scène 7. « Roi ! Que ta superbe vaillance » (Chœur, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:646b9dce-0cdd-4832-9939-63024da9a7b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:646b9dce-0cdd-4832-9939-63024da9a7b7', 4, NULL, 'Acte II, tableau 2, scène 7. « Roi ! Que ta superbe vaillance » (Chœur, Hérode)', 'Hérodiade : Acte II, tableau 2, scène 7. « Roi ! Que ta superbe vaillance » (Chœur, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:646b9dce-0cdd-4832-9939-63024da9a7b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Si l’esclave mentait cependant… » (Une jeune Babylonienne, Hérode)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Si l’esclave mentait cependant… » (Une jeune Babylonienne, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:66ecd08f-437f-4617-b85d-25c8e37a263d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66ecd08f-437f-4617-b85d-25c8e37a263d', 5, NULL, 'Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Si l’esclave mentait cependant… » (Une jeune Babylonienne, Hérode)', 'Hérodiade : Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Si l’esclave mentait cependant… » (Une jeune Babylonienne, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ecd08f-437f-4617-b85d-25c8e37a263d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 6. « Explique‐moi d’abord le mal que je ressens ! » (Hérode, Phanuel, Chœur)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 6. « Explique‐moi d’abord le mal que je ressens ! » (Hérode, Phanuel, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:693bbb25-9e1a-4bb0-a23d-3815f7749549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:693bbb25-9e1a-4bb0-a23d-3815f7749549', 6, NULL, 'Acte II, tableau 1, scène 6. « Explique‐moi d’abord le mal que je ressens ! » (Hérode, Phanuel, Chœur)', 'Hérodiade : Acte II, tableau 1, scène 6. « Explique‐moi d’abord le mal que je ressens ! » (Hérode, Phanuel, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:693bbb25-9e1a-4bb0-a23d-3815f7749549'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 2, scène 7. « Hosannah ! » … « Je tiens ma vengeance ! » … « Toute justice vient du ciel ! » (Chœur, Salomé, Hérode, Phanuel, Hérodiade, Vitellius, Jean)', part.name_en = 'Hérodiade : Acte II, tableau 2, scène 7. « Hosannah ! » … « Je tiens ma vengeance ! » … « Toute justice vient du ciel ! » (Chœur, Salomé, Hérode, Phanuel, Hérodiade, Vitellius, Jean)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:89acc176-4813-4fcb-b037-e7abefa84d90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89acc176-4813-4fcb-b037-e7abefa84d90', 7, NULL, 'Acte II, tableau 2, scène 7. « Hosannah ! » … « Je tiens ma vengeance ! » … « Toute justice vient du ciel ! » (Chœur, Salomé, Hérode, Phanuel, Hérodiade, Vitellius, Jean)', 'Hérodiade : Acte II, tableau 2, scène 7. « Hosannah ! » … « Je tiens ma vengeance ! » … « Toute justice vient du ciel ! » (Chœur, Salomé, Hérode, Phanuel, Hérodiade, Vitellius, Jean)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89acc176-4813-4fcb-b037-e7abefa84d90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 5. « Roi, tu peux t’assoupir » (Chœur, Hérode)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 5. « Roi, tu peux t’assoupir » (Chœur, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:96fabddb-3749-462b-aa86-db447b59b20f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96fabddb-3749-462b-aa86-db447b59b20f', 8, NULL, 'Acte II, tableau 1, scène 5. « Roi, tu peux t’assoupir » (Chœur, Hérode)', 'Hérodiade : Acte II, tableau 1, scène 5. « Roi, tu peux t’assoupir » (Chœur, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96fabddb-3749-462b-aa86-db447b59b20f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 5. « Ce breuvage pourrait me donner un tel rêve ! » … « Vision fugitive » (Hérode)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 5. « Ce breuvage pourrait me donner un tel rêve ! » … « Vision fugitive » (Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aeb07b8b-84a8-4463-85df-415479909a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aeb07b8b-84a8-4463-85df-415479909a29', 9, NULL, 'Acte II, tableau 1, scène 5. « Ce breuvage pourrait me donner un tel rêve ! » … « Vision fugitive » (Hérode)', 'Hérodiade : Acte II, tableau 1, scène 5. « Ce breuvage pourrait me donner un tel rêve ! » … « Vision fugitive » (Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeb07b8b-84a8-4463-85df-415479909a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 5. Danse babylonienne', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 5. Danse babylonienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b28c1371-246f-496e-b863-cb7f3ad8ffaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b28c1371-246f-496e-b863-cb7f3ad8ffaf', 10, NULL, 'Acte II, tableau 1, scène 5. Danse babylonienne', 'Hérodiade : Acte II, tableau 1, scène 5. Danse babylonienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b28c1371-246f-496e-b863-cb7f3ad8ffaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Maître, bois dans cette amphore » (Une jeune Babylonienne, Chœur)', part.name_en = 'Hérodiade : Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Maître, bois dans cette amphore » (Une jeune Babylonienne, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b383266e-1f40-4a85-851c-10ee1ef50bae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b383266e-1f40-4a85-851c-10ee1ef50bae', 11, NULL, 'Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Maître, bois dans cette amphore » (Une jeune Babylonienne, Chœur)', 'Hérodiade : Acte II, tableau 1, scène 5. « Que ce philtre amoureux dissipe ton ennui ! » … « Maître, bois dans cette amphore » (Une jeune Babylonienne, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b383266e-1f40-4a85-851c-10ee1ef50bae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte II, tableau 2, scène 7. « À mon approche quel trouble fait détourner les yeux ? » (Vitellius, Hérode, Phanuel, Chœur, Hérodiade)', part.name_en = 'Hérodiade : Acte II, tableau 2, scène 7. « À mon approche quel trouble fait détourner les yeux ? » (Vitellius, Hérode, Phanuel, Chœur, Hérodiade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dced888d-01b0-448e-8d34-75884dcffeac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dced888d-01b0-448e-8d34-75884dcffeac', 12, NULL, 'Acte II, tableau 2, scène 7. « À mon approche quel trouble fait détourner les yeux ? » (Vitellius, Hérode, Phanuel, Chœur, Hérodiade)', 'Hérodiade : Acte II, tableau 2, scène 7. « À mon approche quel trouble fait détourner les yeux ? » (Vitellius, Hérode, Phanuel, Chœur, Hérodiade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc7855d-dd69-40e3-ad25-fe65f914cd9d'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dced888d-01b0-448e-8d34-75884dcffeac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Hérodiade: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7', 5, NULL, 'Acte I', 'Hérodiade: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 3. « C’est Jean » … « Hérode ! Ne me refuse pas ! » (Hérodiade)', part.name_en = 'Hérodiade : Acte I, scène 3. « C’est Jean » … « Hérode ! Ne me refuse pas ! » (Hérodiade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0e57d734-3c62-4f8e-a435-b298140ec6f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e57d734-3c62-4f8e-a435-b298140ec6f9', 1, NULL, 'Acte I, scène 3. « C’est Jean » … « Hérode ! Ne me refuse pas ! » (Hérodiade)', 'Hérodiade : Acte I, scène 3. « C’est Jean » … « Hérode ! Ne me refuse pas ! » (Hérodiade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e57d734-3c62-4f8e-a435-b298140ec6f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 3. « Frappe donc ! » (Jean, Hérode, Hérodiade)', part.name_en = 'Hérodiade : Acte I, scène 3. « Frappe donc ! » (Jean, Hérode, Hérodiade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:18405f85-618c-436c-a56f-a78b59509d62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18405f85-618c-436c-a56f-a78b59509d62', 2, NULL, 'Acte I, scène 3. « Frappe donc ! » (Jean, Hérode, Hérodiade)', 'Hérodiade : Acte I, scène 3. « Frappe donc ! » (Jean, Hérode, Hérodiade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18405f85-618c-436c-a56f-a78b59509d62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 1. « Encore une dispute ! » (Phanuel, Chœur)', part.name_en = 'Hérodiade : Acte I, scène 1. « Encore une dispute ! » (Phanuel, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:50c770f2-bf51-4379-8e0e-fe1065cdbd67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50c770f2-bf51-4379-8e0e-fe1065cdbd67', 3, NULL, 'Acte I, scène 1. « Encore une dispute ! » (Phanuel, Chœur)', 'Hérodiade : Acte I, scène 1. « Encore une dispute ! » (Phanuel, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50c770f2-bf51-4379-8e0e-fe1065cdbd67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 1. « Ah ! Salomé ! Dans ce palais quelle destinée t’amène ? » (Phanuel, Salomé)', part.name_en = 'Hérodiade : Acte I, scène 1. « Ah ! Salomé ! Dans ce palais quelle destinée t’amène ? » (Phanuel, Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:61b3f2e4-b14d-4a1b-a5db-f320c1a8dea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61b3f2e4-b14d-4a1b-a5db-f320c1a8dea9', 4, NULL, 'Acte I, scène 1. « Ah ! Salomé ! Dans ce palais quelle destinée t’amène ? » (Phanuel, Salomé)', 'Hérodiade : Acte I, scène 1. « Ah ! Salomé ! Dans ce palais quelle destinée t’amène ? » (Phanuel, Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b3f2e4-b14d-4a1b-a5db-f320c1a8dea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 4. « Calmez donc vos fureurs » (Jean, Salomé)', part.name_en = 'Hérodiade : Acte I, scène 4. « Calmez donc vos fureurs » (Jean, Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6941a76f-41d1-459f-ba5b-7314c30569db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6941a76f-41d1-459f-ba5b-7314c30569db', 5, NULL, 'Acte I, scène 4. « Calmez donc vos fureurs » (Jean, Salomé)', 'Hérodiade : Acte I, scène 4. « Calmez donc vos fureurs » (Jean, Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6941a76f-41d1-459f-ba5b-7314c30569db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 2. « Elle a fui le palais » … « Elle a quitté ces lieux » (Hérode)', part.name_en = 'Hérodiade : Acte I, scène 2. « Elle a fui le palais » … « Elle a quitté ces lieux » (Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:700843b0-8f50-43b4-901f-36a8b05b4120' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:700843b0-8f50-43b4-901f-36a8b05b4120', 6, NULL, 'Acte I, scène 2. « Elle a fui le palais » … « Elle a quitté ces lieux » (Hérode)', 'Hérodiade : Acte I, scène 2. « Elle a fui le palais » … « Elle a quitté ces lieux » (Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:700843b0-8f50-43b4-901f-36a8b05b4120'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 1. « Celui dont la parole efface toutes peines » … « Il est doux, il est bon » (Salomé)', part.name_en = 'Hérodiade : Acte I, scène 1. « Celui dont la parole efface toutes peines » … « Il est doux, il est bon » (Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:70d1111b-78d7-486e-8a9b-71889eaef12a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70d1111b-78d7-486e-8a9b-71889eaef12a', 7, NULL, 'Acte I, scène 1. « Celui dont la parole efface toutes peines » … « Il est doux, il est bon » (Salomé)', 'Hérodiade : Acte I, scène 1. « Celui dont la parole efface toutes peines » … « Il est doux, il est bon » (Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d1111b-78d7-486e-8a9b-71889eaef12a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ce que je veux, à Jean ! »', part.name_en = 'Hérodiade : Acte I. « Ce que je veux, à Jean ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:75147be9-104b-470d-859a-e99338e9b29d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75147be9-104b-470d-859a-e99338e9b29d', 8, NULL, 'Acte I. « Ce que je veux, à Jean ! »', 'Hérodiade : Acte I. « Ce que je veux, à Jean ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75147be9-104b-470d-859a-e99338e9b29d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 3. « Venge‐moi d’une suprême offense ! » (Hérodiade, Hérode)', part.name_en = 'Hérodiade : Acte I, scène 3. « Venge‐moi d’une suprême offense ! » (Hérodiade, Hérode)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8bdf1900-f2e6-3dc2-a17c-2804ae08dd13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bdf1900-f2e6-3dc2-a17c-2804ae08dd13', 9, NULL, 'Acte I, scène 3. « Venge‐moi d’une suprême offense ! » (Hérodiade, Hérode)', 'Hérodiade : Acte I, scène 3. « Venge‐moi d’une suprême offense ! » (Hérodiade, Hérode)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bdf1900-f2e6-3dc2-a17c-2804ae08dd13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 1. « Jérusalem ! Jérusalem salut ! Ville fortunée ! » (Chœur, Phanuel, Salomé)', part.name_en = 'Hérodiade : Acte I, scène 1. « Jérusalem ! Jérusalem salut ! Ville fortunée ! » (Chœur, Phanuel, Salomé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a9bbae46-7362-4b1a-9a08-ef216bb1e19c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9bbae46-7362-4b1a-9a08-ef216bb1e19c', 10, NULL, 'Acte I, scène 1. « Jérusalem ! Jérusalem salut ! Ville fortunée ! » (Chœur, Phanuel, Salomé)', 'Hérodiade : Acte I, scène 1. « Jérusalem ! Jérusalem salut ! Ville fortunée ! » (Chœur, Phanuel, Salomé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9bbae46-7362-4b1a-9a08-ef216bb1e19c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. « C’est sa tête que je réclame »', part.name_en = 'Hérodiade : Acte I. « C’est sa tête que je réclame »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d5bb6616-6ff2-4480-89dc-dfd0fe309710' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5bb6616-6ff2-4480-89dc-dfd0fe309710', 11, NULL, 'Acte I. « C’est sa tête que je réclame »', 'Hérodiade : Acte I. « C’est sa tête que je réclame »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5bb6616-6ff2-4480-89dc-dfd0fe309710'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I, scène 1. « Alerte ! Levez‐vous ! Le palais est ouvert ! » (Chœur)', part.name_en = 'Hérodiade : Acte I, scène 1. « Alerte ! Levez‐vous ! Le palais est ouvert ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10346 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e0a582b7-74a0-40fb-ad19-3f5727ce1c15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0a582b7-74a0-40fb-ad19-3f5727ce1c15', 12, NULL, 'Acte I, scène 1. « Alerte ! Levez‐vous ! Le palais est ouvert ! » (Chœur)', 'Hérodiade : Acte I, scène 1. « Alerte ! Levez‐vous ! Le palais est ouvert ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ac2e511-7ea2-44a2-963a-db0cd2b750c7'
WHERE p.id = 10346 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0a582b7-74a0-40fb-ad19-3f5727ce1c15'
);


-- None 가곡 <Il pleuvait>

UPDATE pieces piece
SET piece.title = '가곡 <Il pleuvait>', piece.title_en = 'Il pleuvait',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8447 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je t'aime>

UPDATE pieces piece
SET piece.title = '가곡 <Je t''aime>', piece.title_en = 'Je t''aime',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10752 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jour de noces>

UPDATE pieces piece
SET piece.title = '가곡 <Jour de noces>', piece.title_en = 'Jour de noces',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10959 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Mélodie des baisers>

UPDATE pieces piece
SET piece.title = '가곡 <La Mélodie des baisers>', piece.title_en = 'La Mélodie des baisers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10004 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La Navarraise>

UPDATE pieces piece
SET piece.title = '오페라 <La Navarraise>', piece.title_en = 'La Navarraise',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8323 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'La Navarraise: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88', 1, NULL, 'Acte I', 'La Navarraise: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. Nocturne', part.name_en = 'La Navarraise : Acte I. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3d996609-5203-4f3b-b333-99cb2a2e8730' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d996609-5203-4f3b-b333-99cb2a2e8730', 1, NULL, 'Acte I. Nocturne', 'La Navarraise : Acte I. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d996609-5203-4f3b-b333-99cb2a2e8730'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Capitaine, je vois que vous appartenez » (Anita, Ramon)', part.name_en = 'La Navarraise : Acte I. « Capitaine, je vois que vous appartenez » (Anita, Ramon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4806588a-722a-4424-aa9d-2690df7995e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4806588a-722a-4424-aa9d-2690df7995e0', 2, NULL, 'Acte I. « Capitaine, je vois que vous appartenez » (Anita, Ramon)', 'La Navarraise : Acte I. « Capitaine, je vois que vous appartenez » (Anita, Ramon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4806588a-722a-4424-aa9d-2690df7995e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Je ne pensais qu’à toi » (Araquil, Anita)', part.name_en = 'La Navarraise : Acte I. « Je ne pensais qu’à toi » (Araquil, Anita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:55006188-719a-46fd-bdb4-d2ec5f39bd8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55006188-719a-46fd-bdb4-d2ec5f39bd8a', 3, NULL, 'Acte I. « Je ne pensais qu’à toi » (Araquil, Anita)', 'La Navarraise : Acte I. « Je ne pensais qu’à toi » (Araquil, Anita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55006188-719a-46fd-bdb4-d2ec5f39bd8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. « J’ai trois maisons dans Madrid » (Bustamente, Chœur)', part.name_en = 'La Navarraise : Acte I. « J’ai trois maisons dans Madrid » (Bustamente, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:55b9cdae-b259-4a36-9cc8-810db13d2331' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55b9cdae-b259-4a36-9cc8-810db13d2331', 4, NULL, 'Acte I. « J’ai trois maisons dans Madrid » (Bustamente, Chœur)', 'La Navarraise : Acte I. « J’ai trois maisons dans Madrid » (Bustamente, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55b9cdae-b259-4a36-9cc8-810db13d2331'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Morts ! Les vieux compagnons, les meilleurs ! » (Garrido, Anita, Ramon)', part.name_en = 'La Navarraise : Acte I. « Morts ! Les vieux compagnons, les meilleurs ! » (Garrido, Anita, Ramon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:67998d28-fc7d-45d9-a27a-49aba5a68804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67998d28-fc7d-45d9-a27a-49aba5a68804', 5, NULL, 'Acte I. « Morts ! Les vieux compagnons, les meilleurs ! » (Garrido, Anita, Ramon)', 'La Navarraise : Acte I. « Morts ! Les vieux compagnons, les meilleurs ! » (Garrido, Anita, Ramon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67998d28-fc7d-45d9-a27a-49aba5a68804'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Êtes‐vous de la compagnie » (Garrido, Araquil, Remigio, Anita)', part.name_en = 'La Navarraise : Acte I. « Êtes‐vous de la compagnie » (Garrido, Araquil, Remigio, Anita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:83c3d874-ec50-40c4-be0f-9b3a97998859' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83c3d874-ec50-40c4-be0f-9b3a97998859', 6, NULL, 'Acte I. « Êtes‐vous de la compagnie » (Garrido, Araquil, Remigio, Anita)', 'La Navarraise : Acte I. « Êtes‐vous de la compagnie » (Garrido, Araquil, Remigio, Anita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83c3d874-ec50-40c4-be0f-9b3a97998859'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Araquil ! – Mon père ! » (Remigio, Araquil, Anita)', part.name_en = 'La Navarraise : Acte I. « Araquil ! – Mon père ! » (Remigio, Araquil, Anita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a478cdc9-715c-41ae-b09e-e84e0b1e7e43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a478cdc9-715c-41ae-b09e-e84e0b1e7e43', 7, NULL, 'Acte I. « Araquil ! – Mon père ! » (Remigio, Araquil, Anita)', 'La Navarraise : Acte I. « Araquil ! – Mon père ! » (Remigio, Araquil, Anita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a478cdc9-715c-41ae-b09e-e84e0b1e7e43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. Prélude', part.name_en = 'La Navarraise: Acte I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b7f87c1e-4bd5-4bf6-83f1-97f220a9e04d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7f87c1e-4bd5-4bf6-83f1-97f220a9e04d', 8, NULL, 'Acte I. Prélude', 'La Navarraise: Acte I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7f87c1e-4bd5-4bf6-83f1-97f220a9e04d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Anita, la Navarraise ? » (Ramon, Araquil, Bustamente, Chœur)', part.name_en = 'La Navarraise : Acte I. « Anita, la Navarraise ? » (Ramon, Araquil, Bustamente, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c2583325-3b01-4472-97f3-1e2473960c63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2583325-3b01-4472-97f3-1e2473960c63', 9, NULL, 'Acte I. « Anita, la Navarraise ? » (Ramon, Araquil, Bustamente, Chœur)', 'La Navarraise : Acte I. « Anita, la Navarraise ? » (Ramon, Araquil, Bustamente, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2583325-3b01-4472-97f3-1e2473960c63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Depuis deux ans je l’aime ! » (Araquil, Anita, Remigio)', part.name_en = 'La Navarraise : Acte I. « Depuis deux ans je l’aime ! » (Araquil, Anita, Remigio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:cd2a9dc3-0350-487e-a6e9-19b4d9343db0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd2a9dc3-0350-487e-a6e9-19b4d9343db0', 10, NULL, 'Acte I. « Depuis deux ans je l’aime ! » (Araquil, Anita, Remigio)', 'La Navarraise : Acte I. « Depuis deux ans je l’aime ! » (Araquil, Anita, Remigio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd2a9dc3-0350-487e-a6e9-19b4d9343db0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Crénelons les maisons donnant sur la campagne » (Garrido, Chœur)', part.name_en = 'La Navarraise : Acte I. « Crénelons les maisons donnant sur la campagne » (Garrido, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d0bf946b-0eb3-4a2d-bd9e-eb39ae5725a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0bf946b-0eb3-4a2d-bd9e-eb39ae5725a8', 11, NULL, 'Acte I. « Crénelons les maisons donnant sur la campagne » (Garrido, Chœur)', 'La Navarraise : Acte I. « Crénelons les maisons donnant sur la campagne » (Garrido, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0bf946b-0eb3-4a2d-bd9e-eb39ae5725a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. « L’assaut a coûté cher, messieurs ! » (Garrido)', part.name_en = 'La Navarraise : Acte I. « L’assaut a coûté cher, messieurs ! » (Garrido)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fec03f15-f10c-4225-b1fb-43e151a440a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fec03f15-f10c-4225-b1fb-43e151a440a8', 12, NULL, 'Acte I. « L’assaut a coûté cher, messieurs ! » (Garrido)', 'La Navarraise : Acte I. « L’assaut a coûté cher, messieurs ! » (Garrido)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fec03f15-f10c-4225-b1fb-43e151a440a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ah ! Mariez donc son cœur avec mon cœur ! » (Anita, Remigio, Araquil)', part.name_en = 'La Navarraise : Acte I. « Ah ! Mariez donc son cœur avec mon cœur ! » (Anita, Remigio, Araquil)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ffc1b6a3-3aa8-407a-858a-c12044e72d7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffc1b6a3-3aa8-407a-858a-c12044e72d7c', 13, NULL, 'Acte I. « Ah ! Mariez donc son cœur avec mon cœur ! » (Anita, Remigio, Araquil)', 'La Navarraise : Acte I. « Ah ! Mariez donc son cœur avec mon cœur ! » (Anita, Remigio, Araquil)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc1b6a3-3aa8-407a-858a-c12044e72d7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ô bien‐aimée ! Pourquoi n’es‐tu pas là ? » (Araquil)', part.name_en = 'La Navarraise : Acte I. « Ô bien‐aimée ! Pourquoi n’es‐tu pas là ? » (Araquil)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ffe456ed-1410-4e88-a82d-37f24a07c1a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffe456ed-1410-4e88-a82d-37f24a07c1a8', 14, NULL, 'Acte I. « Ô bien‐aimée ! Pourquoi n’es‐tu pas là ? » (Araquil)', 'La Navarraise : Acte I. « Ô bien‐aimée ! Pourquoi n’es‐tu pas là ? » (Araquil)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1019b813-565a-4670-b9ac-f832e0e1cb88'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe456ed-1410-4e88-a82d-37f24a07c1a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'La Navarraise: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc', 2, NULL, 'Acte II', 'La Navarraise: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Mourir ! mourir par moi ! » (Anita, Araquil)', part.name_en = 'La Navarraise : Acte II. « Mourir ! mourir par moi ! » (Anita, Araquil)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2d52f610-81f6-4ffa-bc91-17be1e1f9124' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d52f610-81f6-4ffa-bc91-17be1e1f9124', 1, NULL, 'Acte II. « Mourir ! mourir par moi ! » (Anita, Araquil)', 'La Navarraise : Acte II. « Mourir ! mourir par moi ! » (Anita, Araquil)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d52f610-81f6-4ffa-bc91-17be1e1f9124'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Blessé, mourant, j’espère ! » (Araquil)', part.name_en = 'La Navarraise : Acte II. « Blessé, mourant, j’espère ! » (Araquil)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4261e90b-a454-43eb-9644-e5ed79bd09ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4261e90b-a454-43eb-9644-e5ed79bd09ba', 2, NULL, 'Acte II. « Blessé, mourant, j’espère ! » (Araquil)', 'La Navarraise : Acte II. « Blessé, mourant, j’espère ! » (Araquil)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4261e90b-a454-43eb-9644-e5ed79bd09ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Mon argent ! – Que dis‐tu ? » (Anita, Garrido)', part.name_en = 'La Navarraise : Acte II. « Mon argent ! – Que dis‐tu ? » (Anita, Garrido)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:478a0bdb-9cef-4f59-a4bc-59f1e004bc1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:478a0bdb-9cef-4f59-a4bc-59f1e004bc1a', 3, NULL, 'Acte II. « Mon argent ! – Que dis‐tu ? » (Anita, Garrido)', 'La Navarraise : Acte II. « Mon argent ! – Que dis‐tu ? » (Anita, Garrido)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:478a0bdb-9cef-4f59-a4bc-59f1e004bc1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Alerte ! Alerte ! » (Chœur)', part.name_en = 'La Navarraise : Acte II. « Alerte ! Alerte ! » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:84188817-8987-40e0-81d9-6e820378127c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84188817-8987-40e0-81d9-6e820378127c', 4, NULL, 'Acte II. « Alerte ! Alerte ! » (Chœur)', 'La Navarraise : Acte II. « Alerte ! Alerte ! » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84188817-8987-40e0-81d9-6e820378127c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Merci, la bonne Vierge ! » (Anita, Garrido)', part.name_en = 'La Navarraise : Acte II. « Merci, la bonne Vierge ! » (Anita, Garrido)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9d601210-481e-4431-9db8-d1cab573a966' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d601210-481e-4431-9db8-d1cab573a966', 5, NULL, 'Acte II. « Merci, la bonne Vierge ! » (Anita, Garrido)', 'La Navarraise : Acte II. « Merci, la bonne Vierge ! » (Anita, Garrido)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d601210-481e-4431-9db8-d1cab573a966'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Mon fils ! – Père ! » (Remigio, Araquil, Ramon, Anita)', part.name_en = 'La Navarraise : Acte II. « Mon fils ! – Père ! » (Remigio, Araquil, Ramon, Anita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d45c130e-3b96-44c3-a4c0-d2bb3b49d426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d45c130e-3b96-44c3-a4c0-d2bb3b49d426', 6, NULL, 'Acte II. « Mon fils ! – Père ! » (Remigio, Araquil, Ramon, Anita)', 'La Navarraise : Acte II. « Mon fils ! – Père ! » (Remigio, Araquil, Ramon, Anita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d45c130e-3b96-44c3-a4c0-d2bb3b49d426'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Voici ma dot ! » (Anita)', part.name_en = 'La Navarraise : Acte II. « Voici ma dot ! » (Anita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8323 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:fcf7f414-ef8b-40da-bb20-144cb5cf6edf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcf7f414-ef8b-40da-bb20-144cb5cf6edf', 7, NULL, 'Acte II. « Voici ma dot ! » (Anita)', 'La Navarraise : Acte II. « Voici ma dot ! » (Anita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9807c5cd-edce-43b6-9253-989f424368dc'
WHERE p.id = 8323 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf7f414-ef8b-40da-bb20-144cb5cf6edf'
);


-- None 가곡 <La Nuit>

UPDATE pieces piece
SET piece.title = '가곡 <La Nuit>', piece.title_en = 'La Nuit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9565 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <La Terre Promise>

UPDATE pieces piece
SET piece.title = '오라토리오 <La Terre Promise>', piece.title_en = 'La Terre Promise',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8298 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« Alors Moïse »', part.name_en = 'La Terre promise : « Alors Moïse »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:160b2cec-accc-4e65-b229-1428290dc910' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:160b2cec-accc-4e65-b229-1428290dc910', 1, NULL, '« Alors Moïse »', 'La Terre promise : « Alors Moïse »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:160b2cec-accc-4e65-b229-1428290dc910'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '« Que cette ville soit anathème »', part.name_en = 'La Terre promise : « Que cette ville soit anathème »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:27f2d746-1f99-416b-a8da-412ce17d1e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27f2d746-1f99-416b-a8da-412ce17d1e05', 2, NULL, '« Que cette ville soit anathème »', 'La Terre promise : « Que cette ville soit anathème »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27f2d746-1f99-416b-a8da-412ce17d1e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '« Peuple béni de dieu »', part.name_en = 'La Terre promise : « Peuple béni de dieu »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2e9392a7-bb0e-4976-a04b-bb3de05e5279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9392a7-bb0e-4976-a04b-bb3de05e5279', 3, NULL, '« Peuple béni de dieu »', 'La Terre promise : « Peuple béni de dieu »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9392a7-bb0e-4976-a04b-bb3de05e5279'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '« Maudit celui qui n’honore point son père »', part.name_en = 'La Terre promise : « Maudit celui qui n’honore point son père »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:46ad3288-860c-44d8-8aca-9f5b918759c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46ad3288-860c-44d8-8aca-9f5b918759c3', 4, NULL, '« Maudit celui qui n’honore point son père »', 'La Terre promise : « Maudit celui qui n’honore point son père »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ad3288-860c-44d8-8aca-9f5b918759c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pastorale', part.name_en = 'La Terre promise : Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:533afada-4f25-441b-bc8f-cbb3d4d9804d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:533afada-4f25-441b-bc8f-cbb3d4d9804d', 5, NULL, 'Pastorale', 'La Terre promise : Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:533afada-4f25-441b-bc8f-cbb3d4d9804d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '« Gloire à dieu ! »', part.name_en = 'La Terre promise : « Gloire à dieu ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:53d91446-4b59-4d01-87e6-3732c4319309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d91446-4b59-4d01-87e6-3732c4319309', 6, NULL, '« Gloire à dieu ! »', 'La Terre promise : « Gloire à dieu ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d91446-4b59-4d01-87e6-3732c4319309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '« Lors Josué »', part.name_en = 'La Terre promise : « Lors Josué »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7a85ac52-a360-4d57-a2b9-f8f97c925a03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a85ac52-a360-4d57-a2b9-f8f97c925a03', 7, NULL, '« Lors Josué »', 'La Terre promise : « Lors Josué »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a85ac52-a360-4d57-a2b9-f8f97c925a03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Marche du septième jour', part.name_en = 'La Terre promise : Marche du septième jour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:91dc9eeb-a594-4ebb-b822-1a3131c5f5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91dc9eeb-a594-4ebb-b822-1a3131c5f5ce', 8, NULL, 'Marche du septième jour', 'La Terre promise : Marche du septième jour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91dc9eeb-a594-4ebb-b822-1a3131c5f5ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '« Obéissez et vous serez béni »', part.name_en = 'La Terre promise : « Obéissez et vous serez béni »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ae075d4e-99e6-4d9a-bd86-81af4903b31c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae075d4e-99e6-4d9a-bd86-81af4903b31c', 9, NULL, '« Obéissez et vous serez béni »', 'La Terre promise : « Obéissez et vous serez béni »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae075d4e-99e6-4d9a-bd86-81af4903b31c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '« Cependant, Jéricho était fermée »', part.name_en = 'La Terre promise : « Cependant, Jéricho était fermée »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d1792c16-29ee-4eb0-aa68-ff6d3a30825e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1792c16-29ee-4eb0-aa68-ff6d3a30825e', 10, NULL, '« Cependant, Jéricho était fermée »', 'La Terre promise : « Cependant, Jéricho était fermée »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1792c16-29ee-4eb0-aa68-ff6d3a30825e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '« Écoutez, écoutez Israël »', part.name_en = 'La Terre promise : « Écoutez, écoutez Israël »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e2e973f5-fc71-4386-822b-5d167d8cb200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2e973f5-fc71-4386-822b-5d167d8cb200', 11, NULL, '« Écoutez, écoutez Israël »', 'La Terre promise : « Écoutez, écoutez Israël »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2e973f5-fc71-4386-822b-5d167d8cb200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '« Les Israëlites étant au deça du Jourdain »', part.name_en = 'La Terre promise : « Les Israëlites étant au deça du Jourdain »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eb0f8b86-f30c-46da-838c-b67fdda3fa15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb0f8b86-f30c-46da-838c-b67fdda3fa15', 12, NULL, '« Les Israëlites étant au deça du Jourdain »', 'La Terre promise : « Les Israëlites étant au deça du Jourdain »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb0f8b86-f30c-46da-838c-b67fdda3fa15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '« De vos yeux vous avez vu »', part.name_en = 'La Terre promise : « De vos yeux vous avez vu »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8298 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f9bda054-2a7e-4add-bc42-71d69845a132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bda054-2a7e-4add-bc42-71d69845a132', 13, NULL, '« De vos yeux vous avez vu »', 'La Terre promise : « De vos yeux vous avez vu »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8298 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bda054-2a7e-4add-bc42-71d69845a132'
);


-- None 부수음악 <La Vie de bohème>

UPDATE pieces piece
SET piece.title = '부수음악 <La Vie de bohème>', piece.title_en = 'La Vie de bohème',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9641 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Chanson de Musette', part.name_en = 'La Chanson de Musette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9641 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f2621bd9-8bd4-49eb-bb5c-0ca449e5120e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2621bd9-8bd4-49eb-bb5c-0ca449e5120e', 1, NULL, 'La Chanson de Musette', 'La Chanson de Musette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9641 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2621bd9-8bd4-49eb-bb5c-0ca449e5120e'
);


-- None 오라토리오 <La Vierge>

UPDATE pieces piece
SET piece.title = '오라토리오 <La Vierge>', piece.title_en = 'La Vierge',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8548 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 4. The Assumption: Dernier sommeil de la Vierge', part.name_en = 'La Vierge: Scene 4. The Assumption: Dernier sommeil de la Vierge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8548 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1725fb24-547a-42e3-8071-d9e6a515546f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1725fb24-547a-42e3-8071-d9e6a515546f', 1, NULL, 'Scene 4. The Assumption: Dernier sommeil de la Vierge', 'La Vierge: Scene 4. The Assumption: Dernier sommeil de la Vierge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8548 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1725fb24-547a-42e3-8071-d9e6a515546f'
);


-- None La Vierge, danse galiléenne

UPDATE pieces piece
SET piece.title = 'La Vierge, danse galiléenne', piece.title_en = 'La Vierge, danse galiléenne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8874 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Larmes maternelles>

UPDATE pieces piece
SET piece.title = '가곡 <Larmes maternelles>', piece.title_en = 'Larmes maternelles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10705 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Le Carillon>

UPDATE pieces piece
SET piece.title = '발레 <Le Carillon>', piece.title_en = 'Le Carillon',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7772 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Valse au cabaret', part.name_en = 'Le Carillon: Valse au cabaret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7772 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:07f10a74-9cfe-4c7e-9066-a2466cdf203c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f10a74-9cfe-4c7e-9066-a2466cdf203c', 1, NULL, 'Valse au cabaret', 'Le Carillon: Valse au cabaret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7772 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f10a74-9cfe-4c7e-9066-a2466cdf203c'
);


-- None 오페라 <Le Cid>

UPDATE pieces piece
SET piece.title = '오페라 <Le Cid>', piece.title_en = 'Le Cid',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8024 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Cid : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6', 1, NULL, 'Acte I', 'Le Cid : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Écoutez la joyeuse fanfare » (Seigneurs, Don Arias, Don Alonzo, Comte de Gormaz, Chimène)', part.name_en = 'Le Cid : Acte I, scène 1. « Écoutez la joyeuse fanfare » (Seigneurs, Don Arias, Don Alonzo, Comte de Gormaz, Chimène)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:46598d2e-eb0b-45dc-b702-13ba09fa3c6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46598d2e-eb0b-45dc-b702-13ba09fa3c6a', 1, NULL, 'scène 1. « Écoutez la joyeuse fanfare » (Seigneurs, Don Arias, Don Alonzo, Comte de Gormaz, Chimène)', 'Le Cid : Acte I, scène 1. « Écoutez la joyeuse fanfare » (Seigneurs, Don Arias, Don Alonzo, Comte de Gormaz, Chimène)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46598d2e-eb0b-45dc-b702-13ba09fa3c6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Aimer ! Je puis aimer librement, devant tous ! » (Chimène, l''Infante)', part.name_en = 'Le Cid : Acte I, scène 1. « Aimer ! Je puis aimer librement, devant tous ! » (Chimène, l''Infante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6ecc54d2-953e-4530-bddf-d0e4b0ec7aae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ecc54d2-953e-4530-bddf-d0e4b0ec7aae', 2, NULL, 'scène 1. « Aimer ! Je puis aimer librement, devant tous ! » (Chimène, l''Infante)', 'Le Cid : Acte I, scène 1. « Aimer ! Je puis aimer librement, devant tous ! » (Chimène, l''Infante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ecc54d2-953e-4530-bddf-d0e4b0ec7aae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 1. No. 1 Duo « Laissez le doute dans mon âme… » (Chimène, l''Infante)', part.name_en = 'Le Cid : Acte I, scène 1. No. 1 Duo « Laissez le doute dans mon âme… » (Chimène, l''Infante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6a5bfba2-a156-41a4-9bee-83cbafe5fd26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a5bfba2-a156-41a4-9bee-83cbafe5fd26', 3, NULL, 'scène 1. No. 1 Duo « Laissez le doute dans mon âme… » (Chimène, l''Infante)', 'Le Cid : Acte I, scène 1. No. 1 Duo « Laissez le doute dans mon âme… » (Chimène, l''Infante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a5bfba2-a156-41a4-9bee-83cbafe5fd26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Béni soit le nom du Seigneur » (Le peuple, le Roi, Don Diègue, Chimène, l''Infante, le Comte)', part.name_en = 'Le Cid : Acte I, scène 2. « Béni soit le nom du Seigneur » (Le peuple, le Roi, Don Diègue, Chimène, l''Infante, le Comte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e1eb5ee5-c991-40c3-8681-56b8ebbd8fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1eb5ee5-c991-40c3-8681-56b8ebbd8fc9', 4, NULL, 'scène 2. « Béni soit le nom du Seigneur » (Le peuple, le Roi, Don Diègue, Chimène, l''Infante, le Comte)', 'Le Cid : Acte I, scène 2. « Béni soit le nom du Seigneur » (Le peuple, le Roi, Don Diègue, Chimène, l''Infante, le Comte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1eb5ee5-c991-40c3-8681-56b8ebbd8fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Jurez‐vous d’être bon chevalier ? » (Le Roi, Rodrigue, chœur)', part.name_en = 'Le Cid : Acte I, scène 2. « Jurez‐vous d’être bon chevalier ? » (Le Roi, Rodrigue, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b5603bbb-bd79-4f5e-bed1-8f899fec85b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5603bbb-bd79-4f5e-bed1-8f899fec85b7', 5, NULL, 'scène 2. « Jurez‐vous d’être bon chevalier ? » (Le Roi, Rodrigue, chœur)', 'Le Cid : Acte I, scène 2. « Jurez‐vous d’être bon chevalier ? » (Le Roi, Rodrigue, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5603bbb-bd79-4f5e-bed1-8f899fec85b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 2 Air « Ô noble lame étincelante » (Rodrigue)', part.name_en = 'Le Cid : Acte I, scène 2. No. 2 Air « Ô noble lame étincelante » (Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:527c8f02-5143-445c-9523-5dcde410705e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:527c8f02-5143-445c-9523-5dcde410705e', 6, NULL, 'scène 2. No. 2 Air « Ô noble lame étincelante » (Rodrigue)', 'Le Cid : Acte I, scène 2. No. 2 Air « Ô noble lame étincelante » (Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:527c8f02-5143-445c-9523-5dcde410705e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'scène 2. « À St. Jacques de Compostelle » (Rodrigue, Chimène, le Roi, chœur, Don Diègue, Comte)', part.name_en = 'Le Cid : Acte I, scène 2. « À St. Jacques de Compostelle » (Rodrigue, Chimène, le Roi, chœur, Don Diègue, Comte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:34d3e856-1c80-453e-a5e9-0c21a1cf2dbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34d3e856-1c80-453e-a5e9-0c21a1cf2dbd', 7, NULL, 'scène 2. « À St. Jacques de Compostelle » (Rodrigue, Chimène, le Roi, chœur, Don Diègue, Comte)', 'Le Cid : Acte I, scène 2. « À St. Jacques de Compostelle » (Rodrigue, Chimène, le Roi, chœur, Don Diègue, Comte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34d3e856-1c80-453e-a5e9-0c21a1cf2dbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Ainsi vous l’emportez ! … » (Comte, Don Diègue, seigneurs)', part.name_en = 'Le Cid : Acte I, scène 2. « Ainsi vous l’emportez ! … » (Comte, Don Diègue, seigneurs)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1c6ce85c-ff75-4da6-9af7-81b6a29e3203' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c6ce85c-ff75-4da6-9af7-81b6a29e3203', 8, NULL, 'scène 2. « Ainsi vous l’emportez ! … » (Comte, Don Diègue, seigneurs)', 'Le Cid : Acte I, scène 2. « Ainsi vous l’emportez ! … » (Comte, Don Diègue, seigneurs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c6ce85c-ff75-4da6-9af7-81b6a29e3203'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 3 Air « Ô rage, ô désespoir, ô vieillesse ennemie … » (Don Diègue, Rodrigue)', part.name_en = 'Le Cid : Acte I, scène 2. No. 3 Air « Ô rage, ô désespoir, ô vieillesse ennemie … » (Don Diègue, Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2a3c88ef-3f62-47f0-a938-3ba14d50d9c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a3c88ef-3f62-47f0-a938-3ba14d50d9c7', 9, NULL, 'scène 2. No. 3 Air « Ô rage, ô désespoir, ô vieillesse ennemie … » (Don Diègue, Rodrigue)', 'Le Cid : Acte I, scène 2. No. 3 Air « Ô rage, ô désespoir, ô vieillesse ennemie … » (Don Diègue, Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a3c88ef-3f62-47f0-a938-3ba14d50d9c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 4 Duo « Rodrigue, as‐tu du cœur ?… » (Don Diègue, Rodrigue, Chimène)', part.name_en = 'Le Cid : Acte I, scène 2. No. 4 Duo « Rodrigue, as‐tu du cœur ?… » (Don Diègue, Rodrigue, Chimène)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b723116a-2179-43a2-8d3f-5ecdee128c45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b723116a-2179-43a2-8d3f-5ecdee128c45', 10, NULL, 'scène 2. No. 4 Duo « Rodrigue, as‐tu du cœur ?… » (Don Diègue, Rodrigue, Chimène)', 'Le Cid : Acte I, scène 2. No. 4 Duo « Rodrigue, as‐tu du cœur ?… » (Don Diègue, Rodrigue, Chimène)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b167545e-075d-4f7a-8ec6-ebbffd6fe9c6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b723116a-2179-43a2-8d3f-5ecdee128c45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Le Cid : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03', 2, NULL, 'Acte II', 'Le Cid : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 1. No. 6 Duo « À moi, comte, deux mots … » (Rodrigue, Comte, Don Diègue, chœur)', part.name_en = 'Le Cid : Acte II, scène 1. No. 6 Duo « À moi, comte, deux mots … » (Rodrigue, Comte, Don Diègue, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:87a0bfc2-3c2d-4aae-8a58-967ba16f7880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87a0bfc2-3c2d-4aae-8a58-967ba16f7880', 1, NULL, 'scène 1. No. 6 Duo « À moi, comte, deux mots … » (Rodrigue, Comte, Don Diègue, chœur)', 'Le Cid : Acte II, scène 1. No. 6 Duo « À moi, comte, deux mots … » (Rodrigue, Comte, Don Diègue, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87a0bfc2-3c2d-4aae-8a58-967ba16f7880'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Quand vous revient l’honneur ravi … » (Rodrigue, Don Diègue, Chimène, chœur)', part.name_en = 'Le Cid : Acte II, scène 1. « Quand vous revient l’honneur ravi … » (Rodrigue, Don Diègue, Chimène, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8a2c8a59-db22-4490-99e9-69b1f35ee219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a2c8a59-db22-4490-99e9-69b1f35ee219', 2, NULL, 'scène 1. « Quand vous revient l’honneur ravi … » (Rodrigue, Don Diègue, Chimène, chœur)', 'Le Cid : Acte II, scène 1. « Quand vous revient l’honneur ravi … » (Rodrigue, Don Diègue, Chimène, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a2c8a59-db22-4490-99e9-69b1f35ee219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 7 Air « Plus de tourments et plus de peine » (L’Infante, chœur)', part.name_en = 'Le Cid : Acte II, scène 2. No. 7 Air « Plus de tourments et plus de peine » (L’Infante, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a3ac79bf-c392-40aa-9a02-c954f3aa3211' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3ac79bf-c392-40aa-9a02-c954f3aa3211', 3, NULL, 'scène 2. No. 7 Air « Plus de tourments et plus de peine » (L’Infante, chœur)', 'Le Cid : Acte II, scène 2. No. 7 Air « Plus de tourments et plus de peine » (L’Infante, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3ac79bf-c392-40aa-9a02-c954f3aa3211'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 2. Ballet', part.name_en = 'Le Cid : Acte II, scène 2. Ballet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4827525e-3e91-4ba9-a8ad-704d1b8e568b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4827525e-3e91-4ba9-a8ad-704d1b8e568b', 4, NULL, 'scène 2. Ballet', 'Le Cid : Acte II, scène 2. Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4827525e-3e91-4ba9-a8ad-704d1b8e568b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ballet: I. Castillane', part.name_en = 'Le Cid: Ballet: I. Castillane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ea5c6658-1d1c-4485-8a21-4f6971f5f540' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea5c6658-1d1c-4485-8a21-4f6971f5f540', 5, NULL, 'Ballet: I. Castillane', 'Le Cid: Ballet: I. Castillane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5c6658-1d1c-4485-8a21-4f6971f5f540'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ballet: IV. Aubade', part.name_en = 'Le Cid: Ballet: IV. Aubade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ecb9be36-71ae-4174-af06-75a64bf4cdeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecb9be36-71ae-4174-af06-75a64bf4cdeb', 6, NULL, 'Ballet: IV. Aubade', 'Le Cid: Ballet: IV. Aubade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb9be36-71ae-4174-af06-75a64bf4cdeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ballet: V. Catalane', part.name_en = 'Le Cid: Ballet: V. Catalane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2f5f02cd-1912-4feb-8f06-2d7dbf42785c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f5f02cd-1912-4feb-8f06-2d7dbf42785c', 7, NULL, 'Ballet: V. Catalane', 'Le Cid: Ballet: V. Catalane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f5f02cd-1912-4feb-8f06-2d7dbf42785c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ballet: VII. Navarraise', part.name_en = 'Le Cid: Ballet: VII. Navarraise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9b95f199-5ff6-4eac-9824-862c2006e030' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b95f199-5ff6-4eac-9824-862c2006e030', 8, NULL, 'Ballet: VII. Navarraise', 'Le Cid: Ballet: VII. Navarraise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b95f199-5ff6-4eac-9824-862c2006e030'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Le roi ! Le roi ! » … No. 8 Air « Lorsque j’irai dans l’ombre » (Chœur, Chimène, le Roi)', part.name_en = 'Le Cid : Acte II, scène 2. « Le roi ! Le roi ! » … No. 8 Air « Lorsque j’irai dans l’ombre » (Chœur, Chimène, le Roi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:83bbf70b-1bde-47f7-8d21-a5ed37e11386' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83bbf70b-1bde-47f7-8d21-a5ed37e11386', 9, NULL, 'scène 2. « Le roi ! Le roi ! » … No. 8 Air « Lorsque j’irai dans l’ombre » (Chœur, Chimène, le Roi)', 'Le Cid : Acte II, scène 2. « Le roi ! Le roi ! » … No. 8 Air « Lorsque j’irai dans l’ombre » (Chœur, Chimène, le Roi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83bbf70b-1bde-47f7-8d21-a5ed37e11386'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Vous, Don Diègue, parlez ! » … No. 9 Air « Qu’on est digne d’envie » (Le Roi, Don Diègue, l''Infante, chœur)', part.name_en = 'Le Cid : Acte II, scène 2. « Vous, Don Diègue, parlez ! » … No. 9 Air « Qu’on est digne d’envie » (Le Roi, Don Diègue, l''Infante, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6b583112-c9b2-4cb1-93b0-51dab37afeeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b583112-c9b2-4cb1-93b0-51dab37afeeb', 10, NULL, 'scène 2. « Vous, Don Diègue, parlez ! » … No. 9 Air « Qu’on est digne d’envie » (Le Roi, Don Diègue, l''Infante, chœur)', 'Le Cid : Acte II, scène 2. « Vous, Don Diègue, parlez ! » … No. 9 Air « Qu’on est digne d’envie » (Le Roi, Don Diègue, l''Infante, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b583112-c9b2-4cb1-93b0-51dab37afeeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Ô tourment de la voir ! » (Rodrigue, Chimène, Don Diègue, l''Infante, le Roi, l''Envoyé maure, chœur)', part.name_en = 'Le Cid : Acte II, scène 2. « Ô tourment de la voir ! » (Rodrigue, Chimène, Don Diègue, l''Infante, le Roi, l''Envoyé maure, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:352f931b-5b33-429c-a866-618f7fb13863' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:352f931b-5b33-429c-a866-618f7fb13863', 11, NULL, 'scène 2. « Ô tourment de la voir ! » (Rodrigue, Chimène, Don Diègue, l''Infante, le Roi, l''Envoyé maure, chœur)', 'Le Cid : Acte II, scène 2. « Ô tourment de la voir ! » (Rodrigue, Chimène, Don Diègue, l''Infante, le Roi, l''Envoyé maure, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352f931b-5b33-429c-a866-618f7fb13863'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'scène 1. No. 5 Stances « Percé jusqu’au fond du cœur » (Rodrigue)', part.name_en = 'Le Cid : Acte II, scène 1. No. 5 Stances « Percé jusqu’au fond du cœur » (Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b6db025e-c991-46ba-8446-0886239ebc82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6db025e-c991-46ba-8446-0886239ebc82', 12, NULL, 'scène 1. No. 5 Stances « Percé jusqu’au fond du cœur » (Rodrigue)', 'Le Cid : Acte II, scène 1. No. 5 Stances « Percé jusqu’au fond du cœur » (Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:794275a5-a7cf-48c1-a87b-c23a09c28e03'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6db025e-c991-46ba-8446-0886239ebc82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Cid : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8', 3, NULL, 'Acte III', 'Le Cid : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 1. Entracte', part.name_en = 'Le Cid : Acte III, scène 1. Entracte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:51f1891c-8ee6-4177-ac74-c1a29ee02a2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51f1891c-8ee6-4177-ac74-c1a29ee02a2e', 1, NULL, 'scène 1. Entracte', 'Le Cid : Acte III, scène 1. Entracte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f1891c-8ee6-4177-ac74-c1a29ee02a2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. « De cet affreux combat je sors l’âme brisée ! » (Chimène)', part.name_en = 'Le Cid : Acte III, scène 1. « De cet affreux combat je sors l’âme brisée ! » (Chimène)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b36fbf64-a763-4867-a671-64d4f78363df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b36fbf64-a763-4867-a671-64d4f78363df', 2, NULL, 'scène 1. « De cet affreux combat je sors l’âme brisée ! » (Chimène)', 'Le Cid : Acte III, scène 1. « De cet affreux combat je sors l’âme brisée ! » (Chimène)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b36fbf64-a763-4867-a671-64d4f78363df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 1. No. 10 Air « Pleurez ! pleurez mes yeux » (Chimène)', part.name_en = 'Le Cid : Acte III, scène 1. No. 10 Air « Pleurez ! pleurez mes yeux » (Chimène)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a50a4451-8657-4237-8a0b-d48c752f45d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a50a4451-8657-4237-8a0b-d48c752f45d0', 3, NULL, 'scène 1. No. 10 Air « Pleurez ! pleurez mes yeux » (Chimène)', 'Le Cid : Acte III, scène 1. No. 10 Air « Pleurez ! pleurez mes yeux » (Chimène)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a50a4451-8657-4237-8a0b-d48c752f45d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Rodrigue, toi dans cette demeure » … No. 11 Duo « Ô jours de première tendresse » (Chimène, Rodrigue)', part.name_en = 'Le Cid : Acte III, scène 1. « Rodrigue, toi dans cette demeure » … No. 11 Duo « Ô jours de première tendresse » (Chimène, Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f5426753-3c92-418d-a4e0-e6254b99a322' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5426753-3c92-418d-a4e0-e6254b99a322', 4, NULL, 'scène 1. « Rodrigue, toi dans cette demeure » … No. 11 Duo « Ô jours de première tendresse » (Chimène, Rodrigue)', 'Le Cid : Acte III, scène 1. « Rodrigue, toi dans cette demeure » … No. 11 Duo « Ô jours de première tendresse » (Chimène, Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5426753-3c92-418d-a4e0-e6254b99a322'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 1. « Mourir ! Tu vas mourir… » (Chimène, Rodrigue)', part.name_en = 'Le Cid : Acte III, scène 1. « Mourir ! Tu vas mourir… » (Chimène, Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:84a66fb1-c23e-49da-9682-ddc9d2ebd053' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84a66fb1-c23e-49da-9682-ddc9d2ebd053', 5, NULL, 'scène 1. « Mourir ! Tu vas mourir… » (Chimène, Rodrigue)', 'Le Cid : Acte III, scène 1. « Mourir ! Tu vas mourir… » (Chimène, Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a66fb1-c23e-49da-9682-ddc9d2ebd053'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 12 Chœur « Vivons sans peur et sans remords ! » (Chœur, Rodrigue)', part.name_en = 'Le Cid : Acte III, scène 2. No. 12 Chœur « Vivons sans peur et sans remords ! » (Chœur, Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3d5a68fb-7d40-49f8-bc5d-3278fc4163c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d5a68fb-7d40-49f8-bc5d-3278fc4163c4', 6, NULL, 'scène 2. No. 12 Chœur « Vivons sans peur et sans remords ! » (Chœur, Rodrigue)', 'Le Cid : Acte III, scène 2. No. 12 Chœur « Vivons sans peur et sans remords ! » (Chœur, Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5a68fb-7d40-49f8-bc5d-3278fc4163c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'scène 3. « Ah ! tout est bien fini » ... No. 13 Prière « Ô souverain, ô juge, ô père » (Rodrigue, Saint Jacques, voix du ciel)', part.name_en = 'Le Cid : Acte III, scène 3. « Ah ! tout est bien fini » ... No. 13 Prière « Ô souverain, ô juge, ô père » (Rodrigue, Saint Jacques, voix du ciel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ee5656ea-2bcf-348e-8b4d-b860671b3ec3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee5656ea-2bcf-348e-8b4d-b860671b3ec3', 7, NULL, 'scène 3. « Ah ! tout est bien fini » ... No. 13 Prière « Ô souverain, ô juge, ô père » (Rodrigue, Saint Jacques, voix du ciel)', 'Le Cid : Acte III, scène 3. « Ah ! tout est bien fini » ... No. 13 Prière « Ô souverain, ô juge, ô père » (Rodrigue, Saint Jacques, voix du ciel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee5656ea-2bcf-348e-8b4d-b860671b3ec3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'scène 4. « Alerte, amis » … « Ô noble lame étincelante » (Chœur, Rodrigue)', part.name_en = 'Le Cid : Acte III, scène 4. « Alerte, amis » … « Ô noble lame étincelante » (Chœur, Rodrigue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9fb1fb2b-6925-4d03-b46a-11a9a0971d72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fb1fb2b-6925-4d03-b46a-11a9a0971d72', 8, NULL, 'scène 4. « Alerte, amis » … « Ô noble lame étincelante » (Chœur, Rodrigue)', 'Le Cid : Acte III, scène 4. « Alerte, amis » … « Ô noble lame étincelante » (Chœur, Rodrigue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03727432-8b31-4cdd-82f8-5b575933cde8'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fb1fb2b-6925-4d03-b46a-11a9a0971d72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Le Cid : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6', 4, NULL, 'Acte IV', 'Le Cid : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'scène 1. Entracte', part.name_en = 'Le Cid : Acte IV, scène 1. Entracte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:68bb7f0c-c2da-4eb3-9c4a-bf6eea988673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68bb7f0c-c2da-4eb3-9c4a-bf6eea988673', 1, NULL, 'scène 1. Entracte', 'Le Cid : Acte IV, scène 1. Entracte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68bb7f0c-c2da-4eb3-9c4a-bf6eea988673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'scène 1. No. 14 Air « Ainsi mon fils est mort … » (Don Diègue, l''Infante, Chimène, le Roi)', part.name_en = 'Le Cid : Acte IV, scène 1. No. 14 Air « Ainsi mon fils est mort … » (Don Diègue, l''Infante, Chimène, le Roi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a52c4914-3a6a-4a18-ba06-82762d333266' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a52c4914-3a6a-4a18-ba06-82762d333266', 2, NULL, 'scène 1. No. 14 Air « Ainsi mon fils est mort … » (Don Diègue, l''Infante, Chimène, le Roi)', 'Le Cid : Acte IV, scène 1. No. 14 Air « Ainsi mon fils est mort … » (Don Diègue, l''Infante, Chimène, le Roi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a52c4914-3a6a-4a18-ba06-82762d333266'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Gloire à celui que les Rois Maures … » (Chœur)', part.name_en = 'Le Cid : Acte IV, scène 2. « Gloire à celui que les Rois Maures … » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a09caec8-a67d-4c94-81b4-a131ac7e87af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a09caec8-a67d-4c94-81b4-a131ac7e87af', 3, NULL, 'scène 2. « Gloire à celui que les Rois Maures … » (Chœur)', 'Le Cid : Acte IV, scène 2. « Gloire à celui que les Rois Maures … » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a09caec8-a67d-4c94-81b4-a131ac7e87af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'scène 2. « Ô roi ! C’est de ta main que je tiens » (Rodrigue, le Roi, Chimène, Chœur)', part.name_en = 'Le Cid : Acte IV, scène 2. « Ô roi ! C’est de ta main que je tiens » (Rodrigue, le Roi, Chimène, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d608d527-15f5-4d8c-bf0f-38c3ee8fa789' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d608d527-15f5-4d8c-bf0f-38c3ee8fa789', 4, NULL, 'scène 2. « Ô roi ! C’est de ta main que je tiens » (Rodrigue, le Roi, Chimène, Chœur)', 'Le Cid : Acte IV, scène 2. « Ô roi ! C’est de ta main que je tiens » (Rodrigue, le Roi, Chimène, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d608d527-15f5-4d8c-bf0f-38c3ee8fa789'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'scène 2. No. 15 « Que je réponde … » (Chimène, le Roi, Rodrigue, l''Infante, Don Diègue, chœur)', part.name_en = 'Le Cid : Acte IV, scène 2. No. 15 « Que je réponde … » (Chimène, le Roi, Rodrigue, l''Infante, Don Diègue, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d011e340-b9bf-4f83-8c8e-e489a9abfac2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d011e340-b9bf-4f83-8c8e-e489a9abfac2', 5, NULL, 'scène 2. No. 15 « Que je réponde … » (Chimène, le Roi, Rodrigue, l''Infante, Don Diègue, chœur)', 'Le Cid : Acte IV, scène 2. No. 15 « Que je réponde … » (Chimène, le Roi, Rodrigue, l''Infante, Don Diègue, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55418a84-9066-4ab3-bc93-9c8339d0f1d6'
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d011e340-b9bf-4f83-8c8e-e489a9abfac2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Le Cid - Opera in four acts: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8024 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bb2dfa25-029d-4e1c-bada-ab517a2d3a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb2dfa25-029d-4e1c-bada-ab517a2d3a45', 5, NULL, 'Overture', 'Le Cid - Opera in four acts: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8024 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb2dfa25-029d-4e1c-bada-ab517a2d3a45'
);


-- None 아리아 <Le Cid: Akt III. „Ach! Alles sinkt hinab - Du, den ich stets im Sinn getragen”>

UPDATE pieces piece
SET piece.title = '아리아 <Le Cid: Akt III. „Ach! Alles sinkt hinab - Du, den ich stets im Sinn getragen”>', piece.title_en = 'Le Cid: Akt III. „Ach! Alles sinkt hinab - Du, den ich stets im Sinn getragen”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8518 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Le Jongleur de Notre-Dame>

UPDATE pieces piece
SET piece.title = '오페라 <Le Jongleur de Notre-Dame>', piece.title_en = 'Le Jongleur de Notre-Dame',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10544 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Jongleur de Notre-Dame : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f', 1, NULL, 'Acte I', 'Le Jongleur de Notre-Dame : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Pour la vierge d’abord »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Pour la vierge d’abord »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:20f9476a-dbdc-446a-98ae-585414efd1cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20f9476a-dbdc-446a-98ae-585414efd1cb', 1, NULL, 'Acte I. « Pour la vierge d’abord »', 'Le Jongleur de Notre‐Dame : Acte I. « Pour la vierge d’abord »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20f9476a-dbdc-446a-98ae-585414efd1cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Ô liberté ma mie »', part.name_en = 'Le Jongleur de Notre-Dame : Acte I. « Ô liberté ma mie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:23abb05e-d8f1-4e7e-84f5-e2337787718f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23abb05e-d8f1-4e7e-84f5-e2337787718f', 2, NULL, 'Acte I. « Ô liberté ma mie »', 'Le Jongleur de Notre-Dame : Acte I. « Ô liberté ma mie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23abb05e-d8f1-4e7e-84f5-e2337787718f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Place au roi des jongleurs »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Place au roi des jongleurs »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3c69b97a-7d7a-4e7a-9479-a8e4a31b664d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c69b97a-7d7a-4e7a-9479-a8e4a31b664d', 3, NULL, 'Acte I. « Place au roi des jongleurs »', 'Le Jongleur de Notre‐Dame : Acte I. « Place au roi des jongleurs »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c69b97a-7d7a-4e7a-9479-a8e4a31b664d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Hors d’ici, troupe infâme »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Hors d’ici, troupe infâme »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:49c387cd-4eef-47bc-a49a-23f45fcf7e51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49c387cd-4eef-47bc-a49a-23f45fcf7e51', 4, NULL, 'Acte I. « Hors d’ici, troupe infâme »', 'Le Jongleur de Notre‐Dame : Acte I. « Hors d’ici, troupe infâme »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c387cd-4eef-47bc-a49a-23f45fcf7e51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. « C’est un accord de vièle » … « Un jongleur »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « C’est un accord de vièle » … « Un jongleur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5286cbe5-e743-44fd-8cc1-fb41f01cc19b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5286cbe5-e743-44fd-8cc1-fb41f01cc19b', 5, NULL, 'Acte I. « C’est un accord de vièle » … « Un jongleur »', 'Le Jongleur de Notre‐Dame : Acte I. « C’est un accord de vièle » … « Un jongleur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5286cbe5-e743-44fd-8cc1-fb41f01cc19b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Belle maîtresse en vérité »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Belle maîtresse en vérité »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:78c724cb-b582-470d-9466-3115d7ff6bf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78c724cb-b582-470d-9466-3115d7ff6bf6', 6, NULL, 'Acte I. « Belle maîtresse en vérité »', 'Le Jongleur de Notre‐Dame : Acte I. « Belle maîtresse en vérité »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c724cb-b582-470d-9466-3115d7ff6bf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. Boniment: « Voulez‐vous des tours de jonglerie »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. Boniment: « Voulez‐vous des tours de jonglerie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8ecc31fd-198c-4654-ba6f-1ab076669968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ecc31fd-198c-4654-ba6f-1ab076669968', 7, NULL, 'Acte I. Boniment: « Voulez‐vous des tours de jonglerie »', 'Le Jongleur de Notre‐Dame : Acte I. Boniment: « Voulez‐vous des tours de jonglerie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ecc31fd-198c-4654-ba6f-1ab076669968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. Le benedicite: « À table! Et qu’un bon déjeuner »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. Le benedicite: « À table! Et qu’un bon déjeuner »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a08ff92e-fb02-458f-86a9-72a650f97c72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a08ff92e-fb02-458f-86a9-72a650f97c72', 8, NULL, 'Acte I. Le benedicite: « À table! Et qu’un bon déjeuner »', 'Le Jongleur de Notre‐Dame : Acte I. Le benedicite: « À table! Et qu’un bon déjeuner »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a08ff92e-fb02-458f-86a9-72a650f97c72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Dansez la bergerette »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Dansez la bergerette »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d17e6e71-d06e-43ee-9c58-db785fdbeae3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d17e6e71-d06e-43ee-9c58-db785fdbeae3', 9, NULL, 'Acte I. « Dansez la bergerette »', 'Le Jongleur de Notre‐Dame : Acte I. « Dansez la bergerette »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17e6e71-d06e-43ee-9c58-db785fdbeae3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Gentil roi, choisis ta reine »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Gentil roi, choisis ta reine »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e9e9866b-bdd2-40c1-ad7c-957a49582f3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9e9866b-bdd2-40c1-ad7c-957a49582f3d', 10, NULL, 'Acte I. « Gentil roi, choisis ta reine »', 'Le Jongleur de Notre‐Dame : Acte I. « Gentil roi, choisis ta reine »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e9866b-bdd2-40c1-ad7c-957a49582f3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. Alleluia du vin: « Le vin, c’est Dieu le père »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. Alleluia du vin: « Le vin, c’est Dieu le père »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:efab0e0f-5ed5-45ab-a979-8d0de345978f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efab0e0f-5ed5-45ab-a979-8d0de345978f', 11, NULL, 'Acte I. Alleluia du vin: « Le vin, c’est Dieu le père »', 'Le Jongleur de Notre‐Dame : Acte I. Alleluia du vin: « Le vin, c’est Dieu le père »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efab0e0f-5ed5-45ab-a979-8d0de345978f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. « Il pleure » … « Tu seras pardonné »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte I. « Il pleure » … « Tu seras pardonné »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f556fcd7-2648-4f44-a6dc-2256ee211fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f556fcd7-2648-4f44-a6dc-2256ee211fc9', 12, NULL, 'Acte I. « Il pleure » … « Tu seras pardonné »', 'Le Jongleur de Notre‐Dame : Acte I. « Il pleure » … « Tu seras pardonné »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:092c0fc6-f1cc-413e-91df-42c857f15a6f'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f556fcd7-2648-4f44-a6dc-2256ee211fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Le Jongleur de Notre-Dame : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b', 2, NULL, 'Acte II', 'Le Jongleur de Notre-Dame : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Vous oubliez, mon frère, la peinture »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Vous oubliez, mon frère, la peinture »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:05c8eaa5-db15-4c56-8b43-01ffe4c60605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05c8eaa5-db15-4c56-8b43-01ffe4c60605', 1, NULL, 'Acte II. « Vous oubliez, mon frère, la peinture »', 'Le Jongleur de Notre‐Dame : Acte II. « Vous oubliez, mon frère, la peinture »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05c8eaa5-db15-4c56-8b43-01ffe4c60605'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Pour moi, je me figure »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Pour moi, je me figure »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:25bc425e-b962-4be3-a496-3bb25ad6e89a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25bc425e-b962-4be3-a496-3bb25ad6e89a', 2, NULL, 'Acte II. « Pour moi, je me figure »', 'Le Jongleur de Notre‐Dame : Acte II. « Pour moi, je me figure »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25bc425e-b962-4be3-a496-3bb25ad6e89a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Jongleur, piteux métier »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Jongleur, piteux métier »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:340b4e5b-f3a4-4807-9eb4-5093afcd8035' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:340b4e5b-f3a4-4807-9eb4-5093afcd8035', 3, NULL, 'Acte II. « Jongleur, piteux métier »', 'Le Jongleur de Notre‐Dame : Acte II. « Jongleur, piteux métier »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:340b4e5b-f3a4-4807-9eb4-5093afcd8035'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Vierge, mère d’amour »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Vierge, mère d’amour »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3d3fe339-5f79-4a79-b34b-9110fd080ee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d3fe339-5f79-4a79-b34b-9110fd080ee6', 4, NULL, 'Acte II. « Vierge, mère d’amour »', 'Le Jongleur de Notre‐Dame : Acte II. « Vierge, mère d’amour »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d3fe339-5f79-4a79-b34b-9110fd080ee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. Prélude', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:46342f9e-482d-45f2-a197-4a9c0e661093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46342f9e-482d-45f2-a197-4a9c0e661093', 5, NULL, 'Acte II. Prélude', 'Le Jongleur de Notre‐Dame : Acte II. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46342f9e-482d-45f2-a197-4a9c0e661093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Va, frère Jean, ne les envie »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Va, frère Jean, ne les envie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:48c4e4e4-7e55-4e20-99e6-ab833e501cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48c4e4e4-7e55-4e20-99e6-ab833e501cf4', 6, NULL, 'Acte II. « Va, frère Jean, ne les envie »', 'Le Jongleur de Notre‐Dame : Acte II. « Va, frère Jean, ne les envie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c4e4e4-7e55-4e20-99e6-ab833e501cf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. « La cuisine est bonne au couvent »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « La cuisine est bonne au couvent »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6374067d-728f-4e4d-b643-a9b3f947446f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6374067d-728f-4e4d-b643-a9b3f947446f', 7, NULL, 'Acte II. « La cuisine est bonne au couvent »', 'Le Jongleur de Notre‐Dame : Acte II. « La cuisine est bonne au couvent »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6374067d-728f-4e4d-b643-a9b3f947446f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Ô frère Jean, quelle paresse »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Ô frère Jean, quelle paresse »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6486b5b9-7648-4393-8e1c-971a578db62a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6486b5b9-7648-4393-8e1c-971a578db62a', 8, NULL, 'Acte II. « Ô frère Jean, quelle paresse »', 'Le Jongleur de Notre‐Dame : Acte II. « Ô frère Jean, quelle paresse »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6486b5b9-7648-4393-8e1c-971a578db62a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Ah ! Mes frères, je connais ma triste indignité »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Ah ! Mes frères, je connais ma triste indignité »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6678d702-72d6-4584-9504-661a25c86a5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6678d702-72d6-4584-9504-661a25c86a5a', 9, NULL, 'Acte II. « Ah ! Mes frères, je connais ma triste indignité »', 'Le Jongleur de Notre‐Dame : Acte II. « Ah ! Mes frères, je connais ma triste indignité »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6678d702-72d6-4584-9504-661a25c86a5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Quoi, mes frères! »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Quoi, mes frères! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8575acd4-d5ef-4d0a-a83a-7ff3b1b50c55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8575acd4-d5ef-4d0a-a83a-7ff3b1b50c55', 10, NULL, 'Acte II. « Quoi, mes frères! »', 'Le Jongleur de Notre‐Dame : Acte II. « Quoi, mes frères! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8575acd4-d5ef-4d0a-a83a-7ff3b1b50c55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Non pas, à la place d’honneur »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Non pas, à la place d’honneur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8709ee5a-91c2-46f9-b364-bc9089c6cb6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8709ee5a-91c2-46f9-b364-bc9089c6cb6d', 11, NULL, 'Acte II. « Non pas, à la place d’honneur »', 'Le Jongleur de Notre‐Dame : Acte II. « Non pas, à la place d’honneur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8709ee5a-91c2-46f9-b364-bc9089c6cb6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte II. Chœur des moines: « Ave rosa speciosa »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. Chœur des moines: « Ave rosa speciosa »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9a7fb288-11ae-42b0-b522-948e874fd24f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a7fb288-11ae-42b0-b522-948e874fd24f', 12, NULL, 'Acte II. Chœur des moines: « Ave rosa speciosa »', 'Le Jongleur de Notre‐Dame : Acte II. Chœur des moines: « Ave rosa speciosa »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a7fb288-11ae-42b0-b522-948e874fd24f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte II. Légende de la sauge « Marie, avec l''enfant Jésus » (Boniface)', part.name_en = 'Le Jongleur de Notre-Dame : Acte II. Légende de la sauge « Marie, avec l''enfant Jésus » (Boniface)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a1fae405-fa7c-4a08-a4f6-49233bd7a4f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1fae405-fa7c-4a08-a4f6-49233bd7a4f7', 13, NULL, 'Acte II. Légende de la sauge « Marie, avec l''enfant Jésus » (Boniface)', 'Le Jongleur de Notre-Dame : Acte II. Légende de la sauge « Marie, avec l''enfant Jésus » (Boniface)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1fae405-fa7c-4a08-a4f6-49233bd7a4f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Dans ce coin solitaire »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte II. « Dans ce coin solitaire »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bd711d95-dd65-440d-b22f-5463beb57864' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd711d95-dd65-440d-b22f-5463beb57864', 14, NULL, 'Acte II. « Dans ce coin solitaire »', 'Le Jongleur de Notre‐Dame : Acte II. « Dans ce coin solitaire »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97cabe83-c50e-4e78-b58e-93f15fd8ca4b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd711d95-dd65-440d-b22f-5463beb57864'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Jongleur de Notre-Dame : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b', 3, NULL, 'Acte III', 'Le Jongleur de Notre-Dame : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Relevez‐vous »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Relevez‐vous »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1b826c9e-d13f-4c83-a875-2ab7ee53bd9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b826c9e-d13f-4c83-a875-2ab7ee53bd9d', 1, NULL, 'Acte III. « Relevez‐vous »', 'Le Jongleur de Notre‐Dame : Acte III. « Relevez‐vous »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b826c9e-d13f-4c83-a875-2ab7ee53bd9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Spectacle radieux »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Spectacle radieux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:41fe3672-51f4-4d04-8c2b-b1262099f471' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41fe3672-51f4-4d04-8c2b-b1262099f471', 2, NULL, 'Acte III. « Spectacle radieux »', 'Le Jongleur de Notre‐Dame : Acte III. « Spectacle radieux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41fe3672-51f4-4d04-8c2b-b1262099f471'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Ave, Céleste »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Ave, Céleste »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6245fdbd-b742-4a91-81ca-0bd9e6b41abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6245fdbd-b742-4a91-81ca-0bd9e6b41abe', 3, NULL, 'Acte III. « Ave, Céleste »', 'Le Jongleur de Notre‐Dame : Acte III. « Ave, Céleste »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6245fdbd-b742-4a91-81ca-0bd9e6b41abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. Le Miracle: « Arrière tous »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Le Miracle: « Arrière tous »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6b499358-722d-4ae7-ae59-729d6c27ec04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b499358-722d-4ae7-ae59-729d6c27ec04', 4, NULL, 'Acte III. Le Miracle: « Arrière tous »', 'Le Jongleur de Notre‐Dame : Acte III. Le Miracle: « Arrière tous »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b499358-722d-4ae7-ae59-729d6c27ec04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Caressé par le vent de nos ailes »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Caressé par le vent de nos ailes »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:730ce99c-1cf4-44fe-9dcb-e56fadc7b514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:730ce99c-1cf4-44fe-9dcb-e56fadc7b514', 5, NULL, 'Acte III. « Caressé par le vent de nos ailes »', 'Le Jongleur de Notre‐Dame : Acte III. « Caressé par le vent de nos ailes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:730ce99c-1cf4-44fe-9dcb-e56fadc7b514'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. Chanson de guerre: « Il fait beau voir »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Chanson de guerre: « Il fait beau voir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9316a024-7901-4a80-b747-f4b4b6a2d3f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9316a024-7901-4a80-b747-f4b4b6a2d3f6', 6, NULL, 'Acte III. Chanson de guerre: « Il fait beau voir »', 'Le Jongleur de Notre‐Dame : Acte III. Chanson de guerre: « Il fait beau voir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9316a024-7901-4a80-b747-f4b4b6a2d3f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III. Boniment: « Place, place, silence »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Boniment: « Place, place, silence »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9edf63a8-e603-4328-8517-9fd3d6a40bb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9edf63a8-e603-4328-8517-9fd3d6a40bb2', 7, NULL, 'Acte III. Boniment: « Place, place, silence »', 'Le Jongleur de Notre‐Dame : Acte III. Boniment: « Place, place, silence »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9edf63a8-e603-4328-8517-9fd3d6a40bb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Mère adorable de Jésus »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Mère adorable de Jésus »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a02f83ce-5746-4215-a7f9-02cc80c06136' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a02f83ce-5746-4215-a7f9-02cc80c06136', 8, NULL, 'Acte III. « Mère adorable de Jésus »', 'Le Jongleur de Notre‐Dame : Acte III. « Mère adorable de Jésus »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a02f83ce-5746-4215-a7f9-02cc80c06136'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Rayonnement ! Bonheur ! »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Rayonnement ! Bonheur ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a1221527-cdc0-4d5c-8413-11a590e37ce2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1221527-cdc0-4d5c-8413-11a590e37ce2', 9, NULL, 'Acte III. « Rayonnement ! Bonheur ! »', 'Le Jongleur de Notre‐Dame : Acte III. « Rayonnement ! Bonheur ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1221527-cdc0-4d5c-8413-11a590e37ce2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte III. Danse du jongleur: « Sacrilège »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Danse du jongleur: « Sacrilège »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c5e835f9-d229-4e82-a740-82542225cbb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5e835f9-d229-4e82-a740-82542225cbb2', 10, NULL, 'Acte III. Danse du jongleur: « Sacrilège »', 'Le Jongleur de Notre‐Dame : Acte III. Danse du jongleur: « Sacrilège »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e835f9-d229-4e82-a740-82542225cbb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte III. Romance d’amour: « Belle Doètte »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Romance d’amour: « Belle Doètte »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c789e1cd-e49a-4071-9990-fe49bfff079a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c789e1cd-e49a-4071-9990-fe49bfff079a', 11, NULL, 'Acte III. Romance d’amour: « Belle Doètte »', 'Le Jongleur de Notre‐Dame : Acte III. Romance d’amour: « Belle Doètte »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c789e1cd-e49a-4071-9990-fe49bfff079a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Hosannah ! Gloire à Jean ! »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. « Hosannah ! Gloire à Jean ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:caf42576-36da-4e18-b892-1e1a5c513e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:caf42576-36da-4e18-b892-1e1a5c513e1d', 12, NULL, 'Acte III. « Hosannah ! Gloire à Jean ! »', 'Le Jongleur de Notre‐Dame : Acte III. « Hosannah ! Gloire à Jean ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf42576-36da-4e18-b892-1e1a5c513e1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte III. Le Jeu de Robin et Marion: « À l’orée du joli bocage »', part.name_en = 'Le Jongleur de Notre‐Dame : Acte III. Le Jeu de Robin et Marion: « À l’orée du joli bocage »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10544 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ce16e331-b89e-433e-b1d6-1ae039a73839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce16e331-b89e-433e-b1d6-1ae039a73839', 13, NULL, 'Acte III. Le Jeu de Robin et Marion: « À l’orée du joli bocage »', 'Le Jongleur de Notre‐Dame : Acte III. Le Jeu de Robin et Marion: « À l’orée du joli bocage »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b5129818-e69e-4aaf-964d-46e0fceb9c5b'
WHERE p.id = 10544 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce16e331-b89e-433e-b1d6-1ae039a73839'
);


-- None 오페라 <Le Mage>

UPDATE pieces piece
SET piece.title = '오페라 <Le Mage>', piece.title_en = 'Le Mage',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10163 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Mage: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10163 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9886a54e-d555-4add-950b-92f2a9cda966' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9886a54e-d555-4add-950b-92f2a9cda966', 1, NULL, 'Acte I', 'Le Mage: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10163 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9886a54e-d555-4add-950b-92f2a9cda966'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Le Mage: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10163 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ed177bd6-ea66-4c30-9807-9948cc133c8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed177bd6-ea66-4c30-9807-9948cc133c8b', 2, NULL, 'Acte II', 'Le Mage: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10163 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed177bd6-ea66-4c30-9807-9948cc133c8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Mage: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10163 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:50a9d365-1cdc-4bca-913d-ba5c8e06036c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50a9d365-1cdc-4bca-913d-ba5c8e06036c', 3, NULL, 'Acte III', 'Le Mage: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10163 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a9d365-1cdc-4bca-913d-ba5c8e06036c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Le Mage: Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10163 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:88f1fb21-175e-4c4d-a115-49408b39783f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f1fb21-175e-4c4d-a115-49408b39783f', 4, NULL, 'Acte IV', 'Le Mage: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10163 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f1fb21-175e-4c4d-a115-49408b39783f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V', part.name_en = 'Le Mage: Acte V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10163 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5ee3bb0a-159a-4577-847d-fadf493b2246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ee3bb0a-159a-4577-847d-fadf493b2246', 5, NULL, 'Acte V', 'Le Mage: Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10163 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ee3bb0a-159a-4577-847d-fadf493b2246'
);


-- None 가곡 <Le Poète et le Fantôme>

UPDATE pieces piece
SET piece.title = '가곡 <Le Poète et le Fantôme>', piece.title_en = 'Le Poète et le Fantôme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11093 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Le Roi de Lahore>

UPDATE pieces piece
SET piece.title = '오페라 <Le Roi de Lahore>', piece.title_en = 'Le Roi de Lahore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11011 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le roman d’Arlequin

UPDATE pieces piece
SET piece.title = 'Le roman d’Arlequin', piece.title_en = 'Le roman d’Arlequin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9602 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sérénade d’Arlequin à Colombine. Allegretto', part.name_en = 'Le roman d’Arlequin: Sérénade d’Arlequin à Colombine. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9602 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:1e2a4c04-c741-434d-847a-788a6e5a7596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e2a4c04-c741-434d-847a-788a6e5a7596', 1, NULL, 'Sérénade d’Arlequin à Colombine. Allegretto', 'Le roman d’Arlequin: Sérénade d’Arlequin à Colombine. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9602 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e2a4c04-c741-434d-847a-788a6e5a7596'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Duo d’Arlequin et de Colombine. Allegro vivo', part.name_en = 'Le roman d’Arlequin: Duo d’Arlequin et de Colombine. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9602 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4dc773ed-3c5c-4264-906b-50d77eec0df1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dc773ed-3c5c-4264-906b-50d77eec0df1', 2, NULL, 'Duo d’Arlequin et de Colombine. Allegro vivo', 'Le roman d’Arlequin: Duo d’Arlequin et de Colombine. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9602 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dc773ed-3c5c-4264-906b-50d77eec0df1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rêverie de Colombine à sa fenêtre. Andantino simplice', part.name_en = 'Le roman d’Arlequin: Rêverie de Colombine à sa fenêtre. Andantino simplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9602 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:52ad7a84-3e3f-4134-8493-0150dbeec1bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52ad7a84-3e3f-4134-8493-0150dbeec1bd', 3, NULL, 'Rêverie de Colombine à sa fenêtre. Andantino simplice', 'Le roman d’Arlequin: Rêverie de Colombine à sa fenêtre. Andantino simplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9602 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ad7a84-3e3f-4134-8493-0150dbeec1bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ouverture-gigue. Allegro moderato', part.name_en = 'Le roman d’Arlequin: Ouverture-gigue. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9602 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:90cb10e8-b4b3-490d-a780-5d4a9d1a8ea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90cb10e8-b4b3-490d-a780-5d4a9d1a8ea7', 4, NULL, 'Ouverture-gigue. Allegro moderato', 'Le roman d’Arlequin: Ouverture-gigue. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9602 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90cb10e8-b4b3-490d-a780-5d4a9d1a8ea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Entrée d’Arlequin. Allegro spirito', part.name_en = 'Le roman d’Arlequin: Entrée d’Arlequin. Allegro spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9602 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9ca782a3-72b9-431b-9299-9566d4be3684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ca782a3-72b9-431b-9299-9566d4be3684', 5, NULL, 'Entrée d’Arlequin. Allegro spirito', 'Le roman d’Arlequin: Entrée d’Arlequin. Allegro spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9602 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ca782a3-72b9-431b-9299-9566d4be3684'
);


-- None 가곡 <Le sais‐tu ?>

UPDATE pieces piece
SET piece.title = '가곡 <Le sais‐tu ?>', piece.title_en = 'Le sais‐tu ?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9648 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Les Alcyons>

UPDATE pieces piece
SET piece.title = '가곡 <Les Alcyons>', piece.title_en = 'Les Alcyons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7773 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Enfants / Marquise

UPDATE pieces piece
SET piece.title = 'Les Enfants / Marquise', piece.title_en = 'Les Enfants / Marquise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9291 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Les Yeux clos>

UPDATE pieces piece
SET piece.title = '가곡 <Les Yeux clos>', piece.title_en = 'Les Yeux clos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10097 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Les amoureuses sont des folles>

UPDATE pieces piece
SET piece.title = '가곡 <Les amoureuses sont des folles>', piece.title_en = 'Les amoureuses sont des folles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7987 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les enfants

UPDATE pieces piece
SET piece.title = 'Les enfants', piece.title_en = 'Les enfants',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9111 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Les Érinnyes>

UPDATE pieces piece
SET piece.title = '부수음악 <Les Érinnyes>', piece.title_en = 'Les Érinnyes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9113 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scène religieuse', part.name_en = 'Scène religieuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9113 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:bafaac20-39c2-451e-87f3-803a5905f23d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bafaac20-39c2-451e-87f3-803a5905f23d', 1, NULL, 'Scène religieuse', 'Scène religieuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9113 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bafaac20-39c2-451e-87f3-803a5905f23d'
);


-- None L’improvisatore

UPDATE pieces piece
SET piece.title = 'L’improvisatore', piece.title_en = 'L’improvisatore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10994 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <L’Âme des fleurs>

UPDATE pieces piece
SET piece.title = '가곡 <L’Âme des fleurs>', piece.title_en = 'L’Âme des fleurs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9310 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <L’Éventail>

UPDATE pieces piece
SET piece.title = '가곡 <L’Éventail>', piece.title_en = 'L’Éventail',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10724 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마드리갈

UPDATE pieces piece
SET piece.title = '마드리갈', piece.title_en = 'Madrigal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9000 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marquise

UPDATE pieces piece
SET piece.title = 'Marquise', piece.title_en = 'Marquise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10342 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musique pour 'bercer les petits enfants'

UPDATE pieces piece
SET piece.title = 'Musique pour ''bercer les petits enfants''', piece.title_en = 'Musique pour ''bercer les petits enfants''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8732 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Oh! Si les fleurs avaient des yeux>

UPDATE pieces piece
SET piece.title = '가곡 <Oh! Si les fleurs avaient des yeux>', piece.title_en = 'Oh! Si les fleurs avaient des yeux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7894 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <On dit !>

UPDATE pieces piece
SET piece.title = '가곡 <On dit !>', piece.title_en = 'On dit !',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10519 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Orphelines>

UPDATE pieces piece
SET piece.title = '가곡 <Orphelines>', piece.title_en = 'Orphelines',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11060 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 아리아 <Panurge : Acte I. « Touraine est un pays » (Panurge)>

UPDATE pieces piece
SET piece.title = '아리아 <Panurge : Acte I. « Touraine est un pays » (Panurge)>', piece.title_en = 'Panurge : Acte I. « Touraine est un pays » (Panurge)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10169 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Panurge', part.name_en = 'Panurge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10169 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5b8f65dd-ce55-44c6-bd78-d400ded7ae35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8f65dd-ce55-44c6-bd78-d400ded7ae35', 1, NULL, 'Panurge', 'Panurge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10169 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8f65dd-ce55-44c6-bd78-d400ded7ae35'
);


-- None 가곡 <Passionnément>

UPDATE pieces piece
SET piece.title = '가곡 <Passionnément>', piece.title_en = 'Passionnément',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10130 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Pensée d'automne>

UPDATE pieces piece
SET piece.title = '가곡 <Pensée d''automne>', piece.title_en = 'Pensée d''automne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8483 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pensée de printemps

UPDATE pieces piece
SET piece.title = 'Pensée de printemps', piece.title_en = 'Pensée de printemps',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10854 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Phèdre>

UPDATE pieces piece
SET piece.title = '부수음악 <Phèdre>', piece.title_en = 'Phèdre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9416 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Phèdre: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9416 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:19939981-7267-4d65-80f7-c4d13d20c185' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19939981-7267-4d65-80f7-c4d13d20c185', 1, NULL, 'Overture', 'Phèdre: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9416 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19939981-7267-4d65-80f7-c4d13d20c185'
);


-- None 피아노 협주곡 E♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 E♭장조', piece.title_en = 'Piano Concerto in E-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8257 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato - Allegro non troppo', part.name_en = 'Piano Concerto in E-flat major: I. Andante moderato - Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8257 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b6e9fef4-edf0-4bc6-8454-2ae971c9f565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6e9fef4-edf0-4bc6-8454-2ae971c9f565', 1, 'I', 'Andante moderato - Allegro non troppo', 'Piano Concerto in E-flat major: I. Andante moderato - Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8257 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6e9fef4-edf0-4bc6-8454-2ae971c9f565'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Piano Concerto in E-flat major: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8257 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2c4c1dfb-e95e-4708-a831-34355093da27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c4c1dfb-e95e-4708-a831-34355093da27', 2, 'II', 'Largo', 'Piano Concerto in E-flat major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8257 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c4c1dfb-e95e-4708-a831-34355093da27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Airs slovaques. Allegro', part.name_en = 'Piano Concerto in E-flat major: III. Airs slovaques. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8257 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:39e00452-9801-4248-b719-8ec0f63be55c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39e00452-9801-4248-b719-8ec0f63be55c', 3, 'III', 'Airs slovaques. Allegro', 'Piano Concerto in E-flat major: III. Airs slovaques. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8257 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e00452-9801-4248-b719-8ec0f63be55c'
);


-- None Pitchounette

UPDATE pieces piece
SET piece.title = 'Pitchounette', piece.title_en = 'Pitchounette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9265 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Poème d'avril

UPDATE pieces piece
SET piece.title = 'Poème d''avril', piece.title_en = 'Poème d''avril, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10775 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Poème d''avril, op. 14: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:7ca5374e-4256-4d4a-9e10-a1bb9c5384a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ca5374e-4256-4d4a-9e10-a1bb9c5384a4', 1, 'I', 'Prélude', 'Poème d''avril, op. 14: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ca5374e-4256-4d4a-9e10-a1bb9c5384a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sonnet matinal', part.name_en = 'Poème d''avril, op. 14: II. Sonnet matinal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:63c916ab-1f0f-452f-ad42-45ee88397f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63c916ab-1f0f-452f-ad42-45ee88397f42', 2, 'II', 'Sonnet matinal', 'Poème d''avril, op. 14: II. Sonnet matinal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c916ab-1f0f-452f-ad42-45ee88397f42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Voici que les grands lys', part.name_en = 'Poème d''avril, op. 14: III. Voici que les grands lys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:41024712-fb5a-4b0a-ae87-f976c7174f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41024712-fb5a-4b0a-ae87-f976c7174f65', 3, 'III', 'Voici que les grands lys', 'Poème d''avril, op. 14: III. Voici que les grands lys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41024712-fb5a-4b0a-ae87-f976c7174f65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Riez-vous? Ne riez-vous pas?', part.name_en = 'Poème d''avril, op. 14: IV. Riez-vous? Ne riez-vous pas?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a603a3ed-30c8-4ef8-99e6-35a3ac6d178d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a603a3ed-30c8-4ef8-99e6-35a3ac6d178d', 4, 'IV', 'Riez-vous? Ne riez-vous pas?', 'Poème d''avril, op. 14: IV. Riez-vous? Ne riez-vous pas?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a603a3ed-30c8-4ef8-99e6-35a3ac6d178d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le doux printemps a bu', part.name_en = 'Poème d''avril, op. 14: V. Le doux printemps a bu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:74f7bfd6-d2c9-410b-b120-72adc525c35d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74f7bfd6-d2c9-410b-b120-72adc525c35d', 5, 'V', 'Le doux printemps a bu', 'Poème d''avril, op. 14: V. Le doux printemps a bu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74f7bfd6-d2c9-410b-b120-72adc525c35d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Que l''heure est donc brève', part.name_en = 'Poème d''avril, op. 14: VI. Que l''heure est donc brève',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c496c259-a97c-425d-a071-e28190844c90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c496c259-a97c-425d-a071-e28190844c90', 6, 'VI', 'Que l''heure est donc brève', 'Poème d''avril, op. 14: VI. Que l''heure est donc brève', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c496c259-a97c-425d-a071-e28190844c90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Sur la source elle se pencha', part.name_en = 'Poème d''avril, op. 14: VII. Sur la source elle se pencha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a46fd8ff-ebf1-416b-b2d0-76728be7c05b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a46fd8ff-ebf1-416b-b2d0-76728be7c05b', 7, 'VII', 'Sur la source elle se pencha', 'Poème d''avril, op. 14: VII. Sur la source elle se pencha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a46fd8ff-ebf1-416b-b2d0-76728be7c05b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Complainte', part.name_en = 'Poème d''avril, op. 14: VIII. Complainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10775 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:f5d516e5-ad3f-4470-b9ab-e6904f18f855' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5d516e5-ad3f-4470-b9ab-e6904f18f855', 8, 'VIII', 'Complainte', 'Poème d''avril, op. 14: VIII. Complainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10775 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5d516e5-ad3f-4470-b9ab-e6904f18f855'
);


-- None Poème d'octobre

UPDATE pieces piece
SET piece.title = 'Poème d''octobre', piece.title_en = 'Poème d''octobre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8050 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Poème d''octobre: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ac317eef-d447-4c2a-a782-57b8949742d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac317eef-d447-4c2a-a782-57b8949742d3', 1, NULL, 'Prélude', 'Poème d''octobre: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac317eef-d447-4c2a-a782-57b8949742d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Automne', part.name_en = 'Poème d''octobre: I. Automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:21660a79-b888-40e2-bc00-e772598bce9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21660a79-b888-40e2-bc00-e772598bce9d', 2, NULL, 'Automne', 'Poème d''octobre: I. Automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21660a79-b888-40e2-bc00-e772598bce9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Les Marroniers', part.name_en = 'Poème d''octobre: II. Les Marroniers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:37c50483-b6df-4eee-b2fe-884a34b4e00c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37c50483-b6df-4eee-b2fe-884a34b4e00c', 3, NULL, 'Les Marroniers', 'Poème d''octobre: II. Les Marroniers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c50483-b6df-4eee-b2fe-884a34b4e00c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Qu''importe que l''hiver', part.name_en = 'Poème d''octobre: III. Qu''importe que l''hiver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:506c7c68-9e0d-44df-9530-48b5dc8ce190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506c7c68-9e0d-44df-9530-48b5dc8ce190', 4, NULL, 'Qu''importe que l''hiver', 'Poème d''octobre: III. Qu''importe que l''hiver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506c7c68-9e0d-44df-9530-48b5dc8ce190'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Roses d''octobre', part.name_en = 'Poème d''octobre: IV. Roses d''octobre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b30f6dc9-a40a-4d7c-9948-23e67270b458' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b30f6dc9-a40a-4d7c-9948-23e67270b458', 5, NULL, 'Roses d''octobre', 'Poème d''octobre: IV. Roses d''octobre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b30f6dc9-a40a-4d7c-9948-23e67270b458'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pareils à des oiseaux', part.name_en = 'Poème d''octobre: V. Pareils à des oiseaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8050 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4101abc7-ae5d-4963-be28-57c2abdc9d38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4101abc7-ae5d-4963-be28-57c2abdc9d38', 6, NULL, 'Pareils à des oiseaux', 'Poème d''octobre: V. Pareils à des oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8050 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4101abc7-ae5d-4963-be28-57c2abdc9d38'
);


-- None Poème d'un soir

UPDATE pieces piece
SET piece.title = 'Poème d''un soir', piece.title_en = 'Poème d''un soir',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8986 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Antienne', part.name_en = 'Poème d''un soir: I. Antienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8986 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aa4d205f-737c-4591-a206-86d1e1473f9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa4d205f-737c-4591-a206-86d1e1473f9b', 1, 'I', 'Antienne', 'Poème d''un soir: I. Antienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8986 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa4d205f-737c-4591-a206-86d1e1473f9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fleuramye', part.name_en = 'Poème d''un soir: II. Fleuramye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8986 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b22ee5de-35e4-4029-99a7-f5647142c1d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b22ee5de-35e4-4029-99a7-f5647142c1d5', 2, 'II', 'Fleuramye', 'Poème d''un soir: II. Fleuramye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8986 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22ee5de-35e4-4029-99a7-f5647142c1d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Defuncta nascuntur', part.name_en = 'Poème d''un soir: III. Defuncta nascuntur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8986 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6a8f19c5-1d9e-48cb-a6ec-d652ee07672f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8f19c5-1d9e-48cb-a6ec-d652ee07672f', 3, 'III', 'Defuncta nascuntur', 'Poème d''un soir: III. Defuncta nascuntur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8986 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8f19c5-1d9e-48cb-a6ec-d652ee07672f'
);


-- None Poème du souvenir

UPDATE pieces piece
SET piece.title = 'Poème du souvenir', piece.title_en = 'Poème du souvenir',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8920 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'À la trépassée', part.name_en = 'Poème du souvenir: À la trépassée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8920 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9f77f383-a8cb-447a-85dd-7ea032e26d1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f77f383-a8cb-447a-85dd-7ea032e26d1d', 1, NULL, 'À la trépassée', 'Poème du souvenir: À la trépassée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8920 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f77f383-a8cb-447a-85dd-7ea032e26d1d'
);


-- None 연가곡집 <Poème d’amour>

UPDATE pieces piece
SET piece.title = '연가곡집 <Poème d’amour>', piece.title_en = 'Poème d’amour',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7636 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Je me suis plaint aux tourterelles', part.name_en = 'Poème d’amour: 1. Je me suis plaint aux tourterelles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:8f9db057-8174-4600-b972-8c2d13469446' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f9db057-8174-4600-b972-8c2d13469446', 1, NULL, 'Je me suis plaint aux tourterelles', 'Poème d’amour: 1. Je me suis plaint aux tourterelles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f9db057-8174-4600-b972-8c2d13469446'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La nuit, sans doute', part.name_en = 'Poème d’amour: 2. La nuit, sans doute',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:afb5aa62-ad63-4ae5-bfec-154bd301714a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb5aa62-ad63-4ae5-bfec-154bd301714a', 2, NULL, 'La nuit, sans doute', 'Poème d’amour: 2. La nuit, sans doute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb5aa62-ad63-4ae5-bfec-154bd301714a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ouvre tes yeux bleus', part.name_en = 'Poème d’amour: 3. Ouvre tes yeux bleus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:99e91f53-803b-443a-aa7b-5c0b096240ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99e91f53-803b-443a-aa7b-5c0b096240ce', 3, NULL, 'Ouvre tes yeux bleus', 'Poème d’amour: 3. Ouvre tes yeux bleus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e91f53-803b-443a-aa7b-5c0b096240ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Puisqu’elle a pris ma vie', part.name_en = 'Poème d’amour: 4. Puisqu’elle a pris ma vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9eb39ee8-5c31-465c-b3eb-3c0983569678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eb39ee8-5c31-465c-b3eb-3c0983569678', 4, NULL, 'Puisqu’elle a pris ma vie', 'Poème d’amour: 4. Puisqu’elle a pris ma vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb39ee8-5c31-465c-b3eb-3c0983569678'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pourquoi pleures-tu?', part.name_en = 'Poème d’amour: 5. Pourquoi pleures-tu?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9f4f929b-9eb0-42c1-8365-d0ab567be549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f4f929b-9eb0-42c1-8365-d0ab567be549', 5, NULL, 'Pourquoi pleures-tu?', 'Poème d’amour: 5. Pourquoi pleures-tu?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f4f929b-9eb0-42c1-8365-d0ab567be549'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Oh! ne finis jamais', part.name_en = 'Poème d’amour: 6. Oh! ne finis jamais',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7636 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aefe392d-a0ce-4fa4-b76e-5bb72c0cf680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aefe392d-a0ce-4fa4-b76e-5bb72c0cf680', 6, NULL, 'Oh! ne finis jamais', 'Poème d’amour: 6. Oh! ne finis jamais', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7636 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aefe392d-a0ce-4fa4-b76e-5bb72c0cf680'
);


-- None 연가곡집 <Poème pastoral>

UPDATE pieces piece
SET piece.title = '연가곡집 <Poème pastoral>', piece.title_en = 'Poème pastoral',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10599 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Crépuscule', part.name_en = 'Poème pastoral: 5. Crépuscule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10599 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3e94b955-11c1-410b-b4e7-a287d3e320aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e94b955-11c1-410b-b4e7-a287d3e320aa', 1, NULL, 'Crépuscule', 'Poème pastoral: 5. Crépuscule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10599 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e94b955-11c1-410b-b4e7-a287d3e320aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aurore', part.name_en = 'Poème pastoral: 3. Aurore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10599 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dd09c4c2-ebc0-4271-8250-b8969854317d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd09c4c2-ebc0-4271-8250-b8969854317d', 2, NULL, 'Aurore', 'Poème pastoral: 3. Aurore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10599 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd09c4c2-ebc0-4271-8250-b8969854317d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Musette', part.name_en = 'Poème pastoral: 2. Musette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10599 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eb5533f0-dcf5-4c6c-a6b3-77e5e48b0ede' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb5533f0-dcf5-4c6c-a6b3-77e5e48b0ede', 3, NULL, 'Musette', 'Poème pastoral: 2. Musette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10599 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb5533f0-dcf5-4c6c-a6b3-77e5e48b0ede'
);


-- Op. 11 Première Suite Op. 11

UPDATE pieces piece
SET piece.title = 'Première Suite Op. 11', piece.title_en = 'Première Suite, op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9112 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Première Suite, op. 11: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9112 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:5b3a35ad-f4b0-43d6-9d99-745f788a2fc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b3a35ad-f4b0-43d6-9d99-745f788a2fc1', 1, NULL, 'I', 'Première Suite, op. 11: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9112 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b3a35ad-f4b0-43d6-9d99-745f788a2fc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Première Suite, op. 11: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9112 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c983ac77-7684-414a-a962-06cf645dd1a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c983ac77-7684-414a-a962-06cf645dd1a1', 2, NULL, 'II', 'Première Suite, op. 11: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9112 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c983ac77-7684-414a-a962-06cf645dd1a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Première Suite, op. 11: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9112 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:29ab662f-2d7c-47b0-83e4-1e2d81ed9f2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ab662f-2d7c-47b0-83e4-1e2d81ed9f2c', 3, NULL, 'III', 'Première Suite, op. 11: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9112 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ab662f-2d7c-47b0-83e4-1e2d81ed9f2c'
);


-- None 가곡 <Première danse>

UPDATE pieces piece
SET piece.title = '가곡 <Première danse>', piece.title_en = 'Première danse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8088 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Printemps dernier>

UPDATE pieces piece
SET piece.title = '가곡 <Printemps dernier>', piece.title_en = 'Printemps dernier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7925 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Roma>

UPDATE pieces piece
SET piece.title = '오페라 <Roma>', piece.title_en = 'Roma',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7779 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Roma: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7779 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ec860e17-7ee6-43fa-ad21-5f4e13ca187d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec860e17-7ee6-43fa-ad21-5f4e13ca187d', 1, NULL, 'Acte I', 'Roma: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7779 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec860e17-7ee6-43fa-ad21-5f4e13ca187d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Roma: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7779 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:85586fa9-3740-46f6-97eb-ef3b3672f5be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85586fa9-3740-46f6-97eb-ef3b3672f5be', 2, NULL, 'Acte II', 'Roma: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7779 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85586fa9-3740-46f6-97eb-ef3b3672f5be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Roma: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7779 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d0332830-1f6b-447f-b118-0f104fbaade3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0332830-1f6b-447f-b118-0f104fbaade3', 3, NULL, 'Acte III', 'Roma: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7779 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0332830-1f6b-447f-b118-0f104fbaade3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Roma: Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7779 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b10eb64b-a0ae-407d-a09c-a55836da7035' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b10eb64b-a0ae-407d-a09c-a55836da7035', 4, NULL, 'Acte IV', 'Roma: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7779 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b10eb64b-a0ae-407d-a09c-a55836da7035'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V', part.name_en = 'Roma: Acte V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7779 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:51bd25d6-1d71-4db1-9817-bc43bb668842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51bd25d6-1d71-4db1-9817-bc43bb668842', 5, NULL, 'Acte V', 'Roma: Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7779 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51bd25d6-1d71-4db1-9817-bc43bb668842'
);


-- None Rêverie du pauvre

UPDATE pieces piece
SET piece.title = 'Rêverie du pauvre', piece.title_en = 'Rêverie du pauvre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8392 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rêvons, c'est l'heure>

UPDATE pieces piece
SET piece.title = '가곡 <Rêvons, c''est l''heure>', piece.title_en = 'Rêvons, c''est l''heure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8866 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sainte Thérèse prie>

UPDATE pieces piece
SET piece.title = '가곡 <Sainte Thérèse prie>', piece.title_en = 'Sainte Thérèse prie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7832 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Sapho>

UPDATE pieces piece
SET piece.title = '오페라 <Sapho>', piece.title_en = 'Sapho',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10741 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Ces gens que je connais » ... « Pendant un an je fus ta femme » (Fanny)', part.name_en = 'Sapho: Acte IV. « Ces gens que je connais » ... « Pendant un an je fus ta femme » (Fanny)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10741 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:3f7f05af-cda4-4300-9408-d9d63bf02cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f7f05af-cda4-4300-9408-d9d63bf02cf4', 1, NULL, 'Acte IV. « Ces gens que je connais » ... « Pendant un an je fus ta femme » (Fanny)', 'Sapho: Acte IV. « Ces gens que je connais » ... « Pendant un an je fus ta femme » (Fanny)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10741 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f7f05af-cda4-4300-9408-d9d63bf02cf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prélude / « Demain je partirai »', part.name_en = 'Sapho: Prélude / « Demain je partirai »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10741 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:46b325df-4cfc-4269-9349-f447124f2c56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b325df-4cfc-4269-9349-f447124f2c56', 2, NULL, 'Prélude / « Demain je partirai »', 'Sapho: Prélude / « Demain je partirai »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10741 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b325df-4cfc-4269-9349-f447124f2c56'
);


-- None Scènes alsaciennes

UPDATE pieces piece
SET piece.title = 'Scènes alsaciennes', piece.title_en = 'Scènes alsaciennes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11169 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dimanche matin', part.name_en = 'Scènes alsaciennes: I. Dimanche matin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11169 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:509f0be5-1b2f-4715-8d8a-e2707b78bc26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:509f0be5-1b2f-4715-8d8a-e2707b78bc26', 1, 'I', 'Dimanche matin', 'Scènes alsaciennes: I. Dimanche matin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11169 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:509f0be5-1b2f-4715-8d8a-e2707b78bc26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Au cabaret', part.name_en = 'Scènes alsaciennes: II. Au cabaret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11169 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:33be5638-9d2a-423f-80c2-504a67507abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33be5638-9d2a-423f-80c2-504a67507abe', 2, 'II', 'Au cabaret', 'Scènes alsaciennes: II. Au cabaret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11169 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33be5638-9d2a-423f-80c2-504a67507abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sous les tilleuls', part.name_en = 'Scènes alsaciennes: III. Sous les tilleuls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11169 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:95e192a7-bb54-4f8e-a5a4-40e006fc23ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95e192a7-bb54-4f8e-a5a4-40e006fc23ac', 3, 'III', 'Sous les tilleuls', 'Scènes alsaciennes: III. Sous les tilleuls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11169 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e192a7-bb54-4f8e-a5a4-40e006fc23ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dimanche soir', part.name_en = 'Scènes alsaciennes: IV. Dimanche soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11169 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:77f2f976-d0a8-4fc1-9862-5117334641cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77f2f976-d0a8-4fc1-9862-5117334641cf', 4, 'IV', 'Dimanche soir', 'Scènes alsaciennes: IV. Dimanche soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11169 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77f2f976-d0a8-4fc1-9862-5117334641cf'
);


-- None Scènes pittoresques

UPDATE pieces piece
SET piece.title = 'Scènes pittoresques', piece.title_en = 'Scènes pittoresques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7578 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Marche', part.name_en = 'Scènes pittoresques: I. Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7578 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2971ee15-25d1-45aa-abd4-f97163449e92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2971ee15-25d1-45aa-abd4-f97163449e92', 1, 'I', 'Marche', 'Scènes pittoresques: I. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7578 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2971ee15-25d1-45aa-abd4-f97163449e92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air de ballet', part.name_en = 'Scènes pittoresques: II. Air de ballet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7578 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:034129d6-ced2-409e-b71a-bed5ef7f7f61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:034129d6-ced2-409e-b71a-bed5ef7f7f61', 2, 'II', 'Air de ballet', 'Scènes pittoresques: II. Air de ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7578 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:034129d6-ced2-409e-b71a-bed5ef7f7f61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Angelus', part.name_en = 'Scènes pittoresques: III. Angelus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7578 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:712410b9-7c64-4ef0-be0a-21723c5d1a7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:712410b9-7c64-4ef0-be0a-21723c5d1a7f', 3, 'III', 'Angelus', 'Scènes pittoresques: III. Angelus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7578 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:712410b9-7c64-4ef0-be0a-21723c5d1a7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fête bohème', part.name_en = 'Scènes pittoresques: IV. Fête bohème',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7578 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:aa905c85-0851-4b81-93ca-070e0183aef8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa905c85-0851-4b81-93ca-070e0183aef8', 4, 'IV', 'Fête bohème', 'Scènes pittoresques: IV. Fête bohème', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7578 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa905c85-0851-4b81-93ca-070e0183aef8'
);


-- None Sept Improvisations

UPDATE pieces piece
SET piece.title = 'Sept Improvisations', piece.title_en = 'Sept Improvisations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8106 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Sept Improvisations: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c2b553d8-6a1e-4b03-9292-49b6f77ff14a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b553d8-6a1e-4b03-9292-49b6f77ff14a', 1, NULL, 'No. 1', 'Sept Improvisations: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b553d8-6a1e-4b03-9292-49b6f77ff14a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Sept Improvisations: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:69b50bbf-ea3a-4ae0-b2da-b258d679b842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69b50bbf-ea3a-4ae0-b2da-b258d679b842', 2, NULL, 'No. 2', 'Sept Improvisations: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69b50bbf-ea3a-4ae0-b2da-b258d679b842'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Sept Improvisations: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:83245c70-a005-4176-8411-abcb4051781d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83245c70-a005-4176-8411-abcb4051781d', 3, NULL, 'No. 3', 'Sept Improvisations: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83245c70-a005-4176-8411-abcb4051781d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Sept Improvisations: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:b58dab37-4d7e-4f41-a023-f7d1b799cecb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58dab37-4d7e-4f41-a023-f7d1b799cecb', 4, NULL, 'No. 4', 'Sept Improvisations: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58dab37-4d7e-4f41-a023-f7d1b799cecb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Sept Improvisations: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:378a5409-6eea-4242-9a90-331b3bbd2041' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:378a5409-6eea-4242-9a90-331b3bbd2041', 5, NULL, 'No. 5', 'Sept Improvisations: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:378a5409-6eea-4242-9a90-331b3bbd2041'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Sept Improvisations: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:2d7b2e64-19c3-421a-828b-dd7aff3c4a50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d7b2e64-19c3-421a-828b-dd7aff3c4a50', 6, NULL, 'No. 6', 'Sept Improvisations: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d7b2e64-19c3-421a-828b-dd7aff3c4a50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = 'Sept Improvisations: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8106 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e3e9773b-1f23-4b22-aea2-cfccd06c0225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e9773b-1f23-4b22-aea2-cfccd06c0225', 7, NULL, 'No. 7', 'Sept Improvisations: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8106 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e9773b-1f23-4b22-aea2-cfccd06c0225'
);


-- None 가곡 <Si tu veux, Mignonne>

UPDATE pieces piece
SET piece.title = '가곡 <Si tu veux, Mignonne>', piece.title_en = 'Si tu veux, Mignonne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9069 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Six danses

UPDATE pieces piece
SET piece.title = 'Six danses', piece.title_en = 'Six danses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10277 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Six danses: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:a55acbf5-b4f8-4a27-880f-97b10d5d6f99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a55acbf5-b4f8-4a27-880f-97b10d5d6f99', 1, NULL, 'No. 1', 'Six danses: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a55acbf5-b4f8-4a27-880f-97b10d5d6f99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Six danses: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eadc7308-b127-4eb0-bf74-b25f15d564f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eadc7308-b127-4eb0-bf74-b25f15d564f7', 2, NULL, 'No. 2', 'Six danses: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eadc7308-b127-4eb0-bf74-b25f15d564f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Six danses: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:839b2e34-8bf5-4ac7-8b07-078d5d44063b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:839b2e34-8bf5-4ac7-8b07-078d5d44063b', 3, NULL, 'No. 3', 'Six danses: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839b2e34-8bf5-4ac7-8b07-078d5d44063b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Six danses: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6239a6ea-595d-4887-88bc-caea283446b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6239a6ea-595d-4887-88bc-caea283446b2', 4, NULL, 'No. 4', 'Six danses: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6239a6ea-595d-4887-88bc-caea283446b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Six danses: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:ae7049fc-055b-4b73-a3a5-6d190c64ed62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae7049fc-055b-4b73-a3a5-6d190c64ed62', 5, NULL, 'No. 5', 'Six danses: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae7049fc-055b-4b73-a3a5-6d190c64ed62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Six danses: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10277 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9e62775d-7ece-4ddd-af98-70b9eb95cef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e62775d-7ece-4ddd-af98-70b9eb95cef6', 6, NULL, 'No. 6', 'Six danses: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10277 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e62775d-7ece-4ddd-af98-70b9eb95cef6'
);


-- None 가곡 <Soleil couchant>

UPDATE pieces piece
SET piece.title = '가곡 <Soleil couchant>', piece.title_en = 'Soleil couchant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10715 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Souhait>

UPDATE pieces piece
SET piece.title = '가곡 <Souhait>', piece.title_en = 'Souhait',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8067 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Souvenance>

UPDATE pieces piece
SET piece.title = '가곡 <Souvenance>', piece.title_en = 'Souvenance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10882 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Souvenez-vous, Vierge Marie !

UPDATE pieces piece
SET piece.title = 'Souvenez-vous, Vierge Marie !', piece.title_en = 'Souvenez-vous, Vierge Marie !',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9248 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Souvenir de Venise>

UPDATE pieces piece
SET piece.title = '가곡 <Souvenir de Venise>', piece.title_en = 'Souvenir de Venise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9626 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모음곡 2번

UPDATE pieces piece
SET piece.title = '모음곡 2번', piece.title_en = 'Suite No. 2: Scènes hongroises',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9118 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro risoluto', part.name_en = 'Suite No. 2: Scènes hongroises: Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9118 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:4fdfd836-5de3-4c75-9f8b-c9c8f9855bee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fdfd836-5de3-4c75-9f8b-c9c8f9855bee', 1, NULL, 'Allegro risoluto', 'Suite No. 2: Scènes hongroises: Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9118 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fdfd836-5de3-4c75-9f8b-c9c8f9855bee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto leggiero', part.name_en = 'Suite No. 2: Scènes hongroises: Allegretto leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9118 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:61ae56f8-ae4d-4f1e-9564-e86132f513c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61ae56f8-ae4d-4f1e-9564-e86132f513c4', 2, NULL, 'Allegretto leggiero', 'Suite No. 2: Scènes hongroises: Allegretto leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9118 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ae56f8-ae4d-4f1e-9564-e86132f513c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro risoluto', part.name_en = 'Suite No. 2: Scènes hongroises: Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9118 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:c481273e-c108-4c46-b17e-5a95733f4bc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c481273e-c108-4c46-b17e-5a95733f4bc1', 3, NULL, 'Allegro risoluto', 'Suite No. 2: Scènes hongroises: Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9118 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c481273e-c108-4c46-b17e-5a95733f4bc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Suite No. 2: Scènes hongroises: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9118 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d4b065a2-09af-4104-ac18-4b918d8b271d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4b065a2-09af-4104-ac18-4b918d8b271d', 4, NULL, 'Andante', 'Suite No. 2: Scènes hongroises: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9118 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4b065a2-09af-4104-ac18-4b918d8b271d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro risoluto', part.name_en = 'Suite No. 2: Scènes hongroises: Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9118 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:dbe7ef8f-963b-4c5f-8ea9-09b8d7c6ed4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbe7ef8f-963b-4c5f-8ea9-09b8d7c6ed4b', 5, NULL, 'Allegro risoluto', 'Suite No. 2: Scènes hongroises: Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9118 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbe7ef8f-963b-4c5f-8ea9-09b8d7c6ed4b'
);


-- Op. 13 모음곡 1번

UPDATE pieces piece
SET piece.title = '모음곡 1번', piece.title_en = 'Suite no. 1, op. 13',
    piece.type = 'album', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10188 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pastorale et Fugue', part.name_en = 'Suite no. 1, op. 13: I. Pastorale et Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10188 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:e0cce095-7149-4aae-8b24-c44ead41d770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0cce095-7149-4aae-8b24-c44ead41d770', 1, 'I', 'Pastorale et Fugue', 'Suite no. 1, op. 13: I. Pastorale et Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10188 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0cce095-7149-4aae-8b24-c44ead41d770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variations', part.name_en = 'Suite no. 1, op. 13: II. Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10188 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:6bba4c22-597f-4f79-90e9-5bf7b944ae01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bba4c22-597f-4f79-90e9-5bf7b944ae01', 2, 'II', 'Variations', 'Suite no. 1, op. 13: II. Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10188 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bba4c22-597f-4f79-90e9-5bf7b944ae01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturne', part.name_en = 'Suite no. 1, op. 13: III. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10188 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:05622594-2d62-4ae3-93bc-2f786cf04828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05622594-2d62-4ae3-93bc-2f786cf04828', 3, 'III', 'Nocturne', 'Suite no. 1, op. 13: III. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10188 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05622594-2d62-4ae3-93bc-2f786cf04828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Marche et Strette', part.name_en = 'Suite no. 1, op. 13: IV. Marche et Strette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10188 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:09178025-140e-4cd4-8c07-885de42c4a6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09178025-140e-4cd4-8c07-885de42c4a6c', 4, 'IV', 'Marche et Strette', 'Suite no. 1, op. 13: IV. Marche et Strette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10188 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09178025-140e-4cd4-8c07-885de42c4a6c'
);


-- None 가곡 <Sérénade du passant>

UPDATE pieces piece
SET piece.title = '가곡 <Sérénade du passant>', piece.title_en = 'Sérénade du passant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11076 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sérénade d’automne>

UPDATE pieces piece
SET piece.title = '가곡 <Sérénade d’automne>', piece.title_en = 'Sérénade d’automne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9876 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sœur d’élection

UPDATE pieces piece
SET piece.title = 'Sœur d’élection', piece.title_en = 'Sœur d’élection',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9347 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thaïs: Acte II, Scène II. Divertissement VI. La Charmeuse (avec chant)

UPDATE pieces piece
SET piece.title = 'Thaïs: Acte II, Scène II. Divertissement VI. La Charmeuse (avec chant)', piece.title_en = 'Thaïs: Acte II, Scène II. Divertissement VI. La Charmeuse (avec chant)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10918 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Thérèse>

UPDATE pieces piece
SET piece.title = '오페라 <Thérèse>', piece.title_en = 'Thérèse',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8745 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Menuet d’amour', part.name_en = 'Thérèse: Menuet d’amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8745 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:23635a23-5069-4832-a815-fdd198b44dc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23635a23-5069-4832-a815-fdd198b44dc3', 1, NULL, 'Menuet d’amour', 'Thérèse: Menuet d’amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8745 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23635a23-5069-4832-a815-fdd198b44dc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Thérèse : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8745 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9b84398a-0eae-47da-9891-31d12d6744e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b84398a-0eae-47da-9891-31d12d6744e7', 2, NULL, 'Acte I', 'Thérèse : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8745 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b84398a-0eae-47da-9891-31d12d6744e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Thérèse : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8745 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9f398bdc-c4ef-46dd-9691-a194fa405101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f398bdc-c4ef-46dd-9691-a194fa405101', 3, NULL, 'Acte II', 'Thérèse : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8745 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f398bdc-c4ef-46dd-9691-a194fa405101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f398bdc-c4ef-46dd-9691-a194fa405101'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Jour de juin, jour d’été » (Thérèse)', part.name_en = 'Thérèse : Acte II. « Jour de juin, jour d’été » (Thérèse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8745 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:9f75b960-0380-4c83-8339-8501a6c213d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f75b960-0380-4c83-8339-8501a6c213d2', 1, NULL, 'Acte II. « Jour de juin, jour d’été » (Thérèse)', 'Thérèse : Acte II. « Jour de juin, jour d’été » (Thérèse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f398bdc-c4ef-46dd-9691-a194fa405101'
WHERE p.id = 8745 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f75b960-0380-4c83-8339-8501a6c213d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Menuet lent mélancolique', part.name_en = 'Thérèse: Menuet lent mélancolique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8745 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:d3787822-1e0b-4898-b3e7-dcc43c0dcc7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3787822-1e0b-4898-b3e7-dcc43c0dcc7a', 4, NULL, 'Menuet lent mélancolique', 'Thérèse: Menuet lent mélancolique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8745 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3787822-1e0b-4898-b3e7-dcc43c0dcc7a'
);


-- None Trois marches

UPDATE pieces piece
SET piece.title = 'Trois marches', piece.title_en = 'Trois marches',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8186 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Trois marches: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8186 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:45a36e9a-b26a-465b-8842-6d33ea78f7ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45a36e9a-b26a-465b-8842-6d33ea78f7ac', 1, NULL, 'No. 1', 'Trois marches: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8186 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45a36e9a-b26a-465b-8842-6d33ea78f7ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Trois marches: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8186 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:0dbf7578-4c25-4239-aef5-75366e2eecb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dbf7578-4c25-4239-aef5-75366e2eecb0', 2, NULL, 'No. 2', 'Trois marches: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8186 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dbf7578-4c25-4239-aef5-75366e2eecb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Trois marches: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8186 AND p.composer_id = 62 AND part.part_key = 'musicbrainz:eb49fb55-878e-434b-becb-766f5797bbb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb49fb55-878e-434b-becb-766f5797bbb2', 3, NULL, 'No. 3', 'Trois marches: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8186 AND p.composer_id = 62
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb49fb55-878e-434b-becb-766f5797bbb2'
);


-- None 가곡 <Un adieu>

UPDATE pieces piece
SET piece.title = '가곡 <Un adieu>', piece.title_en = 'Un adieu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8918 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Un momento musicale

UPDATE pieces piece
SET piece.title = 'Un momento musicale', piece.title_en = 'Un momento musicale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10563 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse folle

UPDATE pieces piece
SET piece.title = 'Valse folle', piece.title_en = 'Valse folle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9501 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse très lente

UPDATE pieces piece
SET piece.title = 'Valse très lente', piece.title_en = 'Valse très lente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9073 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Visions

UPDATE pieces piece
SET piece.title = 'Visions', piece.title_en = 'Visions',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10700 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <À Colombine>

UPDATE pieces piece
SET piece.title = '가곡 <À Colombine>', piece.title_en = 'À Colombine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8624 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <Ève>

UPDATE pieces piece
SET piece.title = '오라토리오 <Ève>', piece.title_en = 'Ève',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9748 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cendrillon : Acte I. « Ah ! Douce enfant »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Ah ! Douce enfant »', 'Cendrillon : Acte I. « Ah ! Douce enfant »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Ah ! Douce enfant »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e95fe990-4c9a-4854-b0e3-b4a46d5d03da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e95fe990-4c9a-4854-b0e3-b4a46d5d03da'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Ah ! Douce enfant »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e95fe990-4c9a-4854-b0e3-b4a46d5d03da'
);


-- None Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »', 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f491aeb-fc4a-471c-9a21-4d04f385140c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f491aeb-fc4a-471c-9a21-4d04f385140c'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Ah ! Que mes sœurs sont heureuses ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f491aeb-fc4a-471c-9a21-4d04f385140c'
);


-- None Cendrillon : Acte I. « Du côte de la barbe »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Du côte de la barbe »', 'Cendrillon : Acte I. « Du côte de la barbe »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Du côte de la barbe »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b72f1a5-e881-465d-8a93-06370f826e86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b72f1a5-e881-465d-8a93-06370f826e86'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Du côte de la barbe »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b72f1a5-e881-465d-8a93-06370f826e86'
);


-- None Cendrillon : Acte I. « Enfin, je connaîtrai »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Enfin, je connaîtrai »', 'Cendrillon : Acte I. « Enfin, je connaîtrai »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Enfin, je connaîtrai »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f70f5ce-22ba-4f89-bcaa-d48b211b238c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f70f5ce-22ba-4f89-bcaa-d48b211b238c'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Enfin, je connaîtrai »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f70f5ce-22ba-4f89-bcaa-d48b211b238c'
);


-- None Cendrillon : Acte I. « Faites‐vous très belles »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Faites‐vous très belles »', 'Cendrillon : Acte I. « Faites‐vous très belles »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Faites‐vous très belles »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Faites‐vous très belles »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be7f05b3-f3e0-402e-8c2a-bbe3bc8c5fcc'
);


-- None Cendrillon : Acte I. « Félicitez‐moi donc »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Félicitez‐moi donc »', 'Cendrillon : Acte I. « Félicitez‐moi donc »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Félicitez‐moi donc »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a03b03-baab-4ea4-86f3-a9428f75c1ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8a03b03-baab-4ea4-86f3-a9428f75c1ae'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Félicitez‐moi donc »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a03b03-baab-4ea4-86f3-a9428f75c1ae'
);


-- None Cendrillon : Acte I. « Madame, ce sont les modistes »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Madame, ce sont les modistes »', 'Cendrillon : Acte I. « Madame, ce sont les modistes »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Madame, ce sont les modistes »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '180bfb9c-0cca-482f-8d41-39ea73eebe00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '180bfb9c-0cca-482f-8d41-39ea73eebe00'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Madame, ce sont les modistes »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '180bfb9c-0cca-482f-8d41-39ea73eebe00'
);


-- None Cendrillon : Acte I. « On appelle, on sonne ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « On appelle, on sonne ! »', 'Cendrillon : Acte I. « On appelle, on sonne ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « On appelle, on sonne ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8b8594f-59c5-4ae5-9005-1ba9e61467b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8b8594f-59c5-4ae5-9005-1ba9e61467b1'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « On appelle, on sonne ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8b8594f-59c5-4ae5-9005-1ba9e61467b1'
);


-- None Cendrillon : Acte I. « Pour en faire un tissu »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Pour en faire un tissu »', 'Cendrillon : Acte I. « Pour en faire un tissu »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Pour en faire un tissu »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef4624b2-a536-4e5a-8f2f-3cc1b94fec83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef4624b2-a536-4e5a-8f2f-3cc1b94fec83'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Pour en faire un tissu »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef4624b2-a536-4e5a-8f2f-3cc1b94fec83'
);


-- None Cendrillon : Acte I. « Prenez un maintien gracieux »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte I. « Prenez un maintien gracieux »', 'Cendrillon : Acte I. « Prenez un maintien gracieux »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte I. « Prenez un maintien gracieux »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff2fc95b-064a-41c6-92f5-f1206999ed6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff2fc95b-064a-41c6-92f5-f1206999ed6f'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte I. « Prenez un maintien gracieux »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff2fc95b-064a-41c6-92f5-f1206999ed6f'
);


-- None Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy', 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77183f24-dec4-4354-9722-b580f1e2c627'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77183f24-dec4-4354-9722-b580f1e2c627'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Cinquième Entrée : Le Rigodon du Roy' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77183f24-dec4-4354-9722-b580f1e2c627'
);


-- None Cendrillon : Acte II. Deuxième Entrée : Les Fiancés

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés', 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1da3460-5b65-422c-999e-c02ae7550155'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1da3460-5b65-422c-999e-c02ae7550155'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Deuxième Entrée : Les Fiancés' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1da3460-5b65-422c-999e-c02ae7550155'
);


-- None Cendrillon : Acte II. Entrée du Roi et de la Cour

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Entrée du Roi et de la Cour', 'Cendrillon : Acte II. Entrée du Roi et de la Cour', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Entrée du Roi et de la Cour'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '193e8361-44d6-4a82-8259-9762458dbc61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '193e8361-44d6-4a82-8259-9762458dbc61'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Entrée du Roi et de la Cour' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '193e8361-44d6-4a82-8259-9762458dbc61'
);


-- None Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse', 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b839dd-5503-48d2-8fb2-9668cb5dc6cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8b839dd-5503-48d2-8fb2-9668cb5dc6cf'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Première Entrée : Les Filles de Noblesse' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b839dd-5503-48d2-8fb2-9668cb5dc6cf'
);


-- None Cendrillon : Acte II. Quatrième Entrée : La Florentine

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Quatrième Entrée : La Florentine', 'Cendrillon : Acte II. Quatrième Entrée : La Florentine', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Quatrième Entrée : La Florentine'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47ee0ad-b54c-4af0-a67d-b69699905261'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd47ee0ad-b54c-4af0-a67d-b69699905261'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Quatrième Entrée : La Florentine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47ee0ad-b54c-4af0-a67d-b69699905261'
);


-- None Cendrillon : Acte II. Troisième Entrée : Les Mandores

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. Troisième Entrée : Les Mandores', 'Cendrillon : Acte II. Troisième Entrée : Les Mandores', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. Troisième Entrée : Les Mandores'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '376a7d95-4214-43ed-b138-83cb9588bd15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '376a7d95-4214-43ed-b138-83cb9588bd15'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. Troisième Entrée : Les Mandores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '376a7d95-4214-43ed-b138-83cb9588bd15'
);


-- None Cendrillon : Acte II. « Allez, laissez‐moi seul »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. « Allez, laissez‐moi seul »', 'Cendrillon : Acte II. « Allez, laissez‐moi seul »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. « Allez, laissez‐moi seul »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bb3c5b-31f3-4b89-88cc-68690df96d8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41bb3c5b-31f3-4b89-88cc-68690df96d8e'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. « Allez, laissez‐moi seul »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41bb3c5b-31f3-4b89-88cc-68690df96d8e'
);


-- None Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »', 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f72777a-4d8f-4986-9c3c-a46923ea704e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f72777a-4d8f-4986-9c3c-a46923ea704e'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. « O la surprenante aventure » / « O la décevante aventure »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f72777a-4d8f-4986-9c3c-a46923ea704e'
);


-- None Cendrillon : Acte II. « Que les doux pensers »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. « Que les doux pensers »', 'Cendrillon : Acte II. « Que les doux pensers »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. « Que les doux pensers »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cefcfe0-0cbb-4826-bd64-c270ab574a1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cefcfe0-0cbb-4826-bd64-c270ab574a1f'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. « Que les doux pensers »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cefcfe0-0cbb-4826-bd64-c270ab574a1f'
);


-- None Cendrillon : Acte II. « Toi qui m’es apparue »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte II. « Toi qui m’es apparue »', 'Cendrillon : Acte II. « Toi qui m’es apparue »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte II. « Toi qui m’es apparue »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273ef9c4-9e71-4e58-a723-28cdf8455f88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '273ef9c4-9e71-4e58-a723-28cdf8455f88'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte II. « Toi qui m’es apparue »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273ef9c4-9e71-4e58-a723-28cdf8455f88'
);


-- None Cendrillon : Acte III. « Ah ! Fugitives chimères »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « Ah ! Fugitives chimères »', 'Cendrillon : Acte III. « Ah ! Fugitives chimères »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « Ah ! Fugitives chimères »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8955c2f8-06ac-40f0-9c2d-febc7e45d6aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8955c2f8-06ac-40f0-9c2d-febc7e45d6aa'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « Ah ! Fugitives chimères »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8955c2f8-06ac-40f0-9c2d-febc7e45d6aa'
);


-- None Cendrillon : Acte III. « C’est vrai ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « C’est vrai ! »', 'Cendrillon : Acte III. « C’est vrai ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « C’est vrai ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ead01c2-285f-427e-bfd6-aef32764a804'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ead01c2-285f-427e-bfd6-aef32764a804'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « C’est vrai ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ead01c2-285f-427e-bfd6-aef32764a804'
);


-- None Cendrillon : Acte III. « Enfin, je suis ici »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « Enfin, je suis ici »', 'Cendrillon : Acte III. « Enfin, je suis ici »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « Enfin, je suis ici »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdf678db-a3d6-4d24-9249-488f93664269'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdf678db-a3d6-4d24-9249-488f93664269'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « Enfin, je suis ici »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdf678db-a3d6-4d24-9249-488f93664269'
);


-- None Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »', 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db9e0094-6c48-4395-a6ae-37c0f6ae8ad0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db9e0094-6c48-4395-a6ae-37c0f6ae8ad0'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « Lorsqu’on a plus de vingt quartiers »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db9e0094-6c48-4395-a6ae-37c0f6ae8ad0'
);


-- None Cendrillon : Acte III. « Ma pauvre enfant chérie ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »', 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « Ma pauvre enfant chérie ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70a6bc62-fd74-4cdb-8ad2-d40c83b6e4fb'
);


-- None Cendrillon : Acte III. « Seule, je partirai »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « Seule, je partirai »', 'Cendrillon : Acte III. « Seule, je partirai »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « Seule, je partirai »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ddc3cc9-15a0-460f-b203-6e27690abe54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ddc3cc9-15a0-460f-b203-6e27690abe54'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « Seule, je partirai »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ddc3cc9-15a0-460f-b203-6e27690abe54'
);


-- None Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »', 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5cccd05-88bf-4a77-b983-b87206f76bda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5cccd05-88bf-4a77-b983-b87206f76bda'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte III. « À deux genoux » / « Je viens à vous »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5cccd05-88bf-4a77-b983-b87206f76bda'
);


-- None Cendrillon : Acte IV. Marche des Princesses

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte IV. Marche des Princesses', 'Cendrillon : Acte IV. Marche des Princesses', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte IV. Marche des Princesses'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00ed5cd2-01d3-45e9-ad5d-78fb3326beed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00ed5cd2-01d3-45e9-ad5d-78fb3326beed'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte IV. Marche des Princesses' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00ed5cd2-01d3-45e9-ad5d-78fb3326beed'
);


-- None Cendrillon : Acte IV. « Ah ! Ouvre ta porte »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »', 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b72abcc6-7947-49c0-a30f-c0be5cdf43c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b72abcc6-7947-49c0-a30f-c0be5cdf43c8'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte IV. « Ah ! Ouvre ta porte »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b72abcc6-7947-49c0-a30f-c0be5cdf43c8'
);


-- None Cendrillon : Acte IV. « Avancez ! Reculez ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte IV. « Avancez ! Reculez ! »', 'Cendrillon : Acte IV. « Avancez ! Reculez ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte IV. « Avancez ! Reculez ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdc14b84-6ca5-4ab4-b99d-ad81814ca207'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cdc14b84-6ca5-4ab4-b99d-ad81814ca207'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte IV. « Avancez ! Reculez ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdc14b84-6ca5-4ab4-b99d-ad81814ca207'
);


-- None Cendrillon : Acte IV. « O pauvre enfant ! »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte IV. « O pauvre enfant ! »', 'Cendrillon : Acte IV. « O pauvre enfant ! »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte IV. « O pauvre enfant ! »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5160662c-fad4-4b26-a2cd-33e478e1f5f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5160662c-fad4-4b26-a2cd-33e478e1f5f4'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte IV. « O pauvre enfant ! »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5160662c-fad4-4b26-a2cd-33e478e1f5f4'
);


-- None Cendrillon : Acte IV. « Posez dans son écrin »

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cendrillon : Acte IV. « Posez dans son écrin »', 'Cendrillon : Acte IV. « Posez dans son écrin »', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cendrillon : Acte IV. « Posez dans son écrin »'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a38294-ad8d-4126-8b74-fd647dd60038'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37a38294-ad8d-4126-8b74-fd647dd60038'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Cendrillon : Acte IV. « Posez dans son écrin »' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a38294-ad8d-4126-8b74-fd647dd60038'
);


-- None 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지', 'Elegy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f67910f-bf21-40e4-8aa1-03f91217fb16'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f67910f-bf21-40e4-8aa1-03f91217fb16'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f67910f-bf21-40e4-8aa1-03f91217fb16'
);


-- None 가곡 <La Rivière>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Rivière>', 'La Rivière', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Rivière>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecc6bb09-b88b-4ea9-891f-cb5fb62e16a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecc6bb09-b88b-4ea9-891f-cb5fb62e16a2'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '가곡 <La Rivière>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecc6bb09-b88b-4ea9-891f-cb5fb62e16a2'
);


-- None 가곡 <Le Petit Jésus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le Petit Jésus>', 'Le Petit Jésus', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le Petit Jésus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c63750aa-2e6d-4080-89ee-aee511f39834'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c63750aa-2e6d-4080-89ee-aee511f39834'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '가곡 <Le Petit Jésus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c63750aa-2e6d-4080-89ee-aee511f39834'
);


-- None 오페라 <Le Portrait de Manon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Le Portrait de Manon>', 'Le Portrait de Manon', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Le Portrait de Manon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '542a07b3-ede5-418c-bec0-0a626fb946a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '542a07b3-ede5-418c-bec0-0a626fb946a4'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Le Portrait de Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '542a07b3-ede5-418c-bec0-0a626fb946a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c87d841-cd99-470a-9555-c545c4091bd9', 1, NULL, '« L’Amour, toujours l’amour maudit ! »', 'Le Portrait de Manon : « L’Amour, toujours l’amour maudit ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Le Portrait de Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c87d841-cd99-470a-9555-c545c4091bd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49745de5-6c84-4f6e-a094-53896b456ef6', 2, NULL, '« On se serait assis sur le gazon »', 'Le Portrait de Manon : « On se serait assis sur le gazon »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Le Portrait de Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49745de5-6c84-4f6e-a094-53896b456ef6'
);


-- None Les fleurs

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Les fleurs', 'Les fleurs', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Les fleurs'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21707e23-b84d-4ce3-b61c-2c297db79640'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21707e23-b84d-4ce3-b61c-2c297db79640'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Les fleurs' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21707e23-b84d-4ce3-b61c-2c297db79640'
);


-- None 오페라 <Manon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Manon>', 'Manon', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Manon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2fcb52c-b902-354e-9fe4-0c4816d28ec5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2fcb52c-b902-354e-9fe4-0c4816d28ec5'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2fcb52c-b902-354e-9fe4-0c4816d28ec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504', 1, NULL, 'Acte I', 'Manon : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b420087b-a200-489e-bd30-f03b4a4e151e', 1, NULL, 'Acte I. Prélude', 'Manon : Acte I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b420087b-a200-489e-bd30-f03b4a4e151e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d57e6776-886e-4c49-bf17-89ee46c6222c', 2, NULL, 'Acte I. « Holà ! Hé ! Monsieur l’hôtelier ? » (Poussette, Javotte, Rosette, Guillot, Brétigny, l’Hôtelier)', 'Manon : Acte I. « Holà ! Hé ! Monsieur l’hôtelier ? » (Poussette, Javotte, Rosette, Guillot, Brétigny, l’Hôtelier)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d57e6776-886e-4c49-bf17-89ee46c6222c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04de8d20-5b45-44c1-accd-9313384be8b3', 3, NULL, 'Acte I. « Hors d’œuvre de choix ! » (L''Hôtelier, Poussette, Javotte, Rosette, Guillot, Brétigny)', 'Manon : Acte I. « Hors d’œuvre de choix ! » (L''Hôtelier, Poussette, Javotte, Rosette, Guillot, Brétigny)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04de8d20-5b45-44c1-accd-9313384be8b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c644a0e5-b06f-4bc4-a577-8e1c506d8de9', 4, NULL, 'Acte I. « Entendez-vous la cloche » (Chœur, Lescaut)', 'Manon : Acte I. « Entendez-vous la cloche » (Chœur, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c644a0e5-b06f-4bc4-a577-8e1c506d8de9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87cea4ab-a042-455a-ba26-bf7f4f8c028d', 5, NULL, 'Acte I. « Allez à l’auberge voisine » (Lescaut, Chœur)', 'Manon : Acte I. « Allez à l’auberge voisine » (Lescaut, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87cea4ab-a042-455a-ba26-bf7f4f8c028d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab765b24-8189-48c2-9415-eec3ec677d50', 6, NULL, 'Acte I. « Les voilà !… » … « Eh ! J’imagine » (Chœur, Lescaut, Manon)', 'Manon : Acte I. « Les voilà !… » … « Eh ! J’imagine » (Chœur, Lescaut, Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab765b24-8189-48c2-9415-eec3ec677d50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d10ad49d-2877-40ab-927c-5bbbd787b9df', 7, NULL, 'Acte I. « Je suis encore tout étourdie » (Manon)', 'Manon : Acte I. « Je suis encore tout étourdie » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10ad49d-2877-40ab-927c-5bbbd787b9df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e5a54cf-cde5-4ced-8542-38806fb517bb', 8, NULL, 'Acte I. « Partez ! On sonne ! » (Chœur, Lescaut, Guillot, Manon, Brétigny, Poussette, Javotte, Rosette)', 'Manon : Acte I. « Partez ! On sonne ! » (Chœur, Lescaut, Guillot, Manon, Brétigny, Poussette, Javotte, Rosette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e5a54cf-cde5-4ced-8542-38806fb517bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be1b705b-2525-4bec-b297-4e9aa75346c5', 9, NULL, 'Acte I. « Revenez, Guillot, revenez ! » (Poussette, Javotte, Rosette, Brétigny, Guillot, Lescaut)', 'Manon : Acte I. « Revenez, Guillot, revenez ! » (Poussette, Javotte, Rosette, Brétigny, Guillot, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be1b705b-2525-4bec-b297-4e9aa75346c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1096d4f0-0f72-469a-9cff-347e500dcf39', 10, NULL, 'Acte I. « Il vous parlait, Manon ? » (Lescaut, Manon, Chœur)', 'Manon : Acte I. « Il vous parlait, Manon ? » (Lescaut, Manon, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1096d4f0-0f72-469a-9cff-347e500dcf39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3fb8381d-c21b-481a-a184-d105815a16a3', 11, NULL, 'Acte I. « Regardez-moi bien dans les yeux ! » (Lescaut)', 'Manon : Acte I. « Regardez-moi bien dans les yeux ! » (Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fb8381d-c21b-481a-a184-d105815a16a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d41f74e1-5a06-41b7-8d3a-4960d03beec0', 12, NULL, 'Acte I. « Restons ici, puisqu’il le faut » (Manon)', 'Manon : Acte I. « Restons ici, puisqu’il le faut » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d41f74e1-5a06-41b7-8d3a-4960d03beec0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59f3bce9-ea2b-47dd-8b08-84ab321a8f40', 13, NULL, 'Acte I. « Voyons, Manon, plus de chiméres ! » (Manon)', 'Manon : Acte I. « Voyons, Manon, plus de chiméres ! » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f3bce9-ea2b-47dd-8b08-84ab321a8f40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ec85f46f-e956-41f7-856f-033d25685d62', 14, NULL, 'Acte I. Dialogue « Quelqu’un » … « J’ai marqué l’heure du départ » (Manon, des Grieux)', 'Manon : Acte I. Dialogue « Quelqu’un » … « J’ai marqué l’heure du départ » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec85f46f-e956-41f7-856f-033d25685d62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03e61197-3c26-4259-8fd5-15f3a8ff06a6', 15, NULL, 'Acte I. « Et je sais votre nom » (Manon, des Grieux)', 'Manon : Acte I. « Et je sais votre nom » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e61197-3c26-4259-8fd5-15f3a8ff06a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd6fadd4-d683-4bb5-a0b6-c949b83b89b0', 16, NULL, 'Acte I. « Par aventure… » (Manon, des Grieux)', 'Manon : Acte I. « Par aventure… » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6fadd4-d683-4bb5-a0b6-c949b83b89b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38dbc007-0786-49e9-b1b7-05631348a29d', 17, NULL, 'Acte I. « Nous vivrons à Paris tous les deux ! » (des Grieux, Manon, Poussette, Javotte, Rosette, Lescaut)', 'Manon : Acte I. « Nous vivrons à Paris tous les deux ! » (des Grieux, Manon, Poussette, Javotte, Rosette, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38dbc007-0786-49e9-b1b7-05631348a29d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78a36ff1-5cec-4dee-81d6-2322e9cd9179', 18, NULL, 'Acte I. « Plus un sou ! Le tour est très plaisant ! » (Lescaut, Guillot, Brétigny, l''Hôtelier, Poussette, Javotte, Rosette, Chœur)', 'Manon : Acte I. « Plus un sou ! Le tour est très plaisant ! » (Lescaut, Guillot, Brétigny, l''Hôtelier, Poussette, Javotte, Rosette, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:056a825e-f836-4660-b3f4-5275bc6cf504'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a36ff1-5cec-4dee-81d6-2322e9cd9179'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d', 2, NULL, 'Acte II', 'Manon : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50067827-a1d7-49b6-bbca-1c7748c074ce', 1, NULL, 'Acte II. Prélude', 'Manon : Acte II. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50067827-a1d7-49b6-bbca-1c7748c074ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd3d980a-87b9-4aa2-ba60-cd4e037cee05', 2, NULL, 'Acte II. « Manon ! Avez-vous peur que mon visage » (des Grieux, Manon)', 'Manon : Acte II. « Manon ! Avez-vous peur que mon visage » (des Grieux, Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd3d980a-87b9-4aa2-ba60-cd4e037cee05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f483f936-b3d3-482d-b3fc-88b09439d02f', 3, NULL, 'Acte II. « On l’appelle Manon » (Manon, des Grieux)', 'Manon : Acte II. « On l’appelle Manon » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f483f936-b3d3-482d-b3fc-88b09439d02f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfaee29d-3c89-4463-b8fc-9789292c9597', 4, NULL, 'Acte II. « Enfin, les amoureux » (Lescaut, Brétigny, des Grieux, Manon)', 'Manon : Acte II. « Enfin, les amoureux » (Lescaut, Brétigny, des Grieux, Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfaee29d-3c89-4463-b8fc-9789292c9597'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1184350-0f0d-4918-858f-7e643a69150e', 5, NULL, 'Acte II. « Allons ! Il le faut ! Pour lui-même » (Manon)', 'Manon : Acte II. « Allons ! Il le faut ! Pour lui-même » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1184350-0f0d-4918-858f-7e643a69150e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c805450d-ffec-4ece-8a81-b5283b72da8d', 6, NULL, 'Acte II. « Je ne suis que faiblesse » (Manon)', 'Manon : Acte II. « Je ne suis que faiblesse » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c805450d-ffec-4ece-8a81-b5283b72da8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d2aff90-175d-46e7-acce-a60bbf7ab4a0', 7, NULL, 'Acte II. « Adieu, notre petite table » (Manon)', 'Manon : Acte II. « Adieu, notre petite table » (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d2aff90-175d-46e7-acce-a60bbf7ab4a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd185e3a-20a0-45f1-9089-02c452c3f3c4', 8, NULL, 'Acte II. « C’est lui ! » … « Instant charmant » (Manon, des Grieux)', 'Manon : Acte II. « C’est lui ! » … « Instant charmant » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd185e3a-20a0-45f1-9089-02c452c3f3c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48340b60-0628-3131-8e84-573d6b7b63ca', 9, NULL, 'Acte II. « Instant charmant » … « En fermant les yeux » (des Grieux)', 'Manon : Acte II. « Instant charmant » … « En fermant les yeux » (des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48340b60-0628-3131-8e84-573d6b7b63ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e05aa8b3-ec3d-4847-88b8-00ab8e6bd17b', 10, NULL, 'Acte II. « Oh ! Ciel ! déjà ! » (Manon, des Grieux)', 'Manon : Acte II. « Oh ! Ciel ! déjà ! » (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522eee30-750b-49fb-9e7d-983775c4940d'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e05aa8b3-ec3d-4847-88b8-00ab8e6bd17b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b', 3, NULL, 'Acte III', 'Manon: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d511b5e-d84a-4d56-9cd2-ba36b10d0b9f', 1, NULL, 'Scène I. Entr’acte (Menuet)', 'Manon: Acte III, Scène I. Entr’acte (Menuet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d511b5e-d84a-4d56-9cd2-ba36b10d0b9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da9c95b7-18e0-461c-bae7-0a46e9fe34e4', 2, NULL, 'Scène I. “Voyez mules à fleurettes” (Chœur)', 'Manon: Acte III, Scène I. “Voyez mules à fleurettes” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da9c95b7-18e0-461c-bae7-0a46e9fe34e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de8f80dc-9c27-4f9b-ab8c-5a7fbc35e3be', 3, NULL, 'Scène I. “C’est fête au Cours-la-Reine !” (Chœur)', 'Manon: Acte III, Scène I. “C’est fête au Cours-la-Reine !” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de8f80dc-9c27-4f9b-ab8c-5a7fbc35e3be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32a7842e-0ced-4e8c-9669-7bc60f452943', 4, NULL, 'Scène I. “La charmante promenade !” (Poussette, Javotte, Rosette, Chœur, Lescaut)', 'Manon: Acte III, Scène I. “La charmante promenade !” (Poussette, Javotte, Rosette, Chœur, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32a7842e-0ced-4e8c-9669-7bc60f452943'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:447972a7-a71e-4a80-957c-eefc0d9d36db', 5, NULL, 'Scène I. “À quoi bon l’économie” (Lescaut, Chœur)', 'Manon: Acte III, Scène I. “À quoi bon l’économie” (Lescaut, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:447972a7-a71e-4a80-957c-eefc0d9d36db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9dc7bb8f-9606-4ff7-9ee6-83208f53e08e', 6, NULL, 'Scène I. “O Rosalinde” (Lescaut)', 'Manon: Acte III, Scène I. “O Rosalinde” (Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dc7bb8f-9606-4ff7-9ee6-83208f53e08e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f829b83f-4f4a-42c9-bd9b-418060bcc1f4', 7, NULL, 'Scène I. “Bonjour, Poussette !” (Guillot, Poussette, Javotte, Rosette, Brétigny)', 'Manon: Acte III, Scène I. “Bonjour, Poussette !” (Guillot, Poussette, Javotte, Rosette, Brétigny)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f829b83f-4f4a-42c9-bd9b-418060bcc1f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ec49a599-019e-40ad-a506-0971024adc8a', 8, NULL, 'Scène I. “Voici les élégantes !…Suis-je gentille ainsi ?” (Chœur, Brétigny, Manon)', 'Manon: Acte III, Scène I. “Voici les élégantes !…Suis-je gentille ainsi ?” (Chœur, Brétigny, Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec49a599-019e-40ad-a506-0971024adc8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c467c06-ce2a-4bb5-b153-b8b27bb5feb2', 9, NULL, 'Scène I. “Je marche sur tous les chemins” (Manon)', 'Manon: Acte III, Scène I. “Je marche sur tous les chemins” (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c467c06-ce2a-4bb5-b153-b8b27bb5feb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47befd09-c780-3e05-8cfa-d04f335419a6', 10, NULL, 'Scène I. Gavotte “Obéissons quand leur voix appelle” (Manon, Brétigny, Chœur)', 'Manon: Acte III, Scène I. Gavotte “Obéissons quand leur voix appelle” (Manon, Brétigny, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47befd09-c780-3e05-8cfa-d04f335419a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:675028c7-4ba5-428c-ab54-653c59b27d53', 11, NULL, 'Acte III, scène I. « Et maintenant restez seul » (Manon, Brétigny, Chœur, Le Comte)', 'Manon : Acte III, scène I. « Et maintenant restez seul » (Manon, Brétigny, Chœur, Le Comte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675028c7-4ba5-428c-ab54-653c59b27d53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25e36a1b-810d-407a-a55d-5547e8774640', 12, NULL, 'Scène I. “C’est elle ? Oui, c’est Manon !” (Comte, Brétigny)', 'Manon: Acte III, Scène I. “C’est elle ? Oui, c’est Manon !” (Comte, Brétigny)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e36a1b-810d-407a-a55d-5547e8774640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6b26d3b-6529-4246-8ff4-d5b820eb750b', 13, NULL, 'Scène I. “Pardon ! Mais j’étais là…” (Manon, Le Comte)', 'Manon: Acte III, Scène I. “Pardon ! Mais j’étais là…” (Manon, Le Comte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b26d3b-6529-4246-8ff4-d5b820eb750b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a35a0f6-494b-42cd-b364-40b370cf8042', 14, NULL, 'Scène I. Dialogue “Répondez-moi, Guillot !” (Brétigny, Guillot, Manon, Lescaut)', 'Manon: Acte III, Scène I. Dialogue “Répondez-moi, Guillot !” (Brétigny, Guillot, Manon, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a35a0f6-494b-42cd-b364-40b370cf8042'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e824ddf1-8157-4f0d-ba3d-e1e559435478', 15, NULL, 'Scène I. Ballet', 'Manon: Acte III, Scène I. Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e824ddf1-8157-4f0d-ba3d-e1e559435478'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88250ae2-8964-4c0b-9e1e-abc7d6adb8b1', 16, NULL, 'Scène II. “Quelle éloquence !” (Chœur)', 'Manon: Acte III, Scène II. “Quelle éloquence !” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88250ae2-8964-4c0b-9e1e-abc7d6adb8b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95af2eff-6e78-41b3-a782-719a278c282e', 17, NULL, 'Scène II. “Bravo, mon cher” (Comte, des Grieux)', 'Manon: Acte III, Scène II. “Bravo, mon cher” (Comte, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95af2eff-6e78-41b3-a782-719a278c282e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b0cc5eb-d11d-4e12-905a-98893bcfc852', 18, NULL, 'Scène II. “Épouse quelque brave fille” (Comte, des Grieux)', 'Manon: Acte III, Scène II. “Épouse quelque brave fille” (Comte, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b0cc5eb-d11d-4e12-905a-98893bcfc852'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80ecd1da-e6c3-3d1a-aa5e-69b449557c86', 19, NULL, 'Scène II. “Je suis seul !… Ah, fuyez, douce image” (des Grieux)', 'Manon: Acte III, Scène II. “Je suis seul !… Ah, fuyez, douce image” (des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80ecd1da-e6c3-3d1a-aa5e-69b449557c86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:328b7f06-c1f2-46ca-a079-4dd1d9892f9f', 20, NULL, 'Scène II. “Ces murs silencieux…Pardonnez-moi, Dieu de toute puissance” (Manon)', 'Manon: Acte III, Scène II. “Ces murs silencieux…Pardonnez-moi, Dieu de toute puissance” (Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328b7f06-c1f2-46ca-a079-4dd1d9892f9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afc83316-29df-4874-9d74-36508be41f56', 21, NULL, 'Scène II. “Toi ! Vous !… Oui ! Je fus cruelle et coupable !” (Manon, des Grieux)', 'Manon: Acte III, Scène II. “Toi ! Vous !… Oui ! Je fus cruelle et coupable !” (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afc83316-29df-4874-9d74-36508be41f56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34307fc5-644b-42b4-86c1-5353e84b9a17', 22, NULL, 'Scène II. “N’est-ce plus ma main ?” (Manon, des Grieux)', 'Manon: Acte III, Scène II. “N’est-ce plus ma main ?” (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34307fc5-644b-42b4-86c1-5353e84b9a17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05e1ad55-199b-41b7-9618-0122edfb3ba6', 23, NULL, 'Scène I. Alternate Scène & Fabliau', 'Manon: Acte III, Scène I. Alternate Scène & Fabliau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc441b37-ac7b-4dec-93c5-3ae9c4ba467b'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e1ad55-199b-41b7-9618-0122edfb3ba6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82', 4, NULL, 'Acte IV', 'Manon: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5defd9a5-b55e-4fc2-9bee-aa90ef893aab', 1, NULL, 'Acte IV. Dialogue “Faites vous jeux, Messieurs !…Le joueur sans prudence…” (Chœur de Gamblers, Lescaut)', 'Manon: Acte IV. Dialogue “Faites vous jeux, Messieurs !…Le joueur sans prudence…” (Chœur de Gamblers, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5defd9a5-b55e-4fc2-9bee-aa90ef893aab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92126dcb-4445-4a87-a0bf-99ea400ffa0d', 2, NULL, 'Acte IV. “A l’Hôtel de Transylvanie” (Poussette, Javotte, Rosette, Chœur)', 'Manon: Acte IV. “A l’Hôtel de Transylvanie” (Poussette, Javotte, Rosette, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92126dcb-4445-4a87-a0bf-99ea400ffa0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31e0b308-e9fc-4b74-885c-c7349c410a6c', 3, NULL, 'Acte IV. “C’est ici que celle que j’aime” (Lescaut, Poussette, Javotte, Rosette)', 'Manon: Acte IV. “C’est ici que celle que j’aime” (Lescaut, Poussette, Javotte, Rosette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e0b308-e9fc-4b74-885c-c7349c410a6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32b4d847-df6b-4d98-82c3-0d679510377c', 4, NULL, 'Acte IV. “J’enfourche aussi Pégase” (Guillot, Poussette, Javotte, Rosette', 'Manon: Acte IV. “J’enfourche aussi Pégase” (Guillot, Poussette, Javotte, Rosette,', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b4d847-df6b-4d98-82c3-0d679510377c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5827263a-0a9c-41c5-922f-034e1824a2cd', 5, NULL, 'Acte IV. “Mais qui donc nous arrive” (Guillot, Poussette, Javotte, Rosette, des Grieux, Lescaut)', 'Manon: Acte IV. “Mais qui donc nous arrive” (Guillot, Poussette, Javotte, Rosette, des Grieux, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5827263a-0a9c-41c5-922f-034e1824a2cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee197509-37c0-42e7-a8c9-40dcd1c18bb2', 6, NULL, 'Acte IV. « Manon ! Sphinx étonnant… » (des Grieux, Manon, Lescaut)', 'Manon : Acte IV. « Manon ! Sphinx étonnant… » (des Grieux, Manon, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee197509-37c0-42e7-a8c9-40dcd1c18bb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d4e9f21-a4ae-4fa5-94a0-fe93d5b576c4', 7, NULL, 'Acte IV. “Un mot, s’il vous plait, Chevalier” (Guillot, des Grieux, Manon, Cast)', 'Manon: Acte IV. “Un mot, s’il vous plait, Chevalier” (Guillot, des Grieux, Manon, Cast)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4e9f21-a4ae-4fa5-94a0-fe93d5b576c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06330569-06bf-49b3-97fc-aab8feacda53', 8, NULL, 'Acte IV. “Ce bruit de l’or” (Manon, Poussette, Javotte, Rosette)', 'Manon: Acte IV. “Ce bruit de l’or” (Manon, Poussette, Javotte, Rosette),', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06330569-06bf-49b3-97fc-aab8feacda53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d24b142-12d2-4e24-812a-834ecc26ce0d', 9, NULL, 'Acte IV. “À nous les amours et les roses !” (Manon, Poussette, Javotte, Rosette)', 'Manon: Acte IV. “À nous les amours et les roses !” (Manon, Poussette, Javotte, Rosette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d24b142-12d2-4e24-812a-834ecc26ce0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a6e041e-40d8-49aa-99fa-83f47f7f1797', 10, NULL, 'Acte IV. “Au jeu ! Au jeu !” (Chœur, Lescaut, Guillot, des Grieux, Manon, Poussette, Rosette, Javotte)', 'Manon: Acte IV. “Au jeu ! Au jeu !” (Chœur, Lescaut, Guillot, des Grieux, Manon, Poussette, Rosette, Javotte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a6e041e-40d8-49aa-99fa-83f47f7f1797'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b232bca-cd1a-4750-8447-e65b79bd9165', 11, NULL, 'Acte IV. “Oui, je viens t’arracher à la honte !” (Comte, Manon, des Grieux, Guillot, Poussette, Javotte, Rosette, Chœur)', 'Manon: Acte IV. “Oui, je viens t’arracher à la honte !” (Comte, Manon, des Grieux, Guillot, Poussette, Javotte, Rosette, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86819c46-48a8-4a15-a823-f055fb6b7b82'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b232bca-cd1a-4750-8447-e65b79bd9165'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00', 5, NULL, 'Acte V', 'Manon: Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5903771-5276-4426-8542-fcf2bc8cd98c', 1, NULL, 'Acte V. “Manon ! Pauvre Manon !” (des Grieux, Lescaut)', 'Manon: Acte V. “Manon ! Pauvre Manon !” (des Grieux, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5903771-5276-4426-8542-fcf2bc8cd98c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20843989-fcce-4efd-bf47-69ea15f1f606', 2, NULL, 'Acte V. “Capitaine, ô gué, es-tu fatigué” (Les Archers, des Grieux, Lescaut)', 'Manon: Acte V. “Capitaine, ô gué, es-tu fatigué” (Les Archers, des Grieux, Lescaut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20843989-fcce-4efd-bf47-69ea15f1f606'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15b6d352-ed04-4deb-a7ce-9b3c2f2417c2', 3, NULL, 'Acte V. “Ah ! Des Grieux !… Ô Manon ! Tu pleures !” (Manon, des Grieux)', 'Manon: Acte V. “Ah ! Des Grieux !… Ô Manon ! Tu pleures !” (Manon, des Grieux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b6d352-ed04-4deb-a7ce-9b3c2f2417c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c2ee950-df6e-4808-a7b2-93c98bd9bc1f', 4, NULL, 'Acte V. « N’est‐ce plus ma main que cette main presse » (des Grieux, Manon)', 'Manon : Acte V. « N’est‐ce plus ma main que cette main presse » (des Grieux, Manon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3964496-bb6e-4aab-b173-f381688dfc00'
WHERE p.composer_id = 62 AND p.title = '오페라 <Manon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c2ee950-df6e-4808-a7b2-93c98bd9bc1f'
);


-- None Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”', 'Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10759bf0-37fe-4590-8c4f-3cf2d86c8784'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10759bf0-37fe-4590-8c4f-3cf2d86c8784'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Manon: Atto III. “Ahimè! L’augel … La tua non è la mano che mi tocca”' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10759bf0-37fe-4590-8c4f-3cf2d86c8784'
);


-- None Morceau de concours

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Morceau de concours', 'Morceau de concours', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Morceau de concours'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2a31018-24f9-4f22-b8d8-5b73605680e6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2a31018-24f9-4f22-b8d8-5b73605680e6'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = 'Morceau de concours' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2a31018-24f9-4f22-b8d8-5b73605680e6'
);


-- None 가곡 <Noël païen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Noël païen>', 'Noël païen', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Noël païen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4561c208-229f-4052-b326-4c7ec93e0b7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4561c208-229f-4052-b326-4c7ec93e0b7b'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '가곡 <Noël païen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4561c208-229f-4052-b326-4c7ec93e0b7b'
);


-- None 가곡 <Nuit d'Espagne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nuit d''Espagne>', 'Nuit d''Espagne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nuit d''Espagne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b90365a-da62-30ff-aa47-2fcf33ab3e7c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b90365a-da62-30ff-aa47-2fcf33ab3e7c'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '가곡 <Nuit d''Espagne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b90365a-da62-30ff-aa47-2fcf33ab3e7c'
);


-- None 오페라 <Thaïs>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Thaïs>', 'Thaïs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Thaïs>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a3bf259-fceb-441c-be05-ba5b83398086'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a3bf259-fceb-441c-be05-ba5b83398086'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a3bf259-fceb-441c-be05-ba5b83398086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a', 1, NULL, 'Acte I', 'Thaïs: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02bfdc86-7c4e-4e5c-ae6a-edbdd9652969', 1, NULL, 'Scène II. "C''est Thaïs, l''idole fragile" (Thaïs, Nicias)', 'Thaïs: Acte I, Scène II. "C''est Thaïs, l''idole fragile" (Thaïs, Nicias)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02bfdc86-7c4e-4e5c-ae6a-edbdd9652969'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1eff670d-fedc-4f8c-81c3-adb7461148f8', 2, NULL, 'Scène I. "Toi, qui mis la pitié dans nos âmes" (Athanaël)', 'Thaïs: Acte I, Scène I. "Toi, qui mis la pitié dans nos âmes" (Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eff670d-fedc-4f8c-81c3-adb7461148f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3aec67f4-db53-4b72-8d28-ae50f4e82c31', 3, NULL, 'Scène I. "Mon fils, ne nous mêlons jamais" (Palémon, Athanaël, Cénobites)', 'Thaïs: Acte I, Scène I. "Mon fils, ne nous mêlons jamais" (Palémon, Athanaël, Cénobites)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aec67f4-db53-4b72-8d28-ae50f4e82c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bed7f86-135d-4fae-82fb-b8a97f9529cf', 4, NULL, 'Scène II. "Va, mendiant, chercher ailleurs ta vie !" (Serviteur, Athanaël)', 'Thaïs: Acte I, Scène II. "Va, mendiant, chercher ailleurs ta vie !" (Serviteur, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bed7f86-135d-4fae-82fb-b8a97f9529cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5eeb29c9-9718-436b-8cd9-a864e60b8332', 5, NULL, 'Scène II. "Ah ! ah ! ah ! ... Athanaël, c''est toi !" (Crobyle, Myrtale, Nicias, Athanaël)', 'Thaïs: Acte I, Scène II. "Ah ! ah ! ah ! ... Athanaël, c''est toi !" (Crobyle, Myrtale, Nicias, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eeb29c9-9718-436b-8cd9-a864e60b8332'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67363e8f-06de-4e92-8116-1a49a69252f2', 6, NULL, 'Scène II. "Garde-toi bien ! Voici ta terrible ennemie !" (Nicias, Chœur)', 'Thaïs: Acte I, Scène II. "Garde-toi bien ! Voici ta terrible ennemie !" (Nicias, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67363e8f-06de-4e92-8116-1a49a69252f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:675a4062-352e-45cc-aede-5fb496eebd2b', 7, NULL, 'Scène I. "Voici le pain ... et le sel" (Cénobites, Palémon)', 'Thaïs: Acte I, Scène I. "Voici le pain ... et le sel" (Cénobites, Palémon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675a4062-352e-45cc-aede-5fb496eebd2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:781b7e41-3f35-4cc6-b524-c4887ed36d97', 8, NULL, 'Scène II. "Non ! non ! je hais vos fausses ivresses !" (Athanaël, Thaïs, Nicias, Chœur)', 'Thaïs: Acte I, Scène II. "Non ! non ! je hais vos fausses ivresses !" (Athanaël, Thaïs, Nicias, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781b7e41-3f35-4cc6-b524-c4887ed36d97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bd0002b-2e7c-4f7f-857a-315de7ce31af', 9, NULL, 'Scène II. "Voilà donc la terrible cité" (Athanaël)', 'Thaïs: Acte I, Scène II. "Voilà donc la terrible cité" (Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bd0002b-2e7c-4f7f-857a-315de7ce31af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86f7c481-7c16-412d-89fa-bfe707a1afa5', 10, NULL, 'Scène II. "Ah ! ah ! ah ! ... Je vais donc te revoir" (Crobyle, Myrtale, Nicias, Athanaël)', 'Thaïs: Acte I, Scène II. "Ah ! ah ! ah ! ... Je vais donc te revoir" (Crobyle, Myrtale, Nicias, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86f7c481-7c16-412d-89fa-bfe707a1afa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:968e26e3-e903-457d-aef8-f549e30e5324', 11, NULL, 'Scène I. Vision d''Athanaël "Honte ! horreur !" (Athanaël)', 'Thaïs: Acte I, Scène I. Vision d''Athanaël "Honte ! horreur !" (Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:968e26e3-e903-457d-aef8-f549e30e5324'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a60bcc93-4c13-4731-8901-b383a884a20f', 12, NULL, 'Scène II. "Qui te fit si sévère" (Thaïs, Nicias, Chœur)', 'Thaïs: Acte I, Scène II. "Qui te fit si sévère" (Thaïs, Nicias, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a60bcc93-4c13-4731-8901-b383a884a20f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5021e39-3403-4bf6-bf94-e88d227e51d2', 13, NULL, 'Scène I. "Ne nous mêlons jamais, mon fils" (Palémon, Cénobites, Athanaël)', 'Thaïs: Acte I, Scène I. "Ne nous mêlons jamais, mon fils" (Palémon, Cénobites, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5021e39-3403-4bf6-bf94-e88d227e51d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c20ed5f2-a85a-44e7-b310-907c2a0c0362', 14, NULL, 'Scène II. "Quel est cet étranger" (Thaïs, Nicias, Athanaël)', 'Thaïs: Acte I, Scène II. "Quel est cet étranger" (Thaïs, Nicias, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c20ed5f2-a85a-44e7-b310-907c2a0c0362'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2010357-d368-4406-b3cf-0cfb8e3743d2', 15, NULL, 'Scène II. Prélude', 'Thaïs: Acte I, Scène II. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2010357-d368-4406-b3cf-0cfb8e3743d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5d0169a-d368-4f17-a5e1-e17bac248673', 16, NULL, 'Scène I. "Le voici ! le voici !" (Cénobites, Athanaël, Palémon)', 'Thaïs: Acte I, Scène I. "Le voici ! le voici !" (Cénobites, Athanaël, Palémon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5d0169a-d368-4f17-a5e1-e17bac248673'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edf46650-aba0-45f2-933f-47b6e119ae54', 17, NULL, 'Scène I. "Hélas ! enfant encore" (Athanaël)', 'Thaïs: Acte I, Scène I. "Hélas ! enfant encore" (Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:702292ed-5e3f-47dc-8896-f31e5c0ab75a'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf46650-aba0-45f2-933f-47b6e119ae54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735', 2, NULL, 'Acte II', 'Thaïs: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05d42483-e77f-4267-99dd-4c6f6823146c', 1, NULL, 'Scène II. "Eh ! c''est lui ! ... Athanaël" (Nicias, Chœur, Athanaël)', 'Thaïs: Acte II, Scène II. "Eh ! c''est lui ! ... Athanaël" (Nicias, Chœur, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05d42483-e77f-4267-99dd-4c6f6823146c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d05b4c7-c9a0-4a59-82fd-73e193f1f60a', 2, NULL, 'Scène II. "Il dit vrai !" (Thaïs, Nicias, Athanaël, Chœur)', 'Thaïs: Acte II, Scène II. "Il dit vrai !" (Thaïs, Nicias, Athanaël, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d05b4c7-c9a0-4a59-82fd-73e193f1f60a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a434e39-3f9f-4bf1-8257-f5bbc70a00f5', 3, NULL, 'Scène I. "Je n''ai pas plus choisi mon sort que ma nature" (Thaïs, Athanaël, Nicias)', 'Thaïs: Acte II, Scène I. "Je n''ai pas plus choisi mon sort que ma nature" (Thaïs, Athanaël, Nicias)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a434e39-3f9f-4bf1-8257-f5bbc70a00f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bf28445-274f-46ab-b5ae-b4b65742e05b', 4, NULL, 'Scène I. "Dis-moi que je suis belle" (Thaïs)', 'Thaïs: Acte II, Scène I. "Dis-moi que je suis belle" (Thaïs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf28445-274f-46ab-b5ae-b4b65742e05b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e376d5e-e659-4c45-881c-c0f66ce61aa8', 5, NULL, 'Scène II. Divertissement', 'Thaïs: Acte II, Scène II. Divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e376d5e-e659-4c45-881c-c0f66ce61aa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e883474-0334-44af-bda0-1739e23e41eb', 6, NULL, 'Scène I. "Je suis Athanaël, moine d''Antinoé !" (Thaïs, Athanaël)', 'Thaïs: Acte II, Scène I. "Je suis Athanaël, moine d''Antinoé !" (Thaïs, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e883474-0334-44af-bda0-1739e23e41eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65f2524f-3c91-4292-a083-a51770dc6c57', 7, NULL, 'Scène I. "Étranger, te voilà comme tu l''avais dit !" (Thäis, Athanaël)', 'Thaïs: Acte II, Scène I. "Étranger, te voilà comme tu l''avais dit !" (Thäis, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f2524f-3c91-4292-a083-a51770dc6c57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96dd284c-d506-4e9e-bacb-da90cc8cbbc9', 8, NULL, 'Scène II. "Non loin d''ici, vers l''occident" (Thäis, Athanaël)', 'Thaïs: Acte II, Scène II. "Non loin d''ici, vers l''occident" (Thäis, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96dd284c-d506-4e9e-bacb-da90cc8cbbc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9acba5a1-b91c-43a7-9e0c-9b2e8cd2dc9d', 9, NULL, 'Scène II. "Celle qui vient est plus belle" (Crobyle, Myrtale)', 'Thaïs: Acte II, Scène II. "Celle qui vient est plus belle" (Crobyle, Myrtale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acba5a1-b91c-43a7-9e0c-9b2e8cd2dc9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1d8197f-95c1-4220-bd26-c2f62c3dc444', 10, NULL, 'Scène I. "Ah ! je suis seule, seule enfin !" (Thaïs)', 'Thaïs: Acte II, Scène I. "Ah ! je suis seule, seule enfin !" (Thaïs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d8197f-95c1-4220-bd26-c2f62c3dc444'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5a1e74c-7702-46d5-8fd8-c9f1ed0fd646', 11, NULL, 'Scène II. "Considère, ô mon père" (Thaïs, Athanaël)', 'Thaïs: Acte II, Scène II. "Considère, ô mon père" (Thaïs, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5a1e74c-7702-46d5-8fd8-c9f1ed0fd646'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b4b7f17c-f2ad-4f95-93ae-5e6ef17c6fdb', 12, NULL, 'Scène I. "Eh bien, fais-moi connaître tout cet amour" (Thäis, Athanaël)', 'Thaïs: Acte II, Scène I. "Eh bien, fais-moi connaître tout cet amour" (Thäis, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b7f17c-f2ad-4f95-93ae-5e6ef17c6fdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:baf29b3f-9a7a-4949-a5ab-2df633fefdff', 13, NULL, 'Scène II. "Père, Dieu m''a parlé par ta voix !" (Thäis, Athanaël)', 'Thaïs: Acte II, Scène II. "Père, Dieu m''a parlé par ta voix !" (Thäis, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baf29b3f-9a7a-4949-a5ab-2df633fefdff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c26cb0d0-c3ee-4351-b32d-55cf3fc4dfb5', 14, NULL, 'Scène II. "Voilà l''incomparable !" (Nicias)', 'Thaïs: Acte II, Scène II. "Voilà l''incomparable !" (Nicias)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26cb0d0-c3ee-4351-b32d-55cf3fc4dfb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 260 AND linked.composer_id = 62), 'musicbrainz:c8b5137d-d386-3393-8b6c-f756c31dc8f6', 15, NULL, 'Acte II. Entr’acte “Méditation”', 'Thaïs: Acte II. Entr’acte “Méditation”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8b5137d-d386-3393-8b6c-f756c31dc8f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddbfca29-e8bd-44f1-9b35-94a5b87c29ae', 16, NULL, 'Scène II. "Suivez-moi tous, amis !" (Nicias, Chœur, Crobyle, Myrtale)', 'Thaïs: Acte II, Scène II. "Suivez-moi tous, amis !" (Nicias, Chœur, Crobyle, Myrtale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:946301eb-b231-4590-b116-bc0fbde38735'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddbfca29-e8bd-44f1-9b35-94a5b87c29ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268', 3, NULL, 'Acte III', 'Thaïs: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ed6c62a-e96e-489f-90af-dc5465a3a146', 1, NULL, 'Scène I. "Ô messager de dieu, si bon dans ta rudesse" (Thaïs)', 'Thaïs: Acte III, Scène I. "Ô messager de dieu, si bon dans ta rudesse" (Thaïs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ed6c62a-e96e-489f-90af-dc5465a3a146'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:149fe378-34a5-4da1-bfd5-b15eb50576f0', 2, NULL, 'Scène II. "Qui te fait si sévère" (Thaïs, Athanaël, Chœur)', 'Thaïs: Acte III, Scène II. "Qui te fait si sévère" (Thaïs, Athanaël, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:149fe378-34a5-4da1-bfd5-b15eb50576f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:179328b5-fb60-4385-9e97-3f368e09bcb5', 3, NULL, 'Scène I. "Mon œuvre est accomplie !" (Athanaël, Thaïs, Albine, Chœur)', 'Thaïs: Acte III, Scène I. "Mon œuvre est accomplie !" (Athanaël, Thaïs, Albine, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:179328b5-fb60-4385-9e97-3f368e09bcb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6eecdc18-2cc3-4407-b88f-f139e89288aa', 4, NULL, 'Scène II. "Que le ciel est pesant !" (Cénobites, Palémon)', 'Thaïs: Acte III, Scène II. "Que le ciel est pesant !" (Cénobites, Palémon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eecdc18-2cc3-4407-b88f-f139e89288aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a1c67d3-a040-44f2-8c2b-d68fdf95d9dd', 5, NULL, 'Scène II. "Thaïs va mourir" (Athanaël)', 'Thaïs: Acte III, Scène II. "Thaïs va mourir" (Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a1c67d3-a040-44f2-8c2b-d68fdf95d9dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9236ffa7-9b34-4780-b4f7-0bcec8cc503a', 6, NULL, 'Scène III. "Sois le bienvenu dans nos tabernacles" (Albine, Athanaël, Chœur)', 'Thaïs: Acte III, Scène III. "Sois le bienvenu dans nos tabernacles" (Albine, Athanaël, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9236ffa7-9b34-4780-b4f7-0bcec8cc503a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a36204bb-3e78-4ccb-8a52-8c2d7dbac485', 7, NULL, 'Scène I. "Ah ! des gouttes de sang coulent de ses pieds blancs" (Thaïs, Athanaël)', 'Thaïs: Acte III, Scène I. "Ah ! des gouttes de sang coulent de ses pieds blancs" (Thaïs, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a36204bb-3e78-4ccb-8a52-8c2d7dbac485'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c860a868-52de-4daa-a2bd-6966d0d61bdc', 8, NULL, 'Scène II. "C''est lui qui vient !" (Athanaël, Palémon, Cénobites)', 'Thaïs: Acte III, Scène II. "C''est lui qui vient !" (Athanaël, Palémon, Cénobites)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c860a868-52de-4daa-a2bd-6966d0d61bdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfc18370-bafd-40e3-aa42-8cb9e04600d8', 9, NULL, 'Scène III. "C''est toi mon père !" (Thaïs, Athanaël)', 'Thaïs: Acte III, Scène III. "C''est toi mon père !" (Thaïs, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfc18370-bafd-40e3-aa42-8cb9e04600d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d27e4fbf-9cd3-44d7-9837-68cb769d5316', 10, NULL, 'Scène III. "Seigneur, ayez pitié de moi" (Chœur, Albine)', 'Thaïs: Acte III, Scène III. "Seigneur, ayez pitié de moi" (Chœur, Albine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d27e4fbf-9cd3-44d7-9837-68cb769d5316'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d35d9bb7-c039-4dff-be40-94781b34d475', 11, NULL, 'Scène I. "Baigne d''eau mes mains et mes lèvres" (Thaïs, Athanaël, Chœur)', 'Thaïs: Acte III, Scène I. "Baigne d''eau mes mains et mes lèvres" (Thaïs, Athanaël, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35d9bb7-c039-4dff-be40-94781b34d475'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dfeeaff8-8810-4133-a306-d64738059a0d', 12, NULL, 'Scène I. "La paix du seigneur soit avec toi" (Athanaël, Albine)', 'Thaïs: Acte III, Scène I. "La paix du seigneur soit avec toi" (Athanaël, Albine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfeeaff8-8810-4133-a306-d64738059a0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f14ec3a5-c96a-41e9-9b53-66083728ec8a', 13, NULL, 'Scène I. "L''ardent soleil m''écrase" (Thaïs, Athanaël)', 'Thaïs: Acte III, Scène I. "L''ardent soleil m''écrase" (Thaïs, Athanaël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fe55172-2d94-4e5f-99dc-98d1ece69268'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14ec3a5-c96a-41e9-9b53-66083728ec8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438', 4, NULL, 'Thaïs', 'Thaïs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d59b6b07-10b3-42c5-bf00-f45acf8932ed', 1, NULL, 'Andante – Allegro vivo – Largo – Allegro moderato – Lento – Presto vivace', '« Thais »: I. Andante – Allegro vivo – Largo – Allegro moderato – Lento – Presto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59b6b07-10b3-42c5-bf00-f45acf8932ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df6feff1-c278-48a6-aa19-137b3a78edc4', 2, NULL, 'Andante cantabile', '« Thais »: II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df6feff1-c278-48a6-aa19-137b3a78edc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b7e972a-796b-4e12-91f6-e0f0eeac0d06', 3, NULL, 'Scherzetto molto vivace', '« Thais »: III. Scherzetto molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b7e972a-796b-4e12-91f6-e0f0eeac0d06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8781498d-73c1-4939-b34a-2b50f75257e8', 4, NULL, 'Allegro moderato – Tres lent', '« Thais »: IV. Allegro moderato – Tres lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8781498d-73c1-4939-b34a-2b50f75257e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17a4d5b1-3ced-46b1-a3c1-bac75236a602', 5, NULL, 'Allegro maestoso', '« Thais »: V. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17a4d5b1-3ced-46b1-a3c1-bac75236a602'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef820f93-aca9-4445-8859-44e18065ae9f', 6, NULL, 'Andante religioso', '« Thais »: VI. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef820f93-aca9-4445-8859-44e18065ae9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:986034d3-43f1-4551-8a56-b247d671d6ae', 7, NULL, 'Allegro vivace – Frenetico', '« Thais »: VII. Allegro vivace – Frenetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:986034d3-43f1-4551-8a56-b247d671d6ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51b0e96e-7755-46ba-9914-25bb3fcc4691', 8, NULL, 'Finale', 'Thais: VIII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7628c08c-3126-4639-9623-4176712c6438'
WHERE p.composer_id = 62 AND p.title = '오페라 <Thaïs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b0e96e-7755-46ba-9914-25bb3fcc4691'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad468687-f625-4869-9cf0-b7382681d25d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad468687-f625-4869-9cf0-b7382681d25d'
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad468687-f625-4869-9cf0-b7382681d25d'
);


-- 카탈로그에 대응이 없는 seed 작품 18개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 62 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    1674, 7469, 7884, 8010, 8202, 8243, 8320, 8327, 8765, 9201, 9301, 9603, 9884, 10503, 10525, 10827, 11032, 11046
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
