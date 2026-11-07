-- Anatol Vieru 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 24개(묶음 0, 다악장 6, 낱곡 18),
-- 새 작품 2개, part 22개, 그 아래 0개.
-- seed 22개 중 22개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Cantata anilor lumină

UPDATE pieces piece
SET piece.title = 'Cantata anilor lumină', piece.title_en = 'Cantata anilor lumină',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23628 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clepsidra I

UPDATE pieces piece
SET piece.title = 'Clepsidra I', piece.title_en = 'Clepsidra I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23324 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clepsidra II

UPDATE pieces piece
SET piece.title = 'Clepsidra II', piece.title_en = 'Clepsidra II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25674 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 협주곡

UPDATE pieces piece
SET piece.title = '바이올린 협주곡', piece.title_en = 'Concerto for Violin, Cello and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23070 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Doux Polyson

UPDATE pieces piece
SET piece.title = 'Doux Polyson', piece.title_en = 'Doux Polyson',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24888 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dyathlon

UPDATE pieces piece
SET piece.title = 'Dyathlon', piece.title_en = 'Dyathlon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23658 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Giusto

UPDATE pieces piece
SET piece.title = 'Giusto', piece.title_en = 'Giusto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25770 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Metaksax

UPDATE pieces piece
SET piece.title = 'Metaksax', piece.title_en = 'Metaksax',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25152 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Narration

UPDATE pieces piece
SET piece.title = 'Narration', piece.title_en = 'Narration',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23656 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nuit

UPDATE pieces piece
SET piece.title = 'Nuit', piece.title_en = 'Nuit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25071 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 140 피아노 소나타 2번

UPDATE pieces piece
SET piece.title = '피아노 소나타 2번', piece.title_en = 'Piano Sonata no. 2, op. 140',
    piece.type = 'album', piece.opus_number = 'Op. 140',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25302 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ ≈ 48-50', part.name_en = 'Piano Sonata no. 2, op. 140: I. ♩ ≈ 48-50',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25302 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:56719e8f-b5c9-4f38-92d3-e388f359438f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56719e8f-b5c9-4f38-92d3-e388f359438f', 1, 'I', '♩ ≈ 48-50', 'Piano Sonata no. 2, op. 140: I. ♩ ≈ 48-50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25302 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56719e8f-b5c9-4f38-92d3-e388f359438f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♪. = 129', part.name_en = 'Piano Sonata no. 2, op. 140: II. ♪. = 129',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25302 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:11f48964-3347-476a-bf8a-543c1ab6690a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11f48964-3347-476a-bf8a-543c1ab6690a', 2, 'II', '♪. = 129', 'Piano Sonata no. 2, op. 140: II. ♪. = 129', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25302 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11f48964-3347-476a-bf8a-543c1ab6690a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = 40', part.name_en = 'Piano Sonata no. 2, op. 140: III. ♩ = 40',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25302 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:70f559c8-5224-4beb-ae66-ba72b95aba5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70f559c8-5224-4beb-ae66-ba72b95aba5b', 3, 'III', '♩ = 40', 'Piano Sonata no. 2, op. 140: III. ♩ = 40', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25302 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f559c8-5224-4beb-ae66-ba72b95aba5b'
);


-- None 피아노 3중주

UPDATE pieces piece
SET piece.title = '피아노 3중주', piece.title_en = 'Piano Trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23705 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ ≈ 72', part.name_en = 'Piano Trio: I. ♩ ≈ 72',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23705 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:72f99e1e-51d4-4feb-92cc-3532a0b92239' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f99e1e-51d4-4feb-92cc-3532a0b92239', 1, 'I', '♩ ≈ 72', 'Piano Trio: I. ♩ ≈ 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23705 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f99e1e-51d4-4feb-92cc-3532a0b92239'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = 84-88', part.name_en = 'Piano Trio: II. ♩ = 84-88',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23705 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:226ece9a-67a6-41d8-93bb-0ede012a56ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:226ece9a-67a6-41d8-93bb-0ede012a56ae', 2, 'II', '♩ = 84-88', 'Piano Trio: II. ♩ = 84-88', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23705 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:226ece9a-67a6-41d8-93bb-0ede012a56ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = 80', part.name_en = 'Piano Trio: III. ♩ = 80',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23705 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:4845d349-3b49-4ebd-9af6-7f9dfef487b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4845d349-3b49-4ebd-9af6-7f9dfef487b6', 3, 'III', '♩ = 80', 'Piano Trio: III. ♩ = 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23705 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4845d349-3b49-4ebd-9af6-7f9dfef487b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '[Minim] = 64', part.name_en = 'Piano Trio: IV. [Minim] = 64',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23705 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:e76ead9a-c022-4bca-ba73-b751f69ab19d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e76ead9a-c022-4bca-ba73-b751f69ab19d', 4, 'IV', '[Minim] = 64', 'Piano Trio: IV. [Minim] = 64', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23705 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76ead9a-c022-4bca-ba73-b751f69ab19d'
);


-- None Piesă în mozaic

UPDATE pieces piece
SET piece.title = 'Piesă în mozaic', piece.title_en = 'Piesă în mozaic',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25029 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psalm

UPDATE pieces piece
SET piece.title = 'Psalm', piece.title_en = 'Psalm',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25667 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pulsions en souffle countinu

UPDATE pieces piece
SET piece.title = 'Pulsions en souffle countinu', piece.title_en = 'Pulsions en souffle countinu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25904 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None SHQIP For Violin Solo

UPDATE pieces piece
SET piece.title = 'SHQIP For Violin Solo', piece.title_en = 'SHQIP For Violin Solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25915 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Siehe, du bist schön

UPDATE pieces piece
SET piece.title = 'Siehe, du bist schön', piece.title_en = 'Siehe, du bist schön',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24425 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Simfonia nr. 2

UPDATE pieces piece
SET piece.title = 'Simfonia nr. 2', piece.title_en = 'Simfonia nr. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23063 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tachicardie', part.name_en = 'Simfonia nr. 2: I. Tachicardie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23063 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:92d20fa5-afde-4113-b0e2-08cd84399573' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d20fa5-afde-4113-b0e2-08cd84399573', 1, 'I', 'Tachicardie', 'Simfonia nr. 2: I. Tachicardie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23063 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d20fa5-afde-4113-b0e2-08cd84399573'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Psalm', part.name_en = 'Simfonia nr. 2: II. Psalm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23063 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:94e794e6-d684-465f-a0b9-0268247ab783' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e794e6-d684-465f-a0b9-0268247ab783', 2, 'II', 'Psalm', 'Simfonia nr. 2: II. Psalm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23063 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e794e6-d684-465f-a0b9-0268247ab783'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Melodie descătușată', part.name_en = 'Simfonia nr. 2: III. Melodie descătușată',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23063 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:87fb8157-4a70-4b46-94fa-8b0b76ef7079' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87fb8157-4a70-4b46-94fa-8b0b76ef7079', 3, 'III', 'Melodie descătușată', 'Simfonia nr. 2: III. Melodie descătușată', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23063 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87fb8157-4a70-4b46-94fa-8b0b76ef7079'
);


-- None 교향곡 5번

UPDATE pieces piece
SET piece.title = '교향곡 5번', piece.title_en = 'Symphony no. 5 for Chorus and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24838 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Peste vîrfuri', part.name_en = 'Symphony no. 5 for Chorus and Orchestra: I. Peste vîrfuri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24838 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:6c60df0a-500d-406a-ab74-1ec83bf917d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c60df0a-500d-406a-ab74-1ec83bf917d0', 1, 'I', 'Peste vîrfuri', 'Symphony no. 5 for Chorus and Orchestra: I. Peste vîrfuri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24838 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c60df0a-500d-406a-ab74-1ec83bf917d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Colinde, colinde', part.name_en = 'Symphony no. 5 for Chorus and Orchestra: II. Colinde, colinde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24838 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:310c8bd5-eb4e-47d3-a1c7-558653e417eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:310c8bd5-eb4e-47d3-a1c7-558653e417eb', 2, 'II', 'Colinde, colinde', 'Symphony no. 5 for Chorus and Orchestra: II. Colinde, colinde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24838 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:310c8bd5-eb4e-47d3-a1c7-558653e417eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dintre sute de catarge', part.name_en = 'Symphony no. 5 for Chorus and Orchestra: III. Dintre sute de catarge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24838 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:4c181acb-c143-445a-8799-27be13d86a6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c181acb-c143-445a-8799-27be13d86a6e', 3, 'III', 'Dintre sute de catarge', 'Symphony no. 5 for Chorus and Orchestra: III. Dintre sute de catarge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24838 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c181acb-c143-445a-8799-27be13d86a6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Glossă', part.name_en = 'Symphony no. 5 for Chorus and Orchestra: IV. Glossă',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24838 AND p.composer_id = 443 AND part.part_key = 'musicbrainz:c6ca65c7-4608-4536-bc05-48eae243b79c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6ca65c7-4608-4536-bc05-48eae243b79c', 4, 'IV', 'Glossă', 'Symphony no. 5 for Chorus and Orchestra: IV. Glossă', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24838 AND p.composer_id = 443
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6ca65c7-4608-4536-bc05-48eae243b79c'
);


-- Op. 116 Versete for Piano and Violin

UPDATE pieces piece
SET piece.title = 'Versete for Piano and Violin', piece.title_en = 'Versete for Piano and Violin, op. 116',
    piece.type = 'song', piece.opus_number = 'Op. 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25739 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None „Ecran” pentru orchestră

UPDATE pieces piece
SET piece.title = '„Ecran” pentru orchestră', piece.title_en = '„Ecran” pentru orchestră',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25658 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None „Narațiune” pentru orgă

UPDATE pieces piece
SET piece.title = '„Narațiune” pentru orgă', piece.title_en = '„Narațiune” pentru orgă',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25752 AND piece.composer_id = 443
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Simfonia nr. 3 "La un cutremur"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Simfonia nr. 3 "La un cutremur"', 'Simfonia nr. 3 "La un cutremur"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 443
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Simfonia nr. 3 "La un cutremur"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4d3fab0-7196-43f3-b9b1-dbacc6b46210'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4d3fab0-7196-43f3-b9b1-dbacc6b46210'
FROM pieces p
WHERE p.composer_id = 443 AND p.title = 'Simfonia nr. 3 "La un cutremur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4d3fab0-7196-43f3-b9b1-dbacc6b46210'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff1a1929-f770-440b-8a83-a432ea6cbb34', 1, 'I', 'Reportaj', 'Simfonia nr. 3 "La un cutremur": I. Reportaj', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = 'Simfonia nr. 3 "La un cutremur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff1a1929-f770-440b-8a83-a432ea6cbb34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05df4813-2978-413d-83c5-5ccbd0a0f543', 2, 'II', 'Valea plîngerii', 'Simfonia nr. 3 "La un cutremur": II. Valea plîngerii', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = 'Simfonia nr. 3 "La un cutremur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05df4813-2978-413d-83c5-5ccbd0a0f543'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c37ea326-cf79-43f0-9660-519d86900681', 3, 'III', 'Colinde de greieri', 'Simfonia nr. 3 "La un cutremur": III. Colinde de greieri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = 'Simfonia nr. 3 "La un cutremur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37ea326-cf79-43f0-9660-519d86900681'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c41e53f-6451-4cfc-89e8-1b9aac3ab663', 4, 'IV', 'Mînie', 'Simfonia nr. 3 "La un cutremur": IV. Mînie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = 'Simfonia nr. 3 "La un cutremur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c41e53f-6451-4cfc-89e8-1b9aac3ab663'
);


-- None 교향곡 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번', 'Symphony no. 4', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 443
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabb8f62-aadf-4455-a4fc-8ce548881319'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fabb8f62-aadf-4455-a4fc-8ce548881319'
FROM pieces p
WHERE p.composer_id = 443 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabb8f62-aadf-4455-a4fc-8ce548881319'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:205b549b-f553-40d4-a255-35de160e6c0d', 1, NULL, 'I', 'Symphony no. 4: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:205b549b-f553-40d4-a255-35de160e6c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b7d918-4570-400d-8cb3-f50c8fe87792', 2, NULL, 'II', 'Symphony no. 4: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b7d918-4570-400d-8cb3-f50c8fe87792'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b92e5c33-c97c-43eb-9d53-c2c6b8b20cd9', 3, NULL, 'III', 'Symphony no. 4: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b92e5c33-c97c-43eb-9d53-c2c6b8b20cd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f4272b-e7e8-4a97-bf18-3405f1e7c007', 4, NULL, 'IV', 'Symphony no. 4: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 443 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f4272b-e7e8-4a97-bf18-3405f1e7c007'
);


-- 숨길 seed 작품 없음
