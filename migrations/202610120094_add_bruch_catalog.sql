-- 브루흐 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 68개(묶음 13, 다악장 24, 낱곡 31),
-- 새 작품 4개, part 197개, 그 아래 0개.
-- seed 67개 중 62개를 작품·part 에 잇고, 5개를 숨기고, 0개는 그대로 둔다.
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

-- None 12 Schottische Volkslieder

UPDATE pieces piece
SET piece.title = '12 Schottische Volkslieder', piece.title_en = '12 Schottische Volkslieder',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1101 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O sahst du den Vater?', part.name_en = '12 Schottische Volkslieder: No. 6. O sahst du den Vater?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1101 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:85c8ef0a-3da6-46e3-a66a-e3a0a8e28641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c8ef0a-3da6-46e3-a66a-e3a0a8e28641', 1, NULL, 'O sahst du den Vater?', '12 Schottische Volkslieder: No. 6. O sahst du den Vater?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1101 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c8ef0a-3da6-46e3-a66a-e3a0a8e28641'
);


-- Op. 31 2개의 칸타타 Op. 31

UPDATE pieces piece
SET piece.title = '2개의 칸타타 Op. 31', piece.title_en = '2 Cantatas, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2405 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Flucht nach Ägypten, op. 31 no. 1', part.name_en = 'Die Flucht nach Ägypten, op. 31 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2405 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:96894c8d-8425-492d-be99-39f9fe03ed67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96894c8d-8425-492d-be99-39f9fe03ed67', 1, NULL, 'Die Flucht nach Ägypten, op. 31 no. 1', 'Die Flucht nach Ägypten, op. 31 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2405 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96894c8d-8425-492d-be99-39f9fe03ed67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Morgenstunde, op. 31 no. 2', part.name_en = 'Morgenstunde, op. 31 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2405 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0c010a84-3b28-437e-bb22-0370ee250519' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c010a84-3b28-437e-bb22-0370ee250519', 2, NULL, 'Morgenstunde, op. 31 no. 2', 'Morgenstunde, op. 31 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2405 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c010a84-3b28-437e-bb22-0370ee250519'
);


-- Op. 83 8개의 클라리넷 소품 Op. 83

UPDATE pieces piece
SET piece.title = '8개의 클라리넷 소품 Op. 83', piece.title_en = '8 Pieces for Clarinet, Viola and Piano, op. 83',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '83',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2096 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante in A minor', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 1. Andante in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:78264c79-0ea1-37cd-9629-47f3f66c9eca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78264c79-0ea1-37cd-9629-47f3f66c9eca', 1, NULL, 'Andante in A minor', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 1. Andante in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78264c79-0ea1-37cd-9629-47f3f66c9eca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro con moto in B minor', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 2. Allegro con moto in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6f3f2e25-b5af-3c2b-bcbc-66625652f72e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f3f2e25-b5af-3c2b-bcbc-66625652f72e', 2, NULL, 'Allegro con moto in B minor', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 2. Allegro con moto in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f3f2e25-b5af-3c2b-bcbc-66625652f72e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante con moto in C-sharp minor', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 3. Andante con moto in C-sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:fc01c003-21f3-3d5c-8b02-3dd5264bd84e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc01c003-21f3-3d5c-8b02-3dd5264bd84e', 3, NULL, 'Andante con moto in C-sharp minor', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 3. Andante con moto in C-sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc01c003-21f3-3d5c-8b02-3dd5264bd84e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro agitato in D minor', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 4. Allegro agitato in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:e3b9dbd6-a28b-30df-b62d-7a5a3004c461' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3b9dbd6-a28b-30df-b62d-7a5a3004c461', 4, NULL, 'Allegro agitato in D minor', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 4. Allegro agitato in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3b9dbd6-a28b-30df-b62d-7a5a3004c461'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante in F minor "Rumänische Melodie"', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 5. Andante in F minor "Rumänische Melodie"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:08766c84-9764-37f3-b64a-dcaa721d94f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08766c84-9764-37f3-b64a-dcaa721d94f9', 5, NULL, 'Andante in F minor "Rumänische Melodie"', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 5. Andante in F minor "Rumänische Melodie"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08766c84-9764-37f3-b64a-dcaa721d94f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Andante con moto in G minor "Nachtgesang"', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 6. Andante con moto in G minor "Nachtgesang"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9a55720c-db0c-3f6f-9410-7640d0e186d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a55720c-db0c-3f6f-9410-7640d0e186d8', 6, NULL, 'Andante con moto in G minor "Nachtgesang"', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 6. Andante con moto in G minor "Nachtgesang"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a55720c-db0c-3f6f-9410-7640d0e186d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace, ma non troppo in B major', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 7. Allegro vivace, ma non troppo in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:7a2ac519-6203-3b61-98fc-104f58e54f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a2ac519-6203-3b61-98fc-104f58e54f6c', 7, NULL, 'Allegro vivace, ma non troppo in B major', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 7. Allegro vivace, ma non troppo in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a2ac519-6203-3b61-98fc-104f58e54f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Moderato in E-flat minor', part.name_en = '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 8. Moderato in E-flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2096 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:7a8ec61d-817b-3cf5-a07f-e87e94123bbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a8ec61d-817b-3cf5-a07f-e87e94123bbf', 8, NULL, 'Moderato in E-flat minor', '8 Pieces for Clarinet, Viola and Piano, op. 83: No. 8. Moderato in E-flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2096 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a8ec61d-817b-3cf5-a07f-e87e94123bbf'
);


-- Op. 57 Adagio appassionato

UPDATE pieces piece
SET piece.title = 'Adagio appassionato', piece.title_en = 'Adagio appassionato, op. 57',
    piece.type = 'song', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2465 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 56 Adagio on Celtic Themes

UPDATE pieces piece
SET piece.title = 'Adagio on Celtic Themes', piece.title_en = 'Adagio on Celtic Themes, op. 56',
    piece.type = 'song', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1028 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 No. 1 가곡 <Altes Lied>

UPDATE pieces piece
SET piece.title = '가곡 <Altes Lied>', piece.title_en = 'Altes Lied, op. 7 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 7 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2290 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 No. 3 가곡 <An den Jesusknaben>

UPDATE pieces piece
SET piece.title = '가곡 <An den Jesusknaben>', piece.title_en = 'An den Jesusknaben, op. 17 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 17 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1847 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 No. 1 가곡 <An die heilige Jungfrau>

UPDATE pieces piece
SET piece.title = '가곡 <An die heilige Jungfrau>', piece.title_en = 'An die heilige Jungfrau, op. 17 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 17 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2882 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 No. 3 가곡 <An die heilige Jungfrau> Op. 18 No. 3

UPDATE pieces piece
SET piece.title = '가곡 <An die heilige Jungfrau> Op. 18 No. 3', piece.title_en = 'An die heilige Jungfrau, op. 18 no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18 No. 3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1308 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 88a Concerto for Two Pianos and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Two Pianos and Orchestra', piece.title_en = 'Concerto for Two Pianos and Orchestra, op. 88a',
    piece.type = 'album', piece.opus_number = 'Op. 88a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 554 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Concerto for Two Pianos and Orchestra, op. 88a: I. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 554 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a33a6998-939f-3c12-b773-9bc84f9a3bb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a33a6998-939f-3c12-b773-9bc84f9a3bb9', 1, 'I', 'Andante sostenuto', 'Concerto for Two Pianos and Orchestra, op. 88a: I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 554 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a33a6998-939f-3c12-b773-9bc84f9a3bb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto; Allegro molto vivace', part.name_en = 'Concerto for Two Pianos and Orchestra, op. 88a: II. Andante con moto; Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 554 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:05ecf4c3-a8f4-354f-9e32-71514625af8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ecf4c3-a8f4-354f-9e32-71514625af8f', 2, 'II', 'Andante con moto; Allegro molto vivace', 'Concerto for Two Pianos and Orchestra, op. 88a: II. Andante con moto; Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 554 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ecf4c3-a8f4-354f-9e32-71514625af8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'Concerto for Two Pianos and Orchestra, op. 88a: III. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 554 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:fbac1d6d-dffb-3e9d-ac2b-85a0f0ac475d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbac1d6d-dffb-3e9d-ac2b-85a0f0ac475d', 3, 'III', 'Adagio ma non troppo', 'Concerto for Two Pianos and Orchestra, op. 88a: III. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 554 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbac1d6d-dffb-3e9d-ac2b-85a0f0ac475d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante; Allegro', part.name_en = 'Concerto for Two Pianos and Orchestra, op. 88a: IV. Andante; Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 554 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0724f500-6fcf-344d-acf9-0b16e4e0b363' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0724f500-6fcf-344d-acf9-0b16e4e0b363', 4, 'IV', 'Andante; Allegro', 'Concerto for Two Pianos and Orchestra, op. 88a: IV. Andante; Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 554 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0724f500-6fcf-344d-acf9-0b16e4e0b363'
);


-- Op. 88 Concerto for violin & viola

UPDATE pieces piece
SET piece.title = 'Concerto for violin & viola', piece.title_en = 'Concerto for violin & viola, op. 88',
    piece.type = 'song', piece.opus_number = 'Op. 88',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2945 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 52 오라토리오 <Das Feuerkreuz>

UPDATE pieces piece
SET piece.title = '오라토리오 <Das Feuerkreuz>', piece.title_en = 'Das Feuerkreuz, op. 52',
    piece.type = 'song', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2255 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 칸타타 <Das Lied von der Glocke>

UPDATE pieces piece
SET piece.title = '칸타타 <Das Lied von der Glocke>', piece.title_en = 'Das Lied von der Glocke, op. 45',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2502 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Einleitung', part.name_en = 'Das Lied von der Glocke, op. 45: Einleitung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4b0f7bb2-3dd6-4cf2-bd76-20cfb8c0d33e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0f7bb2-3dd6-4cf2-bd76-20cfb8c0d33e', 1, NULL, 'Einleitung', 'Das Lied von der Glocke, op. 45: Einleitung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0f7bb2-3dd6-4cf2-bd76-20cfb8c0d33e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Festgemauert in der Erden', part.name_en = 'Das Lied von der Glocke, op. 45: I. Festgemauert in der Erden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bc36500a-5254-414e-b8a0-2fedc8c9d391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc36500a-5254-414e-b8a0-2fedc8c9d391', 2, 'I', 'Festgemauert in der Erden', 'Das Lied von der Glocke, op. 45: I. Festgemauert in der Erden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc36500a-5254-414e-b8a0-2fedc8c9d391'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Praeludium. Andante molto sostenuto', part.name_en = 'Das Lied von der Glocke, op. 45: II. Praeludium. Andante molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:ec8bfe63-6ad1-4efa-b316-e28e53e0da5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8bfe63-6ad1-4efa-b316-e28e53e0da5d', 3, 'II', 'Praeludium. Andante molto sostenuto', 'Das Lied von der Glocke, op. 45: II. Praeludium. Andante molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8bfe63-6ad1-4efa-b316-e28e53e0da5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Denn mit der Freude Feierklange', part.name_en = 'Das Lied von der Glocke, op. 45: III. Denn mit der Freude Feierklange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:8d1e9b4d-2bbc-4899-a8ec-fa78d118f157' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d1e9b4d-2bbc-4899-a8ec-fa78d118f157', 4, 'III', 'Denn mit der Freude Feierklange', 'Das Lied von der Glocke, op. 45: III. Denn mit der Freude Feierklange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d1e9b4d-2bbc-4899-a8ec-fa78d118f157'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'Die Jahre fliegen pfeilgeschwind', part.name_en = 'Das Lied von der Glocke, op. 45: IV. Die Jahre fliegen pfeilgeschwind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9f207352-1405-4d9c-bc32-4e46f3f831ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f207352-1405-4d9c-bc32-4e46f3f831ea', 5, 'IV', 'Die Jahre fliegen pfeilgeschwind', 'Das Lied von der Glocke, op. 45: IV. Die Jahre fliegen pfeilgeschwind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f207352-1405-4d9c-bc32-4e46f3f831ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'V',
    part.name_ko = 'O zarte Sehnsucht, süßes Hoffen', part.name_en = 'Das Lied von der Glocke, op. 45: V. O zarte Sehnsucht, süßes Hoffen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:e5513908-f2f9-48c0-9d17-ac9a3dddb0f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5513908-f2f9-48c0-9d17-ac9a3dddb0f4', 6, 'V', 'O zarte Sehnsucht, süßes Hoffen', 'Das Lied von der Glocke, op. 45: V. O zarte Sehnsucht, süßes Hoffen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5513908-f2f9-48c0-9d17-ac9a3dddb0f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VI',
    part.name_ko = 'Wie sich schon die Pfeifen bräunen', part.name_en = 'Das Lied von der Glocke, op. 45: VI. Wie sich schon die Pfeifen bräunen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4929427b-148d-4bb3-a01e-b3d08a2ef5ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4929427b-148d-4bb3-a01e-b3d08a2ef5ad', 7, 'VI', 'Wie sich schon die Pfeifen bräunen', 'Das Lied von der Glocke, op. 45: VI. Wie sich schon die Pfeifen bräunen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4929427b-148d-4bb3-a01e-b3d08a2ef5ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VII',
    part.name_ko = 'Denn wo das Strenge mit dem Zarten', part.name_en = 'Das Lied von der Glocke, op. 45: VII. Denn wo das Strenge mit dem Zarten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:235dcc9a-43f4-4dbb-bec5-6c1e4dbc61a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:235dcc9a-43f4-4dbb-bec5-6c1e4dbc61a7', 8, 'VII', 'Denn wo das Strenge mit dem Zarten', 'Das Lied von der Glocke, op. 45: VII. Denn wo das Strenge mit dem Zarten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:235dcc9a-43f4-4dbb-bec5-6c1e4dbc61a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'VIII',
    part.name_ko = 'Der Mann muß hinaus ins feindliche Leben', part.name_en = 'Das Lied von der Glocke, op. 45: VIII. Der Mann muß hinaus ins feindliche Leben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:545b7fde-e9de-4bb5-90e1-8882443450f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:545b7fde-e9de-4bb5-90e1-8882443450f3', 9, 'VIII', 'Der Mann muß hinaus ins feindliche Leben', 'Das Lied von der Glocke, op. 45: VIII. Der Mann muß hinaus ins feindliche Leben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:545b7fde-e9de-4bb5-90e1-8882443450f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'IX',
    part.name_ko = 'Und der Vater mit frohem Blick', part.name_en = 'Das Lied von der Glocke, op. 45: IX. Und der Vater mit frohem Blick',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:78d62409-c331-4920-9133-262880bab843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78d62409-c331-4920-9133-262880bab843', 10, 'IX', 'Und der Vater mit frohem Blick', 'Das Lied von der Glocke, op. 45: IX. Und der Vater mit frohem Blick', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78d62409-c331-4920-9133-262880bab843'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'X',
    part.name_ko = 'Wohl! Nun kann der Guß beginnen', part.name_en = 'Das Lied von der Glocke, op. 45: X. Wohl! Nun kann der Guß beginnen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a1a77506-2d47-4e9e-b0e8-5a9681a467d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a77506-2d47-4e9e-b0e8-5a9681a467d2', 11, 'X', 'Wohl! Nun kann der Guß beginnen', 'Das Lied von der Glocke, op. 45: X. Wohl! Nun kann der Guß beginnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a77506-2d47-4e9e-b0e8-5a9681a467d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XI',
    part.name_ko = 'Wohltätig ist des Feuers Macht', part.name_en = 'Das Lied von der Glocke, op. 45: XI. Wohltätig ist des Feuers Macht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:89ba9f42-ecc5-4018-8784-f77d370324aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89ba9f42-ecc5-4018-8784-f77d370324aa', 12, 'XI', 'Wohltätig ist des Feuers Macht', 'Das Lied von der Glocke, op. 45: XI. Wohltätig ist des Feuers Macht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89ba9f42-ecc5-4018-8784-f77d370324aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XII',
    part.name_ko = 'Hört ihr’s wimmern', part.name_en = 'Das Lied von der Glocke, op. 45: XII. Hört ihr’s wimmern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:61638428-327f-45a4-8524-629af5208e33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61638428-327f-45a4-8524-629af5208e33', 13, 'XII', 'Hört ihr’s wimmern', 'Das Lied von der Glocke, op. 45: XII. Hört ihr’s wimmern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61638428-327f-45a4-8524-629af5208e33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIII',
    part.name_ko = 'Einen Blick nach dem Grabe', part.name_en = 'Das Lied von der Glocke, op. 45: XIII. Einen Blick nach dem Grabe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bcb50235-1963-40c6-94e8-a799b265b1b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb50235-1963-40c6-94e8-a799b265b1b2', 14, 'XIII', 'Einen Blick nach dem Grabe', 'Das Lied von der Glocke, op. 45: XIII. Einen Blick nach dem Grabe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb50235-1963-40c6-94e8-a799b265b1b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XIV',
    part.name_ko = 'In die Erd’ ist’s aufgenommen', part.name_en = 'Das Lied von der Glocke, op. 45: XIV. In die Erd’ ist’s aufgenommen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:02d35832-d4c3-41df-ab6a-d4e6dba0dfcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d35832-d4c3-41df-ab6a-d4e6dba0dfcf', 15, 'XIV', 'In die Erd’ ist’s aufgenommen', 'Das Lied von der Glocke, op. 45: XIV. In die Erd’ ist’s aufgenommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d35832-d4c3-41df-ab6a-d4e6dba0dfcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XV',
    part.name_ko = 'Dem dunklen Schoß der heil’gen Erde', part.name_en = 'Das Lied von der Glocke, op. 45: XV. Dem dunklen Schoß der heil’gen Erde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a12bccc2-5324-4790-8e8e-2ccd4131feaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a12bccc2-5324-4790-8e8e-2ccd4131feaf', 16, 'XV', 'Dem dunklen Schoß der heil’gen Erde', 'Das Lied von der Glocke, op. 45: XV. Dem dunklen Schoß der heil’gen Erde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12bccc2-5324-4790-8e8e-2ccd4131feaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVI',
    part.name_ko = 'Von dem Dome schwer und bang', part.name_en = 'Das Lied von der Glocke, op. 45: XVI. Von dem Dome schwer und bang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2e918dd9-d7e6-4fbe-8604-179a24dcfdfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e918dd9-d7e6-4fbe-8604-179a24dcfdfe', 17, 'XVI', 'Von dem Dome schwer und bang', 'Das Lied von der Glocke, op. 45: XVI. Von dem Dome schwer und bang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e918dd9-d7e6-4fbe-8604-179a24dcfdfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVII',
    part.name_ko = 'Ach! Die Gattin ist’s, die teure', part.name_en = 'Das Lied von der Glocke, op. 45: XVII. Ach! Die Gattin ist’s, die teure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:fa16027a-2af6-47e3-b1de-cc37fe4040f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa16027a-2af6-47e3-b1de-cc37fe4040f5', 18, 'XVII', 'Ach! Die Gattin ist’s, die teure', 'Das Lied von der Glocke, op. 45: XVII. Ach! Die Gattin ist’s, die teure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa16027a-2af6-47e3-b1de-cc37fe4040f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'XVIII',
    part.name_ko = 'Bis die Glocke sich verkühlet', part.name_en = 'Das Lied von der Glocke, op. 45: XVIII. Bis die Glocke sich verkühlet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b1f181f6-8dc8-4e0a-afef-30887ca7d825' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f181f6-8dc8-4e0a-afef-30887ca7d825', 19, 'XVIII', 'Bis die Glocke sich verkühlet', 'Das Lied von der Glocke, op. 45: XVIII. Bis die Glocke sich verkühlet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f181f6-8dc8-4e0a-afef-30887ca7d825'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'XIX',
    part.name_ko = 'Munter fördert seine Schritte', part.name_en = 'Das Lied von der Glocke, op. 45: XIX. Munter fördert seine Schritte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1f1d1125-6a0f-46b0-b5fe-c3083800ba0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1d1125-6a0f-46b0-b5fe-c3083800ba0d', 20, 'XIX', 'Munter fördert seine Schritte', 'Das Lied von der Glocke, op. 45: XIX. Munter fördert seine Schritte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1d1125-6a0f-46b0-b5fe-c3083800ba0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = 'XX',
    part.name_ko = 'Heil’ge Ordnung', part.name_en = 'Das Lied von der Glocke, op. 45: XX. Heil’ge Ordnung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6ae1f1f3-d64a-40d9-be1e-a30f28d7a476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae1f1f3-d64a-40d9-be1e-a30f28d7a476', 21, 'XX', 'Heil’ge Ordnung', 'Das Lied von der Glocke, op. 45: XX. Heil’ge Ordnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae1f1f3-d64a-40d9-be1e-a30f28d7a476'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = 'XXI',
    part.name_ko = 'Heil’ge Ordnung', part.name_en = 'Das Lied von der Glocke, op. 45: XXI. Heil’ge Ordnung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9ce71c54-3b28-464a-8b09-ea7c9da26e07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ce71c54-3b28-464a-8b09-ea7c9da26e07', 22, 'XXI', 'Heil’ge Ordnung', 'Das Lied von der Glocke, op. 45: XXI. Heil’ge Ordnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ce71c54-3b28-464a-8b09-ea7c9da26e07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = 'XXII',
    part.name_ko = 'Holder Friede, süße Eintracht', part.name_en = 'Das Lied von der Glocke, op. 45: XXII. Holder Friede, süße Eintracht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:7b630080-f55a-4d44-9132-b5822fa571c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b630080-f55a-4d44-9132-b5822fa571c0', 23, 'XXII', 'Holder Friede, süße Eintracht', 'Das Lied von der Glocke, op. 45: XXII. Holder Friede, süße Eintracht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b630080-f55a-4d44-9132-b5822fa571c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = 'XXIII',
    part.name_ko = 'Nun zerbrecht mir das Gebäude', part.name_en = 'Das Lied von der Glocke, op. 45: XXIII. Nun zerbrecht mir das Gebäude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9dbad5ee-1641-486c-8ff0-cee3acb97e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dbad5ee-1641-486c-8ff0-cee3acb97e6c', 24, 'XXIII', 'Nun zerbrecht mir das Gebäude', 'Das Lied von der Glocke, op. 45: XXIII. Nun zerbrecht mir das Gebäude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbad5ee-1641-486c-8ff0-cee3acb97e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = 'XXIV',
    part.name_ko = 'Der Meister kann die Form zerbrechen', part.name_en = 'Das Lied von der Glocke, op. 45: XXIV. Der Meister kann die Form zerbrechen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:35befc7a-9a20-49c8-9b77-ef15ce5f8bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35befc7a-9a20-49c8-9b77-ef15ce5f8bd3', 25, 'XXIV', 'Der Meister kann die Form zerbrechen', 'Das Lied von der Glocke, op. 45: XXIV. Der Meister kann die Form zerbrechen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35befc7a-9a20-49c8-9b77-ef15ce5f8bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = 'XXV',
    part.name_ko = 'Freude hat mir Gott gegeben', part.name_en = 'Das Lied von der Glocke, op. 45: XXV. Freude hat mir Gott gegeben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:22956a55-cd58-4381-a7fd-e7ad94f8fd40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22956a55-cd58-4381-a7fd-e7ad94f8fd40', 26, 'XXV', 'Freude hat mir Gott gegeben', 'Das Lied von der Glocke, op. 45: XXV. Freude hat mir Gott gegeben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22956a55-cd58-4381-a7fd-e7ad94f8fd40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = 'XXVI',
    part.name_ko = 'Und dies sei fortan ihr Beruf', part.name_en = 'Das Lied von der Glocke, op. 45: XXVI. Und dies sei fortan ihr Beruf',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:e2c209e9-d1ef-4967-a2b9-56493c7b6c7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c209e9-d1ef-4967-a2b9-56493c7b6c7a', 27, 'XXVI', 'Und dies sei fortan ihr Beruf', 'Das Lied von der Glocke, op. 45: XXVI. Und dies sei fortan ihr Beruf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c209e9-d1ef-4967-a2b9-56493c7b6c7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = 'XXVII',
    part.name_ko = 'Jetzo mit der Kraft des Stranges', part.name_en = 'Das Lied von der Glocke, op. 45: XXVII. Jetzo mit der Kraft des Stranges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2502 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0b9f5b05-8831-4cbf-87ee-d31d89e0e442' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b9f5b05-8831-4cbf-87ee-d31d89e0e442', 28, 'XXVII', 'Jetzo mit der Kraft des Stranges', 'Das Lied von der Glocke, op. 45: XXVII. Jetzo mit der Kraft des Stranges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2502 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b9f5b05-8831-4cbf-87ee-d31d89e0e442'
);


-- Op. 33 No. 3 가곡 <Dein gedenk’ ich Margaretha>

UPDATE pieces piece
SET piece.title = '가곡 <Dein gedenk’ ich Margaretha>', piece.title_en = 'Dein gedenk’ ich Margaretha, op. 33 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 33 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2189 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 No. 2 가곡 <Der Landsknecht>

UPDATE pieces piece
SET piece.title = '가곡 <Der Landsknecht>', piece.title_en = 'Der Landsknecht, op. 18 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 18 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2665 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 오페라 <Die Loreley>

UPDATE pieces piece
SET piece.title = '오페라 <Die Loreley>', piece.title_en = 'Die Loreley, op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2615 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 97 No. 2 가곡 <Durch die wolkige Maiennacht>

UPDATE pieces piece
SET piece.title = '가곡 <Durch die wolkige Maiennacht>', piece.title_en = 'Durch die wolkige Maiennacht, op. 97 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 97 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1052 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 97 No. 5 가곡 <Ein Mädchen und ein Gläschen Wein>

UPDATE pieces piece
SET piece.title = '가곡 <Ein Mädchen und ein Gläschen Wein>', piece.title_en = 'Ein Mädchen und ein Gläschen Wein, op. 97 no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 97 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2195 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Einleitung zur Oper Die Loreley

UPDATE pieces piece
SET piece.title = 'Einleitung zur Oper Die Loreley', piece.title_en = 'Einleitung zur Oper Die Loreley',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2380 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 환상곡 D단조

UPDATE pieces piece
SET piece.title = '환상곡 D단조', piece.title_en = 'Fantasia in D minor for Two Pianos, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1181 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 70 4개의 첼로와 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '4개의 첼로와 피아노를 위한 소품', piece.title_en = 'Four Pieces for Cello and Piano, op. 70',
    piece.type = 'album', piece.opus_number = 'Op. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2221 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aria', part.name_en = 'Four Pieces for Cello and Piano, op. 70: I. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2221 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a26a5750-52f1-4c58-8c97-2927b1d28e8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a26a5750-52f1-4c58-8c97-2927b1d28e8f', 1, 'I', 'Aria', 'Four Pieces for Cello and Piano, op. 70: I. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2221 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a26a5750-52f1-4c58-8c97-2927b1d28e8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Finnländisch', part.name_en = 'Four Pieces for Cello and Piano, op. 70: II. Finnländisch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2221 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d8c23656-f0ae-4849-a0d4-ec49a8ee426a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8c23656-f0ae-4849-a0d4-ec49a8ee426a', 2, 'II', 'Finnländisch', 'Four Pieces for Cello and Piano, op. 70: II. Finnländisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2221 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c23656-f0ae-4849-a0d4-ec49a8ee426a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tanz. Schwedisch', part.name_en = 'Four Pieces for Cello and Piano, op. 70: III. Tanz. Schwedisch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2221 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:30040ad2-174d-4ecd-b1bc-b8d925b80a4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30040ad2-174d-4ecd-b1bc-b8d925b80a4b', 3, 'III', 'Tanz. Schwedisch', 'Four Pieces for Cello and Piano, op. 70: III. Tanz. Schwedisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2221 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30040ad2-174d-4ecd-b1bc-b8d925b80a4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Schottisch', part.name_en = 'Four Pieces for Cello and Piano, op. 70: IV. Schottisch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2221 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a703b00e-6d91-419a-844e-b1e345e75070' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a703b00e-6d91-419a-844e-b1e345e75070', 4, 'IV', 'Schottisch', 'Four Pieces for Cello and Piano, op. 70: IV. Schottisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2221 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a703b00e-6d91-419a-844e-b1e345e75070'
);


-- Op. 38 Fünf Lieder Op. 38

UPDATE pieces piece
SET piece.title = 'Fünf Lieder Op. 38', piece.title_en = 'Fünf Lieder, op. 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '38',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2723 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rheinsage', part.name_en = 'Fünf Lieder, op. 38: Rheinsage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2723 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:17dd89aa-97e7-424e-90da-c4450c00637f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17dd89aa-97e7-424e-90da-c4450c00637f', 1, NULL, 'Rheinsage', 'Fünf Lieder, op. 38: Rheinsage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2723 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17dd89aa-97e7-424e-90da-c4450c00637f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Wald von Traquair', part.name_en = 'Fünf Lieder, op. 38: Der Wald von Traquair',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2723 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:567f122d-a54a-4b5c-933d-b90fbc857ffc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:567f122d-a54a-4b5c-933d-b90fbc857ffc', 2, NULL, 'Der Wald von Traquair', 'Fünf Lieder, op. 38: Der Wald von Traquair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2723 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:567f122d-a54a-4b5c-933d-b90fbc857ffc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Waldpsalm', part.name_en = 'Fünf Lieder, op. 38: Waldpsalm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2723 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:97e8b932-6887-454f-8fff-974f18e19e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e8b932-6887-454f-8fff-974f18e19e54', 3, NULL, 'Waldpsalm', 'Fünf Lieder, op. 38: Waldpsalm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2723 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e8b932-6887-454f-8fff-974f18e19e54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Feierliches Tafellied', part.name_en = 'Fünf Lieder, op. 38: Feierliches Tafellied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2723 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:cca41c21-b318-4cae-abad-7497657381fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cca41c21-b318-4cae-abad-7497657381fe', 4, NULL, 'Feierliches Tafellied', 'Fünf Lieder, op. 38: Feierliches Tafellied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2723 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca41c21-b318-4cae-abad-7497657381fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tannhäuser', part.name_en = 'Fünf Lieder, op. 38: Tannhäuser',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2723 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:f3d25000-3425-4540-8888-39db0f1d145d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3d25000-3425-4540-8888-39db0f1d145d', 5, NULL, 'Tannhäuser', 'Fünf Lieder, op. 38: Tannhäuser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2723 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3d25000-3425-4540-8888-39db0f1d145d'
);


-- Op. 15 No. 4 가곡 <Goldne Brücken>

UPDATE pieces piece
SET piece.title = '가곡 <Goldne Brücken>', piece.title_en = 'Goldne Brücken, op. 15 no. 4',
    piece.type = 'song', piece.opus_number = 'Op. 15 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 945 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 No. 3 가곡 <Im tiefen Thale>

UPDATE pieces piece
SET piece.title = '가곡 <Im tiefen Thale>', piece.title_en = 'Im tiefen Thale, op. 15 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 15 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1606 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 65 In Memoriam

UPDATE pieces piece
SET piece.title = 'In Memoriam', piece.title_en = 'In Memoriam, op. 65',
    piece.type = 'song', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 895 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 72 가곡 <In der Nacht>

UPDATE pieces piece
SET piece.title = '가곡 <In der Nacht>', piece.title_en = 'In der Nacht, op. 72',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1768 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 Jubilate-Amen

UPDATE pieces piece
SET piece.title = 'Jubilate-Amen', piece.title_en = 'Jubilate-Amen, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2662 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 Klavierstücke Op. 12

UPDATE pieces piece
SET piece.title = 'Klavierstücke Op. 12', piece.title_en = 'Klavierstücke, op. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '12',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2297 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'in B-flat (Andante sostenuto)', part.name_en = 'Klavierstücke, op. 12: No. 1 in B-flat (Andante sostenuto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:398526a2-8179-4c17-9ea7-c640455bc1a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398526a2-8179-4c17-9ea7-c640455bc1a0', 1, NULL, 'in B-flat (Andante sostenuto)', 'Klavierstücke, op. 12: No. 1 in B-flat (Andante sostenuto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398526a2-8179-4c17-9ea7-c640455bc1a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'in G minor (Andante con moto) (Sehr einfach)', part.name_en = 'Klavierstücke, op. 12: No. 2 in G minor (Andante con moto) (Sehr einfach)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2b26c741-5ed4-4523-bd8f-4957121c9746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b26c741-5ed4-4523-bd8f-4957121c9746', 2, NULL, 'in G minor (Andante con moto) (Sehr einfach)', 'Klavierstücke, op. 12: No. 2 in G minor (Andante con moto) (Sehr einfach)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b26c741-5ed4-4523-bd8f-4957121c9746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Impromptu in G (Allegretto)', part.name_en = 'Klavierstücke, op. 12: No. 3. Impromptu in G (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a73ad68c-cd38-412c-ae57-0234358a35aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a73ad68c-cd38-412c-ae57-0234358a35aa', 3, NULL, 'Impromptu in G (Allegretto)', 'Klavierstücke, op. 12: No. 3. Impromptu in G (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a73ad68c-cd38-412c-ae57-0234358a35aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'in D minor (Moderato)', part.name_en = 'Klavierstücke, op. 12: No. 4 in D minor (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:987b3a90-27e9-484a-91f0-dfb3351c010a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:987b3a90-27e9-484a-91f0-dfb3351c010a', 4, NULL, 'in D minor (Moderato)', 'Klavierstücke, op. 12: No. 4 in D minor (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:987b3a90-27e9-484a-91f0-dfb3351c010a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Walzer in F-sharp (Grazioso)', part.name_en = 'Klavierstücke, op. 12: No. 5. Walzer in F-sharp (Grazioso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a8cb8a63-3ffc-4867-9a05-1c56c2cba7f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8cb8a63-3ffc-4867-9a05-1c56c2cba7f3', 5, NULL, 'Walzer in F-sharp (Grazioso)', 'Klavierstücke, op. 12: No. 5. Walzer in F-sharp (Grazioso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8cb8a63-3ffc-4867-9a05-1c56c2cba7f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'in E (Andante con larghezza)', part.name_en = 'Klavierstücke, op. 12: No. 6 in E (Andante con larghezza)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2297 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:679446ef-1ea0-4031-88e5-978d53135e5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:679446ef-1ea0-4031-88e5-978d53135e5a', 6, NULL, 'in E (Andante con larghezza)', 'Klavierstücke, op. 12: No. 6 in E (Andante con larghezza)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2297 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:679446ef-1ea0-4031-88e5-978d53135e5a'
);


-- Op. 14 Klavierstücke Op. 14

UPDATE pieces piece
SET piece.title = 'Klavierstücke Op. 14', piece.title_en = 'Klavierstücke, op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1429 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Romanze in G (Andante molto cantabile)', part.name_en = 'Klavierstücke, op. 14: No. 1. Romanze in G (Andante molto cantabile)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1429 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9ff45a71-5e7e-4c12-bdf5-a6c004fb913d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ff45a71-5e7e-4c12-bdf5-a6c004fb913d', 1, NULL, 'Romanze in G (Andante molto cantabile)', 'Klavierstücke, op. 14: No. 1. Romanze in G (Andante molto cantabile)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1429 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ff45a71-5e7e-4c12-bdf5-a6c004fb913d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fantasiestück in C minor (Allegro molto)', part.name_en = 'Klavierstücke, op. 14: No. 2. Fantasiestück in C minor (Allegro molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1429 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:50239de4-07e1-4b13-9c39-27faf2a4c674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50239de4-07e1-4b13-9c39-27faf2a4c674', 2, NULL, 'Fantasiestück in C minor (Allegro molto)', 'Klavierstücke, op. 14: No. 2. Fantasiestück in C minor (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1429 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50239de4-07e1-4b13-9c39-27faf2a4c674'
);


-- Op. 17 No. 10 가곡 <Klosterlied>

UPDATE pieces piece
SET piece.title = '가곡 <Klosterlied>', piece.title_en = 'Klosterlied, op. 17 no. 10',
    piece.type = 'song', piece.opus_number = 'Op. 17 No. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2595 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 84 Konzertstück in F-sharp minor

UPDATE pieces piece
SET piece.title = 'Konzertstück in F-sharp minor', piece.title_en = 'Konzertstück in F-sharp minor, op. 84',
    piece.type = 'album', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1108 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro appassionato', part.name_en = 'Konzertstück in F-sharp minor, op. 84: I. Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1108 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:846b06f1-bfd4-3514-88f3-900e1938a4f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:846b06f1-bfd4-3514-88f3-900e1938a4f4', 1, 'I', 'Allegro appassionato', 'Konzertstück in F-sharp minor, op. 84: I. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1108 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:846b06f1-bfd4-3514-88f3-900e1938a4f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio, ma non troppo lento', part.name_en = 'Konzertstück in F-sharp minor, op. 84: II. Adagio, ma non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1108 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:8ad0766f-f167-3cd7-af03-0849662b5a8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad0766f-f167-3cd7-af03-0849662b5a8a', 2, 'II', 'Adagio, ma non troppo lento', 'Konzertstück in F-sharp minor, op. 84: II. Adagio, ma non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1108 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad0766f-f167-3cd7-af03-0849662b5a8a'
);


-- Op. 86 Lieder für gemischten Chor Op. 86

UPDATE pieces piece
SET piece.title = 'Lieder für gemischten Chor Op. 86', piece.title_en = 'Lieder für gemischten Chor, op. 86',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '86',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2709 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Deutscher Frühling', part.name_en = 'Lieder für gemischten Chor, op. 86: Deutscher Frühling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:52bec608-6262-48e1-a611-2032519c739f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52bec608-6262-48e1-a611-2032519c739f', 1, NULL, 'Deutscher Frühling', 'Lieder für gemischten Chor, op. 86: Deutscher Frühling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52bec608-6262-48e1-a611-2032519c739f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Im Moseltal', part.name_en = 'Lieder für gemischten Chor, op. 86: Im Moseltal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:69b8b273-5133-448f-ac1d-604968181057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69b8b273-5133-448f-ac1d-604968181057', 2, NULL, 'Im Moseltal', 'Lieder für gemischten Chor, op. 86: Im Moseltal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69b8b273-5133-448f-ac1d-604968181057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Geh, wo der Ruhm dir winket', part.name_en = 'Lieder für gemischten Chor, op. 86: Geh, wo der Ruhm dir winket',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:792864a2-13ca-421f-a9ba-19a1b3155e92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792864a2-13ca-421f-a9ba-19a1b3155e92', 3, NULL, 'Geh, wo der Ruhm dir winket', 'Lieder für gemischten Chor, op. 86: Geh, wo der Ruhm dir winket', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792864a2-13ca-421f-a9ba-19a1b3155e92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ackeley', part.name_en = 'Lieder für gemischten Chor, op. 86: Ackeley',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9330c6f6-4ffe-4a7e-ae4e-e4f9365b2878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9330c6f6-4ffe-4a7e-ae4e-e4f9365b2878', 4, NULL, 'Ackeley', 'Lieder für gemischten Chor, op. 86: Ackeley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9330c6f6-4ffe-4a7e-ae4e-e4f9365b2878'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kleine Maria. Legende', part.name_en = 'Lieder für gemischten Chor, op. 86: Kleine Maria. Legende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:e6dbc516-56e9-40fa-8aa7-50590b4b4da7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6dbc516-56e9-40fa-8aa7-50590b4b4da7', 5, NULL, 'Kleine Maria. Legende', 'Lieder für gemischten Chor, op. 86: Kleine Maria. Legende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6dbc516-56e9-40fa-8aa7-50590b4b4da7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Weit über dem Meere', part.name_en = 'Lieder für gemischten Chor, op. 86: Weit über dem Meere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2709 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:fa013226-e556-4aac-8e7d-a3d2f0ab9621' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa013226-e556-4aac-8e7d-a3d2f0ab9621', 6, NULL, 'Weit über dem Meere', 'Lieder für gemischten Chor, op. 86: Weit über dem Meere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2709 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa013226-e556-4aac-8e7d-a3d2f0ab9621'
);


-- Op. 97 No. 1 가곡 <Mein Liebchen naht, Blumen zu pflücken>

UPDATE pieces piece
SET piece.title = '가곡 <Mein Liebchen naht, Blumen zu pflücken>', piece.title_en = 'Mein Liebchen naht, Blumen zu pflücken, op. 97 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 97 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1140 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 60 Neun Lieder Op. 60

UPDATE pieces piece
SET piece.title = 'Neun Lieder Op. 60', piece.title_en = 'Neun Lieder, op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2546 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In der Christnacht', part.name_en = 'Neun Lieder, op. 60: In der Christnacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:45211fec-3d5a-4952-9d6b-3ef4819871c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45211fec-3d5a-4952-9d6b-3ef4819871c3', 1, NULL, 'In der Christnacht', 'Neun Lieder, op. 60: In der Christnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45211fec-3d5a-4952-9d6b-3ef4819871c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sommerlied', part.name_en = 'Neun Lieder, op. 60: Sommerlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bdaf39b2-57e2-4891-b5bd-c1c805b7cd91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdaf39b2-57e2-4891-b5bd-c1c805b7cd91', 2, NULL, 'Sommerlied', 'Neun Lieder, op. 60: Sommerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdaf39b2-57e2-4891-b5bd-c1c805b7cd91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Mutter Klage', part.name_en = 'Neun Lieder, op. 60: Der Mutter Klage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:de0a3147-17d4-4b73-aa07-7a9c46640289' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de0a3147-17d4-4b73-aa07-7a9c46640289', 3, NULL, 'Der Mutter Klage', 'Neun Lieder, op. 60: Der Mutter Klage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de0a3147-17d4-4b73-aa07-7a9c46640289'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gebet', part.name_en = 'Neun Lieder, op. 60: Gebet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:94f36ddf-324c-416a-af6c-4b8721b65269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94f36ddf-324c-416a-af6c-4b8721b65269', 4, NULL, 'Gebet', 'Neun Lieder, op. 60: Gebet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94f36ddf-324c-416a-af6c-4b8721b65269'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ausreise zum Turnier', part.name_en = 'Neun Lieder, op. 60: Ausreise zum Turnier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d4cf6cda-1cc6-4100-9acf-7c3fb1d81103' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4cf6cda-1cc6-4100-9acf-7c3fb1d81103', 5, NULL, 'Ausreise zum Turnier', 'Neun Lieder, op. 60: Ausreise zum Turnier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4cf6cda-1cc6-4100-9acf-7c3fb1d81103'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Weit, weit aus ferner Zeit', part.name_en = 'Neun Lieder, op. 60: Weit, weit aus ferner Zeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0c7ad80e-5843-4e81-874e-a0c79e0d1c8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c7ad80e-5843-4e81-874e-a0c79e0d1c8a', 6, NULL, 'Weit, weit aus ferner Zeit', 'Neun Lieder, op. 60: Weit, weit aus ferner Zeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c7ad80e-5843-4e81-874e-a0c79e0d1c8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Nachruf an Walther von der Vogelweide', part.name_en = 'Neun Lieder, op. 60: Nachruf an Walther von der Vogelweide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:019b7a72-60cb-44a5-95cb-c800648362ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:019b7a72-60cb-44a5-95cb-c800648362ac', 7, NULL, 'Nachruf an Walther von der Vogelweide', 'Neun Lieder, op. 60: Nachruf an Walther von der Vogelweide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:019b7a72-60cb-44a5-95cb-c800648362ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Weihnachtsliedchen', part.name_en = 'Neun Lieder, op. 60: Weihnachtsliedchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:ed16b118-dc6c-434a-8b35-22a68dba9f8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed16b118-dc6c-434a-8b35-22a68dba9f8a', 8, NULL, 'Weihnachtsliedchen', 'Neun Lieder, op. 60: Weihnachtsliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed16b118-dc6c-434a-8b35-22a68dba9f8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Palmsonntagmorgen', part.name_en = 'Neun Lieder, op. 60: Palmsonntagmorgen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2546 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:881e9070-b009-42d5-922b-f39bb47122b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:881e9070-b009-42d5-922b-f39bb47122b2', 9, NULL, 'Palmsonntagmorgen', 'Neun Lieder, op. 60: Palmsonntagmorgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2546 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:881e9070-b009-42d5-922b-f39bb47122b2'
);


-- Op. 41 오라토리오 <Odysseus>

UPDATE pieces piece
SET piece.title = '오라토리오 <Odysseus>', piece.title_en = 'Odysseus, op. 41',
    piece.type = 'song', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2203 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 5중주 G단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 G단조', piece.title_en = 'Piano Quintet in G minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3008 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Piano Quintet in G minor: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3008 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:19af79bb-6347-4e03-9326-d1a0a256639e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19af79bb-6347-4e03-9326-d1a0a256639e', 1, 'I', 'Allegro molto moderato', 'Piano Quintet in G minor: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3008 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19af79bb-6347-4e03-9326-d1a0a256639e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Piano Quintet in G minor: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3008 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9ef4f93d-2740-4017-9a53-528703a03cb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ef4f93d-2740-4017-9a53-528703a03cb1', 2, 'II', 'Adagio', 'Piano Quintet in G minor: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3008 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ef4f93d-2740-4017-9a53-528703a03cb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro molto - Trio', part.name_en = 'Piano Quintet in G minor: III. Scherzo: Allegro molto - Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3008 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:679d8450-8e34-4907-89b1-e7be1de25e6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:679d8450-8e34-4907-89b1-e7be1de25e6a', 3, 'III', 'Scherzo: Allegro molto - Trio', 'Piano Quintet in G minor: III. Scherzo: Allegro molto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3008 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:679d8450-8e34-4907-89b1-e7be1de25e6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro agitato', part.name_en = 'Piano Quintet in G minor: IV. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3008 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:f1b2e615-9c38-4108-9200-7b33ecd4ff90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b2e615-9c38-4108-9200-7b33ecd4ff90', 4, 'IV', 'Allegro agitato', 'Piano Quintet in G minor: IV. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3008 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b2e615-9c38-4108-9200-7b33ecd4ff90'
);


-- Op. 46 Scottish Fantasy in E-flat major

UPDATE pieces piece
SET piece.title = 'Scottish Fantasy in E-flat major', piece.title_en = 'Scottish Fantasy in E-flat major, op. 46',
    piece.type = 'album', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 863 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction. Grave - Adagio cantabile', part.name_en = 'Scottish Fantasy in E-flat major, op. 46: I. Introduction. Grave - Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 863 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b139ca9f-8453-3f2b-a87f-84c816b912cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b139ca9f-8453-3f2b-a87f-84c816b912cc', 1, 'I', 'Introduction. Grave - Adagio cantabile', 'Scottish Fantasy in E-flat major, op. 46: I. Introduction. Grave - Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 863 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b139ca9f-8453-3f2b-a87f-84c816b912cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Allegro', part.name_en = 'Scottish Fantasy in E-flat major, op. 46: II. Scherzo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 863 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:26a77dad-89bc-3715-bcf8-33e6ebefe0f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26a77dad-89bc-3715-bcf8-33e6ebefe0f3', 2, 'II', 'Scherzo. Allegro', 'Scottish Fantasy in E-flat major, op. 46: II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 863 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a77dad-89bc-3715-bcf8-33e6ebefe0f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro guerriero', part.name_en = 'Scottish Fantasy in E-flat major, op. 46: IV. Finale. Allegro guerriero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 863 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:40cd6f20-07bc-41c6-8ff3-1980678cff4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40cd6f20-07bc-41c6-8ff3-1980678cff4a', 3, 'IV', 'Finale. Allegro guerriero', 'Scottish Fantasy in E-flat major, op. 46: IV. Finale. Allegro guerriero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 863 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40cd6f20-07bc-41c6-8ff3-1980678cff4a'
);


-- None 7중주 E♭장조

UPDATE pieces piece
SET piece.title = '7중주 E♭장조', piece.title_en = 'Septet in E-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1337 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 75 바이올린 세레나데

UPDATE pieces piece
SET piece.title = '바이올린 세레나데', piece.title_en = 'Serenade for Violin and Orchestra, op. 75',
    piece.type = 'album', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1198 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con moto', part.name_en = 'Serenade for Violin and Orchestra, op. 75: I. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1198 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6fe3e795-a47d-3049-b1b3-1ba8b40f812c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fe3e795-a47d-3049-b1b3-1ba8b40f812c', 1, 'I', 'Andante con moto', 'Serenade for Violin and Orchestra, op. 75: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1198 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe3e795-a47d-3049-b1b3-1ba8b40f812c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato, alla marcia', part.name_en = 'Serenade for Violin and Orchestra, op. 75: II. Allegro moderato, alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1198 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:891ed6c1-3503-3527-8c89-fcbbdb648f89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:891ed6c1-3503-3527-8c89-fcbbdb648f89', 2, 'II', 'Allegro moderato, alla marcia', 'Serenade for Violin and Orchestra, op. 75: II. Allegro moderato, alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1198 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:891ed6c1-3503-3527-8c89-fcbbdb648f89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Notturno', part.name_en = 'Serenade for Violin and Orchestra, op. 75: III. Notturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1198 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:38bde87a-1b6e-3fec-b95a-ddd5a27b5f3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38bde87a-1b6e-3fec-b95a-ddd5a27b5f3c', 3, 'III', 'Notturno', 'Serenade for Violin and Orchestra, op. 75: III. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1198 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38bde87a-1b6e-3fec-b95a-ddd5a27b5f3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro energico e vivace', part.name_en = 'Serenade for Violin and Orchestra, op. 75: IV. Allegro energico e vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1198 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:faab8a25-5cc1-37e9-bfb2-e06958c1e256' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faab8a25-5cc1-37e9-bfb2-e06958c1e256', 4, 'IV', 'Allegro energico e vivace', 'Serenade for Violin and Orchestra, op. 75: IV. Allegro energico e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1198 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faab8a25-5cc1-37e9-bfb2-e06958c1e256'
);


-- Op. 71 Sieben Gesänge Op. 71

UPDATE pieces piece
SET piece.title = 'Sieben Gesänge Op. 71', piece.title_en = 'Sieben Gesänge, op. 71',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '71',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2899 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lenz, komm herbei!', part.name_en = 'Sieben Gesänge, op. 71: Lenz, komm herbei!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1cdb0964-3730-435d-8e5e-1367315a65a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cdb0964-3730-435d-8e5e-1367315a65a0', 1, NULL, 'Lenz, komm herbei!', 'Sieben Gesänge, op. 71: Lenz, komm herbei!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cdb0964-3730-435d-8e5e-1367315a65a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'An die Musik', part.name_en = 'Sieben Gesänge, op. 71: An die Musik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:30f1cac9-24ae-4739-88fc-00d952669fa0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f1cac9-24ae-4739-88fc-00d952669fa0', 2, NULL, 'An die Musik', 'Sieben Gesänge, op. 71: An die Musik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f1cac9-24ae-4739-88fc-00d952669fa0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sommerlust in Walde', part.name_en = 'Sieben Gesänge, op. 71: Sommerlust in Walde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:46958ecf-348f-478e-9c30-1ab82a11884c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46958ecf-348f-478e-9c30-1ab82a11884c', 3, NULL, 'Sommerlust in Walde', 'Sieben Gesänge, op. 71: Sommerlust in Walde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46958ecf-348f-478e-9c30-1ab82a11884c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der fröhliche Musicus', part.name_en = 'Sieben Gesänge, op. 71: Der fröhliche Musicus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:53129101-3f5f-4cca-a54c-dbc3caadfafa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53129101-3f5f-4cca-a54c-dbc3caadfafa', 4, NULL, 'Der fröhliche Musicus', 'Sieben Gesänge, op. 71: Der fröhliche Musicus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53129101-3f5f-4cca-a54c-dbc3caadfafa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Morgengesang', part.name_en = 'Sieben Gesänge, op. 71: Morgengesang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:68256ee7-3c8a-4358-9e4a-e4c4c7114dcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68256ee7-3c8a-4358-9e4a-e4c4c7114dcb', 5, NULL, 'Morgengesang', 'Sieben Gesänge, op. 71: Morgengesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68256ee7-3c8a-4358-9e4a-e4c4c7114dcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Musicaklang', part.name_en = 'Sieben Gesänge, op. 71: Musicaklang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a70c947c-49d0-49fa-b83c-6128c40b9f4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a70c947c-49d0-49fa-b83c-6128c40b9f4d', 6, NULL, 'Musicaklang', 'Sieben Gesänge, op. 71: Musicaklang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a70c947c-49d0-49fa-b83c-6128c40b9f4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Narrenfahrt', part.name_en = 'Sieben Gesänge, op. 71: Narrenfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2899 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d8756afa-346f-4cda-9ff3-f0a50894074e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8756afa-346f-4cda-9ff3-f0a50894074e', 7, NULL, 'Narrenfahrt', 'Sieben Gesänge, op. 71: Narrenfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2899 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8756afa-346f-4cda-9ff3-f0a50894074e'
);


-- None Sieben Schottische Lieder

UPDATE pieces piece
SET piece.title = 'Sieben Schottische Lieder', piece.title_en = 'Sieben Schottische Lieder',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1969 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bei den roten Rosen', part.name_en = 'Sieben Schottische Lieder: Bei den roten Rosen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:03c89d0c-c24d-47fe-b835-1f0520d9f1e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03c89d0c-c24d-47fe-b835-1f0520d9f1e4', 1, NULL, 'Bei den roten Rosen', 'Sieben Schottische Lieder: Bei den roten Rosen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03c89d0c-c24d-47fe-b835-1f0520d9f1e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marion', part.name_en = 'Sieben Schottische Lieder: Marion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:44b9908f-4d26-45c2-9d77-96e69782bc53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44b9908f-4d26-45c2-9d77-96e69782bc53', 2, NULL, 'Marion', 'Sieben Schottische Lieder: Marion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44b9908f-4d26-45c2-9d77-96e69782bc53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lord Gregory', part.name_en = 'Sieben Schottische Lieder: Lord Gregory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:5c129e4c-95cc-45ba-85f1-6d1614135671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c129e4c-95cc-45ba-85f1-6d1614135671', 3, NULL, 'Lord Gregory', 'Sieben Schottische Lieder: Lord Gregory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c129e4c-95cc-45ba-85f1-6d1614135671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ruhelos, rastlos', part.name_en = 'Sieben Schottische Lieder: Ruhelos, rastlos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:5e3e6a3f-c229-4c30-9eed-ec15f768e31d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e3e6a3f-c229-4c30-9eed-ec15f768e31d', 4, NULL, 'Ruhelos, rastlos', 'Sieben Schottische Lieder: Ruhelos, rastlos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e3e6a3f-c229-4c30-9eed-ec15f768e31d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'O sahst du den Vater', part.name_en = 'Sieben Schottische Lieder: O sahst du den Vater',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bb447840-1440-4ff0-8ffd-e703876833a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb447840-1440-4ff0-8ffd-e703876833a2', 5, NULL, 'O sahst du den Vater', 'Sieben Schottische Lieder: O sahst du den Vater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb447840-1440-4ff0-8ffd-e703876833a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Johnie und Jenny', part.name_en = 'Sieben Schottische Lieder: Johnie und Jenny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:c8a2d621-c434-4c28-a690-ff1809007c1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a2d621-c434-4c28-a690-ff1809007c1a', 6, NULL, 'Johnie und Jenny', 'Sieben Schottische Lieder: Johnie und Jenny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a2d621-c434-4c28-a690-ff1809007c1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Der Hochzeittag', part.name_en = 'Sieben Schottische Lieder: Der Hochzeittag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1969 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d2418492-7733-4741-8ac3-cbddc0ced4a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2418492-7733-4741-8ac3-cbddc0ced4a2', 7, NULL, 'Der Hochzeittag', 'Sieben Schottische Lieder: Der Hochzeittag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1969 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2418492-7733-4741-8ac3-cbddc0ced4a2'
);


-- Op. 54 연가곡집 <Siechentrost-Lieder> Op. 54

UPDATE pieces piece
SET piece.title = '연가곡집 <Siechentrost-Lieder> Op. 54', piece.title_en = 'Siechentrost-Lieder, op. 54',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '54',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1172 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lied im Volkston', part.name_en = 'Siechentrost-Lieder, op. 54: No. 1. Lied im Volkston',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1172 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:3ec6c7bb-b993-40ef-a990-bc8f70496896' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec6c7bb-b993-40ef-a990-bc8f70496896', 1, NULL, 'Lied im Volkston', 'Siechentrost-Lieder, op. 54: No. 1. Lied im Volkston', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1172 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec6c7bb-b993-40ef-a990-bc8f70496896'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lied', part.name_en = 'Siechentrost-Lieder, op. 54: No. 2. Lied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1172 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:27e35e48-a736-4e31-ad29-63945b8dd037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27e35e48-a736-4e31-ad29-63945b8dd037', 2, NULL, 'Lied', 'Siechentrost-Lieder, op. 54: No. 2. Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1172 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27e35e48-a736-4e31-ad29-63945b8dd037'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duett', part.name_en = 'Siechentrost-Lieder, op. 54: No. 3. Duett',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1172 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6fd88bbc-ace4-44cc-a035-13e7697dcae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fd88bbc-ace4-44cc-a035-13e7697dcae8', 3, NULL, 'Duett', 'Siechentrost-Lieder, op. 54: No. 3. Duett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1172 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fd88bbc-ace4-44cc-a035-13e7697dcae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Duett', part.name_en = 'Siechentrost-Lieder, op. 54: No. 4. Duett',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1172 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:ed14c7ec-0753-4316-8484-309cec6f0949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed14c7ec-0753-4316-8484-309cec6f0949', 4, NULL, 'Duett', 'Siechentrost-Lieder, op. 54: No. 4. Duett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1172 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed14c7ec-0753-4316-8484-309cec6f0949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Schlussgesang. Frühling im Moselthal', part.name_en = 'Siechentrost-Lieder, op. 54: No. 5. Schlussgesang. Frühling im Moselthal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1172 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:87a04def-09a3-46eb-88e1-c2fcd90cf80c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87a04def-09a3-46eb-88e1-c2fcd90cf80c', 5, NULL, 'Schlussgesang. Frühling im Moselthal', 'Siechentrost-Lieder, op. 54: No. 5. Schlussgesang. Frühling im Moselthal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1172 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87a04def-09a3-46eb-88e1-c2fcd90cf80c'
);


-- None String Octet in B-flat major, op. posth.

UPDATE pieces piece
SET piece.title = 'String Octet in B-flat major, op. posth.', piece.title_en = 'String Octet in B-flat major, op. posth.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 883 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'String Octet in B-flat major, op. posth.: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 883 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6b2e3c96-dff5-4c7b-a89b-222e8f4cda93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b2e3c96-dff5-4c7b-a89b-222e8f4cda93', 1, 'I', 'Allegro moderato', 'String Octet in B-flat major, op. posth.: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 883 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b2e3c96-dff5-4c7b-a89b-222e8f4cda93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Octet in B-flat major, op. posth.: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 883 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2d1a0fb5-ea5a-4f33-be1e-a05c7ec571f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d1a0fb5-ea5a-4f33-be1e-a05c7ec571f6', 2, 'II', 'Adagio', 'String Octet in B-flat major, op. posth.: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 883 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d1a0fb5-ea5a-4f33-be1e-a05c7ec571f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'String Octet in B-flat major, op. posth.: III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 883 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:037d7606-44bd-4dae-8832-3a9bacb70bc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:037d7606-44bd-4dae-8832-3a9bacb70bc4', 3, 'III', 'Allegro molto', 'String Octet in B-flat major, op. posth.: III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 883 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:037d7606-44bd-4dae-8832-3a9bacb70bc4'
);


-- None 현악 4중주 C단조

UPDATE pieces piece
SET piece.title = '현악 4중주 C단조', piece.title_en = 'String Quartet in C minor, op. posth.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1415 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio ma non troppo – Allegro molto', part.name_en = 'String Quartet in C minor, op. posth.: I. Adagio ma non troppo – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1415 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0cd78850-7f58-4a81-83a7-6a9fa6af396b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cd78850-7f58-4a81-83a7-6a9fa6af396b', 1, 'I', 'Adagio ma non troppo – Allegro molto', 'String Quartet in C minor, op. posth.: I. Adagio ma non troppo – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1415 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cd78850-7f58-4a81-83a7-6a9fa6af396b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet in C minor, op. posth.: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1415 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b7d3464c-73d1-4dcb-88b6-9f6f448cb315' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7d3464c-73d1-4dcb-88b6-9f6f448cb315', 2, 'II', 'Adagio', 'String Quartet in C minor, op. posth.: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1415 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7d3464c-73d1-4dcb-88b6-9f6f448cb315'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro molto', part.name_en = 'String Quartet in C minor, op. posth.: III. Scherzo. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1415 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:56ebf12a-1511-43f1-b6ff-d525195b286d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56ebf12a-1511-43f1-b6ff-d525195b286d', 3, 'III', 'Scherzo. Allegro molto', 'String Quartet in C minor, op. posth.: III. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1415 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56ebf12a-1511-43f1-b6ff-d525195b286d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Presto agitato', part.name_en = 'String Quartet in C minor, op. posth.: IV. Finale. Presto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1415 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6814e661-fdf1-4a48-ad90-2bbf1dd36b98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6814e661-fdf1-4a48-ad90-2bbf1dd36b98', 4, 'IV', 'Finale. Presto agitato', 'String Quartet in C minor, op. posth.: IV. Finale. Presto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1415 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6814e661-fdf1-4a48-ad90-2bbf1dd36b98'
);


-- Op. 9 현악 4중주 1번 C단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 C단조', piece.title_en = 'String Quartet no. 1 in C minor, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2112 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Allegro ma non troppo', part.name_en = 'String Quartet no. 1 in C minor, op. 9: I. Andante - Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2112 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:50b77627-d052-4649-a897-850bbd14e9ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b77627-d052-4649-a897-850bbd14e9ce', 1, 'I', 'Andante - Allegro ma non troppo', 'String Quartet no. 1 in C minor, op. 9: I. Andante - Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2112 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b77627-d052-4649-a897-850bbd14e9ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet no. 1 in C minor, op. 9: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2112 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2fa90b15-c71f-407f-bdb7-cadcc36069c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fa90b15-c71f-407f-bdb7-cadcc36069c6', 2, 'II', 'Adagio', 'String Quartet no. 1 in C minor, op. 9: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2112 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa90b15-c71f-407f-bdb7-cadcc36069c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto energico', part.name_en = 'String Quartet no. 1 in C minor, op. 9: III. Allegro molto energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2112 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a56df548-800d-4729-b38f-066c8883e9e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56df548-800d-4729-b38f-066c8883e9e1', 3, 'III', 'Allegro molto energico', 'String Quartet no. 1 in C minor, op. 9: III. Allegro molto energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2112 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56df548-800d-4729-b38f-066c8883e9e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto vivace', part.name_en = 'String Quartet no. 1 in C minor, op. 9: IV. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2112 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:98051c36-9eb8-4959-9cc4-e3a28d6eaff4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98051c36-9eb8-4959-9cc4-e3a28d6eaff4', 4, 'IV', 'Molto vivace', 'String Quartet no. 1 in C minor, op. 9: IV. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2112 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98051c36-9eb8-4959-9cc4-e3a28d6eaff4'
);


-- Op. 10 현악 4중주 2번 E장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 E장조', piece.title_en = 'String Quartet no. 2 in E major, op. 10',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1226 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso – Un poco più vivo', part.name_en = 'String Quartet no. 2 in E major, op. 10: I. Allegro maestoso – Un poco più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1226 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bda241e3-7831-4dc9-b5e5-48e772f0afa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bda241e3-7831-4dc9-b5e5-48e772f0afa7', 1, 'I', 'Allegro maestoso – Un poco più vivo', 'String Quartet no. 2 in E major, op. 10: I. Allegro maestoso – Un poco più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1226 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bda241e3-7831-4dc9-b5e5-48e772f0afa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'String Quartet no. 2 in E major, op. 10: II. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1226 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:7553ed58-1c71-47bd-a5f4-223a9846b65e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7553ed58-1c71-47bd-a5f4-223a9846b65e', 2, 'II', 'Andante quasi adagio', 'String Quartet no. 2 in E major, op. 10: II. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1226 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7553ed58-1c71-47bd-a5f4-223a9846b65e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace non troppo – Un poco meno vivo', part.name_en = 'String Quartet no. 2 in E major, op. 10: III. Vivace non troppo – Un poco meno vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1226 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4e0e30aa-83c5-4bc5-bcdc-1a92a578b57d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e0e30aa-83c5-4bc5-bcdc-1a92a578b57d', 3, 'III', 'Vivace non troppo – Un poco meno vivo', 'String Quartet no. 2 in E major, op. 10: III. Vivace non troppo – Un poco meno vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1226 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e0e30aa-83c5-4bc5-bcdc-1a92a578b57d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Vivace', part.name_en = 'String Quartet no. 2 in E major, op. 10: IV. Finale. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1226 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2d635adb-b1f4-46bf-a33f-febda88467d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d635adb-b1f4-46bf-a33f-febda88467d4', 4, 'IV', 'Finale. Vivace', 'String Quartet no. 2 in E major, op. 10: IV. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1226 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d635adb-b1f4-46bf-a33f-febda88467d4'
);


-- None 현악 5중주 A단조

UPDATE pieces piece
SET piece.title = '현악 5중주 A단조', piece.title_en = 'String Quintet in A minor, op. posth.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 919 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'String Quintet in A minor, op. posth.: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 919 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:27b92b6d-fed1-4d85-ba7f-315cf8003a03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27b92b6d-fed1-4d85-ba7f-315cf8003a03', 1, 'I', 'Allegro', 'String Quintet in A minor, op. posth.: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 919 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b92b6d-fed1-4d85-ba7f-315cf8003a03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'String Quintet in A minor, op. posth.: II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 919 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1c70be4a-c5c6-433d-9258-3aa7640c63a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c70be4a-c5c6-433d-9258-3aa7640c63a6', 2, 'II', 'Allegro molto', 'String Quintet in A minor, op. posth.: II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 919 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c70be4a-c5c6-433d-9258-3aa7640c63a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio non troppo', part.name_en = 'String Quintet in A minor, op. posth.: III. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 919 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:477feae5-b9a2-40fa-aa4d-f3a8ce7baf50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:477feae5-b9a2-40fa-aa4d-f3a8ce7baf50', 3, 'III', 'Adagio non troppo', 'String Quintet in A minor, op. posth.: III. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 919 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:477feae5-b9a2-40fa-aa4d-f3a8ce7baf50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'String Quintet in A minor, op. posth.: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 919 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0554aaf0-d358-4b23-b9c0-e7fb376baaea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0554aaf0-d358-4b23-b9c0-e7fb376baaea', 4, 'IV', 'Allegro', 'String Quintet in A minor, op. posth.: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 919 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0554aaf0-d358-4b23-b9c0-e7fb376baaea'
);


-- None 현악 5중주 E♭장조

UPDATE pieces piece
SET piece.title = '현악 5중주 E♭장조', piece.title_en = 'String Quintet in E-flat major, op. posth.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2616 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con moto', part.name_en = 'String Quintet in E-flat major, op. posth.: I. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2616 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b19267b3-728e-421b-9918-a20595ecf31c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b19267b3-728e-421b-9918-a20595ecf31c', 1, 'I', 'Andante con moto', 'String Quintet in E-flat major, op. posth.: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2616 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b19267b3-728e-421b-9918-a20595ecf31c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'String Quintet in E-flat major, op. posth.: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2616 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:17965870-24ac-4f0f-b454-6f71ad68ac43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17965870-24ac-4f0f-b454-6f71ad68ac43', 2, 'II', 'Allegro', 'String Quintet in E-flat major, op. posth.: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2616 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17965870-24ac-4f0f-b454-6f71ad68ac43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'String Quintet in E-flat major, op. posth.: III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2616 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b6c099ff-196e-4a5d-84f6-20baf1a953f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6c099ff-196e-4a5d-84f6-20baf1a953f2', 3, 'III', 'Andante con moto', 'String Quintet in E-flat major, op. posth.: III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2616 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6c099ff-196e-4a5d-84f6-20baf1a953f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante con moto – Allegro ma non troppo vivace', part.name_en = 'String Quintet in E-flat major, op. posth.: IV. Andante con moto – Allegro ma non troppo vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2616 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:021bc86c-408a-48ae-a6f3-f89ee1325e0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:021bc86c-408a-48ae-a6f3-f89ee1325e0d', 4, 'IV', 'Andante con moto – Allegro ma non troppo vivace', 'String Quintet in E-flat major, op. posth.: IV. Andante con moto – Allegro ma non troppo vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2616 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:021bc86c-408a-48ae-a6f3-f89ee1325e0d'
);


-- Op. 88b Suite für Orgel und Orchester

UPDATE pieces piece
SET piece.title = 'Suite für Orgel und Orchester', piece.title_en = 'Suite für Orgel und Orchester, op. 88b',
    piece.type = 'album', piece.opus_number = 'Op. 88b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2742 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Präludium. Langsam und feierlich', part.name_en = 'Suite für Orgel und Orchester, op. 88b: I. Präludium. Langsam und feierlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2742 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:72724673-50aa-4403-a4bf-bf69183d31df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72724673-50aa-4403-a4bf-bf69183d31df', 1, 'I', 'Präludium. Langsam und feierlich', 'Suite für Orgel und Orchester, op. 88b: I. Präludium. Langsam und feierlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2742 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72724673-50aa-4403-a4bf-bf69183d31df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mäßig bewegt - Allegro con fuoco', part.name_en = 'Suite für Orgel und Orchester, op. 88b: II. Mäßig bewegt - Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2742 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b1dd2e35-de96-40b7-8213-1aa20dd8c980' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1dd2e35-de96-40b7-8213-1aa20dd8c980', 2, 'II', 'Mäßig bewegt - Allegro con fuoco', 'Suite für Orgel und Orchester, op. 88b: II. Mäßig bewegt - Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2742 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1dd2e35-de96-40b7-8213-1aa20dd8c980'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturno. Adagio ma non troppo', part.name_en = 'Suite für Orgel und Orchester, op. 88b: III. Nocturno. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2742 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:abfc6d2e-4534-468b-97a2-d732e6f72d72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abfc6d2e-4534-468b-97a2-d732e6f72d72', 3, 'III', 'Nocturno. Adagio ma non troppo', 'Suite für Orgel und Orchester, op. 88b: III. Nocturno. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2742 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abfc6d2e-4534-468b-97a2-d732e6f72d72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Festlicher Ausklang. Langsam und feierlich - Lebhaft, nicht zu schnell', part.name_en = 'Suite für Orgel und Orchester, op. 88b: IV. Festlicher Ausklang. Langsam und feierlich - Lebhaft, nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2742 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9399436f-9581-4131-a8f0-d78871d33f44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9399436f-9581-4131-a8f0-d78871d33f44', 4, 'IV', 'Festlicher Ausklang. Langsam und feierlich - Lebhaft, nicht zu schnell', 'Suite für Orgel und Orchester, op. 88b: IV. Festlicher Ausklang. Langsam und feierlich - Lebhaft, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2742 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9399436f-9581-4131-a8f0-d78871d33f44'
);


-- Op. 79b Suite on Russian Folk Melodies

UPDATE pieces piece
SET piece.title = 'Suite on Russian Folk Melodies', piece.title_en = 'Suite on Russian Folk Melodies, op. 79b',
    piece.type = 'album', piece.opus_number = 'Op. 79b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2157 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Suite on Russian Folk Melodies, op. 79b: I. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2157 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:64f4cde1-822e-4881-b1e7-5d62d940ba0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f4cde1-822e-4881-b1e7-5d62d940ba0f', 1, 'I', 'Andante sostenuto', 'Suite on Russian Folk Melodies, op. 79b: I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2157 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f4cde1-822e-4881-b1e7-5d62d940ba0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ma non troppo lento — Vivace', part.name_en = 'Suite on Russian Folk Melodies, op. 79b: II. Adagio ma non troppo lento — Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2157 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:3b1f3676-8ed2-4173-8355-b86c109fa05d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b1f3676-8ed2-4173-8355-b86c109fa05d', 2, 'II', 'Adagio ma non troppo lento — Vivace', 'Suite on Russian Folk Melodies, op. 79b: II. Adagio ma non troppo lento — Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2157 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b1f3676-8ed2-4173-8355-b86c109fa05d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tanz. Vivace ma non troppo', part.name_en = 'Suite on Russian Folk Melodies, op. 79b: III. Tanz. Vivace ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2157 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:40e77c69-0979-44b4-b0be-47a8dbf22562' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40e77c69-0979-44b4-b0be-47a8dbf22562', 3, 'III', 'Tanz. Vivace ma non troppo', 'Suite on Russian Folk Melodies, op. 79b: III. Tanz. Vivace ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2157 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40e77c69-0979-44b4-b0be-47a8dbf22562'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio sostenuto — Trauermarsch. Andante sostenuto', part.name_en = 'Suite on Russian Folk Melodies, op. 79b: IV. Adagio sostenuto — Trauermarsch. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2157 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:0fe1f643-002e-446c-97d3-1004badd4507' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fe1f643-002e-446c-97d3-1004badd4507', 4, 'IV', 'Adagio sostenuto — Trauermarsch. Andante sostenuto', 'Suite on Russian Folk Melodies, op. 79b: IV. Adagio sostenuto — Trauermarsch. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2157 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fe1f643-002e-446c-97d3-1004badd4507'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro energico, ma non troppo', part.name_en = 'Suite on Russian Folk Melodies, op. 79b: V. Allegro energico, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2157 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:2c56091f-1a1d-4b30-8287-033d67d254dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c56091f-1a1d-4b30-8287-033d67d254dc', 5, 'V', 'Allegro energico, ma non troppo', 'Suite on Russian Folk Melodies, op. 79b: V. Allegro energico, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2157 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c56091f-1a1d-4b30-8287-033d67d254dc'
);


-- Op. 63 Swedish Dances for Piano 4 Hands Op. 63

UPDATE pieces piece
SET piece.title = 'Swedish Dances for Piano 4 Hands Op. 63', piece.title_en = 'Swedish Dances for Piano 4 Hands, op. 63',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '63',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2355 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Schwedischer Tanz in A minor', part.name_en = 'Schwedische Tanz, op. 63: No. 14. Schwedischer Tanz in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2355 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:3b2295de-98a3-4531-b4bc-debddc638c04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b2295de-98a3-4531-b4bc-debddc638c04', 1, NULL, 'Schwedischer Tanz in A minor', 'Schwedische Tanz, op. 63: No. 14. Schwedischer Tanz in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2355 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b2295de-98a3-4531-b4bc-debddc638c04'
);


-- Op. 28 교향곡 1번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 1번 E♭장조', piece.title_en = 'Symphony no. 1 in E-flat major, op. 28',
    piece.type = 'album', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1675 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Symphony no. 1 in E-flat major, op. 28: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1675 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b9c19983-6f43-3dec-9079-a9b17bb4c0a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9c19983-6f43-3dec-9079-a9b17bb4c0a6', 1, 'I', 'Allegro maestoso', 'Symphony no. 1 in E-flat major, op. 28: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1675 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9c19983-6f43-3dec-9079-a9b17bb4c0a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Presto', part.name_en = 'Symphony no. 1 in E-flat major, op. 28: II. Scherzo. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1675 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:75ec5855-2942-3721-9beb-b1755abe89ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75ec5855-2942-3721-9beb-b1755abe89ba', 2, 'II', 'Scherzo. Presto', 'Symphony no. 1 in E-flat major, op. 28: II. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1675 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ec5855-2942-3721-9beb-b1755abe89ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quasi fantasia. Grave', part.name_en = 'Symphony no. 1 in E-flat major, op. 28: III. Quasi fantasia. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1675 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1d02324e-270d-39aa-b26e-45ba0ca1e838' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d02324e-270d-39aa-b26e-45ba0ca1e838', 3, 'III', 'Quasi fantasia. Grave', 'Symphony no. 1 in E-flat major, op. 28: III. Quasi fantasia. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1675 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d02324e-270d-39aa-b26e-45ba0ca1e838'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final. Allegro guerriero', part.name_en = 'Symphony no. 1 in E-flat major, op. 28: IV. Final. Allegro guerriero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1675 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:66d3a01e-4b43-321c-ba57-4b8fafaabea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66d3a01e-4b43-321c-ba57-4b8fafaabea8', 4, 'IV', 'Final. Allegro guerriero', 'Symphony no. 1 in E-flat major, op. 28: IV. Final. Allegro guerriero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1675 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d3a01e-4b43-321c-ba57-4b8fafaabea8'
);


-- Op. 36 교향곡 2번 F단조

UPDATE pieces piece
SET piece.title = '교향곡 2번 F단조', piece.title_en = 'Symphony no. 2 in F minor, op. 36',
    piece.type = 'album', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2740 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro appassionato, ma un poco maestoso', part.name_en = 'Symphony no. 2 in F minor, op. 36: I. Allegro appassionato, ma un poco maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2740 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4058a2b8-8f23-3fdc-ae29-dfafb0dad1f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4058a2b8-8f23-3fdc-ae29-dfafb0dad1f4', 1, 'I', 'Allegro appassionato, ma un poco maestoso', 'Symphony no. 2 in F minor, op. 36: I. Allegro appassionato, ma un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2740 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4058a2b8-8f23-3fdc-ae29-dfafb0dad1f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'Symphony no. 2 in F minor, op. 36: II. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2740 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:60d4014b-0bd3-3f98-bfe0-bb44e4488b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d4014b-0bd3-3f98-bfe0-bb44e4488b78', 2, 'II', 'Adagio ma non troppo', 'Symphony no. 2 in F minor, op. 36: II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2740 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d4014b-0bd3-3f98-bfe0-bb44e4488b78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto tranquillo', part.name_en = 'Symphony no. 2 in F minor, op. 36: III. Allegro molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2740 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:a18991a1-7551-3111-bc28-d1dfcc1db06e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a18991a1-7551-3111-bc28-d1dfcc1db06e', 3, 'III', 'Allegro molto tranquillo', 'Symphony no. 2 in F minor, op. 36: III. Allegro molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2740 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a18991a1-7551-3111-bc28-d1dfcc1db06e'
);


-- Op. 51 교향곡 3번 E장조

UPDATE pieces piece
SET piece.title = '교향곡 3번 E장조', piece.title_en = 'Symphony no. 3 in E major, op. 51',
    piece.type = 'album', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1752 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto - Allegro molto vivace - Adagio', part.name_en = 'Symphony no. 3 in E major, op. 51: I. Andante sostenuto - Allegro molto vivace - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1752 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:193486da-7f45-3b23-b0b2-fe419c4af7e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:193486da-7f45-3b23-b0b2-fe419c4af7e2', 1, 'I', 'Andante sostenuto - Allegro molto vivace - Adagio', 'Symphony no. 3 in E major, op. 51: I. Andante sostenuto - Allegro molto vivace - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1752 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193486da-7f45-3b23-b0b2-fe419c4af7e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio, Adagio ma non troppo', part.name_en = 'Symphony no. 3 in E major, op. 51: II. Adagio, Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1752 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4641889b-c23e-3f9e-95bc-2d636638242a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4641889b-c23e-3f9e-95bc-2d636638242a', 2, 'II', 'Adagio, Adagio ma non troppo', 'Symphony no. 3 in E major, op. 51: II. Adagio, Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1752 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4641889b-c23e-3f9e-95bc-2d636638242a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo, Vivace', part.name_en = 'Symphony no. 3 in E major, op. 51: III. Scherzo, Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1752 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:f53fbd1e-6d25-3be1-9728-7e7ac81eaef1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f53fbd1e-6d25-3be1-9728-7e7ac81eaef1', 3, 'III', 'Scherzo, Vivace', 'Symphony no. 3 in E major, op. 51: III. Scherzo, Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1752 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f53fbd1e-6d25-3be1-9728-7e7ac81eaef1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale, Allegro ma non troppo', part.name_en = 'Symphony no. 3 in E major, op. 51: IV. Finale, Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1752 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1e7992ae-486f-3474-af7b-c9e8fa308364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e7992ae-486f-3474-af7b-c9e8fa308364', 4, 'IV', 'Finale, Allegro ma non troppo', 'Symphony no. 3 in E major, op. 51: IV. Finale, Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1752 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e7992ae-486f-3474-af7b-c9e8fa308364'
);


-- Op. 17 No. 8 가곡 <Tannhäuser>

UPDATE pieces piece
SET piece.title = '가곡 <Tannhäuser>', piece.title_en = 'Tannhäuser, op. 17 no. 8',
    piece.type = 'song', piece.opus_number = 'Op. 17 No. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2916 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 Trio for Violin, Violoncello and Piano in C minor

UPDATE pieces piece
SET piece.title = 'Trio for Violin, Violoncello and Piano in C minor', piece.title_en = 'Trio for Violin, Violoncello and Piano in C minor, op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1588 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Trio for Violin, Violoncello and Piano in C minor, op. 5: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1588 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1bc94d32-4b6f-4b2d-98ce-284a941a6eff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bc94d32-4b6f-4b2d-98ce-284a941a6eff', 1, 'I', 'Andante', 'Trio for Violin, Violoncello and Piano in C minor, op. 5: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1588 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bc94d32-4b6f-4b2d-98ce-284a941a6eff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro assai', part.name_en = 'Trio for Violin, Violoncello and Piano in C minor, op. 5: II. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1588 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:660487b5-0b8c-46f1-9667-6f03033a57f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:660487b5-0b8c-46f1-9667-6f03033a57f7', 2, 'II', 'Allegro assai', 'Trio for Violin, Violoncello and Piano in C minor, op. 5: II. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1588 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:660487b5-0b8c-46f1-9667-6f03033a57f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Trio for Violin, Violoncello and Piano in C minor, op. 5: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1588 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:13e5282f-b15d-492d-b3d2-425a6ed6e647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13e5282f-b15d-492d-b3d2-425a6ed6e647', 3, 'III', 'Presto', 'Trio for Violin, Violoncello and Piano in C minor, op. 5: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1588 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13e5282f-b15d-492d-b3d2-425a6ed6e647'
);


-- Op. 59 No. 1 가곡 <Um Mitternacht>

UPDATE pieces piece
SET piece.title = '가곡 <Um Mitternacht>', piece.title_en = 'Um Mitternacht, op. 59 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 59 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1244 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 26 바이올린 협주곡 1번 G단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vorspiel. Allegro moderato', part.name_en = 'Violin Concerto no. 1 in G minor, op. 26: I. Vorspiel. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 257 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:8f479f07-7fdc-302c-bf32-42a2b31e08ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f479f07-7fdc-302c-bf32-42a2b31e08ab', 1, 'I', 'Vorspiel. Allegro moderato', 'Violin Concerto no. 1 in G minor, op. 26: I. Vorspiel. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 257 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f479f07-7fdc-302c-bf32-42a2b31e08ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Violin Concerto no. 1 in G minor, op. 26: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 257 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:76be660c-c8e6-33c2-868a-cc332d1a3d98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76be660c-c8e6-33c2-868a-cc332d1a3d98', 2, 'II', 'Adagio', 'Violin Concerto no. 1 in G minor, op. 26: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 257 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76be660c-c8e6-33c2-868a-cc332d1a3d98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Allegro energico', part.name_en = 'Violin Concerto no. 1 in G minor, op. 26: III. Finale. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 257 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:b1ce6863-f12d-3fea-a08b-73b0fbd664d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ce6863-f12d-3fea-a08b-73b0fbd664d4', 3, 'III', 'Finale. Allegro energico', 'Violin Concerto no. 1 in G minor, op. 26: III. Finale. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 257 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ce6863-f12d-3fea-a08b-73b0fbd664d4'
);


-- Op. 44 바이올린 협주곡 2번 D단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 D단조', piece.title_en = 'Violin Concerto no. 2 in D minor, op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1656 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'Violin Concerto no. 2 in D minor, op. 44: I. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1656 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1001edda-3ba0-3747-9b28-f75f4759236e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1001edda-3ba0-3747-9b28-f75f4759236e', 1, 'I', 'Adagio ma non troppo', 'Violin Concerto no. 2 in D minor, op. 44: I. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1656 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1001edda-3ba0-3747-9b28-f75f4759236e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Recitativo. Allegro moderato - Allegro - Andante sostenuto', part.name_en = 'Violin Concerto no. 2 in D minor, op. 44: II. Recitativo. Allegro moderato - Allegro - Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1656 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:95062e82-1367-3259-945f-ecf8408bde82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95062e82-1367-3259-945f-ecf8408bde82', 2, 'II', 'Recitativo. Allegro moderato - Allegro - Andante sostenuto', 'Violin Concerto no. 2 in D minor, op. 44: II. Recitativo. Allegro moderato - Allegro - Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1656 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95062e82-1367-3259-945f-ecf8408bde82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Allegro molto', part.name_en = 'Violin Concerto no. 2 in D minor, op. 44: III. Finale. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1656 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:78781c8e-777b-3b9a-825d-56757781b83d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78781c8e-777b-3b9a-825d-56757781b83d', 3, 'III', 'Finale. Allegro molto', 'Violin Concerto no. 2 in D minor, op. 44: III. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1656 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78781c8e-777b-3b9a-825d-56757781b83d'
);


-- Op. 58 바이올린 협주곡 3번 D단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 3번 D단조', piece.title_en = 'Violin Concerto no. 3 in D minor, op. 58',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2334 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro energico', part.name_en = 'Violin Concerto no. 3 in D minor, op. 58: I. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2334 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4eab60b0-8f14-3e04-b905-ae14a8a75860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eab60b0-8f14-3e04-b905-ae14a8a75860', 1, 'I', 'Allegro energico', 'Violin Concerto no. 3 in D minor, op. 58: I. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2334 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eab60b0-8f14-3e04-b905-ae14a8a75860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Violin Concerto no. 3 in D minor, op. 58: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2334 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:228d84ee-dd84-340d-86a2-710ee5886407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:228d84ee-dd84-340d-86a2-710ee5886407', 2, 'II', 'Adagio', 'Violin Concerto no. 3 in D minor, op. 58: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2334 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:228d84ee-dd84-340d-86a2-710ee5886407'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Allegro molto', part.name_en = 'Violin Concerto no. 3 in D minor, op. 58: III. Finale. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2334 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4883fe91-96ef-351d-b1a4-6de26a270503' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4883fe91-96ef-351d-b1a4-6de26a270503', 3, 'III', 'Finale. Allegro molto', 'Violin Concerto no. 3 in D minor, op. 58: III. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2334 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4883fe91-96ef-351d-b1a4-6de26a270503'
);


-- Op. 17 No. 4 가곡 <Von den Rosen komm’ ich>

UPDATE pieces piece
SET piece.title = '가곡 <Von den Rosen komm’ ich>', piece.title_en = 'Von den Rosen komm’ ich, op. 17 no. 4',
    piece.type = 'song', piece.opus_number = 'Op. 17 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2013 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wettspiele zu Ehren des Patroklus

UPDATE pieces piece
SET piece.title = 'Wettspiele zu Ehren des Patroklus', piece.title_en = 'Wettspiele zu Ehren des Patroklus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2564 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Erste Fanfare', part.name_en = 'Wettspiele zu Ehren des Patroklus: Erste Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d9c67257-abe8-4162-bd69-923d0ace9767' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9c67257-abe8-4162-bd69-923d0ace9767', 1, NULL, 'Erste Fanfare', 'Wettspiele zu Ehren des Patroklus: Erste Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9c67257-abe8-4162-bd69-923d0ace9767'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ringkämpfer', part.name_en = 'Wettspiele zu Ehren des Patroklus: Ringkämpfer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9332990d-41bf-40e2-bfbf-f8b92d052e77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9332990d-41bf-40e2-bfbf-f8b92d052e77', 2, NULL, 'Ringkämpfer', 'Wettspiele zu Ehren des Patroklus: Ringkämpfer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9332990d-41bf-40e2-bfbf-f8b92d052e77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Zweite Fanfare', part.name_en = 'Wettspiele zu Ehren des Patroklus: Zweite Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:1d47d80f-aaad-4f5b-8400-056228e6a8dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d47d80f-aaad-4f5b-8400-056228e6a8dc', 3, NULL, 'Zweite Fanfare', 'Wettspiele zu Ehren des Patroklus: Zweite Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d47d80f-aaad-4f5b-8400-056228e6a8dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Wagenrennen', part.name_en = 'Wettspiele zu Ehren des Patroklus: Wagenrennen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:732b90fa-b519-4dbc-bcd1-272f9c232c98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:732b90fa-b519-4dbc-bcd1-272f9c232c98', 4, NULL, 'Wagenrennen', 'Wettspiele zu Ehren des Patroklus: Wagenrennen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:732b90fa-b519-4dbc-bcd1-272f9c232c98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dritte Fanfare', part.name_en = 'Wettspiele zu Ehren des Patroklus: Dritte Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:6fe08c0f-35e6-4535-bc13-02008f606721' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fe08c0f-35e6-4535-bc13-02008f606721', 5, NULL, 'Dritte Fanfare', 'Wettspiele zu Ehren des Patroklus: Dritte Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe08c0f-35e6-4535-bc13-02008f606721'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Die Sieger', part.name_en = 'Wettspiele zu Ehren des Patroklus: Die Sieger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2564 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:9d65c416-56af-4288-bdbd-d94c96636ec0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d65c416-56af-4288-bdbd-d94c96636ec0', 6, NULL, 'Die Sieger', 'Wettspiele zu Ehren des Patroklus: Die Sieger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2564 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d65c416-56af-4288-bdbd-d94c96636ec0'
);


-- None Zwölf Walisische Lieder

UPDATE pieces piece
SET piece.title = 'Zwölf Walisische Lieder', piece.title_en = 'Zwölf Walisische Lieder',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2445 AND piece.composer_id = 61
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Heimweh', part.name_en = 'Zwölf Walisische Lieder: Heimweh',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:17638fd8-4996-412f-b4a1-e685742f0cc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17638fd8-4996-412f-b4a1-e685742f0cc0', 1, NULL, 'Heimweh', 'Zwölf Walisische Lieder: Heimweh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17638fd8-4996-412f-b4a1-e685742f0cc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tanzlied', part.name_en = 'Zwölf Walisische Lieder: Tanzlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:27db6c39-7e0e-47be-ab11-445c7e5a396e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27db6c39-7e0e-47be-ab11-445c7e5a396e', 2, NULL, 'Tanzlied', 'Zwölf Walisische Lieder: Tanzlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27db6c39-7e0e-47be-ab11-445c7e5a396e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Taliesins Weissagung', part.name_en = 'Zwölf Walisische Lieder: Taliesins Weissagung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:3654ef99-4ea6-4b6d-bb94-51fc0ff1d265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3654ef99-4ea6-4b6d-bb94-51fc0ff1d265', 3, NULL, 'Taliesins Weissagung', 'Zwölf Walisische Lieder: Taliesins Weissagung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3654ef99-4ea6-4b6d-bb94-51fc0ff1d265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Walisisches Kriegslied', part.name_en = 'Zwölf Walisische Lieder: Walisisches Kriegslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:3c09ff13-3892-4c3f-ad4d-615c2c41a966' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c09ff13-3892-4c3f-ad4d-615c2c41a966', 4, NULL, 'Walisisches Kriegslied', 'Zwölf Walisische Lieder: Walisisches Kriegslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c09ff13-3892-4c3f-ad4d-615c2c41a966'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Abschied von der Heimat', part.name_en = 'Zwölf Walisische Lieder: Abschied von der Heimat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:423973b9-99b2-4eaa-91c2-fa24c18bcfb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:423973b9-99b2-4eaa-91c2-fa24c18bcfb8', 5, NULL, 'Abschied von der Heimat', 'Zwölf Walisische Lieder: Abschied von der Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:423973b9-99b2-4eaa-91c2-fa24c18bcfb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Die Glocken von Aberdovey', part.name_en = 'Zwölf Walisische Lieder: Die Glocken von Aberdovey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:4c626a4a-d89c-47f1-a198-ab5b57b33ffa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c626a4a-d89c-47f1-a198-ab5b57b33ffa', 6, NULL, 'Die Glocken von Aberdovey', 'Zwölf Walisische Lieder: Die Glocken von Aberdovey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c626a4a-d89c-47f1-a198-ab5b57b33ffa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Kriegsgesang', part.name_en = 'Zwölf Walisische Lieder: Kriegsgesang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:7810acac-11f3-475b-a93e-e9a5072db52f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7810acac-11f3-475b-a93e-e9a5072db52f', 7, NULL, 'Kriegsgesang', 'Zwölf Walisische Lieder: Kriegsgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7810acac-11f3-475b-a93e-e9a5072db52f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Kriegslied der Männer von Glamorgan', part.name_en = 'Zwölf Walisische Lieder: Kriegslied der Männer von Glamorgan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:bb080ba1-253f-47e4-8f46-e418433024ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb080ba1-253f-47e4-8f46-e418433024ba', 8, NULL, 'Kriegslied der Männer von Glamorgan', 'Zwölf Walisische Lieder: Kriegslied der Männer von Glamorgan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb080ba1-253f-47e4-8f46-e418433024ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Abendständchen', part.name_en = 'Zwölf Walisische Lieder: Abendständchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:cdf85793-302d-4932-a440-11b651114003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf85793-302d-4932-a440-11b651114003', 9, NULL, 'Abendständchen', 'Zwölf Walisische Lieder: Abendständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf85793-302d-4932-a440-11b651114003'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Die Nachtigall', part.name_en = 'Zwölf Walisische Lieder: Die Nachtigall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:d8bdf1f8-3fa7-4021-a3dd-7eee11f7b2c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bdf1f8-3fa7-4021-a3dd-7eee11f7b2c5', 10, NULL, 'Die Nachtigall', 'Zwölf Walisische Lieder: Die Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bdf1f8-3fa7-4021-a3dd-7eee11f7b2c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Liebeslied', part.name_en = 'Zwölf Walisische Lieder: Liebeslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:ec82e692-b5ee-4a51-84c6-cfebccc449eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec82e692-b5ee-4a51-84c6-cfebccc449eb', 11, NULL, 'Liebeslied', 'Zwölf Walisische Lieder: Liebeslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec82e692-b5ee-4a51-84c6-cfebccc449eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Der sterbende Barde', part.name_en = 'Zwölf Walisische Lieder: Der sterbende Barde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2445 AND p.composer_id = 61 AND part.part_key = 'musicbrainz:fc26b465-6e84-4415-9cea-c4218ee45f55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc26b465-6e84-4415-9cea-c4218ee45f55', 12, NULL, 'Der sterbende Barde', 'Zwölf Walisische Lieder: Der sterbende Barde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2445 AND p.composer_id = 61
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc26b465-6e84-4415-9cea-c4218ee45f55'
);


-- Op. 55 Canzone

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Canzone', 'Canzone, op. 55', 'song', 'Op. 55', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 61
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Canzone'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '874d98d4-a1ed-38a0-a415-1df63ea9f698'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '874d98d4-a1ed-38a0-a415-1df63ea9f698'
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Canzone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '874d98d4-a1ed-38a0-a415-1df63ea9f698'
);


-- Op. 42 로망스 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 A단조', 'Romance in A minor, op. 42', 'song', 'Op. 42', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 61
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a58c3bb-a660-390d-8a63-935e4568ce00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a58c3bb-a660-390d-8a63-935e4568ce00'
FROM pieces p
WHERE p.composer_id = 61 AND p.title = '로망스 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a58c3bb-a660-390d-8a63-935e4568ce00'
);


-- Op. 85 로망스 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 F장조', 'Romance in F major, op. 85', 'song', 'Op. 85', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 61
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d21fbf-4331-3fda-a544-e27160893fe6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9d21fbf-4331-3fda-a544-e27160893fe6'
FROM pieces p
WHERE p.composer_id = 61 AND p.title = '로망스 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9d21fbf-4331-3fda-a544-e27160893fe6'
);


-- Op. 63 Swedish Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Swedish Dances', 'Swedish Dances, op. 63', 'album', 'Op. 63', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 61
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Swedish Dances'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e8ae324-be75-4adc-97dd-68cc2ff31120'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e8ae324-be75-4adc-97dd-68cc2ff31120'
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e8ae324-be75-4adc-97dd-68cc2ff31120'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68eb64ce-fb1a-4952-9ed9-a7022fe2ea1d', 1, 'I', 'Introduction: Langsam', 'Swedish Dances, op. 63: I. Introduction: Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68eb64ce-fb1a-4952-9ed9-a7022fe2ea1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c3bfa1c-4de4-4b6f-83c4-e95e3f578fa9', 2, 'II', 'Sehr mässig', 'Swedish Dances, op. 63: II. No. 1: Sehr mässig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c3bfa1c-4de4-4b6f-83c4-e95e3f578fa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:351e29d9-6c85-43b4-a39a-4b82bf8552e1', 3, 'III', 'Ruhig bewegt', 'Swedish Dances, op. 63: III. No. 2: Ruhig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:351e29d9-6c85-43b4-a39a-4b82bf8552e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffbde334-522d-4dd8-9a8b-cc6c93cbe951', 4, 'IV', 'Frisch, nicht zu schnell', 'Swedish Dances, op. 63: IV. No. 3: Frisch, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffbde334-522d-4dd8-9a8b-cc6c93cbe951'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52827313-c904-42e3-9467-1121e2cbea65', 5, 'V', 'Langsam, nicht schleppend', 'Swedish Dances, op. 63: V. No. 4: Langsam, nicht schleppend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52827313-c904-42e3-9467-1121e2cbea65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfc121c4-89f5-40e8-9879-d001dd570765', 6, 'VI', 'Ziemlich schnell', 'Swedish Dances, op. 63: VI. No. 5: Ziemlich schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfc121c4-89f5-40e8-9879-d001dd570765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be42f0e-e394-423c-b566-18b329f95ece', 7, 'VII', 'Langsam, mit Ausdruck', 'Swedish Dances, op. 63: VII. No. 6: Langsam, mit Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be42f0e-e394-423c-b566-18b329f95ece'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeeccef1-8fb7-4fd5-92fa-16098e6c7132', 8, 'VIII', 'Lebhaft', 'Swedish Dances, op. 63: VIII. No. 7: Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeeccef1-8fb7-4fd5-92fa-16098e6c7132'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80ee258a-8b9e-41a3-a7ef-6637ba4d59c6', 9, 'IX', 'Sehr mässig', 'Swedish Dances, op. 63: IX. No. 8: Sehr mässig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80ee258a-8b9e-41a3-a7ef-6637ba4d59c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:431afdaf-70dd-41a4-aaba-11e36b0b6240', 10, 'X', 'Lebhaft', 'Swedish Dances, op. 63: X. No. 9: Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:431afdaf-70dd-41a4-aaba-11e36b0b6240'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:214de342-6d54-4e75-ba57-a2931aa62a6a', 11, 'XI', 'Frisch, nicht zu schnell', 'Swedish Dances, op. 63: XI. No. 10: Frisch, nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:214de342-6d54-4e75-ba57-a2931aa62a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31ec8c2f-3654-4226-bf9e-f8cf07fdc357', 12, 'XII', 'Sehr mässig', 'Swedish Dances, op. 63: XII. No. 11: Sehr mässig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31ec8c2f-3654-4226-bf9e-f8cf07fdc357'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a342b19-9cd8-4daf-ae91-6784bc4fbc74', 13, 'XIII', 'Langsam, nicht schleppend', 'Swedish Dances, op. 63: XIII. No. 12: Langsam, nicht schleppend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a342b19-9cd8-4daf-ae91-6784bc4fbc74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ecb04f-e478-4f8d-a820-7daf7c7fa985', 14, 'XIV', 'Sehr mässig', 'Swedish Dances, op. 63: XIV. No. 13: Sehr mässig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ecb04f-e478-4f8d-a820-7daf7c7fa985'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f258955c-97b8-4b0f-9c87-f706def60f86', 15, 'XV', 'Gehend, ruhig bewegt', 'Swedish Dances, op. 63: XV. No. 14: Gehend, ruhig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f258955c-97b8-4b0f-9c87-f706def60f86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ea1e639-c7ce-4507-a482-d312c50814a6', 16, 'XVI', 'Sehr mässig', 'Swedish Dances, op. 63: XVI. No. 15: Sehr mässig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 61 AND p.title = 'Swedish Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea1e639-c7ce-4507-a482-d312c50814a6'
);


-- 카탈로그에 대응이 없는 seed 작품 5개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 61 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    644, 1230, 1790, 2267, 2654
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
