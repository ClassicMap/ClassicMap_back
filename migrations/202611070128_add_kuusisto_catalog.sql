-- Ilkka Kuusisto 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 28개(묶음 8, 다악장 2, 낱곡 18),
-- 새 작품 2개, part 33개, 그 아래 0개.
-- seed 27개 중 26개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None Concertino Improvvisando

UPDATE pieces piece
SET piece.title = 'Concertino Improvvisando', piece.title_en = 'Concertino Improvvisando',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18377 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante e rubato', part.name_en = 'Concertino Improvvisando: I. Andante e rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18377 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:a8e15de0-47ea-4e7d-93aa-873596644623' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8e15de0-47ea-4e7d-93aa-873596644623', 1, 'I', 'Andante e rubato', 'Concertino Improvvisando: I. Andante e rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18377 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8e15de0-47ea-4e7d-93aa-873596644623'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow and sweet', part.name_en = 'Concertino Improvvisando: II. Slow and sweet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18377 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:157034f3-7757-485c-9c8e-ee3bf2a300e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:157034f3-7757-485c-9c8e-ee3bf2a300e9', 2, 'II', 'Slow and sweet', 'Concertino Improvvisando: II. Slow and sweet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18377 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:157034f3-7757-485c-9c8e-ee3bf2a300e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fast', part.name_en = 'Concertino Improvvisando: III. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18377 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:3e5bdf13-4c41-47d2-bb1f-a817ba0c08e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e5bdf13-4c41-47d2-bb1f-a817ba0c08e2', 3, 'III', 'Fast', 'Concertino Improvvisando: III. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18377 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5bdf13-4c41-47d2-bb1f-a817ba0c08e2'
);


-- None 오페라 <Fröken Julie>

UPDATE pieces piece
SET piece.title = '오페라 <Fröken Julie>', piece.title_en = 'Fröken Julie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15819 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Gabriel, tule takaisin!>

UPDATE pieces piece
SET piece.title = '오페라 <Gabriel, tule takaisin!>', piece.title_en = 'Gabriel, tule takaisin!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15827 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hiljainen ilta>

UPDATE pieces piece
SET piece.title = '가곡 <Hiljainen ilta>', piece.title_en = 'Hiljainen ilta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18113 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Isänmaan tyttäret>

UPDATE pieces piece
SET piece.title = '오페라 <Isänmaan tyttäret>', piece.title_en = 'Isänmaan tyttäret',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15788 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Isänmaan tyttäret: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15788 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:54267d8b-62e7-49f2-bb14-f453b814352a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54267d8b-62e7-49f2-bb14-f453b814352a', 1, NULL, 'Näytös I', 'Isänmaan tyttäret: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15788 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54267d8b-62e7-49f2-bb14-f453b814352a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Isänmaan tyttäret: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15788 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:bc5e1fec-d783-4ad5-89fe-00393eeb8b9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5e1fec-d783-4ad5-89fe-00393eeb8b9e', 2, NULL, 'Näytös II', 'Isänmaan tyttäret: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15788 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5e1fec-d783-4ad5-89fe-00393eeb8b9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Näytös III', part.name_en = 'Isänmaan tyttäret: Näytös III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15788 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:920cea67-1fe0-48bd-80be-51a3e787e222' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:920cea67-1fe0-48bd-80be-51a3e787e222', 3, NULL, 'Näytös III', 'Isänmaan tyttäret: Näytös III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15788 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:920cea67-1fe0-48bd-80be-51a3e787e222'
);


-- None 오페라 <Jääkäri Ståhl>

UPDATE pieces piece
SET piece.title = '오페라 <Jääkäri Ståhl>', piece.title_en = 'Jääkäri Ståhl',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18884 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Epilogi', part.name_en = 'Jääkäri Ståhl: Epilogi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:fc02fa39-5843-49fb-b868-166b83cd13b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc02fa39-5843-49fb-b868-166b83cd13b2', 1, NULL, 'Epilogi', 'Jääkäri Ståhl: Epilogi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc02fa39-5843-49fb-b868-166b83cd13b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Jääkäri Ståhl: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:ed3fea93-30ef-4a8e-b1c1-6cd73c47ef32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed3fea93-30ef-4a8e-b1c1-6cd73c47ef32', 2, NULL, 'Näytös I', 'Jääkäri Ståhl: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed3fea93-30ef-4a8e-b1c1-6cd73c47ef32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Jääkäri Ståhl: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:b86ae7ca-b41d-44a7-86d0-3b3affe760cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b86ae7ca-b41d-44a7-86d0-3b3affe760cf', 3, NULL, 'Näytös II', 'Jääkäri Ståhl: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b86ae7ca-b41d-44a7-86d0-3b3affe760cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Näytös III', part.name_en = 'Jääkäri Ståhl: Näytös III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:59653fae-6b6e-4958-9748-2b34e3e8993e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59653fae-6b6e-4958-9748-2b34e3e8993e', 4, NULL, 'Näytös III', 'Jääkäri Ståhl: Näytös III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59653fae-6b6e-4958-9748-2b34e3e8993e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Näytös IV', part.name_en = 'Jääkäri Ståhl: Näytös IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:3a0797e3-64fb-44aa-a479-e1cd6adfddb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a0797e3-64fb-44aa-a479-e1cd6adfddb0', 5, NULL, 'Näytös IV', 'Jääkäri Ståhl: Näytös IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a0797e3-64fb-44aa-a479-e1cd6adfddb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Näytös V', part.name_en = 'Jääkäri Ståhl: Näytös V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:1e5eadf8-6e05-400b-8c20-1b9d6dcdcafd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e5eadf8-6e05-400b-8c20-1b9d6dcdcafd', 6, NULL, 'Näytös V', 'Jääkäri Ståhl: Näytös V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e5eadf8-6e05-400b-8c20-1b9d6dcdcafd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Näytös VI', part.name_en = 'Jääkäri Ståhl: Näytös VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18884 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:25e50bcd-a576-4301-8c8a-95f5ceeca213' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25e50bcd-a576-4301-8c8a-95f5ceeca213', 7, NULL, 'Näytös VI', 'Jääkäri Ståhl: Näytös VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18884 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e50bcd-a576-4301-8c8a-95f5ceeca213'
);


-- None 가곡 <Kaukainen aamu>

UPDATE pieces piece
SET piece.title = '가곡 <Kaukainen aamu>', piece.title_en = 'Kaukainen aamu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18020 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Kotia kohti>

UPDATE pieces piece
SET piece.title = '오페라 <Kotia kohti>', piece.title_en = 'Kotia kohti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16521 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Kun talo alkaa soida>

UPDATE pieces piece
SET piece.title = '칸타타 <Kun talo alkaa soida>', piece.title_en = 'Kun talo alkaa soida',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15784 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Kuninkaan sormus>

UPDATE pieces piece
SET piece.title = '오페라 <Kuninkaan sormus>', piece.title_en = 'Kuninkaan sormus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15736 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Kuutamo-simmi>

UPDATE pieces piece
SET piece.title = '가곡 <Kuutamo-simmi>', piece.title_en = 'Kuutamo-simmi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19619 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Lumikuningatar>

UPDATE pieces piece
SET piece.title = '발레 <Lumikuningatar>', piece.title_en = 'Lumikuningatar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19985 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Matilda ja Nikolai>

UPDATE pieces piece
SET piece.title = '오페라 <Matilda ja Nikolai>', piece.title_en = 'Matilda ja Nikolai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19275 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Miehen kylkiluu>

UPDATE pieces piece
SET piece.title = '오페라 <Miehen kylkiluu>', piece.title_en = 'Miehen kylkiluu',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17225 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Miehen kylkiluu: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17225 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:f9a153c4-dbc8-4791-b98f-146656e4fdce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a153c4-dbc8-4791-b98f-146656e4fdce', 1, NULL, 'Näytös I', 'Miehen kylkiluu: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17225 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a153c4-dbc8-4791-b98f-146656e4fdce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Miehen kylkiluu: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17225 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:cea14c12-16cd-4831-ab3a-ab38b53e7f7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea14c12-16cd-4831-ab3a-ab38b53e7f7a', 2, NULL, 'Näytös II', 'Miehen kylkiluu: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17225 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea14c12-16cd-4831-ab3a-ab38b53e7f7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Näytös III', part.name_en = 'Miehen kylkiluu: Näytös III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17225 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:ed018576-a223-4397-b8ce-4e477d1568c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed018576-a223-4397-b8ce-4e477d1568c8', 3, NULL, 'Näytös III', 'Miehen kylkiluu: Näytös III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17225 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed018576-a223-4397-b8ce-4e477d1568c8'
);


-- None 오페라 <Muumiooppera>

UPDATE pieces piece
SET piece.title = '오페라 <Muumiooppera>', piece.title_en = 'Muumiooppera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17512 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Nainen kuin jäätynyt samppanja>

UPDATE pieces piece
SET piece.title = '오페라 <Nainen kuin jäätynyt samppanja>', piece.title_en = 'Nainen kuin jäätynyt samppanja',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15734 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Nainen kuin jäätynyt samppanja: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15734 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:5f5e05f0-81f6-42b0-8e8c-90d99a1d2106' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f5e05f0-81f6-42b0-8e8c-90d99a1d2106', 1, NULL, 'Näytös I', 'Nainen kuin jäätynyt samppanja: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15734 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f5e05f0-81f6-42b0-8e8c-90d99a1d2106'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Nainen kuin jäätynyt samppanja: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15734 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:a3933dd8-28bd-477f-8b3f-e0af617877fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3933dd8-28bd-477f-8b3f-e0af617877fd', 2, NULL, 'Näytös II', 'Nainen kuin jäätynyt samppanja: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15734 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3933dd8-28bd-477f-8b3f-e0af617877fd'
);


-- None 오페라 <Pierrot ja yön salaisuudet>

UPDATE pieces piece
SET piece.title = '오페라 <Pierrot ja yön salaisuudet>', piece.title_en = 'Pierrot ja yön salaisuudet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15840 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Pierrot ja yön salaisuudet: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15840 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:860f7738-5fb0-4ed7-bfba-aea5f2bcc445' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:860f7738-5fb0-4ed7-bfba-aea5f2bcc445', 1, NULL, 'Näytös I', 'Pierrot ja yön salaisuudet: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15840 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:860f7738-5fb0-4ed7-bfba-aea5f2bcc445'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Pierrot ja yön salaisuudet: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15840 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:9e61ae65-e063-42d2-853c-381b7febe01a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e61ae65-e063-42d2-853c-381b7febe01a', 2, NULL, 'Näytös II', 'Pierrot ja yön salaisuudet: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15840 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e61ae65-e063-42d2-853c-381b7febe01a'
);


-- None 오페라 <Postineiti>

UPDATE pieces piece
SET piece.title = '오페라 <Postineiti>', piece.title_en = 'Postineiti',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15739 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Postineiti: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15739 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:34be32e2-6b99-4400-a42b-e4a43078860c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34be32e2-6b99-4400-a42b-e4a43078860c', 1, NULL, 'Näytös I', 'Postineiti: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15739 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34be32e2-6b99-4400-a42b-e4a43078860c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Postineiti: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15739 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:7106201d-79ba-4ebf-b163-119e610e6de0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7106201d-79ba-4ebf-b163-119e610e6de0', 2, NULL, 'Näytös II', 'Postineiti: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15739 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7106201d-79ba-4ebf-b163-119e610e6de0'
);


-- None 오페라 <Pula! Ooppera Konikapinasta>

UPDATE pieces piece
SET piece.title = '오페라 <Pula! Ooppera Konikapinasta>', piece.title_en = 'Pula! Ooppera Konikapinasta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19727 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ritmo Acustico 2

UPDATE pieces piece
SET piece.title = 'Ritmo Acustico 2', piece.title_en = 'Ritmo Acustico 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19836 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Robin Hood>

UPDATE pieces piece
SET piece.title = '발레 <Robin Hood>', piece.title_en = 'Robin Hood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20005 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Sota valosta>

UPDATE pieces piece
SET piece.title = '오페라 <Sota valosta>', piece.title_en = 'Sota valosta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15733 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Sota valosta: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15733 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:73e5ad47-51f9-4dbb-90a6-d1adb3a9b2e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e5ad47-51f9-4dbb-90a6-d1adb3a9b2e6', 1, NULL, 'Näytös I', 'Sota valosta: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15733 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e5ad47-51f9-4dbb-90a6-d1adb3a9b2e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Sota valosta: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15733 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:557e3577-74e7-4dc7-9c05-ec6ad708b4f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:557e3577-74e7-4dc7-9c05-ec6ad708b4f0', 2, NULL, 'Näytös II', 'Sota valosta: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15733 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:557e3577-74e7-4dc7-9c05-ec6ad708b4f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Näytös III', part.name_en = 'Sota valosta: Näytös III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15733 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:e1571305-e864-4041-9b4c-fefb13751549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1571305-e864-4041-9b4c-fefb13751549', 3, NULL, 'Näytös III', 'Sota valosta: Näytös III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15733 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1571305-e864-4041-9b4c-fefb13751549'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Näytös IV', part.name_en = 'Sota valosta: Näytös IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15733 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:147735f0-0e50-4609-a735-01788e4998e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147735f0-0e50-4609-a735-01788e4998e1', 4, NULL, 'Näytös IV', 'Sota valosta: Näytös IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15733 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147735f0-0e50-4609-a735-01788e4998e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Näytös V', part.name_en = 'Sota valosta: Näytös V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15733 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:a6ddd760-0d16-419f-8de6-b722545063a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6ddd760-0d16-419f-8de6-b722545063a7', 5, NULL, 'Näytös V', 'Sota valosta: Näytös V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15733 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6ddd760-0d16-419f-8de6-b722545063a7'
);


-- None 가곡 <Suomalainen>

UPDATE pieces piece
SET piece.title = '가곡 <Suomalainen>', piece.title_en = 'Suomalainen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19189 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Taipaleenjoki>

UPDATE pieces piece
SET piece.title = '오페라 <Taipaleenjoki>', piece.title_en = 'Taipaleenjoki',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19801 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Näytös I', part.name_en = 'Taipaleenjoki: Näytös I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19801 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:fa05aa13-594b-425c-bec3-86e51068d8b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa05aa13-594b-425c-bec3-86e51068d8b3', 1, NULL, 'Näytös I', 'Taipaleenjoki: Näytös I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19801 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa05aa13-594b-425c-bec3-86e51068d8b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Näytös II', part.name_en = 'Taipaleenjoki: Näytös II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19801 AND p.composer_id = 181 AND part.part_key = 'musicbrainz:b64aed7d-f71a-46c5-a681-46020acb76d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b64aed7d-f71a-46c5-a681-46020acb76d2', 2, NULL, 'Näytös II', 'Taipaleenjoki: Näytös II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19801 AND p.composer_id = 181
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b64aed7d-f71a-46c5-a681-46020acb76d2'
);


-- None 가곡 <Unessa tumma torni>

UPDATE pieces piece
SET piece.title = '가곡 <Unessa tumma torni>', piece.title_en = 'Unessa tumma torni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18879 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Vapauden vanki>

UPDATE pieces piece
SET piece.title = '오페라 <Vapauden vanki>', piece.title_en = 'Vapauden vanki',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18297 AND piece.composer_id = 181
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 181
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca036fb2-8f38-4c2a-b543-0e05a386ae52'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca036fb2-8f38-4c2a-b543-0e05a386ae52'
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca036fb2-8f38-4c2a-b543-0e05a386ae52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5e4e188-4bf9-447a-833f-580c332cfca3', 1, 'I', 'Andantino', 'Symphony no. 1: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5e4e188-4bf9-447a-833f-580c332cfca3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13294592-a4fd-4769-913d-3d7270173021', 2, 'II', 'Marcia', 'Symphony no. 1: II. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13294592-a4fd-4769-913d-3d7270173021'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16b1db6-9196-4488-9008-0e4f1ba0977d', 3, 'III', 'Rubato', 'Symphony no. 1: III. Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16b1db6-9196-4488-9008-0e4f1ba0977d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8b90710-57eb-48ed-b228-9b64b8103267', 4, 'IV', 'Allegro', 'Symphony no. 1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8b90710-57eb-48ed-b228-9b64b8103267'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony no. 2', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 181
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '687be19e-96dd-4fce-a95b-f68330168fe3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '687be19e-96dd-4fce-a95b-f68330168fe3'
FROM pieces p
WHERE p.composer_id = 181 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '687be19e-96dd-4fce-a95b-f68330168fe3'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 181 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    18218
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
