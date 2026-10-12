-- 비제 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 184개(묶음 16, 다악장 6, 낱곡 162),
-- 새 작품 95개, part 199개, 그 아래 203개.
-- seed 162개 중 88개를 작품·part 에 잇고, 72개를 숨기고, 2개는 그대로 둔다.
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

-- Op. 3 1er Caprice original en do dièse mineur

UPDATE pieces piece
SET piece.title = '1er Caprice original en do dièse mineur', piece.title_en = '1er Caprice original en do dièse mineur, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11824 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 1er nocturne en fa majeur

UPDATE pieces piece
SET piece.title = '1er nocturne en fa majeur', piece.title_en = '1er nocturne en fa majeur, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11788 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 2ème Caprice original en do majeur

UPDATE pieces piece
SET piece.title = '2ème Caprice original en do majeur', piece.title_en = '2ème Caprice original en do majeur, op. 5',
    piece.type = 'song', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11956 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 4개의 전주곡 Op. 2

UPDATE pieces piece
SET piece.title = '4개의 전주곡 Op. 2', piece.title_en = '4 Préludes, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11478 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'en ut majeur', part.name_en = '4 Préludes, op. 2 : no. 1 en ut majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11478 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e2f744a3-6859-4fe8-a9c2-c7495a093306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2f744a3-6859-4fe8-a9c2-c7495a093306', 1, NULL, 'en ut majeur', '4 Préludes, op. 2 : no. 1 en ut majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11478 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f744a3-6859-4fe8-a9c2-c7495a093306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'en la mineur', part.name_en = '4 Préludes, op. 2 : no. 2 en la mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11478 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5f26b3d7-7d79-4009-af17-5d3038f57933' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f26b3d7-7d79-4009-af17-5d3038f57933', 2, NULL, 'en la mineur', '4 Préludes, op. 2 : no. 2 en la mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11478 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f26b3d7-7d79-4009-af17-5d3038f57933'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'en sol majeur', part.name_en = '4 Préludes, op. 2 : no. 3 en sol majeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11478 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:af670134-a463-4f5c-8032-e8f5a1a7a9a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af670134-a463-4f5c-8032-e8f5a1a7a9a6', 3, NULL, 'en sol majeur', '4 Préludes, op. 2 : no. 3 en sol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11478 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af670134-a463-4f5c-8032-e8f5a1a7a9a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'en mi mineur', part.name_en = '4 Préludes, op. 2 : no. 4 en mi mineur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11478 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f90c942c-0f6a-4a28-9867-adffbf5c2615' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f90c942c-0f6a-4a28-9867-adffbf5c2615', 4, NULL, 'en mi mineur', '4 Préludes, op. 2 : no. 4 en mi mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11478 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f90c942c-0f6a-4a28-9867-adffbf5c2615'
);


-- None 가곡 <Ah ! Qu’elle est belle à voir>

UPDATE pieces piece
SET piece.title = '가곡 <Ah ! Qu’elle est belle à voir>', piece.title_en = 'Ah ! Qu’elle est belle à voir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11967 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Aimons, rêvons !, WD 102>

UPDATE pieces piece
SET piece.title = '가곡 <Aimons, rêvons !, WD 102>', piece.title_en = 'Aimons, rêvons !, WD 102',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11568 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Aubade, WD 99>

UPDATE pieces piece
SET piece.title = '가곡 <Aubade, WD 99>', piece.title_en = 'Aubade, WD 99',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11938 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barcarolle, mélodie sans paroles, WD 110

UPDATE pieces piece
SET piece.title = 'Barcarolle, mélodie sans paroles, WD 110', piece.title_en = 'Barcarolle, mélodie sans paroles, WD 110',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11651 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Carmen>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Carmen : Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb', 1, NULL, 'Prélude', 'Carmen : Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Carmen: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176', 2, NULL, 'Act I', 'Carmen: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. “So corporal: tell me what happened” (Zuniga, Don José)', part.name_en = 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:022b9ec9-3fa7-43d0-b053-50ef73f6d0f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:022b9ec9-3fa7-43d0-b053-50ef73f6d0f5', 1, NULL, 'Act I. “So corporal: tell me what happened” (Zuniga, Don José)', 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:022b9ec9-3fa7-43d0-b053-50ef73f6d0f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)', part.name_en = 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:06a59598-d129-43c1-ab06-20d66b6e9226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06a59598-d129-43c1-ab06-20d66b6e9226', 2, NULL, 'Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)', 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06a59598-d129-43c1-ab06-20d66b6e9226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. Entr’acte', part.name_en = 'Carmen : Acte I. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1', 3, NULL, 'Acte I. Entr’acte', 'Carmen : Acte I. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)', part.name_en = 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1fc9838b-d4de-4a19-b5eb-36c0a27ea63d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fc9838b-d4de-4a19-b5eb-36c0a27ea63d', 4, NULL, 'Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)', 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fc9838b-d4de-4a19-b5eb-36c0a27ea63d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)', part.name_en = 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6', 5, NULL, 'Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)', 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)', part.name_en = 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93', 6, NULL, 'Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)', 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. “We have heard the bell summon us to meet here” (Young Men)', part.name_en = 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:381f1f9d-3710-43d9-a9a4-d7e4ed691eb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:381f1f9d-3710-43d9-a9a4-d7e4ed691eb3', 7, NULL, 'Act I. “We have heard the bell summon us to meet here” (Young Men)', 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:381f1f9d-3710-43d9-a9a4-d7e4ed691eb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. “Corporal! — Sir!” (Zuniga, Don José)', part.name_en = 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4052185a-300f-43df-8138-bada97512e4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4052185a-300f-43df-8138-bada97512e4c', 8, NULL, 'Act I. “Corporal! — Sir!” (Zuniga, Don José)', 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4052185a-300f-43df-8138-bada97512e4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. “Off with you old soldier boys” (Children)', part.name_en = 'Carmen: Act I. “Off with you old soldier boys” (Children)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:40611ea4-1939-45ed-9020-618046ffab3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40611ea4-1939-45ed-9020-618046ffab3a', 9, NULL, 'Act I. “Off with you old soldier boys” (Children)', 'Carmen: Act I. “Off with you old soldier boys” (Children)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40611ea4-1939-45ed-9020-618046ffab3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)', part.name_en = 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:47051267-cb2e-4e9d-83bc-dbc9efb37ed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47051267-cb2e-4e9d-83bc-dbc9efb37ed8', 10, NULL, 'Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)', 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47051267-cb2e-4e9d-83bc-dbc9efb37ed8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. “José! There was a girl looking for you just now” (Moralès, Don José)', part.name_en = 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:52ba3860-5d23-4764-99ac-9af082b6376d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52ba3860-5d23-4764-99ac-9af082b6376d', 11, NULL, 'Act I. “José! There was a girl looking for you just now” (Moralès, Don José)', 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ba3860-5d23-4764-99ac-9af082b6376d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)', part.name_en = 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:56571b7a-0a36-4ea2-836a-dd8457da1355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56571b7a-0a36-4ea2-836a-dd8457da1355', 12, NULL, 'Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)', 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56571b7a-0a36-4ea2-836a-dd8457da1355'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)', part.name_en = 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5eca6407-ff9a-4aba-b35a-2351b680b0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5eca6407-ff9a-4aba-b35a-2351b680b0f8', 13, NULL, 'Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)', 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eca6407-ff9a-4aba-b35a-2351b680b0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)', part.name_en = 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:84bdeda9-76d4-4059-a85f-8a42c69cb720' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84bdeda9-76d4-4059-a85f-8a42c69cb720', 14, NULL, 'Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)', 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84bdeda9-76d4-4059-a85f-8a42c69cb720'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I. “In the plaza” (Soldiers, Moralès)', part.name_en = 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8b01bc7a-e180-406e-9ee1-d0a93fc314f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b01bc7a-e180-406e-9ee1-d0a93fc314f6', 15, NULL, 'Act I. “In the plaza” (Soldiers, Moralès)', 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b01bc7a-e180-406e-9ee1-d0a93fc314f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)', part.name_en = 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9532ad56-25c6-4110-aed8-a997b6d4b50e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9532ad56-25c6-4110-aed8-a997b6d4b50e', 16, NULL, 'Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)', 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9532ad56-25c6-4110-aed8-a997b6d4b50e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act I. “Here come our new soldier boys” (Children)', part.name_en = 'Carmen: Act I. “Here come our new soldier boys” (Children)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c00b0090-924d-4f78-80ac-01fd3cb3c78c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c00b0090-924d-4f78-80ac-01fd3cb3c78c', 17, NULL, 'Act I. “Here come our new soldier boys” (Children)', 'Carmen: Act I. “Here come our new soldier boys” (Children)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c00b0090-924d-4f78-80ac-01fd3cb3c78c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act I. “There’s an old bar in the city” (Carmen, Don José)', part.name_en = 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d34adfee-620f-4c98-80cc-3b2071ecf787' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d34adfee-620f-4c98-80cc-3b2071ecf787', 18, NULL, 'Act I. “There’s an old bar in the city” (Carmen, Don José)', 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34adfee-620f-4c98-80cc-3b2071ecf787'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act I. “I see my mother’s face!” (Don José, Micaëla)', part.name_en = 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d3a409be-749d-48af-a24f-eda6918b3f64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3a409be-749d-48af-a24f-eda6918b3f64', 19, NULL, 'Act I. “I see my mother’s face!” (Don José, Micaëla)', 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3a409be-749d-48af-a24f-eda6918b3f64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)', part.name_en = 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d5363fd2-699b-40c4-ab72-8d09fa866deb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5363fd2-699b-40c4-ab72-8d09fa866deb', 20, NULL, 'Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)', 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5363fd2-699b-40c4-ab72-8d09fa866deb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Act I. “Where are you taking me?” (Carmen, Don José)', part.name_en = 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:da1b10f1-8ccf-453c-88b1-102941cb4ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da1b10f1-8ccf-453c-88b1-102941cb4ff5', 21, NULL, 'Act I. “Where are you taking me?” (Carmen, Don José)', 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da1b10f1-8ccf-453c-88b1-102941cb4ff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Act I. “The cheek of it!” (Don José, Micaëla)', part.name_en = 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e10ce949-e746-42ce-9f72-e4fa001c3ba9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e10ce949-e746-42ce-9f72-e4fa001c3ba9', 22, NULL, 'Act I. “The cheek of it!” (Don José, Micaëla)', 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10ce949-e746-42ce-9f72-e4fa001c3ba9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Act I. “Give me news of my mother!” (Don José, Micaëla)', part.name_en = 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fa53920a-d701-4f13-b9dd-f7965ee3a61e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa53920a-d701-4f13-b9dd-f7965ee3a61e', 23, NULL, 'Act I. “Give me news of my mother!” (Don José, Micaëla)', 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9393cc9-3257-448c-9b49-a73575f62176'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa53920a-d701-4f13-b9dd-f7965ee3a61e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Carmen: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e', 3, NULL, 'Act II', 'Carmen: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', part.name_en = 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:09ebc619-d7b8-400a-a6eb-2f1d1c49424b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09ebc619-d7b8-400a-a6eb-2f1d1c49424b', 1, NULL, 'Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ebc619-d7b8-400a-a6eb-2f1d1c49424b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. “That flow’r you threw to me I treasured” (Don José)', part.name_en = 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:16aba3b8-cd50-4657-834b-a26d21fa1eb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16aba3b8-cd50-4657-834b-a26d21fa1eb2', 2, NULL, 'Act II. “That flow’r you threw to me I treasured” (Don José)', 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16aba3b8-cd50-4657-834b-a26d21fa1eb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)', part.name_en = 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1a35f3b1-5fdb-496c-8879-e1cc69c7ea50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a35f3b1-5fdb-496c-8879-e1cc69c7ea50', 3, NULL, 'Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)', 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a35f3b1-5fdb-496c-8879-e1cc69c7ea50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)', part.name_en = 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4201a997-a084-4235-8f0d-254a7c500d12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4201a997-a084-4235-8f0d-254a7c500d12', 4, NULL, 'Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)', 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4201a997-a084-4235-8f0d-254a7c500d12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)', part.name_en = 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:456d1d3a-a88a-413f-a35b-36131a68f49e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:456d1d3a-a88a-413f-a35b-36131a68f49e', 5, NULL, 'Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)', 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:456d1d3a-a88a-413f-a35b-36131a68f49e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entr’acte', part.name_en = 'Carmen : Acte II. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3', 6, NULL, 'Acte II. Entr’acte', 'Carmen : Acte II. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)', part.name_en = 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4918ca1b-c839-45ba-99f9-a65287414a12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4918ca1b-c839-45ba-99f9-a65287414a12', 7, NULL, 'Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)', 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4918ca1b-c839-45ba-99f9-a65287414a12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)', part.name_en = 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:52256ae8-bc72-40e9-8fd8-18698c5f4771' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52256ae8-bc72-40e9-8fd8-18698c5f4771', 8, NULL, 'Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)', 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52256ae8-bc72-40e9-8fd8-18698c5f4771'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. “Back to camp!… Go at once!” (Carmen, Don José)', part.name_en = 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:544994eb-ded0-44b9-9540-69dacab80770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:544994eb-ded0-44b9-9540-69dacab80770', 9, NULL, 'Act II. “Back to camp!… Go at once!” (Carmen, Don José)', 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:544994eb-ded0-44b9-9540-69dacab80770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)', part.name_en = 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:58e685dd-b813-4f2d-b066-088f130792a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58e685dd-b813-4f2d-b066-088f130792a4', 10, NULL, 'Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)', 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e685dd-b813-4f2d-b066-088f130792a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II. “Hurrah! Hurrah! The Torero!” (Zuniga, Officers, Friends of Escamillo, Mercédès, Frasquita, Carmen, Moralès, Escamillo)', part.name_en = 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Zuniga, Officers, Friends of Escamillo, Mercédès, Frasquita, Carmen, Moralès, Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:63017e2a-9341-41ec-8c83-edea02f634ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63017e2a-9341-41ec-8c83-edea02f634ef', 11, NULL, 'Act II. “Hurrah! Hurrah! The Torero!” (Zuniga, Officers, Friends of Escamillo, Mercédès, Frasquita, Carmen, Moralès, Escamillo)', 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Zuniga, Officers, Friends of Escamillo, Mercédès, Frasquita, Carmen, Moralès, Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63017e2a-9341-41ec-8c83-edea02f634ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II. “La la la la la la la…” (Carmen, Don José)', part.name_en = 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6cf4306f-fbbd-48e1-a7c5-57b1b05939d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cf4306f-fbbd-48e1-a7c5-57b1b05939d9', 12, NULL, 'Act II. “La la la la la la la…” (Carmen, Don José)', 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf4306f-fbbd-48e1-a7c5-57b1b05939d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)', part.name_en = 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7e28ee83-01f0-4192-b82c-6dc5494f5cd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e28ee83-01f0-4192-b82c-6dc5494f5cd5', 13, NULL, 'Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)', 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e28ee83-01f0-4192-b82c-6dc5494f5cd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act II. “Toreador, be ready!” (Friends of Escamillo)', part.name_en = 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7edaa80d-9c20-4b20-ae13-437f128c1bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7edaa80d-9c20-4b20-ae13-437f128c1bef', 14, NULL, 'Act II. “Toreador, be ready!” (Friends of Escamillo)', 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7edaa80d-9c20-4b20-ae13-437f128c1bef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:92cb3a2c-7205-4051-9a8a-e97e8e057928' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92cb3a2c-7205-4051-9a8a-e97e8e057928', 15, NULL, 'Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)', 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92cb3a2c-7205-4051-9a8a-e97e8e057928'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)', part.name_en = 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:93ad2e2f-aa2f-4f78-9dad-30f831848ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93ad2e2f-aa2f-4f78-9dad-30f831848ccf', 16, NULL, 'Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)', 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93ad2e2f-aa2f-4f78-9dad-30f831848ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9576baa7-a289-4962-b2ff-177903f946db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9576baa7-a289-4962-b2ff-177903f946db', 17, NULL, 'Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)', 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9576baa7-a289-4962-b2ff-177903f946db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)', part.name_en = 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9a9124e7-47a6-4920-ab9e-232317e86590' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a9124e7-47a6-4920-ab9e-232317e86590', 18, NULL, 'Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)', 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a9124e7-47a6-4920-ab9e-232317e86590'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act II. “No, it’s not love at all!” (Carmen, Don José)', part.name_en = 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9b891214-75d0-4c1b-a45b-884648be346a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b891214-75d0-4c1b-a45b-884648be346a', 19, NULL, 'Act II. “No, it’s not love at all!” (Carmen, Don José)', 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b891214-75d0-4c1b-a45b-884648be346a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act II. “To bid you welcome to our bar” (Carmen)', part.name_en = 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b09239d2-ba4a-432b-9fb2-f9e8cb67591d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b09239d2-ba4a-432b-9fb2-f9e8cb67591d', 20, NULL, 'Act II. “To bid you welcome to our bar” (Carmen)', 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0fe956f-dc8d-435e-a93f-f77336789b3e'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09239d2-ba4a-432b-9fb2-f9e8cb67591d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Carmen: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67', 4, NULL, 'Act III', 'Carmen: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)', part.name_en = 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b', 1, NULL, 'Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)', 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)', part.name_en = 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:269cfb91-988a-4905-8b21-dd1bb9a4aed2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:269cfb91-988a-4905-8b21-dd1bb9a4aed2', 2, NULL, 'Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)', 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:269cfb91-988a-4905-8b21-dd1bb9a4aed2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', part.name_en = 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2fd671b1-33f4-4f77-9133-81fe1ffddac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2fd671b1-33f4-4f77-9133-81fe1ffddac9', 3, NULL, 'Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fd671b1-33f4-4f77-9133-81fe1ffddac9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)', part.name_en = 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:3331672e-852a-4d8e-bf5c-479426dd316f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3331672e-852a-4d8e-bf5c-479426dd316f', 4, NULL, 'Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)', 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3331672e-852a-4d8e-bf5c-479426dd316f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)', part.name_en = 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:34a6ce33-7717-4803-ab64-100977272d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34a6ce33-7717-4803-ab64-100977272d5a', 5, NULL, 'Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)', 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a6ce33-7717-4803-ab64-100977272d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)', part.name_en = 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:52cdc016-2dae-404e-bc7f-13d90bdf8df5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52cdc016-2dae-404e-bc7f-13d90bdf8df5', 6, NULL, 'Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)', 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52cdc016-2dae-404e-bc7f-13d90bdf8df5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)', part.name_en = 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:58d0ce62-eff1-45c3-82ff-13b8eada28a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58d0ce62-eff1-45c3-82ff-13b8eada28a8', 7, NULL, 'Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)', 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58d0ce62-eff1-45c3-82ff-13b8eada28a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)', part.name_en = 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:66efe409-7330-4842-944c-5e59d7cc19db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66efe409-7330-4842-944c-5e59d7cc19db', 8, NULL, 'Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)', 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66efe409-7330-4842-944c-5e59d7cc19db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act III. “She had a lover here” (Escamillo, Don José)', part.name_en = 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:74dbce55-e99d-450b-b9db-ffe1684d5504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74dbce55-e99d-450b-b9db-ffe1684d5504', 9, NULL, 'Act III. “She had a lover here” (Escamillo, Don José)', 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74dbce55-e99d-450b-b9db-ffe1684d5504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)', part.name_en = 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8cf07935-a01a-4b94-8ee1-86eef12ef76a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cf07935-a01a-4b94-8ee1-86eef12ef76a', 10, NULL, 'Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)', 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cf07935-a01a-4b94-8ee1-86eef12ef76a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act III. “Is this the place?” (Micaëla, Guide)', part.name_en = 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:99312ba3-f497-4a72-a970-5ffedea993e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99312ba3-f497-4a72-a970-5ffedea993e7', 11, NULL, 'Act III. “Is this the place?” (Micaëla, Guide)', 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99312ba3-f497-4a72-a970-5ffedea993e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte III. Entr’acte', part.name_en = 'Carmen : Acte III. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec', 12, NULL, 'Acte III. Entr’acte', 'Carmen : Acte III. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:be293e88-55ad-4aaa-bd80-db61c97cfddb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be293e88-55ad-4aaa-bd80-db61c97cfddb', 13, NULL, 'Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)', 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be293e88-55ad-4aaa-bd80-db61c97cfddb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act III. “I say that there’s nothing to fear” (Micaëla)', part.name_en = 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d7789a04-d1fd-4495-a760-ce698e01f53b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7789a04-d1fd-4495-a760-ce698e01f53b', 14, NULL, 'Act III. “I say that there’s nothing to fear” (Micaëla)', 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7789a04-d1fd-4495-a760-ce698e01f53b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)', part.name_en = 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:eb41674e-3ce9-4682-bf50-4883cc24b422' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eb41674e-3ce9-4682-bf50-4883cc24b422', 15, NULL, 'Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)', 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6014514b-7b26-4ce1-b7ec-46b2e7190a67'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb41674e-3ce9-4682-bf50-4883cc24b422'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act IV', part.name_en = 'Carmen: Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3', 5, NULL, 'Act IV', 'Carmen: Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)', part.name_en = 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0a45801c-6aac-4d58-aeaf-dc66c29094fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a45801c-6aac-4d58-aeaf-dc66c29094fa', 1, NULL, 'Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)', 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a45801c-6aac-4d58-aeaf-dc66c29094fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)', part.name_en = 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2c367187-8029-4fff-932f-27f1727079c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c367187-8029-4fff-932f-27f1727079c5', 2, NULL, 'Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)', 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c367187-8029-4fff-932f-27f1727079c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act IV. “It’s you! — It’s me!” (Carmen, Don José)', part.name_en = 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4d2b42c7-8a3e-4689-9d88-777c497978ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d2b42c7-8a3e-4689-9d88-777c497978ea', 3, NULL, 'Act IV. “It’s you! — It’s me!” (Carmen, Don José)', 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d2b42c7-8a3e-4689-9d88-777c497978ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)', part.name_en = 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:81e3cbef-73d4-42c5-ad9a-3e25ecd4873d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81e3cbef-73d4-42c5-ad9a-3e25ecd4873d', 4, NULL, 'Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)', 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e3cbef-73d4-42c5-ad9a-3e25ecd4873d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)', part.name_en = 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 193 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fca30d89-519e-4caa-b2c5-a57c4d7629fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fca30d89-519e-4caa-b2c5-a57c4d7629fd', 5, NULL, 'Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)', 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6304a372-9219-43c4-a0c2-57b7dc0c78b3'
WHERE p.id = 193 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca30d89-519e-4caa-b2c5-a57c4d7629fd'
);


-- None Carmen Fantasie

UPDATE pieces piece
SET piece.title = 'Carmen Fantasie', piece.title_en = 'Carmen Fantasie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11366 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Carmen, WD 31>

UPDATE pieces piece
SET piece.title = '오페라 <Carmen, WD 31>', piece.title_en = 'Carmen, WD 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11318 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Carmen : Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb', 1, NULL, 'Prélude', 'Carmen : Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ba78e4-9a29-30a1-bbbc-5790ac2c82eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Carmen : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262', 2, NULL, 'Acte I', 'Carmen : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 2 « Sur la place, chacun passe » (Les Soldats, Moralès)', part.name_en = 'Carmen : Acte I. No. 2 « Sur la place, chacun passe » (Les Soldats, Moralès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:938960a2-9e04-3872-94e0-c6eb29e3267c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:938960a2-9e04-3872-94e0-c6eb29e3267c', 1, NULL, 'Acte I. No. 2 « Sur la place, chacun passe » (Les Soldats, Moralès)', 'Carmen : Acte I. No. 2 « Sur la place, chacun passe » (Les Soldats, Moralès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:938960a2-9e04-3872-94e0-c6eb29e3267c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. Dialogue « Regardez donc cette petite » (Moralès, les Soldats, Micaëla)', part.name_en = 'Carmen : Acte I. Dialogue « Regardez donc cette petite » (Moralès, les Soldats, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:28cadb69-8022-3cf1-b1e1-687127c92267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28cadb69-8022-3cf1-b1e1-687127c92267', 2, NULL, 'Acte I. Dialogue « Regardez donc cette petite » (Moralès, les Soldats, Micaëla)', 'Carmen : Acte I. Dialogue « Regardez donc cette petite » (Moralès, les Soldats, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28cadb69-8022-3cf1-b1e1-687127c92267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 3 Marche et chœur des gamins : « Avec la garde montante » (Chœur des gamins, Zuniga)', part.name_en = 'Carmen : Acte I. No. 3 Marche et chœur des gamins : « Avec la garde montante » (Chœur des gamins, Zuniga)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:35dfafb0-7a38-3952-aa0c-080b2d3842c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35dfafb0-7a38-3952-aa0c-080b2d3842c0', 3, NULL, 'Acte I. No. 3 Marche et chœur des gamins : « Avec la garde montante » (Chœur des gamins, Zuniga)', 'Carmen : Acte I. No. 3 Marche et chœur des gamins : « Avec la garde montante » (Chœur des gamins, Zuniga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35dfafb0-7a38-3952-aa0c-080b2d3842c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 3 Dialogue « Il y a une jolie fille qui est venue te demander » (Moralès, Don José)', part.name_en = 'Carmen : Acte I. No. 3 Dialogue « Il y a une jolie fille qui est venue te demander » (Moralès, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:368d6e69-da72-36a7-9fc5-b9ffc2d9ef89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:368d6e69-da72-36a7-9fc5-b9ffc2d9ef89', 4, NULL, 'Acte I. No. 3 Dialogue « Il y a une jolie fille qui est venue te demander » (Moralès, Don José)', 'Carmen : Acte I. No. 3 Dialogue « Il y a une jolie fille qui est venue te demander » (Moralès, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368d6e69-da72-36a7-9fc5-b9ffc2d9ef89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 3 Marche et chœur des gamins « Et la garde descendante rentre chez elle » (Chœur des gamins)', part.name_en = 'Carmen : Acte I. No. 3 Marche et chœur des gamins « Et la garde descendante rentre chez elle » (Chœur des gamins)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ec6b62f8-eb67-32e0-84b5-c7da85465955' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ec6b62f8-eb67-32e0-84b5-c7da85465955', 5, NULL, 'Acte I. No. 3 Marche et chœur des gamins « Et la garde descendante rentre chez elle » (Chœur des gamins)', 'Carmen : Acte I. No. 3 Marche et chœur des gamins « Et la garde descendante rentre chez elle » (Chœur des gamins)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec6b62f8-eb67-32e0-84b5-c7da85465955'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. Dialogue « Dites-moi, brigadier ? » (Zuniga, Don José)', part.name_en = 'Carmen : Acte I. Dialogue « Dites-moi, brigadier ? » (Zuniga, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6735cfcc-f546-3650-9f63-fcf29a33bfc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6735cfcc-f546-3650-9f63-fcf29a33bfc1', 6, NULL, 'Acte I. Dialogue « Dites-moi, brigadier ? » (Zuniga, Don José)', 'Carmen : Acte I. Dialogue « Dites-moi, brigadier ? » (Zuniga, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6735cfcc-f546-3650-9f63-fcf29a33bfc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 3b Récit « C’est bien là, n’est-ce pas » (Zuniga, Don José)', part.name_en = 'Carmen : Acte I. No. 3b Récit « C’est bien là, n’est-ce pas » (Zuniga, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c5146a7c-2f88-3c87-9f83-c22aae5af17e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5146a7c-2f88-3c87-9f83-c22aae5af17e', 7, NULL, 'Acte I. No. 3b Récit « C’est bien là, n’est-ce pas » (Zuniga, Don José)', 'Carmen : Acte I. No. 3b Récit « C’est bien là, n’est-ce pas » (Zuniga, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5146a7c-2f88-3c87-9f83-c22aae5af17e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 4 Chœur des cigarières « La cloche a sonné » (Les Jeunes Gens, les Soldats, les Cigarières)', part.name_en = 'Carmen : Acte I. No. 4 Chœur des cigarières « La cloche a sonné » (Les Jeunes Gens, les Soldats, les Cigarières)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c1f6b309-2a0e-3373-8e17-3e07c924068d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1f6b309-2a0e-3373-8e17-3e07c924068d', 8, NULL, 'Acte I. No. 4 Chœur des cigarières « La cloche a sonné » (Les Jeunes Gens, les Soldats, les Cigarières)', 'Carmen : Acte I. No. 4 Chœur des cigarières « La cloche a sonné » (Les Jeunes Gens, les Soldats, les Cigarières)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1f6b309-2a0e-3373-8e17-3e07c924068d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 4 Chœur et scène « Dans l’air, nous suivons des yeux la fumée » (Les jeunes gens, les soldats, les cigarières)', part.name_en = 'Carmen : Acte I. No. 4 Chœur et scène « Dans l’air, nous suivons des yeux la fumée » (Les jeunes gens, les soldats, les cigarières)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fc6fa38f-8aab-385c-a406-40e0f4f93039' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc6fa38f-8aab-385c-a406-40e0f4f93039', 9, NULL, 'Acte I. No. 4 Chœur et scène « Dans l’air, nous suivons des yeux la fumée » (Les jeunes gens, les soldats, les cigarières)', 'Carmen : Acte I. No. 4 Chœur et scène « Dans l’air, nous suivons des yeux la fumée » (Les jeunes gens, les soldats, les cigarières)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc6fa38f-8aab-385c-a406-40e0f4f93039'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 4 Chœur et scène « Mais nous ne voyons pas la Carmencita ! » (Les Soldats, les Jeunes Gens)', part.name_en = 'Carmen : Acte I. No. 4 Chœur et scène « Mais nous ne voyons pas la Carmencita ! » (Les Soldats, les Jeunes Gens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fa16b121-7f04-32f7-bfa9-17acf0e4e370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa16b121-7f04-32f7-bfa9-17acf0e4e370', 10, NULL, 'Acte I. No. 4 Chœur et scène « Mais nous ne voyons pas la Carmencita ! » (Les Soldats, les Jeunes Gens)', 'Carmen : Acte I. No. 4 Chœur et scène « Mais nous ne voyons pas la Carmencita ! » (Les Soldats, les Jeunes Gens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa16b121-7f04-32f7-bfa9-17acf0e4e370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 4 « La voilà, la voilà » (Les jeunes gens, les soldats, les cigarières)', part.name_en = 'Carmen : Acte I. No. 4 « La voilà, la voilà » (Les jeunes gens, les soldats, les cigarières)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b60ecbd8-b016-3541-a72b-338df0ac0bbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b60ecbd8-b016-3541-a72b-338df0ac0bbf', 11, NULL, 'Acte I. No. 4 « La voilà, la voilà » (Les jeunes gens, les soldats, les cigarières)', 'Carmen : Acte I. No. 4 « La voilà, la voilà » (Les jeunes gens, les soldats, les cigarières)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60ecbd8-b016-3541-a72b-338df0ac0bbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 6 Scène « Carmen ! Sur tes pas, nous nous pressons tous ! » (Les Jeunes Gens, les Cigarières, Don José, Carmen)', part.name_en = 'Carmen : Acte I. No. 6 Scène « Carmen ! Sur tes pas, nous nous pressons tous ! » (Les Jeunes Gens, les Cigarières, Don José, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:76a14988-a17e-3474-ad4b-81cdd0e86e2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76a14988-a17e-3474-ad4b-81cdd0e86e2f', 12, NULL, 'Acte I. No. 6 Scène « Carmen ! Sur tes pas, nous nous pressons tous ! » (Les Jeunes Gens, les Cigarières, Don José, Carmen)', 'Carmen : Acte I. No. 6 Scène « Carmen ! Sur tes pas, nous nous pressons tous ! » (Les Jeunes Gens, les Cigarières, Don José, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a14988-a17e-3474-ad4b-81cdd0e86e2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 6 Scène « Qu''est-ce que ça veut dire » (Don José, Micaëla)', part.name_en = 'Carmen : Acte I. No. 6 Scène « Qu''est-ce que ça veut dire » (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:07dfa5b5-ad12-3274-a301-1244fba5c3fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07dfa5b5-ad12-3274-a301-1244fba5c3fd', 13, NULL, 'Acte I. No. 6 Scène « Qu''est-ce que ça veut dire » (Don José, Micaëla)', 'Carmen : Acte I. No. 6 Scène « Qu''est-ce que ça veut dire » (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07dfa5b5-ad12-3274-a301-1244fba5c3fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 6b Récit « Quels regards ! Quelle effronterie ! » (Don José, Micaëla)', part.name_en = 'Carmen : Acte I. No. 6b Récit « Quels regards ! Quelle effronterie ! » (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b9b55648-5d92-35ed-bee4-dfbc55bcf89c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9b55648-5d92-35ed-bee4-dfbc55bcf89c', 14, NULL, 'Acte I. No. 6b Récit « Quels regards ! Quelle effronterie ! » (Don José, Micaëla)', 'Carmen : Acte I. No. 6b Récit « Quels regards ! Quelle effronterie ! » (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9b55648-5d92-35ed-bee4-dfbc55bcf89c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 7 Duo « Parle-moi de ma mère ! » (Don José, Micaëla)', part.name_en = 'Carmen : Acte I. No. 7 Duo « Parle-moi de ma mère ! » (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9d122d79-bead-3ac7-890a-0ceb3e7f888e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d122d79-bead-3ac7-890a-0ceb3e7f888e', 15, NULL, 'Acte I. No. 7 Duo « Parle-moi de ma mère ! » (Don José, Micaëla)', 'Carmen : Acte I. No. 7 Duo « Parle-moi de ma mère ! » (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d122d79-bead-3ac7-890a-0ceb3e7f888e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 7b Récit « Reste là, maintenant, pendant que je lirai » (Don José, Micaëla)', part.name_en = 'Carmen : Acte I. No. 7b Récit « Reste là, maintenant, pendant que je lirai » (Don José, Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8e661068-a60a-32d8-8070-2011e23625aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e661068-a60a-32d8-8070-2011e23625aa', 16, NULL, 'Acte I. No. 7b Récit « Reste là, maintenant, pendant que je lirai » (Don José, Micaëla)', 'Carmen : Acte I. No. 7b Récit « Reste là, maintenant, pendant que je lirai » (Don José, Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e661068-a60a-32d8-8070-2011e23625aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 8 « Que se passe‐t‐il donc là‐bas ? » … « Au secours » (Les Cigarières, les Soldats, Zuniga)', part.name_en = 'Carmen : Acte I. No. 8 « Que se passe‐t‐il donc là‐bas ? » … « Au secours » (Les Cigarières, les Soldats, Zuniga)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ee377388-6852-331e-92e1-83aaab9f6d28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee377388-6852-331e-92e1-83aaab9f6d28', 17, NULL, 'Acte I. No. 8 « Que se passe‐t‐il donc là‐bas ? » … « Au secours » (Les Cigarières, les Soldats, Zuniga)', 'Carmen : Acte I. No. 8 « Que se passe‐t‐il donc là‐bas ? » … « Au secours » (Les Cigarières, les Soldats, Zuniga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee377388-6852-331e-92e1-83aaab9f6d28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 8 Chœur « Voyons brigadier » (Zuniga, les Cigarières, un Soldat, Don José)', part.name_en = 'Carmen : Acte I. No. 8 Chœur « Voyons brigadier » (Zuniga, les Cigarières, un Soldat, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:91d65102-f2b6-3c8f-8234-bd3a25193988' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91d65102-f2b6-3c8f-8234-bd3a25193988', 18, NULL, 'Acte I. No. 8 Chœur « Voyons brigadier » (Zuniga, les Cigarières, un Soldat, Don José)', 'Carmen : Acte I. No. 8 Chœur « Voyons brigadier » (Zuniga, les Cigarières, un Soldat, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d65102-f2b6-3c8f-8234-bd3a25193988'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 9 Chanson « Mon officier, c’était une querelle » (Don José, Zuniga)', part.name_en = 'Carmen : Acte I. No. 9 Chanson « Mon officier, c’était une querelle » (Don José, Zuniga)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1a306fe2-f08a-3211-b5c1-209cfb39edce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a306fe2-f08a-3211-b5c1-209cfb39edce', 19, NULL, 'Acte I. No. 9 Chanson « Mon officier, c’était une querelle » (Don José, Zuniga)', 'Carmen : Acte I. No. 9 Chanson « Mon officier, c’était une querelle » (Don José, Zuniga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a306fe2-f08a-3211-b5c1-209cfb39edce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 9 Chanson et mélodrame « Tralalalala, coupe-moi, brûle-moi » … « Fais-nous grâce de tes chansons » (Carmen, Don José, Zuniga, chœur de femmes)', part.name_en = 'Carmen : Acte I. No. 9 Chanson et mélodrame « Tralalalala, coupe-moi, brûle-moi » … « Fais-nous grâce de tes chansons » (Carmen, Don José, Zuniga, chœur de femmes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:56de4341-867f-369e-8744-c92b95ef54aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56de4341-867f-369e-8744-c92b95ef54aa', 20, NULL, 'Acte I. No. 9 Chanson et mélodrame « Tralalalala, coupe-moi, brûle-moi » … « Fais-nous grâce de tes chansons » (Carmen, Don José, Zuniga, chœur de femmes)', 'Carmen : Acte I. No. 9 Chanson et mélodrame « Tralalalala, coupe-moi, brûle-moi » … « Fais-nous grâce de tes chansons » (Carmen, Don José, Zuniga, chœur de femmes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56de4341-867f-369e-8744-c92b95ef54aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 9 Chanson et mélodrame « Où me conduirez-vous ? » (Carmen, Don José)', part.name_en = 'Carmen : Acte I. No. 9 Chanson et mélodrame « Où me conduirez-vous ? » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7e6c5196-5497-3074-865d-71d8f0259f1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e6c5196-5497-3074-865d-71d8f0259f1c', 21, NULL, 'Acte I. No. 9 Chanson et mélodrame « Où me conduirez-vous ? » (Carmen, Don José)', 'Carmen : Acte I. No. 9 Chanson et mélodrame « Où me conduirez-vous ? » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e6c5196-5497-3074-865d-71d8f0259f1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 10 Séguedille « Près des remparts de Séville » (Carmen, Don José)', part.name_en = 'Carmen : Acte I. No. 10 Séguedille « Près des remparts de Séville » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8213f288-f084-3a0b-946b-f88493c1b5c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8213f288-f084-3a0b-946b-f88493c1b5c1', 22, NULL, 'Acte I. No. 10 Séguedille « Près des remparts de Séville » (Carmen, Don José)', 'Carmen : Acte I. No. 10 Séguedille « Près des remparts de Séville » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8213f288-f084-3a0b-946b-f88493c1b5c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 11 Finale « Voici l''ordre, partez » (Zuniga, Carmen)', part.name_en = 'Carmen : Acte I. No. 11 Finale « Voici l''ordre, partez » (Zuniga, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1a80b22b-1de8-3801-a9c2-3eb2aa1efafd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a80b22b-1de8-3801-a9c2-3eb2aa1efafd', 23, NULL, 'Acte I. No. 11 Finale « Voici l''ordre, partez » (Zuniga, Carmen)', 'Carmen : Acte I. No. 11 Finale « Voici l''ordre, partez » (Zuniga, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a80b22b-1de8-3801-a9c2-3eb2aa1efafd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Acte I. Entr’acte', part.name_en = 'Carmen : Acte I. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1', 24, NULL, 'Acte I. Entr’acte', 'Carmen : Acte I. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cd37503-b0fe-4e9c-9cfa-781888d50262'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bba3faa-5998-3f9e-9905-b96421157bd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Carmen : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7', 3, NULL, 'Acte II', 'Carmen : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 12 Chanson bohème « Les tringles des sistres tintaient » (Frasquita, Mercédès, Carmen)', part.name_en = 'Carmen : Acte II. No. 12 Chanson bohème « Les tringles des sistres tintaient » (Frasquita, Mercédès, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:936adb44-16fb-346f-badb-076cbdda3e56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:936adb44-16fb-346f-badb-076cbdda3e56', 1, NULL, 'Acte II. No. 12 Chanson bohème « Les tringles des sistres tintaient » (Frasquita, Mercédès, Carmen)', 'Carmen : Acte II. No. 12 Chanson bohème « Les tringles des sistres tintaient » (Frasquita, Mercédès, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:936adb44-16fb-346f-badb-076cbdda3e56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 12b Récit « Messieurs, Pastia me dit… » (Frasquita, Zuniga, Carmen, Mercédès)', part.name_en = 'Carmen : Acte II. No. 12b Récit « Messieurs, Pastia me dit… » (Frasquita, Zuniga, Carmen, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:276ec25e-59cd-3b88-98f9-f14268c6026c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:276ec25e-59cd-3b88-98f9-f14268c6026c', 2, NULL, 'Acte II. No. 12b Récit « Messieurs, Pastia me dit… » (Frasquita, Zuniga, Carmen, Mercédès)', 'Carmen : Acte II. No. 12b Récit « Messieurs, Pastia me dit… » (Frasquita, Zuniga, Carmen, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276ec25e-59cd-3b88-98f9-f14268c6026c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. Dialogue « Vous avez quelque chose à nous dire, maître Lillas Pastia ? » (Zuniga, Pastia, Andrès, Frasquita, Carmen)', part.name_en = 'Carmen : Acte II. Dialogue « Vous avez quelque chose à nous dire, maître Lillas Pastia ? » (Zuniga, Pastia, Andrès, Frasquita, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0e988259-e876-38b4-b37a-a29e73a3d13d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e988259-e876-38b4-b37a-a29e73a3d13d', 3, NULL, 'Acte II. Dialogue « Vous avez quelque chose à nous dire, maître Lillas Pastia ? » (Zuniga, Pastia, Andrès, Frasquita, Carmen)', 'Carmen : Acte II. Dialogue « Vous avez quelque chose à nous dire, maître Lillas Pastia ? » (Zuniga, Pastia, Andrès, Frasquita, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e988259-e876-38b4-b37a-a29e73a3d13d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 13 Chœur « Vivat ! Vivat le toréro ! » (Frasquita, Mercédès, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d''hommes)', part.name_en = 'Carmen : Acte II. No. 13 Chœur « Vivat ! Vivat le toréro ! » (Frasquita, Mercédès, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d''hommes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:185803ee-a26b-39f3-be19-8e3cc18b2daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:185803ee-a26b-39f3-be19-8e3cc18b2daa', 4, NULL, 'Acte II. No. 13 Chœur « Vivat ! Vivat le toréro ! » (Frasquita, Mercédès, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d''hommes)', 'Carmen : Acte II. No. 13 Chœur « Vivat ! Vivat le toréro ! » (Frasquita, Mercédès, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d''hommes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:185803ee-a26b-39f3-be19-8e3cc18b2daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 14 Couplets « Votre toast, je peux vous le rendre » … « Toréador, en garde ! » (Escamillo, Mercédès, Frasquita, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d’hommes)', part.name_en = 'Carmen : Acte II. No. 14 Couplets « Votre toast, je peux vous le rendre » … « Toréador, en garde ! » (Escamillo, Mercédès, Frasquita, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d’hommes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9a771cbb-6de4-3758-b917-05b69fa0b20b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a771cbb-6de4-3758-b917-05b69fa0b20b', 5, NULL, 'Acte II. No. 14 Couplets « Votre toast, je peux vous le rendre » … « Toréador, en garde ! » (Escamillo, Mercédès, Frasquita, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d’hommes)', 'Carmen : Acte II. No. 14 Couplets « Votre toast, je peux vous le rendre » … « Toréador, en garde ! » (Escamillo, Mercédès, Frasquita, Carmen, Moralès, Zuniga, Lillas Pastia, chœur d’hommes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a771cbb-6de4-3758-b917-05b69fa0b20b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. Dialogue « Messieurs les officiers, je vous en prie » / « La belle, un mot » / « Le Dancaïre et le Remendado ont à vous parler » (Pastia, Zuniga, Escamillo, Carmen, chœur, Frasquita, Le Dancaïre)', part.name_en = 'Carmen : Acte II. Dialogue « Messieurs les officiers, je vous en prie » / « La belle, un mot » / « Le Dancaïre et le Remendado ont à vous parler » (Pastia, Zuniga, Escamillo, Carmen, chœur, Frasquita, Le Dancaïre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:788b32cb-2871-3f89-94cc-794866a49407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:788b32cb-2871-3f89-94cc-794866a49407', 6, NULL, 'Acte II. Dialogue « Messieurs les officiers, je vous en prie » / « La belle, un mot » / « Le Dancaïre et le Remendado ont à vous parler » (Pastia, Zuniga, Escamillo, Carmen, chœur, Frasquita, Le Dancaïre)', 'Carmen : Acte II. Dialogue « Messieurs les officiers, je vous en prie » / « La belle, un mot » / « Le Dancaïre et le Remendado ont à vous parler » (Pastia, Zuniga, Escamillo, Carmen, chœur, Frasquita, Le Dancaïre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:788b32cb-2871-3f89-94cc-794866a49407'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 15 Récit "Eh bien ! Vite, quelles nouvelles ? » (Frasquita, Le Dancaïre, Mercédès, Le Remendado, Carmen)', part.name_en = 'Carmen : Acte II. No. 15 Récit "Eh bien ! Vite, quelles nouvelles ? » (Frasquita, Le Dancaïre, Mercédès, Le Remendado, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4827adab-8272-3fc0-8279-d6e2422def54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4827adab-8272-3fc0-8279-d6e2422def54', 7, NULL, 'Acte II. No. 15 Récit "Eh bien ! Vite, quelles nouvelles ? » (Frasquita, Le Dancaïre, Mercédès, Le Remendado, Carmen)', 'Carmen : Acte II. No. 15 Récit "Eh bien ! Vite, quelles nouvelles ? » (Frasquita, Le Dancaïre, Mercédès, Le Remendado, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4827adab-8272-3fc0-8279-d6e2422def54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 15 Quintette « Nous avons en tête une affaire ! » (Le Dancaïre, Le Remendado, Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte II. No. 15 Quintette « Nous avons en tête une affaire ! » (Le Dancaïre, Le Remendado, Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:76df7fc2-476e-37e6-abfb-15bb2e6bce56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76df7fc2-476e-37e6-abfb-15bb2e6bce56', 8, NULL, 'Acte II. No. 15 Quintette « Nous avons en tête une affaire ! » (Le Dancaïre, Le Remendado, Carmen, Frasquita, Mercédès)', 'Carmen : Acte II. No. 15 Quintette « Nous avons en tête une affaire ! » (Le Dancaïre, Le Remendado, Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76df7fc2-476e-37e6-abfb-15bb2e6bce56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 15 Dialogue « En voilà assez » (Le Dancaïre, Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte II. No. 15 Dialogue « En voilà assez » (Le Dancaïre, Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ae6be9e6-5a6b-3d07-97bd-1d6c09c97eff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae6be9e6-5a6b-3d07-97bd-1d6c09c97eff', 9, NULL, 'Acte II. No. 15 Dialogue « En voilà assez » (Le Dancaïre, Carmen, Frasquita, Mercédès)', 'Carmen : Acte II. No. 15 Dialogue « En voilà assez » (Le Dancaïre, Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6be9e6-5a6b-3d07-97bd-1d6c09c97eff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 15 Récit : « Mais qui donc attends-tu ? » (Le Dancaïre, Le Remendado, Carmen)', part.name_en = 'Carmen : Acte II. No. 15 Récit : « Mais qui donc attends-tu ? » (Le Dancaïre, Le Remendado, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e94b0a7c-a670-3da5-be8b-b86733a37d64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e94b0a7c-a670-3da5-be8b-b86733a37d64', 10, NULL, 'Acte II. No. 15 Récit : « Mais qui donc attends-tu ? » (Le Dancaïre, Le Remendado, Carmen)', 'Carmen : Acte II. No. 15 Récit : « Mais qui donc attends-tu ? » (Le Dancaïre, Le Remendado, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e94b0a7c-a670-3da5-be8b-b86733a37d64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 16 « Halte là ! Qui va là ? Dragon d''Alcala !» (Don José, Carmen, Mercédès, Frasquita, Le Dancaïre, Le Remendado)', part.name_en = 'Carmen : Acte II. No. 16 « Halte là ! Qui va là ? Dragon d''Alcala !» (Don José, Carmen, Mercédès, Frasquita, Le Dancaïre, Le Remendado)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0782a148-fe86-32dc-bb0e-50745e2fd6a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0782a148-fe86-32dc-bb0e-50745e2fd6a8', 11, NULL, 'Acte II. No. 16 « Halte là ! Qui va là ? Dragon d''Alcala !» (Don José, Carmen, Mercédès, Frasquita, Le Dancaïre, Le Remendado)', 'Carmen : Acte II. No. 16 « Halte là ! Qui va là ? Dragon d''Alcala !» (Don José, Carmen, Mercédès, Frasquita, Le Dancaïre, Le Remendado)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0782a148-fe86-32dc-bb0e-50745e2fd6a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 16b Récit « Enfin c’est toi ! » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 16b Récit « Enfin c’est toi ! » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7531300d-ba5b-3a6f-bc93-9f98bd9b8a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7531300d-ba5b-3a6f-bc93-9f98bd9b8a16', 12, NULL, 'Acte II. No. 16b Récit « Enfin c’est toi ! » (Carmen, Don José)', 'Carmen : Acte II. No. 16b Récit « Enfin c’est toi ! » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7531300d-ba5b-3a6f-bc93-9f98bd9b8a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 17 Duo : « Attends un peu, Carmen » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 17 Duo : « Attends un peu, Carmen » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6de07893-371e-38c3-adc4-3ba76bc9ca11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6de07893-371e-38c3-adc4-3ba76bc9ca11', 13, NULL, 'Acte II. No. 17 Duo : « Attends un peu, Carmen » (Carmen, Don José)', 'Carmen : Acte II. No. 17 Duo : « Attends un peu, Carmen » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6de07893-371e-38c3-adc4-3ba76bc9ca11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 17 Duo : « Au quartier ! Pour l’appel ! » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 17 Duo : « Au quartier ! Pour l’appel ! » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:264b0e3a-7308-34b6-a9ab-2267b5079bea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:264b0e3a-7308-34b6-a9ab-2267b5079bea', 14, NULL, 'Acte II. No. 17 Duo : « Au quartier ! Pour l’appel ! » (Carmen, Don José)', 'Carmen : Acte II. No. 17 Duo : « Au quartier ! Pour l’appel ! » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264b0e3a-7308-34b6-a9ab-2267b5079bea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 17 Duo : « Tout doux, Monsieur » … « Je vais danser en votre honneur » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 17 Duo : « Tout doux, Monsieur » … « Je vais danser en votre honneur » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a0b59180-a85c-325d-a471-58259171affb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0b59180-a85c-325d-a471-58259171affb', 15, NULL, 'Acte II. No. 17 Duo : « Tout doux, Monsieur » … « Je vais danser en votre honneur » (Carmen, Don José)', 'Carmen : Acte II. No. 17 Duo : « Tout doux, Monsieur » … « Je vais danser en votre honneur » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b59180-a85c-325d-a471-58259171affb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 17 Duo : « La Fleur que tu m’avais jetée » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 17 Duo : « La Fleur que tu m’avais jetée » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fad9ff7a-d715-39e3-a087-ebbfe1ca632a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fad9ff7a-d715-39e3-a087-ebbfe1ca632a', 16, NULL, 'Acte II. No. 17 Duo : « La Fleur que tu m’avais jetée » (Carmen, Don José)', 'Carmen : Acte II. No. 17 Duo : « La Fleur que tu m’avais jetée » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad9ff7a-d715-39e3-a087-ebbfe1ca632a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 17 Duo : « Non ! Tu ne m’aimes pas » (Carmen, Don José)', part.name_en = 'Carmen : Acte II. No. 17 Duo : « Non ! Tu ne m’aimes pas » (Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:82946e57-622a-3c59-b3b3-8326ebb93d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82946e57-622a-3c59-b3b3-8326ebb93d53', 17, NULL, 'Acte II. No. 17 Duo : « Non ! Tu ne m’aimes pas » (Carmen, Don José)', 'Carmen : Acte II. No. 17 Duo : « Non ! Tu ne m’aimes pas » (Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82946e57-622a-3c59-b3b3-8326ebb93d53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Acte II, No. 18. Finale : « Bel officier, bel officier » (Carmen, Le Dancaïre, Le Remendado, Zuniga)', part.name_en = 'Carmen: Acte II, No. 18. Finale : « Bel officier, bel officier » (Carmen, Le Dancaïre, Le Remendado, Zuniga)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:36e01410-f41e-3514-be43-5b0386e85f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36e01410-f41e-3514-be43-5b0386e85f48', 18, NULL, 'Acte II, No. 18. Finale : « Bel officier, bel officier » (Carmen, Le Dancaïre, Le Remendado, Zuniga)', 'Carmen: Acte II, No. 18. Finale : « Bel officier, bel officier » (Carmen, Le Dancaïre, Le Remendado, Zuniga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e01410-f41e-3514-be43-5b0386e85f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 18 Finale « Holà ! Carmen ! Holà ! Holà ! » (Zuniga, Don José, Carmen, Le Dancaïre, Le Remendado, les Bohémiens)', part.name_en = 'Carmen : Acte II. No. 18 Finale « Holà ! Carmen ! Holà ! Holà ! » (Zuniga, Don José, Carmen, Le Dancaïre, Le Remendado, les Bohémiens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:00119dda-8a12-37c3-a05b-6c6b6b286b11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00119dda-8a12-37c3-a05b-6c6b6b286b11', 19, NULL, 'Acte II. No. 18 Finale « Holà ! Carmen ! Holà ! Holà ! » (Zuniga, Don José, Carmen, Le Dancaïre, Le Remendado, les Bohémiens)', 'Carmen : Acte II. No. 18 Finale « Holà ! Carmen ! Holà ! Holà ! » (Zuniga, Don José, Carmen, Le Dancaïre, Le Remendado, les Bohémiens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00119dda-8a12-37c3-a05b-6c6b6b286b11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Acte II. Entr’acte', part.name_en = 'Carmen : Acte II. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3', 20, NULL, 'Acte II. Entr’acte', 'Carmen : Acte II. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80201f0b-a8b7-4004-baa2-a82b8b430fa7'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f332e9-0e43-4edd-967d-405dba5a72a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Carmen : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c', 4, NULL, 'Acte III', 'Carmen : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. Introduction : « Halte ! Nous allons nous arrêter ici ! » (Dancaïre, Remendado, Don José, Carmen)', part.name_en = 'Carmen : Acte III. Introduction : « Halte ! Nous allons nous arrêter ici ! » (Dancaïre, Remendado, Don José, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ec9d7c0b-7c3e-3f9a-884f-93fcaf14f15f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ec9d7c0b-7c3e-3f9a-884f-93fcaf14f15f', 1, NULL, 'Acte III. Introduction : « Halte ! Nous allons nous arrêter ici ! » (Dancaïre, Remendado, Don José, Carmen)', 'Carmen : Acte III. Introduction : « Halte ! Nous allons nous arrêter ici ! » (Dancaïre, Remendado, Don José, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec9d7c0b-7c3e-3f9a-884f-93fcaf14f15f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sextuor et Chœur « Écoute, écoute, compagnon, écoute » (Les contrebandiers, Le Dancaïre, Le Remendado, Don José, Carmen, Mercédès, Frasquita)', part.name_en = 'Carmen : Acte III, No. 19. Sextuor et Chœur « Écoute, écoute, compagnon, écoute » (Les contrebandiers, Le Dancaïre, Le Remendado, Don José, Carmen, Mercédès, Frasquita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:45b93938-6585-3886-a6fe-5630bbf9c2c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45b93938-6585-3886-a6fe-5630bbf9c2c6', 2, NULL, 'Sextuor et Chœur « Écoute, écoute, compagnon, écoute » (Les contrebandiers, Le Dancaïre, Le Remendado, Don José, Carmen, Mercédès, Frasquita)', 'Carmen : Acte III, No. 19. Sextuor et Chœur « Écoute, écoute, compagnon, écoute » (Les contrebandiers, Le Dancaïre, Le Remendado, Don José, Carmen, Mercédès, Frasquita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b93938-6585-3886-a6fe-5630bbf9c2c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. Récitative « Reposons‐nous une heure ici » (Le Dancaïre, Carmen, Don José)', part.name_en = 'Carmen : Acte III. Récitative « Reposons‐nous une heure ici » (Le Dancaïre, Carmen, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4eea33fc-9fd8-3f61-acad-f5c6adc57453' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4eea33fc-9fd8-3f61-acad-f5c6adc57453', 3, NULL, 'Acte III. Récitative « Reposons‐nous une heure ici » (Le Dancaïre, Carmen, Don José)', 'Carmen : Acte III. Récitative « Reposons‐nous une heure ici » (Le Dancaïre, Carmen, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eea33fc-9fd8-3f61-acad-f5c6adc57453'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Trio des cartes « Mêlons ! Coupons ! » (Frasquita, Mercédès, Carmen)', part.name_en = 'Carmen : Acte III, No. 20. Trio des cartes « Mêlons ! Coupons ! » (Frasquita, Mercédès, Carmen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4cfc17eb-23ae-3396-b14f-d28e5bd333af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4cfc17eb-23ae-3396-b14f-d28e5bd333af', 4, NULL, 'Trio des cartes « Mêlons ! Coupons ! » (Frasquita, Mercédès, Carmen)', 'Carmen : Acte III, No. 20. Trio des cartes « Mêlons ! Coupons ! » (Frasquita, Mercédès, Carmen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cfc17eb-23ae-3396-b14f-d28e5bd333af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. Trio des cartes : « Carreau ! Pique !… La mort ! » (Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte III. Trio des cartes : « Carreau ! Pique !… La mort ! » (Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1d418e36-5258-3fce-85a1-bdb1de620559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d418e36-5258-3fce-85a1-bdb1de620559', 5, NULL, 'Acte III. Trio des cartes : « Carreau ! Pique !… La mort ! » (Carmen, Frasquita, Mercédès)', 'Carmen : Acte III. Trio des cartes : « Carreau ! Pique !… La mort ! » (Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d418e36-5258-3fce-85a1-bdb1de620559'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. Récitative « Eh bien ? … » (Carmen, Le Dancaïre, Frasquita)', part.name_en = 'Carmen : Acte III. Récitative « Eh bien ? … » (Carmen, Le Dancaïre, Frasquita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fbda1785-a714-340e-a013-684a6c6ff8fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fbda1785-a714-340e-a013-684a6c6ff8fc', 6, NULL, 'Acte III. Récitative « Eh bien ? … » (Carmen, Le Dancaïre, Frasquita)', 'Carmen : Acte III. Récitative « Eh bien ? … » (Carmen, Le Dancaïre, Frasquita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbda1785-a714-340e-a013-684a6c6ff8fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III. No. 21. « Quant au douanier, c’est notre affaire » (Carmen, Mercédès, Frasquita, toutes les femmes, tout le monde)', part.name_en = 'Carmen : Acte III. No. 21. « Quant au douanier, c’est notre affaire » (Carmen, Mercédès, Frasquita, toutes les femmes, tout le monde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:560874ae-8239-3f91-9fec-473b3c4be1aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:560874ae-8239-3f91-9fec-473b3c4be1aa', 7, NULL, 'Acte III. No. 21. « Quant au douanier, c’est notre affaire » (Carmen, Mercédès, Frasquita, toutes les femmes, tout le monde)', 'Carmen : Acte III. No. 21. « Quant au douanier, c’est notre affaire » (Carmen, Mercédès, Frasquita, toutes les femmes, tout le monde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560874ae-8239-3f91-9fec-473b3c4be1aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte III. Récitative « C’est des contrebandiers le refuge ordinaire » (Micaëla, le guide)', part.name_en = 'Carmen : Acte III. Récitative « C’est des contrebandiers le refuge ordinaire » (Micaëla, le guide)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f8db6887-c8c9-3e7c-b572-129cdfb5b5cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8db6887-c8c9-3e7c-b572-129cdfb5b5cc', 8, NULL, 'Acte III. Récitative « C’est des contrebandiers le refuge ordinaire » (Micaëla, le guide)', 'Carmen : Acte III. Récitative « C’est des contrebandiers le refuge ordinaire » (Micaëla, le guide)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8db6887-c8c9-3e7c-b572-129cdfb5b5cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte III. No. 22. Air « Je dis que rien ne m’épouvante » (Micaëla)', part.name_en = 'Carmen : Acte III. No. 22. Air « Je dis que rien ne m’épouvante » (Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c6bfb6f6-e5db-3c4c-ae46-ad8761217be0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6bfb6f6-e5db-3c4c-ae46-ad8761217be0', 9, NULL, 'Acte III. No. 22. Air « Je dis que rien ne m’épouvante » (Micaëla)', 'Carmen : Acte III. No. 22. Air « Je dis que rien ne m’épouvante » (Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6bfb6f6-e5db-3c4c-ae46-ad8761217be0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte III. Récitative « Je ne me trompe pas… » (Micaëla)', part.name_en = 'Carmen : Acte III. Récitative « Je ne me trompe pas… » (Micaëla)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:df7290a4-0bef-32f1-8881-c414512be26a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df7290a4-0bef-32f1-8881-c414512be26a', 10, NULL, 'Acte III. Récitative « Je ne me trompe pas… » (Micaëla)', 'Carmen : Acte III. Récitative « Je ne me trompe pas… » (Micaëla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7290a4-0bef-32f1-8881-c414512be26a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte III. No. 23. Duo « Quelques lignes plus bas » …« Je suis Escamillo, toréro de Grenade ! » (Escamillo, Don José)', part.name_en = 'Carmen : Acte III. No. 23. Duo « Quelques lignes plus bas » …« Je suis Escamillo, toréro de Grenade ! » (Escamillo, Don José)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1d0dc5c0-b261-3cac-9f71-f0d7bd196deb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d0dc5c0-b261-3cac-9f71-f0d7bd196deb', 11, NULL, 'Acte III. No. 23. Duo « Quelques lignes plus bas » …« Je suis Escamillo, toréro de Grenade ! » (Escamillo, Don José)', 'Carmen : Acte III. No. 23. Duo « Quelques lignes plus bas » …« Je suis Escamillo, toréro de Grenade ! » (Escamillo, Don José)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0dc5c0-b261-3cac-9f71-f0d7bd196deb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte III. No. 24. Finale « Holà, holà, José ! » (Carmen, Escamillo, Micaëla, Frasquita, Mercédès, Le Dancaïre, Don José, Le Remendado, Chœur)', part.name_en = 'Carmen : Acte III. No. 24. Finale « Holà, holà, José ! » (Carmen, Escamillo, Micaëla, Frasquita, Mercédès, Le Dancaïre, Don José, Le Remendado, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:500727b1-436c-3fac-b325-1361e3224ac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:500727b1-436c-3fac-b325-1361e3224ac9', 12, NULL, 'Acte III. No. 24. Finale « Holà, holà, José ! » (Carmen, Escamillo, Micaëla, Frasquita, Mercédès, Le Dancaïre, Don José, Le Remendado, Chœur)', 'Carmen : Acte III. No. 24. Finale « Holà, holà, José ! » (Carmen, Escamillo, Micaëla, Frasquita, Mercédès, Le Dancaïre, Don José, Le Remendado, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500727b1-436c-3fac-b325-1361e3224ac9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte III. Final « Halte ! Quelqu''un est là » … « Moi, je viens te chercher ! » (Le Remendado, Carmen, le Dancaïre, Don José, Micaëla, Frasquita, Mercédès, Escamillo, contrebandiers, contrebandières)', part.name_en = 'Carmen : Acte III. Final « Halte ! Quelqu''un est là » … « Moi, je viens te chercher ! » (Le Remendado, Carmen, le Dancaïre, Don José, Micaëla, Frasquita, Mercédès, Escamillo, contrebandiers, contrebandières)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f3980bdb-e87e-357c-92e8-c7e0e31f99c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3980bdb-e87e-357c-92e8-c7e0e31f99c1', 13, NULL, 'Acte III. Final « Halte ! Quelqu''un est là » … « Moi, je viens te chercher ! » (Le Remendado, Carmen, le Dancaïre, Don José, Micaëla, Frasquita, Mercédès, Escamillo, contrebandiers, contrebandières)', 'Carmen : Acte III. Final « Halte ! Quelqu''un est là » … « Moi, je viens te chercher ! » (Le Remendado, Carmen, le Dancaïre, Don José, Micaëla, Frasquita, Mercédès, Escamillo, contrebandiers, contrebandières)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3980bdb-e87e-357c-92e8-c7e0e31f99c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Acte III. Entr’acte', part.name_en = 'Carmen : Acte III. Entr’acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec', 14, NULL, 'Acte III. Entr’acte', 'Carmen : Acte III. Entr’acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61f95a8-1426-4d24-8e8a-fd3068fa5f5c'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa2ed1af-0b6b-4d8b-8244-0d86a7e935ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Carmen : Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139', 5, NULL, 'Acte IV', 'Carmen : Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 25 « À deux cuartos ! » (Chœur, Zuniga, Moralès, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte IV. No. 25 « À deux cuartos ! » (Chœur, Zuniga, Moralès, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:aa46f2e7-e84d-34c7-a488-ca145784fbb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa46f2e7-e84d-34c7-a488-ca145784fbb8', 1, NULL, 'Acte IV. No. 25 « À deux cuartos ! » (Chœur, Zuniga, Moralès, Frasquita, Mercédès)', 'Carmen : Acte IV. No. 25 « À deux cuartos ! » (Chœur, Zuniga, Moralès, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa46f2e7-e84d-34c7-a488-ca145784fbb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV. Dialogue « Qu''avez-vous donc fait de la Carmencita ? » (Zuniga, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte IV. Dialogue « Qu''avez-vous donc fait de la Carmencita ? » (Zuniga, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b74c306f-b2ef-3977-b2b6-498627e54253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b74c306f-b2ef-3977-b2b6-498627e54253', 2, NULL, 'Acte IV. Dialogue « Qu''avez-vous donc fait de la Carmencita ? » (Zuniga, Frasquita, Mercédès)', 'Carmen : Acte IV. Dialogue « Qu''avez-vous donc fait de la Carmencita ? » (Zuniga, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b74c306f-b2ef-3977-b2b6-498627e54253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 26 « Les voici ! Voici la quadrille ! » (Chœur, les gamins, Escamillo, Carmen, Frasquita, Mercédès)', part.name_en = 'Carmen : Acte IV. No. 26 « Les voici ! Voici la quadrille ! » (Chœur, les gamins, Escamillo, Carmen, Frasquita, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4675d8be-af52-3f74-befd-22144dc407b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4675d8be-af52-3f74-befd-22144dc407b7', 3, NULL, 'Acte IV. No. 26 « Les voici ! Voici la quadrille ! » (Chœur, les gamins, Escamillo, Carmen, Frasquita, Mercédès)', 'Carmen : Acte IV. No. 26 « Les voici ! Voici la quadrille ! » (Chœur, les gamins, Escamillo, Carmen, Frasquita, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4675d8be-af52-3f74-befd-22144dc407b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Si tu m’aimes, Carmen » (Escamillo, Carmen, chœur)', part.name_en = 'Carmen : Acte IV. « Si tu m’aimes, Carmen » (Escamillo, Carmen, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:434a95d9-a7ad-3919-88d1-2cc8011ad318' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:434a95d9-a7ad-3919-88d1-2cc8011ad318', 4, NULL, 'Acte IV. « Si tu m’aimes, Carmen » (Escamillo, Carmen, chœur)', 'Carmen : Acte IV. « Si tu m’aimes, Carmen » (Escamillo, Carmen, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:434a95d9-a7ad-3919-88d1-2cc8011ad318'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Place, place ! Place ! Au seigneur Alcalde ! » … « Carmen, un bon conseil » (Chœur, Frasquita, Carmen, Mercédès)', part.name_en = 'Carmen : Acte IV. « Place, place ! Place ! Au seigneur Alcalde ! » … « Carmen, un bon conseil » (Chœur, Frasquita, Carmen, Mercédès)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a995bc1e-d3c6-441a-a43f-906c0d336754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a995bc1e-d3c6-441a-a43f-906c0d336754', 5, NULL, 'Acte IV. « Place, place ! Place ! Au seigneur Alcalde ! » … « Carmen, un bon conseil » (Chœur, Frasquita, Carmen, Mercédès)', 'Carmen : Acte IV. « Place, place ! Place ! Au seigneur Alcalde ! » … « Carmen, un bon conseil » (Chœur, Frasquita, Carmen, Mercédès)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a995bc1e-d3c6-441a-a43f-906c0d336754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 27 Duo final : « C’est toi ! – C’est moi ! » (Carmen, Don José, chœur)', part.name_en = 'Carmen : Acte IV. No. 27 Duo final : « C’est toi ! – C’est moi ! » (Carmen, Don José, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5c27d587-e3c2-312d-958a-71e56ec119a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c27d587-e3c2-312d-958a-71e56ec119a9', 6, NULL, 'Acte IV. No. 27 Duo final : « C’est toi ! – C’est moi ! » (Carmen, Don José, chœur)', 'Carmen : Acte IV. No. 27 Duo final : « C’est toi ! – C’est moi ! » (Carmen, Don José, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c27d587-e3c2-312d-958a-71e56ec119a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Viva ! Viva ! La course est belle » (Chœur)', part.name_en = 'Carmen : Acte IV. « Viva ! Viva ! La course est belle » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9105d8b0-ff03-4890-a27a-2ce050dc0f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9105d8b0-ff03-4890-a27a-2ce050dc0f4f', 7, NULL, 'Acte IV. « Viva ! Viva ! La course est belle » (Chœur)', 'Carmen : Acte IV. « Viva ! Viva ! La course est belle » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9105d8b0-ff03-4890-a27a-2ce050dc0f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte IV. « Où vas‐tu ? – Laisse‐moi ! » (Don José, Carmen, Chœur)', part.name_en = 'Carmen : Acte IV. « Où vas‐tu ? – Laisse‐moi ! » (Don José, Carmen, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a6eedba1-9cab-318f-854b-1e77479d5d26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6eedba1-9cab-318f-854b-1e77479d5d26', 8, NULL, 'Acte IV. « Où vas‐tu ? – Laisse‐moi ! » (Don José, Carmen, Chœur)', 'Carmen : Acte IV. « Où vas‐tu ? – Laisse‐moi ! » (Don José, Carmen, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6eedba1-9cab-318f-854b-1e77479d5d26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pastorale', part.name_en = 'Carmen: Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:00c0da2d-4eff-4dbc-9f61-d42a6bb27416' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00c0da2d-4eff-4dbc-9f61-d42a6bb27416', 9, NULL, 'Pastorale', 'Carmen: Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00c0da2d-4eff-4dbc-9f61-d42a6bb27416'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Marche', part.name_en = 'Carmen: Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:23f6c263-3047-43d6-8947-68b4e1c872dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23f6c263-3047-43d6-8947-68b4e1c872dd', 10, NULL, 'Marche', 'Carmen: Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f6c263-3047-43d6-8947-68b4e1c872dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Danse bohémienne', part.name_en = 'Carmen: Danse bohémienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:318a5c7e-4294-4b01-87a5-d082e2db1513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:318a5c7e-4294-4b01-87a5-d082e2db1513', 11, NULL, 'Danse bohémienne', 'Carmen: Danse bohémienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318a5c7e-4294-4b01-87a5-d082e2db1513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Farandole', part.name_en = 'Carmen: Farandole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11318 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6011eff4-5929-4972-af2c-900930fbc5df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6011eff4-5929-4972-af2c-900930fbc5df', 12, NULL, 'Farandole', 'Carmen: Farandole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24bf7a10-135e-4bd6-b2db-32d641436139'
WHERE p.id = 11318 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6011eff4-5929-4972-af2c-900930fbc5df'
);


-- None Carmen: Abertura

UPDATE pieces piece
SET piece.title = 'Carmen: Abertura', piece.title_en = 'Carmen: Abertura',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11738 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Carmen: Act II. Entr'acte. Les Dragons d’Alcala

UPDATE pieces piece
SET piece.title = 'Carmen: Act II. Entr''acte. Les Dragons d’Alcala', piece.title_en = 'Carmen: Act II. Entr''acte. Les Dragons d’Alcala',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11443 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Carmen: Malaguena

UPDATE pieces piece
SET piece.title = 'Carmen: Malaguena', piece.title_en = 'Carmen: Malaguena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11587 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Casilda

UPDATE pieces piece
SET piece.title = 'Casilda', piece.title_en = 'Casilda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11921 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chanson bohème (from Carmen)

UPDATE pieces piece
SET piece.title = 'Chanson bohème (from Carmen)', piece.title_en = 'Chanson bohème (from Carmen)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11562 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chanson “De mon ami”>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson “De mon ami”>', piece.title_en = 'Chanson “De mon ami”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11393 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chants du Rhin

UPDATE pieces piece
SET piece.title = 'Chants du Rhin', piece.title_en = 'Chants du Rhin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11722 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L''Aurore', part.name_en = 'Chants du Rhin: I. L''Aurore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:bdbc1a38-463c-4869-a343-9f0d2d2525b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdbc1a38-463c-4869-a343-9f0d2d2525b2', 1, 'I', 'L''Aurore', 'Chants du Rhin: I. L''Aurore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdbc1a38-463c-4869-a343-9f0d2d2525b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Départ', part.name_en = 'Chants du Rhin: II. Le Départ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:46912636-b853-442f-b2db-d988c9ea3c39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46912636-b853-442f-b2db-d988c9ea3c39', 2, 'II', 'Le Départ', 'Chants du Rhin: II. Le Départ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46912636-b853-442f-b2db-d988c9ea3c39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les Rêves', part.name_en = 'Chants du Rhin: III. Les Rêves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2e67916e-9e9d-422a-8923-b1e9cff5b4aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e67916e-9e9d-422a-8923-b1e9cff5b4aa', 3, 'III', 'Les Rêves', 'Chants du Rhin: III. Les Rêves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e67916e-9e9d-422a-8923-b1e9cff5b4aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Bohémienne', part.name_en = 'Chants du Rhin: IV. La Bohémienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7fbf692b-06dd-47c0-85c4-8e8a859b91e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fbf692b-06dd-47c0-85c4-8e8a859b91e8', 4, 'IV', 'La Bohémienne', 'Chants du Rhin: IV. La Bohémienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fbf692b-06dd-47c0-85c4-8e8a859b91e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Les Confidences', part.name_en = 'Chants du Rhin: V. Les Confidences',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:04040dd1-a1b8-450d-8e61-b8b46e2d2a94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04040dd1-a1b8-450d-8e61-b8b46e2d2a94', 5, 'V', 'Les Confidences', 'Chants du Rhin: V. Les Confidences', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04040dd1-a1b8-450d-8e61-b8b46e2d2a94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Le Retour', part.name_en = 'Chants du Rhin: VI. Le Retour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11722 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:87142601-94e5-41dc-a046-d9eeb84e913f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87142601-94e5-41dc-a046-d9eeb84e913f', 6, 'VI', 'Le Retour', 'Chants du Rhin: VI. Le Retour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11722 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87142601-94e5-41dc-a046-d9eeb84e913f'
);


-- None Chasse fantastique, WD 51

UPDATE pieces piece
SET piece.title = 'Chasse fantastique, WD 51', piece.title_en = 'Chasse fantastique, WD 51',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11962 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chromatic Variations C Major>

UPDATE pieces piece
SET piece.title = '가곡 <Chromatic Variations C Major>', piece.title_en = 'Chromatic Variations C Major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11770 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chœur d’étudiants, WD 111

UPDATE pieces piece
SET piece.title = 'Chœur d’étudiants, WD 111', piece.title_en = 'Chœur d’étudiants, WD 111',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11488 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Clovis et Clotilde, WD 121, GB 55>

UPDATE pieces piece
SET piece.title = '칸타타 <Clovis et Clotilde, WD 121, GB 55>', piece.title_en = 'Clovis et Clotilde, WD 121, GB 55',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11690 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction: Largo – Allegro non troppo – Andantino – Allegro vivo', part.name_en = 'Clovis et Clotilde: Introduction: Largo – Allegro non troppo – Andantino – Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0fdf6b99-903c-4b66-856e-8b0f2d7914ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fdf6b99-903c-4b66-856e-8b0f2d7914ac', 1, NULL, 'Introduction: Largo – Allegro non troppo – Andantino – Allegro vivo', 'Clovis et Clotilde: Introduction: Largo – Allegro non troppo – Andantino – Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fdf6b99-903c-4b66-856e-8b0f2d7914ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scène 1', part.name_en = 'Clovis et Clotilde: Scène 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763', 2, NULL, 'Scène 1', 'Clovis et Clotilde: Scène 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Récit: Noble Clovis (Clotilde)', part.name_en = 'Clovis et Clotilde: Scène 1: 1. Récit: Noble Clovis (Clotilde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fb8c14de-6a05-448f-bccb-8bef917d16fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb8c14de-6a05-448f-bccb-8bef917d16fe', 1, NULL, 'Récit: Noble Clovis (Clotilde)', 'Clovis et Clotilde: Scène 1: 1. Récit: Noble Clovis (Clotilde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8c14de-6a05-448f-bccb-8bef917d16fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Romance: Il est si beau (Clotilde)', part.name_en = 'Clovis et Clotilde: Scène 1: 2. Romance: Il est si beau (Clotilde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7103155a-3603-4c1d-bf00-25fc03dd5e9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7103155a-3603-4c1d-bf00-25fc03dd5e9a', 2, NULL, 'Romance: Il est si beau (Clotilde)', 'Clovis et Clotilde: Scène 1: 2. Romance: Il est si beau (Clotilde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84a182f3-ac87-439e-a4f4-244dfce7c763'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7103155a-3603-4c1d-bf00-25fc03dd5e9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scène 2', part.name_en = 'Clovis et Clotilde: Scène 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6', 3, NULL, 'Scène 2', 'Clovis et Clotilde: Scène 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duo: Que vois-je! (Clotilde / Rémy)', part.name_en = 'Clovis et Clotilde: Scène 2: 1. Duo: Que vois-je! (Clotilde / Rémy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d5240f65-fdff-496e-8cb9-152d2d4414c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5240f65-fdff-496e-8cb9-152d2d4414c0', 1, NULL, 'Duo: Que vois-je! (Clotilde / Rémy)', 'Clovis et Clotilde: Scène 2: 1. Duo: Que vois-je! (Clotilde / Rémy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5240f65-fdff-496e-8cb9-152d2d4414c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récit: Reine, je vais pour vous (Rémy)', part.name_en = 'Clovis et Clotilde: Scène 2: 2. Récit: Reine, je vais pour vous (Rémy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:25b80bc7-105a-460a-b0b7-31aa942f080f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25b80bc7-105a-460a-b0b7-31aa942f080f', 2, NULL, 'Récit: Reine, je vais pour vous (Rémy)', 'Clovis et Clotilde: Scène 2: 2. Récit: Reine, je vais pour vous (Rémy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10968257-d04a-419e-b745-134291d7a3e6'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25b80bc7-105a-460a-b0b7-31aa942f080f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scène 3: Prière! Prière! (Clotilde)', part.name_en = 'Clovis et Clotilde: Scène 3: Prière! Prière! (Clotilde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5199bdf1-4c5f-47e8-892c-639617804e3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5199bdf1-4c5f-47e8-892c-639617804e3b', 4, NULL, 'Scène 3: Prière! Prière! (Clotilde)', 'Clovis et Clotilde: Scène 3: Prière! Prière! (Clotilde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5199bdf1-4c5f-47e8-892c-639617804e3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scène 4', part.name_en = 'Clovis et Clotilde: Scène 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19', 5, NULL, 'Scène 4', 'Clovis et Clotilde: Scène 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duo: Ma Clotilde chérie! (Clovis / Clotilde)', part.name_en = 'Clovis et Clotilde: Scène 4: 1. Duo: Ma Clotilde chérie! (Clovis / Clotilde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:54405d93-da95-4b2a-aba5-7a464de47107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54405d93-da95-4b2a-aba5-7a464de47107', 1, NULL, 'Duo: Ma Clotilde chérie! (Clovis / Clotilde)', 'Clovis et Clotilde: Scène 4: 1. Duo: Ma Clotilde chérie! (Clovis / Clotilde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54405d93-da95-4b2a-aba5-7a464de47107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Duo (suite): Paix, triomphe, espérance! (Clotilde / Clovis)', part.name_en = 'Clovis et Clotilde: Scène 4: 2. Duo (suite): Paix, triomphe, espérance! (Clotilde / Clovis)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7e87b2f0-5e82-41d4-a915-72c786805358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e87b2f0-5e82-41d4-a915-72c786805358', 2, NULL, 'Duo (suite): Paix, triomphe, espérance! (Clotilde / Clovis)', 'Clovis et Clotilde: Scène 4: 2. Duo (suite): Paix, triomphe, espérance! (Clotilde / Clovis)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e87b2f0-5e82-41d4-a915-72c786805358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duo (suite): Mais comment laissas-tu (Clotilde / Clovis)', part.name_en = 'Clovis et Clotilde: Scène 4: 3. Duo (suite): Mais comment laissas-tu (Clotilde / Clovis)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0f94cfea-0044-4c1c-a587-d5297dd9f0a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f94cfea-0044-4c1c-a587-d5297dd9f0a5', 3, NULL, 'Duo (suite): Mais comment laissas-tu (Clotilde / Clovis)', 'Clovis et Clotilde: Scène 4: 3. Duo (suite): Mais comment laissas-tu (Clotilde / Clovis)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f94cfea-0044-4c1c-a587-d5297dd9f0a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Duo (suite): Ta douce aurore (Clotilde)', part.name_en = 'Clovis et Clotilde: Scène 4: 4. Duo (suite): Ta douce aurore (Clotilde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fc9623b7-7401-456d-85a3-9e47656f3142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc9623b7-7401-456d-85a3-9e47656f3142', 4, NULL, 'Duo (suite): Ta douce aurore (Clotilde)', 'Clovis et Clotilde: Scène 4: 4. Duo (suite): Ta douce aurore (Clotilde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c2a3cd06-b52e-45d7-b774-f5b5898def19'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9623b7-7401-456d-85a3-9e47656f3142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scène 5', part.name_en = 'Clovis et Clotilde: Scène 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16', 6, NULL, 'Scène 5', 'Clovis et Clotilde: Scène 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Récit: Mon père, en ce beau jour (Clotilde / Rémy)', part.name_en = 'Clovis et Clotilde: Scène 5: 1. Récit: Mon père, en ce beau jour (Clotilde / Rémy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f0266ad5-6c77-4d54-a5da-0e1a0ebe9069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0266ad5-6c77-4d54-a5da-0e1a0ebe9069', 1, NULL, 'Récit: Mon père, en ce beau jour (Clotilde / Rémy)', 'Clovis et Clotilde: Scène 5: 1. Récit: Mon père, en ce beau jour (Clotilde / Rémy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0266ad5-6c77-4d54-a5da-0e1a0ebe9069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Strophes: Salut à toi (Rémy)', part.name_en = 'Clovis et Clotilde: Scène 5: 2. Strophes: Salut à toi (Rémy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2a5b560d-5d4d-4079-a139-3226afea8abf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a5b560d-5d4d-4079-a139-3226afea8abf', 2, NULL, 'Strophes: Salut à toi (Rémy)', 'Clovis et Clotilde: Scène 5: 2. Strophes: Salut à toi (Rémy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ecf02dca-fdd6-475d-be2e-cfe92a038e16'
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a5b560d-5d4d-4079-a139-3226afea8abf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ensemble final: C’en est fait (Clovis / Clotilde / Rémy)', part.name_en = 'Clovis et Clotilde: Ensemble final: C’en est fait (Clovis / Clotilde / Rémy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11690 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0cf4bb23-0b58-441d-9952-071ef0f35db4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cf4bb23-0b58-441d-9952-071ef0f35db4', 7, NULL, 'Ensemble final: C’en est fait (Clovis / Clotilde / Rémy)', 'Clovis et Clotilde: Ensemble final: C’en est fait (Clovis / Clotilde / Rémy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11690 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cf4bb23-0b58-441d-9952-071ef0f35db4'
);


-- None 가곡 <Conte, WD 101>

UPDATE pieces piece
SET piece.title = '가곡 <Conte, WD 101>', piece.title_en = 'Conte, WD 101',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11420 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Djamileh, WD 27>

UPDATE pieces piece
SET piece.title = '오페라 <Djamileh, WD 27>', piece.title_en = 'Djamileh, WD 27',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11483 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Djamileh, WD 27: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e39879ba-bb34-46c9-b80f-b74ad37d678b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e39879ba-bb34-46c9-b80f-b74ad37d678b', 1, NULL, 'Ouverture', 'Djamileh, WD 27: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e39879ba-bb34-46c9-b80f-b74ad37d678b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chœur. « Le soleil s’en va » (Chœur)', part.name_en = 'Djamileh, WD 27: Chœur. « Le soleil s’en va » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:06ca4370-78d8-4188-a42a-80f17c470077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06ca4370-78d8-4188-a42a-80f17c470077', 2, NULL, 'Chœur. « Le soleil s’en va » (Chœur)', 'Djamileh, WD 27: Chœur. « Le soleil s’en va » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06ca4370-78d8-4188-a42a-80f17c470077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rêverie. « Dans la blonde fumée » (Haroun)', part.name_en = 'Djamileh, WD 27: Rêverie. « Dans la blonde fumée » (Haroun)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fbc60fd3-ea0b-49e3-ac43-3791a3a4c957' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc60fd3-ea0b-49e3-ac43-3791a3a4c957', 3, NULL, 'Rêverie. « Dans la blonde fumée » (Haroun)', 'Djamileh, WD 27: Rêverie. « Dans la blonde fumée » (Haroun)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc60fd3-ea0b-49e3-ac43-3791a3a4c957'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pantomime et reprise du chœur. « Le soleil s’en va » (Chœur)', part.name_en = 'Djamileh, WD 27: Pantomime et reprise du chœur. « Le soleil s’en va » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b5bc6da4-c364-461f-94e2-1e8c83542ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5bc6da4-c364-461f-94e2-1e8c83542ab8', 4, NULL, 'Pantomime et reprise du chœur. « Le soleil s’en va » (Chœur)', 'Djamileh, WD 27: Pantomime et reprise du chœur. « Le soleil s’en va » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5bc6da4-c364-461f-94e2-1e8c83542ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Hé ! Splendiano ! » (Haroun, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « Hé ! Splendiano ! » (Haroun, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:89a14faf-74ff-4a59-bdba-8dc8553c7c59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89a14faf-74ff-4a59-bdba-8dc8553c7c59', 5, NULL, 'Dialogue. « Hé ! Splendiano ! » (Haroun, Splendiano)', 'Djamileh, WD 27: Dialogue. « Hé ! Splendiano ! » (Haroun, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a14faf-74ff-4a59-bdba-8dc8553c7c59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Duo. « Songez‐y bien ! » (Haroun, Splendiano)', part.name_en = 'Djamileh, WD 27: Duo. « Songez‐y bien ! » (Haroun, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:46c3769c-b4a8-4198-ae39-84a3db63fb15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46c3769c-b4a8-4198-ae39-84a3db63fb15', 6, NULL, 'Duo. « Songez‐y bien ! » (Haroun, Splendiano)', 'Djamileh, WD 27: Duo. « Songez‐y bien ! » (Haroun, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46c3769c-b4a8-4198-ae39-84a3db63fb15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Couplets et suite du duo. « Tu veux savoir » (Haroun, Splendiano)', part.name_en = 'Djamileh, WD 27: Couplets et suite du duo. « Tu veux savoir » (Haroun, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:40d5f316-1a18-44aa-989b-a6ef22a7cde1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d5f316-1a18-44aa-989b-a6ef22a7cde1', 7, NULL, 'Couplets et suite du duo. « Tu veux savoir » (Haroun, Splendiano)', 'Djamileh, WD 27: Couplets et suite du duo. « Tu veux savoir » (Haroun, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d5f316-1a18-44aa-989b-a6ef22a7cde1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « C’est elle ! Fais servir le dîner ! » (Haroun, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « C’est elle ! Fais servir le dîner ! » (Haroun, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:30c75f9c-6862-4c0b-967d-d980edf520e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30c75f9c-6862-4c0b-967d-d980edf520e3', 8, NULL, 'Dialogue. « C’est elle ! Fais servir le dîner ! » (Haroun, Splendiano)', 'Djamileh, WD 27: Dialogue. « C’est elle ! Fais servir le dîner ! » (Haroun, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30c75f9c-6862-4c0b-967d-d980edf520e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Trio. « Quelle pâleur est sur ta joue ? » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Trio. « Quelle pâleur est sur ta joue ? » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:93252f08-8a90-4a2b-b102-557e4295aecb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93252f08-8a90-4a2b-b102-557e4295aecb', 9, NULL, 'Trio. « Quelle pâleur est sur ta joue ? » (Haroun, Djamileh)', 'Djamileh, WD 27: Trio. « Quelle pâleur est sur ta joue ? » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93252f08-8a90-4a2b-b102-557e4295aecb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Trio (suite). « Chère, laissons‐nous vivre » (Haroun, Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Trio (suite). « Chère, laissons‐nous vivre » (Haroun, Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:df907bc8-0514-44dd-9f94-9f3b0f06224a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df907bc8-0514-44dd-9f94-9f3b0f06224a', 10, NULL, 'Trio (suite). « Chère, laissons‐nous vivre » (Haroun, Djamileh, Splendiano)', 'Djamileh, WD 27: Trio (suite). « Chère, laissons‐nous vivre » (Haroun, Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df907bc8-0514-44dd-9f94-9f3b0f06224a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ghazel. « Nour‐Eddin, roi de Lahore » (Djamileh)', part.name_en = 'Djamileh, WD 27: Ghazel. « Nour‐Eddin, roi de Lahore » (Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:865ade2a-2801-47c5-9542-e7d412236854' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:865ade2a-2801-47c5-9542-e7d412236854', 11, NULL, 'Ghazel. « Nour‐Eddin, roi de Lahore » (Djamileh)', 'Djamileh, WD 27: Ghazel. « Nour‐Eddin, roi de Lahore » (Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:865ade2a-2801-47c5-9542-e7d412236854'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Trio (fin). « L’histoire sans doute » (Haroun, Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Trio (fin). « L’histoire sans doute » (Haroun, Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e44327d9-f973-49d1-adc3-3b726adb2b25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e44327d9-f973-49d1-adc3-3b726adb2b25', 12, NULL, 'Trio (fin). « L’histoire sans doute » (Haroun, Djamileh, Splendiano)', 'Djamileh, WD 27: Trio (fin). « L’histoire sans doute » (Haroun, Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e44327d9-f973-49d1-adc3-3b726adb2b25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Je t’ai interrompue tout à l’heure » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Dialogue. « Je t’ai interrompue tout à l’heure » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:da8941fa-d6fa-4ad0-a838-d93c17c7ac07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da8941fa-d6fa-4ad0-a838-d93c17c7ac07', 13, NULL, 'Dialogue. « Je t’ai interrompue tout à l’heure » (Haroun, Djamileh)', 'Djamileh, WD 27: Dialogue. « Je t’ai interrompue tout à l’heure » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da8941fa-d6fa-4ad0-a838-d93c17c7ac07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Chœur (suite). « C’est Djamileh ! venez ! » (Haroun, chœur)', part.name_en = 'Djamileh, WD 27: Chœur (suite). « C’est Djamileh ! venez ! » (Haroun, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:32ed3f05-9630-4523-a1fc-89600fad4198' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ed3f05-9630-4523-a1fc-89600fad4198', 14, NULL, 'Chœur (suite). « C’est Djamileh ! venez ! » (Haroun, chœur)', 'Djamileh, WD 27: Chœur (suite). « C’est Djamileh ! venez ! » (Haroun, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ed3f05-9630-4523-a1fc-89600fad4198'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Chœur. « Salut ! Seigneur Haroun ! » (Haroun, chœur)', part.name_en = 'Djamileh, WD 27: Chœur. « Salut ! Seigneur Haroun ! » (Haroun, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8a2b8c1f-3618-470a-863f-f2e125e91669' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a2b8c1f-3618-470a-863f-f2e125e91669', 15, NULL, 'Chœur. « Salut ! Seigneur Haroun ! » (Haroun, chœur)', 'Djamileh, WD 27: Chœur. « Salut ! Seigneur Haroun ! » (Haroun, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a2b8c1f-3618-470a-863f-f2e125e91669'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Mélodrame.« Ah ! je t’ai ménagé une surprise ! » (Haroun, Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Mélodrame.« Ah ! je t’ai ménagé une surprise ! » (Haroun, Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5558af06-2db7-4c11-aaa6-e072425db9a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5558af06-2db7-4c11-aaa6-e072425db9a3', 16, NULL, 'Mélodrame.« Ah ! je t’ai ménagé une surprise ! » (Haroun, Djamileh, Splendiano)', 'Djamileh, WD 27: Mélodrame.« Ah ! je t’ai ménagé une surprise ! » (Haroun, Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5558af06-2db7-4c11-aaa6-e072425db9a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Ces paroles qu’il m’a dites » (Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « Ces paroles qu’il m’a dites » (Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fe0122a6-c931-4add-8fc4-11ce5269464f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe0122a6-c931-4add-8fc4-11ce5269464f', 17, NULL, 'Dialogue. « Ces paroles qu’il m’a dites » (Djamileh, Splendiano)', 'Djamileh, WD 27: Dialogue. « Ces paroles qu’il m’a dites » (Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe0122a6-c931-4add-8fc4-11ce5269464f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Chanson. « La fortune est femme » (Haroun, chœur)', part.name_en = 'Djamileh, WD 27: Chanson. « La fortune est femme » (Haroun, chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:17468a48-3601-48b5-b978-9f09a6988baa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17468a48-3601-48b5-b978-9f09a6988baa', 18, NULL, 'Chanson. « La fortune est femme » (Haroun, chœur)', 'Djamileh, WD 27: Chanson. « La fortune est femme » (Haroun, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17468a48-3601-48b5-b978-9f09a6988baa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Tu entends ? Tu as reconnu sa voix » (Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « Tu entends ? Tu as reconnu sa voix » (Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f3d9b80f-8eff-42fa-8c6c-5378c445cd3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3d9b80f-8eff-42fa-8c6c-5378c445cd3d', 19, NULL, 'Dialogue. « Tu entends ? Tu as reconnu sa voix » (Djamileh, Splendiano)', 'Djamileh, WD 27: Dialogue. « Tu entends ? Tu as reconnu sa voix » (Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3d9b80f-8eff-42fa-8c6c-5378c445cd3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Lamento. « Sans doute, l’heure est prochaine » (Djamileh)', part.name_en = 'Djamileh, WD 27: Lamento. « Sans doute, l’heure est prochaine » (Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8de685a8-60df-48c8-8486-dd78ea465249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8de685a8-60df-48c8-8486-dd78ea465249', 20, NULL, 'Lamento. « Sans doute, l’heure est prochaine » (Djamileh)', 'Djamileh, WD 27: Lamento. « Sans doute, l’heure est prochaine » (Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8de685a8-60df-48c8-8486-dd78ea465249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Tu m’ennuies avec tes scrupules » (Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « Tu m’ennuies avec tes scrupules » (Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:344230e0-5b8c-4e28-b0e7-4be9ecb5fc41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:344230e0-5b8c-4e28-b0e7-4be9ecb5fc41', 21, NULL, 'Dialogue. « Tu m’ennuies avec tes scrupules » (Splendiano)', 'Djamileh, WD 27: Dialogue. « Tu m’ennuies avec tes scrupules » (Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:344230e0-5b8c-4e28-b0e7-4be9ecb5fc41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Mélodrame. « Non ! je ne veux pas » (Haroun, Splendiano, le Marchand)', part.name_en = 'Djamileh, WD 27: Mélodrame. « Non ! je ne veux pas » (Haroun, Splendiano, le Marchand)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e4af1bc0-8c34-4a43-b6bf-60f2a38e492a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4af1bc0-8c34-4a43-b6bf-60f2a38e492a', 22, NULL, 'Mélodrame. « Non ! je ne veux pas » (Haroun, Splendiano, le Marchand)', 'Djamileh, WD 27: Mélodrame. « Non ! je ne veux pas » (Haroun, Splendiano, le Marchand)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4af1bc0-8c34-4a43-b6bf-60f2a38e492a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Danse et Chœur. « Froide et lente » (Chœur)', part.name_en = 'Djamileh, WD 27: Danse et Chœur. « Froide et lente » (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5e4216ca-cc99-4ee9-b991-244b3b41f4c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e4216ca-cc99-4ee9-b991-244b3b41f4c5', 23, NULL, 'Danse et Chœur. « Froide et lente » (Chœur)', 'Djamileh, WD 27: Danse et Chœur. « Froide et lente » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4216ca-cc99-4ee9-b991-244b3b41f4c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Eh bien ? » (Le Marchand, Haroun)', part.name_en = 'Djamileh, WD 27: Dialogue. « Eh bien ? » (Le Marchand, Haroun)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:bf28af20-7dbf-48bb-9701-d6a1d1017797' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf28af20-7dbf-48bb-9701-d6a1d1017797', 24, NULL, 'Dialogue. « Eh bien ? » (Le Marchand, Haroun)', 'Djamileh, WD 27: Dialogue. « Eh bien ? » (Le Marchand, Haroun)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf28af20-7dbf-48bb-9701-d6a1d1017797'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11505 AND linked.composer_id = 44),
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Sortie d’Haroun et de ses Amis', part.name_en = 'Djamileh, WD 27: Sortie d’Haroun et de ses Amis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2f8020c3-e225-4e83-8333-11daacdc89c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11505 AND linked.composer_id = 44), 'musicbrainz:2f8020c3-e225-4e83-8333-11daacdc89c2', 25, NULL, 'Sortie d’Haroun et de ses Amis', 'Djamileh, WD 27: Sortie d’Haroun et de ses Amis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f8020c3-e225-4e83-8333-11daacdc89c2'
);

UPDATE pieces piece
SET piece.title = '오페라 <Djamileh, WD 27> 중 "Sortie d’Haroun et de ses Amis"', piece.title_en = 'Djamileh, WD 27: Djamileh, WD 27: Sortie d’Haroun et de ses Amis', piece.editor_locked = 1
WHERE piece.id = 11505 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « C’est parfait ! » (Le Marchand, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « C’est parfait ! » (Le Marchand, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d0313a98-174f-41b3-99d5-64a06b4f8896' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0313a98-174f-41b3-99d5-64a06b4f8896', 26, NULL, 'Dialogue. « C’est parfait ! » (Le Marchand, Splendiano)', 'Djamileh, WD 27: Dialogue. « C’est parfait ! » (Le Marchand, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0313a98-174f-41b3-99d5-64a06b4f8896'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Couplets. « Il faut pour éteindre ma fièvre » (Splendiano)', part.name_en = 'Djamileh, WD 27: Couplets. « Il faut pour éteindre ma fièvre » (Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8c8bec2a-4472-4136-adbe-0568e73ec0e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c8bec2a-4472-4136-adbe-0568e73ec0e5', 27, NULL, 'Couplets. « Il faut pour éteindre ma fièvre » (Splendiano)', 'Djamileh, WD 27: Couplets. « Il faut pour éteindre ma fièvre » (Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8bec2a-4472-4136-adbe-0568e73ec0e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Dialogue. « Ils sont gais » (Haroun, Djamileh, Splendiano)', part.name_en = 'Djamileh, WD 27: Dialogue. « Ils sont gais » (Haroun, Djamileh, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4c7a464e-c0a0-4807-b91b-a93cbbc80554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c7a464e-c0a0-4807-b91b-a93cbbc80554', 28, NULL, 'Dialogue. « Ils sont gais » (Haroun, Djamileh, Splendiano)', 'Djamileh, WD 27: Dialogue. « Ils sont gais » (Haroun, Djamileh, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c7a464e-c0a0-4807-b91b-a93cbbc80554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Mélodrame. « Si vous saviez… » (Haroun, Splendiano)', part.name_en = 'Djamileh, WD 27: Mélodrame. « Si vous saviez… » (Haroun, Splendiano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:573ce4d7-996a-40e0-abb3-381476c5ff7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:573ce4d7-996a-40e0-abb3-381476c5ff7a', 29, NULL, 'Mélodrame. « Si vous saviez… » (Haroun, Splendiano)', 'Djamileh, WD 27: Mélodrame. « Si vous saviez… » (Haroun, Splendiano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:573ce4d7-996a-40e0-abb3-381476c5ff7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Duo. « Est‐ce la crainte, est‐ce un caprice » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Duo. « Est‐ce la crainte, est‐ce un caprice » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:48541feb-377d-46d2-97f4-131921940b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48541feb-377d-46d2-97f4-131921940b35', 30, NULL, 'Duo. « Est‐ce la crainte, est‐ce un caprice » (Haroun, Djamileh)', 'Djamileh, WD 27: Duo. « Est‐ce la crainte, est‐ce un caprice » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48541feb-377d-46d2-97f4-131921940b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Duo (suite). « La frayeur me glace ! » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Duo (suite). « La frayeur me glace ! » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5e937bba-62e7-43bb-9fa2-180bd71f9d9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e937bba-62e7-43bb-9fa2-180bd71f9d9e', 31, NULL, 'Duo (suite). « La frayeur me glace ! » (Haroun, Djamileh)', 'Djamileh, WD 27: Duo (suite). « La frayeur me glace ! » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e937bba-62e7-43bb-9fa2-180bd71f9d9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Duo (suite). « Cherchant, des monts à la plaine » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Duo (suite). « Cherchant, des monts à la plaine » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a503823a-6ab9-4ea3-8c16-3e5c636fe7f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a503823a-6ab9-4ea3-8c16-3e5c636fe7f7', 32, NULL, 'Duo (suite). « Cherchant, des monts à la plaine » (Haroun, Djamileh)', 'Djamileh, WD 27: Duo (suite). « Cherchant, des monts à la plaine » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a503823a-6ab9-4ea3-8c16-3e5c636fe7f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Duo (fin). « Ta lèvre parfumée » (Haroun, Djamileh)', part.name_en = 'Djamileh, WD 27: Duo (fin). « Ta lèvre parfumée » (Haroun, Djamileh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:bc6bb680-a9f5-4a29-bca5-120b5fcf709c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6bb680-a9f5-4a29-bca5-120b5fcf709c', 33, NULL, 'Duo (fin). « Ta lèvre parfumée » (Haroun, Djamileh)', 'Djamileh, WD 27: Duo (fin). « Ta lèvre parfumée » (Haroun, Djamileh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6bb680-a9f5-4a29-bca5-120b5fcf709c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Scène. Danse de l’almée (chorale)', part.name_en = 'Djamileh: 7. Scène. Danse de l’almée (chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11483 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5cc7c7e4-0eef-460d-b5fb-a16035c2c7c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc7c7e4-0eef-460d-b5fb-a16035c2c7c8', 34, NULL, 'Scène. Danse de l’almée (chorale)', 'Djamileh: 7. Scène. Danse de l’almée (chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11483 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc7c7e4-0eef-460d-b5fb-a16035c2c7c8'
);


-- None 오페라 <Don Procopio>

UPDATE pieces piece
SET piece.title = '오페라 <Don Procopio>', piece.title_en = 'Don Procopio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11625 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Don Procopio: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:65f2ea24-df5a-4fd0-bf19-2f5b02289c59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f2ea24-df5a-4fd0-bf19-2f5b02289c59', 1, NULL, 'Ouverture', 'Don Procopio: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f2ea24-df5a-4fd0-bf19-2f5b02289c59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Don Procopio: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d', 2, NULL, 'Acte I', 'Don Procopio: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duo Eufemia - Don Andronico “Voi no siete che suo zio”', part.name_en = 'Don Procopio: Duo Eufemia - Don Andronico “Voi no siete che suo zio”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:346a55c8-7f0a-4f31-915f-dc8d1473a165' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:346a55c8-7f0a-4f31-915f-dc8d1473a165', 1, NULL, 'Duo Eufemia - Don Andronico “Voi no siete che suo zio”', 'Don Procopio: Duo Eufemia - Don Andronico “Voi no siete che suo zio”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346a55c8-7f0a-4f31-915f-dc8d1473a165'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aria de Ernesto: “Non v''é, signor, di lei”', part.name_en = 'Don Procopio: Aria de Ernesto: “Non v''é, signor, di lei”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:36a6d20e-426c-46ff-b737-34af9e26e99c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36a6d20e-426c-46ff-b737-34af9e26e99c', 2, NULL, 'Aria de Ernesto: “Non v''é, signor, di lei”', 'Don Procopio: Aria de Ernesto: “Non v''é, signor, di lei”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36a6d20e-426c-46ff-b737-34af9e26e99c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Marcia guerriera', part.name_en = 'Don Procopio: Marcia guerriera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4b769abe-640b-4983-afee-f112f438a956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b769abe-640b-4983-afee-f112f438a956', 3, NULL, 'Marcia guerriera', 'Don Procopio: Marcia guerriera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b769abe-640b-4983-afee-f112f438a956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Aria de Bettina: “Voler che sposi un vecchio”', part.name_en = 'Don Procopio: Aria de Bettina: “Voler che sposi un vecchio”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:761cd7c1-5aa2-4716-832d-617979b47806' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:761cd7c1-5aa2-4716-832d-617979b47806', 4, NULL, 'Aria de Bettina: “Voler che sposi un vecchio”', 'Don Procopio: Aria de Bettina: “Voler che sposi un vecchio”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761cd7c1-5aa2-4716-832d-617979b47806'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Coro “Gran piacer son gli sponsali”', part.name_en = 'Don Procopio: Coro “Gran piacer son gli sponsali”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8cfe5d8f-20d4-47a4-8c93-dc6f1e232563' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cfe5d8f-20d4-47a4-8c93-dc6f1e232563', 5, NULL, 'Coro “Gran piacer son gli sponsali”', 'Don Procopio: Coro “Gran piacer son gli sponsali”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfe5d8f-20d4-47a4-8c93-dc6f1e232563'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Trio Bettina - Ernesto - Odoardo “Che caro progetto”', part.name_en = 'Don Procopio: Trio Bettina - Ernesto - Odoardo “Che caro progetto”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:cd4f0a63-1002-46f9-be28-2b9a5f1323b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd4f0a63-1002-46f9-be28-2b9a5f1323b8', 6, NULL, 'Trio Bettina - Ernesto - Odoardo “Che caro progetto”', 'Don Procopio: Trio Bettina - Ernesto - Odoardo “Che caro progetto”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd4f0a63-1002-46f9-be28-2b9a5f1323b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Finale de l''acte I. “Il paese é tutto pieno”', part.name_en = 'Don Procopio: Finale de l''acte I. “Il paese é tutto pieno”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ed9e7237-4f6c-4cce-848f-bb87a4b8fcfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed9e7237-4f6c-4cce-848f-bb87a4b8fcfc', 7, NULL, 'Finale de l''acte I. “Il paese é tutto pieno”', 'Don Procopio: Finale de l''acte I. “Il paese é tutto pieno”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1c87a697-4ef9-4149-9f45-d0758d50e36d'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed9e7237-4f6c-4cce-848f-bb87a4b8fcfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Don Procopio: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e', 3, NULL, 'Acte II', 'Don Procopio: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duo Bettina - Odoardo “Per me beato appieno”', part.name_en = 'Don Procopio: Duo Bettina - Odoardo “Per me beato appieno”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:24592016-5991-4d95-b287-383b52af6fab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24592016-5991-4d95-b287-383b52af6fab', 1, NULL, 'Duo Bettina - Odoardo “Per me beato appieno”', 'Don Procopio: Duo Bettina - Odoardo “Per me beato appieno”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24592016-5991-4d95-b287-383b52af6fab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Duo Bettina - Don Procopio “lo di tutto mi contento”', part.name_en = 'Don Procopio: Duo Bettina - Don Procopio “lo di tutto mi contento”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:3aae383f-9512-4681-88d2-21ab3a10fa2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3aae383f-9512-4681-88d2-21ab3a10fa2e', 2, NULL, 'Duo Bettina - Don Procopio “lo di tutto mi contento”', 'Don Procopio: Duo Bettina - Don Procopio “lo di tutto mi contento”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aae383f-9512-4681-88d2-21ab3a10fa2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Coro finale “Viva il conte!”', part.name_en = 'Don Procopio: Coro finale “Viva il conte!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c14812af-68b4-4754-96fb-8c471794181d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c14812af-68b4-4754-96fb-8c471794181d', 3, NULL, 'Coro finale “Viva il conte!”', 'Don Procopio: Coro finale “Viva il conte!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c14812af-68b4-4754-96fb-8c471794181d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sérénade de Oduardo “Sulle piume dell'' amore”', part.name_en = 'Don Procopio: Sérénade de Oduardo “Sulle piume dell'' amore”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ee10574b-2c2c-4392-a582-57c3aa3cdea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee10574b-2c2c-4392-a582-57c3aa3cdea9', 4, NULL, 'Sérénade de Oduardo “Sulle piume dell'' amore”', 'Don Procopio: Sérénade de Oduardo “Sulle piume dell'' amore”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee10574b-2c2c-4392-a582-57c3aa3cdea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Trio Ernesto - Don Procopio - Don Andronico “Se Lei di parola”', part.name_en = 'Don Procopio: Trio Ernesto - Don Procopio - Don Andronico “Se Lei di parola”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11625 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fdb60a5b-4618-4de1-ae68-1814e63e36b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdb60a5b-4618-4de1-ae68-1814e63e36b1', 5, NULL, 'Trio Ernesto - Don Procopio - Don Andronico “Se Lei di parola”', 'Don Procopio: Trio Ernesto - Don Procopio - Don Andronico “Se Lei di parola”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d537df4d-7323-4379-a627-67b66ae4211e'
WHERE p.id = 11625 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdb60a5b-4618-4de1-ae68-1814e63e36b1'
);


-- None 연가곡집 <Feuilles d'album>

UPDATE pieces piece
SET piece.title = '연가곡집 <Feuilles d''album>', piece.title_en = 'Feuilles d''album',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11779 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A une fleur', part.name_en = 'Feuilles d''album: A une fleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7d9e0cf9-7b15-4208-8fc7-21f7a4189a13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d9e0cf9-7b15-4208-8fc7-21f7a4189a13', 1, NULL, 'A une fleur', 'Feuilles d''album: A une fleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d9e0cf9-7b15-4208-8fc7-21f7a4189a13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adieux à Suzon', part.name_en = 'Feuilles d''album: Adieux à Suzon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5dd32ee3-28ca-4d20-b2d4-51459700623a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd32ee3-28ca-4d20-b2d4-51459700623a', 2, NULL, 'Adieux à Suzon', 'Feuilles d''album: Adieux à Suzon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd32ee3-28ca-4d20-b2d4-51459700623a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonnet, WD 78', part.name_en = 'Feuilles d''album: Sonnet, WD 78',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7d819f69-59d0-4ccd-ba20-6326f980d762' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d819f69-59d0-4ccd-ba20-6326f980d762', 3, NULL, 'Sonnet, WD 78', 'Feuilles d''album: Sonnet, WD 78', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d819f69-59d0-4ccd-ba20-6326f980d762'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Guitare, WD 79', part.name_en = 'Feuilles d''album: Guitare, WD 79',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7c1c2fcb-7e2d-43b5-9034-d625de1ef082' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1c2fcb-7e2d-43b5-9034-d625de1ef082', 4, NULL, 'Guitare, WD 79', 'Feuilles d''album: Guitare, WD 79', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1c2fcb-7e2d-43b5-9034-d625de1ef082'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rose d''amour, WD 80', part.name_en = 'Feuilles d''album: Rose d''amour, WD 80',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:aba2ec9f-97bf-445b-9bb4-ee0afe738786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba2ec9f-97bf-445b-9bb4-ee0afe738786', 5, NULL, 'Rose d''amour, WD 80', 'Feuilles d''album: Rose d''amour, WD 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba2ec9f-97bf-445b-9bb4-ee0afe738786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Grillon, WD 81', part.name_en = 'Feuilles d''album: Le Grillon, WD 81',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11779 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:55bf439a-2ee6-46a5-af8d-bad0aa649d76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55bf439a-2ee6-46a5-af8d-bad0aa649d76', 6, NULL, 'Le Grillon, WD 81', 'Feuilles d''album: Le Grillon, WD 81', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11779 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55bf439a-2ee6-46a5-af8d-bad0aa649d76'
);


-- None Grande Valse de concert in E-flat major

UPDATE pieces piece
SET piece.title = 'Grande Valse de concert in E-flat major', piece.title_en = 'Grande Valse de concert in E-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11792 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Habanera (L'Amour est un oiseau rebelle)

UPDATE pieces piece
SET piece.title = 'Habanera (L''Amour est un oiseau rebelle)', piece.title_en = 'Habanera (L''Amour est un oiseau rebelle)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11846 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Improvisations sur ouverture>

UPDATE pieces piece
SET piece.title = '가곡 <Improvisations sur ouverture>', piece.title_en = 'Improvisations sur ouverture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11645 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Ivan IV>

UPDATE pieces piece
SET piece.title = '오페라 <Ivan IV>', piece.title_en = 'Ivan IV',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11394 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Ivan IV: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61', 1, NULL, 'Acte I', 'Ivan IV: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 4 Final "Victoire ! Victoire ! Chantez !" (Temrouk, Igor, Chœur)', part.name_en = 'Ivan IV: Acte I. No. 4 Final "Victoire ! Victoire ! Chantez !" (Temrouk, Igor, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:33de80d6-09f8-3256-b51c-583cc5d12592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33de80d6-09f8-3256-b51c-583cc5d12592', 1, NULL, 'Acte I. No. 4 Final "Victoire ! Victoire ! Chantez !" (Temrouk, Igor, Chœur)', 'Ivan IV: Acte I. No. 4 Final "Victoire ! Victoire ! Chantez !" (Temrouk, Igor, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33de80d6-09f8-3256-b51c-583cc5d12592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. No. 2 Duo "Puisses-tu voir longtemps encore" (Marie, Le Jeune Bulgare)', part.name_en = 'Ivan IV: Acte I. No. 2 Duo "Puisses-tu voir longtemps encore" (Marie, Le Jeune Bulgare)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fa725464-c432-30a8-b031-72f5c73e28c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa725464-c432-30a8-b031-72f5c73e28c8', 2, NULL, 'Acte I. No. 2 Duo "Puisses-tu voir longtemps encore" (Marie, Le Jeune Bulgare)', 'Ivan IV: Acte I. No. 2 Duo "Puisses-tu voir longtemps encore" (Marie, Le Jeune Bulgare)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cae7fc4e-da24-4a68-9e63-317b3018cb61'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa725464-c432-30a8-b031-72f5c73e28c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Ivan IV: Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1', 2, NULL, 'Acte II', 'Ivan IV: Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 7 Récit et chant du Cosak "Et c''est un chant de femmes ... Hourrah ! Hourrah ! Vive la guerre" (Ivan, Yorloff, Chœur)', part.name_en = 'Ivan IV: Acte II. No. 7 Récit et chant du Cosak "Et c''est un chant de femmes ... Hourrah ! Hourrah ! Vive la guerre" (Ivan, Yorloff, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6406db93-cf47-3f3b-9971-0e3db408169c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6406db93-cf47-3f3b-9971-0e3db408169c', 1, NULL, 'Acte II. No. 7 Récit et chant du Cosak "Et c''est un chant de femmes ... Hourrah ! Hourrah ! Vive la guerre" (Ivan, Yorloff, Chœur)', 'Ivan IV: Acte II. No. 7 Récit et chant du Cosak "Et c''est un chant de femmes ... Hourrah ! Hourrah ! Vive la guerre" (Ivan, Yorloff, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6406db93-cf47-3f3b-9971-0e3db408169c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. No. 6 Sérénade "Ouvre ton cœur à l''amour qui m''enflamme" (Le Jeune Bulgare)', part.name_en = 'Ivan IV: Acte II. No. 6 Sérénade "Ouvre ton cœur à l''amour qui m''enflamme" (Le Jeune Bulgare)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:73aa8901-c111-3dd9-8618-6985ccd01b8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73aa8901-c111-3dd9-8618-6985ccd01b8c', 2, NULL, 'Acte II. No. 6 Sérénade "Ouvre ton cœur à l''amour qui m''enflamme" (Le Jeune Bulgare)', 'Ivan IV: Acte II. No. 6 Sérénade "Ouvre ton cœur à l''amour qui m''enflamme" (Le Jeune Bulgare)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27aeea1-6c04-4dad-bf2a-b1be0f3205a1'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73aa8901-c111-3dd9-8618-6985ccd01b8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Ivan IV: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9402a149-6dee-4dff-8571-16dd84eb3c4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9402a149-6dee-4dff-8571-16dd84eb3c4e', 3, NULL, 'Acte III', 'Ivan IV: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9402a149-6dee-4dff-8571-16dd84eb3c4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9402a149-6dee-4dff-8571-16dd84eb3c4e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. No. 9 Chœur dansé "Sous nos pas le sol résonne" (Chœur)', part.name_en = 'Ivan IV: Acte III. No. 9 Chœur dansé "Sous nos pas le sol résonne" (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b8427670-9182-3e18-bd4b-aaf46064002b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8427670-9182-3e18-bd4b-aaf46064002b', 1, NULL, 'Acte III. No. 9 Chœur dansé "Sous nos pas le sol résonne" (Chœur)', 'Ivan IV: Acte III. No. 9 Chœur dansé "Sous nos pas le sol résonne" (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9402a149-6dee-4dff-8571-16dd84eb3c4e'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8427670-9182-3e18-bd4b-aaf46064002b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV', part.name_en = 'Ivan IV: Acte IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd', 4, NULL, 'Acte IV', 'Ivan IV: Acte IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 16 Récit et air "La vengeance va donc être enfin satisfaite ... Pourquoi me verrez-vous" (Igor)', part.name_en = 'Ivan IV: Acte IV. No. 16 Récit et air "La vengeance va donc être enfin satisfaite ... Pourquoi me verrez-vous" (Igor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2036fe4e-414c-319b-951c-ca58a6a8f4ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2036fe4e-414c-319b-951c-ca58a6a8f4ee', 1, NULL, 'Acte IV. No. 16 Récit et air "La vengeance va donc être enfin satisfaite ... Pourquoi me verrez-vous" (Igor)', 'Ivan IV: Acte IV. No. 16 Récit et air "La vengeance va donc être enfin satisfaite ... Pourquoi me verrez-vous" (Igor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2036fe4e-414c-319b-951c-ca58a6a8f4ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 17 Duo "Marie ! Igor !" (Igor, Marie)', part.name_en = 'Ivan IV: Acte IV. No. 17 Duo "Marie ! Igor !" (Igor, Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4451988b-6d10-3dd1-b4c6-266829a00162' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4451988b-6d10-3dd1-b4c6-266829a00162', 2, NULL, 'Acte IV. No. 17 Duo "Marie ! Igor !" (Igor, Marie)', 'Ivan IV: Acte IV. No. 17 Duo "Marie ! Igor !" (Igor, Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4451988b-6d10-3dd1-b4c6-266829a00162'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 18 Final "Voyez ! Ah ! Mon épouse" (Ensemble)', part.name_en = 'Ivan IV: Acte IV. No. 18 Final "Voyez ! Ah ! Mon épouse" (Ensemble)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:70260bdc-6bb0-3539-ad03-e43562481f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70260bdc-6bb0-3539-ad03-e43562481f53', 3, NULL, 'Acte IV. No. 18 Final "Voyez ! Ah ! Mon épouse" (Ensemble)', 'Ivan IV: Acte IV. No. 18 Final "Voyez ! Ah ! Mon épouse" (Ensemble)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70260bdc-6bb0-3539-ad03-e43562481f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte IV. No. 14 Air "Il me semble parfois que ma vie est un songe" (Marie)', part.name_en = 'Ivan IV: Acte IV. No. 14 Air "Il me semble parfois que ma vie est un songe" (Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:80f67305-492b-3126-bea7-d4c08fa307b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80f67305-492b-3126-bea7-d4c08fa307b0', 4, NULL, 'Acte IV. No. 14 Air "Il me semble parfois que ma vie est un songe" (Marie)', 'Ivan IV: Acte IV. No. 14 Air "Il me semble parfois que ma vie est un songe" (Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a8e0bb1-1cb3-4686-ae3a-caf910da98dd'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f67305-492b-3126-bea7-d4c08fa307b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte V', part.name_en = 'Ivan IV: Acte V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ca02cebd-8a6e-4b15-98ba-c51e45f8ba45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca02cebd-8a6e-4b15-98ba-c51e45f8ba45', 5, NULL, 'Acte V', 'Ivan IV: Acte V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca02cebd-8a6e-4b15-98ba-c51e45f8ba45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ca02cebd-8a6e-4b15-98ba-c51e45f8ba45'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau II. No. 21 Finale "A mort ! A mort !" (Ensemble)', part.name_en = 'Ivan IV: Acte V, Tableau II. No. 21 Finale "A mort ! A mort !" (Ensemble)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11394 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c4cf7a46-0b54-37bb-9666-92f18562657d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4cf7a46-0b54-37bb-9666-92f18562657d', 1, NULL, 'Tableau II. No. 21 Finale "A mort ! A mort !" (Ensemble)', 'Ivan IV: Acte V, Tableau II. No. 21 Finale "A mort ! A mort !" (Ensemble)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ca02cebd-8a6e-4b15-98ba-c51e45f8ba45'
WHERE p.id = 11394 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4cf7a46-0b54-37bb-9666-92f18562657d'
);


-- Op. 22 Jeux d'enfants

UPDATE pieces piece
SET piece.title = 'Jeux d''enfants', piece.title_en = 'Jeux d''enfants, op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11794 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L’Escarpolette', part.name_en = 'Jeux d’enfants, op. 22 : I. L’Escarpolette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9645dd9c-911c-4572-bd2d-860847f221cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9645dd9c-911c-4572-bd2d-860847f221cf', 1, 'I', 'L’Escarpolette', 'Jeux d’enfants, op. 22 : I. L’Escarpolette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9645dd9c-911c-4572-bd2d-860847f221cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Toupie', part.name_en = 'Jeux d’enfants, op. 22 : II. La Toupie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a5770a83-455e-47a4-8a75-e192af9b58fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5770a83-455e-47a4-8a75-e192af9b58fd', 2, 'II', 'La Toupie', 'Jeux d’enfants, op. 22 : II. La Toupie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5770a83-455e-47a4-8a75-e192af9b58fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Poupée', part.name_en = 'Jeux d’enfants, op. 22 : III. La Poupée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:24d0ba42-45d9-4447-a66c-65d45872723a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24d0ba42-45d9-4447-a66c-65d45872723a', 3, 'III', 'La Poupée', 'Jeux d’enfants, op. 22 : III. La Poupée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d0ba42-45d9-4447-a66c-65d45872723a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Les Chevaux de bois', part.name_en = 'Jeux d’enfants, op. 22 : IV. Les Chevaux de bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:acb0ec5d-7ba9-4e3d-95b1-fead5fb01399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb0ec5d-7ba9-4e3d-95b1-fead5fb01399', 4, 'IV', 'Les Chevaux de bois', 'Jeux d’enfants, op. 22 : IV. Les Chevaux de bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb0ec5d-7ba9-4e3d-95b1-fead5fb01399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le Volant', part.name_en = 'Jeux d’enfants, op. 22 : V. Le Volant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2c2a1c04-0de5-49c1-9ff1-344154a51756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c2a1c04-0de5-49c1-9ff1-344154a51756', 5, 'V', 'Le Volant', 'Jeux d’enfants, op. 22 : V. Le Volant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2a1c04-0de5-49c1-9ff1-344154a51756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Trompette et Tambour', part.name_en = 'Jeux d’enfants, op. 22 : VI. Trompette et Tambour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8cb491b8-e49e-449d-8041-77626abf1248' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb491b8-e49e-449d-8041-77626abf1248', 6, 'VI', 'Trompette et Tambour', 'Jeux d’enfants, op. 22 : VI. Trompette et Tambour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb491b8-e49e-449d-8041-77626abf1248'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Les Bulles de savon', part.name_en = 'Jeux d’enfants, op. 22 : VII. Les Bulles de savon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e900578d-89b8-421f-b130-bf998d545c0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e900578d-89b8-421f-b130-bf998d545c0a', 7, 'VII', 'Les Bulles de savon', 'Jeux d’enfants, op. 22 : VII. Les Bulles de savon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e900578d-89b8-421f-b130-bf998d545c0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Les Quatre Coins', part.name_en = 'Jeux d’enfants, op. 22 : VIII. Les Quatre Coins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4ac55d4f-7fb1-4134-a9d1-a541fc3c387c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac55d4f-7fb1-4134-a9d1-a541fc3c387c', 8, 'VIII', 'Les Quatre Coins', 'Jeux d’enfants, op. 22 : VIII. Les Quatre Coins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac55d4f-7fb1-4134-a9d1-a541fc3c387c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Colin‐maillard', part.name_en = 'Jeux d’enfants, op. 22 : IX. Colin‐maillard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c1a37765-4fb7-4681-9d3d-869e5037261d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1a37765-4fb7-4681-9d3d-869e5037261d', 9, 'IX', 'Colin‐maillard', 'Jeux d’enfants, op. 22 : IX. Colin‐maillard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a37765-4fb7-4681-9d3d-869e5037261d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Saute‐mouton', part.name_en = 'Jeux d’enfants, op. 22 : X. Saute‐mouton',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c6738df7-36a9-4c11-8064-3d9db4cd3ddc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6738df7-36a9-4c11-8064-3d9db4cd3ddc', 10, 'X', 'Saute‐mouton', 'Jeux d’enfants, op. 22 : X. Saute‐mouton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6738df7-36a9-4c11-8064-3d9db4cd3ddc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Petit Mari, petite Femme', part.name_en = 'Jeux d’enfants, op. 22 : XI. Petit Mari, petite Femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d3def8a1-63dd-4813-80c8-3f5a9f2c97a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3def8a1-63dd-4813-80c8-3f5a9f2c97a0', 11, 'XI', 'Petit Mari, petite Femme', 'Jeux d’enfants, op. 22 : XI. Petit Mari, petite Femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3def8a1-63dd-4813-80c8-3f5a9f2c97a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Le Bal (Galop)', part.name_en = 'Jeux d’enfants, op. 22 : XII. Le Bal (Galop)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11794 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f2437184-a8e9-4887-9fd7-6c32919e696d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2437184-a8e9-4887-9fd7-6c32919e696d', 12, 'XII', 'Le Bal (Galop)', 'Jeux d’enfants, op. 22 : XII. Le Bal (Galop)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11794 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2437184-a8e9-4887-9fd7-6c32919e696d'
);


-- None 가곡 <L'Abandonnée>

UPDATE pieces piece
SET piece.title = '가곡 <L''Abandonnée>', piece.title_en = 'L''Abandonnée',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11786 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Chanson de la rose, WD 103>

UPDATE pieces piece
SET piece.title = '가곡 <La Chanson de la rose, WD 103>', piece.title_en = 'La Chanson de la rose, WD 103',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11974 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Chanson du rouet, WD 120

UPDATE pieces piece
SET piece.title = 'La Chanson du rouet, WD 120', piece.title_en = 'La Chanson du rouet, WD 120',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11769 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Foi, l’Espérance et la Charité>

UPDATE pieces piece
SET piece.title = '가곡 <La Foi, l’Espérance et la Charité>', piece.title_en = 'La Foi, l’Espérance et la Charité',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11758 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Fuite, WD 135>

UPDATE pieces piece
SET piece.title = '가곡 <La Fuite, WD 135>', piece.title_en = 'La Fuite, WD 135',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11728 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La Jolie Fille de Perth>

UPDATE pieces piece
SET piece.title = '오페라 <La Jolie Fille de Perth>', piece.title_en = 'La Jolie Fille de Perth',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11636 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Tu seras mon bon ange » (Le Duc, Mab, Chœur)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Tu seras mon bon ange » (Le Duc, Mab, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:01c6946c-5c19-4f1b-b59a-49f2b3bd56d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01c6946c-5c19-4f1b-b59a-49f2b3bd56d9', 1, NULL, 'Acte II. « Tu seras mon bon ange » (Le Duc, Mab, Chœur)', 'La Jolie Fille de Perth : Acte II. « Tu seras mon bon ange » (Le Duc, Mab, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01c6946c-5c19-4f1b-b59a-49f2b3bd56d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Tout bois, amis, dans ce monde… » (Le Duc, Chœur)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Tout bois, amis, dans ce monde… » (Le Duc, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:33b97dc7-500d-49e6-a9d2-9a3a2a105837' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33b97dc7-500d-49e6-a9d2-9a3a2a105837', 2, NULL, 'Acte II. « Tout bois, amis, dans ce monde… » (Le Duc, Chœur)', 'La Jolie Fille de Perth : Acte II. « Tout bois, amis, dans ce monde… » (Le Duc, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b97dc7-500d-49e6-a9d2-9a3a2a105837'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Écho, viens sur l’air embaumé » (Catherine, Chœur)', part.name_en = 'La Jolie Fille de Perth : Acte III. « Écho, viens sur l’air embaumé » (Catherine, Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:79ffeb78-dfe5-419d-9504-dca22c2b3a92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79ffeb78-dfe5-419d-9504-dca22c2b3a92', 3, NULL, 'Acte III. « Écho, viens sur l’air embaumé » (Catherine, Chœur)', 'La Jolie Fille de Perth : Acte III. « Écho, viens sur l’air embaumé » (Catherine, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79ffeb78-dfe5-419d-9504-dca22c2b3a92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Bons citoyens, dormez ! » (La Patrouille, Simon)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Bons citoyens, dormez ! » (La Patrouille, Simon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8536b3d7-c829-4f50-8cba-4c9cc89de359' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8536b3d7-c829-4f50-8cba-4c9cc89de359', 4, NULL, 'Acte II. « Bons citoyens, dormez ! » (La Patrouille, Simon)', 'La Jolie Fille de Perth : Acte II. « Bons citoyens, dormez ! » (La Patrouille, Simon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8536b3d7-c829-4f50-8cba-4c9cc89de359'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Intermezzo', part.name_en = 'La Jolie Fille de Perth : Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:85c221db-2587-459a-a536-faae42070d25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c221db-2587-459a-a536-faae42070d25', 5, NULL, 'Intermezzo', 'La Jolie Fille de Perth : Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c221db-2587-459a-a536-faae42070d25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. Danse bohémienne', part.name_en = 'La Jolie Fille de Perth : Acte II. Danse bohémienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8e4c8702-1806-420d-b9ed-94c32cd5fc99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e4c8702-1806-420d-b9ed-94c32cd5fc99', 6, NULL, 'Acte II. Danse bohémienne', 'La Jolie Fille de Perth : Acte II. Danse bohémienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e4c8702-1806-420d-b9ed-94c32cd5fc99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Quand la flamme de l''amour » (Air de Ralph)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Quand la flamme de l''amour » (Air de Ralph)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9076562c-11a5-496f-b521-593910106172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9076562c-11a5-496f-b521-593910106172', 7, NULL, 'Acte II. « Quand la flamme de l''amour » (Air de Ralph)', 'La Jolie Fille de Perth : Acte II. « Quand la flamme de l''amour » (Air de Ralph)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9076562c-11a5-496f-b521-593910106172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Je donne en mon palais » (Le Duc, Mab)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Je donne en mon palais » (Le Duc, Mab)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a4aac3c2-6217-4423-96db-bfe55578315d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4aac3c2-6217-4423-96db-bfe55578315d', 8, NULL, 'Acte II. « Je donne en mon palais » (Le Duc, Mab)', 'La Jolie Fille de Perth : Acte II. « Je donne en mon palais » (Le Duc, Mab)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4aac3c2-6217-4423-96db-bfe55578315d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Les seigneurs de la cour » (Le Duc)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Les seigneurs de la cour » (Le Duc)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c71989c6-e8b2-4b33-867c-673889412a09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c71989c6-e8b2-4b33-867c-673889412a09', 9, NULL, 'Acte II. « Les seigneurs de la cour » (Le Duc)', 'La Jolie Fille de Perth : Acte II. « Les seigneurs de la cour » (Le Duc)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c71989c6-e8b2-4b33-867c-673889412a09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Partout des cris de joie » (Henry)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Partout des cris de joie » (Henry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d80aba87-47ed-430e-a443-6775489cec5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d80aba87-47ed-430e-a443-6775489cec5d', 10, NULL, 'Acte II. « Partout des cris de joie » (Henry)', 'La Jolie Fille de Perth : Acte II. « Partout des cris de joie » (Henry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d80aba87-47ed-430e-a443-6775489cec5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Sérénade “Elle est la ... à la voix d''un amant fidele”', part.name_en = 'La Jolie Fille de Perth : Sérénade “Elle est la ... à la voix d''un amant fidele”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e2a70180-0146-4209-8b58-70e84958a152' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2a70180-0146-4209-8b58-70e84958a152', 11, NULL, 'Sérénade “Elle est la ... à la voix d''un amant fidele”', 'La Jolie Fille de Perth : Sérénade “Elle est la ... à la voix d''un amant fidele”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2a70180-0146-4209-8b58-70e84958a152'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte II. « Carnaval ! Carnaval ! » (Chœur, Le Duc)', part.name_en = 'La Jolie Fille de Perth : Acte II. « Carnaval ! Carnaval ! » (Chœur, Le Duc)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e709a7b1-3c70-4552-82e3-f311ad204a5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e709a7b1-3c70-4552-82e3-f311ad204a5e', 12, NULL, 'Acte II. « Carnaval ! Carnaval ! » (Chœur, Le Duc)', 'La Jolie Fille de Perth : Acte II. « Carnaval ! Carnaval ! » (Chœur, Le Duc)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e709a7b1-3c70-4552-82e3-f311ad204a5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Acte III. « Nous voilà seuls » (Le Duc, La Femme, Mab)', part.name_en = 'La Jolie Fille de Perth : Acte III. « Nous voilà seuls » (Le Duc, La Femme, Mab)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11636 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ec84c30f-ab9c-4aac-9fb9-4f1a401690bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec84c30f-ab9c-4aac-9fb9-4f1a401690bb', 13, NULL, 'Acte III. « Nous voilà seuls » (Le Duc, La Femme, Mab)', 'La Jolie Fille de Perth : Acte III. « Nous voilà seuls » (Le Duc, La Femme, Mab)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11636 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec84c30f-ab9c-4aac-9fb9-4f1a401690bb'
);


-- None La Mort s’avance, WD 133

UPDATE pieces piece
SET piece.title = 'La Mort s’avance, WD 133', piece.title_en = 'La Mort s’avance, WD 133',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11431 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Rose et l’Abeille>

UPDATE pieces piece
SET piece.title = '가곡 <La Rose et l’Abeille>', piece.title_en = 'La Rose et l’Abeille',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11598 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Rose et l’Abeille, WD 70>

UPDATE pieces piece
SET piece.title = '가곡 <La Rose et l’Abeille, WD 70>', piece.title_en = 'La Rose et l’Abeille, WD 70',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11795 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La Sirène, WD 88>

UPDATE pieces piece
SET piece.title = '가곡 <La Sirène, WD 88>', piece.title_en = 'La Sirène, WD 88',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11849 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lamento>

UPDATE pieces piece
SET piece.title = '가곡 <Lamento>', piece.title_en = 'Lamento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11736 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Colibri>

UPDATE pieces piece
SET piece.title = '가곡 <Le Colibri>', piece.title_en = 'Le Colibri',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11965 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Le Docteur Miracle>

UPDATE pieces piece
SET piece.title = '오페레타 <Le Docteur Miracle>', piece.title_en = 'Le Docteur Miracle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11835 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Maintenant que ton pere n''est plus la (Veronique, Laurette)', part.name_en = 'Le docteur Miracle, Scene 2: Maintenant que ton pere n''est plus la (Veronique, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:272ca64e-3ac5-4b17-8371-79694de8f49a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272ca64e-3ac5-4b17-8371-79694de8f49a', 1, NULL, 'Maintenant que ton pere n''est plus la (Veronique, Laurette)', 'Le docteur Miracle, Scene 2: Maintenant que ton pere n''est plus la (Veronique, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272ca64e-3ac5-4b17-8371-79694de8f49a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quatuor de l''omelette. Voici l''omelette! (Pasquin, Veronique, Le Podestat, Laurette)', part.name_en = 'Le docteur Miracle, Scene 7: Quatuor de l''omelette. Voici l''omelette! (Pasquin, Veronique, Le Podestat, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2b75055d-c763-43cc-83d4-c3c9639f6ab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b75055d-c763-43cc-83d4-c3c9639f6ab5', 2, NULL, 'Quatuor de l''omelette. Voici l''omelette! (Pasquin, Veronique, Le Podestat, Laurette)', 'Le docteur Miracle, Scene 7: Quatuor de l''omelette. Voici l''omelette! (Pasquin, Veronique, Le Podestat, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b75055d-c763-43cc-83d4-c3c9639f6ab5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Terzetto. Dieu! Son père! (Silvio, Laurette, Le Podestat)', part.name_en = 'Le docteur Miracle, Scene 9: Terzetto. Dieu! Son père! (Silvio, Laurette, Le Podestat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:3ae7c3e4-f650-4702-adad-99c77a466150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ae7c3e4-f650-4702-adad-99c77a466150', 3, NULL, 'Terzetto. Dieu! Son père! (Silvio, Laurette, Le Podestat)', 'Le docteur Miracle, Scene 9: Terzetto. Dieu! Son père! (Silvio, Laurette, Le Podestat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ae7c3e4-f650-4702-adad-99c77a466150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Encore un coup, malheureux (Le Podestat, Pasquin, Veronique, Laurette)', part.name_en = 'Le docteur Miracle, Scene 7: Encore un coup, malheureux (Le Podestat, Pasquin, Veronique, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:60745238-2625-4797-a391-2f8a48b35c24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60745238-2625-4797-a391-2f8a48b35c24', 4, NULL, 'Encore un coup, malheureux (Le Podestat, Pasquin, Veronique, Laurette)', 'Le docteur Miracle, Scene 7: Encore un coup, malheureux (Le Podestat, Pasquin, Veronique, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60745238-2625-4797-a391-2f8a48b35c24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Et puis, d''ailleurs (Laurette, Veronique)', part.name_en = 'Le docteur Miracle, Scene 2: Et puis, d''ailleurs (Laurette, Veronique)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6ba56a1d-cb21-4c5d-b709-b9cd7fe5c006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ba56a1d-cb21-4c5d-b709-b9cd7fe5c006', 5, NULL, 'Et puis, d''ailleurs (Laurette, Veronique)', 'Le docteur Miracle, Scene 2: Et puis, d''ailleurs (Laurette, Veronique)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ba56a1d-cb21-4c5d-b709-b9cd7fe5c006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Il va partir! (Le Podestat, Laurette, Veronique)', part.name_en = 'Le docteur Miracle, Scene 3: Il va partir! (Le Podestat, Laurette, Veronique)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7038f8c9-6a82-4801-8d0a-4b756d7808b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7038f8c9-6a82-4801-8d0a-4b756d7808b3', 6, NULL, 'Il va partir! (Le Podestat, Laurette, Veronique)', 'Le docteur Miracle, Scene 3: Il va partir! (Le Podestat, Laurette, Veronique)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7038f8c9-6a82-4801-8d0a-4b756d7808b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Et bien oui, la, je me trompais (Le Podestat, Laurette)', part.name_en = 'Le docteur Miracle, Scene 1: Et bien oui, la, je me trompais (Le Podestat, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:77817ed6-31e7-4e91-b6d6-2a5e8f8777e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77817ed6-31e7-4e91-b6d6-2a5e8f8777e5', 7, NULL, 'Et bien oui, la, je me trompais (Le Podestat, Laurette)', 'Le docteur Miracle, Scene 1: Et bien oui, la, je me trompais (Le Podestat, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77817ed6-31e7-4e91-b6d6-2a5e8f8777e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Duo. En votre aimable compagnie (Laurette, Pasquin)', part.name_en = 'Le docteur Miracle, Scene 8: Duo. En votre aimable compagnie (Laurette, Pasquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:77ef9dee-56cd-4fc1-8933-17e1ff4a0616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77ef9dee-56cd-4fc1-8933-17e1ff4a0616', 8, NULL, 'Duo. En votre aimable compagnie (Laurette, Pasquin)', 'Le docteur Miracle, Scene 8: Duo. En votre aimable compagnie (Laurette, Pasquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77ef9dee-56cd-4fc1-8933-17e1ff4a0616'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Trio. La drôle de musique (Laurette, Le Podestat, Veronique)', part.name_en = 'Le docteur Miracle, Scene 1: Trio. La drôle de musique (Laurette, Le Podestat, Veronique)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7803b1ae-bdef-49f5-b21c-41d0ea3a333a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7803b1ae-bdef-49f5-b21c-41d0ea3a333a', 9, NULL, 'Trio. La drôle de musique (Laurette, Le Podestat, Veronique)', 'Le docteur Miracle, Scene 1: Trio. La drôle de musique (Laurette, Le Podestat, Veronique)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7803b1ae-bdef-49f5-b21c-41d0ea3a333a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Décidément, je me félicite (Le Podestat, Laurette)', part.name_en = 'Le docteur Miracle, Scene 6: Décidément, je me félicite (Le Podestat, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:9061cf1b-bb5c-4a10-877d-bfc159c50af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9061cf1b-bb5c-4a10-877d-bfc159c50af9', 10, NULL, 'Décidément, je me félicite (Le Podestat, Laurette)', 'Le docteur Miracle, Scene 6: Décidément, je me félicite (Le Podestat, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9061cf1b-bb5c-4a10-877d-bfc159c50af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Le Docteur Miracle: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a6327851-6b02-4a49-b47a-faf6f2e1160e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6327851-6b02-4a49-b47a-faf6f2e1160e', 11, NULL, 'Ouverture', 'Le Docteur Miracle: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6327851-6b02-4a49-b47a-faf6f2e1160e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Venez ici Veronique (Le Podestat, Veronique, Laurette, Pasquin)', part.name_en = 'Le docteur Miracle, Scene 5: Venez ici Veronique (Le Podestat, Veronique, Laurette, Pasquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b79da590-e8ea-49af-8b5a-0f669c972aad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79da590-e8ea-49af-8b5a-0f669c972aad', 12, NULL, 'Venez ici Veronique (Le Podestat, Veronique, Laurette, Pasquin)', 'Le docteur Miracle, Scene 5: Venez ici Veronique (Le Podestat, Veronique, Laurette, Pasquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79da590-e8ea-49af-8b5a-0f669c972aad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Me v''la, Excellence! (Pasquin, Le Podestat)', part.name_en = 'Le docteur Miracle, Scene 4: Me v''la, Excellence! (Pasquin, Le Podestat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:bcffe711-39fa-401e-824b-ab7893343a53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcffe711-39fa-401e-824b-ab7893343a53', 13, NULL, 'Me v''la, Excellence! (Pasquin, Le Podestat)', 'Le docteur Miracle, Scene 4: Me v''la, Excellence! (Pasquin, Le Podestat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcffe711-39fa-401e-824b-ab7893343a53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Quid?… Charlatan, le podestat que voici (Doucteur Miracle, Veronique, Le Podestat, Laurette)', part.name_en = 'Le docteur Miracle, Scene 12: Quid?… Charlatan, le podestat que voici (Doucteur Miracle, Veronique, Le Podestat, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c18a2e40-ddfa-4f8f-9378-399b4db66c20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c18a2e40-ddfa-4f8f-9378-399b4db66c20', 14, NULL, 'Quid?… Charlatan, le podestat que voici (Doucteur Miracle, Veronique, Le Podestat, Laurette)', 'Le docteur Miracle, Scene 12: Quid?… Charlatan, le podestat que voici (Doucteur Miracle, Veronique, Le Podestat, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18a2e40-ddfa-4f8f-9378-399b4db66c20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Romance. Me gronder pour cela (Laurette)', part.name_en = 'Le docteur Miracle, Scene 2: Romance. Me gronder pour cela (Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d9da11e1-4022-40ec-83aa-874373eb5a89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9da11e1-4022-40ec-83aa-874373eb5a89', 15, NULL, 'Romance. Me gronder pour cela (Laurette)', 'Le docteur Miracle, Scene 2: Romance. Me gronder pour cela (Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9da11e1-4022-40ec-83aa-874373eb5a89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Couplets. Je sais monter les escaliers (Pasquin)', part.name_en = 'Le docteur Miracle, Scene 4: Couplets. Je sais monter les escaliers (Pasquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e26553b4-0515-4aa8-a383-1b14aa6c32d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e26553b4-0515-4aa8-a383-1b14aa6c32d5', 16, NULL, 'Couplets. Je sais monter les escaliers (Pasquin)', 'Le docteur Miracle, Scene 4: Couplets. Je sais monter les escaliers (Pasquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e26553b4-0515-4aa8-a383-1b14aa6c32d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Ah, j''en mourrai! (Laurette, Le Podestat)', part.name_en = 'Le docteur Miracle, Scene 10: Ah, j''en mourrai! (Laurette, Le Podestat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e70060bd-a888-4220-93a0-558932858102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70060bd-a888-4220-93a0-558932858102', 17, NULL, 'Ah, j''en mourrai! (Laurette, Le Podestat)', 'Le docteur Miracle, Scene 10: Ah, j''en mourrai! (Laurette, Le Podestat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70060bd-a888-4220-93a0-558932858102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Ah, c''est vous, tendre amie (Le Podestat, Veronique, Laurette)', part.name_en = 'Le docteur Miracle, Scene 11: Ah, c''est vous, tendre amie (Le Podestat, Veronique, Laurette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f2404db0-08ed-404e-a4e0-01d20a097fa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2404db0-08ed-404e-a4e0-01d20a097fa4', 18, NULL, 'Ah, c''est vous, tendre amie (Le Podestat, Veronique, Laurette)', 'Le docteur Miracle, Scene 11: Ah, c''est vous, tendre amie (Le Podestat, Veronique, Laurette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2404db0-08ed-404e-a4e0-01d20a097fa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Allons, tu as des connaissances tres variées (Le Podestat, Pasquin)', part.name_en = 'Le docteur Miracle, Scene 4: Allons, tu as des connaissances tres variées (Le Podestat, Pasquin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f5c5cc8b-d899-4ff6-b0a9-ace9392ea16a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5c5cc8b-d899-4ff6-b0a9-ace9392ea16a', 19, NULL, 'Allons, tu as des connaissances tres variées (Le Podestat, Pasquin)', 'Le docteur Miracle, Scene 4: Allons, tu as des connaissances tres variées (Le Podestat, Pasquin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c5cc8b-d899-4ff6-b0a9-ace9392ea16a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Quatuor final. Mon enfant, si tu m''aimes bien (Le Podestat, Veronique, Laurette, Silvio)', part.name_en = 'Le docteur Miracle, Scene 12: Quatuor final. Mon enfant, si tu m''aimes bien (Le Podestat, Veronique, Laurette, Silvio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11835 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:ffb0036e-122a-45f0-bb6c-312309035dfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffb0036e-122a-45f0-bb6c-312309035dfe', 20, NULL, 'Quatuor final. Mon enfant, si tu m''aimes bien (Le Podestat, Veronique, Laurette, Silvio)', 'Le docteur Miracle, Scene 12: Quatuor final. Mon enfant, si tu m''aimes bien (Le Podestat, Veronique, Laurette, Silvio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11835 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb0036e-122a-45f0-bb6c-312309035dfe'
);


-- None 가곡 <Le Doute, WD 89>

UPDATE pieces piece
SET piece.title = '가곡 <Le Doute, WD 89>', piece.title_en = 'Le Doute, WD 89',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11759 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Gascon>

UPDATE pieces piece
SET piece.title = '가곡 <Le Gascon>', piece.title_en = 'Le Gascon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11481 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Golfe de Baïa, WD 119

UPDATE pieces piece
SET piece.title = 'Le Golfe de Baïa, WD 119', piece.title_en = 'Le Golfe de Baïa, WD 119',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11945 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le Matin>

UPDATE pieces piece
SET piece.title = '가곡 <Le Matin>', piece.title_en = 'Le Matin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11702 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Le Retour de Virginie>

UPDATE pieces piece
SET piece.title = '칸타타 <Le Retour de Virginie>', piece.title_en = 'Le Retour de Virginie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11599 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'WD 117: Récit. Paul, mon fils ! sois heureux ! (Marguerite, Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Récit. Paul, mon fils ! sois heureux ! (Marguerite, Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2e71d83f-ae89-4f03-801e-79b84ad764c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e71d83f-ae89-4f03-801e-79b84ad764c9', 1, NULL, 'WD 117: Récit. Paul, mon fils ! sois heureux ! (Marguerite, Paul)', 'Le Retour de Virginie, WD 117: Récit. Paul, mon fils ! sois heureux ! (Marguerite, Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e71d83f-ae89-4f03-801e-79b84ad764c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'WD 117: Prière. Ô roi des cieux, souverain maître (Marguerite, Paul, Le Missionnaire des Pamplemousses)', part.name_en = 'Le Retour de Virginie, WD 117: Prière. Ô roi des cieux, souverain maître (Marguerite, Paul, Le Missionnaire des Pamplemousses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:4b15f46c-73a9-408c-9c7e-e9624e3a384f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b15f46c-73a9-408c-9c7e-e9624e3a384f', 2, NULL, 'WD 117: Prière. Ô roi des cieux, souverain maître (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'Le Retour de Virginie, WD 117: Prière. Ô roi des cieux, souverain maître (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b15f46c-73a9-408c-9c7e-e9624e3a384f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'WD 117: Duo. Bengalis d’alentour (Marguerite, Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Duo. Bengalis d’alentour (Marguerite, Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5178548d-d577-4e04-9beb-b96dbe02f4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5178548d-d577-4e04-9beb-b96dbe02f4b4', 3, NULL, 'WD 117: Duo. Bengalis d’alentour (Marguerite, Paul)', 'Le Retour de Virginie, WD 117: Duo. Bengalis d’alentour (Marguerite, Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5178548d-d577-4e04-9beb-b96dbe02f4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'WD 117: Scène finale. Ô douleur infinie (Marguerite, Paul, Le Missionnaire des Pamplemousses)', part.name_en = 'Le Retour de Virginie, WD 117: Scène finale. Ô douleur infinie (Marguerite, Paul, Le Missionnaire des Pamplemousses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6118f961-f6b7-4991-bb63-58fdf949f13d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6118f961-f6b7-4991-bb63-58fdf949f13d', 4, NULL, 'WD 117: Scène finale. Ô douleur infinie (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'Le Retour de Virginie, WD 117: Scène finale. Ô douleur infinie (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6118f961-f6b7-4991-bb63-58fdf949f13d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'WD 117: Introduction', part.name_en = 'Le Retour de Virginie, WD 117: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:67edde2f-5fa5-4b8f-84a2-9c7a9e206a53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67edde2f-5fa5-4b8f-84a2-9c7a9e206a53', 5, NULL, 'WD 117: Introduction', 'Le Retour de Virginie, WD 117: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67edde2f-5fa5-4b8f-84a2-9c7a9e206a53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'WD 117: Récit. Déjà les orangers ont fleuri quatre fois (Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Récit. Déjà les orangers ont fleuri quatre fois (Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:694b10b7-a2d7-44e5-9c6d-be69b5f92bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:694b10b7-a2d7-44e5-9c6d-be69b5f92bbc', 6, NULL, 'WD 117: Récit. Déjà les orangers ont fleuri quatre fois (Paul)', 'Le Retour de Virginie, WD 117: Récit. Déjà les orangers ont fleuri quatre fois (Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:694b10b7-a2d7-44e5-9c6d-be69b5f92bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'WD 117: Air. Échos de mon deuil solitaire (Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Air. Échos de mon deuil solitaire (Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7f91fbfc-f8a6-460c-9b8e-38243832c0d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f91fbfc-f8a6-460c-9b8e-38243832c0d4', 7, NULL, 'WD 117: Air. Échos de mon deuil solitaire (Paul)', 'Le Retour de Virginie, WD 117: Air. Échos de mon deuil solitaire (Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f91fbfc-f8a6-460c-9b8e-38243832c0d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'WD 117: Récit. Mon âme était partie, on m’a rendu mon âme (Marguerite, Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Récit. Mon âme était partie, on m’a rendu mon âme (Marguerite, Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:867d0271-6b61-4346-8727-153d4b62d8eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:867d0271-6b61-4346-8727-153d4b62d8eb', 8, NULL, 'WD 117: Récit. Mon âme était partie, on m’a rendu mon âme (Marguerite, Paul)', 'Le Retour de Virginie, WD 117: Récit. Mon âme était partie, on m’a rendu mon âme (Marguerite, Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:867d0271-6b61-4346-8727-153d4b62d8eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'WD 117: Strette. Âme de ma vie (Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Strette. Âme de ma vie (Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a71a2ed4-3ae0-42c0-8a59-2caaae8dc13a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a71a2ed4-3ae0-42c0-8a59-2caaae8dc13a', 9, NULL, 'WD 117: Strette. Âme de ma vie (Paul)', 'Le Retour de Virginie, WD 117: Strette. Âme de ma vie (Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a71a2ed4-3ae0-42c0-8a59-2caaae8dc13a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'WD 117: Récit. Virginie ! ô ma sœur, pourquoi rester en France ? (Paul)', part.name_en = 'Le Retour de Virginie, WD 117: Récit. Virginie ! ô ma sœur, pourquoi rester en France ? (Paul)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c39237e6-1309-4398-bc0f-609a68e3933b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c39237e6-1309-4398-bc0f-609a68e3933b', 10, NULL, 'WD 117: Récit. Virginie ! ô ma sœur, pourquoi rester en France ? (Paul)', 'Le Retour de Virginie, WD 117: Récit. Virginie ! ô ma sœur, pourquoi rester en France ? (Paul)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c39237e6-1309-4398-bc0f-609a68e3933b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'WD 117: Orage. Amis, entendez‐vous ? (Le Missionnaire des Pamplemousses)', part.name_en = 'Le Retour de Virginie, WD 117: Orage. Amis, entendez‐vous ? (Le Missionnaire des Pamplemousses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:dd6084c1-9be8-41e4-8f53-3fcdd9a93523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd6084c1-9be8-41e4-8f53-3fcdd9a93523', 11, NULL, 'WD 117: Orage. Amis, entendez‐vous ? (Le Missionnaire des Pamplemousses)', 'Le Retour de Virginie, WD 117: Orage. Amis, entendez‐vous ? (Le Missionnaire des Pamplemousses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd6084c1-9be8-41e4-8f53-3fcdd9a93523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'WD 117: Orage (suite). Entendez‐vous ? le canon tonne ! (Marguerite, Paul, Le Missionnaire des Pamplemousses)', part.name_en = 'Le Retour de Virginie, WD 117: Orage (suite). Entendez‐vous ? le canon tonne ! (Marguerite, Paul, Le Missionnaire des Pamplemousses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11599 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:de79c3f0-25b2-4a0b-9499-967fc583997f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de79c3f0-25b2-4a0b-9499-967fc583997f', 12, NULL, 'WD 117: Orage (suite). Entendez‐vous ? le canon tonne ! (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'Le Retour de Virginie, WD 117: Orage (suite). Entendez‐vous ? le canon tonne ! (Marguerite, Paul, Le Missionnaire des Pamplemousses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11599 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de79c3f0-25b2-4a0b-9499-967fc583997f'
);


-- None 가곡 <Le Retour, WD 130>

UPDATE pieces piece
SET piece.title = '가곡 <Le Retour, WD 130>', piece.title_en = 'Le Retour, WD 130',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12010 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Les Nymphes des bois, WD 132>

UPDATE pieces piece
SET piece.title = '가곡 <Les Nymphes des bois, WD 132>', piece.title_en = 'Les Nymphes des bois, WD 132',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11823 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <L’Arlésienne>

UPDATE pieces piece
SET piece.title = '부수음악 <L’Arlésienne>', piece.title_en = 'L’Arlésienne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11649 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chœur I acte II, tableau 2', part.name_en = 'L’Arlesienne, Musique de scène : Chœur I acte II, tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:3826ab3b-933d-3cea-bf61-fdc67a59297a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3826ab3b-933d-3cea-bf61-fdc67a59297a', 1, NULL, 'Chœur I acte II, tableau 2', 'L’Arlesienne, Musique de scène : Chœur I acte II, tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3826ab3b-933d-3cea-bf61-fdc67a59297a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chœur I acte III, tableau 5', part.name_en = 'L’Arlesienne, Musique de scène : Chœur I acte III, tableau 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:6988b85e-a91d-3c6e-a0a5-ba06ce19e69f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6988b85e-a91d-3c6e-a0a5-ba06ce19e69f', 2, NULL, 'Chœur I acte III, tableau 5', 'L’Arlesienne, Musique de scène : Chœur I acte III, tableau 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6988b85e-a91d-3c6e-a0a5-ba06ce19e69f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Entracte I acte III, tableau 5', part.name_en = 'L’Arlesienne, Musique de scène : Entracte I acte III, tableau 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a57f750a-b5a2-3e5f-83ad-fc7c5c56175f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a57f750a-b5a2-3e5f-83ad-fc7c5c56175f', 3, NULL, 'Entracte I acte III, tableau 5', 'L’Arlesienne, Musique de scène : Entracte I acte III, tableau 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a57f750a-b5a2-3e5f-83ad-fc7c5c56175f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Farandole I acte III, tableau 4', part.name_en = 'L’Arlesienne, Musique de scène : Farandole I acte III, tableau 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f7603d2a-0534-3e93-a0b4-888554b78d62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7603d2a-0534-3e93-a0b4-888554b78d62', 4, NULL, 'Farandole I acte III, tableau 4', 'L’Arlesienne, Musique de scène : Farandole I acte III, tableau 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7603d2a-0534-3e93-a0b4-888554b78d62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mélodrame I acte II, tableau 2', part.name_en = 'L’Arlesienne, Musique de scène : Mélodrame I acte II, tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d3f329d2-192d-3469-8f75-bf377d6945be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3f329d2-192d-3469-8f75-bf377d6945be', 5, NULL, 'Mélodrame I acte II, tableau 2', 'L’Arlesienne, Musique de scène : Mélodrame I acte II, tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3f329d2-192d-3469-8f75-bf377d6945be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Mélodrame I acte II, tableau 2', part.name_en = 'L’Arlesienne, Musique de scène : Mélodrame I acte II, tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a6b3abb7-a6ff-38ee-9148-0fcd0df8d748' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6b3abb7-a6ff-38ee-9148-0fcd0df8d748', 6, NULL, 'Mélodrame I acte II, tableau 2', 'L’Arlesienne, Musique de scène : Mélodrame I acte II, tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b3abb7-a6ff-38ee-9148-0fcd0df8d748'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mélodrame I acte III, tableau 4', part.name_en = 'L’Arlesienne, Musique de scène : Mélodrame I acte III, tableau 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:790cc748-3fe5-3748-806c-90a14269852a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:790cc748-3fe5-3748-806c-90a14269852a', 7, NULL, 'Mélodrame I acte III, tableau 4', 'L’Arlesienne, Musique de scène : Mélodrame I acte III, tableau 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:790cc748-3fe5-3748-806c-90a14269852a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pastorale, entracte et chœur I acte II, tableau 2', part.name_en = 'L’Arlesienne, Musique de scène : Pastorale, entracte et chœur I acte II, tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11649 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:610d8314-270a-31b8-919d-4655f8b15390' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:610d8314-270a-31b8-919d-4655f8b15390', 8, NULL, 'Pastorale, entracte et chœur I acte II, tableau 2', 'L’Arlesienne, Musique de scène : Pastorale, entracte et chœur I acte II, tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11649 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610d8314-270a-31b8-919d-4655f8b15390'
);


-- None Marche funèbre

UPDATE pieces piece
SET piece.title = 'Marche funèbre', piece.title_en = 'Marche funèbre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11433 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marine

UPDATE pieces piece
SET piece.title = 'Marine', piece.title_en = 'Marine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11491 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 미뉴에트 E♭장조

UPDATE pieces piece
SET piece.title = '미뉴에트 E♭장조', piece.title_en = 'Menuet in E-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11831 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Misericorda

UPDATE pieces piece
SET piece.title = 'Misericorda', piece.title_en = 'Misericorda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12002 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Méditation religieuse

UPDATE pieces piece
SET piece.title = 'Méditation religieuse', piece.title_en = 'Méditation religieuse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11833 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <N’oublions pas ! WD 105>

UPDATE pieces piece
SET piece.title = '가곡 <N’oublions pas ! WD 105>', piece.title_en = 'N’oublions pas ! WD 105',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11552 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ogenbliksem>

UPDATE pieces piece
SET piece.title = '가곡 <Ogenbliksem>', piece.title_en = 'Ogenbliksem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11754 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 서곡

UPDATE pieces piece
SET piece.title = '서곡', piece.title_en = 'Ouverture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11899 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ouverture, WD 32, GB 116

UPDATE pieces piece
SET piece.title = 'Ouverture, WD 32, GB 116', piece.title_en = 'Ouverture, WD 32, GB 116',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11664 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Pastel, WD 107>

UPDATE pieces piece
SET piece.title = '가곡 <Pastel, WD 107>', piece.title_en = 'Pastel, WD 107',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11416 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Patrie, ouverture dramatique, op. 19, WD 41

UPDATE pieces piece
SET piece.title = 'Patrie, ouverture dramatique, op. 19, WD 41', piece.title_en = 'Patrie, ouverture dramatique, op. 19, WD 41',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9973 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perlenfischer-Tango

UPDATE pieces piece
SET piece.title = 'Perlenfischer-Tango', piece.title_en = 'Perlenfischer-Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11634 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Petite Marguerite>

UPDATE pieces piece
SET piece.title = '가곡 <Petite Marguerite>', piece.title_en = 'Petite Marguerite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11749 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Pourquoi pleurer>

UPDATE pieces piece
SET piece.title = '가곡 <Pourquoi pleurer>', piece.title_en = 'Pourquoi pleurer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11785 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Qui donc t’aimera mieux ?>

UPDATE pieces piece
SET piece.title = '가곡 <Qui donc t’aimera mieux ?>', piece.title_en = 'Qui donc t’aimera mieux ?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11909 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance sans paroles, GB 129

UPDATE pieces piece
SET piece.title = 'Romance sans paroles, GB 129', piece.title_en = 'Romance sans paroles, GB 129',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11850 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance sans paroles, GB 133

UPDATE pieces piece
SET piece.title = 'Romance sans paroles, GB 133', piece.title_en = 'Romance sans paroles, GB 133',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11721 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rose d’amour, WD 80>

UPDATE pieces piece
SET piece.title = '가곡 <Rose d’amour, WD 80>', piece.title_en = 'Rose d’amour, WD 80',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11986 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rêvons>

UPDATE pieces piece
SET piece.title = '가곡 <Rêvons>', piece.title_en = 'Rêvons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11816 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Si vous aimez, WD 106>

UPDATE pieces piece
SET piece.title = '가곡 <Si vous aimez, WD 106>', piece.title_en = 'Si vous aimez, WD 106',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11600 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spanish Gypsy Dance (from “Carmen”)

UPDATE pieces piece
SET piece.title = 'Spanish Gypsy Dance (from “Carmen”)', piece.title_en = 'Spanish Gypsy Dance (from “Carmen”)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11957 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spanish Kick ("Carmen Habanera")

UPDATE pieces piece
SET piece.title = 'Spanish Kick ("Carmen Habanera")', piece.title_en = 'Spanish Kick ("Carmen Habanera")',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11713 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 1번 C장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivo', part.name_en = 'Symphonie no. 1 en ut majeur : I. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 196 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e65819d3-620c-3fbf-8c10-9afa8f4ed27e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e65819d3-620c-3fbf-8c10-9afa8f4ed27e', 1, 'I', 'Allegro vivo', 'Symphonie no. 1 en ut majeur : I. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 196 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e65819d3-620c-3fbf-8c10-9afa8f4ed27e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante (Adagio)', part.name_en = 'Symphonie no. 1 en ut majeur : II. Andante (Adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 196 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c1c5d47a-2582-35a9-89df-0533fce8361d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1c5d47a-2582-35a9-89df-0533fce8361d', 2, 'II', 'Andante (Adagio)', 'Symphonie no. 1 en ut majeur : II. Andante (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 196 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c5d47a-2582-35a9-89df-0533fce8361d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro vivace', part.name_en = 'Symphonie no. 1 en ut majeur : III. Scherzo. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 196 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:12fa62c0-0bfc-3746-ac7f-02ac9436616c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12fa62c0-0bfc-3746-ac7f-02ac9436616c', 3, 'III', 'Scherzo. Allegro vivace', 'Symphonie no. 1 en ut majeur : III. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 196 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12fa62c0-0bfc-3746-ac7f-02ac9436616c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro vivace', part.name_en = 'Symphonie no. 1 en ut majeur : IV. Finale. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 196 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:67bbdf52-cd9b-3082-a1eb-ce7db0421ae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67bbdf52-cd9b-3082-a1eb-ce7db0421ae5', 4, 'IV', 'Finale. Allegro vivace', 'Symphonie no. 1 en ut majeur : IV. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 196 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67bbdf52-cd9b-3082-a1eb-ce7db0421ae5'
);


-- None 교향곡 C장조 "Roma"

UPDATE pieces piece
SET piece.title = '교향곡 C장조 "Roma"', piece.title_en = 'Symphony in C major "Roma"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11309 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante tranquillo - Allegro agitato', part.name_en = 'Symphony in C major "Roma": I. Andante tranquillo - Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11309 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a793736a-fe0f-4afe-bcd9-9f2f3393243f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a793736a-fe0f-4afe-bcd9-9f2f3393243f', 1, 'I', 'Andante tranquillo - Allegro agitato', 'Symphony in C major "Roma": I. Andante tranquillo - Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11309 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a793736a-fe0f-4afe-bcd9-9f2f3393243f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony in C major "Roma": II. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11309 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:da690341-13d7-4478-af1d-9dd306845d32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da690341-13d7-4478-af1d-9dd306845d32', 2, 'II', 'Allegro vivace', 'Symphony in C major "Roma": II. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11309 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da690341-13d7-4478-af1d-9dd306845d32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante molto', part.name_en = 'Symphony in C major "Roma": III. Andante molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11309 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5c1ae49f-aa60-4ad3-9f8c-dfaeacf9de7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c1ae49f-aa60-4ad3-9f8c-dfaeacf9de7c', 3, 'III', 'Andante molto', 'Symphony in C major "Roma": III. Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11309 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c1ae49f-aa60-4ad3-9f8c-dfaeacf9de7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro vivacissimo', part.name_en = 'Symphony in C major "Roma": IV. Allegro vivacissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11309 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8ee4d9ba-0f94-4aeb-8032-dcf77d09ed99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee4d9ba-0f94-4aeb-8032-dcf77d09ed99', 4, 'IV', 'Allegro vivacissimo', 'Symphony in C major "Roma": IV. Allegro vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11309 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee4d9ba-0f94-4aeb-8032-dcf77d09ed99'
);


-- None 세레나데

UPDATE pieces piece
SET piece.title = '세레나데', piece.title_en = 'Sérénade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11915 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Te Deum, WD 122, GB 36

UPDATE pieces piece
SET piece.title = 'Te Deum, WD 122, GB 36', piece.title_en = 'Te Deum, WD 122, GB 36',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11608 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Te Deum laudamus', part.name_en = 'Te Deum: 1. Te Deum laudamus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11608 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:23601b0f-07e6-4a44-9bbe-2ce96290d90f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23601b0f-07e6-4a44-9bbe-2ce96290d90f', 1, NULL, 'Te Deum laudamus', 'Te Deum: 1. Te Deum laudamus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11608 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23601b0f-07e6-4a44-9bbe-2ce96290d90f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tu rex gloriae, Christe', part.name_en = 'Te Deum: 2. Tu rex gloriae, Christe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11608 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a3eb3178-56fd-47f0-af75-34367e2d7869' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3eb3178-56fd-47f0-af75-34367e2d7869', 2, NULL, 'Tu rex gloriae, Christe', 'Te Deum: 2. Tu rex gloriae, Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11608 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3eb3178-56fd-47f0-af75-34367e2d7869'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Te ergo quaesumus', part.name_en = 'Te Deum: 3. Te ergo quaesumus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11608 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2be231e7-fe23-4005-af91-9e93e09fdcab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2be231e7-fe23-4005-af91-9e93e09fdcab', 3, NULL, 'Te ergo quaesumus', 'Te Deum: 3. Te ergo quaesumus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11608 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2be231e7-fe23-4005-af91-9e93e09fdcab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fiat misericordia tua', part.name_en = 'Te Deum: 4. Fiat misericordia tua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11608 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:09585e48-fe2d-442d-8350-93966f4aa5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09585e48-fe2d-442d-8350-93966f4aa5ce', 4, NULL, 'Fiat misericordia tua', 'Te Deum: 4. Fiat misericordia tua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11608 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09585e48-fe2d-442d-8350-93966f4aa5ce'
);


-- None The Quintette Plays Carmen

UPDATE pieces piece
SET piece.title = 'The Quintette Plays Carmen', piece.title_en = 'The Quintette Plays Carmen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11412 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thème brillant

UPDATE pieces piece
SET piece.title = 'Thème brillant', piece.title_en = 'Thème brillant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11706 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Toreador

UPDATE pieces piece
SET piece.title = 'Toreador', piece.title_en = 'Toreador',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11637 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trois Esquisses musicales

UPDATE pieces piece
SET piece.title = 'Trois Esquisses musicales', piece.title_en = 'Trois Esquisses musicales',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11417 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ronde turque', part.name_en = 'Trois Esquisses musicales: no. 1. Ronde turque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11417 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f2e0ee46-48ef-4751-b29b-80ae2c230146' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2e0ee46-48ef-4751-b29b-80ae2c230146', 1, NULL, 'Ronde turque', 'Trois Esquisses musicales: no. 1. Ronde turque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11417 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2e0ee46-48ef-4751-b29b-80ae2c230146'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sérénade', part.name_en = 'Trois Esquisses musicales: no. 2. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11417 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:82cd426b-4216-4a51-81e8-922ce5441d7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82cd426b-4216-4a51-81e8-922ce5441d7f', 2, NULL, 'Sérénade', 'Trois Esquisses musicales: no. 2. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11417 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82cd426b-4216-4a51-81e8-922ce5441d7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Caprice', part.name_en = 'Trois Esquisses musicales: no. 3. Caprice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11417 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8902cd58-b100-4c49-a2b5-4f48a7bc9897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8902cd58-b100-4c49-a2b5-4f48a7bc9897', 3, NULL, 'Caprice', 'Trois Esquisses musicales: no. 3. Caprice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11417 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8902cd58-b100-4c49-a2b5-4f48a7bc9897'
);


-- Op. 1 Valse en do majeur

UPDATE pieces piece
SET piece.title = 'Valse en do majeur', piece.title_en = 'Valse en do majeur, op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11662 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations chromatiques de concert, WD 54

UPDATE pieces piece
SET piece.title = 'Variations chromatiques de concert, WD 54', piece.title_en = 'Variations chromatiques de concert, WD 54',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11560 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme. Moderato maestoso', part.name_en = 'Variations chromatiques de concert, op. 3: Theme. Moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5ad0bbbf-3156-3581-ba8c-03bca89dc5a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ad0bbbf-3156-3581-ba8c-03bca89dc5a3', 1, NULL, 'Theme. Moderato maestoso', 'Variations chromatiques de concert, op. 3: Theme. Moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ad0bbbf-3156-3581-ba8c-03bca89dc5a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variatio I. Un pochissimo più allegretto', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio I. Un pochissimo più allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a0ab508c-3b72-3597-81c4-41cb369c106d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0ab508c-3b72-3597-81c4-41cb369c106d', 2, NULL, 'Variatio I. Un pochissimo più allegretto', 'Variations chromatiques de concert, op. 3: Variatio I. Un pochissimo più allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ab508c-3b72-3597-81c4-41cb369c106d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variatio II. A tempo rubato', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio II. A tempo rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b39ddbb6-263d-340b-9db6-90d802265f24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b39ddbb6-263d-340b-9db6-90d802265f24', 3, NULL, 'Variatio II. A tempo rubato', 'Variations chromatiques de concert, op. 3: Variatio II. A tempo rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b39ddbb6-263d-340b-9db6-90d802265f24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variatio III. A tempo risoluto', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio III. A tempo risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:f545ebfc-b4da-3683-92a7-df6574ef47a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f545ebfc-b4da-3683-92a7-df6574ef47a5', 4, NULL, 'Variatio III. A tempo risoluto', 'Variations chromatiques de concert, op. 3: Variatio III. A tempo risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f545ebfc-b4da-3683-92a7-df6574ef47a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variatio IV. Con fuoco', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio IV. Con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a689dad1-a20e-39dc-a774-f73e409ce8eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a689dad1-a20e-39dc-a774-f73e409ce8eb', 5, NULL, 'Variatio IV. Con fuoco', 'Variations chromatiques de concert, op. 3: Variatio IV. Con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a689dad1-a20e-39dc-a774-f73e409ce8eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variatio V', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:7576ac1f-e607-3ed3-84cd-ec68752f7159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7576ac1f-e607-3ed3-84cd-ec68752f7159', 6, NULL, 'Variatio V', 'Variations chromatiques de concert, op. 3: Variatio V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7576ac1f-e607-3ed3-84cd-ec68752f7159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variatio VI. Agitato', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio VI. Agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0ecd5414-70de-37bc-a9ac-97c31f6c8a99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ecd5414-70de-37bc-a9ac-97c31f6c8a99', 7, NULL, 'Variatio VI. Agitato', 'Variations chromatiques de concert, op. 3: Variatio VI. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ecd5414-70de-37bc-a9ac-97c31f6c8a99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variatio VII', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio VII.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:57256a5b-34e0-3cb2-ab60-a02878187dd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57256a5b-34e0-3cb2-ab60-a02878187dd7', 8, NULL, 'Variatio VII', 'Variations chromatiques de concert, op. 3: Variatio VII.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57256a5b-34e0-3cb2-ab60-a02878187dd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variatio VIII. Con espressione', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio VIII. Con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:a77991f1-62fa-304b-8827-c583352d9e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a77991f1-62fa-304b-8827-c583352d9e2e', 9, NULL, 'Variatio VIII. Con espressione', 'Variations chromatiques de concert, op. 3: Variatio VIII. Con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a77991f1-62fa-304b-8827-c583352d9e2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variatio IX. Un peu plus vite', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio IX. Un peu plus vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:1a5f3eaf-e4c6-37cc-b868-43378cd18f3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a5f3eaf-e4c6-37cc-b868-43378cd18f3c', 10, NULL, 'Variatio IX. Un peu plus vite', 'Variations chromatiques de concert, op. 3: Variatio IX. Un peu plus vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a5f3eaf-e4c6-37cc-b868-43378cd18f3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Variatio X. Alla polacca', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio X. Alla polacca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:847cdfa2-5d3b-3f7c-a7b6-7c557a320b06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:847cdfa2-5d3b-3f7c-a7b6-7c557a320b06', 11, NULL, 'Variatio X. Alla polacca', 'Variations chromatiques de concert, op. 3: Variatio X. Alla polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:847cdfa2-5d3b-3f7c-a7b6-7c557a320b06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Variatio XI. Andante', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio XI. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:e9dc7c75-319e-3de7-bf1d-b4a69fdcc71a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9dc7c75-319e-3de7-bf1d-b4a69fdcc71a', 12, NULL, 'Variatio XI. Andante', 'Variations chromatiques de concert, op. 3: Variatio XI. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9dc7c75-319e-3de7-bf1d-b4a69fdcc71a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Variatio XII. Plus animé', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio XII. Plus animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:fd103901-03d2-3e07-8ed2-936d0622a7b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd103901-03d2-3e07-8ed2-936d0622a7b4', 13, NULL, 'Variatio XII. Plus animé', 'Variations chromatiques de concert, op. 3: Variatio XII. Plus animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd103901-03d2-3e07-8ed2-936d0622a7b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Variatio XIII. Mouvement des 1ères variations', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio XIII. Mouvement des 1ères variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:b51aa7a2-1280-3985-a517-fd6cee1c311e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51aa7a2-1280-3985-a517-fd6cee1c311e', 14, NULL, 'Variatio XIII. Mouvement des 1ères variations', 'Variations chromatiques de concert, op. 3: Variatio XIII. Mouvement des 1ères variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51aa7a2-1280-3985-a517-fd6cee1c311e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Variatio XIV. Appassionato', part.name_en = 'Variations chromatiques de concert, op. 3: Variatio XIV. Appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:d2405f9d-9f52-386c-b730-929287a1263c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2405f9d-9f52-386c-b730-929287a1263c', 15, NULL, 'Variatio XIV. Appassionato', 'Variations chromatiques de concert, op. 3: Variatio XIV. Appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2405f9d-9f52-386c-b730-929287a1263c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Coda. Semplice – Un peu plus lent – Quasi recitativo – A tempo', part.name_en = 'Variations chromatiques de concert, op. 3: Coda. Semplice – Un peu plus lent – Quasi recitativo – A tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11560 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:15777b91-ccbc-3859-83af-050210c352ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15777b91-ccbc-3859-83af-050210c352ed', 16, NULL, 'Coda. Semplice – Un peu plus lent – Quasi recitativo – A tempo', 'Variations chromatiques de concert, op. 3: Coda. Semplice – Un peu plus lent – Quasi recitativo – A tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11560 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15777b91-ccbc-3859-83af-050210c352ed'
);


-- None Vasco da Gama. Ode-symphonie, WD 124

UPDATE pieces piece
SET piece.title = 'Vasco da Gama. Ode-symphonie, WD 124', piece.title_en = 'Vasco da Gama. Ode-symphonie, WD 124',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11804 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Final. « Terre ! Terre ! »', part.name_en = 'Vasco de Gama, WD 124: Final. « Terre ! Terre ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:07f7aa47-1bc5-43c3-9ed0-290f1a52a328' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f7aa47-1bc5-43c3-9ed0-290f1a52a328', 1, NULL, 'Final. « Terre ! Terre ! »', 'Vasco de Gama, WD 124: Final. « Terre ! Terre ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f7aa47-1bc5-43c3-9ed0-290f1a52a328'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Récit et Prière. « Que l’aspect du danger »', part.name_en = 'Vasco de Gama, WD 124: Récit et Prière. « Que l’aspect du danger »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:3fe799fd-9301-47c7-948d-ffd21da678a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fe799fd-9301-47c7-948d-ffd21da678a8', 2, NULL, 'Récit et Prière. « Que l’aspect du danger »', 'Vasco de Gama, WD 124: Récit et Prière. « Que l’aspect du danger »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fe799fd-9301-47c7-948d-ffd21da678a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '« La Marguerite a fermé sa corolle » ... « Ouvre ton cœur »', part.name_en = 'Vasco da Gama: « La Marguerite a fermé sa corolle » ... « Ouvre ton cœur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:74618b91-edcd-4f4b-ad29-b21ea8d70746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74618b91-edcd-4f4b-ad29-b21ea8d70746', 3, NULL, '« La Marguerite a fermé sa corolle » ... « Ouvre ton cœur »', 'Vasco da Gama: « La Marguerite a fermé sa corolle » ... « Ouvre ton cœur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74618b91-edcd-4f4b-ad29-b21ea8d70746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Récit. « La mer est immobile »', part.name_en = 'Vasco de Gama, WD 124: Récit. « La mer est immobile »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:bc48a789-1c08-497d-92bd-ff91e695e53e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc48a789-1c08-497d-92bd-ff91e695e53e', 4, NULL, 'Récit. « La mer est immobile »', 'Vasco de Gama, WD 124: Récit. « La mer est immobile »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc48a789-1c08-497d-92bd-ff91e695e53e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Orage et Apparition. « Amis, cessez vos chants ! »', part.name_en = 'Vasco de Gama, WD 124: Orage et Apparition. « Amis, cessez vos chants ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c11838ba-e8b8-4a47-9a88-622c0709c7d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c11838ba-e8b8-4a47-9a88-622c0709c7d9', 5, NULL, 'Orage et Apparition. « Amis, cessez vos chants ! »', 'Vasco de Gama, WD 124: Orage et Apparition. « Amis, cessez vos chants ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c11838ba-e8b8-4a47-9a88-622c0709c7d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Introduction. « Limpide et radieux »', part.name_en = 'Vasco de Gama, WD 124: Introduction. « Limpide et radieux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11804 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c4219ce4-5f73-49ba-940d-12bd2589d9c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4219ce4-5f73-49ba-940d-12bd2589d9c7', 6, NULL, 'Introduction. « Limpide et radieux »', 'Vasco de Gama, WD 124: Introduction. « Limpide et radieux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11804 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4219ce4-5f73-49ba-940d-12bd2589d9c7'
);


-- Op. 21 Vingt mélodies Op. 21

UPDATE pieces piece
SET piece.title = 'Vingt mélodies Op. 21', piece.title_en = 'Vingt mélodies, op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11941 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Matin, op. 21 no. 2', part.name_en = 'Le Matin, op. 21 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:22d07565-8b79-4eee-b938-80e2e0712dd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d07565-8b79-4eee-b938-80e2e0712dd9', 1, NULL, 'Le Matin, op. 21 no. 2', 'Le Matin, op. 21 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d07565-8b79-4eee-b938-80e2e0712dd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vieille Chanson, op. 21 no. 3', part.name_en = 'Vieille Chanson, op. 21 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:437b2bd0-6960-4abc-a41a-b4b4fd2348b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:437b2bd0-6960-4abc-a41a-b4b4fd2348b7', 2, NULL, 'Vieille Chanson, op. 21 no. 3', 'Vieille Chanson, op. 21 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437b2bd0-6960-4abc-a41a-b4b4fd2348b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adieux de l''hôtesse arabe, op. 21 no. 4', part.name_en = 'Adieux de l''hôtesse arabe, op. 21 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:16a96e5c-02c9-4874-a655-6eda8b843ea4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16a96e5c-02c9-4874-a655-6eda8b843ea4', 3, NULL, 'Adieux de l''hôtesse arabe, op. 21 no. 4', 'Adieux de l''hôtesse arabe, op. 21 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a96e5c-02c9-4874-a655-6eda8b843ea4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rêve de la bien-aimée, op. 21 no. 5', part.name_en = 'Rêve de la bien-aimée, op. 21 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:5f4a94cd-ed5e-46c2-b4dc-80f103fa4292' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f4a94cd-ed5e-46c2-b4dc-80f103fa4292', 4, NULL, 'Rêve de la bien-aimée, op. 21 no. 5', 'Rêve de la bien-aimée, op. 21 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4a94cd-ed5e-46c2-b4dc-80f103fa4292'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vous ne priez pas, op. 21 no. 7', part.name_en = 'Vous ne priez pas, op. 21 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:48ab3cc9-d0bc-41cf-b221-d0ab7958d205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48ab3cc9-d0bc-41cf-b221-d0ab7958d205', 5, NULL, 'Vous ne priez pas, op. 21 no. 7', 'Vous ne priez pas, op. 21 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48ab3cc9-d0bc-41cf-b221-d0ab7958d205'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ma vie a son secret, op. 21 no. 8', part.name_en = 'Ma vie a son secret, op. 21 no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:60a3b08a-2a33-43a5-9572-b57ff9ac8fdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60a3b08a-2a33-43a5-9572-b57ff9ac8fdf', 6, NULL, 'Ma vie a son secret, op. 21 no. 8', 'Ma vie a son secret, op. 21 no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a3b08a-2a33-43a5-9572-b57ff9ac8fdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pastorale, op. 21 no. 9', part.name_en = 'Pastorale, op. 21 no. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:670083ab-193d-45ef-a513-fc8d1f18624e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:670083ab-193d-45ef-a513-fc8d1f18624e', 7, NULL, 'Pastorale, op. 21 no. 9', 'Pastorale, op. 21 no. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:670083ab-193d-45ef-a513-fc8d1f18624e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sérénade, op. 21 no. 10', part.name_en = 'Sérénade, op. 21 no. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8c2ab42a-adf0-4794-94b4-0cf07b7ff98c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c2ab42a-adf0-4794-94b4-0cf07b7ff98c', 8, NULL, 'Sérénade, op. 21 no. 10', 'Sérénade, op. 21 no. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c2ab42a-adf0-4794-94b4-0cf07b7ff98c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Berceuse (Sur un vieil air), op. 21 no. 11', part.name_en = 'Berceuse (Sur un vieil air), op. 21 no. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:051ea5d6-6d24-4ea6-8a4b-c5a223624721' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:051ea5d6-6d24-4ea6-8a4b-c5a223624721', 9, NULL, 'Berceuse (Sur un vieil air), op. 21 no. 11', 'Berceuse (Sur un vieil air), op. 21 no. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:051ea5d6-6d24-4ea6-8a4b-c5a223624721'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'La Chanson du fou, op. 21 no. 12', part.name_en = 'La Chanson du fou, op. 21 no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:cbe66e83-5ae8-434a-aa5e-ee3f610b6b1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbe66e83-5ae8-434a-aa5e-ee3f610b6b1e', 10, NULL, 'La Chanson du fou, op. 21 no. 12', 'La Chanson du fou, op. 21 no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbe66e83-5ae8-434a-aa5e-ee3f610b6b1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Absence, op. 21 no. 13', part.name_en = 'Absence, op. 21 no. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c82c20da-f2f0-4e55-861a-c94edccca37b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c82c20da-f2f0-4e55-861a-c94edccca37b', 11, NULL, 'Absence, op. 21 no. 13', 'Absence, op. 21 no. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c82c20da-f2f0-4e55-861a-c94edccca37b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Douce Mer, op. 21 no. 14', part.name_en = 'Douce Mer, op. 21 no. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:dfbc0810-a028-44ed-bd11-6d58e3eea463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfbc0810-a028-44ed-bd11-6d58e3eea463', 12, NULL, 'Douce Mer, op. 21 no. 14', 'Douce Mer, op. 21 no. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfbc0810-a028-44ed-bd11-6d58e3eea463'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Après l’hiver, op. 21 no. 15', part.name_en = 'Après l’hiver, op. 21 no. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:879cd367-e676-419e-818d-0fbb204e6b4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:879cd367-e676-419e-818d-0fbb204e6b4b', 13, NULL, 'Après l’hiver, op. 21 no. 15', 'Après l’hiver, op. 21 no. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:879cd367-e676-419e-818d-0fbb204e6b4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'La Coccinelle, op. 21 no. 16', part.name_en = 'La Coccinelle, op. 21 no. 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:c932c6a4-fd12-467a-aabe-8e188ff7aa82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c932c6a4-fd12-467a-aabe-8e188ff7aa82', 14, NULL, 'La Coccinelle, op. 21 no. 16', 'La Coccinelle, op. 21 no. 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c932c6a4-fd12-467a-aabe-8e188ff7aa82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Chant d’amour ! op. 21 no. 17', part.name_en = 'Chant d’amour ! op. 21 no. 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:199af11c-70ab-4c1c-b9e9-e015bd89303c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:199af11c-70ab-4c1c-b9e9-e015bd89303c', 15, NULL, 'Chant d’amour ! op. 21 no. 17', 'Chant d’amour ! op. 21 no. 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199af11c-70ab-4c1c-b9e9-e015bd89303c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Je n''en dirai rien, op. 21 no. 18', part.name_en = 'Je n''en dirai rien, op. 21 no. 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:0bed53f4-fa12-465e-9661-5733c4a185c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bed53f4-fa12-465e-9661-5733c4a185c4', 16, NULL, 'Je n''en dirai rien, op. 21 no. 18', 'Je n''en dirai rien, op. 21 no. 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bed53f4-fa12-465e-9661-5733c4a185c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'L''Esprit saint, op. 21 no. 19', part.name_en = 'L''Esprit saint, op. 21 no. 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:2d297733-8da0-4ab8-be86-31a19677af0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d297733-8da0-4ab8-be86-31a19677af0b', 17, NULL, 'L''Esprit saint, op. 21 no. 19', 'L''Esprit saint, op. 21 no. 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d297733-8da0-4ab8-be86-31a19677af0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Tarentelle, op. 21 no. 20', part.name_en = 'Tarentelle, op. 21 no. 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11941 AND p.composer_id = 44 AND part.part_key = 'musicbrainz:8271b179-f22c-4894-9113-ebbdf0859ba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8271b179-f22c-4894-9113-ebbdf0859ba0', 18, NULL, 'Tarentelle, op. 21 no. 20', 'Tarentelle, op. 21 no. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11941 AND p.composer_id = 44
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8271b179-f22c-4894-9113-ebbdf0859ba0'
);


-- None 가곡 <Vocalise pour ténor, WD 109>

UPDATE pieces piece
SET piece.title = '가곡 <Vocalise pour ténor, WD 109>', piece.title_en = 'Vocalise pour ténor, WD 109',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11561 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vœu>

UPDATE pieces piece
SET piece.title = '가곡 <Vœu>', piece.title_en = 'Vœu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11485 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡

UPDATE pieces piece
SET piece.title = '연습곡', piece.title_en = 'Étude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11650 AND piece.composer_id = 44
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave Maria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave Maria', 'Ave Maria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave Maria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ffa5c10-9c38-43e2-a7fd-b10153f0431c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ffa5c10-9c38-43e2-a7fd-b10153f0431c'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Ave Maria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ffa5c10-9c38-43e2-a7fd-b10153f0431c'
);


-- None Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)', 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56571b7a-0a36-4ea2-836a-dd8457da1355'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56571b7a-0a36-4ea2-836a-dd8457da1355'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Ah, just look!” (Soldiers, Cigarette Girls, Young Men)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56571b7a-0a36-4ea2-836a-dd8457da1355'
);


-- None Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)', 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “But why hasn’t she come, our Carmencita?” (Soldiers, Young Men, Cigarette Girls, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fcf49d0-7624-4399-b6f6-dcd3e7e8a4c6'
);


-- None Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)', 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84bdeda9-76d4-4059-a85f-8a42c69cb720'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84bdeda9-76d4-4059-a85f-8a42c69cb720'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Careful—it’s the lieutenant” (Don José, Zuniga, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84bdeda9-76d4-4059-a85f-8a42c69cb720'
);


-- None Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)', 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47051267-cb2e-4e9d-83bc-dbc9efb37ed8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47051267-cb2e-4e9d-83bc-dbc9efb37ed8'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Carmen! We will follow you high and low!” (Young Men, Carmen, Don José, Cigarette Girls)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47051267-cb2e-4e9d-83bc-dbc9efb37ed8'
);


-- None Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)', 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eca6407-ff9a-4aba-b35a-2351b680b0f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5eca6407-ff9a-4aba-b35a-2351b680b0f8'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Come and help!” (Cigarette Girls, Zuniga, Soldiers)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eca6407-ff9a-4aba-b35a-2351b680b0f8'
);


-- None Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)', 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4052185a-300f-43df-8138-bada97512e4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4052185a-300f-43df-8138-bada97512e4c'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Corporal! — Sir!” (Zuniga, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4052185a-300f-43df-8138-bada97512e4c'
);


-- None Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)', 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa53920a-d701-4f13-b9dd-f7965ee3a61e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa53920a-d701-4f13-b9dd-f7965ee3a61e'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Give me news of my mother!” (Don José, Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa53920a-d701-4f13-b9dd-f7965ee3a61e'
);


-- None Carmen: Act I. “Here come our new soldier boys” (Children)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Here come our new soldier boys” (Children)', 'Carmen: Act I. “Here come our new soldier boys” (Children)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Here come our new soldier boys” (Children)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00b0090-924d-4f78-80ac-01fd3cb3c78c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c00b0090-924d-4f78-80ac-01fd3cb3c78c'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Here come our new soldier boys” (Children)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00b0090-924d-4f78-80ac-01fd3cb3c78c'
);


-- None Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)', 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3a409be-749d-48af-a24f-eda6918b3f64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3a409be-749d-48af-a24f-eda6918b3f64'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “I see my mother’s face!” (Don José, Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3a409be-749d-48af-a24f-eda6918b3f64'
);


-- None Carmen: Act I. “In the plaza” (Soldiers, Moralès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)', 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b01bc7a-e180-406e-9ee1-d0a93fc314f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b01bc7a-e180-406e-9ee1-d0a93fc314f6'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “In the plaza” (Soldiers, Moralès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b01bc7a-e180-406e-9ee1-d0a93fc314f6'
);


-- None Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)', 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52ba3860-5d23-4764-99ac-9af082b6376d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52ba3860-5d23-4764-99ac-9af082b6376d'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “José! There was a girl looking for you just now” (Moralès, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52ba3860-5d23-4764-99ac-9af082b6376d'
);


-- None Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)', 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06a59598-d129-43c1-ab06-20d66b6e9226'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06a59598-d129-43c1-ab06-20d66b6e9226'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Just look at that delicious morsel” (Moralès, Soldiers, Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06a59598-d129-43c1-ab06-20d66b6e9226'
);


-- None Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)', 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Love’s a bird wild as any rebel” (Carmen, Cigarette Girls, Young Men, Soldiers)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f5cc9b-a9fe-43ae-8c1e-a49fdc243e93'
);


-- None Carmen: Act I. “Off with you old soldier boys” (Children)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Off with you old soldier boys” (Children)', 'Carmen: Act I. “Off with you old soldier boys” (Children)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Off with you old soldier boys” (Children)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40611ea4-1939-45ed-9020-618046ffab3a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40611ea4-1939-45ed-9020-618046ffab3a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Off with you old soldier boys” (Children)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40611ea4-1939-45ed-9020-618046ffab3a'
);


-- None Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)', 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '022b9ec9-3fa7-43d0-b053-50ef73f6d0f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '022b9ec9-3fa7-43d0-b053-50ef73f6d0f5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “So corporal: tell me what happened” (Zuniga, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '022b9ec9-3fa7-43d0-b053-50ef73f6d0f5'
);


-- None Carmen: Act I. “The cheek of it!” (Don José, Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)', 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e10ce949-e746-42ce-9f72-e4fa001c3ba9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e10ce949-e746-42ce-9f72-e4fa001c3ba9'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “The cheek of it!” (Don José, Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e10ce949-e746-42ce-9f72-e4fa001c3ba9'
);


-- None Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)', 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd34adfee-620f-4c98-80cc-3b2071ecf787'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd34adfee-620f-4c98-80cc-3b2071ecf787'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “There’s an old bar in the city” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd34adfee-620f-4c98-80cc-3b2071ecf787'
);


-- None Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)', 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5363fd2-699b-40c4-ab72-8d09fa866deb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5363fd2-699b-40c4-ab72-8d09fa866deb'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Wait a moment—I’m going to read the letter” (Don José, Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5363fd2-699b-40c4-ab72-8d09fa866deb'
);


-- None Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)', 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '381f1f9d-3710-43d9-a9a4-d7e4ed691eb3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '381f1f9d-3710-43d9-a9a4-d7e4ed691eb3'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “We have heard the bell summon us to meet here” (Young Men)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '381f1f9d-3710-43d9-a9a4-d7e4ed691eb3'
);


-- None Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)', 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9532ad56-25c6-4110-aed8-a997b6d4b50e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9532ad56-25c6-4110-aed8-a997b6d4b50e'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Well, Carmencita: what do you have to say for yourself?” (Zuniga, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9532ad56-25c6-4110-aed8-a997b6d4b50e'
);


-- None Carmen: Act I. “Where are you taking me?” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)', 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da1b10f1-8ccf-453c-88b1-102941cb4ff5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da1b10f1-8ccf-453c-88b1-102941cb4ff5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Where are you taking me?” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da1b10f1-8ccf-453c-88b1-102941cb4ff5'
);


-- None Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)', 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fc9838b-d4de-4a19-b5eb-36c0a27ea63d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1fc9838b-d4de-4a19-b5eb-36c0a27ea63d'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act I. “Your dear mother and I were leaving church this morning” (Micaëla, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fc9838b-d4de-4a19-b5eb-36c0a27ea63d'
);


-- None Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)', 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '456d1d3a-a88a-413f-a35b-36131a68f49e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '456d1d3a-a88a-413f-a35b-36131a68f49e'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “At last! – We got rid of them as quickly as we could” (Remendado, Frasquita, Dancaïre, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '456d1d3a-a88a-413f-a35b-36131a68f49e'
);


-- None Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)', 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '544994eb-ded0-44b9-9540-69dacab80770'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '544994eb-ded0-44b9-9540-69dacab80770'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Back to camp!… Go at once!” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '544994eb-ded0-44b9-9540-69dacab80770'
);


-- None Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)', 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93ad2e2f-aa2f-4f78-9dad-30f831848ccf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93ad2e2f-aa2f-4f78-9dad-30f831848ccf'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Being in love is not a reason” (Dancaïre, Carmen, Frasquita, Mercédès, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93ad2e2f-aa2f-4f78-9dad-30f831848ccf'
);


-- None Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)', 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a9124e7-47a6-4920-ab9e-232317e86590'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a9124e7-47a6-4920-ab9e-232317e86590'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Bravo! bravo! More! Keep dancing!” (Zuniga, Frasquita, Mercédès, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a9124e7-47a6-4920-ab9e-232317e86590'
);


-- None Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)', 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cb3a2c-7205-4051-9a8a-e97e8e057928'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92cb3a2c-7205-4051-9a8a-e97e8e057928'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “From far away mysterious sounds” (Carmen, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cb3a2c-7205-4051-9a8a-e97e8e057928'
);


-- None Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)', 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4918ca1b-c839-45ba-99f9-a65287414a12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4918ca1b-c839-45ba-99f9-a65287414a12'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Hello! Carmen!” (Zuniga, Don José, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4918ca1b-c839-45ba-99f9-a65287414a12'
);


-- None Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)', 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58e685dd-b813-4f2d-b066-088f130792a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58e685dd-b813-4f2d-b066-088f130792a4'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Hurrah! Hurrah! The Torero!” (Friends of Escamillo)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58e685dd-b813-4f2d-b066-088f130792a4'
);


-- None Carmen: Act II. “La la la la la la la…” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)', 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf4306f-fbbd-48e1-a7c5-57b1b05939d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6cf4306f-fbbd-48e1-a7c5-57b1b05939d9'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “La la la la la la la…” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf4306f-fbbd-48e1-a7c5-57b1b05939d9'
);


-- None Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)', 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52256ae8-bc72-40e9-8fd8-18698c5f4771'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52256ae8-bc72-40e9-8fd8-18698c5f4771'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Lieutenant fair, it’s true” (Carmen, Remendado, Dancaïre, Gipsies, Zuniga, Don José, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52256ae8-bc72-40e9-8fd8-18698c5f4771'
);


-- None Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)', 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b891214-75d0-4c1b-a45b-884648be346a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b891214-75d0-4c1b-a45b-884648be346a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “No, it’s not love at all!” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b891214-75d0-4c1b-a45b-884648be346a'
);


-- None Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)', 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16aba3b8-cd50-4657-834b-a26d21fa1eb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16aba3b8-cd50-4657-834b-a26d21fa1eb2'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “That flow’r you threw to me I treasured” (Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16aba3b8-cd50-4657-834b-a26d21fa1eb2'
);


-- None Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09ebc619-d7b8-400a-a6eb-2f1d1c49424b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09ebc619-d7b8-400a-a6eb-2f1d1c49424b'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “The sky above the open road” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09ebc619-d7b8-400a-a6eb-2f1d1c49424b'
);


-- None Carmen: Act II. “There’s a little job that we're starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)', 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a35f3b1-5fdb-496c-8879-e1cc69c7ea50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a35f3b1-5fdb-496c-8879-e1cc69c7ea50'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “There’s a little job that we''re starting!” (Dancaïre, Mercédès, Frasquita, Remendado, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a35f3b1-5fdb-496c-8879-e1cc69c7ea50'
);


-- None Carmen: Act II. “To bid you welcome to our bar” (Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)', 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b09239d2-ba4a-432b-9fb2-f9e8cb67591d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b09239d2-ba4a-432b-9fb2-f9e8cb67591d'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “To bid you welcome to our bar” (Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b09239d2-ba4a-432b-9fb2-f9e8cb67591d'
);


-- None Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)', 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7edaa80d-9c20-4b20-ae13-437f128c1bef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7edaa80d-9c20-4b20-ae13-437f128c1bef'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Toreador, be ready!” (Friends of Escamillo)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7edaa80d-9c20-4b20-ae13-437f128c1bef'
);


-- None Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)', 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9576baa7-a289-4962-b2ff-177903f946db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9576baa7-a289-4962-b2ff-177903f946db'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “We’ll come with you, Señor Torero” (Zuniga, Escamillo, Friends of Escamillo, Carmen, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9576baa7-a289-4962-b2ff-177903f946db'
);


-- None Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)', 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4201a997-a084-4235-8f0d-254a7c500d12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4201a997-a084-4235-8f0d-254a7c500d12'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “Who’s that? — It’s Escamillo, the bullfighter from Granada” (Zuniga, Frasquita, Friends of Escamillo)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4201a997-a084-4235-8f0d-254a7c500d12'
);


-- None Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)', 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e28ee83-01f0-4192-b82c-6dc5494f5cd5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e28ee83-01f0-4192-b82c-6dc5494f5cd5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act II. “You’re most kind” (Escamillo, Frasquita, Mercédès, Carmen, Moralès, Zuniga, Officers, Friends of Escamillo)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e28ee83-01f0-4192-b82c-6dc5494f5cd5'
);


-- None Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)', 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb41674e-3ce9-4682-bf50-4883cc24b422'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb41674e-3ce9-4682-bf50-4883cc24b422'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Alas! José, your mother is ill” (Micaëla, Don José, Escamillo)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb41674e-3ce9-4682-bf50-4883cc24b422'
);


-- None Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)', 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66efe409-7330-4842-944c-5e59d7cc19db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66efe409-7330-4842-944c-5e59d7cc19db'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “As for that man, it should be easy!” (Frasquita, Mercédès, Carmen, Gipsies, Remendado, Dancaïre)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66efe409-7330-4842-944c-5e59d7cc19db'
);


-- None Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)', 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34a6ce33-7717-4803-ab64-100977272d5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34a6ce33-7717-4803-ab64-100977272d5a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Escamillo is my name, and I come from Granada” (Escamillo, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34a6ce33-7717-4803-ab64-100977272d5a'
);


-- None Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)', 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52cdc016-2dae-404e-bc7f-13d90bdf8df5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52cdc016-2dae-404e-bc7f-13d90bdf8df5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Holà! holà! José!” (Carmen, Escamillo, Dancaïre)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52cdc016-2dae-404e-bc7f-13d90bdf8df5'
);


-- None Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)', 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7789a04-d1fd-4495-a760-ce698e01f53b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7789a04-d1fd-4495-a760-ce698e01f53b'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “I say that there’s nothing to fear” (Micaëla)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7789a04-d1fd-4495-a760-ce698e01f53b'
);


-- None Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)', 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be293e88-55ad-4aaa-bd80-db61c97cfddb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be293e88-55ad-4aaa-bd80-db61c97cfddb'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “In vain you would avoid the bitter things they’re saying” (Carmen, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be293e88-55ad-4aaa-bd80-db61c97cfddb'
);


-- None Carmen: Act III. “Is this the place?” (Micaëla, Guide)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)', 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99312ba3-f497-4a72-a970-5ffedea993e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99312ba3-f497-4a72-a970-5ffedea993e7'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Is this the place?” (Micaëla, Guide)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99312ba3-f497-4a72-a970-5ffedea993e7'
);


-- None Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)', 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3331672e-852a-4d8e-bf5c-479426dd316f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3331672e-852a-4d8e-bf5c-479426dd316f'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “It’s him! I’m sure it’s him over there!” (Micaëla, Escamillo, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3331672e-852a-4d8e-bf5c-479426dd316f'
);


-- None Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fd671b1-33f4-4f77-9133-81fe1ffddac9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fd671b1-33f4-4f77-9133-81fe1ffddac9'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Keep going, dear old friend keep going!” (Gipsies, Frasquita, Mercédès, Carmen, Don José, Remendado, Dancaïre)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fd671b1-33f4-4f77-9133-81fe1ffddac9'
);


-- None Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)', 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d0ce62-eff1-45c3-82ff-13b8eada28a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58d0ce62-eff1-45c3-82ff-13b8eada28a8'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Right! Let’s stop for a while” (Dancaïre, Don José, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d0ce62-eff1-45c3-82ff-13b8eada28a8'
);


-- None Carmen: Act III. “She had a lover here” (Escamillo, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)', 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74dbce55-e99d-450b-b9db-ffe1684d5504'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74dbce55-e99d-450b-b9db-ffe1684d5504'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “She had a lover here” (Escamillo, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74dbce55-e99d-450b-b9db-ffe1684d5504'
);


-- None Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)', 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cf07935-a01a-4b94-8ee1-86eef12ef76a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8cf07935-a01a-4b94-8ee1-86eef12ef76a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “Shuffle! Cut them!” (Frasquita, Mercédès, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cf07935-a01a-4b94-8ee1-86eef12ef76a'
);


-- None Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)', 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “You should take care, Carmen” (Don José, Dancaïre, Gipsies, Remendado, Carmen, Micaëla, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21570d96-0bf4-4dfe-8d0a-4e2cbe528a4b'
);


-- None Carmen: Act III. “You're back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)', 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '269cfb91-988a-4905-8b21-dd1bb9a4aed2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '269cfb91-988a-4905-8b21-dd1bb9a4aed2'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act III. “You''re back!” (Frasquita, Dancaïre, Mercédès, Carmen, Remendado, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '269cfb91-988a-4905-8b21-dd1bb9a4aed2'
);


-- None Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)', 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81e3cbef-73d4-42c5-ad9a-3e25ecd4873d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81e3cbef-73d4-42c5-ad9a-3e25ecd4873d'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act IV. “A few cuartos! A few cuartos!” (Merchants, Vendors, Zuniga, An Orange Vendor, A Gipsy)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81e3cbef-73d4-42c5-ad9a-3e25ecd4873d'
);


-- None Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)', 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a45801c-6aac-4d58-aeaf-dc66c29094fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a45801c-6aac-4d58-aeaf-dc66c29094fa'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act IV. “Here they come! Here they come!” (Children, Merchants, Vendors, Crowd)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a45801c-6aac-4d58-aeaf-dc66c29094fa'
);


-- None Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)', 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fca30d89-519e-4caa-b2c5-a57c4d7629fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fca30d89-519e-4caa-b2c5-a57c4d7629fd'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act IV. “If you love me, Carmen” (Escamillo, Carmen, Cordeliers, Frasquita, Mercédès)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fca30d89-519e-4caa-b2c5-a57c4d7629fd'
);


-- None Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)', 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d2b42c7-8a3e-4689-9d88-777c497978ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d2b42c7-8a3e-4689-9d88-777c497978ea'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act IV. “It’s you! — It’s me!” (Carmen, Don José)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d2b42c7-8a3e-4689-9d88-777c497978ea'
);


-- None Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)', 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c367187-8029-4fff-932f-27f1727079c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c367187-8029-4fff-932f-27f1727079c5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Carmen: Act IV. “Viva!, Viva! What a corrida!” (Crowd, Don José, Carmen)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c367187-8029-4fff-932f-27f1727079c5'
);


-- None Die Perlenfischer: Akt I. „Das Glück, das große Glück“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Das Glück, das große Glück“', 'Die Perlenfischer: Akt I. „Das Glück, das große Glück“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Das Glück, das große Glück“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b0174b9-7653-49a7-878f-441281282ca8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b0174b9-7653-49a7-878f-441281282ca8'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Das Glück, das große Glück“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b0174b9-7653-49a7-878f-441281282ca8'
);


-- None Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“', 'Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a35d972-8a67-4cd7-8608-be65afd22347'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a35d972-8a67-4cd7-8608-be65afd22347'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Der Himmel schuf die Perlen“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a35d972-8a67-4cd7-8608-be65afd22347'
);


-- None Die Perlenfischer: Akt I. „Hier ist der Tempel“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Hier ist der Tempel“', 'Die Perlenfischer: Akt I. „Hier ist der Tempel“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Hier ist der Tempel“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88b0b6b2-c79a-4318-a020-df0ec3aa8572'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88b0b6b2-c79a-4318-a020-df0ec3aa8572'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Hier ist der Tempel“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88b0b6b2-c79a-4318-a020-df0ec3aa8572'
);


-- None Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“', 'Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27e13f07-dbce-4aac-896b-b23ad3beab3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27e13f07-dbce-4aac-896b-b23ad3beab3c'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Höre Leila, was ich nun fragen muß“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27e13f07-dbce-4aac-896b-b23ad3beab3c'
);


-- None Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“', 'Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2c29407-3987-4356-af90-9974e574bd09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2c29407-3987-4356-af90-9974e574bd09'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Im Tempel Brahmas kniet“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2c29407-3987-4356-af90-9974e574bd09'
);


-- None Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“', 'Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f2561b0-9ad0-423f-9a7d-d9b5ffac140a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f2561b0-9ad0-423f-9a7d-d9b5ffac140a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Komm’, süßer Sonne Licht“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f2561b0-9ad0-423f-9a7d-d9b5ffac140a'
);


-- None Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“', 'Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb20e5db-2b54-4d3b-9ace-0741a75a335e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb20e5db-2b54-4d3b-9ace-0741a75a335e'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Mein Freund, du, sei gegrüßt“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb20e5db-2b54-4d3b-9ace-0741a75a335e'
);


-- None Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“', 'Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c02eba7-96fe-466a-9360-7c73de9dd50f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c02eba7-96fe-466a-9360-7c73de9dd50f'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Nadir, es lichtet sich der Platz“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c02eba7-96fe-466a-9360-7c73de9dd50f'
);


-- None Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“', 'Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c61bc1e2-38a3-46ba-955f-994f2a08cd68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c61bc1e2-38a3-46ba-955f-994f2a08cd68'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „O Freude! Ihr Schiff, es kommt!“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c61bc1e2-38a3-46ba-955f-994f2a08cd68'
);


-- None Die Perlenfischer: Akt I. „Seht hin, sie ist es“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Seht hin, sie ist es“', 'Die Perlenfischer: Akt I. „Seht hin, sie ist es“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Seht hin, sie ist es“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb57ae37-d35a-42bc-80e2-c6b18c89dce9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb57ae37-d35a-42bc-80e2-c6b18c89dce9'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Seht hin, sie ist es“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb57ae37-d35a-42bc-80e2-c6b18c89dce9'
);


-- None Die Perlenfischer: Akt I. „Sei uns gegrüßt!“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Sei uns gegrüßt!“', 'Die Perlenfischer: Akt I. „Sei uns gegrüßt!“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Sei uns gegrüßt!“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51802322-48f0-4644-9598-8b53bf6db3a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51802322-48f0-4644-9598-8b53bf6db3a9'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Sei uns gegrüßt!“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51802322-48f0-4644-9598-8b53bf6db3a9'
);


-- None Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“', 'Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1be486aa-b579-48a9-8e42-e927306c78a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1be486aa-b579-48a9-8e42-e927306c78a7'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt I. „Wo des Morgens Grau’n“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1be486aa-b579-48a9-8e42-e927306c78a7'
);


-- None Die Perlenfischer: Akt II. Entr’acte

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. Entr’acte', 'Die Perlenfischer: Akt II. Entr’acte', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. Entr’acte'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfef6eed-24df-4ecb-b399-c9239196a719'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfef6eed-24df-4ecb-b399-c9239196a719'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. Entr’acte' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfef6eed-24df-4ecb-b399-c9239196a719'
);


-- None Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“', 'Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03121e1-d08a-4da2-9d2b-e7332088b3ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f03121e1-d08a-4da2-9d2b-e7332088b3ec'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Das letzte Schiff ist nun verankert“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03121e1-d08a-4da2-9d2b-e7332088b3ec'
);


-- None Die Perlenfischer: Akt II. „Der Abend bricht an“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Der Abend bricht an“', 'Die Perlenfischer: Akt II. „Der Abend bricht an“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Der Abend bricht an“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f13599-2cda-41aa-a505-31aeb2fc9b9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29f13599-2cda-41aa-a505-31aeb2fc9b9f'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Der Abend bricht an“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f13599-2cda-41aa-a505-31aeb2fc9b9f'
);


-- None Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“', 'Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff60fe81-b53d-411e-9cbd-c5ef322a9ffe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff60fe81-b53d-411e-9cbd-c5ef322a9ffe'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Ein Opfer ist der Liebe Pfand“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff60fe81-b53d-411e-9cbd-c5ef322a9ffe'
);


-- None Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“', 'Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3daad71-9ab0-419f-a801-476fec1a05d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3daad71-9ab0-419f-a801-476fec1a05d5'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Hin, zu ihr! Leila!“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3daad71-9ab0-419f-a801-476fec1a05d5'
);


-- None Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“', 'Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a7b1485-c5e5-43fc-9933-ae0d500a7b6a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a7b1485-c5e5-43fc-9933-ae0d500a7b6a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Hör’ mich, o Brahma!“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a7b1485-c5e5-43fc-9933-ae0d500a7b6a'
);


-- None Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“', 'Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f44adcc2-3033-48c6-88ff-434d0a050964'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f44adcc2-3033-48c6-88ff-434d0a050964'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Leila, träume, träume von Blumen“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f44adcc2-3033-48c6-88ff-434d0a050964'
);


-- None Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“', 'Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f322724-05ba-4fed-b368-152e903e4a8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f322724-05ba-4fed-b368-152e903e4a8a'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt II. „Nun wird es einsam um mich her“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f322724-05ba-4fed-b368-152e903e4a8a'
);


-- None Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“', 'Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e0b5cac-f747-4c94-9a9d-2c44a7e05adf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e0b5cac-f747-4c94-9a9d-2c44a7e05adf'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Ach, wie find’ ich rechte Worte“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e0b5cac-f747-4c94-9a9d-2c44a7e05adf'
);


-- None Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“', 'Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7eab1f0f-c964-4f39-b01a-3c84eb43e1b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7eab1f0f-c964-4f39-b01a-3c84eb43e1b4'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Die Stimme ihres Fleh’ns“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7eab1f0f-c964-4f39-b01a-3c84eb43e1b4'
);


-- None Die Perlenfischer: Akt III. „Haltet ein!“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Haltet ein!“', 'Die Perlenfischer: Akt III. „Haltet ein!“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Haltet ein!“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f86f004-ce6f-4533-89cb-d370ead71592'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f86f004-ce6f-4533-89cb-d370ead71592'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Haltet ein!“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f86f004-ce6f-4533-89cb-d370ead71592'
);


-- None Die Perlenfischer: Akt III. „Leila, Liebste, du“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Leila, Liebste, du“', 'Die Perlenfischer: Akt III. „Leila, Liebste, du“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Leila, Liebste, du“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ead843bd-d190-4c79-8b39-9b22e5a23b71'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ead843bd-d190-4c79-8b39-9b22e5a23b71'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Leila, Liebste, du“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ead843bd-d190-4c79-8b39-9b22e5a23b71'
);


-- None Die Perlenfischer: Akt III. „Sie kommt zu mir“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Sie kommt zu mir“', 'Die Perlenfischer: Akt III. „Sie kommt zu mir“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Sie kommt zu mir“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '093168b3-90eb-46b3-bd73-658e588b4803'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '093168b3-90eb-46b3-bd73-658e588b4803'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Sie kommt zu mir“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '093168b3-90eb-46b3-bd73-658e588b4803'
);


-- None Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“', 'Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fb98dfa-fe7a-4ce6-a580-47308e7d8625'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9fb98dfa-fe7a-4ce6-a580-47308e7d8625'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Was ich fühl’ darf sie niemals wissen“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fb98dfa-fe7a-4ce6-a580-47308e7d8625'
);


-- None Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“', 'Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca8c9a22-ea38-4f12-8de8-fd35501ad771'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca8c9a22-ea38-4f12-8de8-fd35501ad771'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = 'Die Perlenfischer: Akt III. „Zurga, Flut! Die Springflut des Meers“' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca8c9a22-ea38-4f12-8de8-fd35501ad771'
);


-- None 가곡 <La Nuit, WD 100>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Nuit, WD 100>', 'La Nuit, WD 100', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Nuit, WD 100>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13455d61-1491-4b1e-87f4-789fd30cfad2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13455d61-1491-4b1e-87f4-789fd30cfad2'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '가곡 <La Nuit, WD 100>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13455d61-1491-4b1e-87f4-789fd30cfad2'
);


-- None 오페라 <Les Pêcheurs de perles>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Les Pêcheurs de perles>', 'Les Pêcheurs de perles', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Les Pêcheurs de perles>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd0dc53-ec99-41d7-a061-9d1e10220b9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dd0dc53-ec99-41d7-a061-9d1e10220b9b'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd0dc53-ec99-41d7-a061-9d1e10220b9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd1fe28-fda6-3a3e-b61d-334b5cb19577', 1, NULL, 'Prélude', 'Les Pêcheurs de perles : Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd1fe28-fda6-3a3e-b61d-334b5cb19577'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c', 2, NULL, 'Acte I', 'Les Pêcheurs de perles : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d09a7d6-ffaf-3817-bc87-1e01002bcfe4', 1, NULL, 'Acte I. No. 1 Introduction « Sur la grève en feu » (Chœur)', 'Les Pêcheurs de perles : Acte I. No. 1 Introduction « Sur la grève en feu » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d09a7d6-ffaf-3817-bc87-1e01002bcfe4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70e5e835-be7b-3a05-b973-fdf169f41b41', 2, NULL, 'Acte I. No. 1 Scène et chœur « Amis, interrompez vos danses … » (Zurga, Nadir, Chœur)', 'Les Pêcheurs de perles : Acte I. No. 1 Scène et chœur « Amis, interrompez vos danses … » (Zurga, Nadir, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e5e835-be7b-3a05-b973-fdf169f41b41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:959938d2-bc8e-4bf8-b974-897118e5d56e', 3, NULL, 'Acte I. No. 1 Récit « Mais qui vient la ? » (Chœur, Zurga, Nadir)', 'Les Pêcheurs de perles : Acte I. No. 1 Récit « Mais qui vient la ? » (Chœur, Zurga, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:959938d2-bc8e-4bf8-b974-897118e5d56e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:762b3f5e-fa0a-4f7c-a3a2-c8103c6161ca', 4, NULL, 'Acte I. No. 1 Couplet « Des savanes et des forêts » (Nadir)', 'Les Pêcheurs de perles : Acte I. No. 1 Couplet « Des savanes et des forêts » (Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:762b3f5e-fa0a-4f7c-a3a2-c8103c6161ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d23b3461-409e-3bb3-a69f-e6eec3a415ee', 5, NULL, 'Acte I. Récit et reprise du chœur dansé « Demeure parmi nous, Nadir » (Zurga, Nadir, Chœur)', 'Les Pêcheurs de perles : Acte I. Récit et reprise du chœur dansé « Demeure parmi nous, Nadir » (Zurga, Nadir, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d23b3461-409e-3bb3-a69f-e6eec3a415ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0fdc6124-6a3b-3b4b-8a74-14670d1c92bb', 6, NULL, 'Acte I. No. 2 Récit « C’est toi, toi qu’enfin je revois ! » (Zurga, Nadir)', 'Les Pêcheurs de perles : Acte I. No. 2 Récit « C’est toi, toi qu’enfin je revois ! » (Zurga, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fdc6124-6a3b-3b4b-8a74-14670d1c92bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0423255f-585c-3c7c-bdbd-b578b004c81e', 7, NULL, 'Acte I. No. 2 Duo « Au fond du temple saint » (Zurga, Nadir)', 'Les Pêcheurs de perles : Acte I. No. 2 Duo « Au fond du temple saint » (Zurga, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0423255f-585c-3c7c-bdbd-b578b004c81e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33d7bec4-77c9-424c-99b3-85164b04a386', 8, NULL, 'Acte I. No. 2 « Amitié sainte » (Zurga, Nadir)', 'Les Pêcheurs de perles : Acte I. No. 2 « Amitié sainte » (Zurga, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d7bec4-77c9-424c-99b3-85164b04a386'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75d05df6-0854-37b0-8a15-7fac84f30834', 9, NULL, 'Acte I. No. 3 Récit « Que vois-je ? » (Zurga, Nadir)', 'Les Pêcheurs de perles : Acte I. No. 3 Récit « Que vois-je ? » (Zurga, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75d05df6-0854-37b0-8a15-7fac84f30834'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddd59aac-1d07-4b4c-a358-b1c5442de1b9', 10, NULL, 'Acte I. No. 3 « C''est elle, la voici » (Chœur)', 'Les Pêcheurs de perles : Acte I. No. 3 « C''est elle, la voici » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd59aac-1d07-4b4c-a358-b1c5442de1b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7843bd6-e71f-31be-a6ad-c500355a3893', 11, NULL, 'Acte I. Chœur « Elle vient ... Sois la bienvenue » (Chœur)', 'Les Pêcheurs de perles : Acte I. Chœur « Elle vient ... Sois la bienvenue » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7843bd6-e71f-31be-a6ad-c500355a3893'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07d81ecc-01dc-3840-aed9-56d26d7f9414', 12, NULL, 'Acte I. No. 3 Scène et chœur « Seule au milieu de nous » (Zurga, Leïla, Chœur)', 'Les Pêcheurs de perles : Acte I. No. 3 Scène et chœur « Seule au milieu de nous » (Zurga, Leïla, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d81ecc-01dc-3840-aed9-56d26d7f9414'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13dd9892-1fbf-478f-9d37-4c5475a60b97', 13, NULL, 'Acte I. « Qu’as‐tu donc ? » (Zurga, Leïla, Nadir, chœur)', 'Les Pêcheurs de perles : Acte I. « Qu’as‐tu donc ? » (Zurga, Leïla, Nadir, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13dd9892-1fbf-478f-9d37-4c5475a60b97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d06fc0f6-f9f9-3f63-8bb6-6557c030ff9a', 14, NULL, 'Acte I. No. 4 Récit « À cette voix quel trouble » (Nadir)', 'Les Pêcheurs de perles : Acte I. No. 4 Récit « À cette voix quel trouble » (Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d06fc0f6-f9f9-3f63-8bb6-6557c030ff9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d7800a0-657a-32b1-b586-e7013b4841c5', 15, NULL, 'Acte I. No. 4 Romance « Je crois entendre encore » (Nadir)', 'Les Pêcheurs de perles : Acte I. No. 4 Romance « Je crois entendre encore » (Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7800a0-657a-32b1-b586-e7013b4841c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0263a395-1e24-3968-8770-f05f574c6d84', 16, NULL, 'Acte I. No. 5 Chœur et récit « Le ciel est bleu » (Nadir, Nourabad, Chœur)', 'Les Pêcheurs de perles : Acte I. No. 5 Chœur et récit « Le ciel est bleu » (Nadir, Nourabad, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0263a395-1e24-3968-8770-f05f574c6d84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2ea96fe-b9b3-3d61-a33f-00484187fcf4', 17, NULL, 'Acte I. Air et chœur "Ô Dieu Brahma !" (Leïla, Nadir, Chœur)', 'Les Pêcheurs de perles : Acte I. Air et chœur "Ô Dieu Brahma !" (Leïla, Nadir, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1adef64f-1ab0-428e-a7a1-bd5a2db8914c'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2ea96fe-b9b3-3d61-a33f-00484187fcf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc', 3, NULL, 'Acte II', 'Les Pêcheurs de perles : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:397e30d4-8e41-3949-8b43-ec590294422b', 1, NULL, 'Acte II. No. 6 Entracte, scène et chœur « L''ombre descend des cieux » (Leïla, Nourabad, chœur)', 'Les Pêcheurs de perles : Acte II. No. 6 Entracte, scène et chœur « L''ombre descend des cieux » (Leïla, Nourabad, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397e30d4-8e41-3949-8b43-ec590294422b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f5b7db1-e3a5-47a3-804e-9d367fa230cd', 2, NULL, 'Acte II. No. 6 Scène « Les barques ont regagné la grève » (Chœur, Leïla, Nourabad)', 'Les Pêcheurs de perles : Acte II. No. 6 Scène « Les barques ont regagné la grève » (Chœur, Leïla, Nourabad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f5b7db1-e3a5-47a3-804e-9d367fa230cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4a2be50-ffd3-4a3d-90b0-d6d1f5aafba7', 3, NULL, 'Acte II. « J’étais encore enfant » (Leïla, Nourabad, chœur)', 'Les Pêcheurs de perles : Acte II. « J’étais encore enfant » (Leïla, Nourabad, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a2be50-ffd3-4a3d-90b0-d6d1f5aafba7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01dbfbf2-fac0-3ed6-b4cd-0ee0745c3d01', 4, NULL, 'Acte II. No. 7 Récit et cavatine « Me voilà seule dans la nuit » (Leïla)', 'Les Pêcheurs de perles : Acte II. No. 7 Récit et cavatine « Me voilà seule dans la nuit » (Leïla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01dbfbf2-fac0-3ed6-b4cd-0ee0745c3d01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c1f2589-1607-314f-9eff-5d7337429405', 5, NULL, 'Acte II. No. 8 Chanson « De mon amie » (Nadir, Leïla)', 'Les Pêcheurs de perles : Acte II. No. 8 Chanson « De mon amie » (Nadir, Leïla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1f2589-1607-314f-9eff-5d7337429405'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5595b9f4-e799-3476-b6de-9affae70ea5a', 6, NULL, 'Acte II. No. 9 Duo « Leïla ! Dieu puissant » (Nadir, Leïla)', 'Les Pêcheurs de perles : Acte II. No. 9 Duo « Leïla ! Dieu puissant » (Nadir, Leïla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5595b9f4-e799-3476-b6de-9affae70ea5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3b0d4a2-c278-43e3-8ce3-06a9b5352675', 7, NULL, 'Acte II. Duo « Ton cœur n’as pas compris le mien » (Leïla, Nadir)', 'Les Pêcheurs de perles : Acte II. Duo « Ton cœur n’as pas compris le mien » (Leïla, Nadir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b0d4a2-c278-43e3-8ce3-06a9b5352675'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcc0ca7b-c9b4-3cbd-84bf-4dc116174459', 8, NULL, 'Acte II. No. 10 Final (début) « Ah ! Revenez à la raison » (Leïla, Nadir, Nourabad, Chœur)', 'Les Pêcheurs de perles : Acte II. No. 10 Final (début) « Ah ! Revenez à la raison » (Leïla, Nadir, Nourabad, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc0ca7b-c9b4-3cbd-84bf-4dc116174459'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:313e7be9-3638-371f-a0ae-b5ee3caf037d', 9, NULL, 'Acte II. No. 10 Final (fin) "Arrêtez ! C''est à moi d''ordonner" (Zurga, Leïla, Nourabad, chœur)', 'Les Pêcheurs de perles : Acte II. No. 10 Final (fin) "Arrêtez ! C''est à moi d''ordonner" (Zurga, Leïla, Nourabad, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:041331c2-5dfc-4c23-9eaf-a57c3b8369dc'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313e7be9-3638-371f-a0ae-b5ee3caf037d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b', 4, NULL, 'Acte III', 'Les Pêcheurs de perles: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e86f305e-4305-3105-af15-1a26b170b70a', 1, NULL, 'Acte III. No. 11 Entracte, récit et air « L''Orage s''est calmé » ... « Ô Nadir, tendre ami » (Zurga)', 'Les Pêcheurs de perles : Acte III. No. 11 Entracte, récit et air « L''Orage s''est calmé » ... « Ô Nadir, tendre ami » (Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e86f305e-4305-3105-af15-1a26b170b70a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4bf2bab-a7cd-33a4-86d8-c415a0c10d2c', 2, NULL, 'Acte III. No. 12 Duo « Je frémis, je chancelle » (Leïla, Zurga)', 'Les Pêcheurs de perles : Acte III. No. 12 Duo « Je frémis, je chancelle » (Leïla, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4bf2bab-a7cd-33a4-86d8-c415a0c10d2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28121cd5-7ab4-49e9-8397-12f20cc8e19c', 3, NULL, 'Acte III. « Quoi ! Innocent ? » (Leïla, Zurga)', 'Les Pêcheurs de perles : Acte III. « Quoi ! Innocent ? » (Leïla, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28121cd5-7ab4-49e9-8397-12f20cc8e19c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80cc3fe2-20ff-4491-9074-6d333907c522', 4, NULL, 'Acte III. « Je suis jaloux ! » (Zurga, Leïla)', 'Les Pêcheurs de perles : Acte III. « Je suis jaloux ! » (Zurga, Leïla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80cc3fe2-20ff-4491-9074-6d333907c522'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a774844-3b43-3bd2-b3cf-f45c4dae56b3', 5, NULL, 'Acte III. No. 12 Scène « Entends au loin ... » (Nourabad, Leïla, Zurga)', 'Les Pêcheurs de perles : Acte III. No. 12 Scène « Entends au loin ... » (Nourabad, Leïla, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a774844-3b43-3bd2-b3cf-f45c4dae56b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97f55ffb-e8b7-3791-b48a-cfa7732a4d6c', 6, NULL, 'Acte III. No. 13 Chœur dansé « Dès que le soleil » (Chœur)', 'Les Pêcheurs de perles : Acte III. No. 13 Chœur dansé « Dès que le soleil » (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f55ffb-e8b7-3791-b48a-cfa7732a4d6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7745961e-ef36-3161-9d1f-3426c96cf052', 7, NULL, 'Acte III. Scène et chœur « Sombres divinités » (Nourabad, chœur, Zurga)', 'Les Pêcheurs de perles : Acte III. Scène et chœur « Sombres divinités » (Nourabad, chœur, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7745961e-ef36-3161-9d1f-3426c96cf052'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83d3dcc3-34bc-3abb-897f-29238929b1a3', 8, NULL, 'Acte III. No. 14 Trio « Ô lumière sainte » (Leïla, Nadir, Zurga)', 'Les Pêcheurs de perles : Acte III. No. 14 Trio « Ô lumière sainte » (Leïla, Nadir, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83d3dcc3-34bc-3abb-897f-29238929b1a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37e26ee3-5338-4294-a6ef-a153dd519a73', 9, NULL, 'Acte III. No. 14 Scène : « Le jour enfin perce la nue ! » – « Non, ce n''est pas le jour » (Nourabad, chœur, Zurga)', 'Les Pêcheurs de perles : Acte III. No. 14 Scène : « Le jour enfin perce la nue ! » – « Non, ce n''est pas le jour » (Nourabad, chœur, Zurga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37e26ee3-5338-4294-a6ef-a153dd519a73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a6dacf0-3ff3-4f56-9e09-d183a3467d72', 10, NULL, 'Acte III. No. 15 Final : « C''est lui le traitre ! » – « Plus de crainte » (Nourabad, Zurga, Nadir, Leila, chœur)', 'Les Pêcheurs de perles : Acte III. No. 15 Final : « C''est lui le traitre ! » – « Plus de crainte » (Nourabad, Zurga, Nadir, Leila, chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a6dacf0-3ff3-4f56-9e09-d183a3467d72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13523fbb-caf1-3ad7-b5b8-4a4942b6753c', 11, NULL, 'Acte III. No. 16 Final "Ce sont eux, les voici" (Zurga, Nadir, Leïla, Nourabad, Chœur)', 'Les Pêcheurs de perles: Acte III. No. 16 Final "Ce sont eux, les voici" (Zurga, Nadir, Leïla, Nourabad, Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13523fbb-caf1-3ad7-b5b8-4a4942b6753c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dbb597d6-c226-424d-a5d6-937952f0fd64', 12, NULL, 'Acte III. « Qu’ai‐je vu ? Ô ciel, quel trouble ! » (Zurga, Leïla)', 'Les Pêcheurs de perles : Acte III. « Qu’ai‐je vu ? Ô ciel, quel trouble ! » (Zurga, Leïla)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09beba32-9a64-438c-b4d2-dc505fbdc57b'
WHERE p.composer_id = 44 AND p.title = '오페라 <Les Pêcheurs de perles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbb597d6-c226-424d-a5d6-937952f0fd64'
);


-- None 오페라 <L’Arlésienne Suite no. 2: I. Pastorale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L’Arlésienne Suite no. 2: I. Pastorale>', 'L’Arlésienne Suite no. 2: I. Pastorale', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L’Arlésienne Suite no. 2: I. Pastorale>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c9251ec-a0e3-43fa-8933-60b2f2e408a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c9251ec-a0e3-43fa-8933-60b2f2e408a1'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <L’Arlésienne Suite no. 2: I. Pastorale>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c9251ec-a0e3-43fa-8933-60b2f2e408a1'
);


-- None 오페라 <L’Arlésienne Suite no. 2: II. Intermezzo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L’Arlésienne Suite no. 2: II. Intermezzo>', 'L’Arlésienne Suite no. 2: II. Intermezzo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L’Arlésienne Suite no. 2: II. Intermezzo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd8a0e2-dda7-43e2-adad-4a6c5cf6110c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cd8a0e2-dda7-43e2-adad-4a6c5cf6110c'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <L’Arlésienne Suite no. 2: II. Intermezzo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd8a0e2-dda7-43e2-adad-4a6c5cf6110c'
);


-- None 오페라 <L’Arlésienne Suite no. 2: III. Menuet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L’Arlésienne Suite no. 2: III. Menuet>', 'L’Arlésienne Suite no. 2: III. Menuet', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L’Arlésienne Suite no. 2: III. Menuet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4bda5e7-9faf-4652-8a4a-7d3c01f4a80e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4bda5e7-9faf-4652-8a4a-7d3c01f4a80e'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <L’Arlésienne Suite no. 2: III. Menuet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4bda5e7-9faf-4652-8a4a-7d3c01f4a80e'
);


-- None 오페라 <L’Arlésienne Suite no. 2: IV. Farandole>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <L’Arlésienne Suite no. 2: IV. Farandole>', 'L’Arlésienne Suite no. 2: IV. Farandole', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <L’Arlésienne Suite no. 2: IV. Farandole>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70d4ee0d-1ea5-465b-85f5-e09ea39750a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70d4ee0d-1ea5-465b-85f5-e09ea39750a6'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '오페라 <L’Arlésienne Suite no. 2: IV. Farandole>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70d4ee0d-1ea5-465b-85f5-e09ea39750a6'
);


-- None 가곡 <Ouvre ton cœur (Sérénade espagnole)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ouvre ton cœur (Sérénade espagnole)>', 'Ouvre ton cœur (Sérénade espagnole)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ouvre ton cœur (Sérénade espagnole)>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7718148e-6279-4e35-b7b0-dcc2e07492ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7718148e-6279-4e35-b7b0-dcc2e07492ee'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '가곡 <Ouvre ton cœur (Sérénade espagnole)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7718148e-6279-4e35-b7b0-dcc2e07492ee'
);


-- None 가곡 <Voyage, WD 98>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Voyage, WD 98>', 'Voyage, WD 98', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 44
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Voyage, WD 98>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ab1c4c7-8a49-4186-aeda-22a35587957b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ab1c4c7-8a49-4186-aeda-22a35587957b'
FROM pieces p
WHERE p.composer_id = 44 AND p.title = '가곡 <Voyage, WD 98>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ab1c4c7-8a49-4186-aeda-22a35587957b'
);


-- 카탈로그에 대응이 없는 seed 작품 72개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 44 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    490, 657, 11296, 11313, 11342, 11354, 11373, 11380, 11381, 11385, 11392, 11397, 11418, 11423, 11441, 11446, 11451, 11454, 11480, 11486,
    11503, 11529, 11541, 11544, 11556, 11563, 11564, 11577, 11582, 11594, 11596, 11607, 11609, 11618, 11627, 11633, 11639, 11666, 11670, 11679,
    11699, 11700, 11715, 11739, 11744, 11748, 11755, 11760, 11761, 11762, 11778, 11780, 11782, 11798, 11813, 11838, 11856, 11857, 11858, 11874,
    11877, 11890, 11893, 11905, 11906, 11913, 11924, 11958, 11964, 11990, 12001, 12009
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
