-- 작곡가 12명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 9/9).
-- 작품 37개(새 1개), seed 44개 중 잇기 36·숨김 3·그대로 5.
--
-- 6차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- ===== Gilbert Duprez (composer_id 471) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Nita la gondolière>

UPDATE pieces piece
SET piece.title = '가곡 <Nita la gondolière>', piece.title_en = 'Nita la gondolière',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23257 AND piece.composer_id = 471
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Isaac Nathan (composer_id 473) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 1개 중 0개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None Oh! weep for those

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Oh! weep for those', 'Oh! weep for those', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 473
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Oh! weep for those'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb2122f6-bdb3-4a9d-bcce-0f0cf6f24e02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb2122f6-bdb3-4a9d-bcce-0f0cf6f24e02'
FROM pieces p
WHERE p.composer_id = 473 AND p.title = 'Oh! weep for those' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb2122f6-bdb3-4a9d-bcce-0f0cf6f24e02'
);

-- 숨길 seed 작품 없음

-- ===== Jean Gilbert (composer_id 480) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 1, 다악장 0, 낱곡 5),
-- 새 작품 0개, part 4개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페레타 <Die Kinokönigin>

UPDATE pieces piece
SET piece.title = '오페레타 <Die Kinokönigin>', piece.title_en = 'Die Kinokönigin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23631 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Durch Berlin fließt immer noch die Spree

UPDATE pieces piece
SET piece.title = 'Durch Berlin fließt immer noch die Spree', piece.title_en = 'Durch Berlin fließt immer noch die Spree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23230 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Katja, die Tänzerin>

UPDATE pieces piece
SET piece.title = '오페레타 <Katja, die Tänzerin>', piece.title_en = 'Katja, die Tänzerin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23790 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '„Ein sonderbares Prickeln”', part.name_en = 'Katja, die Tänzerin: „Ein sonderbares Prickeln”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23790 AND p.composer_id = 480 AND part.part_key = 'musicbrainz:0982e11e-cb34-4b38-91e9-05e9796ed7d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0982e11e-cb34-4b38-91e9-05e9796ed7d9', 1, NULL, '„Ein sonderbares Prickeln”', 'Katja, die Tänzerin: „Ein sonderbares Prickeln”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23790 AND p.composer_id = 480
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0982e11e-cb34-4b38-91e9-05e9796ed7d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '„Komm morgen zu mir in mein kleines Quartier”', part.name_en = 'Katja, die Tänzerin: „Komm morgen zu mir in mein kleines Quartier”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23790 AND p.composer_id = 480 AND part.part_key = 'musicbrainz:261c36b3-1c61-4f4b-a5ba-59b35d8c3610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:261c36b3-1c61-4f4b-a5ba-59b35d8c3610', 2, NULL, '„Komm morgen zu mir in mein kleines Quartier”', 'Katja, die Tänzerin: „Komm morgen zu mir in mein kleines Quartier”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23790 AND p.composer_id = 480
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:261c36b3-1c61-4f4b-a5ba-59b35d8c3610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '„Immer wenn zwei sich gerne mögen”', part.name_en = 'Katja, die Tänzerin: „Immer wenn zwei sich gerne mögen”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23790 AND p.composer_id = 480 AND part.part_key = 'musicbrainz:42c97f13-709f-4e45-97dd-e269cf30f75b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42c97f13-709f-4e45-97dd-e269cf30f75b', 3, NULL, '„Immer wenn zwei sich gerne mögen”', 'Katja, die Tänzerin: „Immer wenn zwei sich gerne mögen”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23790 AND p.composer_id = 480
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c97f13-709f-4e45-97dd-e269cf30f75b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '„Ja, die Liebe hat zwei Trabanten”', part.name_en = 'Katja, die Tänzerin: „Ja, die Liebe hat zwei Trabanten”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23790 AND p.composer_id = 480 AND part.part_key = 'musicbrainz:80847cfa-2a75-4199-9315-bd9caeb60f84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80847cfa-2a75-4199-9315-bd9caeb60f84', 4, NULL, '„Ja, die Liebe hat zwei Trabanten”', 'Katja, die Tänzerin: „Ja, die Liebe hat zwei Trabanten”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23790 AND p.composer_id = 480
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80847cfa-2a75-4199-9315-bd9caeb60f84'
);


-- None 가곡 <Mein Justav>

UPDATE pieces piece
SET piece.title = '가곡 <Mein Justav>', piece.title_en = 'Mein Justav',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23936 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Puppchen, du bist mein Augenstern>

UPDATE pieces piece
SET piece.title = '가곡 <Puppchen, du bist mein Augenstern>', piece.title_en = 'Puppchen, du bist mein Augenstern',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23981 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Queen of the Movies (medley)

UPDATE pieces piece
SET piece.title = 'The Queen of the Movies (medley)', piece.title_en = 'The Queen of the Movies (medley)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24099 AND piece.composer_id = 480
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Mark Bucci (composer_id 481) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Concerto for a Singing Instrument

UPDATE pieces piece
SET piece.title = 'Concerto for a Singing Instrument', piece.title_en = 'Concerto for a Singing Instrument',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23487 AND piece.composer_id = 481
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for a Singing Instrument: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23487 AND p.composer_id = 481 AND part.part_key = 'musicbrainz:30b5f5c6-24f4-4b94-a45a-6fbbf09e4a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b5f5c6-24f4-4b94-a45a-6fbbf09e4a6a', 1, NULL, 'III', 'Concerto for a Singing Instrument: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23487 AND p.composer_id = 481
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b5f5c6-24f4-4b94-a45a-6fbbf09e4a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tug of War from ”Concerto for a Singing Instrument”', part.name_en = 'Tug of War from ”Concerto for a Singing Instrument”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23487 AND p.composer_id = 481 AND part.part_key = 'musicbrainz:b2af27e8-3126-485b-901f-baa5340a833f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2af27e8-3126-485b-901f-baa5340a833f', 2, NULL, 'Tug of War from ”Concerto for a Singing Instrument”', 'Tug of War from ”Concerto for a Singing Instrument”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23487 AND p.composer_id = 481
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2af27e8-3126-485b-901f-baa5340a833f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vocalise from ”Concerto for a Singing Instrument”', part.name_en = 'Vocalise from ”Concerto for a Singing Instrument”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23487 AND p.composer_id = 481 AND part.part_key = 'musicbrainz:b5784546-332c-4bb1-ab96-06d466c6d5f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5784546-332c-4bb1-ab96-06d466c6d5f0', 3, NULL, 'Vocalise from ”Concerto for a Singing Instrument”', 'Vocalise from ”Concerto for a Singing Instrument”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23487 AND p.composer_id = 481
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5784546-332c-4bb1-ab96-06d466c6d5f0'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 481 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25409
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Robert Fuchs (composer_id 482) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 12개(묶음 4, 다악장 7, 낱곡 1),
-- 새 작품 0개, part 38개, 그 아래 0개.
-- seed 13개 중 12개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- Op. 117 6 Phantasiestücke Op. 117

UPDATE pieces piece
SET piece.title = '6 Phantasiestücke Op. 117', piece.title_en = '6 Phantasiestücke, op. 117',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '117',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25549 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ländler Tempo', part.name_en = '6 Phantasiestücke, op. 117: No. 1. Ländler Tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:92415924-afc0-4479-92cd-54c485a580a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92415924-afc0-4479-92cd-54c485a580a6', 1, NULL, 'Ländler Tempo', '6 Phantasiestücke, op. 117: No. 1. Ländler Tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92415924-afc0-4479-92cd-54c485a580a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ruhig und ausdrucksvoll', part.name_en = '6 Phantasiestücke, op. 117: No. 2. Ruhig und ausdrucksvoll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:0136a94d-12fe-4704-bb47-4f35bff00102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0136a94d-12fe-4704-bb47-4f35bff00102', 2, NULL, 'Ruhig und ausdrucksvoll', '6 Phantasiestücke, op. 117: No. 2. Ruhig und ausdrucksvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0136a94d-12fe-4704-bb47-4f35bff00102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Leicht bewegt', part.name_en = '6 Phantasiestücke, op. 117: No. 3. Leicht bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:1ef14d45-751b-494f-a25e-aeddb2f1fcef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ef14d45-751b-494f-a25e-aeddb2f1fcef', 3, NULL, 'Leicht bewegt', '6 Phantasiestücke, op. 117: No. 3. Leicht bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ef14d45-751b-494f-a25e-aeddb2f1fcef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante sostenuto con espressione', part.name_en = '6 Phantasiestücke, op. 117: No. 4. Andante sostenuto con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:9e44e084-675e-4282-b982-fe7afb83bfab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e44e084-675e-4282-b982-fe7afb83bfab', 4, NULL, 'Andante sostenuto con espressione', '6 Phantasiestücke, op. 117: No. 4. Andante sostenuto con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e44e084-675e-4282-b982-fe7afb83bfab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mäßig bewegt', part.name_en = '6 Phantasiestücke, op. 117: No. 5. Mäßig bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:24fa368a-280f-4c68-b4d0-8c029781ec8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24fa368a-280f-4c68-b4d0-8c029781ec8c', 5, NULL, 'Mäßig bewegt', '6 Phantasiestücke, op. 117: No. 5. Mäßig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24fa368a-280f-4c68-b4d0-8c029781ec8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegretto con delicatezza', part.name_en = '6 Phantasiestücke, op. 117: No. 6. Allegretto con delicatezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25549 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:bf04e70c-7d2d-4ddf-9243-95e763d3bb18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf04e70c-7d2d-4ddf-9243-95e763d3bb18', 6, NULL, 'Allegretto con delicatezza', '6 Phantasiestücke, op. 117: No. 6. Allegretto con delicatezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25549 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf04e70c-7d2d-4ddf-9243-95e763d3bb18'
);


-- Op. 63 Andante grazioso and Capriccio Op. 63

UPDATE pieces piece
SET piece.title = 'Andante grazioso and Capriccio Op. 63', piece.title_en = 'Andante grazioso and Capriccio, op. 63',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '63',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24773 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante grazioso', part.name_en = 'Andante grazioso and Capriccio, op. 63: Andante grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24773 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:7939b1de-6718-495a-bc99-3424cc981cbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7939b1de-6718-495a-bc99-3424cc981cbf', 1, NULL, 'Andante grazioso', 'Andante grazioso and Capriccio, op. 63: Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24773 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7939b1de-6718-495a-bc99-3424cc981cbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Capriccio', part.name_en = 'Andante grazioso and Capriccio, op. 63: Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24773 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:bcbe681b-6f5b-4c63-bb8b-3d1b14c82d05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcbe681b-6f5b-4c63-bb8b-3d1b14c82d05', 2, NULL, 'Capriccio', 'Andante grazioso and Capriccio, op. 63: Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24773 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbe681b-6f5b-4c63-bb8b-3d1b14c82d05'
);


-- Op. 102 클라리넷 5중주 E♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 5중주 E♭장조', piece.title_en = 'Clarinet Quintet in E-flat major, op. 102',
    piece.type = 'album', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23584 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Clarinet Quintet in E-flat major, op. 102: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23584 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:9ba54688-1a3e-4925-8f08-5ab71181af2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba54688-1a3e-4925-8f08-5ab71181af2a', 1, 'I', 'Allegro molto moderato', 'Clarinet Quintet in E-flat major, op. 102: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23584 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba54688-1a3e-4925-8f08-5ab71181af2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando', part.name_en = 'Clarinet Quintet in E-flat major, op. 102: II. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23584 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:8d083fcf-8367-41d5-a48e-33e3727baba8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d083fcf-8367-41d5-a48e-33e3727baba8', 2, 'II', 'Allegro scherzando', 'Clarinet Quintet in E-flat major, op. 102: II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23584 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d083fcf-8367-41d5-a48e-33e3727baba8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Clarinet Quintet in E-flat major, op. 102: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23584 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:0884a74b-9c59-4185-84d6-8c8f7e75f632' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0884a74b-9c59-4185-84d6-8c8f7e75f632', 3, 'III', 'Andante sostenuto', 'Clarinet Quintet in E-flat major, op. 102: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23584 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0884a74b-9c59-4185-84d6-8c8f7e75f632'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto grazioso', part.name_en = 'Clarinet Quintet in E-flat major, op. 102: IV. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23584 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:e541d285-e437-499b-89a4-43a605a2127f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e541d285-e437-499b-89a4-43a605a2127f', 4, 'IV', 'Allegretto grazioso', 'Clarinet Quintet in E-flat major, op. 102: IV. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23584 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e541d285-e437-499b-89a4-43a605a2127f'
);


-- Op. 47 Jugendalbum Op. 47

UPDATE pieces piece
SET piece.title = 'Jugendalbum Op. 47', piece.title_en = 'Jugendalbum, op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25242 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wiegenliedchen, op. 47 no. 7', part.name_en = 'Wiegenliedchen, op. 47 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25242 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:350be5fa-569b-413a-970d-40292c9b6a74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:350be5fa-569b-413a-970d-40292c9b6a74', 1, NULL, 'Wiegenliedchen, op. 47 no. 7', 'Wiegenliedchen, op. 47 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25242 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:350be5fa-569b-413a-970d-40292c9b6a74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Banges Herzelein, op. 47 no. 5', part.name_en = 'Banges Herzelein, op. 47 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25242 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:d976be2a-124b-4b57-bdab-adb8825f63d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d976be2a-124b-4b57-bdab-adb8825f63d2', 2, NULL, 'Banges Herzelein, op. 47 no. 5', 'Banges Herzelein, op. 47 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25242 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d976be2a-124b-4b57-bdab-adb8825f63d2'
);


-- Op. 32 Jugendklange Op. 32

UPDATE pieces piece
SET piece.title = 'Jugendklange Op. 32', piece.title_en = 'Jugendklange, op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25181 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Schmetterling im Blumenfeld', part.name_en = 'Jugendklange, op. 32: Nr. 17. Schmetterling im Blumenfeld',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25181 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:a0b1672b-aecf-4359-8aaf-76d529079a89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b1672b-aecf-4359-8aaf-76d529079a89', 1, NULL, 'Schmetterling im Blumenfeld', 'Jugendklange, op. 32: Nr. 17. Schmetterling im Blumenfeld', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25181 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b1672b-aecf-4359-8aaf-76d529079a89'
);


-- None 가곡 <O freudenreicher Tag>

UPDATE pieces piece
SET piece.title = '가곡 <O freudenreicher Tag>', piece.title_en = 'O freudenreicher Tag',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25725 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 피아노 협주곡 B♭단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 B♭단조', piece.title_en = 'Piano Concerto in B-flat minor, op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25684 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso ed energico', part.name_en = 'Piano Concerto in B-flat minor, op. 27: I. Allegro maestoso ed energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25684 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:1fa7dcf7-458c-40bc-a03d-28a5b5a7d890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fa7dcf7-458c-40bc-a03d-28a5b5a7d890', 1, 'I', 'Allegro maestoso ed energico', 'Piano Concerto in B-flat minor, op. 27: I. Allegro maestoso ed energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25684 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fa7dcf7-458c-40bc-a03d-28a5b5a7d890'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Piano Concerto in B-flat minor, op. 27: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25684 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:29363466-4846-4c1c-95cf-fbc8a761c9de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29363466-4846-4c1c-95cf-fbc8a761c9de', 2, 'II', 'Andante sostenuto', 'Piano Concerto in B-flat minor, op. 27: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25684 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29363466-4846-4c1c-95cf-fbc8a761c9de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con fuoco ma non troppo', part.name_en = 'Piano Concerto in B-flat minor, op. 27: III. Allegro con fuoco ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25684 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:021a31ba-5594-41b4-b401-d45756a0d1f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:021a31ba-5594-41b4-b401-d45756a0d1f7', 3, 'III', 'Allegro con fuoco ma non troppo', 'Piano Concerto in B-flat minor, op. 27: III. Allegro con fuoco ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25684 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:021a31ba-5594-41b4-b401-d45756a0d1f7'
);


-- Op. 22 피아노 3중주 1번 C장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 C장조', piece.title_en = 'Piano Trio no. 1 in C major, op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24790 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Piano Trio no. 1 in C major, op. 22: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24790 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:d89e4d62-7801-42e0-9f48-4fb6bafc8de9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d89e4d62-7801-42e0-9f48-4fb6bafc8de9', 1, 'I', 'Allegro moderato', 'Piano Trio no. 1 in C major, op. 22: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24790 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89e4d62-7801-42e0-9f48-4fb6bafc8de9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio con molto espressione', part.name_en = 'Piano Trio no. 1 in C major, op. 22: II. Adagio con molto espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24790 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:3c3533d3-abb1-4126-af1f-cfbb49a33512' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3533d3-abb1-4126-af1f-cfbb49a33512', 2, 'II', 'Adagio con molto espressione', 'Piano Trio no. 1 in C major, op. 22: II. Adagio con molto espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24790 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3533d3-abb1-4126-af1f-cfbb49a33512'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro - Presto', part.name_en = 'Piano Trio no. 1 in C major, op. 22: III. Scherzo. Allegro - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24790 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:442d80e0-3bd6-488c-b31c-9d84b23759d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:442d80e0-3bd6-488c-b31c-9d84b23759d8', 3, 'III', 'Scherzo. Allegro - Presto', 'Piano Trio no. 1 in C major, op. 22: III. Scherzo. Allegro - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24790 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:442d80e0-3bd6-488c-b31c-9d84b23759d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro risoluto', part.name_en = 'Piano Trio no. 1 in C major, op. 22: IV. Finale. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24790 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:1473b54e-2d47-4a14-acd0-e29b5940774f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1473b54e-2d47-4a14-acd0-e29b5940774f', 4, 'IV', 'Finale. Allegro risoluto', 'Piano Trio no. 1 in C major, op. 22: IV. Finale. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24790 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1473b54e-2d47-4a14-acd0-e29b5940774f'
);


-- Op. 9 세레나데 1번 D장조

UPDATE pieces piece
SET piece.title = '세레나데 1번 D장조', piece.title_en = 'Serenade no. 1 in D major, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24284 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Serenade no. 1 in D major, op. 9: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24284 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:cfccba45-81b3-4dd7-97b9-6214c59681d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfccba45-81b3-4dd7-97b9-6214c59681d4', 1, 'I', 'Andante', 'Serenade no. 1 in D major, op. 9: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24284 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfccba45-81b3-4dd7-97b9-6214c59681d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tempo di minuetto', part.name_en = 'Serenade no. 1 in D major, op. 9: II. Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24284 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:ce1cc7b3-79cc-4ebf-9af7-e18d42bca77d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce1cc7b3-79cc-4ebf-9af7-e18d42bca77d', 2, 'II', 'Tempo di minuetto', 'Serenade no. 1 in D major, op. 9: II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24284 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce1cc7b3-79cc-4ebf-9af7-e18d42bca77d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando', part.name_en = 'Serenade no. 1 in D major, op. 9: III. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24284 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:4073682c-e03a-4a8e-88ac-0f9dff866413' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4073682c-e03a-4a8e-88ac-0f9dff866413', 3, 'III', 'Allegro scherzando', 'Serenade no. 1 in D major, op. 9: III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24284 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4073682c-e03a-4a8e-88ac-0f9dff866413'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio con molto espressione', part.name_en = 'Serenade no. 1 in D major, op. 9: IV. Adagio con molto espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24284 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:c72a85ae-0926-4285-aae8-738309de175e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c72a85ae-0926-4285-aae8-738309de175e', 4, 'IV', 'Adagio con molto espressione', 'Serenade no. 1 in D major, op. 9: IV. Adagio con molto espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24284 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72a85ae-0926-4285-aae8-738309de175e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale. Allegro', part.name_en = 'Serenade no. 1 in D major, op. 9: V. Finale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24284 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:6313f341-3eea-438f-84be-77ebdf03c785' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6313f341-3eea-438f-84be-77ebdf03c785', 5, 'V', 'Finale. Allegro', 'Serenade no. 1 in D major, op. 9: V. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24284 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6313f341-3eea-438f-84be-77ebdf03c785'
);


-- Op. 14 세레나데 2번 C장조

UPDATE pieces piece
SET piece.title = '세레나데 2번 C장조', piece.title_en = 'Serenade no. 2 in C major, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24039 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Serenade no. 2 in C major, op. 14: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24039 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:f90da6e5-47e6-4ef9-ad28-2088f8834563' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f90da6e5-47e6-4ef9-ad28-2088f8834563', 1, 'I', 'Allegretto', 'Serenade no. 2 in C major, op. 14: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24039 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f90da6e5-47e6-4ef9-ad28-2088f8834563'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'Serenade no. 2 in C major, op. 14: II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24039 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:0d438bf4-1b71-40d8-85ac-9ccf7c64f7da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d438bf4-1b71-40d8-85ac-9ccf7c64f7da', 2, 'II', 'Larghetto', 'Serenade no. 2 in C major, op. 14: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24039 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d438bf4-1b71-40d8-85ac-9ccf7c64f7da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Serenade no. 2 in C major, op. 14: III. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24039 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:68bd66a5-1ae0-425e-9216-c15f0175bbbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68bd66a5-1ae0-425e-9216-c15f0175bbbe', 3, 'III', 'Allegro risoluto', 'Serenade no. 2 in C major, op. 14: III. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24039 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68bd66a5-1ae0-425e-9216-c15f0175bbbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Presto', part.name_en = 'Serenade no. 2 in C major, op. 14: IV. Finale. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24039 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:61094deb-cc83-4871-8286-a33364b29b88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61094deb-cc83-4871-8286-a33364b29b88', 4, 'IV', 'Finale. Presto', 'Serenade no. 2 in C major, op. 14: IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24039 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61094deb-cc83-4871-8286-a33364b29b88'
);


-- Op. 79 교향곡 3번

UPDATE pieces piece
SET piece.title = '교향곡 3번', piece.title_en = 'Symphony no. 3, op. 79',
    piece.type = 'album', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25530 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Symphony no. 3, op. 79: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25530 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:bf21fb21-a897-43e7-9eba-7d9b22607893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf21fb21-a897-43e7-9eba-7d9b22607893', 1, 'I', 'Allegro maestoso', 'Symphony no. 3, op. 79: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25530 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf21fb21-a897-43e7-9eba-7d9b22607893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con variazioni', part.name_en = 'Symphony no. 3, op. 79: II. Andante con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25530 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:ae390124-a9df-4f97-ab7f-9a8f4718dcbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae390124-a9df-4f97-ab7f-9a8f4718dcbd', 2, 'II', 'Andante con variazioni', 'Symphony no. 3, op. 79: II. Andante con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25530 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae390124-a9df-4f97-ab7f-9a8f4718dcbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando', part.name_en = 'Symphony no. 3, op. 79: III. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25530 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:d4097c15-5bee-44bb-b044-adbe69fb7005' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4097c15-5bee-44bb-b044-adbe69fb7005', 3, 'III', 'Allegro scherzando', 'Symphony no. 3, op. 79: III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25530 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4097c15-5bee-44bb-b044-adbe69fb7005'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro vivace', part.name_en = 'Symphony no. 3, op. 79: IV. Finale. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25530 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:35522d27-40ec-48f8-90c4-1c38d8eeab01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35522d27-40ec-48f8-90c4-1c38d8eeab01', 4, 'IV', 'Finale. Allegro vivace', 'Symphony no. 3, op. 79: IV. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25530 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35522d27-40ec-48f8-90c4-1c38d8eeab01'
);


-- Op. 86 비올라 소나타 D단조

UPDATE pieces piece
SET piece.title = '비올라 소나타 D단조', piece.title_en = 'Viola Sonata in D minor, op. 86',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24573 AND piece.composer_id = 482
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato, ma passionato', part.name_en = 'Viola Sonata in D minor, op. 86: I. Allegro moderato, ma passionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24573 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:d42b1289-3ade-4d53-9c72-7394e177a6b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d42b1289-3ade-4d53-9c72-7394e177a6b9', 1, 'I', 'Allegro moderato, ma passionato', 'Viola Sonata in D minor, op. 86: I. Allegro moderato, ma passionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24573 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d42b1289-3ade-4d53-9c72-7394e177a6b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante grazioso', part.name_en = 'Viola Sonata in D minor, op. 86: II. Andante grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24573 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:58d3f4f9-8f6b-4d50-945f-da5cc3319103' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58d3f4f9-8f6b-4d50-945f-da5cc3319103', 2, 'II', 'Andante grazioso', 'Viola Sonata in D minor, op. 86: II. Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24573 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58d3f4f9-8f6b-4d50-945f-da5cc3319103'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Viola Sonata in D minor, op. 86: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24573 AND p.composer_id = 482 AND part.part_key = 'musicbrainz:a9a018a7-f77a-4246-b6a2-d3052ad5f1eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a018a7-f77a-4246-b6a2-d3052ad5f1eb', 3, 'III', 'Allegro vivace', 'Viola Sonata in D minor, op. 86: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24573 AND p.composer_id = 482
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a018a7-f77a-4246-b6a2-d3052ad5f1eb'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 482 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25444
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Eric Gross (composer_id 483) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 153 No. 2 Cadenza II

UPDATE pieces piece
SET piece.title = 'Cadenza II', piece.title_en = 'Cadenza II, op. 153 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 153 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24418 AND piece.composer_id = 483
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondino Tranquillo

UPDATE pieces piece
SET piece.title = 'Rondino Tranquillo', piece.title_en = 'Rondino Tranquillo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23214 AND piece.composer_id = 483
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 후카이 시로 (composer_id 488) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 연가곡집 <Japanese Flute>

UPDATE pieces piece
SET piece.title = '연가곡집 <Japanese Flute>', piece.title_en = 'Japanese Flute',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25037 AND piece.composer_id = 488
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sailing Out', part.name_en = 'Japanese Flute: Sailing Out',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25037 AND p.composer_id = 488 AND part.part_key = 'musicbrainz:2004ed6e-5e18-4004-b4f4-58132558dc3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2004ed6e-5e18-4004-b4f4-58132558dc3d', 1, NULL, 'Sailing Out', 'Japanese Flute: Sailing Out', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25037 AND p.composer_id = 488
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2004ed6e-5e18-4004-b4f4-58132558dc3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ina', part.name_en = 'Japanese Flute: Ina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25037 AND p.composer_id = 488 AND part.part_key = 'musicbrainz:641fbb71-7fe9-4b82-8dc4-f535594b0536' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:641fbb71-7fe9-4b82-8dc4-f535594b0536', 2, NULL, 'Ina', 'Japanese Flute: Ina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25037 AND p.composer_id = 488
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:641fbb71-7fe9-4b82-8dc4-f535594b0536'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Yanshichi of Yabe', part.name_en = 'Japanese Flute: Yanshichi of Yabe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25037 AND p.composer_id = 488 AND part.part_key = 'musicbrainz:ce044a0f-ee2d-4ad9-b922-e5b8464b1716' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce044a0f-ee2d-4ad9-b922-e5b8464b1716', 3, NULL, 'Yanshichi of Yabe', 'Japanese Flute: Yanshichi of Yabe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25037 AND p.composer_id = 488
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce044a0f-ee2d-4ad9-b922-e5b8464b1716'
);

-- 숨길 seed 작품 없음

-- ===== Fran Lhotka (composer_id 489) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None 발레 <Đavo u selu>

UPDATE pieces piece
SET piece.title = '발레 <Đavo u selu>', piece.title_en = 'Đavo u selu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23082 AND piece.composer_id = 489
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 489 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25574
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Rolf Riehm (composer_id 492) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 0, 낱곡 6),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ach, Königin

UPDATE pieces piece
SET piece.title = 'Ach, Königin', piece.title_en = 'Ach, Königin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23506 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ahi bocca, ahi lingua

UPDATE pieces piece
SET piece.title = 'Ahi bocca, ahi lingua', piece.title_en = 'Ahi bocca, ahi lingua',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25479 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Harryzehn (In nomine actualiter)

UPDATE pieces piece
SET piece.title = 'Harryzehn (In nomine actualiter)', piece.title_en = 'Harryzehn (In nomine actualiter)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23392 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Daddy

UPDATE pieces piece
SET piece.title = 'O Daddy', piece.title_en = 'O Daddy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25597 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Schlaf, schlaf John Donne, schlaf tief und quäl dich nicht

UPDATE pieces piece
SET piece.title = 'Schlaf, schlaf John Donne, schlaf tief und quäl dich nicht', piece.title_en = 'Schlaf, schlaf John Donne, schlaf tief und quäl dich nicht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23852 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None aprikosenbäume gibt es, aprikosenbäume gibt es

UPDATE pieces piece
SET piece.title = 'aprikosenbäume gibt es, aprikosenbäume gibt es', piece.title_en = 'aprikosenbäume gibt es, aprikosenbäume gibt es',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24495 AND piece.composer_id = 492
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 헤르베르트 빈트 (composer_id 493) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Ja, ihr Männer>

UPDATE pieces piece
SET piece.title = '가곡 <Ja, ihr Männer>', piece.title_en = 'Ja, ihr Männer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25465 AND piece.composer_id = 493
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 얀 마클라키에비치 (composer_id 494) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 1, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 8개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 4개는 그대로 둔다.

-- None 발레 <Cagliostro in Warsaw>

UPDATE pieces piece
SET piece.title = '발레 <Cagliostro in Warsaw>', piece.title_en = 'Cagliostro in Warsaw',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24856 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction, Tableau I Allegro vivace', part.name_en = 'Cagliostro in Warsaw: Introduction, Tableau I Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24856 AND p.composer_id = 494 AND part.part_key = 'musicbrainz:06eb9bf3-6c51-40d2-a9ba-80a0bb0c213d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06eb9bf3-6c51-40d2-a9ba-80a0bb0c213d', 1, NULL, 'Introduction, Tableau I Allegro vivace', 'Cagliostro in Warsaw: Introduction, Tableau I Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24856 AND p.composer_id = 494
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06eb9bf3-6c51-40d2-a9ba-80a0bb0c213d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tableau II Allegro ma non troppo. Scherzando', part.name_en = 'Cagliostro in Warsaw: Tableau II Allegro ma non troppo. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24856 AND p.composer_id = 494 AND part.part_key = 'musicbrainz:4baab917-de6a-4f51-b930-764af306f4c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4baab917-de6a-4f51-b930-764af306f4c1', 2, NULL, 'Tableau II Allegro ma non troppo. Scherzando', 'Cagliostro in Warsaw: Tableau II Allegro ma non troppo. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24856 AND p.composer_id = 494
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4baab917-de6a-4f51-b930-764af306f4c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau III Alla polacca', part.name_en = 'Cagliostro in Warsaw: Tableau III Alla polacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24856 AND p.composer_id = 494 AND part.part_key = 'musicbrainz:8ed5bfe4-af28-4925-a649-b7a1374ec0f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed5bfe4-af28-4925-a649-b7a1374ec0f0', 3, NULL, 'Tableau III Alla polacca', 'Cagliostro in Warsaw: Tableau III Alla polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24856 AND p.composer_id = 494
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed5bfe4-af28-4925-a649-b7a1374ec0f0'
);


-- None Offertorium z Mszy Polskiej

UPDATE pieces piece
SET piece.title = 'Offertorium z Mszy Polskiej', piece.title_en = 'Offertorium z Mszy Polskiej',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23927 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Witaj gwiazdko złota

UPDATE pieces piece
SET piece.title = 'Witaj gwiazdko złota', piece.title_en = 'Witaj gwiazdko złota',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23965 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Śliczna Panienka

UPDATE pieces piece
SET piece.title = 'Śliczna Panienka', piece.title_en = 'Śliczna Panienka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25237 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Bartosz Kowalski-Banasewicz (composer_id 497) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Klawitiuda

UPDATE pieces piece
SET piece.title = 'Klawitiuda', piece.title_en = 'Klawitiuda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25384 AND piece.composer_id = 497
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
