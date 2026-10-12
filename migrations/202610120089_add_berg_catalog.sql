-- 베르크 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 73개(묶음 2, 다악장 8, 낱곡 63),
-- 새 작품 6개, part 38개, 그 아래 32개.
-- seed 77개 중 65개를 작품·part 에 잇고, 10개를 숨기고, 2개는 그대로 둔다.
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

-- None 14 Variationen über ein eigenes Thema f-Moll

UPDATE pieces piece
SET piece.title = '14 Variationen über ein eigenes Thema f-Moll', piece.title_en = '14 Variationen über ein eigenes Thema f-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12562 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 4 Gesänge Op. 2

UPDATE pieces piece
SET piece.title = '4 Gesänge Op. 2', piece.title_en = '4 Gesänge, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12557 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dem Schmerz sein Recht, op. 2 no. 1', part.name_en = 'Dem Schmerz sein Recht, op. 2 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12557 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:cea24317-668f-42cd-85f4-4169f6303cf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea24317-668f-42cd-85f4-4169f6303cf7', 1, NULL, 'Dem Schmerz sein Recht, op. 2 no. 1', 'Dem Schmerz sein Recht, op. 2 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12557 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea24317-668f-42cd-85f4-4169f6303cf7'
);


-- Op. 4 5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg

UPDATE pieces piece
SET piece.title = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg', piece.title_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12023 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"Seele, wie bist du schöner"', part.name_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: I. "Seele, wie bist du schöner"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12023 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:c50774bb-580c-4c51-8537-73d8eff7f671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c50774bb-580c-4c51-8537-73d8eff7f671', 1, 'I', '"Seele, wie bist du schöner"', '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: I. "Seele, wie bist du schöner"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12023 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c50774bb-580c-4c51-8537-73d8eff7f671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Sahst du nach dem Gewitterregen den Wald"', part.name_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: II. "Sahst du nach dem Gewitterregen den Wald"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12023 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:4206922f-dbb5-4e33-9228-196463fb3088' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4206922f-dbb5-4e33-9228-196463fb3088', 2, 'II', '"Sahst du nach dem Gewitterregen den Wald"', '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: II. "Sahst du nach dem Gewitterregen den Wald"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12023 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4206922f-dbb5-4e33-9228-196463fb3088'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Über die Grenzen des All"', part.name_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: III. "Über die Grenzen des All"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12023 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:42ce8fc8-c2d2-4827-b81a-829362fe42c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42ce8fc8-c2d2-4827-b81a-829362fe42c3', 3, 'III', '"Über die Grenzen des All"', '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: III. "Über die Grenzen des All"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12023 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ce8fc8-c2d2-4827-b81a-829362fe42c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Nichts ist gekommen"', part.name_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: IV. "Nichts ist gekommen"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12023 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:f8545f8b-d710-4e11-8eef-710fbfd3fb90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8545f8b-d710-4e11-8eef-710fbfd3fb90', 4, 'IV', '"Nichts ist gekommen"', '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: IV. "Nichts ist gekommen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12023 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8545f8b-d710-4e11-8eef-710fbfd3fb90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Hier ist Friede"', part.name_en = '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: V. "Hier ist Friede"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12023 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:f013b3bc-995c-41a5-ab80-e6198fe62c78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f013b3bc-995c-41a5-ab80-e6198fe62c78', 5, 'V', '"Hier ist Friede"', '5 Orchesterlieder nach Ansichtskartentexten von Peter Altenberg, op. 4: V. "Hier ist Friede"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12023 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f013b3bc-995c-41a5-ab80-e6198fe62c78'
);


-- None 가곡 <Abschied>

UPDATE pieces piece
SET piece.title = '가곡 <Abschied>', piece.title_en = 'Abschied',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12988 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alban Berg an das Frankfurter Opernhaus

UPDATE pieces piece
SET piece.title = 'Alban Berg an das Frankfurter Opernhaus', piece.title_en = 'Alban Berg an das Frankfurter Opernhaus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13654 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Am Abend>

UPDATE pieces piece
SET piece.title = '가곡 <Am Abend>', piece.title_en = 'Am Abend',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13594 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Am Strande>

UPDATE pieces piece
SET piece.title = '가곡 <Am Strande>', piece.title_en = 'Am Strande',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12762 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Augenblicke>

UPDATE pieces piece
SET piece.title = '가곡 <Augenblicke>', piece.title_en = 'Augenblicke',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12138 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Concerto

UPDATE pieces piece
SET piece.title = 'Chamber Concerto', piece.title_en = 'Chamber Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12560 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Thema scherzoso con variazioni', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5', 1, 'I', 'Thema scherzoso con variazioni', 'Chamber Concerto: I. Thema scherzoso con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Motto', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Motto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:69cbcd45-c414-36de-b3fa-5b47050dc978' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69cbcd45-c414-36de-b3fa-5b47050dc978', 1, NULL, 'Motto', 'Chamber Concerto: I. Thema scherzoso con variazioni: Motto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69cbcd45-c414-36de-b3fa-5b47050dc978'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Thema scherzoso', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Thema scherzoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:bc41f60e-97bd-36a8-a0c1-4bf066439a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc41f60e-97bd-36a8-a0c1-4bf066439a0a', 2, NULL, 'Thema scherzoso', 'Chamber Concerto: I. Thema scherzoso con variazioni: Thema scherzoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc41f60e-97bd-36a8-a0c1-4bf066439a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation I', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:df65f1c6-bc18-3711-8ff6-523be0fdd139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df65f1c6-bc18-3711-8ff6-523be0fdd139', 3, NULL, 'Variation I', 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df65f1c6-bc18-3711-8ff6-523be0fdd139'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation II: Langsames walzertempo', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation II: Langsames walzertempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:051213ae-bc1c-3eca-a701-eddb256f49e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:051213ae-bc1c-3eca-a701-eddb256f49e3', 4, NULL, 'Variation II: Langsames walzertempo', 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation II: Langsames walzertempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:051213ae-bc1c-3eca-a701-eddb256f49e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation III: Kräftig bewegt', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation III: Kräftig bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:4e8526f7-142b-30d7-aaf7-cf7d42d03e19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e8526f7-142b-30d7-aaf7-cf7d42d03e19', 5, NULL, 'Variation III: Kräftig bewegt', 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation III: Kräftig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8526f7-142b-30d7-aaf7-cf7d42d03e19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation IV: Sehr rasch', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation IV: Sehr rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:a116b6cd-6ed1-3b87-a66b-19a660c11a41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a116b6cd-6ed1-3b87-a66b-19a660c11a41', 6, NULL, 'Variation IV: Sehr rasch', 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation IV: Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a116b6cd-6ed1-3b87-a66b-19a660c11a41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation V: (Tempo primo)', part.name_en = 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation V: (Tempo primo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:42c6f9e7-da6a-38af-995d-85c09997ea91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42c6f9e7-da6a-38af-995d-85c09997ea91', 7, NULL, 'Variation V: (Tempo primo)', 'Chamber Concerto: I. Thema scherzoso con variazioni: Variation V: (Tempo primo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d15a8c0-b9c8-442b-88b7-d0c0bf4898e5'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c6f9e7-da6a-38af-995d-85c09997ea91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Chamber Concerto: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:e2ecf6d9-2ae3-377f-b36c-c089d1682b97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2ecf6d9-2ae3-377f-b36c-c089d1682b97', 2, 'II', 'Adagio', 'Chamber Concerto: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2ecf6d9-2ae3-377f-b36c-c089d1682b97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo ritmico con introduzione', part.name_en = 'Chamber Concerto: III. Rondo ritmico con introduzione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81', 3, 'III', 'Rondo ritmico con introduzione', 'Chamber Concerto: III. Rondo ritmico con introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduzione: Introduzione', part.name_en = 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Introduzione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:c3153c80-fcb1-3a4b-a97e-16643208aaeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3153c80-fcb1-3a4b-a97e-16643208aaeb', 1, NULL, 'Introduzione: Introduzione', 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3153c80-fcb1-3a4b-a97e-16643208aaeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Introduzione: Rondo ritmico', part.name_en = 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Rondo ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:370de57e-44dc-33dd-8b42-4dec180ae86a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:370de57e-44dc-33dd-8b42-4dec180ae86a', 2, NULL, 'Introduzione: Rondo ritmico', 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Rondo ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:370de57e-44dc-33dd-8b42-4dec180ae86a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Introduzione: Coda', part.name_en = 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12560 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:6498f84d-e5fc-3b0e-a173-5cfc94e95606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6498f84d-e5fc-3b0e-a173-5cfc94e95606', 3, NULL, 'Introduzione: Coda', 'Chamber Concerto: III. Rondo ritmico con introduzione: Introduzione: Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:25dea435-5743-4617-b376-79acc0b40c81'
WHERE p.id = 12560 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6498f84d-e5fc-3b0e-a173-5cfc94e95606'
);


-- None 가곡 <Das stille Königreich>

UPDATE pieces piece
SET piece.title = '가곡 <Das stille Königreich>', piece.title_en = 'Das stille Königreich',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13624 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Die Näherin>

UPDATE pieces piece
SET piece.title = '가곡 <Die Näherin>', piece.title_en = 'Die Näherin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12652 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Die Sorglichen>

UPDATE pieces piece
SET piece.title = '가곡 <Die Sorglichen>', piece.title_en = 'Die Sorglichen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12712 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 Drei Orchesterstücke

UPDATE pieces piece
SET piece.title = 'Drei Orchesterstücke', piece.title_en = 'Drei Orchesterstücke, op. 6',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13840 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Präludium', part.name_en = 'Drei Orchesterstücke, op. 6: I. Präludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13840 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:330e3d76-ee05-4da7-b4e1-b1b99fba3464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:330e3d76-ee05-4da7-b4e1-b1b99fba3464', 1, 'I', 'Präludium', 'Drei Orchesterstücke, op. 6: I. Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13840 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330e3d76-ee05-4da7-b4e1-b1b99fba3464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Reigen', part.name_en = 'Drei Orchesterstücke, op. 6: II. Reigen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13840 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:1674d0a8-f7f6-4da4-88ce-963b4204c1fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1674d0a8-f7f6-4da4-88ce-963b4204c1fc', 2, 'II', 'Reigen', 'Drei Orchesterstücke, op. 6: II. Reigen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13840 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1674d0a8-f7f6-4da4-88ce-963b4204c1fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marsch', part.name_en = 'Drei Orchesterstücke, op. 6: III. Marsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13840 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:029c35c1-2d79-4dea-87bd-9e28c43503ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:029c35c1-2d79-4dea-87bd-9e28c43503ae', 3, 'III', 'Marsch', 'Drei Orchesterstücke, op. 6: III. Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13840 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:029c35c1-2d79-4dea-87bd-9e28c43503ae'
);


-- None 가곡 <Er klagt, daß der Frühling so kortz blüht>

UPDATE pieces piece
SET piece.title = '가곡 <Er klagt, daß der Frühling so kortz blüht>', piece.title_en = 'Er klagt, daß der Frühling so kortz blüht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12073 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Erster Verlust>

UPDATE pieces piece
SET piece.title = '가곡 <Erster Verlust>', piece.title_en = 'Erster Verlust',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12718 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Es wandelt, was wir schauen>

UPDATE pieces piece
SET piece.title = '가곡 <Es wandelt, was wir schauen>', piece.title_en = 'Es wandelt, was wir schauen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12672 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Eure Weisheit>

UPDATE pieces piece
SET piece.title = '가곡 <Eure Weisheit>', piece.title_en = 'Eure Weisheit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12407 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ferne Lieder>

UPDATE pieces piece
SET piece.title = '가곡 <Ferne Lieder>', piece.title_en = 'Ferne Lieder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12285 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Flötenspielerin>

UPDATE pieces piece
SET piece.title = '가곡 <Flötenspielerin>', piece.title_en = 'Flötenspielerin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13295 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fraue, du Süße>

UPDATE pieces piece
SET piece.title = '가곡 <Fraue, du Süße>', piece.title_en = 'Fraue, du Süße',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13288 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Geliebte Schöne>

UPDATE pieces piece
SET piece.title = '가곡 <Geliebte Schöne>', piece.title_en = 'Geliebte Schöne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12923 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Grabschrift>

UPDATE pieces piece
SET piece.title = '가곡 <Grabschrift>', piece.title_en = 'Grabschrift',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13012 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Grenzen der Menschheit>

UPDATE pieces piece
SET piece.title = '가곡 <Grenzen der Menschheit>', piece.title_en = 'Grenzen der Menschheit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13475 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Herbstgefühl>

UPDATE pieces piece
SET piece.title = '가곡 <Herbstgefühl>', piece.title_en = 'Herbstgefühl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13026 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hoffnung>

UPDATE pieces piece
SET piece.title = '가곡 <Hoffnung>', piece.title_en = 'Hoffnung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12899 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ich will die Fluren meiden>

UPDATE pieces piece
SET piece.title = '가곡 <Ich will die Fluren meiden>', piece.title_en = 'Ich will die Fluren meiden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12662 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Im Morgengrauen>

UPDATE pieces piece
SET piece.title = '가곡 <Im Morgengrauen>', piece.title_en = 'Im Morgengrauen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13593 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impromptu c-Moll - Sehr aufgeregt

UPDATE pieces piece
SET piece.title = 'Impromptu c-Moll - Sehr aufgeregt', piece.title_en = 'Impromptu c-Moll - Sehr aufgeregt',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12276 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück F-Dur

UPDATE pieces piece
SET piece.title = 'Klavierstück F-Dur', piece.title_en = 'Klavierstück F-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12849 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück c-Moll

UPDATE pieces piece
SET piece.title = 'Klavierstück c-Moll', piece.title_en = 'Klavierstück c-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13118 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück f-Moll

UPDATE pieces piece
SET piece.title = 'Klavierstück f-Moll', piece.title_en = 'Klavierstück f-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13542 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück h-Moll

UPDATE pieces piece
SET piece.title = 'Klavierstück h-Moll', piece.title_en = 'Klavierstück h-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12794 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Klavierstück in B Minor

UPDATE pieces piece
SET piece.title = 'Klavierstück in B Minor', piece.title_en = 'Klavierstück in B Minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13318 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Leukon>

UPDATE pieces piece
SET piece.title = '가곡 <Leukon>', piece.title_en = 'Leukon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13692 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Liebe>

UPDATE pieces piece
SET piece.title = '가곡 <Liebe>', piece.title_en = 'Liebe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13715 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lied der Schiffermädels>

UPDATE pieces piece
SET piece.title = '가곡 <Lied der Schiffermädels>', piece.title_en = 'Lied der Schiffermädels',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12843 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lyrische Suite

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto giovale', part.name_en = 'Lyrische Suite: I. Allegretto giovale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:29b85172-ff2a-3a11-b0c8-c090f5e93e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29b85172-ff2a-3a11-b0c8-c090f5e93e59', 1, 'I', 'Allegretto giovale', 'Lyrische Suite: I. Allegretto giovale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29b85172-ff2a-3a11-b0c8-c090f5e93e59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante amoroso', part.name_en = 'Lyrische Suite: II. Andante amoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:d9e1150e-0b31-33e5-9c78-1f653748b1dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9e1150e-0b31-33e5-9c78-1f653748b1dc', 2, 'II', 'Andante amoroso', 'Lyrische Suite: II. Andante amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9e1150e-0b31-33e5-9c78-1f653748b1dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro misterioso', part.name_en = 'Lyrische Suite: III. Allegro misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:6e24d6ba-6e67-3933-a9f4-938665323d44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e24d6ba-6e67-3933-a9f4-938665323d44', 3, 'III', 'Allegro misterioso', 'Lyrische Suite: III. Allegro misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e24d6ba-6e67-3933-a9f4-938665323d44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio appassionato', part.name_en = 'Lyrische Suite: IV. Adagio appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:8aa50ecf-3959-3c4c-9ab5-51dec0004b25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aa50ecf-3959-3c4c-9ab5-51dec0004b25', 4, 'IV', 'Adagio appassionato', 'Lyrische Suite: IV. Adagio appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aa50ecf-3959-3c4c-9ab5-51dec0004b25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Presto delirando', part.name_en = 'Lyrische Suite: V. Presto delirando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:471c9503-c5ec-32e6-91e1-d99b73908af3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:471c9503-c5ec-32e6-91e1-d99b73908af3', 5, 'V', 'Presto delirando', 'Lyrische Suite: V. Presto delirando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:471c9503-c5ec-32e6-91e1-d99b73908af3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Largo desolato', part.name_en = 'Lyrische Suite: VI. Largo desolato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 366 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:a4403d10-0dd1-387e-9d66-e12e4197e7d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4403d10-0dd1-387e-9d66-e12e4197e7d6', 6, 'VI', 'Largo desolato', 'Lyrische Suite: VI. Largo desolato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 366 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4403d10-0dd1-387e-9d66-e12e4197e7d6'
);


-- None Menuett F-Dur

UPDATE pieces piece
SET piece.title = 'Menuett F-Dur', piece.title_en = 'Menuett F-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12202 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Menuett c-Moll

UPDATE pieces piece
SET piece.title = 'Menuett c-Moll', piece.title_en = 'Menuett c-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12513 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mignon>

UPDATE pieces piece
SET piece.title = '가곡 <Mignon>', piece.title_en = 'Mignon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12972 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Regen>

UPDATE pieces piece
SET piece.title = '가곡 <Regen>', piece.title_en = 'Regen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12258 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Schattenleben>

UPDATE pieces piece
SET piece.title = '가곡 <Schattenleben>', piece.title_en = 'Schattenleben',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13562 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scherzo c-Moll

UPDATE pieces piece
SET piece.title = 'Scherzo c-Moll', piece.title_en = 'Scherzo c-Moll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13040 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sehnsucht I>

UPDATE pieces piece
SET piece.title = '가곡 <Sehnsucht I>', piece.title_en = 'Sehnsucht I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13547 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sehnsucht II>

UPDATE pieces piece
SET piece.title = '가곡 <Sehnsucht II>', piece.title_en = 'Sehnsucht II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13081 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <So regnet es sich langsam ein>

UPDATE pieces piece
SET piece.title = '가곡 <So regnet es sich langsam ein>', piece.title_en = 'So regnet es sich langsam ein',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13109 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate Es-Dur (fragment)

UPDATE pieces piece
SET piece.title = 'Sonate Es-Dur (fragment)', piece.title_en = 'Sonate Es-Dur (fragment)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12656 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate d-Moll (fragment)

UPDATE pieces piece
SET piece.title = 'Sonate d-Moll (fragment)', piece.title_en = 'Sonate d-Moll (fragment)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13441 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonate g-Moll (Fragment)

UPDATE pieces piece
SET piece.title = 'Sonate g-Moll (Fragment)', piece.title_en = 'Sonate g-Moll (Fragment)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12141 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonatentwurf (Klavierstück) f-Moll (fragment)

UPDATE pieces piece
SET piece.title = 'Sonatentwurf (Klavierstück) f-Moll (fragment)', piece.title_en = 'Sonatentwurf (Klavierstück) f-Moll (fragment)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12917 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Spaziergang>

UPDATE pieces piece
SET piece.title = '가곡 <Spaziergang>', piece.title_en = 'Spaziergang',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13185 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Spielleute>

UPDATE pieces piece
SET piece.title = '가곡 <Spielleute>', piece.title_en = 'Spielleute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12205 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sternenfall>

UPDATE pieces piece
SET piece.title = '가곡 <Sternenfall>', piece.title_en = 'Sternenfall',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13123 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Tiefe Sehnsucht>

UPDATE pieces piece
SET piece.title = '가곡 <Tiefe Sehnsucht>', piece.title_en = 'Tiefe Sehnsucht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12335 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Traum>

UPDATE pieces piece
SET piece.title = '가곡 <Traum>', piece.title_en = 'Traum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12959 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Traurigkeit>

UPDATE pieces piece
SET piece.title = '가곡 <Traurigkeit>', piece.title_en = 'Traurigkeit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12527 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Verlassen>

UPDATE pieces piece
SET piece.title = '가곡 <Verlassen>', piece.title_en = 'Verlassen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13199 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vielgeliebte schöne Frau>

UPDATE pieces piece
SET piece.title = '가곡 <Vielgeliebte schöne Frau>', piece.title_en = 'Vielgeliebte schöne Frau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12469 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 Vier Stücke für Klarinette und Klavier

UPDATE pieces piece
SET piece.title = 'Vier Stücke für Klarinette und Klavier', piece.title_en = 'Vier Stücke für Klarinette und Klavier, op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12401 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mäßig', part.name_en = 'Vier Stücke für Klarinette und Klavier, op. 5: I. Mäßig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12401 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:ece1273f-3f3c-309f-83dc-320a0f1d96cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece1273f-3f3c-309f-83dc-320a0f1d96cb', 1, 'I', 'Mäßig', 'Vier Stücke für Klarinette und Klavier, op. 5: I. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12401 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece1273f-3f3c-309f-83dc-320a0f1d96cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr langsam', part.name_en = 'Vier Stücke für Klarinette und Klavier, op. 5: II. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12401 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:9a6e16ee-24d7-361f-96e8-36b7b15a7f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a6e16ee-24d7-361f-96e8-36b7b15a7f42', 2, 'II', 'Sehr langsam', 'Vier Stücke für Klarinette und Klavier, op. 5: II. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12401 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a6e16ee-24d7-361f-96e8-36b7b15a7f42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr rasch', part.name_en = 'Vier Stücke für Klarinette und Klavier, op. 5: III. Sehr rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12401 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:94b4731e-9e55-3e21-9db5-a6b2732ec4dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94b4731e-9e55-3e21-9db5-a6b2732ec4dc', 3, 'III', 'Sehr rasch', 'Vier Stücke für Klarinette und Klavier, op. 5: III. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12401 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94b4731e-9e55-3e21-9db5-a6b2732ec4dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Langsam', part.name_en = 'Vier Stücke für Klarinette und Klavier, op. 5: IV. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12401 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:95a594d1-b7b3-3a14-a48b-12df707ee526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95a594d1-b7b3-3a14-a48b-12df707ee526', 4, 'IV', 'Langsam', 'Vier Stücke für Klarinette und Klavier, op. 5: IV. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12401 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95a594d1-b7b3-3a14-a48b-12df707ee526'
);


-- None 가곡 <Vorüber!>

UPDATE pieces piece
SET piece.title = '가곡 <Vorüber!>', piece.title_en = 'Vorüber!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13513 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Walzer G-Dur

UPDATE pieces piece
SET piece.title = 'Walzer G-Dur', piece.title_en = 'Walzer G-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13240 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Winter>

UPDATE pieces piece
SET piece.title = '가곡 <Winter>', piece.title_en = 'Winter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12831 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Wo der Goldregen steht>

UPDATE pieces piece
SET piece.title = '가곡 <Wo der Goldregen steht>', piece.title_en = 'Wo der Goldregen steht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13490 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Wozzeck>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act 1', part.name_en = 'Wozzeck: Act 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78', 1, NULL, 'Act 1', 'Wozzeck: Act 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1, Langsam, Wozzeck, langsam!', part.name_en = 'Wozzeck: Act 1, Scene 1, Langsam, Wozzeck, langsam!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:4c8573cf-58b1-4041-b82f-155d2c26e9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c8573cf-58b1-4041-b82f-155d2c26e9f9', 1, NULL, 'Scene 1, Langsam, Wozzeck, langsam!', 'Wozzeck: Act 1, Scene 1, Langsam, Wozzeck, langsam!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8573cf-58b1-4041-b82f-155d2c26e9f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1, Wir arme Leut! Sehn Sie, Herr Hauptmann, Geld, Geld!', part.name_en = 'Wozzeck: Act 1, Scene 1, Wir arme Leut! Sehn Sie, Herr Hauptmann, Geld, Geld!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:b3a1bc85-6540-471e-a962-66540f2a0650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3a1bc85-6540-471e-a962-66540f2a0650', 2, NULL, 'Scene 1, Wir arme Leut! Sehn Sie, Herr Hauptmann, Geld, Geld!', 'Wozzeck: Act 1, Scene 1, Wir arme Leut! Sehn Sie, Herr Hauptmann, Geld, Geld!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3a1bc85-6540-471e-a962-66540f2a0650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 2; ''Du, der Platz ist verflucht!''', part.name_en = 'Wozzeck: Act 1, Scene 2; ''Du, der Platz ist verflucht!''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:eaf45ce6-89bb-4be4-99f8-149df5f834fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eaf45ce6-89bb-4be4-99f8-149df5f834fd', 3, NULL, 'Scene 2; ''Du, der Platz ist verflucht!''', 'Wozzeck: Act 1, Scene 2; ''Du, der Platz ist verflucht!''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaf45ce6-89bb-4be4-99f8-149df5f834fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene 3, Tschin Bum, Tschin Bum, Bum, Bum, Bum!', part.name_en = 'Wozzeck: Act 1, Scene 3, Tschin Bum, Tschin Bum, Bum, Bum, Bum!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:8c4c2c0e-30b6-4dfc-bebc-bb5a6193f528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c4c2c0e-30b6-4dfc-bebc-bb5a6193f528', 4, NULL, 'Scene 3, Tschin Bum, Tschin Bum, Bum, Bum, Bum!', 'Wozzeck: Act 1, Scene 3, Tschin Bum, Tschin Bum, Bum, Bum, Bum!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4c2c0e-30b6-4dfc-bebc-bb5a6193f528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 3, Wer da?', part.name_en = 'Wozzeck: Act 1, Scene 3, Wer da?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:094547e5-52ed-40ee-a176-16b66190810b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:094547e5-52ed-40ee-a176-16b66190810b', 5, NULL, 'Scene 3, Wer da?', 'Wozzeck: Act 1, Scene 3, Wer da?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:094547e5-52ed-40ee-a176-16b66190810b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 4, Was erleb'' ich, Wozzeck?', part.name_en = 'Wozzeck: Act 1, Scene 4, Was erleb'' ich, Wozzeck?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:e0b4cabe-1206-4344-8501-430d256aca35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0b4cabe-1206-4344-8501-430d256aca35', 6, NULL, 'Scene 4, Was erleb'' ich, Wozzeck?', 'Wozzeck: Act 1, Scene 4, Was erleb'' ich, Wozzeck?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b4cabe-1206-4344-8501-430d256aca35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 5, Geh'' einmal vor Dich hin!', part.name_en = 'Wozzeck: Act 1, Scene 5, Geh'' einmal vor Dich hin!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:f304c9c7-cf55-43b3-befe-4d2c5f7a4f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f304c9c7-cf55-43b3-befe-4d2c5f7a4f19', 7, NULL, 'Scene 5, Geh'' einmal vor Dich hin!', 'Wozzeck: Act 1, Scene 5, Geh'' einmal vor Dich hin!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d9db791-4ed5-433c-b751-43c0f9023a78'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f304c9c7-cf55-43b3-befe-4d2c5f7a4f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act 2', part.name_en = 'Wozzeck: Act 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96', 2, NULL, 'Act 2', 'Wozzeck: Act 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1, Was die Steine glänzen?', part.name_en = 'Wozzeck: Act 2, Scene 1, Was die Steine glänzen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:6977bc19-fd93-49a4-b88e-3a11d9176581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6977bc19-fd93-49a4-b88e-3a11d9176581', 1, NULL, 'Scene 1, Was die Steine glänzen?', 'Wozzeck: Act 2, Scene 1, Was die Steine glänzen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6977bc19-fd93-49a4-b88e-3a11d9176581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1, Was hast da?', part.name_en = 'Wozzeck: Act 2, Scene 1, Was hast da?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:60dc4f3f-104a-4227-bddd-8efd7a805154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60dc4f3f-104a-4227-bddd-8efd7a805154', 2, NULL, 'Scene 1, Was hast da?', 'Wozzeck: Act 2, Scene 1, Was hast da?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60dc4f3f-104a-4227-bddd-8efd7a805154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 2, Wohin so eilig, geehrtester Herr Sargnagel?', part.name_en = 'Wozzeck: Act 2, Scene 2, Wohin so eilig, geehrtester Herr Sargnagel?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:b66ee330-4372-4f37-80b8-4d81c9626ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b66ee330-4372-4f37-80b8-4d81c9626ba5', 3, NULL, 'Scene 2, Wohin so eilig, geehrtester Herr Sargnagel?', 'Wozzeck: Act 2, Scene 2, Wohin so eilig, geehrtester Herr Sargnagel?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66ee330-4372-4f37-80b8-4d81c9626ba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene 2, He Wozzeck! Was hetzt Er sich so uns vorbei?', part.name_en = 'Wozzeck: Act 2, Scene 2, He Wozzeck! Was hetzt Er sich so uns vorbei?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:4fbf0f92-9d24-44fa-858f-11b196117587' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fbf0f92-9d24-44fa-858f-11b196117587', 4, NULL, 'Scene 2, He Wozzeck! Was hetzt Er sich so uns vorbei?', 'Wozzeck: Act 2, Scene 2, He Wozzeck! Was hetzt Er sich so uns vorbei?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fbf0f92-9d24-44fa-858f-11b196117587'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 3, Guten Tag, Franz', part.name_en = 'Wozzeck: Act 2, Scene 3, Guten Tag, Franz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:8468a50a-2e4a-4e17-a802-cce0338b0505' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8468a50a-2e4a-4e17-a802-cce0338b0505', 5, NULL, 'Scene 3, Guten Tag, Franz', 'Wozzeck: Act 2, Scene 3, Guten Tag, Franz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8468a50a-2e4a-4e17-a802-cce0338b0505'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 4, Ich hab'' ein Hemdlein an, das is nicht mein', part.name_en = 'Wozzeck: Act 2, Scene 4, Ich hab'' ein Hemdlein an, das is nicht mein..',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:22ef2e1b-2062-4af9-a531-133d4a461c3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22ef2e1b-2062-4af9-a531-133d4a461c3f', 6, NULL, 'Scene 4, Ich hab'' ein Hemdlein an, das is nicht mein', 'Wozzeck: Act 2, Scene 4, Ich hab'' ein Hemdlein an, das is nicht mein..', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22ef2e1b-2062-4af9-a531-133d4a461c3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 4, Er! Sie! Teufel!', part.name_en = 'Wozzeck: Act 2, Scene 4, Er! Sie! Teufel!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:de901514-e3fc-4ce7-a93b-fd6da76f0e19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de901514-e3fc-4ce7-a93b-fd6da76f0e19', 7, NULL, 'Scene 4, Er! Sie! Teufel!', 'Wozzeck: Act 2, Scene 4, Er! Sie! Teufel!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de901514-e3fc-4ce7-a93b-fd6da76f0e19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 4, Jedoch, wenn ein Wanderer, der gelehnt steht an dem Strom der Zeit', part.name_en = 'Wozzeck: Act 2, Scene 4, Jedoch, wenn ein Wanderer, der gelehnt steht an dem Strom der Zeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:c42ea8ff-8b8a-42de-88e7-6241c9e4bbf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c42ea8ff-8b8a-42de-88e7-6241c9e4bbf9', 8, NULL, 'Scene 4, Jedoch, wenn ein Wanderer, der gelehnt steht an dem Strom der Zeit', 'Wozzeck: Act 2, Scene 4, Jedoch, wenn ein Wanderer, der gelehnt steht an dem Strom der Zeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42ea8ff-8b8a-42de-88e7-6241c9e4bbf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 5, Andres! Andres! Ich kann nicht schlafen', part.name_en = 'Wozzeck: Act 2, Scene 5, Andres! Andres! Ich kann nicht schlafen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:c01715e2-cce2-4766-b8fe-3bdce5d92099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c01715e2-cce2-4766-b8fe-3bdce5d92099', 9, NULL, 'Scene 5, Andres! Andres! Ich kann nicht schlafen', 'Wozzeck: Act 2, Scene 5, Andres! Andres! Ich kann nicht schlafen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b1767bb-f750-4a03-ad0f-b161bfb30a96'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c01715e2-cce2-4766-b8fe-3bdce5d92099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act 3', part.name_en = 'Wozzeck: Act 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae', 3, NULL, 'Act 3', 'Wozzeck: Act 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1, ''Und ist kein Betrug in seinem Munde erfunden worden''', part.name_en = 'Wozzeck: Act 3, Scene 1, ''Und ist kein Betrug in seinem Munde erfunden worden''..',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:b8a938fe-fe9e-4a8b-9902-8aa1e1d7376e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8a938fe-fe9e-4a8b-9902-8aa1e1d7376e', 1, NULL, 'Scene 1, ''Und ist kein Betrug in seinem Munde erfunden worden''', 'Wozzeck: Act 3, Scene 1, ''Und ist kein Betrug in seinem Munde erfunden worden''..', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a938fe-fe9e-4a8b-9902-8aa1e1d7376e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1. "Und kniete hin zu seinen Fuessen"', part.name_en = 'Wozzeck: Act 3, Scene 1. "Und kniete hin zu seinen Fuessen"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:8e4c4a68-ada3-4316-ab2a-9a34a3c701c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e4c4a68-ada3-4316-ab2a-9a34a3c701c4', 2, NULL, 'Scene 1. "Und kniete hin zu seinen Fuessen"', 'Wozzeck: Act 3, Scene 1. "Und kniete hin zu seinen Fuessen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e4c4a68-ada3-4316-ab2a-9a34a3c701c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 2, Dort links geht''s in die Stadt', part.name_en = 'Wozzeck: Act 3, Scene 2, Dort links geht''s in die Stadt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:8e09d77a-c3d1-4afa-b023-09b99872b2ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e09d77a-c3d1-4afa-b023-09b99872b2ac', 3, NULL, 'Scene 2, Dort links geht''s in die Stadt', 'Wozzeck: Act 3, Scene 2, Dort links geht''s in die Stadt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e09d77a-c3d1-4afa-b023-09b99872b2ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene 3, Tanzt Alle; tanzt nur zu, springt, schwitzt und stinkt', part.name_en = 'Wozzeck: Act 3, Scene 3, Tanzt Alle; tanzt nur zu, springt, schwitzt und stinkt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:a7522189-eef7-431d-b8e0-331ff0f66c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7522189-eef7-431d-b8e0-331ff0f66c4d', 4, NULL, 'Scene 3, Tanzt Alle; tanzt nur zu, springt, schwitzt und stinkt', 'Wozzeck: Act 3, Scene 3, Tanzt Alle; tanzt nur zu, springt, schwitzt und stinkt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7522189-eef7-431d-b8e0-331ff0f66c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 4, Das Messer? Wo ist das Messer?', part.name_en = 'Wozzeck: Act 3, Scene 4, Das Messer? Wo ist das Messer?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:9d329a71-8b92-4fef-b4f9-df54ee9c87f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d329a71-8b92-4fef-b4f9-df54ee9c87f4', 5, NULL, 'Scene 4, Das Messer? Wo ist das Messer?', 'Wozzeck: Act 3, Scene 4, Das Messer? Wo ist das Messer?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d329a71-8b92-4fef-b4f9-df54ee9c87f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 5, Ringel, Ringel, Rosenkranz, Ringelreih''n', part.name_en = 'Wozzeck: Act 3, Scene 5, Ringel, Ringel, Rosenkranz, Ringelreih''n',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 364 AND p.composer_id = 96 AND part.part_key = 'musicbrainz:852fbad9-fb6f-4532-a94b-30c4df4dfd32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:852fbad9-fb6f-4532-a94b-30c4df4dfd32', 6, NULL, 'Scene 5, Ringel, Ringel, Rosenkranz, Ringelreih''n', 'Wozzeck: Act 3, Scene 5, Ringel, Ringel, Rosenkranz, Ringelreih''n', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c76a34c-5d72-494f-98b4-e3cc6ed8b8ae'
WHERE p.id = 364 AND p.composer_id = 96
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:852fbad9-fb6f-4532-a94b-30c4df4dfd32'
);


-- None Zwei Variationen über ein eigenes Thema F-Dur

UPDATE pieces piece
SET piece.title = 'Zwei Variationen über ein eigenes Thema F-Dur', piece.title_en = 'Zwei Variationen über ein eigenes Thema F-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13666 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zwölf Variationen über ein eigenes Thema C-Dur

UPDATE pieces piece
SET piece.title = 'Zwölf Variationen über ein eigenes Thema C-Dur', piece.title_en = 'Zwölf Variationen über ein eigenes Thema C-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12857 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Über den Bergen>

UPDATE pieces piece
SET piece.title = '가곡 <Über den Bergen>', piece.title_en = 'Über den Bergen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12310 AND piece.composer_id = 96
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 4 Lieder

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4 Lieder', '4 Lieder, op. 2', 'album', 'Op. 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4 Lieder'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c41820e-c530-4851-a120-8e49456906ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c41820e-c530-4851-a120-8e49456906ac'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '4 Lieder' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c41820e-c530-4851-a120-8e49456906ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0b54016-184b-405e-9577-3a411f9444a5', 1, 'I', 'Schlafen, schlafen, nichts als schlafen', '4 Lieder, op. 2: I. Schlafen, schlafen, nichts als schlafen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '4 Lieder' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0b54016-184b-405e-9577-3a411f9444a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b640c35-cdaa-478d-a537-461e14367397', 2, 'II', 'Schlafend trägt man mich', '4 Lieder, op. 2: II. Schlafend trägt man mich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '4 Lieder' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b640c35-cdaa-478d-a537-461e14367397'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e104a8df-2325-4e0e-a982-6af5a373e9b9', 3, 'III', 'Nun ich der Riesen Stärksten überwand', '4 Lieder, op. 2: III. Nun ich der Riesen Stärksten überwand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '4 Lieder' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e104a8df-2325-4e0e-a982-6af5a373e9b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50a92863-b4c3-40c7-a758-2b5e8fba702c', 4, 'IV', 'Warm die Lüfte', '4 Lieder, op. 2: IV. Warm die Lüfte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '4 Lieder' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a92863-b4c3-40c7-a758-2b5e8fba702c'
);


-- None 아리아 <Der Wein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Der Wein>', 'Der Wein', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Der Wein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f681c3ed-871c-416e-8cc1-d16cbd28fbdc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f681c3ed-871c-416e-8cc1-d16cbd28fbdc'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '아리아 <Der Wein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f681c3ed-871c-416e-8cc1-d16cbd28fbdc'
);


-- Op. 1 피아노 소나타 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 B단조', 'Piano Sonata, op. 1', 'song', 'Op. 1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cae18526-60e3-3ec8-9c63-8a93983052d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cae18526-60e3-3ec8-9c63-8a93983052d1'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cae18526-60e3-3ec8-9c63-8a93983052d1'
);


-- None 가곡 <Schließe mir die Augen beide>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Schließe mir die Augen beide>', 'Schließe mir die Augen beide', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Schließe mir die Augen beide>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fe71763-dc0e-4fa6-b03e-dac075c4e4fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0fe71763-dc0e-4fa6-b03e-dac075c4e4fb'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '가곡 <Schließe mir die Augen beide>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fe71763-dc0e-4fa6-b03e-dac075c4e4fb'
);


-- None 연가곡집 <Sieben frühe Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Sieben frühe Lieder>', 'Sieben frühe Lieder', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Sieben frühe Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64ef875f-428d-4662-bdd3-d8a4cb335f08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64ef875f-428d-4662-bdd3-d8a4cb335f08'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64ef875f-428d-4662-bdd3-d8a4cb335f08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc93abc-3e33-4ac7-a2e6-385219ab8d68', 1, 'I', 'Nacht', 'Sieben frühe Lieder: I. Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc93abc-3e33-4ac7-a2e6-385219ab8d68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c27256e-ada3-4cc7-95ff-75a172f70187', 2, 'II', 'Schilflied', 'Sieben frühe Lieder: II. Schilflied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c27256e-ada3-4cc7-95ff-75a172f70187'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab2ccb89-5d61-422b-b67a-9108f4bdc5de', 3, 'III', 'Die Nachtigall', 'Sieben frühe Lieder: III. Die Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab2ccb89-5d61-422b-b67a-9108f4bdc5de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0e7830d-2aab-4740-8c9f-c44926e8f403', 4, 'IV', 'Traumgekrönt', 'Sieben frühe Lieder: IV. Traumgekrönt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0e7830d-2aab-4740-8c9f-c44926e8f403'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ea3462-0fea-4091-bbff-fc8b66689e6c', 5, 'V', 'Im Zimmer', 'Sieben frühe Lieder: V. Im Zimmer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ea3462-0fea-4091-bbff-fc8b66689e6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d92a6f-e190-4aa6-b27e-1a4979d57612', 6, 'VI', 'Liebesode', 'Sieben frühe Lieder: VI. Liebesode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d92a6f-e190-4aa6-b27e-1a4979d57612'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f69bb828-3125-4b1b-9395-9875dc5fa5e5', 7, 'VII', 'Sommertage', 'Sieben frühe Lieder: VII. Sommertage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = '연가곡집 <Sieben frühe Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69bb828-3125-4b1b-9395-9875dc5fa5e5'
);


-- Op. 3 Streichquartett

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Streichquartett', 'Streichquartett, op. 3', 'album', 'Op. 3', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 96
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Streichquartett'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcc44089-2928-4bc9-8281-307e386bd27b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcc44089-2928-4bc9-8281-307e386bd27b'
FROM pieces p
WHERE p.composer_id = 96 AND p.title = 'Streichquartett' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcc44089-2928-4bc9-8281-307e386bd27b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c052aa31-faa3-3422-8583-21772b36d227', 1, 'I', 'Langsam', 'Streichquartett, op. 3: I. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = 'Streichquartett' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c052aa31-faa3-3422-8583-21772b36d227'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2fe3f0b-2b5f-39ea-8f7b-7aa4e7d3b134', 2, 'II', 'Mäßige viertel', 'Streichquartett, op. 3: II. Mäßige viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 96 AND p.title = 'Streichquartett' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2fe3f0b-2b5f-39ea-8f7b-7aa4e7d3b134'
);


-- 카탈로그에 대응이 없는 seed 작품 10개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 96 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    12025, 12044, 12549, 12780, 12810, 13043, 13388, 13442, 13717, 13718
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
