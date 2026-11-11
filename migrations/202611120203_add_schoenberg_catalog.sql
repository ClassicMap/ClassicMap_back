-- 아르놀트 쇤베르크(composer_id 82) 작품 목록. 지금은 「정화된 밤」·「달에 홀린 피에로」·「바르샤바의 생존자」·「5개의 피아노 소품」 네 곡뿐이다.
-- 새 작품 55개(현악 4중주 D장조·1~4번, 「펠레아스와 멜리장드」, 실내 교향곡 1·2번, 관현악을 위한 5개의 소품·변주곡,
-- 피아노 소품·모음곡, 바이올린·피아노 협주곡, 「구레의 노래」, 「기대」·「모세와 아론」 등 무대 작품, 가곡집·합창곡),
-- 곡·악장 216개, 장르·형식.
--
-- 작품은 손으로 고르고(남의 곡 편곡·다른 판·미완성 단편·민요 편곡은 뺌) 곡은 MusicBrainz parts 순서대로 붙였다. 자료와 생성기:
--   seed_pipeline/curation/composer-catalog-2026-11-12/(build.py, schoenberg/works.tsv) → catalog-wave4 gen_catalog.py
-- 기존 네 곡은 제목·설명·링크를 두고 MBID 와 곡만 잇는다(「달에 홀린 피에로」 3부×7곡, 「정화된 밤」 5단락, Op. 23 5곡).
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- Op. 4 정화된 밤

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr langsam', part.name_en = 'I. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 313 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:f7a14480-1f8e-3f0a-8107-c327c38ab9ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a14480-1f8e-3f0a-8107-c327c38ab9ad', 1, 'I', 'Sehr langsam', 'I. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 313 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a14480-1f8e-3f0a-8107-c327c38ab9ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Etwas bewegter', part.name_en = 'II. Etwas bewegter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 313 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:0b6337a5-9370-3130-81cc-f07bf0f49073' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b6337a5-9370-3130-81cc-f07bf0f49073', 2, 'II', 'Etwas bewegter', 'II. Etwas bewegter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 313 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6337a5-9370-3130-81cc-f07bf0f49073'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Schwer betont', part.name_en = 'III. Schwer betont',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 313 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:38f91a17-f717-375a-a532-b6e61e84f199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38f91a17-f717-375a-a532-b6e61e84f199', 3, 'III', 'Schwer betont', 'III. Schwer betont', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 313 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f91a17-f717-375a-a532-b6e61e84f199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr breit und langsam', part.name_en = 'IV. Sehr breit und langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 313 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:2ad04956-18f4-3fcc-917b-f867a9fb86e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ad04956-18f4-3fcc-917b-f867a9fb86e3', 4, 'IV', 'Sehr breit und langsam', 'IV. Sehr breit und langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 313 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ad04956-18f4-3fcc-917b-f867a9fb86e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sehr ruhig', part.name_en = 'V. Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 313 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:87c57a77-e8a3-3e99-8e20-3903155c7434' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c57a77-e8a3-3e99-8e20-3903155c7434', 5, 'V', 'Sehr ruhig', 'V. Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 313 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c57a77-e8a3-3e99-8e20-3903155c7434'
);


-- Op. 21 달에 홀린 피에로

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1d77e7d-694f-4d7e-862b-691be2ae47ad'
FROM pieces p
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1d77e7d-694f-4d7e-862b-691be2ae47ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '1부', part.name_en = 'I. Teil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af', 1, 'I', '1부', 'I. Teil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mondestrunken', part.name_en = '1. „Mondestrunken“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:4df4f561-a755-4112-87c5-3942bcbca997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4df4f561-a755-4112-87c5-3942bcbca997', 1, NULL, 'Mondestrunken', '1. „Mondestrunken“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df4f561-a755-4112-87c5-3942bcbca997'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Colombine', part.name_en = '2. „Colombine“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:ac302cbb-ec62-4c6a-a4af-16ca380e92ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac302cbb-ec62-4c6a-a4af-16ca380e92ef', 2, NULL, 'Colombine', '2. „Colombine“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac302cbb-ec62-4c6a-a4af-16ca380e92ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Dandy', part.name_en = '3. „Der Dandy“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:15aabc69-5135-4ebc-b2ef-d827f19b6ed5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15aabc69-5135-4ebc-b2ef-d827f19b6ed5', 3, NULL, 'Der Dandy', '3. „Der Dandy“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15aabc69-5135-4ebc-b2ef-d827f19b6ed5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Eine blasse Wäscherin', part.name_en = '4. „Eine blasse Wäscherin“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:41c7898f-2746-4e58-96eb-4f81e4dac4b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41c7898f-2746-4e58-96eb-4f81e4dac4b7', 4, NULL, 'Eine blasse Wäscherin', '4. „Eine blasse Wäscherin“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c7898f-2746-4e58-96eb-4f81e4dac4b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Valse de Chopin', part.name_en = '5. „Valse de Chopin“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:57224fed-7192-431c-8fe0-64fe4a846e3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57224fed-7192-431c-8fe0-64fe4a846e3d', 5, NULL, 'Valse de Chopin', '5. „Valse de Chopin“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57224fed-7192-431c-8fe0-64fe4a846e3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Madonna', part.name_en = '6. „Madonna“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:403319a6-948e-4cca-aaca-5242379b1465' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:403319a6-948e-4cca-aaca-5242379b1465', 6, NULL, 'Madonna', '6. „Madonna“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403319a6-948e-4cca-aaca-5242379b1465'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Der kranke Mond', part.name_en = '7. „Der kranke Mond“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:c9f9418f-f51b-4463-b523-9c8598a9ee38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9f9418f-f51b-4463-b523-9c8598a9ee38', 7, NULL, 'Der kranke Mond', '7. „Der kranke Mond“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3431ba-edbf-49c5-b490-881028a344af'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f9418f-f51b-4463-b523-9c8598a9ee38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '2부', part.name_en = 'II. Teil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a', 2, 'II', '2부', 'II. Teil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nacht (Passacaglia)', part.name_en = '8. „Nacht (Passacaglia)“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:ef2dec21-ce18-4a1a-a404-513d88da254a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef2dec21-ce18-4a1a-a404-513d88da254a', 1, NULL, 'Nacht (Passacaglia)', '8. „Nacht (Passacaglia)“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef2dec21-ce18-4a1a-a404-513d88da254a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gebet an Pierrot', part.name_en = '9. „Gebet an Pierrot“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:af95d131-e143-42ac-b48d-5414fb23606d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af95d131-e143-42ac-b48d-5414fb23606d', 2, NULL, 'Gebet an Pierrot', '9. „Gebet an Pierrot“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af95d131-e143-42ac-b48d-5414fb23606d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Raub', part.name_en = '10. „Raub“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:15cd7aa5-3066-4388-9435-fb784ded03dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15cd7aa5-3066-4388-9435-fb784ded03dd', 3, NULL, 'Raub', '10. „Raub“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15cd7aa5-3066-4388-9435-fb784ded03dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rote Messe', part.name_en = '11. „Rote Messe“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:0c7f6ac8-0a78-4a8b-8dae-e9d25cd5e0df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c7f6ac8-0a78-4a8b-8dae-e9d25cd5e0df', 4, NULL, 'Rote Messe', '11. „Rote Messe“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c7f6ac8-0a78-4a8b-8dae-e9d25cd5e0df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Galgenlied', part.name_en = '12. „Galgenlied“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:de636fba-72d2-4028-9e90-212e304ffb9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de636fba-72d2-4028-9e90-212e304ffb9f', 5, NULL, 'Galgenlied', '12. „Galgenlied“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de636fba-72d2-4028-9e90-212e304ffb9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Enthauptung', part.name_en = '13. „Enthauptung“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:a6e60a2c-ad8f-446d-bf9a-06a42f077c02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6e60a2c-ad8f-446d-bf9a-06a42f077c02', 6, NULL, 'Enthauptung', '13. „Enthauptung“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e60a2c-ad8f-446d-bf9a-06a42f077c02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Die Kreuze', part.name_en = '14. „Die Kreuze“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:7c12134a-20b9-400c-b2a6-3b0aecb32d0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c12134a-20b9-400c-b2a6-3b0aecb32d0a', 7, NULL, 'Die Kreuze', '14. „Die Kreuze“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49d5a576-b1b0-463a-a568-aa8d72f3536a'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c12134a-20b9-400c-b2a6-3b0aecb32d0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '3부', part.name_en = 'III. Teil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d', 3, 'III', '3부', 'III. Teil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Heimweh', part.name_en = '15. „Heimweh“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:c0b1f5ae-4de3-4160-ae11-0d6b6cf10012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0b1f5ae-4de3-4160-ae11-0d6b6cf10012', 1, NULL, 'Heimweh', '15. „Heimweh“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0b1f5ae-4de3-4160-ae11-0d6b6cf10012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gemeinheit!', part.name_en = '16. „Gemeinheit!“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:58e1e845-7cd8-4e7e-9d65-119c6397a50f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58e1e845-7cd8-4e7e-9d65-119c6397a50f', 2, NULL, 'Gemeinheit!', '16. „Gemeinheit!“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e1e845-7cd8-4e7e-9d65-119c6397a50f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Parodie', part.name_en = '17. „Parodie“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:fd90cc88-f3bc-42d6-8dee-15821e7f94b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd90cc88-f3bc-42d6-8dee-15821e7f94b3', 3, NULL, 'Parodie', '17. „Parodie“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd90cc88-f3bc-42d6-8dee-15821e7f94b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Mondfleck', part.name_en = '18. „Der Mondfleck“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:58cf848d-a681-4da8-8f25-b0ae1e9d7aa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58cf848d-a681-4da8-8f25-b0ae1e9d7aa2', 4, NULL, 'Der Mondfleck', '18. „Der Mondfleck“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58cf848d-a681-4da8-8f25-b0ae1e9d7aa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Serenade', part.name_en = '19. „Serenade“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:45e54e6c-02f7-4a19-a978-3ce5097a124a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45e54e6c-02f7-4a19-a978-3ce5097a124a', 5, NULL, 'Serenade', '19. „Serenade“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45e54e6c-02f7-4a19-a978-3ce5097a124a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Heimfahrt (Barcarole)', part.name_en = '20. „Heimfahrt (Barcarole)“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:42ea23f7-456f-43b9-8784-3d9512293af2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42ea23f7-456f-43b9-8784-3d9512293af2', 6, NULL, 'Heimfahrt (Barcarole)', '20. „Heimfahrt (Barcarole)“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ea23f7-456f-43b9-8784-3d9512293af2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'O alter Duft', part.name_en = '21. „O alter Duft“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 314 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:e1fa30a3-4a94-466e-8a42-8dcf9ee62186' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1fa30a3-4a94-466e-8a42-8dcf9ee62186', 7, NULL, 'O alter Duft', '21. „O alter Duft“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8b4ddfc4-3534-44de-98e0-550309dbc60d'
WHERE p.id = 314 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1fa30a3-4a94-466e-8a42-8dcf9ee62186'
);


-- Op. 46 바르샤바의 생존자

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e46f1364-dd48-4937-91ba-d1e1dba6b996'
FROM pieces p
WHERE p.id = 315 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e46f1364-dd48-4937-91ba-d1e1dba6b996'
);


-- Op. 23 5개의 피아노 소품

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr langsam', part.name_en = 'I. Sehr langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 316 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:a933508f-fed2-366f-a66c-72aec54a5b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a933508f-fed2-366f-a66c-72aec54a5b78', 1, 'I', 'Sehr langsam', 'I. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 316 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a933508f-fed2-366f-a66c-72aec54a5b78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sehr rasch', part.name_en = 'II. Sehr rasch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 316 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:6ef25daa-651f-3b0f-a3f8-ad562bd5c576' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ef25daa-651f-3b0f-a3f8-ad562bd5c576', 2, 'II', 'Sehr rasch', 'II. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 316 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef25daa-651f-3b0f-a3f8-ad562bd5c576'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Langsam', part.name_en = 'III. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 316 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:7fb6d9f3-9dcf-3cdd-b2ff-4facedc76a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fb6d9f3-9dcf-3cdd-b2ff-4facedc76a5c', 3, 'III', 'Langsam', 'III. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 316 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fb6d9f3-9dcf-3cdd-b2ff-4facedc76a5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Schwungvoll. Mäßige Viertel', part.name_en = 'IV. Schwungvoll. Mäßige Viertel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 316 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:510bfc63-fcb4-38b0-8536-ee2a08676a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510bfc63-fcb4-38b0-8536-ee2a08676a39', 4, 'IV', 'Schwungvoll. Mäßige Viertel', 'IV. Schwungvoll. Mäßige Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 316 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510bfc63-fcb4-38b0-8536-ee2a08676a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Walzer', part.name_en = 'V. Walzer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 316 AND p.composer_id = 82 AND part.part_key = 'musicbrainz:4510dd76-851f-3816-b4ce-f524d840e61a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4510dd76-851f-3816-b4ce-f524d840e61a', 5, 'V', 'Walzer', 'V. Walzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 316 AND p.composer_id = 82
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4510dd76-851f-3816-b4ce-f524d840e61a'
);


-- None 현과 하프를 위한 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현과 하프를 위한 녹턴', 'Notturno für Streicher und Harfe', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현과 하프를 위한 녹턴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f8a5dd9-e51c-4128-bc85-63bdb3adfda1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f8a5dd9-e51c-4128-bc85-63bdb3adfda1'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현과 하프를 위한 녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f8a5dd9-e51c-4128-bc85-63bdb3adfda1'
);


-- None 피아노 연탄을 위한 6개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄을 위한 6개의 소품', 'Sechs Stücke für Klavier zu vier Händen', 'album', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄을 위한 6개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '011ba175-d277-4f09-80c5-d0639a893c95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '011ba175-d277-4f09-80c5-d0639a893c95'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '011ba175-d277-4f09-80c5-d0639a893c95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39974331-e2e6-4b68-b845-207e91baae21', 1, 'I', 'Andantino grazioso', 'I. Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39974331-e2e6-4b68-b845-207e91baae21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f33e30c8-1d19-4395-aa9c-cc1f9c67aabb', 2, 'II', 'Poco allegro', 'II. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33e30c8-1d19-4395-aa9c-cc1f9c67aabb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ae02c7-1112-4b31-88d8-d4480ec66a3a', 3, 'III', 'Rasch', 'III. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ae02c7-1112-4b31-88d8-d4480ec66a3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47d7b86b-b3df-4e04-8935-1c6a3a61936b', 4, 'IV', 'Andante', 'IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d7b86b-b3df-4e04-8935-1c6a3a61936b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1734d1b-cfe3-4449-8929-b91c185349af', 5, 'V', 'Lebhaft, rasch', 'V. Lebhaft, rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1734d1b-cfe3-4449-8929-b91c185349af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db2c85c-ea44-4cd9-9833-a509da54004d', 6, 'VI', 'Allegro molto', 'VI. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 연탄을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db2c85c-ea44-4cd9-9833-a509da54004d'
);


-- None 현악 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 D장조', 'String Quartet in D major', 'album', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d42018d-8a4f-47ec-82b8-0c35725eb471'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d42018d-8a4f-47ec-82b8-0c35725eb471'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d42018d-8a4f-47ec-82b8-0c35725eb471'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faf4af13-d4b8-4c53-adb0-0d78a91d55be', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf4af13-d4b8-4c53-adb0-0d78a91d55be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9610717e-9b60-4656-9838-36d3420fd267', 2, 'II', '인테르메초. Andantino grazioso', 'II. Intermezzo: Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9610717e-9b60-4656-9838-36d3420fd267'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7410178-8c3c-43a4-b88a-1cde58c9560d', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7410178-8c3c-43a4-b88a-1cde58c9560d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e54d8147-59db-48c5-af0d-c3d11b09d692', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e54d8147-59db-48c5-af0d-c3d11b09d692'
);


-- Op. 1 2개의 가곡 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡 Op. 1', 'Zwei Gesänge, op. 1', 'album', NULL, 'Op.', '1', 1898, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c352492-b20c-47cb-9572-984378bded58'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c352492-b20c-47cb-9572-984378bded58'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c352492-b20c-47cb-9572-984378bded58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38d28e4c-bf18-3c59-bf12-d547b6d5be73', 1, NULL, 'Dank', 'Dank, op. 1 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38d28e4c-bf18-3c59-bf12-d547b6d5be73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84ca2894-eb39-3301-8ad5-0a548824306c', 2, NULL, 'Abschied', 'Abschied, op. 1 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ca2894-eb39-3301-8ad5-0a548824306c'
);


-- Op. 2 4개의 가곡 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 Op. 2', 'Vier Lieder, op. 2', 'album', NULL, 'Op.', '2', 1900, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e56e4d-b428-4950-99d6-66ab5c7edaed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73e56e4d-b428-4950-99d6-66ab5c7edaed'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '4개의 가곡 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73e56e4d-b428-4950-99d6-66ab5c7edaed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94fd2230-10eb-30ed-8fb2-f9e06df4af8e', 1, NULL, 'Erwartung', 'Erwartung, op. 2 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '4개의 가곡 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94fd2230-10eb-30ed-8fb2-f9e06df4af8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a19d811-2eab-3203-9ade-8ca31347a805', 2, NULL, 'Jesus bettelt', 'Jesus bettelt, op. 2 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '4개의 가곡 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a19d811-2eab-3203-9ade-8ca31347a805'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb55c1e0-05bb-3ff7-89ed-f7ed0785922c', 3, NULL, 'Erhebung', 'Erhebung, op. 2 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '4개의 가곡 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb55c1e0-05bb-3ff7-89ed-f7ed0785922c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f54e93-7d3c-3550-8bd4-8b34a18b2af8', 4, NULL, 'Waldsonne', 'Waldsonne, op. 2 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '4개의 가곡 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f54e93-7d3c-3550-8bd4-8b34a18b2af8'
);


-- None 카바레 가곡 <브레틀 리더>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카바레 가곡 <브레틀 리더>', 'Brettl-Lieder', 'song', NULL, NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카바레 가곡 <브레틀 리더>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b519735-4924-4ccb-8f0b-8bbe8e23f3a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b519735-4924-4ccb-8f0b-8bbe8e23f3a4'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '카바레 가곡 <브레틀 리더>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b519735-4924-4ccb-8f0b-8bbe8e23f3a4'
);


-- Op. 3 6개의 가곡 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 3', 'Sechs Lieder, op. 3', 'album', NULL, 'Op.', '3', 1903, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03e1444e-9211-496d-9587-9bf9a43da70c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03e1444e-9211-496d-9587-9bf9a43da70c'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03e1444e-9211-496d-9587-9bf9a43da70c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c0fa14-d5c0-377b-9146-12b13f32b1d8', 1, NULL, 'Wie Georg von Frundsberg von sich selber sang', 'Wie Georg von Frundsberg von sich selber sang, op. 3 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c0fa14-d5c0-377b-9146-12b13f32b1d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d3f0311-199e-3910-83a8-cce1375a5c69', 2, NULL, 'Die Aufgeregten', 'Die Aufgeregten, op. 3 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d3f0311-199e-3910-83a8-cce1375a5c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1612eba-82f6-33f1-bb0c-1c30d03d6a1b', 3, NULL, 'Warnung', 'Warnung, op. 3 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1612eba-82f6-33f1-bb0c-1c30d03d6a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a1217c-16a8-3a78-b4bb-8ced982e5439', 4, NULL, 'Hochzeitslied', 'Hochzeitslied, op. 3 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a1217c-16a8-3a78-b4bb-8ced982e5439'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba5cdf4-08ad-3b98-9088-d91bda98b731', 5, NULL, 'Geübtes Herz', 'Geübtes Herz, op. 3 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba5cdf4-08ad-3b98-9088-d91bda98b731'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a79211a-a9b2-3e93-9315-512afe90633c', 6, NULL, 'Freihold', 'Freihold, op. 3 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 가곡 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a79211a-a9b2-3e93-9315-512afe90633c'
);


-- Op. 5 교향시 <펠레아스와 멜리장드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <펠레아스와 멜리장드>', 'Pelleas und Melisande, op. 5', 'album', 'Op. 5', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <펠레아스와 멜리장드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b651906-3509-4483-8ba2-5d31a23c9f7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b651906-3509-4483-8ba2-5d31a23c9f7f'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b651906-3509-4483-8ba2-5d31a23c9f7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ed37fb9-b9ce-3b0b-958a-1f12ac781d0b', 1, 'I', 'Anfang', 'I. Anfang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed37fb9-b9ce-3b0b-958a-1f12ac781d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58b9d75c-a44a-3e45-a33c-da81d895129e', 2, 'II', 'Heftig', 'II. Heftig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58b9d75c-a44a-3e45-a33c-da81d895129e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de141a1e-4f7a-38d7-8a25-ba42ff5fa059', 3, 'III', 'Lebhaft', 'III. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de141a1e-4f7a-38d7-8a25-ba42ff5fa059'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e38ce1ec-5468-3525-81a5-42e091d78639', 4, 'IV', 'Sehr rasch', 'IV. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e38ce1ec-5468-3525-81a5-42e091d78639'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2dc01d3-a273-3b4a-a691-895da3e78951', 5, 'V', 'Ein wenig bewegt', 'V. Ein wenig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2dc01d3-a273-3b4a-a691-895da3e78951'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0eb3bf8b-c8f5-371d-bb0a-f1a727427e9b', 6, 'VI', 'Langsam', 'VI. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0eb3bf8b-c8f5-371d-bb0a-f1a727427e9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea3256f7-6b55-3cc1-a102-06d31a303826', 7, 'VII', 'Ein wenig bewegter', 'VII. Ein wenig bewegter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea3256f7-6b55-3cc1-a102-06d31a303826'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a174df0-9c7c-316b-832a-d960cf93c1da', 8, 'VIII', 'Sehr langsam', 'VIII. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a174df0-9c7c-316b-832a-d960cf93c1da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47ef5941-8f22-357c-88a5-fecf12eb9c5e', 9, 'IX', 'Etwas bewegt', 'IX. Etwas bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ef5941-8f22-357c-88a5-fecf12eb9c5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87be1dbb-8cae-3228-b8c4-a069e6250c64', 10, 'X', 'In gehender Bewegung', 'X. In gehender Bewegung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87be1dbb-8cae-3228-b8c4-a069e6250c64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f25b5744-3186-325a-805c-bcb45e6458af', 11, 'XI', 'Breit', 'XI. Breit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '교향시 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f25b5744-3186-325a-805c-bcb45e6458af'
);


-- Op. 6 8개의 가곡 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 가곡 Op. 6', 'Acht Lieder, op. 6', 'album', NULL, 'Op.', '6', 1905, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 가곡 Op. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '128f5e35-e918-46e6-b97f-8dbc4d2828cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '128f5e35-e918-46e6-b97f-8dbc4d2828cf'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '128f5e35-e918-46e6-b97f-8dbc4d2828cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63f8fd76-1702-32f1-9bde-fb4e758f01cd', 1, NULL, 'Traumleben', 'Traumleben, op. 6 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63f8fd76-1702-32f1-9bde-fb4e758f01cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60be2e53-6a1f-3b13-97df-7e6770254631', 2, NULL, 'Alles', 'Alles, op. 6 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60be2e53-6a1f-3b13-97df-7e6770254631'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e40d667c-f7f0-30ea-a459-34e6ae80b18c', 3, NULL, 'Mädchenlied', 'Mädchenlied, op. 6 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e40d667c-f7f0-30ea-a459-34e6ae80b18c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a51f640c-02de-30de-8010-550010c4a22f', 4, NULL, 'Verlassen', 'Verlassen, op. 6 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a51f640c-02de-30de-8010-550010c4a22f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e74b6f33-e1c3-3377-87e9-2dd696a9105b', 5, NULL, 'Ghasel', 'Ghasel, op. 6 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e74b6f33-e1c3-3377-87e9-2dd696a9105b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b8cfcc4-f940-3a3b-9990-a8fad9912a77', 6, NULL, 'Am Wegrand', 'Am Wegrand, op. 6 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b8cfcc4-f940-3a3b-9990-a8fad9912a77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8a2a24b-f261-304a-9091-01dc67e9ad96', 7, NULL, 'Lockung', 'Lockung, op. 6 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8a2a24b-f261-304a-9091-01dc67e9ad96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:167c6cb7-3239-3b86-ba38-9b86b058ce27', 8, NULL, 'Der Wanderer', 'Der Wanderer, op. 6 no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '8개의 가곡 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:167c6cb7-3239-3b86-ba38-9b86b058ce27'
);


-- Op. 7 현악 4중주 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 D단조', 'String Quartet no. 1 in D minor, op. 7', 'album', 'Op. 7', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d7243d8-b2ea-47e1-b0f5-11cca2e34f9d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d7243d8-b2ea-47e1-b0f5-11cca2e34f9d'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d7243d8-b2ea-47e1-b0f5-11cca2e34f9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93b7223a-7c47-3702-b159-56a21ce4c4f0', 1, 'I', 'Nicht zu rasch', 'I. Nicht zu rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93b7223a-7c47-3702-b159-56a21ce4c4f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db29eb96-6751-371e-83da-bef246faa8c3', 2, 'II', 'Viel langsamer', 'II. Viel langsamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db29eb96-6751-371e-83da-bef246faa8c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:135f3286-6d58-31df-a1c6-0c957322c135', 3, 'III', 'Kräftig (nicht zu rasch)', 'III. Kräftig (nicht zu rasch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:135f3286-6d58-31df-a1c6-0c957322c135'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0978adbf-9f90-3b1a-b73f-94ca7d3c8f3c', 4, 'IV', 'Mäßig; langsame Viertel', 'IV. Mäßig; langsame Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0978adbf-9f90-3b1a-b73f-94ca7d3c8f3c'
);


-- Op. 8 목소리와 관현악을 위한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리와 관현악을 위한 6개의 가곡', '6 Orchester-Lieder, op. 8', 'album', 'Op. 8', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리와 관현악을 위한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0320b43f-14d6-40f5-a90e-f261d8f86382'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0320b43f-14d6-40f5-a90e-f261d8f86382'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0320b43f-14d6-40f5-a90e-f261d8f86382'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04c13f06-b8d0-4076-8912-2b4c2e257971', 1, 'I', 'Nature', 'I. Nature', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c13f06-b8d0-4076-8912-2b4c2e257971'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f3c11a0-326e-47c3-8625-7b5f6e0fa591', 2, 'II', 'Das Wappenschild', 'II. Das Wappenschild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3c11a0-326e-47c3-8625-7b5f6e0fa591'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b95a59c-f409-4bc0-baea-346abcedae00', 3, 'III', 'Sehnsucht', 'III. Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b95a59c-f409-4bc0-baea-346abcedae00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48a38b29-5aa0-4946-83ae-86c5923d0cba', 4, 'IV', 'Nie ward ich, Herrin, müd', 'IV. Nie ward ich, Herrin, müd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a38b29-5aa0-4946-83ae-86c5923d0cba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaf56f0a-c27b-4f93-a824-98a2eb310ac3', 5, 'V', 'Voll jener Süße', 'V. Voll jener Süße', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaf56f0a-c27b-4f93-a824-98a2eb310ac3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea8a2c54-8852-45a8-9410-a38e97dd0aee', 6, 'VI', 'Wenn Vöglein klagen', 'VI. Wenn Vöglein klagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8a2c54-8852-45a8-9410-a38e97dd0aee'
);


-- Op. 9 실내 교향곡 1번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 교향곡 1번 E장조', 'Chamber Symphony no. 1, op. 9', 'album', 'Op. 9', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 교향곡 1번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82de56f7-039c-4aaf-b667-182893ddf3c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82de56f7-039c-4aaf-b667-182893ddf3c7'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82de56f7-039c-4aaf-b667-182893ddf3c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cfbc147-3042-3db3-9dd0-def38b3a38ec', 1, 'I', 'Langsam - Sehr rasch', 'I. Langsam - Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cfbc147-3042-3db3-9dd0-def38b3a38ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591879a9-b9e3-3b2b-94fd-a420be560419', 2, 'II', 'Sehr rasch', 'II. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591879a9-b9e3-3b2b-94fd-a420be560419'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354a4150-c03e-49e1-8c0e-85310abbaac0', 3, 'III', 'Viel langsamer, aber doch fließend', 'III. Viel langsamer, aber doch fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354a4150-c03e-49e1-8c0e-85310abbaac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17840790-bb2d-3e14-88f8-4936bc375ce7', 4, 'IV', 'Viel langsamer', 'IV. Viel langsamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17840790-bb2d-3e14-88f8-4936bc375ce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:043437b4-5acf-31b0-9d55-40bf5daf4a3c', 5, 'V', 'Schwungvoll', 'V. Schwungvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:043437b4-5acf-31b0-9d55-40bf5daf4a3c'
);


-- Op. 12 2개의 발라드 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 발라드 Op. 12', 'Zwei Balladen, op. 12', 'album', NULL, 'Op.', '12', 1906, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 발라드 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4065bab-8a06-4b27-bf78-a8689434da4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4065bab-8a06-4b27-bf78-a8689434da4a'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 발라드 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4065bab-8a06-4b27-bf78-a8689434da4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4d96b91-dc75-3474-8b47-d1d221cc46aa', 1, NULL, 'Jane Grey', 'Jane Grey, op. 12 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 발라드 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4d96b91-dc75-3474-8b47-d1d221cc46aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56a5861-8ab9-35cc-abf0-7697883a9db4', 2, NULL, 'Der verlorene Haufen', 'Der verlorene Haufen, op. 12 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 발라드 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56a5861-8ab9-35cc-abf0-7697883a9db4'
);


-- Op. 13 혼성 합창을 위한 <지상의 평화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창을 위한 <지상의 평화>', 'Friede auf Erden, op. 13', 'song', 'Op. 13', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창을 위한 <지상의 평화>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea27ffb-4fc3-3df4-8404-462eea57be89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ea27ffb-4fc3-3df4-8404-462eea57be89'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 <지상의 평화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea27ffb-4fc3-3df4-8404-462eea57be89'
);


-- Op. 10 현악 4중주 2번 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번 F#단조', 'String Quartet no. 2 in F-sharp minor, op. 10', 'album', 'Op. 10', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8498c8d4-6985-4a22-bf95-a0f38ea1f1bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8498c8d4-6985-4a22-bf95-a0f38ea1f1bf'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 2번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8498c8d4-6985-4a22-bf95-a0f38ea1f1bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:360420f0-e1c2-33f1-84b3-efab72ec95cc', 1, 'I', 'Mäßig (Moderato)', 'I. Mäßig (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 2번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:360420f0-e1c2-33f1-84b3-efab72ec95cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d34c42b-65d9-34ac-b327-c5fe555f3521', 2, 'II', 'Sehr rasch', 'II. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 2번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d34c42b-65d9-34ac-b327-c5fe555f3521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a84a6da-82df-434f-a4b3-29769874359b', 3, 'III', 'Litanei. Langsam', 'III. “Litanei”. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 2번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a84a6da-82df-434f-a4b3-29769874359b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80fa3844-0454-35e9-a810-1176cab9ecce', 4, 'IV', 'Entrückung. Sehr langsam', 'IV. Entrückung. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 2번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80fa3844-0454-35e9-a810-1176cab9ecce'
);


-- Op. 14 2개의 가곡 Op. 14

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡 Op. 14', 'Zwei Lieder, op. 14', 'album', NULL, 'Op.', '14', 1908, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡 Op. 14'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f0d6ce3-16f4-4fde-a2c4-9721d48db9cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f0d6ce3-16f4-4fde-a2c4-9721d48db9cf'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f0d6ce3-16f4-4fde-a2c4-9721d48db9cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e667ad-148b-32bb-9941-6dcd52854b38', 1, NULL, 'Ich darf nicht dankend', 'Ich darf nicht dankend, op. 14 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e667ad-148b-32bb-9941-6dcd52854b38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4539dc64-ff91-3f98-b8bb-df030c9929ec', 2, NULL, 'In diesen Wintertagen', 'In diesen Wintertagen, op. 14 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 가곡 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4539dc64-ff91-3f98-b8bb-df030c9929ec'
);


-- Op. 11 3개의 피아노 소품 Op. 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 피아노 소품 Op. 11', 'Drei Klavierstücke, op. 11', 'album', NULL, 'Op.', '11', 1909, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 피아노 소품 Op. 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3a3e945-1899-4714-af2b-8d4aa90244ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3a3e945-1899-4714-af2b-8d4aa90244ab'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 피아노 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3a3e945-1899-4714-af2b-8d4aa90244ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:260b0f6d-880a-38f8-93d6-a1bceb23aa69', 1, 'I', 'Mäßig', 'I. Mäßig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 피아노 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:260b0f6d-880a-38f8-93d6-a1bceb23aa69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdaedf82-8246-3fb8-bf89-03413c84c50f', 2, 'II', 'Mäßige Achtel', 'II. Mäßige Achtel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 피아노 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdaedf82-8246-3fb8-bf89-03413c84c50f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c90bd5e-1398-3adb-874f-a4d29dc3602f', 3, 'III', 'Bewegt', 'III. Bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 피아노 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c90bd5e-1398-3adb-874f-a4d29dc3602f'
);


-- Op. 15 연가곡 <공중정원의 책>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡 <공중정원의 책>', 'Das Buch der hängenden Gärten, op. 15', 'album', 'Op. 15', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡 <공중정원의 책>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092e9f6a-4c0d-4718-b4c6-a820c02d975d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '092e9f6a-4c0d-4718-b4c6-a820c02d975d'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '092e9f6a-4c0d-4718-b4c6-a820c02d975d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb20236-4fb0-3683-b896-7213f4486b5b', 1, 'I', 'Unterm Schutz von dichten Blättergründen', 'I. Unterm Schutz von dichten Blättergründen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb20236-4fb0-3683-b896-7213f4486b5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d465f3f-f785-3da9-954e-d0b1d9560d18', 2, 'II', 'Hain in diesen Paradiesen', 'II. Hain in diesen Paradiesen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d465f3f-f785-3da9-954e-d0b1d9560d18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51acce6-b26b-3f8c-a231-ef7e29eadafb', 3, 'III', 'Als Neuling trat ich ein in dein Gehege', 'III. Als Neuling trat ich ein in dein Gehege', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51acce6-b26b-3f8c-a231-ef7e29eadafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912b3d64-48af-3988-89ab-792983f82e36', 4, 'IV', 'Da meine Lippen reglos sind und brennen', 'IV. Da meine Lippen reglos sind und brennen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912b3d64-48af-3988-89ab-792983f82e36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0485ca8b-9147-330c-9fe4-1f72d9366ec1', 5, 'V', 'Saget mir, auf welchem Pfade', 'V. Saget mir, auf welchem Pfade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0485ca8b-9147-330c-9fe4-1f72d9366ec1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81799e0-ef95-353a-aeef-e8f4d4c23e4b', 6, 'VI', 'Jedem Werke bin ich fürder tot', 'VI. Jedem Werke bin ich fürder tot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81799e0-ef95-353a-aeef-e8f4d4c23e4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd7dbedf-5725-390b-91e6-4d726d2801ba', 7, 'VII', 'Angst und Hoffen wechselnd mich beklemmen', 'VII. Angst und Hoffen wechselnd mich beklemmen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd7dbedf-5725-390b-91e6-4d726d2801ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb6688c9-5caa-3c8d-95a6-95af29573682', 8, 'VIII', 'Wenn ich heut nicht deinen Leib berühre', 'VIII. Wenn ich heut nicht deinen Leib berühre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6688c9-5caa-3c8d-95a6-95af29573682'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cd44650-3188-3afa-b1a7-ea213b67c6e0', 9, 'IX', 'Streng ist uns das Glück und spröde', 'IX. Streng ist uns das Glück und spröde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cd44650-3188-3afa-b1a7-ea213b67c6e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f013bd3-30f8-34cd-83fc-43274f0fde23', 10, 'X', 'Das schöne Beet betracht ich mir im Harren', 'X. Das schöne Beet betracht ich mir im Harren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f013bd3-30f8-34cd-83fc-43274f0fde23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acea0551-3da3-3fe1-ba4a-2496edebabf8', 11, 'XI', 'Als wir hinter dem beblümten Tore', 'XI. Als wir hinter dem beblümten Tore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acea0551-3da3-3fe1-ba4a-2496edebabf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:869a8464-65d7-34db-bbf2-fdc9c1b4fec8', 12, 'XII', 'Wenn sich bei heilger Ruh in tiefen Matten', 'XII. Wenn sich bei heilger Ruh in tiefen Matten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:869a8464-65d7-34db-bbf2-fdc9c1b4fec8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:451d3193-32c5-3245-af60-b9f04aa91741', 13, 'XIII', 'Du lehnest wider eine Silberweide', 'XIII. Du lehnest wider eine Silberweide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451d3193-32c5-3245-af60-b9f04aa91741'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bbf2f4d-386f-3661-9412-7b58374e11c8', 14, 'XIV', 'Sprich nicht immer von dem Laub', 'XIV. Sprich nicht immer von dem Laub', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bbf2f4d-386f-3661-9412-7b58374e11c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9a88f6e-371c-3af8-84e3-2dbe09ef1c36', 15, 'XV', 'Wir bevölkerten die abend-düstern Lauben', 'XV. Wir bevölkerten die abend-düstern Lauben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '연가곡 <공중정원의 책>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9a88f6e-371c-3af8-84e3-2dbe09ef1c36'
);


-- Op. 16 관현악을 위한 5개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 5개의 소품', 'Fünf Orchesterstücke, op. 16', 'album', 'Op. 16', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 5개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd73e95f-e2a5-4c36-bc38-4711c3d7fb69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd73e95f-e2a5-4c36-bc38-4711c3d7fb69'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd73e95f-e2a5-4c36-bc38-4711c3d7fb69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb2ed682-76d3-4d6a-8d8a-6f5b3e705a66', 1, 'I', 'Vorgefühle. Sehr rasch', 'I. Vorgefühle. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb2ed682-76d3-4d6a-8d8a-6f5b3e705a66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e159f21-bbce-4a2d-a1ef-5980d851a0ac', 2, 'II', 'Vergangenes. Mässige Viertel', 'II. Vergangenes. Mässige Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e159f21-bbce-4a2d-a1ef-5980d851a0ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:762a624a-474c-47c4-994d-05c81e346429', 3, 'III', 'Farben. Mässige Viertel', 'III. Farben. Mässige Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:762a624a-474c-47c4-994d-05c81e346429'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48f5300e-416d-4710-b318-e3d6615b1bfd', 4, 'IV', 'Peripetie. Sehr rasch', 'IV. Peripetie. Sehr rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48f5300e-416d-4710-b318-e3d6615b1bfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47189568-6081-414c-bd22-d1e8c05f7bed', 5, 'V', 'Das obligate Rezitativ. Bewegte Achtel', 'V. Das obligate Rezitativ. Bewegte Achtel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47189568-6081-414c-bd22-d1e8c05f7bed'
);


-- Op. 17 모노드라마 <기대>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모노드라마 <기대>', 'Erwartung, op. 17', 'song', 'Op. 17', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모노드라마 <기대>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '715e5987-f74a-4078-b755-7e93e55158a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '715e5987-f74a-4078-b755-7e93e55158a5'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '모노드라마 <기대>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '715e5987-f74a-4078-b755-7e93e55158a5'
);


-- None 실내 관현악을 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 관현악을 위한 3개의 소품', '3 Pieces for Chamber Orchestra', 'album', NULL, NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 관현악을 위한 3개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc41b8d5-f798-477f-aa5d-3213c40e4fe4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc41b8d5-f798-477f-aa5d-3213c40e4fe4'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 관현악을 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc41b8d5-f798-477f-aa5d-3213c40e4fe4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8c1171b-6d3e-4596-bb78-e72974b11a47', 1, 'I', 'Rasche Viertel', 'I. Rasche Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 관현악을 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8c1171b-6d3e-4596-bb78-e72974b11a47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73b6536e-7fd7-4e0c-86bd-cebb20e7c35f', 2, 'II', 'Mäßige Viertel', 'II. Mäßige Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 관현악을 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b6536e-7fd7-4e0c-86bd-cebb20e7c35f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d1d71ed-f287-4ab0-8ddd-aeb6538176a1', 3, 'III', 'Gehende Viertel', 'III. Gehende Viertel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 관현악을 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d1d71ed-f287-4ab0-8ddd-aeb6538176a1'
);


-- Op. 19 6개의 작은 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 작은 피아노 소품', 'Sechs kleine Klavierstücke, op. 19', 'album', 'Op. 19', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 작은 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10f1db34-eba0-4997-a34c-b157bcc52c3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10f1db34-eba0-4997-a34c-b157bcc52c3e'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10f1db34-eba0-4997-a34c-b157bcc52c3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:638fab3e-3f1c-3fbf-9c15-0471add21ca3', 1, 'I', 'Leicht, zart', 'I. Leicht, zart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:638fab3e-3f1c-3fbf-9c15-0471add21ca3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e728c5e1-7db8-3d09-b2ac-db9317cd5212', 2, 'II', 'Langsam', 'II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e728c5e1-7db8-3d09-b2ac-db9317cd5212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ce6bb40-ef3e-31cd-8f2d-a0c9b854d62f', 3, 'III', 'Sehr langsam', 'III. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce6bb40-ef3e-31cd-8f2d-a0c9b854d62f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53919328-81aa-3899-be0b-3b1baa6665b0', 4, 'IV', 'Rasch, aber leicht', 'IV. Rasch, aber leicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53919328-81aa-3899-be0b-3b1baa6665b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f056e3ee-b1e0-3798-903a-bea080b47b73', 5, 'V', 'Etwas rasch', 'V. Etwas rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f056e3ee-b1e0-3798-903a-bea080b47b73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1de8530-adaa-310b-994b-82d35712c9f3', 6, 'VI', 'Sehr langsam', 'VI. Sehr langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '6개의 작은 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1de8530-adaa-310b-994b-82d35712c9f3'
);


-- Op. 20 가곡 <Herzgewächse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Herzgewächse>', 'Herzgewächse, op. 20', 'song', 'Op. 20', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Herzgewächse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fa28dc6-725c-4167-9550-c792d53b0f37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1fa28dc6-725c-4167-9550-c792d53b0f37'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '가곡 <Herzgewächse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1fa28dc6-725c-4167-9550-c792d53b0f37'
);


-- None <구레의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<구레의 노래>', 'Gurre-Lieder', 'song', NULL, NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<구레의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47c43fbc-dbd1-40e7-b79a-31618c7e6e43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47c43fbc-dbd1-40e7-b79a-31618c7e6e43'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '<구레의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47c43fbc-dbd1-40e7-b79a-31618c7e6e43'
);


-- Op. 18 음악극 <행복한 손>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악극 <행복한 손>', 'Die glückliche Hand, op. 18', 'song', 'Op. 18', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악극 <행복한 손>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd676f2a7-de6d-4182-a157-ca26685ae014'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd676f2a7-de6d-4182-a157-ca26685ae014'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '음악극 <행복한 손>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd676f2a7-de6d-4182-a157-ca26685ae014'
);


-- Op. 22 목소리와 관현악을 위한 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리와 관현악을 위한 4개의 가곡', 'Vier Lieder, op. 22', 'album', 'Op. 22', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리와 관현악을 위한 4개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24d24b9c-0ce5-4aaa-b846-b414f54f4fa3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24d24b9c-0ce5-4aaa-b846-b414f54f4fa3'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24d24b9c-0ce5-4aaa-b846-b414f54f4fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75f541f9-932f-4b65-9fc4-3ee1106b45e1', 1, 'I', 'Seraphita', 'I. Seraphita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75f541f9-932f-4b65-9fc4-3ee1106b45e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609f8668-b451-434c-8385-a28d9454d0e6', 2, 'II', 'Alle, welche dich suchen', 'II. Alle, welche dich suchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609f8668-b451-434c-8385-a28d9454d0e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5e70e7f-1f6f-4ef9-8626-10838e292f29', 3, 'III', 'Mach mich zum Wächter deiner Weiten', 'III. Mach mich zum Wächter deiner Weiten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5e70e7f-1f6f-4ef9-8626-10838e292f29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950dee26-4eab-41b6-81b5-e72c9f2e5979', 4, 'IV', 'Vorgefühl', 'IV. Vorgefühl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목소리와 관현악을 위한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950dee26-4eab-41b6-81b5-e72c9f2e5979'
);


-- None 오라토리오 <야곱의 사다리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <야곱의 사다리>', 'Die Jakobsleiter', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <야곱의 사다리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2ecf3d8-0a4a-4f0d-84c6-f8886cf5e4ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2ecf3d8-0a4a-4f0d-84c6-f8886cf5e4ac'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '오라토리오 <야곱의 사다리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2ecf3d8-0a4a-4f0d-84c6-f8886cf5e4ac'
);


-- Op. 24 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade, op. 24', 'album', 'Op. 24', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18b615f6-25c9-4757-811a-eb6cc62a6cfe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18b615f6-25c9-4757-811a-eb6cc62a6cfe'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18b615f6-25c9-4757-811a-eb6cc62a6cfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:021b7e3c-05da-409f-bad8-a6a203b37f44', 1, 'I', '행진곡', 'I. Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:021b7e3c-05da-409f-bad8-a6a203b37f44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8914a12f-ed1f-4d92-9bf2-a721e5497b8a', 2, 'II', '미뉴에트', 'II. Menuett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8914a12f-ed1f-4d92-9bf2-a721e5497b8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abce56bc-9f0c-47ed-a5e7-4092eaf42b9a', 3, 'III', '변주곡', 'III. Variationen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abce56bc-9f0c-47ed-a5e7-4092eaf42b9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:813dae7e-bd2d-4217-af58-a14553dad6cb', 4, 'IV', 'Sonett Nr. 217 von Petrarca', 'IV. Sonett Nr. 217 von Petrarca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:813dae7e-bd2d-4217-af58-a14553dad6cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8dc74b-8784-40cb-a802-2db91dceb331', 5, 'V', 'Tanzscene', 'V. Tanzscene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8dc74b-8784-40cb-a802-2db91dceb331'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd09812-efeb-4619-b5cc-52a0b6de87e2', 6, 'VI', 'Lied (ohne Worte)', 'VI. Lied (ohne Worte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd09812-efeb-4619-b5cc-52a0b6de87e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de887303-db50-472c-a4fb-2edbb0a93a84', 7, 'VII', '피날레', 'VII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de887303-db50-472c-a4fb-2edbb0a93a84'
);


-- Op. 25 피아노 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡', 'Suite für Klavier, op. 25', 'album', 'Op. 25', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0051727f-7bb2-4df9-bb1f-fccdea8a5bfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0051727f-7bb2-4df9-bb1f-fccdea8a5bfb'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0051727f-7bb2-4df9-bb1f-fccdea8a5bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e006cf22-ae54-307c-9e14-b850f5cff121', 1, 'I', '전주곡. Rasch', 'I. Präludium. Rasch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e006cf22-ae54-307c-9e14-b850f5cff121'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fae5b429-b09d-3e8a-a85e-911ba8abb3f0', 2, 'II', '가보트. Etwas langsam, nicht hastig', 'II. Gavotte: Etwas langsam, nicht hastig –', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fae5b429-b09d-3e8a-a85e-911ba8abb3f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0de3b6e4-b5e1-3f6d-8103-c863bae47c0d', 3, 'III', '뮈제트. Rascher – Gavotte da capo', 'III. Musette. Rascher – Gavotte da capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de3b6e4-b5e1-3f6d-8103-c863bae47c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0137fa42-66af-3bea-b3e9-dcb4f05801d8', 4, 'IV', '인테르메초', 'IV. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0137fa42-66af-3bea-b3e9-dcb4f05801d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b9d2510-9198-36bb-b2b6-f25117853d01', 5, 'V', '미뉴에트와 트리오', 'V. Menuett. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b9d2510-9198-36bb-b2b6-f25117853d01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d3cd51-81eb-34b5-aa6f-e4855c7aff68', 6, 'VI', '지그', 'VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d3cd51-81eb-34b5-aa6f-e4855c7aff68'
);


-- Op. 26 목관 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목관 5중주', 'Quintett für Flöte, Oboe, Klarinette, Horn und Fagott, op. 26', 'album', 'Op. 26', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목관 5중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349cf6a4-5b8a-4be9-8348-cf8eb6bc74a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '349cf6a4-5b8a-4be9-8348-cf8eb6bc74a9'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349cf6a4-5b8a-4be9-8348-cf8eb6bc74a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e83b4bc-31eb-4785-bef7-8df14d0844ac', 1, 'I', 'Schwungvoll', 'I. Schwungvoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e83b4bc-31eb-4785-bef7-8df14d0844ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a418c4a6-d6a8-481b-b8cb-a7079549fc99', 2, 'II', 'Anmutig und heiter. Scherzando', 'II. Anmutig und heiter. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a418c4a6-d6a8-481b-b8cb-a7079549fc99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7ea7abd-daf5-4e11-b3f8-21d867adf703', 3, 'III', 'Etwas langsam (Poco adagio)', 'III. Etwas langsam (Poco adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ea7abd-daf5-4e11-b3f8-21d867adf703'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4b08aef-3fe8-48d2-8926-b344a88df3b5', 4, 'IV', '론도', 'IV. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4b08aef-3fe8-48d2-8926-b344a88df3b5'
);


-- Op. 27 혼성 합창을 위한 4개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창을 위한 4개의 소품', '4 Stücke für gemischten Chor, op. 27', 'album', 'Op. 27', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창을 위한 4개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d8ff4cd-9e93-47fd-b5c2-661391d1bb8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d8ff4cd-9e93-47fd-b5c2-661391d1bb8b'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d8ff4cd-9e93-47fd-b5c2-661391d1bb8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a60876be-9ce1-428b-a1b5-44a68ad106f8', 1, 'I', 'Unentrinnbar', 'I. Unentrinnbar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a60876be-9ce1-428b-a1b5-44a68ad106f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08dbd1fe-7502-4244-a835-d96470af1cec', 2, 'II', 'Du sollst nicht, du musst', 'II. Du sollst nicht, du musst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08dbd1fe-7502-4244-a835-d96470af1cec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e63f2148-f563-4bf0-9917-ce8dc18e3495', 3, 'III', 'Mond und Menschen', 'III. Mond und Menschen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e63f2148-f563-4bf0-9917-ce8dc18e3495'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba2cd61-51ba-46e8-a0ce-a8de73ce4ab5', 4, 'IV', 'Der Wunsch des Liebhabers', 'IV. Der Wunsch des Liebhabers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 4개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba2cd61-51ba-46e8-a0ce-a8de73ce4ab5'
);


-- Op. 28 혼성 합창을 위한 3개의 풍자곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창을 위한 3개의 풍자곡', '3 Satiren für gemischten Chor, op. 28', 'album', 'Op. 28', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창을 위한 3개의 풍자곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de614d53-b4fc-4c9c-b131-723f41e963cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de614d53-b4fc-4c9c-b131-723f41e963cf'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 3개의 풍자곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de614d53-b4fc-4c9c-b131-723f41e963cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb354e9-801f-4e22-8a13-b73c5c7b887e', 1, 'I', 'Am Scheideweg', 'I. Am Scheideweg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 3개의 풍자곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb354e9-801f-4e22-8a13-b73c5c7b887e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f92a0b-f4fe-451e-8d9e-e241489c82e6', 2, 'II', 'Vielseitigkeit', 'II. Vielseitigkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 3개의 풍자곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f92a0b-f4fe-451e-8d9e-e241489c82e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffdc7ccd-4ae4-4b01-8c7e-efa6ad5bbb50', 3, 'III', 'Der neue Klassizismus', 'III. Der neue Klassizismus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '혼성 합창을 위한 3개의 풍자곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffdc7ccd-4ae4-4b01-8c7e-efa6ad5bbb50'
);


-- Op. 29 7중주를 위한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7중주를 위한 모음곡', 'Suite, op. 29', 'album', 'Op. 29', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7중주를 위한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99a4da4f-80b7-4335-bcb4-344c0a4e0411'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99a4da4f-80b7-4335-bcb4-344c0a4e0411'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '7중주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99a4da4f-80b7-4335-bcb4-344c0a4e0411'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b209ebbd-045b-45e7-a4da-af472c6dfd2a', 1, 'I', '서곡', 'I. Overtüre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '7중주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b209ebbd-045b-45e7-a4da-af472c6dfd2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df7dd2b8-69b7-44f5-a54d-fb96a3ebb686', 2, 'II', 'Tanzschritte', 'II. Tanzschritte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '7중주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7dd2b8-69b7-44f5-a54d-fb96a3ebb686'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e3d5175-1ceb-4912-a5f6-053fa014a9e9', 3, 'III', '주제와 변주', 'III. Thema mit Variationen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '7중주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e3d5175-1ceb-4912-a5f6-053fa014a9e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4a18355-4c2c-44e9-8051-e8104f02be9e', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '7중주를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4a18355-4c2c-44e9-8051-e8104f02be9e'
);


-- Op. 30 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3, op. 30', 'album', 'Op. 30', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb6f0929-154a-4d76-ab21-3c63a2c2ad64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb6f0929-154a-4d76-ab21-3c63a2c2ad64'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb6f0929-154a-4d76-ab21-3c63a2c2ad64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed21d48-b3d4-339a-a6e4-c155672dafcc', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed21d48-b3d4-339a-a6e4-c155672dafcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1944e038-b04c-3ab0-8a45-8bceeed9b410', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1944e038-b04c-3ab0-8a45-8bceeed9b410'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8773c3e-80f9-32da-9672-7a1f7dbc5101', 3, 'III', '인테르메초, Allegro moderato', 'III. Intermezzo, Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8773c3e-80f9-32da-9672-7a1f7dbc5101'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e19dee-f9b3-328f-9651-9c4cc5b4ec64', 4, 'IV', '론도. Molto moderato', 'IV. Rondo. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e19dee-f9b3-328f-9651-9c4cc5b4ec64'
);


-- Op. 31 관현악을 위한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 변주곡', 'Variations for Orchestra, op. 31', 'album', 'Op. 31', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43706668-1a9f-48f0-bbb3-13189e674730'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43706668-1a9f-48f0-bbb3-13189e674730'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43706668-1a9f-48f0-bbb3-13189e674730'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01a40343-1ffa-3a7d-8d93-e92295214f64', 1, NULL, '서주', 'Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01a40343-1ffa-3a7d-8d93-e92295214f64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60308431-b5a7-3e08-a8f5-d7b80a0c9e08', 2, NULL, '주제', 'Thema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60308431-b5a7-3e08-a8f5-d7b80a0c9e08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c91e1b-29f7-369e-b1ff-970bf392c3c7', 3, 'I', '변주', 'I. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c91e1b-29f7-369e-b1ff-970bf392c3c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22a74a3-92b8-3d87-98a6-ad55844214c7', 4, 'II', '변주', 'II. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22a74a3-92b8-3d87-98a6-ad55844214c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2642789a-5af9-3424-92f2-081d4f9855dd', 5, 'III', '변주', 'III. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2642789a-5af9-3424-92f2-081d4f9855dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4afeb461-dcd1-3250-9d57-2f749c8f5f91', 6, 'IV', '변주', 'IV. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4afeb461-dcd1-3250-9d57-2f749c8f5f91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c134ed17-bf76-3e34-bb16-d28d97ce2b15', 7, 'V', '변주', 'V. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c134ed17-bf76-3e34-bb16-d28d97ce2b15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a321cfd8-c321-32ab-894d-a6305b8ea1f5', 8, 'VI', '변주', 'VI. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a321cfd8-c321-32ab-894d-a6305b8ea1f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53fffaa6-1aad-3cc2-abf9-3a8f5d6e9f77', 9, 'VII', '변주', 'VII. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53fffaa6-1aad-3cc2-abf9-3a8f5d6e9f77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f192e067-5445-35b3-93dd-2d18f52b5dab', 10, 'VIII', '변주', 'VIII. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f192e067-5445-35b3-93dd-2d18f52b5dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25a0b180-7db1-3b31-9830-e5c0ac55b6b3', 11, 'IX', '변주', 'IX. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a0b180-7db1-3b31-9830-e5c0ac55b6b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cd1b8c2-ed98-3f39-9fb5-6a9323e22561', 12, NULL, '피날레', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '관현악을 위한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cd1b8c2-ed98-3f39-9fb5-6a9323e22561'
);


-- Op. 32 오페라 <오늘부터 내일까지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오늘부터 내일까지>', 'Von heute auf morgen, op. 32', 'song', 'Op. 32', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오늘부터 내일까지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efb07e92-4312-4bab-9b89-403173591333'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efb07e92-4312-4bab-9b89-403173591333'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '오페라 <오늘부터 내일까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efb07e92-4312-4bab-9b89-403173591333'
);


-- Op. 34 영화의 한 장면을 위한 반주 음악

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화의 한 장면을 위한 반주 음악', 'Accompaniment to a Cinematographic Scene, op. 34', 'song', 'Op. 34', NULL, NULL, 1930, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화의 한 장면을 위한 반주 음악'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b07be9d-116c-4165-a1f6-fd5ef1babe2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b07be9d-116c-4165-a1f6-fd5ef1babe2f'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '영화의 한 장면을 위한 반주 음악' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b07be9d-116c-4165-a1f6-fd5ef1babe2f'
);


-- Op. 35 남성 합창을 위한 6개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 6개의 소품', 'Sechs Stücke für Männerchor, op. 35', 'album', 'Op. 35', NULL, NULL, 1930, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 6개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad160b3e-b2a6-4520-ac21-1df4b9f3d4bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad160b3e-b2a6-4520-ac21-1df4b9f3d4bc'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad160b3e-b2a6-4520-ac21-1df4b9f3d4bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f63f41-07e6-4bcf-961f-96941d36d843', 1, NULL, 'Hemmung', 'Nr. 1. Hemmung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f63f41-07e6-4bcf-961f-96941d36d843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea7fdc2-ed3e-4f9d-a591-3735cf117cd1', 2, NULL, 'Das Gesetz', 'Nr. 2. Das Gesetz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea7fdc2-ed3e-4f9d-a591-3735cf117cd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae01545a-306f-4ef9-b144-dd0cbf24bafa', 3, NULL, 'Ausdrucksweise', 'Nr. 3. Ausdrucksweise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae01545a-306f-4ef9-b144-dd0cbf24bafa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:080d08aa-b0f0-4f05-a9c5-c62dcf84c78a', 4, NULL, 'Glück', 'Nr. 4. Glück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:080d08aa-b0f0-4f05-a9c5-c62dcf84c78a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c441a45b-370b-4522-8e57-660d9187a771', 5, NULL, 'Landsknechte', 'Nr. 5. Landsknechte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c441a45b-370b-4522-8e57-660d9187a771'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a402090a-6c25-4915-8aef-9c5eb8795d63', 6, NULL, 'Verbundenheit', 'Nr. 6. Verbundenheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '남성 합창을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a402090a-6c25-4915-8aef-9c5eb8795d63'
);


-- Op. 33 2개의 피아노 소품 Op. 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 피아노 소품 Op. 33', 'Klavierstücke, op. 33', 'album', NULL, 'Op.', '33', 1931, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 피아노 소품 Op. 33'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47926a7d-536c-40b4-b2e4-cbee60e9237c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47926a7d-536c-40b4-b2e4-cbee60e9237c'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 피아노 소품 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47926a7d-536c-40b4-b2e4-cbee60e9237c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21deadb6-a45b-3496-b079-3f3a334d14d7', 1, NULL, '피아노 소품 Op. 33a', 'Klavierstück, op. 33a', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 피아노 소품 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21deadb6-a45b-3496-b079-3f3a334d14d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e388315-9c1a-30a3-ad7d-7ff58ed238b4', 2, NULL, '피아노 소품 Op. 33b', 'Klavierstück, op. 33b', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '2개의 피아노 소품 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e388315-9c1a-30a3-ad7d-7ff58ed238b4'
);


-- None 오페라 <모세와 아론>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <모세와 아론>', 'Moses und Aron', 'song', NULL, NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <모세와 아론>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1663fcb1-1d55-4a4f-bb68-bbaed80bbc31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1663fcb1-1d55-4a4f-bb68-bbaed80bbc31'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '오페라 <모세와 아론>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1663fcb1-1d55-4a4f-bb68-bbaed80bbc31'
);


-- Op. 48 3개의 가곡 Op. 48

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 가곡 Op. 48', 'Drei Lieder, op. 48', 'album', NULL, 'Op.', '48', 1933, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 가곡 Op. 48'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503b6cba-ebd5-42b9-85b7-49165ee5689d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '503b6cba-ebd5-42b9-85b7-49165ee5689d'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503b6cba-ebd5-42b9-85b7-49165ee5689d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7295bae-bac2-380a-841a-d5998f07338a', 1, NULL, 'Sommermüd', 'Sommermüd, op. 48 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7295bae-bac2-380a-841a-d5998f07338a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cfd434b-8764-34bd-a8ee-f5077c8f0984', 2, NULL, 'Tot', 'Tot, op. 48 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfd434b-8764-34bd-a8ee-f5077c8f0984'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dae29e57-79f2-37de-9a4a-1a02eb907831', 3, NULL, 'Mädchenlied', 'Mädchenlied, op. 48 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '3개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dae29e57-79f2-37de-9a4a-1a02eb907831'
);


-- None 현악 합주를 위한 모음곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 합주를 위한 모음곡 G장조', 'Suite for String Orchestra in G major', 'album', NULL, NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 합주를 위한 모음곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9326c0e5-5a76-4b6d-ae76-e9b62bb009a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9326c0e5-5a76-4b6d-ae76-e9b62bb009a0'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9326c0e5-5a76-4b6d-ae76-e9b62bb009a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349cc437-3f2f-372e-ba19-caa41b5e7d5f', 1, 'I', '서곡', 'I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349cc437-3f2f-372e-ba19-caa41b5e7d5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7dfcf1-2d1e-3a74-94c7-962b4b7e36af', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7dfcf1-2d1e-3a74-94c7-962b4b7e36af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba68f4f-e978-3d62-83be-ff67e6a18d88', 3, 'III', '미뉴에트와 트리오', 'III. Menuet and Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba68f4f-e978-3d62-83be-ff67e6a18d88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83751260-6a2a-351f-8bbc-7d03f76c713f', 4, 'IV', '가보트', 'IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83751260-6a2a-351f-8bbc-7d03f76c713f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aad84f9-41b3-306b-9c8e-d62ef700c226', 5, 'V', '지그', 'V. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 합주를 위한 모음곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aad84f9-41b3-306b-9c8e-d62ef700c226'
);


-- Op. 36 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto, op. 36', 'album', 'Op. 36', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '001c53e9-8586-49b5-a058-c39bd0aacf78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '001c53e9-8586-49b5-a058-c39bd0aacf78'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '001c53e9-8586-49b5-a058-c39bd0aacf78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea1adedf-b670-3264-bd67-ba5c4b893617', 1, 'I', 'Poco allegro - Vivace', 'I. Poco allegro - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1adedf-b670-3264-bd67-ba5c4b893617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d889df5e-6336-33b7-9857-98c1c62786b1', 2, 'II', 'Andante grazioso', 'II: Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d889df5e-6336-33b7-9857-98c1c62786b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b572f0e8-d92d-322c-8a54-d5f252c399db', 3, 'III', '피날레. Allegro', 'III. Finale: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b572f0e8-d92d-322c-8a54-d5f252c399db'
);


-- Op. 37 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet no. 4, op. 37', 'album', 'Op. 37', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6a3731f-3330-41ba-a685-1a9b9f4dd2c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6a3731f-3330-41ba-a685-1a9b9f4dd2c8'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6a3731f-3330-41ba-a685-1a9b9f4dd2c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b7cbff7-d1e1-3a32-a643-d0dc726c9424', 1, 'I', 'Allegro molto. Energico', 'I. Allegro molto. Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b7cbff7-d1e1-3a32-a643-d0dc726c9424'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:648e36fe-160c-3fa1-93b0-9a94002a6803', 2, 'II', 'Comodo', 'II. Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:648e36fe-160c-3fa1-93b0-9a94002a6803'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d93c53-fb4b-3c04-a815-18bc53d8f9cf', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d93c53-fb4b-3c04-a815-18bc53d8f9cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4c06ad1-21b9-3df8-9654-70cbc04b7272', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4c06ad1-21b9-3df8-9654-70cbc04b7272'
);


-- Op. 39 합창과 관현악을 위한 <콜 니드레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 관현악을 위한 <콜 니드레>', 'Kol Nidre, op. 39', 'song', 'Op. 39', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 관현악을 위한 <콜 니드레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e77dec7-d790-4056-ad0c-abc8c72b82c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e77dec7-d790-4056-ad0c-abc8c72b82c9'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '합창과 관현악을 위한 <콜 니드레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e77dec7-d790-4056-ad0c-abc8c72b82c9'
);


-- Op. 38 실내 교향곡 2번 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 교향곡 2번 E♭단조', 'Chamber Symphony no. 2, op. 38', 'album', 'Op. 38', NULL, NULL, 1939, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 교향곡 2번 E♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4b82176-27bf-423b-a13e-9e495bc3981a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4b82176-27bf-423b-a13e-9e495bc3981a'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 2번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4b82176-27bf-423b-a13e-9e495bc3981a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a28de0e-af4a-3bc9-9322-b6db48a720e7', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 2번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a28de0e-af4a-3bc9-9322-b6db48a720e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cf3a722-f7ac-3713-960f-82a0c9cdd952', 2, 'II', 'Con fuoco', 'II. Con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '실내 교향곡 2번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cf3a722-f7ac-3713-960f-82a0c9cdd952'
);


-- Op. 40 오르간을 위한 레치타티보 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 레치타티보 변주곡', 'Variations on a Recitative, op. 40', 'song', 'Op. 40', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 레치타티보 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2178e909-393c-3872-8883-3eeed7915051'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2178e909-393c-3872-8883-3eeed7915051'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '오르간을 위한 레치타티보 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2178e909-393c-3872-8883-3eeed7915051'
);


-- Op. 41 <나폴레옹 보나파르트에게 바치는 송가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<나폴레옹 보나파르트에게 바치는 송가>', 'Ode to Napoleon Buonaparte, op. 41', 'song', 'Op. 41', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<나폴레옹 보나파르트에게 바치는 송가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fe43d22-5b9d-36d9-ba7f-a4eb0f406461'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9fe43d22-5b9d-36d9-ba7f-a4eb0f406461'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '<나폴레옹 보나파르트에게 바치는 송가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fe43d22-5b9d-36d9-ba7f-a4eb0f406461'
);


-- Op. 42 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Concerto for Piano and Orchestra, op. 42', 'album', 'Op. 42', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd22273d1-02a6-4043-88d8-0e88d497e4cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd22273d1-02a6-4043-88d8-0e88d497e4cb'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd22273d1-02a6-4043-88d8-0e88d497e4cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79d514f1-ffb1-3536-b015-fbec5cc08432', 1, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d514f1-ffb1-3536-b015-fbec5cc08432'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a19e08-d580-38cd-91cb-69b3a44ea067', 2, NULL, 'Molto allegro', 'Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a19e08-d580-38cd-91cb-69b3a44ea067'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:244d1b4a-5f05-3190-9f0a-e6104882f478', 3, NULL, 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:244d1b4a-5f05-3190-9f0a-e6104882f478'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1273fac3-3791-37fb-9f49-ccae720fa68d', 4, NULL, 'Giocoso (Moderato)', 'Giocoso (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1273fac3-3791-37fb-9f49-ccae720fa68d'
);


-- Op. 43a 취주악을 위한 주제와 변주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '취주악을 위한 주제와 변주', 'Theme and Variations, op. 43a', 'album', 'Op. 43a', NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '취주악을 위한 주제와 변주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec59460a-4cca-431e-bf52-14b2ba225a68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec59460a-4cca-431e-bf52-14b2ba225a68'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec59460a-4cca-431e-bf52-14b2ba225a68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4475ed44-b69e-401a-be53-8d349d33787d', 1, NULL, '주제', '1. Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4475ed44-b69e-401a-be53-8d349d33787d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d37362d-4800-45b5-b2cb-544f47358267', 2, NULL, '변주 1', '2. Variation 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d37362d-4800-45b5-b2cb-544f47358267'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:923d5ffa-ecfd-4d32-b672-7ec501863bbf', 3, NULL, '변주 2', '3. Variation 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:923d5ffa-ecfd-4d32-b672-7ec501863bbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c382f26-c285-4800-9914-4a7404049d8c', 4, NULL, '변주 3', '4. Variation 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c382f26-c285-4800-9914-4a7404049d8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5c835dc-1a87-40d1-bd9a-0c4d2c4d8eb0', 5, NULL, '변주 4', '5. Variation 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c835dc-1a87-40d1-bd9a-0c4d2c4d8eb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fee79a19-3765-42f0-8f77-003cefec7c12', 6, NULL, '변주 5', '6. Variation 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fee79a19-3765-42f0-8f77-003cefec7c12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:021db1d5-2972-4f06-a828-09a89cad48d8', 7, NULL, '변주 6', '7. Variation 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:021db1d5-2972-4f06-a828-09a89cad48d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89a64816-3f5f-43c1-ad15-7f2e6dc74a96', 8, NULL, '변주 7', '8. Variation 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a64816-3f5f-43c1-ad15-7f2e6dc74a96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14258f8b-4938-49f9-8ab7-7a5e7360172a', 9, NULL, '피날레', '9. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '취주악을 위한 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14258f8b-4938-49f9-8ab7-7a5e7360172a'
);


-- Op. 44 <창세기 모음곡> 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<창세기 모음곡> 전주곡', 'Genesis Suite: Prelude, op. 44', 'song', 'Op. 44', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<창세기 모음곡> 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dff810c7-56f9-408e-95af-16211ce66938'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dff810c7-56f9-408e-95af-16211ce66938'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '<창세기 모음곡> 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dff810c7-56f9-408e-95af-16211ce66938'
);


-- Op. 45 현악 3중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 3중주', 'String Trio, op. 45', 'song', 'Op. 45', NULL, NULL, 1946, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 3중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9458ed35-6b59-4878-a550-c1ed5e764b63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9458ed35-6b59-4878-a550-c1ed5e764b63'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '현악 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9458ed35-6b59-4878-a550-c1ed5e764b63'
);


-- Op. 47 바이올린과 피아노를 위한 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 환상곡', 'Phantasy for Violin with Piano Accompaniment, op. 47', 'song', 'Op. 47', NULL, NULL, 1949, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba561d1c-f41d-3d6a-9f0e-e1616396eff3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba561d1c-f41d-3d6a-9f0e-e1616396eff3'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '바이올린과 피아노를 위한 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba561d1c-f41d-3d6a-9f0e-e1616396eff3'
);


-- Op. 50a 합창곡 <Dreimal tausend Jahre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Dreimal tausend Jahre>', 'Dreimal tausend Jahre, op. 50a', 'song', 'Op. 50a', NULL, NULL, 1949, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Dreimal tausend Jahre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd81c565e-e6f3-452a-a4cb-fa8c809988d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd81c565e-e6f3-452a-a4cb-fa8c809988d1'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '합창곡 <Dreimal tausend Jahre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd81c565e-e6f3-452a-a4cb-fa8c809988d1'
);


-- Op. 50b 시편 130편 <데 프로푼디스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 130편 <데 프로푼디스>', 'De profundis, op. 50b', 'song', 'Op. 50b', NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 82
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 130편 <데 프로푼디스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c287d99-6e1a-459b-9093-3a034a58be0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c287d99-6e1a-459b-9093-3a034a58be0b'
FROM pieces p
WHERE p.composer_id = 82 AND p.title = '시편 130편 <데 프로푼디스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c287d99-6e1a-459b-9093-3a034a58be0b'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '현과 하프를 위한 녹턴' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE composer_id = 82 AND title = '피아노 연탄을 위한 6개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 82 AND title = '현악 4중주 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '2개의 가곡 Op. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '4개의 가곡 Op. 2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '카바레 가곡 <브레틀 리더>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '6개의 가곡 Op. 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 82 AND title = '교향시 <펠레아스와 멜리장드>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '8개의 가곡 Op. 6' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 82 AND title = '현악 4중주 1번 D단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '목소리와 관현악을 위한 6개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony_other'
WHERE composer_id = 82 AND title = '실내 교향곡 1번 E장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '2개의 발라드 Op. 12' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '혼성 합창을 위한 <지상의 평화>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 82 AND title = '현악 4중주 2번 F#단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '2개의 가곡 Op. 14' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 82 AND title = '3개의 피아노 소품 Op. 11' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '연가곡 <공중정원의 책>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '관현악을 위한 5개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 82 AND title = '모노드라마 <기대>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '실내 관현악을 위한 3개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 82 AND title = '6개의 작은 피아노 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '가곡 <Herzgewächse>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 82 AND title = '<구레의 노래>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 82 AND title = '음악극 <행복한 손>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '목소리와 관현악을 위한 4개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 82 AND title = '오라토리오 <야곱의 사다리>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 82 AND title = '세레나데' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'keyboard_suite'
WHERE composer_id = 82 AND title = '피아노 모음곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 82 AND title = '목관 5중주' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '혼성 합창을 위한 4개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '혼성 합창을 위한 3개의 풍자곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 82 AND title = '7중주를 위한 모음곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 82 AND title = '현악 4중주 3번' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '관현악을 위한 변주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 82 AND title = '오페라 <오늘부터 내일까지>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '영화의 한 장면을 위한 반주 음악' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '남성 합창을 위한 6개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 82 AND title = '2개의 피아노 소품 Op. 33' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 82 AND title = '오페라 <모세와 아론>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 82 AND title = '3개의 가곡 Op. 48' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 82 AND title = '현악 합주를 위한 모음곡 G장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 82 AND title = '바이올린 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 82 AND title = '현악 4중주 4번' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '합창과 관현악을 위한 <콜 니드레>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony_other'
WHERE composer_id = 82 AND title = '실내 교향곡 2번 E♭단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE composer_id = 82 AND title = '오르간을 위한 레치타티보 변주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 82 AND title = '<나폴레옹 보나파르트에게 바치는 송가>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'piano_concerto'
WHERE composer_id = 82 AND title = '피아노 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 82 AND title = '취주악을 위한 주제와 변주' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '<창세기 모음곡> 전주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE composer_id = 82 AND title = '현악 3중주' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 82 AND title = '바이올린과 피아노를 위한 환상곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '합창곡 <Dreimal tausend Jahre>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 82 AND title = '시편 130편 <데 프로푼디스>' AND genre IS NULL AND form_key IS NULL;
