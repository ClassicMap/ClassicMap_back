-- 게오르크 필리프 텔레만(composer_id 11) 작품 목록. 지금은 작곡가 화면에 5곡(타펠무지크·비올라 협주곡·리코더 모음곡·돈키호테·파리 4중주)뿐이다.
-- 작품 78개(새 73 + 기존 5), 묶음·다악장 작품 안 곡 365개, 그 안 악장 549개, 장르·형식.
--
-- 작품은 손으로 골랐다: 관현악 모음곡 10(수상 음악·민족들·알스터 등)과 비올라 다 감바 모음곡·신포니아 2, 협주곡 28,
-- 출판 실내악·건반 묶음 9(무반주 플루트·바이올린 환상곡, 하프시코드 환상곡 36곡, 음악 연습, 베이스 없는 소나타 등)와 실내악 2,
-- 오페라 7, 수난곡·오라토리오 9, 칸타타 4, 마니피카트.
-- 곡은 MusicBrainz parts 순서, 타펠무지크·파리 4중주·음악 연습·카논풍 소나타는 손으로 정한 순서(parts.tsv)다. 자료와 생성기:
--   seed_pipeline/curation/baroque-catalog-2026-11-12/(build.py, telemann/works.tsv·parts.tsv) → catalog-wave4 gen_catalog.py
-- 기존 5곡은 제목·설명·링크를 두고 MBID 와 곡만 잇는다(타펠무지크 18곡, 파리 4중주 12곡 등).
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- TWV 50-55 타펠무지크

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bfbcacb0-d8ad-4b1c-ab46-4ea72bfabf16'
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bfbcacb0-d8ad-4b1c-ab46-4ea72bfabf16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서곡 E단조 (1부)', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b', 1, NULL, '서곡 E단조 (1부)', 'Ouverture-Suite in E minor, TWV 55:e1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture. Lentement - Vite - Lentement', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: I. Ouverture. Lentement - Vite - Lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6c7866af-a909-4a5f-8299-67f281e9cdc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c7866af-a909-4a5f-8299-67f281e9cdc1', 1, 'I', 'Ouverture. Lentement - Vite - Lentement', 'Ouverture-Suite in E minor, TWV 55:e1: I. Ouverture. Lentement - Vite - Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c7866af-a909-4a5f-8299-67f281e9cdc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Réjouissance', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: II. Réjouissance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:578cad05-19c4-4cc6-8f9e-95269144b90e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:578cad05-19c4-4cc6-8f9e-95269144b90e', 2, 'II', 'Réjouissance', 'Ouverture-Suite in E minor, TWV 55:e1: II. Réjouissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:578cad05-19c4-4cc6-8f9e-95269144b90e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondeau', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: III. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:068708c8-cd1f-4c46-bcfe-2ef700b1c58a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:068708c8-cd1f-4c46-bcfe-2ef700b1c58a', 3, 'III', 'Rondeau', 'Ouverture-Suite in E minor, TWV 55:e1: III. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:068708c8-cd1f-4c46-bcfe-2ef700b1c58a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Loure', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: IV. Loure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:2e3af70d-35f2-4cad-b58f-6ad6221c487a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e3af70d-35f2-4cad-b58f-6ad6221c487a', 4, 'IV', 'Loure', 'Ouverture-Suite in E minor, TWV 55:e1: IV. Loure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e3af70d-35f2-4cad-b58f-6ad6221c487a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Passepied', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: V. Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1844691d-f8ed-422d-89a0-98538cca5e4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1844691d-f8ed-422d-89a0-98538cca5e4d', 5, 'V', 'Passepied', 'Ouverture-Suite in E minor, TWV 55:e1: V. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1844691d-f8ed-422d-89a0-98538cca5e4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Air. Un peu vivement', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: VI. Air. Un peu vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d59e6691-a597-492c-b1f2-418e57c0603e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d59e6691-a597-492c-b1f2-418e57c0603e', 6, 'VI', 'Air. Un peu vivement', 'Ouverture-Suite in E minor, TWV 55:e1: VI. Air. Un peu vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59e6691-a597-492c-b1f2-418e57c0603e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Gigue', part.name_en = 'Ouverture-Suite in E minor, TWV 55:e1: VII. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:792244dc-72b7-4ac5-a312-10d6c73ad9d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:792244dc-72b7-4ac5-a312-10d6c73ad9d4', 7, 'VII', 'Gigue', 'Ouverture-Suite in E minor, TWV 55:e1: VII. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c85384d-9632-43a9-80de-ffd1e74ae04b'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792244dc-72b7-4ac5-a312-10d6c73ad9d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '4중주 G장조 (1부)', part.name_en = 'Quartet in G major, TWV 43:G2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57', 2, NULL, '4중주 G장조 (1부)', 'Quartet in G major, TWV 43:G2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo - Allegro - Largo', part.name_en = 'Quartet in G major, TWV 43:G2: I. Largo - Allegro - Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:b57d2c7b-7d62-4683-a5fb-3ef09687da6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b57d2c7b-7d62-4683-a5fb-3ef09687da6e', 1, 'I', 'Largo - Allegro - Largo', 'Quartet in G major, TWV 43:G2: I. Largo - Allegro - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b57d2c7b-7d62-4683-a5fb-3ef09687da6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace - Moderato - Vivace', part.name_en = 'Quartet in G major, TWV 43:G2: II. Vivace - Moderato - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a1013dc6-aaf4-42e5-ab40-753bae08e366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1013dc6-aaf4-42e5-ab40-753bae08e366', 2, 'II', 'Vivace - Moderato - Vivace', 'Quartet in G major, TWV 43:G2: II. Vivace - Moderato - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1013dc6-aaf4-42e5-ab40-753bae08e366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grave', part.name_en = 'Quartet in G major, TWV 43:G2: III. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:e880d602-b638-49db-b8f7-286d30dbfc85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e880d602-b638-49db-b8f7-286d30dbfc85', 3, 'III', 'Grave', 'Quartet in G major, TWV 43:G2: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e880d602-b638-49db-b8f7-286d30dbfc85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Quartet in G major, TWV 43:G2: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:ce74c740-92ca-41ca-9121-fbb8f3dec219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce74c740-92ca-41ca-9121-fbb8f3dec219', 4, 'IV', 'Vivace', 'Quartet in G major, TWV 43:G2: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7194f438-4dd2-4c67-ad0e-7fb7e758cc57'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce74c740-92ca-41ca-9121-fbb8f3dec219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '플루트·바이올린·첼로를 위한 협주곡 A장조 (1부)', part.name_en = 'Concerto for Flute, Violin and Cello, TWV 53:A2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625', 3, NULL, '플루트·바이올린·첼로를 위한 협주곡 A장조 (1부)', 'Concerto for Flute, Violin and Cello, TWV 53:A2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Concerto for Flute, Violin and Cello, TWV 53:A2: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:0a4d384e-b5a2-4af5-8ce4-1d2d962762b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a4d384e-b5a2-4af5-8ce4-1d2d962762b5', 1, 'I', 'Largo', 'Concerto for Flute, Violin and Cello, TWV 53:A2: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a4d384e-b5a2-4af5-8ce4-1d2d962762b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Flute, Violin and Cello, TWV 53:A2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:04f41d26-ff64-4636-b533-7547cfb57182' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04f41d26-ff64-4636-b533-7547cfb57182', 2, 'II', 'Allegro', 'Concerto for Flute, Violin and Cello, TWV 53:A2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f41d26-ff64-4636-b533-7547cfb57182'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gratioso', part.name_en = 'Concerto for Flute, Violin and Cello, TWV 53:A2: III. Gratioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:9a91964c-fc8c-4982-b025-3b5bbe990bf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a91964c-fc8c-4982-b025-3b5bbe990bf8', 3, 'III', 'Gratioso', 'Concerto for Flute, Violin and Cello, TWV 53:A2: III. Gratioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a91964c-fc8c-4982-b025-3b5bbe990bf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Flute, Violin and Cello, TWV 53:A2: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f3b7de73-02d8-49e5-ad8a-2ac8fa954ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3b7de73-02d8-49e5-ad8a-2ac8fa954ef6', 4, 'IV', 'Allegro', 'Concerto for Flute, Violin and Cello, TWV 53:A2: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1b09dd72-418f-45bd-b127-e81eb365b625'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b7de73-02d8-49e5-ad8a-2ac8fa954ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '트리오 E♭장조 (1부)', part.name_en = 'Trio in E-flat major, TWV 42:Es1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198', 4, NULL, '트리오 E♭장조 (1부)', 'Trio in E-flat major, TWV 42:Es1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Affetuoso', part.name_en = 'Trio in E-flat major, TWV 42:Es1: I. Affetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:73ca1d58-ca41-40d3-849e-7be880d170c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73ca1d58-ca41-40d3-849e-7be880d170c0', 1, 'I', 'Affetuoso', 'Trio in E-flat major, TWV 42:Es1: I. Affetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ca1d58-ca41-40d3-849e-7be880d170c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Trio in E-flat major, TWV 42:Es1: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:21df9071-c421-4fe5-a66f-96f6782d467a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21df9071-c421-4fe5-a66f-96f6782d467a', 2, 'II', 'Vivace', 'Trio in E-flat major, TWV 42:Es1: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21df9071-c421-4fe5-a66f-96f6782d467a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grave', part.name_en = 'Trio in E-flat major, TWV 42:Es1: III. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:9f84d282-fe17-4eef-87f3-7a2a3258d9b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f84d282-fe17-4eef-87f3-7a2a3258d9b3', 3, 'III', 'Grave', 'Trio in E-flat major, TWV 42:Es1: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f84d282-fe17-4eef-87f3-7a2a3258d9b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Trio in E-flat major, TWV 42:Es1: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6178c0c4-b1af-49ff-955b-2890873c44c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6178c0c4-b1af-49ff-955b-2890873c44c9', 4, 'IV', 'Allegro', 'Trio in E-flat major, TWV 42:Es1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:392cb65f-9adf-40c0-bc3a-6d3914d8a198'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6178c0c4-b1af-49ff-955b-2890873c44c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '플루트 소나타 B단조 (1부)', part.name_en = 'Flute Sonata in B minor, TWV 41:h4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5', 5, NULL, '플루트 소나타 B단조 (1부)', 'Flute Sonata in B minor, TWV 41:h4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cantabile', part.name_en = 'Flute Sonata in B minor, TWV 41:h4: I. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:111e642f-a421-472f-a385-ea5e73fd3f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:111e642f-a421-472f-a385-ea5e73fd3f53', 1, 'I', 'Cantabile', 'Flute Sonata in B minor, TWV 41:h4: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111e642f-a421-472f-a385-ea5e73fd3f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Flute Sonata in B minor, TWV 41:h4: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6d4e98f7-42a2-48cf-90ee-348ad7f5bc9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d4e98f7-42a2-48cf-90ee-348ad7f5bc9e', 2, 'II', 'Allegro', 'Flute Sonata in B minor, TWV 41:h4: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d4e98f7-42a2-48cf-90ee-348ad7f5bc9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dolce', part.name_en = 'Flute Sonata in B minor, TWV 41:h4: III. Dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:3ea19fd1-4509-4ce7-90a2-e36e478cd191' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ea19fd1-4509-4ce7-90a2-e36e478cd191', 3, 'III', 'Dolce', 'Flute Sonata in B minor, TWV 41:h4: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea19fd1-4509-4ce7-90a2-e36e478cd191'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Flute Sonata in B minor, TWV 41:h4: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:fa4e8c11-6a20-4bff-8478-ad8db5a9903a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa4e8c11-6a20-4bff-8478-ad8db5a9903a', 4, 'IV', 'Allegro', 'Flute Sonata in B minor, TWV 41:h4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76d0c28a-32fd-4501-825e-de49cc39e6d5'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa4e8c11-6a20-4bff-8478-ad8db5a9903a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '결말 E단조 (1부)', part.name_en = 'Conclusion in E minor, TWV 50:5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:8b00b026-2671-4cb9-a099-66ceca2d76f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b00b026-2671-4cb9-a099-66ceca2d76f3', 6, NULL, '결말 E단조 (1부)', 'Conclusion in E minor, TWV 50:5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b00b026-2671-4cb9-a099-66ceca2d76f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '서곡 D장조 (2부)', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6', 7, NULL, '서곡 D장조 (2부)', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouvertüre. Lentement, vite', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Ouvertüre. Lentement, vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bc55b870-f824-4d88-9f41-58835604691c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc55b870-f824-4d88-9f41-58835604691c', 1, 'I', 'Ouvertüre. Lentement, vite', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Ouvertüre. Lentement, vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc55b870-f824-4d88-9f41-58835604691c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air. Tempo giusto', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:fe301184-53e1-4916-a022-6069da9a214d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe301184-53e1-4916-a022-6069da9a214d', 2, 'II', 'Air. Tempo giusto', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe301184-53e1-4916-a022-6069da9a214d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Air. Vivace', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:4ae30005-ade1-4926-a720-925cf8e8c3a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae30005-ade1-4926-a720-925cf8e8c3a9', 3, 'III', 'Air. Vivace', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae30005-ade1-4926-a720-925cf8e8c3a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air. Presto', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:2597bdff-5538-4d70-86a4-c16bf35ea256' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2597bdff-5538-4d70-86a4-c16bf35ea256', 4, 'IV', 'Air. Presto', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2597bdff-5538-4d70-86a4-c16bf35ea256'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Air. Allegro', part.name_en = 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6dd29d0b-80fd-4b21-aa83-4e1a280f163a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6dd29d0b-80fd-4b21-aa83-4e1a280f163a', 5, 'V', 'Air. Allegro', 'Suite Nr. 3 in D-Dur "Tafelmusik", TWV 55:D1: Air. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18d3248b-08f0-40c9-ad93-3364743ad3b6'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dd29d0b-80fd-4b21-aa83-4e1a280f163a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '4중주 D단조 (2부)', part.name_en = 'Quartet in D minor, TWV 43:d1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259', 8, NULL, '4중주 D단조 (2부)', 'Quartet in D minor, TWV 43:d1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Quartet in D minor, TWV 43:d1: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7bb92b10-1414-449c-8c8e-23fc86f0d9a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bb92b10-1414-449c-8c8e-23fc86f0d9a1', 1, 'I', 'Andante', 'Quartet in D minor, TWV 43:d1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bb92b10-1414-449c-8c8e-23fc86f0d9a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Quartet in D minor, TWV 43:d1: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:aabb07ea-a6e9-491d-80e8-317ed448d5e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aabb07ea-a6e9-491d-80e8-317ed448d5e2', 2, 'II', 'Vivace', 'Quartet in D minor, TWV 43:d1: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aabb07ea-a6e9-491d-80e8-317ed448d5e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'Quartet in D minor, TWV 43:d1: III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:15094964-8053-4dff-9e41-300fbb26e910' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15094964-8053-4dff-9e41-300fbb26e910', 3, 'III', 'Largo', 'Quartet in D minor, TWV 43:d1: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15094964-8053-4dff-9e41-300fbb26e910'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Quartet in D minor, TWV 43:d1: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:777ed0ed-6beb-4217-a120-a8a19f7a14c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:777ed0ed-6beb-4217-a120-a8a19f7a14c7', 4, 'IV', 'Allegro', 'Quartet in D minor, TWV 43:d1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:756cc368-b9c7-460c-87ab-1406e51b2259'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:777ed0ed-6beb-4217-a120-a8a19f7a14c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '세 대의 바이올린을 위한 협주곡 F장조 (2부)', part.name_en = 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf', 9, NULL, '세 대의 바이올린을 위한 협주곡 F장조 (2부)', 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:5629b9c5-93e8-41a3-98e9-9777ba3d3534' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5629b9c5-93e8-41a3-98e9-9777ba3d3534', 1, 'I', 'Allegro', 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5629b9c5-93e8-41a3-98e9-9777ba3d3534'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:35cb6ff5-9808-4ff7-b051-dcc20fc6cc90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35cb6ff5-9808-4ff7-b051-dcc20fc6cc90', 2, 'II', 'Largo', 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35cb6ff5-9808-4ff7-b051-dcc20fc6cc90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:e95440c5-1780-4a95-a56d-970a3f4c6f6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e95440c5-1780-4a95-a56d-970a3f4c6f6b', 3, 'III', 'Vivace', 'Concerto for 3 Violins, Strings and Continuo in F major, TWV 53:F1: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a369d561-6ff5-47bb-8bc2-4bc6edab7ccf'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e95440c5-1780-4a95-a56d-970a3f4c6f6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '트리오 E단조 (2부)', part.name_en = 'Trio Sonata in E minor, TWV 42:e2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77', 10, NULL, '트리오 E단조 (2부)', 'Trio Sonata in E minor, TWV 42:e2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Affettuoso', part.name_en = 'Trio Sonata in E minor, TWV 42:e2: I. Affettuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:dd991ac1-28b9-492e-965a-64758e868766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd991ac1-28b9-492e-965a-64758e868766', 1, 'I', 'Affettuoso', 'Trio Sonata in E minor, TWV 42:e2: I. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd991ac1-28b9-492e-965a-64758e868766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Trio Sonata in E minor, TWV 42:e2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:4f3612f1-8f9e-4d68-a9a9-0d34dc42f827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f3612f1-8f9e-4d68-a9a9-0d34dc42f827', 2, 'II', 'Allegro', 'Trio Sonata in E minor, TWV 42:e2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f3612f1-8f9e-4d68-a9a9-0d34dc42f827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dolce', part.name_en = 'Trio Sonata in E minor, TWV 42:e2: III. Dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:3671acec-9105-4966-a892-fb952751f464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3671acec-9105-4966-a892-fb952751f464', 3, 'III', 'Dolce', 'Trio Sonata in E minor, TWV 42:e2: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3671acec-9105-4966-a892-fb952751f464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Trio Sonata in E minor, TWV 42:e2: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bfe4b5f0-adea-42e6-ad56-3757bd47f7b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfe4b5f0-adea-42e6-ad56-3757bd47f7b1', 4, 'IV', 'Vivace', 'Trio Sonata in E minor, TWV 42:e2: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdda3b72-711f-4691-b00b-f975fce2dc77'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfe4b5f0-adea-42e6-ad56-3757bd47f7b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '바이올린 소나타 A장조 (2부)', part.name_en = 'Violin Sonata in A major, TWV 41:A4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279', 11, NULL, '바이올린 소나타 A장조 (2부)', 'Violin Sonata in A major, TWV 41:A4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Violin Sonata in A major, TWV 41:A4: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:9b826226-f071-4c24-a808-57647ce5b591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b826226-f071-4c24-a808-57647ce5b591', 1, 'I', 'Andante', 'Violin Sonata in A major, TWV 41:A4: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b826226-f071-4c24-a808-57647ce5b591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Violin Sonata in A major, TWV 41:A4: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:57cdbc76-7778-443b-b68d-e57e5c4de621' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57cdbc76-7778-443b-b68d-e57e5c4de621', 2, 'II', 'Vivace', 'Violin Sonata in A major, TWV 41:A4: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57cdbc76-7778-443b-b68d-e57e5c4de621'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cantabile', part.name_en = 'Violin Sonata in A major, TWV 41:A4: III. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:897552bf-a6c4-4e8c-b72b-fece0385c30d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:897552bf-a6c4-4e8c-b72b-fece0385c30d', 3, 'III', 'Cantabile', 'Violin Sonata in A major, TWV 41:A4: III. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897552bf-a6c4-4e8c-b72b-fece0385c30d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro - Adagio - Allegro - Adagio', part.name_en = 'Violin Sonata in A major, TWV 41:A4: IV. Allegro - Adagio - Allegro - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d7cb1816-8eb9-4cdc-b402-8323ed12cb61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7cb1816-8eb9-4cdc-b402-8323ed12cb61', 4, 'IV', 'Allegro - Adagio - Allegro - Adagio', 'Violin Sonata in A major, TWV 41:A4: IV. Allegro - Adagio - Allegro - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c28d7a-3384-48ad-9709-ab876650f279'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cb1816-8eb9-4cdc-b402-8323ed12cb61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '결말 D장조 (2부)', part.name_en = 'Conclusion in D major, TWV 50:9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a5e6a766-4b68-45ea-8736-bd9e0b0003fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e6a766-4b68-45ea-8736-bd9e0b0003fd', 12, NULL, '결말 D장조 (2부)', 'Conclusion in D major, TWV 50:9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e6a766-4b68-45ea-8736-bd9e0b0003fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '서곡 B♭장조 (3부)', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3', 13, NULL, '서곡 B♭장조 (3부)', 'Ouverture-Suite in B-flat major, TWV 55:B1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture: Lentement - Presto - Lentement', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: I. Ouverture: Lentement - Presto - Lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d1f0fdea-8ec4-4f2f-910f-ddf78837ca57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1f0fdea-8ec4-4f2f-910f-ddf78837ca57', 1, 'I', 'Ouverture: Lentement - Presto - Lentement', 'Ouverture-Suite in B-flat major, TWV 55:B1: I. Ouverture: Lentement - Presto - Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f0fdea-8ec4-4f2f-910f-ddf78837ca57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bergerie. Un peu vivement', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: II. Bergerie. Un peu vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6b0b86c0-f5e5-41d4-9694-25052be9acda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b0b86c0-f5e5-41d4-9694-25052be9acda', 2, 'II', 'Bergerie. Un peu vivement', 'Ouverture-Suite in B-flat major, TWV 55:B1: II. Bergerie. Un peu vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b0b86c0-f5e5-41d4-9694-25052be9acda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allégresse. Vite - Meno mosso - Vite D.c.', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: III. Allégresse. Vite - Meno mosso - Vite D.c.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bdacbc69-5a01-4caf-b483-3c10d0245739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bdacbc69-5a01-4caf-b483-3c10d0245739', 3, 'III', 'Allégresse. Vite - Meno mosso - Vite D.c.', 'Ouverture-Suite in B-flat major, TWV 55:B1: III. Allégresse. Vite - Meno mosso - Vite D.c.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdacbc69-5a01-4caf-b483-3c10d0245739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Postillons', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: IV. Postillons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:5c696877-0cc4-4daa-95ca-79ab84ee008c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c696877-0cc4-4daa-95ca-79ab84ee008c', 4, 'IV', 'Postillons', 'Ouverture-Suite in B-flat major, TWV 55:B1: IV. Postillons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c696877-0cc4-4daa-95ca-79ab84ee008c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Flaterie', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: V. Flaterie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1c9bd3ca-9d71-4f1d-b971-1ccac646b1a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c9bd3ca-9d71-4f1d-b971-1ccac646b1a8', 5, 'V', 'Flaterie', 'Ouverture-Suite in B-flat major, TWV 55:B1: V. Flaterie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c9bd3ca-9d71-4f1d-b971-1ccac646b1a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Badinage. Très vite', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: VI. Badinage. Très vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:571beb78-e78d-4781-be01-042216023a1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:571beb78-e78d-4781-be01-042216023a1f', 6, 'VI', 'Badinage. Très vite', 'Ouverture-Suite in B-flat major, TWV 55:B1: VI. Badinage. Très vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571beb78-e78d-4781-be01-042216023a1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Menuet', part.name_en = 'Ouverture-Suite in B-flat major, TWV 55:B1: VII. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7944a4d1-f8ec-42ad-94fe-0416b5fd2c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7944a4d1-f8ec-42ad-94fe-0416b5fd2c82', 7, 'VII', 'Menuet', 'Ouverture-Suite in B-flat major, TWV 55:B1: VII. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7944a4d1-f8ec-42ad-94fe-0416b5fd2c82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Conclusion. Furioso', part.name_en = 'Ouverture-Suite B-Dur, TWV 55:B1: VIII. Conclusion. Furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:99883112-057b-453e-88bd-e276148c949f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99883112-057b-453e-88bd-e276148c949f', 8, 'VIII', 'Conclusion. Furioso', 'Ouverture-Suite B-Dur, TWV 55:B1: VIII. Conclusion. Furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0131d32-bd38-4461-82ae-ae86a18b7be3'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99883112-057b-453e-88bd-e276148c949f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '4중주 E단조 (3부)', part.name_en = 'Sonata à 4 in E minor, TWV 43:e2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd', 14, NULL, '4중주 E단조 (3부)', 'Sonata à 4 in E minor, TWV 43:e2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata à 4 in E minor, TWV 43:e2: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:007c23f0-d146-4aa6-b586-fd2237c44dff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:007c23f0-d146-4aa6-b586-fd2237c44dff', 1, 'I', 'Adagio', 'Sonata à 4 in E minor, TWV 43:e2: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:007c23f0-d146-4aa6-b586-fd2237c44dff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Sonata à 4 in E minor, TWV 43:e2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f2d80c35-9e49-407b-9cad-091e7723c629' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2d80c35-9e49-407b-9cad-091e7723c629', 2, 'II', 'Allegro', 'Sonata à 4 in E minor, TWV 43:e2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d80c35-9e49-407b-9cad-091e7723c629'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dolce', part.name_en = 'Sonata à 4 in E minor, TWV 43:e2: III. Dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7edfef0b-4e80-4ea2-b752-c99dfbab620b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7edfef0b-4e80-4ea2-b752-c99dfbab620b', 3, 'III', 'Dolce', 'Sonata à 4 in E minor, TWV 43:e2: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7edfef0b-4e80-4ea2-b752-c99dfbab620b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Sonata à 4 in E minor, TWV 43:e2: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:94afa5be-0349-4de6-ab87-eb864159deeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94afa5be-0349-4de6-ab87-eb864159deeb', 4, 'IV', 'Allegro', 'Sonata à 4 in E minor, TWV 43:e2: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d6ad9e3-89c1-4e11-bce5-dc7a981b22dd'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94afa5be-0349-4de6-ab87-eb864159deeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '두 대의 호른을 위한 협주곡 E♭장조 (3부)', part.name_en = 'Concerto for 2 Horns in E-flat major, TWV 54:Es1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a', 15, NULL, '두 대의 호른을 위한 협주곡 E♭장조 (3부)', 'Concerto for 2 Horns in E-flat major, TWV 54:Es1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso', part.name_en = 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: I. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:57735afb-d3ca-4eee-a52d-c89a08cccb74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57735afb-d3ca-4eee-a52d-c89a08cccb74', 1, 'I', 'Maestoso', 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57735afb-d3ca-4eee-a52d-c89a08cccb74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f8aefbc2-9275-343a-a603-a2a555a8340e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8aefbc2-9275-343a-a603-a2a555a8340e', 2, 'II', 'Allegro', 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8aefbc2-9275-343a-a603-a2a555a8340e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grave', part.name_en = 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: III. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:75d8411b-4098-4eea-80ed-4b7a870172f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75d8411b-4098-4eea-80ed-4b7a870172f2', 3, 'III', 'Grave', 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75d8411b-4098-4eea-80ed-4b7a870172f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:95a2ccfd-52db-4dd5-835f-40e521dd31a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95a2ccfd-52db-4dd5-835f-40e521dd31a4', 4, 'IV', 'Vivace', 'Concerto for 2 Horns in E-flat major, TWV 54:Es1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae5ae48-b217-4201-80fe-eb80b90d363a'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95a2ccfd-52db-4dd5-835f-40e521dd31a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '트리오 D장조 (3부)', part.name_en = 'Trio Sonata in D major, TWV 42:D5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc', 16, NULL, '트리오 D장조 (3부)', 'Trio Sonata in D major, TWV 42:D5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Trio Sonata in D major, TWV 42:D5: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:34238ed1-f56d-47ec-9663-fcd55eebbff2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34238ed1-f56d-47ec-9663-fcd55eebbff2', 1, 'I', 'Andante', 'Trio Sonata in D major, TWV 42:D5: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34238ed1-f56d-47ec-9663-fcd55eebbff2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Trio Sonata in D major, TWV 42:D5: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:78fcaaec-d5ed-4797-8fc5-5c3a54ecde14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78fcaaec-d5ed-4797-8fc5-5c3a54ecde14', 2, 'II', 'Allegro', 'Trio Sonata in D major, TWV 42:D5: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78fcaaec-d5ed-4797-8fc5-5c3a54ecde14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grave - Largo - Grave', part.name_en = 'Trio Sonata in D major, TWV 42:D5: III. Grave - Largo - Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:da54ea5d-dca1-4c37-8da6-33339d1ad2e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da54ea5d-dca1-4c37-8da6-33339d1ad2e3', 3, 'III', 'Grave - Largo - Grave', 'Trio Sonata in D major, TWV 42:D5: III. Grave - Largo - Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da54ea5d-dca1-4c37-8da6-33339d1ad2e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Trio Sonata in D major, TWV 42:D5: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:edd43620-b54c-41e7-b3c0-3e5b3c8b214f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edd43620-b54c-41e7-b3c0-3e5b3c8b214f', 4, 'IV', 'Vivace', 'Trio Sonata in D major, TWV 42:D5: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24285591-843c-4bbe-866e-9dcbfd50eadc'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd43620-b54c-41e7-b3c0-3e5b3c8b214f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '오보에 소나타 G단조 (3부)', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4', 17, NULL, '오보에 소나타 G단조 (3부)', 'Oboe Sonata in G minor, TWV 41:g6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:8f8b43ad-e7df-4998-9cd0-30ef3fb19605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f8b43ad-e7df-4998-9cd0-30ef3fb19605', 1, 'I', 'Largo', 'Oboe Sonata in G minor, TWV 41:g6: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f8b43ad-e7df-4998-9cd0-30ef3fb19605'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6: II. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:69e844f8-6423-45cd-97a3-693ebd6c138e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69e844f8-6423-45cd-97a3-693ebd6c138e', 2, 'II', 'Presto', 'Oboe Sonata in G minor, TWV 41:g6: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e844f8-6423-45cd-97a3-693ebd6c138e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo giusto', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6: III. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:c5359ff8-6615-4efc-be34-3d9353c09fdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5359ff8-6615-4efc-be34-3d9353c09fdc', 3, 'III', 'Tempo giusto', 'Oboe Sonata in G minor, TWV 41:g6: III. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5359ff8-6615-4efc-be34-3d9353c09fdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f9ec06da-433d-4d82-a4bb-33ebd00012d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9ec06da-433d-4d82-a4bb-33ebd00012d4', 4, 'IV', 'Andante', 'Oboe Sonata in G minor, TWV 41:g6: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ec06da-433d-4d82-a4bb-33ebd00012d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro', part.name_en = 'Oboe Sonata in G minor, TWV 41:g6: V. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f93d9eb6-6332-4b19-801f-5a3be92369a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f93d9eb6-6332-4b19-801f-5a3be92369a7', 5, 'V', 'Allegro', 'Oboe Sonata in G minor, TWV 41:g6: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93050754-8597-4226-b72a-1e91daae4cb4'
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93d9eb6-6332-4b19-801f-5a3be92369a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '결말 B♭장조 (3부)', part.name_en = 'Conclusion in B flat major, TWV 50:10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 52 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7223cebc-44d4-4809-92cb-5e477bb39f8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7223cebc-44d4-4809-92cb-5e477bb39f8f', 18, NULL, '결말 B♭장조 (3부)', 'Conclusion in B flat major, TWV 50:10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 52 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7223cebc-44d4-4809-92cb-5e477bb39f8f'
);


-- TWV 51:G9 비올라 협주곡 G장조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50cb3abf-87eb-496b-aee4-d3986f989d2f'
FROM pieces p
WHERE p.id = 53 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50cb3abf-87eb-496b-aee4-d3986f989d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Viola Concerto, TWV 51:G9: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 53 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cc931980-5c44-493f-b495-2f5c720b8acf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc931980-5c44-493f-b495-2f5c720b8acf', 1, 'I', 'Largo', 'Viola Concerto, TWV 51:G9: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 53 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc931980-5c44-493f-b495-2f5c720b8acf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Viola Concerto, TWV 51:G9: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 53 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f69d1ff4-4e92-4f43-8555-2f64eda55d75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f69d1ff4-4e92-4f43-8555-2f64eda55d75', 2, 'II', 'Allegro', 'Viola Concerto, TWV 51:G9: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 53 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69d1ff4-4e92-4f43-8555-2f64eda55d75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Viola Concerto, TWV 51:G9: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 53 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6cb65b93-9042-431e-889f-f6a0cfca076f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb65b93-9042-431e-889f-f6a0cfca076f', 3, 'III', 'Andante', 'Viola Concerto, TWV 51:G9: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 53 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb65b93-9042-431e-889f-f6a0cfca076f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Viola Concerto, TWV 51:G9: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 53 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:59b1d789-55ce-4376-bca1-bdb7a31c3c33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59b1d789-55ce-4376-bca1-bdb7a31c3c33', 4, 'IV', 'Presto', 'Viola Concerto, TWV 51:G9: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 53 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59b1d789-55ce-4376-bca1-bdb7a31c3c33'
);


-- TWV 55:a2 리코더와 현을 위한 모음곡 A단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '569af4af-9c2e-437b-9678-7bb7e0e6c5ff'
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '569af4af-9c2e-437b-9678-7bb7e0e6c5ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Ouverture-Suite, TWV 55:a2: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cfa67bdd-751d-4af6-b4f7-126751ccef29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfa67bdd-751d-4af6-b4f7-126751ccef29', 1, 'I', 'Overture', 'Ouverture-Suite, TWV 55:a2: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa67bdd-751d-4af6-b4f7-126751ccef29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Les Plaisirs', part.name_en = 'Ouverture-Suite, TWV 55:a2: II. Les Plaisirs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:ab199374-1513-4b31-8b24-b44513aab7ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab199374-1513-4b31-8b24-b44513aab7ef', 2, 'II', 'Les Plaisirs', 'Ouverture-Suite, TWV 55:a2: II. Les Plaisirs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab199374-1513-4b31-8b24-b44513aab7ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Air à l''italien', part.name_en = 'Ouverture-Suite, TWV 55:a2: III. Air à l''italien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:0fcb4010-6521-4848-bf37-a1af2c41ac56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcb4010-6521-4848-bf37-a1af2c41ac56', 3, 'III', 'Air à l''italien', 'Ouverture-Suite, TWV 55:a2: III. Air à l''italien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcb4010-6521-4848-bf37-a1af2c41ac56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Menuet I and II', part.name_en = 'Ouverture-Suite, TWV 55:a2: IV. Menuet I and II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:ea9e2ba0-b90a-4e2a-9c4d-d18803adba8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea9e2ba0-b90a-4e2a-9c4d-d18803adba8a', 4, 'IV', 'Menuet I and II', 'Ouverture-Suite, TWV 55:a2: IV. Menuet I and II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea9e2ba0-b90a-4e2a-9c4d-d18803adba8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Réjouissance', part.name_en = 'Ouverture-Suite, TWV 55:a2: V. Réjouissance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:841348a3-6c63-40a6-ad99-f92b6efa7529' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:841348a3-6c63-40a6-ad99-f92b6efa7529', 5, 'V', 'Réjouissance', 'Ouverture-Suite, TWV 55:a2: V. Réjouissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841348a3-6c63-40a6-ad99-f92b6efa7529'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Passepied I and II', part.name_en = 'Ouverture-Suite, TWV 55:a2: VI. Passepied I and II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:79dee6fa-cd23-44a8-b42c-ef95a4fd8da8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79dee6fa-cd23-44a8-b42c-ef95a4fd8da8', 6, 'VI', 'Passepied I and II', 'Ouverture-Suite, TWV 55:a2: VI. Passepied I and II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79dee6fa-cd23-44a8-b42c-ef95a4fd8da8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Polonaise', part.name_en = 'Ouverture-Suite, TWV 55:a2: VII. Polonaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 54 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:868acfef-52d8-45b4-b92b-bb6774412fd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:868acfef-52d8-45b4-b92b-bb6774412fd3', 7, 'VII', 'Polonaise', 'Ouverture-Suite, TWV 55:a2: VII. Polonaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 54 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:868acfef-52d8-45b4-b92b-bb6774412fd3'
);


-- TWV 55:G10 돈키호테 풍자극

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b00b63ef-554c-491b-8a29-47c47ef09e38'
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b00b63ef-554c-491b-8a29-47c47ef09e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:98d68550-1e35-478f-893b-c59d08def83d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d68550-1e35-478f-893b-c59d08def83d', 1, 'I', 'Ouverture', 'Burlesque de Don Quixotte, TWV 55G10: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d68550-1e35-478f-893b-c59d08def83d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Awakening of Quixote', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: II. The Awakening of Quixote',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:0edecd6a-6ded-4110-b995-19845362214a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0edecd6a-6ded-4110-b995-19845362214a', 2, 'II', 'The Awakening of Quixote', 'Burlesque de Don Quixotte, TWV 55G10: II. The Awakening of Quixote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0edecd6a-6ded-4110-b995-19845362214a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'His Attack on the Windmills', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: III. His Attack on the Windmills',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:e1cab18d-04ed-4ae5-83ba-4be9a29f4514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1cab18d-04ed-4ae5-83ba-4be9a29f4514', 3, 'III', 'His Attack on the Windmills', 'Burlesque de Don Quixotte, TWV 55G10: III. His Attack on the Windmills', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1cab18d-04ed-4ae5-83ba-4be9a29f4514'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sighs of Love for the Princess Dulcinea', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: IV. Sighs of Love for the Princess Dulcinea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:3b7daea9-6828-4ff8-84d8-6bc7d5b6d120' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b7daea9-6828-4ff8-84d8-6bc7d5b6d120', 4, 'IV', 'Sighs of Love for the Princess Dulcinea', 'Burlesque de Don Quixotte, TWV 55G10: IV. Sighs of Love for the Princess Dulcinea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7daea9-6828-4ff8-84d8-6bc7d5b6d120'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sancho Panza tossed in a Blanket', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: V. Sancho Panza tossed in a Blanket',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:54b870d5-024c-419d-baa3-3b8c8258caa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54b870d5-024c-419d-baa3-3b8c8258caa2', 5, 'V', 'Sancho Panza tossed in a Blanket', 'Burlesque de Don Quixotte, TWV 55G10: V. Sancho Panza tossed in a Blanket', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54b870d5-024c-419d-baa3-3b8c8258caa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Gallop of Rosinante / The Gallop of Sancho''s Donkey', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: VI. The Gallop of Rosinante / The Gallop of Sancho''s Donkey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7d19a64d-7be7-48e9-91b4-5445b870b2a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d19a64d-7be7-48e9-91b4-5445b870b2a0', 6, 'VI', 'The Gallop of Rosinante / The Gallop of Sancho''s Donkey', 'Burlesque de Don Quixotte, TWV 55G10: VI. The Gallop of Rosinante / The Gallop of Sancho''s Donkey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d19a64d-7be7-48e9-91b4-5445b870b2a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Quixote Asleep', part.name_en = 'Burlesque de Don Quixotte, TWV 55G10: VII. Quixote Asleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 55 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7806a45e-1c7e-4461-b991-ca1082488093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7806a45e-1c7e-4461-b991-ca1082488093', 7, 'VII', 'Quixote Asleep', 'Burlesque de Don Quixotte, TWV 55G10: VII. Quixote Asleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 55 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7806a45e-1c7e-4461-b991-ca1082488093'
);


-- TWV 43 파리 4중주

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '협주곡 1번 G장조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c', 1, NULL, '협주곡 1번 G장조 (콰드리)', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Grave - Allegro - Grave', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: I. Grave - Allegro - Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f1ba2bb7-efab-45da-a1b2-4ed437da93e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1ba2bb7-efab-45da-a1b2-4ed437da93e5', 1, 'I', 'Grave - Allegro - Grave', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: I. Grave - Allegro - Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ba2bb7-efab-45da-a1b2-4ed437da93e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:5982d0c1-464d-4bbf-82f5-50b42110b9c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5982d0c1-464d-4bbf-82f5-50b42110b9c6', 2, 'II', 'Largo', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5982d0c1-464d-4bbf-82f5-50b42110b9c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:12097aaa-dad8-44e1-b710-1043e0da725f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12097aaa-dad8-44e1-b710-1043e0da725f', 3, 'III', 'Presto', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12097aaa-dad8-44e1-b710-1043e0da725f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: IV. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:3d3d747a-03ab-45b2-9cf4-6b80a0a3f1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d3d747a-03ab-45b2-9cf4-6b80a0a3f1b6', 4, 'IV', 'Largo', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d3d747a-03ab-45b2-9cf4-6b80a0a3f1b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro', part.name_en = '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: V. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:01d39a16-e53d-42f4-89ce-5a63dcac174b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01d39a16-e53d-42f4-89ce-5a63dcac174b', 5, 'V', 'Allegro', '6 Quadri "Paris Quartets", Concerto 1 in G major, TWV 43:G1: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1dccd1a6-df05-4c6e-820e-55c283a4b49c'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01d39a16-e53d-42f4-89ce-5a63dcac174b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '협주곡 2번 D장조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2', 2, NULL, '협주곡 2번 D장조 (콰드리)', '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:c7bef3fc-4657-450c-85d1-bcfaa8d06278' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7bef3fc-4657-450c-85d1-bcfaa8d06278', 1, 'I', 'Allegro', '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7bef3fc-4657-450c-85d1-bcfaa8d06278'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Affettuoso', part.name_en = '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: II. Affettuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:685b7900-5555-4969-907e-9fef28598398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:685b7900-5555-4969-907e-9fef28598398', 2, 'II', 'Affettuoso', '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: II. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:685b7900-5555-4969-907e-9fef28598398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a40fb9c6-f2da-4812-bd6a-3f2b4227cca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a40fb9c6-f2da-4812-bd6a-3f2b4227cca8', 3, 'III', 'Vivace', '6 Quadri "Paris Quartets", Concerto 2 in D major, TWV 43:D1: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0f0c052-0583-4be8-b261-22a4d6c1a8e2'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a40fb9c6-f2da-4812-bd6a-3f2b4227cca8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '소나타 1번 A장조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618', 3, NULL, '소나타 1번 A장조 (콰드리)', '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Soave', part.name_en = '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: I. Soave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a4354e10-a7bc-46f3-bcad-b665bc833e43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4354e10-a7bc-46f3-bcad-b665bc833e43', 1, 'I', 'Soave', '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: I. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4354e10-a7bc-46f3-bcad-b665bc833e43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:e0458c6e-fd8d-4f5b-9e4d-c506b66fac88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0458c6e-fd8d-4f5b-9e4d-c506b66fac88', 2, 'II', 'Allegro', '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0458c6e-fd8d-4f5b-9e4d-c506b66fac88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cf3c511e-220d-41c9-a33d-334021115746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf3c511e-220d-41c9-a33d-334021115746', 3, 'III', 'Andante', '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf3c511e-220d-41c9-a33d-334021115746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:de3c799c-fbad-4007-8488-f946025530f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de3c799c-fbad-4007-8488-f946025530f0', 4, 'IV', 'Vivace', '6 Quadri "Paris Quartets", Sonata 1 in A major, TWV 43:A1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:01502e2d-f5de-4703-9a0d-92e13430f618'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3c799c-fbad-4007-8488-f946025530f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '소나타 2번 G단조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616', 4, NULL, '소나타 2번 G단조 (콰드리)', '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:f7f66393-f5b8-4963-8cb2-10c625c6d53f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7f66393-f5b8-4963-8cb2-10c625c6d53f', 1, 'I', 'Andante', '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f66393-f5b8-4963-8cb2-10c625c6d53f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:033f6f58-2f17-414b-9ed1-a1b5af3bf411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:033f6f58-2f17-414b-9ed1-a1b5af3bf411', 2, 'II', 'Allegro', '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033f6f58-2f17-414b-9ed1-a1b5af3bf411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:89a846d4-10cd-4309-8af6-8dc1a420b736' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89a846d4-10cd-4309-8af6-8dc1a420b736', 3, 'III', 'Largo', '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a846d4-10cd-4309-8af6-8dc1a420b736'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:ba078a0b-50b4-4567-9570-56aa74bb73de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba078a0b-50b4-4567-9570-56aa74bb73de', 4, 'IV', 'Allegro', '6 Quadri "Paris Quartets", Sonata 2 in G minor, TWV 43:g1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cf37f6-d123-463f-a2a0-c469fbbb0616'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba078a0b-50b4-4567-9570-56aa74bb73de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '모음곡 1번 E단조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4', 5, NULL, '모음곡 1번 E단조 (콰드리)', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude. Vivement', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: I. Prélude. Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d9b0982d-1a90-42b5-82a3-5319c164a66e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9b0982d-1a90-42b5-82a3-5319c164a66e', 1, 'I', 'Prélude. Vivement', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: I. Prélude. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b0982d-1a90-42b5-82a3-5319c164a66e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rigaudon', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: II. Rigaudon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cfd712b8-b08a-428d-8f20-6f4180e06fe3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfd712b8-b08a-428d-8f20-6f4180e06fe3', 2, 'II', 'Rigaudon', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: II. Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd712b8-b08a-428d-8f20-6f4180e06fe3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Air', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: III. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6b3ea745-0b87-4e2d-9b09-b548fbf0b42c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b3ea745-0b87-4e2d-9b09-b548fbf0b42c', 3, 'III', 'Air', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: III. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3ea745-0b87-4e2d-9b09-b548fbf0b42c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Replique', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: IV. Replique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:79d12c81-5c05-403c-ae3c-360c7a22b0da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79d12c81-5c05-403c-ae3c-360c7a22b0da', 4, 'IV', 'Replique', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: IV. Replique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d12c81-5c05-403c-ae3c-360c7a22b0da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Menuet I & II', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: V. Menuet I & II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:09f67eeb-9ae9-43f3-9165-ff446cf5e7c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09f67eeb-9ae9-43f3-9165-ff446cf5e7c6', 5, 'V', 'Menuet I & II', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: V. Menuet I & II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f67eeb-9ae9-43f3-9165-ff446cf5e7c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gigue', part.name_en = '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: VI. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cee5e159-b47b-45fa-a49e-7d20aed4076e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cee5e159-b47b-45fa-a49e-7d20aed4076e', 6, 'VI', 'Gigue', '6 Quadri "Paris Quartets", Suite 1 in E minor, TWV 43:e1: VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d025cdd5-78dc-41ed-bab5-de78740c2cc4'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee5e159-b47b-45fa-a49e-7d20aed4076e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '모음곡 2번 B단조 (콰드리)', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d', 6, NULL, '모음곡 2번 B단조 (콰드리)', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude. Gaiement', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: I. Prélude. Gaiement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:53ffcf85-6482-40fe-9c6b-bdd58eca81cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53ffcf85-6482-40fe-9c6b-bdd58eca81cc', 1, 'I', 'Prélude. Gaiement', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: I. Prélude. Gaiement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53ffcf85-6482-40fe-9c6b-bdd58eca81cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air Modérément', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: II. Air Modérément',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:33ba2939-9a5e-47c5-a992-2ab656c0ae06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33ba2939-9a5e-47c5-a992-2ab656c0ae06', 2, 'II', 'Air Modérément', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: II. Air Modérément', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ba2939-9a5e-47c5-a992-2ab656c0ae06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Réjouissance', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: III. Réjouissance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:ad6d565d-5353-4b49-8dd9-b65e93fbdcb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad6d565d-5353-4b49-8dd9-b65e93fbdcb7', 3, 'III', 'Réjouissance', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: III. Réjouissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad6d565d-5353-4b49-8dd9-b65e93fbdcb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Courante', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: IV. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1af4f82f-f400-4c11-b5e4-8a5c8676d53a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1af4f82f-f400-4c11-b5e4-8a5c8676d53a', 4, 'IV', 'Courante', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: IV. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1af4f82f-f400-4c11-b5e4-8a5c8676d53a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Passepied', part.name_en = '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: V. Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d2db9ff1-4c6a-431e-a6cd-e55f63da8956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2db9ff1-4c6a-431e-a6cd-e55f63da8956', 5, 'V', 'Passepied', '6 Quadri "Paris Quartets", Suite 2 in B minor, TWV 43:h1: V. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9af30eb4-eb4f-4307-9d2c-d6d1a082f03d'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2db9ff1-4c6a-431e-a6cd-e55f63da8956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '4중주 1번 D장조 (새 4중주)', part.name_en = 'Quartet in D major, TWV 43:D3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048', 7, NULL, '4중주 1번 D장조 (새 4중주)', 'Quartet in D major, TWV 43:D3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prèlude. Vivement', part.name_en = 'Quartet in D major, TWV 43:D3: I. Prèlude. Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:3451d7e6-8fe9-45f1-9ae0-112dee9c0be6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3451d7e6-8fe9-45f1-9ae0-112dee9c0be6', 1, 'I', 'Prèlude. Vivement', 'Quartet in D major, TWV 43:D3: I. Prèlude. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3451d7e6-8fe9-45f1-9ae0-112dee9c0be6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tendrement', part.name_en = 'Quartet in D major, TWV 43:D3: II. Tendrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:80662272-19ef-4f4c-b6c1-a15720b82fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80662272-19ef-4f4c-b6c1-a15720b82fb6', 2, 'II', 'Tendrement', 'Quartet in D major, TWV 43:D3: II. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80662272-19ef-4f4c-b6c1-a15720b82fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vite', part.name_en = 'Quartet in D major, TWV 43:D3: III. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:b2759ebc-294b-42b3-b5ea-23f0749f28a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2759ebc-294b-42b3-b5ea-23f0749f28a9', 3, 'III', 'Vite', 'Quartet in D major, TWV 43:D3: III. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2759ebc-294b-42b3-b5ea-23f0749f28a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gaiement', part.name_en = 'Quartet in D major, TWV 43:D3: IV. Gaiement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:c39abe97-cd4e-47ba-9bfd-3a98a72f6e93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c39abe97-cd4e-47ba-9bfd-3a98a72f6e93', 4, 'IV', 'Gaiement', 'Quartet in D major, TWV 43:D3: IV. Gaiement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c39abe97-cd4e-47ba-9bfd-3a98a72f6e93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Modérement', part.name_en = 'Quartet in D major, TWV 43:D3: V. Modérement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cc348438-42e6-4ebe-a2bf-cdf9827d037c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc348438-42e6-4ebe-a2bf-cdf9827d037c', 5, 'V', 'Modérement', 'Quartet in D major, TWV 43:D3: V. Modérement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc348438-42e6-4ebe-a2bf-cdf9827d037c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Vite', part.name_en = 'Quartet in D major, TWV 43:D3: VI. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:13c5ef58-4054-449c-a587-8bfa102880fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13c5ef58-4054-449c-a587-8bfa102880fd', 6, 'VI', 'Vite', 'Quartet in D major, TWV 43:D3: VI. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adceb012-33fb-45cf-b137-b4c6c2ef2048'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c5ef58-4054-449c-a587-8bfa102880fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '4중주 2번 A단조 (새 4중주)', part.name_en = 'Suite à 4, TWV 43:a2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658', 8, NULL, '4중주 2번 A단조 (새 4중주)', 'Suite à 4, TWV 43:a2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allègrement', part.name_en = 'Suite à 4, TWV 43:a2: I. Allègrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:402b06e5-e003-4015-9c9f-9b2a4cb3f6e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:402b06e5-e003-4015-9c9f-9b2a4cb3f6e1', 1, 'I', 'Allègrement', 'Suite à 4, TWV 43:a2: I. Allègrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:402b06e5-e003-4015-9c9f-9b2a4cb3f6e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Flatteusement', part.name_en = 'Suite à 4, TWV 43:a2: II. Flatteusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:a80ecb18-c997-439f-be9f-ee7705940151' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a80ecb18-c997-439f-be9f-ee7705940151', 2, 'II', 'Flatteusement', 'Suite à 4, TWV 43:a2: II. Flatteusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80ecb18-c997-439f-be9f-ee7705940151'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Légèrement', part.name_en = 'Suite à 4, TWV 43:a2: III. Légèrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6f4890fc-50b5-4123-8d8a-6b4def33bdf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f4890fc-50b5-4123-8d8a-6b4def33bdf9', 3, 'III', 'Légèrement', 'Suite à 4, TWV 43:a2: III. Légèrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f4890fc-50b5-4123-8d8a-6b4def33bdf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Un peu vivement', part.name_en = 'Suite à 4, TWV 43:a2: IV. Un peu vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:580ff26c-9093-46da-bdd1-905521754e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:580ff26c-9093-46da-bdd1-905521754e59', 4, 'IV', 'Un peu vivement', 'Suite à 4, TWV 43:a2: IV. Un peu vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:580ff26c-9093-46da-bdd1-905521754e59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vite', part.name_en = 'Suite à 4, TWV 43:a2: V. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:c87e83b8-1fe3-4104-b168-0f04e464b99b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c87e83b8-1fe3-4104-b168-0f04e464b99b', 5, 'V', 'Vite', 'Suite à 4, TWV 43:a2: V. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c87e83b8-1fe3-4104-b168-0f04e464b99b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Coulant', part.name_en = 'Suite à 4, TWV 43:a2: VI. Coulant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:31eb7bbe-5457-4903-aa3d-e2f55cfa3377' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31eb7bbe-5457-4903-aa3d-e2f55cfa3377', 6, 'VI', 'Coulant', 'Suite à 4, TWV 43:a2: VI. Coulant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6961abed-5671-4b8e-b7e2-1e13cba04658'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31eb7bbe-5457-4903-aa3d-e2f55cfa3377'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '4중주 3번 G장조 (새 4중주)', part.name_en = 'Concerto à 4, TWV 43:G4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310', 9, NULL, '4중주 3번 G장조 (새 4중주)', 'Concerto à 4, TWV 43:G4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Concerto à 4, TWV 43:G4: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:979fb4dc-94ba-416c-81be-a83639be2cdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:979fb4dc-94ba-416c-81be-a83639be2cdd', 1, 'I', 'Prélude', 'Concerto à 4, TWV 43:G4: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:979fb4dc-94ba-416c-81be-a83639be2cdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Légèrement', part.name_en = 'Concerto à 4, TWV 43:G4: II. Légèrement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:349a023a-b435-46c3-ab04-251d2ff3c688' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:349a023a-b435-46c3-ab04-251d2ff3c688', 2, 'II', 'Légèrement', 'Concerto à 4, TWV 43:G4: II. Légèrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349a023a-b435-46c3-ab04-251d2ff3c688'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gracieusement', part.name_en = 'Concerto à 4, TWV 43:G4: III. Gracieusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:c0a0cc0d-5508-491b-9a24-dbccb18d0cda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0a0cc0d-5508-491b-9a24-dbccb18d0cda', 3, 'III', 'Gracieusement', 'Concerto à 4, TWV 43:G4: III. Gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0a0cc0d-5508-491b-9a24-dbccb18d0cda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vite', part.name_en = 'Concerto à 4, TWV 43:G4: IV. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d915c2ac-963d-4947-8c9d-25079580d1ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d915c2ac-963d-4947-8c9d-25079580d1ab', 4, 'IV', 'Vite', 'Concerto à 4, TWV 43:G4: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d915c2ac-963d-4947-8c9d-25079580d1ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Modéré', part.name_en = 'Concerto à 4, TWV 43:G4: V. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:9710d90d-dfae-4103-b906-c61dd7c6d52a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9710d90d-dfae-4103-b906-c61dd7c6d52a', 5, 'V', 'Modéré', 'Concerto à 4, TWV 43:G4: V. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9710d90d-dfae-4103-b906-c61dd7c6d52a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gai', part.name_en = 'Concerto à 4, TWV 43:G4: VI. Gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:5996fc63-ea3e-4a21-ace7-17d8477ae7c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5996fc63-ea3e-4a21-ace7-17d8477ae7c5', 6, 'VI', 'Gai', 'Concerto à 4, TWV 43:G4: VI. Gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5996fc63-ea3e-4a21-ace7-17d8477ae7c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Lentement', part.name_en = 'Concerto à 4, TWV 43:G4: VII. Lentement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:368fa048-4700-418a-803d-30eb23e9c27f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:368fa048-4700-418a-803d-30eb23e9c27f', 7, 'VII', 'Lentement', 'Concerto à 4, TWV 43:G4: VII. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55a43a10-b2b4-49f2-8f9f-2ae365ff3310'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368fa048-4700-418a-803d-30eb23e9c27f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '4중주 4번 B단조 (새 4중주)', part.name_en = 'Concerto a 4, TWV 43:h2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab', 10, NULL, '4중주 4번 B단조 (새 4중주)', 'Concerto a 4, TWV 43:h2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Concerto a 4, TWV 43:h2: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1e06de81-8a34-44bf-ae3f-a6d0c41d0e17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e06de81-8a34-44bf-ae3f-a6d0c41d0e17', 1, 'I', 'Prélude', 'Concerto a 4, TWV 43:h2: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e06de81-8a34-44bf-ae3f-a6d0c41d0e17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Coulant', part.name_en = 'Concerto a 4, TWV 43:h2: II. Coulant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:1e760b70-7049-4408-a4c1-4d61e8cbea8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e760b70-7049-4408-a4c1-4d61e8cbea8f', 2, 'II', 'Coulant', 'Concerto a 4, TWV 43:h2: II. Coulant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e760b70-7049-4408-a4c1-4d61e8cbea8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gai', part.name_en = 'Concerto a 4, TWV 43:h2: III. Gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:8f5d0147-fb3d-4582-98a1-2f7ddfa897d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f5d0147-fb3d-4582-98a1-2f7ddfa897d0', 3, 'III', 'Gai', 'Concerto a 4, TWV 43:h2: III. Gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f5d0147-fb3d-4582-98a1-2f7ddfa897d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vite', part.name_en = 'Concerto a 4, TWV 43:h2: IV. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:7162d540-d4df-484a-b68d-ce4d53e8875f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7162d540-d4df-484a-b68d-ce4d53e8875f', 4, 'IV', 'Vite', 'Concerto a 4, TWV 43:h2: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7162d540-d4df-484a-b68d-ce4d53e8875f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Triste', part.name_en = 'Concerto a 4, TWV 43:h2: V. Triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:cd48fdd8-d137-496c-92bd-ae14c2e44eb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd48fdd8-d137-496c-92bd-ae14c2e44eb8', 5, 'V', 'Triste', 'Concerto a 4, TWV 43:h2: V. Triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd48fdd8-d137-496c-92bd-ae14c2e44eb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Menuet', part.name_en = 'Concerto a 4, TWV 43:h2: VI. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:b2c754b8-27fe-4ec8-ba67-b8ee32455389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2c754b8-27fe-4ec8-ba67-b8ee32455389', 6, 'VI', 'Menuet', 'Concerto a 4, TWV 43:h2: VI. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd58c809-95dd-4f44-a91e-59d455dfeaab'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2c754b8-27fe-4ec8-ba67-b8ee32455389'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '4중주 5번 A장조 (새 4중주)', part.name_en = 'Suite à 4, TWV 43:A3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207', 11, NULL, '4중주 5번 A장조 (새 4중주)', 'Suite à 4, TWV 43:A3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prèlude: Vivement', part.name_en = 'Suite à 4, TWV 43:A3: I. Prèlude: Vivement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:21428133-5b02-4898-b58a-b53d711624cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21428133-5b02-4898-b58a-b53d711624cf', 1, 'I', 'Prèlude: Vivement', 'Suite à 4, TWV 43:A3: I. Prèlude: Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21428133-5b02-4898-b58a-b53d711624cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gai', part.name_en = 'Suite à 4, TWV 43:A3: II. Gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6957ac60-e8f2-4269-a1e2-d302abfc26f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6957ac60-e8f2-4269-a1e2-d302abfc26f1', 2, 'II', 'Gai', 'Suite à 4, TWV 43:A3: II. Gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6957ac60-e8f2-4269-a1e2-d302abfc26f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Modéré', part.name_en = 'Suite à 4, TWV 43:A3: III. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:6b1b50b8-2764-4acb-bd7b-4693936d4694' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b1b50b8-2764-4acb-bd7b-4693936d4694', 3, 'III', 'Modéré', 'Suite à 4, TWV 43:A3: III. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b1b50b8-2764-4acb-bd7b-4693936d4694'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Modéré', part.name_en = 'Suite à 4, TWV 43:A3: IV. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:5db0ac70-df00-4580-a3e0-f6c7c372141c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5db0ac70-df00-4580-a3e0-f6c7c372141c', 4, 'IV', 'Modéré', 'Suite à 4, TWV 43:A3: IV. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5db0ac70-df00-4580-a3e0-f6c7c372141c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Pas vite', part.name_en = 'Suite à 4, TWV 43:A3: V. Pas vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bb014a80-d3de-4a7c-9915-c03c9061eb3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb014a80-d3de-4a7c-9915-c03c9061eb3a', 5, 'V', 'Pas vite', 'Suite à 4, TWV 43:A3: V. Pas vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb014a80-d3de-4a7c-9915-c03c9061eb3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Un peu Gay', part.name_en = 'Suite à 4, TWV 43:A3: VI. Un peu Gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:638e7d60-5745-417e-b309-15800a326514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:638e7d60-5745-417e-b309-15800a326514', 6, 'VI', 'Un peu Gay', 'Suite à 4, TWV 43:A3: VI. Un peu Gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d734c95d-044f-4f44-816f-d8db558cc207'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:638e7d60-5745-417e-b309-15800a326514'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '4중주 6번 E단조 (새 4중주)', part.name_en = 'Suite à 4, TWV 43:e4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba', 12, NULL, '4중주 6번 E단조 (새 4중주)', 'Suite à 4, TWV 43:e4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude. A discretion - tres Vîte - A discretion', part.name_en = 'Suite à 4, TWV 43:e4: I. Prélude. A discretion - tres Vîte - A discretion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:17525e6a-981e-4e34-8e8f-10e37aeeb5fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17525e6a-981e-4e34-8e8f-10e37aeeb5fe', 1, 'I', 'Prélude. A discretion - tres Vîte - A discretion', 'Suite à 4, TWV 43:e4: I. Prélude. A discretion - tres Vîte - A discretion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17525e6a-981e-4e34-8e8f-10e37aeeb5fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gay', part.name_en = 'Suite à 4, TWV 43:e4: II. Gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:4fafc092-61b1-42f3-8e42-aa6afef99fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fafc092-61b1-42f3-8e42-aa6afef99fc9', 2, 'II', 'Gay', 'Suite à 4, TWV 43:e4: II. Gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fafc092-61b1-42f3-8e42-aa6afef99fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vîte', part.name_en = 'Suite à 4, TWV 43:e4: III. Vîte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:29e60e84-4175-45a4-9562-3f6c46edd5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29e60e84-4175-45a4-9562-3f6c46edd5ce', 3, 'III', 'Vîte', 'Suite à 4, TWV 43:e4: III. Vîte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e60e84-4175-45a4-9562-3f6c46edd5ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gracieusement', part.name_en = 'Suite à 4, TWV 43:e4: IV. Gracieusement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:855b3478-3325-4dd1-bfc7-2723379fcc7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:855b3478-3325-4dd1-bfc7-2723379fcc7f', 4, 'IV', 'Gracieusement', 'Suite à 4, TWV 43:e4: IV. Gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:855b3478-3325-4dd1-bfc7-2723379fcc7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Distrait', part.name_en = 'Suite à 4, TWV 43:e4: V. Distrait',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:d0ae89a5-0497-4dda-b854-6b1364b34693' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0ae89a5-0497-4dda-b854-6b1364b34693', 5, 'V', 'Distrait', 'Suite à 4, TWV 43:e4: V. Distrait', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0ae89a5-0497-4dda-b854-6b1364b34693'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Modéré', part.name_en = 'Suite à 4, TWV 43:e4: VI. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 56 AND p.composer_id = 11 AND part.part_key = 'musicbrainz:41b82f68-2104-49d3-9cb1-511b96c120b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41b82f68-2104-49d3-9cb1-511b96c120b8', 6, 'VI', 'Modéré', 'Suite à 4, TWV 43:e4: VI. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf411a3d-4267-436f-a7b1-b29d72e335ba'
WHERE p.id = 56 AND p.composer_id = 11
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b82f68-2104-49d3-9cb1-511b96c120b8'
);


-- TWV 55:C3 관현악 모음곡 C장조 "수상 음악" TWV 55:C3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 C장조 "수상 음악" TWV 55:C3', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth"', 'album', NULL, 'TWV', '55:C3', 1723, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c8359bd-f22e-4686-b318-e073ee9a7d32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c8359bd-f22e-4686-b318-e073ee9a7d32'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c8359bd-f22e-4686-b318-e073ee9a7d32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9233c47-7f2c-4e43-952d-69c833f5d628', 1, 'I', 'Ouverture', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9233c47-7f2c-4e43-952d-69c833f5d628'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6511553d-4503-4cbc-90fe-051a672332ac', 2, 'II', 'Sarabande. Die schlafende Thetis', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": II. Sarabande. Die schlafende Thetis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6511553d-4503-4cbc-90fe-051a672332ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29a2a6eb-2ce0-44a1-96bf-65637d48f0cc', 3, 'III', 'Bourrée. Die erwachende Thetis', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": III. Bourrée. Die erwachende Thetis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29a2a6eb-2ce0-44a1-96bf-65637d48f0cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8dcf74c-1514-4e46-a1f8-8689b627ed06', 4, 'IV', 'Loure. Der verliebte Neptunus', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": IV. Loure. Der verliebte Neptunus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8dcf74c-1514-4e46-a1f8-8689b627ed06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36e75bac-f0ef-460b-b0e2-e81358ad4278', 5, 'V', 'Gavotte. Die spielenden Najaden', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": V. Gavotte. Die spielenden Najaden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e75bac-f0ef-460b-b0e2-e81358ad4278'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a77f144-7476-4696-8475-f2293415e9b6', 6, 'VI', 'Harlequinade. Die scherzenden Tritonen', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": VI. Harlequinade. Die scherzenden Tritonen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a77f144-7476-4696-8475-f2293415e9b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce8b5ce4-9dcd-4194-adfe-394cea864cea', 7, 'VII', 'Der stürmende Aeolus', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": VII. Der stürmende Aeolus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce8b5ce4-9dcd-4194-adfe-394cea864cea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5613e792-fd5f-49f1-b912-e652a0ef78b7', 8, 'VIII', 'Menuet. Der angenehme Zephir', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": VIII. Menuet. Der angenehme Zephir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5613e792-fd5f-49f1-b912-e652a0ef78b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72dbb092-8c3f-4db3-97a2-4efcd39beeaa', 9, 'IX', 'Gigue. Ebbe und Fluth', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": IX. Gigue. Ebbe und Fluth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72dbb092-8c3f-4db3-97a2-4efcd39beeaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2649f172-183b-45ff-8331-c46c8d9f9ff9', 10, 'X', 'Canarie. Die lustigen Bootsleute', 'Ouverture-Suite, TWV 55:C3 "Hamburger Ebb und Fluth": X. Canarie. Die lustigen Bootsleute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2649f172-183b-45ff-8331-c46c8d9f9ff9'
);


-- TWV 55:G4 관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4', 'Ouverture-Suite, TWV 55:G4, '' Les nations anciens et modernes''', 'album', NULL, 'TWV', '55:G4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30443f4e-3e50-488f-b169-36bd756bb1e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30443f4e-3e50-488f-b169-36bd756bb1e4'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30443f4e-3e50-488f-b169-36bd756bb1e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f87a6ec-8198-38c7-80b8-6f30fd2d1f87', 1, 'I', 'Ouverture', 'Les nations anciens et modernes: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f87a6ec-8198-38c7-80b8-6f30fd2d1f87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44ee4072-917a-3058-8b25-b7ace30fa75f', 2, 'II', 'Menuet I and Menuet II', 'Les nations anciens et modernes: II. Menuet I and Menuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44ee4072-917a-3058-8b25-b7ace30fa75f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcae848d-31ef-3c3b-b802-95112c92685d', 3, 'III', 'Les Allemands anciens', 'Les nations anciens et modernes: III. Les Allemands anciens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcae848d-31ef-3c3b-b802-95112c92685d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4234be7-71bb-3cf6-81c0-57b5d33e0ea4', 4, 'IV', 'Les Allemands modernes', 'Les nations anciens et modernes: IV. Les Allemands modernes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4234be7-71bb-3cf6-81c0-57b5d33e0ea4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfe0ca0e-a0d0-3d5f-bf7b-e43190a94013', 5, 'V', 'Les Suedois anciens', 'Les nations anciens et modernes: V. Les Suedois anciens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe0ca0e-a0d0-3d5f-bf7b-e43190a94013'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b67d866-0e14-37d9-a132-06a2b4eb5ce8', 6, 'VI', 'Les Suedois modernes', 'Les nations anciens et modernes: VI. Les Suedois modernes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b67d866-0e14-37d9-a132-06a2b4eb5ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed42ad3e-8ac5-326d-9be3-3b0decc26385', 7, 'VII', 'Les Danois anciens', 'Les nations anciens et modernes: VII. Les Danois anciens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed42ad3e-8ac5-326d-9be3-3b0decc26385'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72fd6c69-412f-3aef-9301-4e624ead1235', 8, 'VIII', 'Les Danois modernes', 'Les nations anciens et modernes: VIII. Les Danois modernes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72fd6c69-412f-3aef-9301-4e624ead1235'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:683ed1a8-9875-3dc9-b8f6-662a4704fed3', 9, 'IX', 'Les vieilles femmes', 'Les nations anciens et modernes: IX. Les vieilles femmes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:683ed1a8-9875-3dc9-b8f6-662a4704fed3'
);


-- TWV 55:B5 관현악 모음곡 B♭장조 "민족들" TWV 55:B5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 B♭장조 "민족들" TWV 55:B5', 'Ouverture in B-flat major, TWV 55:B5 "Völker-Ouvertüre"', 'song', NULL, 'TWV', '55:B5', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 B♭장조 "민족들" TWV 55:B5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7729ae6d-88a6-4adc-b6af-f14731b5138c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7729ae6d-88a6-4adc-b6af-f14731b5138c'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "민족들" TWV 55:B5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7729ae6d-88a6-4adc-b6af-f14731b5138c'
);


-- TWV 55:F11 관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11', 'Overture in F major, "Alster Echo", TWV 55:F11', 'album', NULL, 'TWV', '55:F11', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444c2661-0cf9-4381-88a7-127cbeaf113a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '444c2661-0cf9-4381-88a7-127cbeaf113a'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444c2661-0cf9-4381-88a7-127cbeaf113a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c603126-6f2d-43ba-b727-c8b921fc31bd', 1, 'I', 'Overture', 'Overture in F major, "Alster Echo", TWV 55:F11: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c603126-6f2d-43ba-b727-c8b921fc31bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef70a907-e0d7-4573-ac43-bc43df33d45e', 2, 'II', 'Die Kanonierende Pallas', 'Overture in F major, "Alster Echo", TWV 55:F11: II. Die Kanonierende Pallas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef70a907-e0d7-4573-ac43-bc43df33d45e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d9bf5aa-dc51-45d7-910c-972d29928f66', 3, 'III', 'Das Alster — Echo', 'Overture in F major, "Alster Echo", TWV 55:F11: III. Das Alster — Echo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d9bf5aa-dc51-45d7-910c-972d29928f66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b9406a-6e83-4288-8cd9-304be64dfcdd', 4, 'IV', 'Die Hamburgischen Glockenspiele', 'Overture in F major, "Alster Echo", TWV 55:F11: IV. Die Hamburgischen Glockenspiele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b9406a-6e83-4288-8cd9-304be64dfcdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da729fb8-1d43-441d-accc-b8dff807526a', 5, 'V', 'Die Schwanengesang', 'Overture in F major, "Alster Echo", TWV 55:F11: V. Die Schwanengesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da729fb8-1d43-441d-accc-b8dff807526a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec46f3cc-a4f4-49fb-8bc7-0239becdca61', 6, 'VI', 'Die Alsterschafer Dorfmusik', 'Overture in F major, "Alster Echo", TWV 55:F11: VI. Die Alsterschafer Dorfmusik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec46f3cc-a4f4-49fb-8bc7-0239becdca61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f23feb11-4b33-4351-a9d0-ee2e6a1ffdb9', 7, 'VII', 'Die Konzertierenden Frosche und Krahen', 'Overture in F major, "Alster Echo", TWV 55:F11: VII. Die Konzertierenden Frosche und Krahen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f23feb11-4b33-4351-a9d0-ee2e6a1ffdb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803bbd2a-7e66-4f96-a55b-8ee5e9e8c142', 8, 'VIII', 'Der Rudende Pan', 'Overture in F major, "Alster Echo", TWV 55:F11: VIII. Der Rudende Pan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803bbd2a-7e66-4f96-a55b-8ee5e9e8c142'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:086bd4a4-e030-4f19-a146-5e63087f593d', 9, 'IX', 'Der Schafer und Nymphen Eilfertiger Abzug', 'Overture in F major, "Alster Echo", TWV 55:F11: IX: Der Schafer und Nymphen Eilfertiger Abzug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:086bd4a4-e030-4f19-a146-5e63087f593d'
);


-- TWV 55:B8 관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8', 'album', NULL, 'TWV', '55:B8', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b76597e-77ca-4f18-8ee1-7895c87d8c83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b76597e-77ca-4f18-8ee1-7895c87d8c83'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b76597e-77ca-4f18-8ee1-7895c87d8c83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33510255-b1f4-4b4f-8368-180554742f10', 1, 'I', 'Ouverture', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33510255-b1f4-4b4f-8368-180554742f10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96bea258-af02-449a-97e3-753608b442d2', 2, 'II', 'Scaramouches', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: II. Scaramouches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96bea258-af02-449a-97e3-753608b442d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c871ab8c-65b3-4ede-9979-9ede79e4faa4', 3, 'III', 'Harlequinade', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: III. Harlequinade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c871ab8c-65b3-4ede-9979-9ede79e4faa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4978e94-1120-4a83-b99f-29f3d4ff1394', 4, 'IV', 'Colombine', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: IV. Colombine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4978e94-1120-4a83-b99f-29f3d4ff1394'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a387d748-fc8b-472a-b52e-5b042720c994', 5, 'V', 'Pierrot', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: V. Pierrot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a387d748-fc8b-472a-b52e-5b042720c994'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411025e9-eb48-41ac-ad81-7016bfb3e829', 6, 'VI', 'Menuets I And II', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: VI. Menuets I And II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411025e9-eb48-41ac-ad81-7016bfb3e829'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8d47374-4a23-44af-a184-e97b1018e1a6', 7, 'VII', 'Mezzetin en Turc', 'Ouverture burlesque, Orchestral Suite in B-flat major, TWV 55:B8: VII. Mezzetin en Turc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d47374-4a23-44af-a184-e97b1018e1a6'
);


-- TWV 55:G2 관현악 모음곡 G장조 "라 비자르" TWV 55:G2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 G장조 "라 비자르" TWV 55:G2', 'Ouverture-Suite "La Bizarre", TWV 55:G2', 'album', NULL, 'TWV', '55:G2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4760eb0-dd95-4c3c-95a8-ca352a483c7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4760eb0-dd95-4c3c-95a8-ca352a483c7d'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4760eb0-dd95-4c3c-95a8-ca352a483c7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02036aa0-6d68-42e3-b64c-e5e1e20d953b', 1, 'I', 'Ouverture', 'Ouverture-Suite "La Bizarre", TWV 55:G2: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02036aa0-6d68-42e3-b64c-e5e1e20d953b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ccb7ce7-3772-4c2d-9cc7-0bbe303a5cbb', 2, 'II', 'Courante', 'Ouverture-Suite "La Bizarre", TWV 55:G2: II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ccb7ce7-3772-4c2d-9cc7-0bbe303a5cbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fcd5cef-b240-4d48-a331-e4707c48175e', 3, 'III', 'Gavotte En Rondeau', 'Ouverture-Suite "La Bizarre", TWV 55:G2: III. Gavotte En Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fcd5cef-b240-4d48-a331-e4707c48175e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12fdf5e8-15e8-4664-a431-6aa082503304', 4, 'IV', 'Branle', 'Ouverture-Suite "La Bizarre", TWV 55:G2: IV. Branle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12fdf5e8-15e8-4664-a431-6aa082503304'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d056c790-7a19-4621-a54a-8f63db6407bf', 5, 'V', 'Sarabande', 'Ouverture-Suite "La Bizarre", TWV 55:G2: V. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d056c790-7a19-4621-a54a-8f63db6407bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cdf69f1-e27f-4262-985f-f596a91533b2', 6, 'VI', 'Fantaisie', 'Ouverture-Suite "La Bizarre", TWV 55:G2: VI. Fantaisie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cdf69f1-e27f-4262-985f-f596a91533b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ae47b09-610e-4ecc-85ac-13c5b744c976', 7, 'VII', 'Menuet I - Menuet II', 'Ouverture-Suite "La Bizarre", TWV 55:G2: VII. Menuet I - Menuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ae47b09-610e-4ecc-85ac-13c5b744c976'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1439ad67-4670-49a4-9e4e-78c448d0a50a', 8, 'VIII', 'Rossignol', 'Ouverture-Suite "La Bizarre", TWV 55:G2: VIII. Rossignol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1439ad67-4670-49a4-9e4e-78c448d0a50a'
);


-- TWV 55:g2 관현악 모음곡 G단조 "라 샹장트" TWV 55:g2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2', 'album', NULL, 'TWV', '55:g2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c802de86-3975-40f1-b5a4-3774324ad55a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c802de86-3975-40f1-b5a4-3774324ad55a'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c802de86-3975-40f1-b5a4-3774324ad55a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6dc23d0-736d-3a4b-9393-9bbb022891dc', 1, 'I', 'Ouverture', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6dc23d0-736d-3a4b-9393-9bbb022891dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c336fc3-9c2e-3774-9814-b75881d4fac5', 2, 'II', 'Loure', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: II. Loure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c336fc3-9c2e-3774-9814-b75881d4fac5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:926cb6eb-49d1-395c-b288-05b7fe062d8d', 3, 'III', 'Les Scaramouches', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: III. Les Scaramouches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:926cb6eb-49d1-395c-b288-05b7fe062d8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7362bcfc-5896-3528-bd83-5101f6636bf2', 4, 'IV', 'Menuet I and Menuet II', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: IV. Menuet I and Menuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7362bcfc-5896-3528-bd83-5101f6636bf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c84db46-a103-3bcb-88c4-d58436c79a32', 5, 'V', 'La Plaisanterie', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: V. La Plaisanterie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c84db46-a103-3bcb-88c4-d58436c79a32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d613d45a-3fe0-3f95-a8d1-6b92d20806dd', 6, 'VI', 'Hornpipe', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: VI. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d613d45a-3fe0-3f95-a8d1-6b92d20806dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc0260d8-e2b3-300f-8a9c-801cb8f822b1', 7, 'VII', 'Avec douceur', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: VII. Avec douceur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc0260d8-e2b3-300f-8a9c-801cb8f822b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147a1bcf-2af6-379a-8f6d-6ce043d9babc', 8, 'VIII', 'Canarie', 'Ouverture-Suite in G minor “La Changeante”, TWV 55:g2: VIII. Canarie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147a1bcf-2af6-379a-8f6d-6ce043d9babc'
);


-- TWV 55:C5 관현악 모음곡 C장조 "라 부퐁" TWV 55:C5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne"', 'album', NULL, 'TWV', '55:C5', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca9ace65-217b-4f66-b3de-4b9f3c92ccbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca9ace65-217b-4f66-b3de-4b9f3c92ccbc'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca9ace65-217b-4f66-b3de-4b9f3c92ccbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d6226d-f06f-43dc-8258-3979e2709677', 1, 'I', 'Ouverture', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d6226d-f06f-43dc-8258-3979e2709677'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab202875-b3aa-44a3-8140-bdf387af8ec5', 2, 'II', 'Loure', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": II. Loure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab202875-b3aa-44a3-8140-bdf387af8ec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef626fad-bb84-4710-95ec-b9d2d4d3b064', 3, 'III', 'Rigaudon I & II', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": III. Rigaudon I & II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef626fad-bb84-4710-95ec-b9d2d4d3b064'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd0ad386-1eda-4a26-ac0e-7c83a0bf1cfb', 4, 'IV', 'Menuett I & II', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": IV. Menuett I & II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd0ad386-1eda-4a26-ac0e-7c83a0bf1cfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1b8c534-e481-44a0-ae14-ecc56db2cab1', 5, 'V', 'Entree', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": V. Entree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b8c534-e481-44a0-ae14-ecc56db2cab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9c1bd2a-aff4-4c23-b92f-5e2cc34a8738', 6, 'VI', 'Pastourelle', 'Ouverture-Suite in C major, TWV 55:C5 "La Bouffonne": VI. Pastourelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9c1bd2a-aff4-4c23-b92f-5e2cc34a8738'
);


-- TWV 55:B11 관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11', 'Ouverture-Suite, TWV 55:B11 "La Bourse"', 'album', NULL, 'TWV', '55:B11', 1720, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebb7c851-b4e7-48c3-9e5a-094596ce9054'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ebb7c851-b4e7-48c3-9e5a-094596ce9054'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebb7c851-b4e7-48c3-9e5a-094596ce9054'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f528f8df-de26-4b30-917f-6e61e1937e39', 1, 'I', 'Ouverture', 'Ouverture-Suite, TWV 55:B11 "La Bourse": I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f528f8df-de26-4b30-917f-6e61e1937e39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14b61c6f-b281-4d07-b044-dda7ee9b9549', 2, 'II', 'Le repos interrompu', 'Ouverture-Suite, TWV 55:B11 "La Bourse": II. Le repos interrompu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14b61c6f-b281-4d07-b044-dda7ee9b9549'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80698bb3-27fd-4f54-a44c-7b2cca5a4aab', 3, 'III', 'La guerre en la paix', 'Ouverture-Suite, TWV 55:B11 "La Bourse": III. La guerre en la paix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80698bb3-27fd-4f54-a44c-7b2cca5a4aab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cdbaa13-e2a3-4f88-91a9-020a4efa5e58', 4, 'IV', 'Les vainqueurs vaincus', 'Ouverture-Suite, TWV 55:B11 "La Bourse": IV. Les vainqueurs vaincus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cdbaa13-e2a3-4f88-91a9-020a4efa5e58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c38b7072-03fb-40f7-a06b-ceef7c074be0', 5, 'V', 'La solitude associée', 'Ouverture-Suite, TWV 55:B11 "La Bourse": V. La solitude associée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c38b7072-03fb-40f7-a06b-ceef7c074be0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05f2a9b5-d8a5-4387-9978-d18c28f9e664', 6, 'VI', 'L''espérance de Mississippi', 'Ouverture-Suite, TWV 55:B11 "La Bourse": VI. L''espérance de Mississippi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05f2a9b5-d8a5-4387-9978-d18c28f9e664'
);


-- TWV 55:g4 관현악 모음곡 G단조 TWV 55:g4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 G단조 TWV 55:g4', 'Ouverture-Suite, TWV 55:g4', 'album', NULL, 'TWV', '55:g4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 G단조 TWV 55:g4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc67b621-1b8e-4f5c-ad8a-d75ccaa47d4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc67b621-1b8e-4f5c-ad8a-d75ccaa47d4c'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc67b621-1b8e-4f5c-ad8a-d75ccaa47d4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69459d8f-ab76-3f9a-b03b-a9c8b0e56b06', 1, 'I', 'Ouverture: Grave - Allegro - Grave', 'Overture in g-Moll, TWV 55 g4: I. Ouverture: Grave - Allegro - Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69459d8f-ab76-3f9a-b03b-a9c8b0e56b06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e8f6065-8b6d-33af-bb63-bfed80fe30a0', 2, 'II', 'Rondeau/Gayement', 'Overture in g-Moll, TWV 55 g4: II. Rondeau/Gayement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e8f6065-8b6d-33af-bb63-bfed80fe30a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:210f0cb0-5f59-3b54-a2fe-9805033cd0bf', 3, 'III', 'Les Irrésoluts', 'Overture in g-Moll, TWV 55 g4: III. Les Irrésoluts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:210f0cb0-5f59-3b54-a2fe-9805033cd0bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee9f6bc-c6ca-39e7-8d3f-36dd4065fd5a', 4, 'IV', 'Les Capricieuses', 'Overture in g-Moll, TWV 55 g4: IV. Les Capricieuses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee9f6bc-c6ca-39e7-8d3f-36dd4065fd5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f992cb3-57e2-3c7d-b3d2-f822018ce7b9', 5, 'V', 'Loure', 'Overture in g-Moll, TWV 55 g4: V. Loure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f992cb3-57e2-3c7d-b3d2-f822018ce7b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec9bd14a-87d8-37b3-82a3-535234bb406a', 6, 'VI', 'Gasconnade', 'Overture in g-Moll, TWV 55 g4: VI. Gasconnade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec9bd14a-87d8-37b3-82a3-535234bb406a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18e83a46-f602-35ae-a38a-04fa5e5028b2', 7, 'VII', 'Menuet I/II', 'Overture in g-Moll, TWV 55 g4: VII. Menuet I/II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '관현악 모음곡 G단조 TWV 55:g4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e83a46-f602-35ae-a38a-04fa5e5028b2'
);


-- TWV 55:D6 비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6', 'album', NULL, 'TWV', '55:D6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcf7c1fe-5816-4d21-9194-2e397a927cce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bcf7c1fe-5816-4d21-9194-2e397a927cce'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcf7c1fe-5816-4d21-9194-2e397a927cce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23691d68-e309-41f3-b247-060431517280', 1, 'I', 'Ouverture', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23691d68-e309-41f3-b247-060431517280'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f66229b-44f8-47d7-875b-e3b071f4f6d2', 2, 'II', 'La Trompette', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: II. La Trompette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f66229b-44f8-47d7-875b-e3b071f4f6d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85a023cb-2137-489c-bbab-4906c0e2ebc4', 3, 'III', 'Sarabande', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a023cb-2137-489c-bbab-4906c0e2ebc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df750238-56ce-4b87-827d-cd09290dad99', 4, 'IV', 'Rondeau', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: IV. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df750238-56ce-4b87-827d-cd09290dad99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0336e5b4-31ff-4d4f-a7ee-07fb0ea082d5', 5, 'V', 'Bourrée', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: V. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0336e5b4-31ff-4d4f-a7ee-07fb0ea082d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f22fea7-1e4f-44e1-b4db-9bcb49ae16e9', 6, 'VI', 'Courante - Double', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: VI. Courante - Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f22fea7-1e4f-44e1-b4db-9bcb49ae16e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:530a87b3-b5c3-4b4a-b781-fc1280013126', 7, 'VII', 'Gigue', 'Ouverture-Suite in D Major for Viola da Gamba, Strings and Basso Continuo, TWV 55:D6: VII. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:530a87b3-b5c3-4b4a-b781-fc1280013126'
);


-- TWV 50:1 <귀뚜라미 교향곡> TWV 50:1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<귀뚜라미 교향곡> TWV 50:1', 'Grillen-Symphonie, TWV 50:1', 'album', NULL, 'TWV', '50:1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<귀뚜라미 교향곡> TWV 50:1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b7e36dd-4014-4f7a-85d4-9f1490c55202'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b7e36dd-4014-4f7a-85d4-9f1490c55202'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<귀뚜라미 교향곡> TWV 50:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b7e36dd-4014-4f7a-85d4-9f1490c55202'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38c9678b-ef8b-4cb9-906c-415c3d363889', 1, 'I', 'Etwas Lebhaft', 'Grillen-Symphonie, TWV 50:1: I. Etwas Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<귀뚜라미 교향곡> TWV 50:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c9678b-ef8b-4cb9-906c-415c3d363889'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7799df5a-2c53-4832-8a77-1d3dc83a607f', 2, 'II', 'Tandelnd', 'Grillen-Symphonie, TWV 50:1: II. Tandelnd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<귀뚜라미 교향곡> TWV 50:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7799df5a-2c53-4832-8a77-1d3dc83a607f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7529953b-e2e7-4c51-922e-da81e2455a8e', 3, 'III', 'Presto', 'Grillen-Symphonie, TWV 50:1: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<귀뚜라미 교향곡> TWV 50:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7529953b-e2e7-4c51-922e-da81e2455a8e'
);


-- TWV 44:1 신포니아 스피리투오사 D장조 TWV 44:1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 스피리투오사 D장조 TWV 44:1', 'Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1', 'album', NULL, 'TWV', '44:1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 스피리투오사 D장조 TWV 44:1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfd1817b-4fe5-4444-8c67-7bd5291315f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfd1817b-4fe5-4444-8c67-7bd5291315f0'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '신포니아 스피리투오사 D장조 TWV 44:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfd1817b-4fe5-4444-8c67-7bd5291315f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fbff0e-5438-4a92-93a4-45f8bbb56672', 1, 'I', 'Spiritoso', 'Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1: I. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '신포니아 스피리투오사 D장조 TWV 44:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fbff0e-5438-4a92-93a4-45f8bbb56672'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b9d398-2f5e-4c0e-ae06-dcf214557963', 2, 'II', 'Largo', 'Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '신포니아 스피리투오사 D장조 TWV 44:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b9d398-2f5e-4c0e-ae06-dcf214557963'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c108e4-2e62-4f32-9417-175ab7f62e8e', 3, 'III', 'Vivace', 'Sonata for trumpet, 2 violins, viola & continuo in D major "Sonate spirituosa", TWV 44:1: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '신포니아 스피리투오사 D장조 TWV 44:1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c108e4-2e62-4f32-9417-175ab7f62e8e'
);


-- TWV 51:D7 트럼펫 협주곡 D장조 TWV 51:D7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트럼펫 협주곡 D장조 TWV 51:D7', 'Trumpet Concerto in D major, TWV 51:D7', 'album', NULL, 'TWV', '51:D7', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트럼펫 협주곡 D장조 TWV 51:D7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '601f5c2c-f012-4a18-a276-e5a9be3c377b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '601f5c2c-f012-4a18-a276-e5a9be3c377b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫 협주곡 D장조 TWV 51:D7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '601f5c2c-f012-4a18-a276-e5a9be3c377b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63466bdf-9553-3074-8b05-517bced16d43', 1, 'I', 'Adagio', 'Trumpet Concerto in D major, TWV 51:D7: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫 협주곡 D장조 TWV 51:D7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63466bdf-9553-3074-8b05-517bced16d43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0544bb47-2ab0-438f-aafb-8b6a9275b549', 2, 'II', 'Allegro', 'Trumpet Concerto in D major, TWV 51:D7: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫 협주곡 D장조 TWV 51:D7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0544bb47-2ab0-438f-aafb-8b6a9275b549'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64d5fd65-14fc-45a8-9c90-e83f4429c702', 3, 'III', 'Grave', 'Trumpet Concerto in D major, TWV 51:D7: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫 협주곡 D장조 TWV 51:D7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64d5fd65-14fc-45a8-9c90-e83f4429c702'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3166527e-2f69-3c49-9cbf-349babab5791', 4, 'IV', 'Allegro', 'Trumpet Concerto in D major, TWV 51:D7: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫 협주곡 D장조 TWV 51:D7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3166527e-2f69-3c49-9cbf-349babab5791'
);


-- TWV 51:D8 호른 협주곡 D장조 TWV 51:D8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 협주곡 D장조 TWV 51:D8', 'Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8', 'album', NULL, 'TWV', '51:D8', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 협주곡 D장조 TWV 51:D8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '547b820e-7bc9-4c14-a161-92789d677e7c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '547b820e-7bc9-4c14-a161-92789d677e7c'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '호른 협주곡 D장조 TWV 51:D8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '547b820e-7bc9-4c14-a161-92789d677e7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e003b26-07a1-4554-9cc1-0fac296bb9a6', 1, 'I', 'Vivace', 'Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '호른 협주곡 D장조 TWV 51:D8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e003b26-07a1-4554-9cc1-0fac296bb9a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e4756d7-dd4b-4111-a0dd-0c33d9df271f', 2, 'II', 'Largo', 'Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '호른 협주곡 D장조 TWV 51:D8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e4756d7-dd4b-4111-a0dd-0c33d9df271f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0a056a-3850-48ad-8528-829555f20c2c', 3, 'III', 'Allegro', 'Concerto in D major for Corno da Caccia, Strings and Continuo TWV 51:D8: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '호른 협주곡 D장조 TWV 51:D8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0a056a-3850-48ad-8528-829555f20c2c'
);


-- TWV 51:D2 플루트 협주곡 D장조 TWV 51:D2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 D장조 TWV 51:D2', 'Concerto for Flute, Strings and Continuo in D, TWV 51:D2', 'album', NULL, 'TWV', '51:D2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 D장조 TWV 51:D2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72c846b9-1b7d-4df0-83ee-e7714881c911'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72c846b9-1b7d-4df0-83ee-e7714881c911'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 D장조 TWV 51:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72c846b9-1b7d-4df0-83ee-e7714881c911'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b9beaa3-cde8-456b-bb9b-c869aa0db009', 1, 'I', 'Moderato', 'Concerto for Flute, Strings and Continuo in D, TWV 51:D2: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 D장조 TWV 51:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b9beaa3-cde8-456b-bb9b-c869aa0db009'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31f7d96d-6fe6-4589-9c16-e3435199d9e4', 2, 'II', 'Allegro', 'Concerto for Flute, Strings and Continuo in D, TWV 51:D2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 D장조 TWV 51:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31f7d96d-6fe6-4589-9c16-e3435199d9e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc0fde0-0c85-4cbf-87ce-52e42cb56701', 3, 'III', 'Largo', 'Concerto for Flute, Strings and Continuo in D, TWV 51:D2: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 D장조 TWV 51:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc0fde0-0c85-4cbf-87ce-52e42cb56701'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79ecbeea-5c4e-4d9e-8bb2-887a03e5506d', 4, 'IV', 'Vivace', 'Concerto for Flute, Strings and Continuo in D, TWV 51:D2: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 D장조 TWV 51:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79ecbeea-5c4e-4d9e-8bb2-887a03e5506d'
);


-- TWV 51:E1 플루트 협주곡 E장조 TWV 51:E1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 E장조 TWV 51:E1', 'Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1', 'album', NULL, 'TWV', '51:E1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 E장조 TWV 51:E1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e7611aa-299f-4c3f-962a-fd9ab819b1d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e7611aa-299f-4c3f-962a-fd9ab819b1d5'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 E장조 TWV 51:E1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e7611aa-299f-4c3f-962a-fd9ab819b1d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5919df-b9d9-446e-bf09-57e9cc46447f', 1, 'I', 'Dolce e staccato', 'Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1: I. Dolce e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 E장조 TWV 51:E1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5919df-b9d9-446e-bf09-57e9cc46447f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b70b5b51-b8cf-4d1a-8792-79252b078573', 2, 'II', 'Allabreve', 'Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1: II. Allabreve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 E장조 TWV 51:E1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b70b5b51-b8cf-4d1a-8792-79252b078573'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a96409d-d712-4e78-b593-ed683299651a', 3, 'III', 'Largo (do dièse mineur)', 'Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1: III. Largo (do dièse mineur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 E장조 TWV 51:E1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a96409d-d712-4e78-b593-ed683299651a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daf5a00c-949f-4ab6-aefa-053a6e9c8755', 4, 'IV', 'Vivace', 'Concerto, en mi majeur, pour flûte traversière, cordes et basse continue, TWV 51:E1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 E장조 TWV 51:E1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf5a00c-949f-4ab6-aefa-053a6e9c8755'
);


-- TWV 51:h1 플루트 협주곡 B단조 TWV 51:h1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 B단조 TWV 51:h1', 'Flute Concerto in B minor, TWV 51:h1', 'album', NULL, 'TWV', '51:h1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 B단조 TWV 51:h1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8006e927-f3d8-435c-9f3f-30ead6636f49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8006e927-f3d8-435c-9f3f-30ead6636f49'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 B단조 TWV 51:h1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8006e927-f3d8-435c-9f3f-30ead6636f49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ad297c3-86dd-47ee-9289-f9630974b982', 1, 'I', 'Presto', 'Flute Concerto in B minor, TWV 51:h1: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 B단조 TWV 51:h1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad297c3-86dd-47ee-9289-f9630974b982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4629f2d7-c8d9-4eb4-b730-0daf243e5576', 2, 'II', 'Largo', 'Flute Concerto in B minor, TWV 51:h1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 B단조 TWV 51:h1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4629f2d7-c8d9-4eb4-b730-0daf243e5576'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2997d84c-40e3-4d30-aed9-06884fec2f70', 3, 'III', '(빠르기 표시 없음)', 'Flute Concerto in B Minor, TWV 51:h1: III. No Tempo Indication', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '플루트 협주곡 B단조 TWV 51:h1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2997d84c-40e3-4d30-aed9-06884fec2f70'
);


-- TWV 51:C1 리코더 협주곡 C장조 TWV 51:C1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더 협주곡 C장조 TWV 51:C1', 'Recorder Concerto in C major, TWV 51:C1', 'album', NULL, 'TWV', '51:C1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더 협주곡 C장조 TWV 51:C1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2580410-b463-42b9-a6dc-96e778983e7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2580410-b463-42b9-a6dc-96e778983e7e'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 C장조 TWV 51:C1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2580410-b463-42b9-a6dc-96e778983e7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d7c101-3112-4b12-88df-e40599b5a681', 1, 'I', 'Allegretto', 'Recorder Concerto in C major, TWV 51:C1: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 C장조 TWV 51:C1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d7c101-3112-4b12-88df-e40599b5a681'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77567232-6f29-45e4-b8fe-bd8012ccb710', 2, 'II', 'Allegro', 'Recorder Concerto in C major, TWV 51:C1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 C장조 TWV 51:C1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77567232-6f29-45e4-b8fe-bd8012ccb710'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61854a7c-8f6a-47c8-ba29-362ce574d77e', 3, 'III', 'Andante', 'Recorder Concerto in C major, TWV 51:C1: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 C장조 TWV 51:C1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61854a7c-8f6a-47c8-ba29-362ce574d77e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ffe6a2-69e6-4ef8-a671-caca19a4a91d', 4, 'IV', 'Tempo di minuet', 'Recorder Concerto in C major, TWV 51:C1: IV. Tempo di minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 C장조 TWV 51:C1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ffe6a2-69e6-4ef8-a671-caca19a4a91d'
);


-- TWV 51:F1 리코더 협주곡 F장조 TWV 51:F1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더 협주곡 F장조 TWV 51:F1', 'Recorder Concerto in F major, TWV 51:F1', 'album', NULL, 'TWV', '51:F1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더 협주곡 F장조 TWV 51:F1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72129bb2-c5db-4acb-a1a2-daf615b028c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72129bb2-c5db-4acb-a1a2-daf615b028c2'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 F장조 TWV 51:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72129bb2-c5db-4acb-a1a2-daf615b028c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11a99ae0-4c8e-4842-9686-7cefb49735c4', 1, 'I', 'Affettuoso', 'Recorder Concerto in F major, TWV 51:F1: I. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 F장조 TWV 51:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11a99ae0-4c8e-4842-9686-7cefb49735c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc5d449-655f-4246-8ca7-976a17171d08', 2, 'II', 'Allegro', 'Recorder Concerto in F major, TWV 51:F1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 F장조 TWV 51:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc5d449-655f-4246-8ca7-976a17171d08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da48b79a-322c-489c-a1ae-4c3abfae9750', 3, 'III', 'Adagio', 'Recorder Concerto in F major, TWV 51:F1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 F장조 TWV 51:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da48b79a-322c-489c-a1ae-4c3abfae9750'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23226131-eaec-4b9f-9077-e876d82fa8e1', 4, 'IV', 'Menuett I - Menuett II - Menuett I da capo', 'Recorder Concerto in F major, TWV 51:F1: IV. Menuett I - Menuett II - Menuett I da capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더 협주곡 F장조 TWV 51:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23226131-eaec-4b9f-9077-e876d82fa8e1'
);


-- TWV 51:c1 오보에 협주곡 C단조 TWV 51:c1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 C단조 TWV 51:c1', 'Oboe Concerto in C minor, TWV 51:c1', 'album', NULL, 'TWV', '51:c1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 C단조 TWV 51:c1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17a326e1-2082-40a2-a19e-7c527ba17a24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17a326e1-2082-40a2-a19e-7c527ba17a24'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 C단조 TWV 51:c1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17a326e1-2082-40a2-a19e-7c527ba17a24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:015d3112-224b-4905-a45d-228799c08dc0', 1, 'I', '[Adagio]', 'Oboe Concerto in C minor, TWV 51:c1: I. [Adagio]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 C단조 TWV 51:c1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015d3112-224b-4905-a45d-228799c08dc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa1c322d-6f2b-479a-89aa-aa2d0b510e23', 2, 'II', 'Allegro', 'Oboe Concerto in C minor, TWV 51:c1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 C단조 TWV 51:c1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa1c322d-6f2b-479a-89aa-aa2d0b510e23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff56027-0099-412a-9feb-dac3a6f8635e', 3, 'III', 'Adagio', 'Oboe Concerto in C minor, TWV 51:c1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 C단조 TWV 51:c1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff56027-0099-412a-9feb-dac3a6f8635e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cbcc451-98c5-4ac9-8430-598835899ea1', 4, 'IV', 'Allegro', 'Oboe Concerto in C minor, TWV 51:c1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 C단조 TWV 51:c1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cbcc451-98c5-4ac9-8430-598835899ea1'
);


-- TWV 51:d1 오보에 협주곡 D단조 TWV 51:d1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 D단조 TWV 51:d1', 'Oboe Concerto in D minor, TWV 51:d1', 'album', NULL, 'TWV', '51:d1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 D단조 TWV 51:d1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f14c8993-6469-492d-91b6-e01868db2470'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f14c8993-6469-492d-91b6-e01868db2470'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 D단조 TWV 51:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f14c8993-6469-492d-91b6-e01868db2470'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f38e25-082a-41ea-9308-f5e9c1eb397f', 1, 'I', 'Adagio', 'Oboe Concerto in D minor, TWV 51:d1: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 D단조 TWV 51:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f38e25-082a-41ea-9308-f5e9c1eb397f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:058bc216-63a2-49d4-af7b-dcc52823d5fb', 2, 'II', '[Allegro]', 'Oboe Concerto in D minor, TWV 51:d1: II. [Allegro]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 D단조 TWV 51:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:058bc216-63a2-49d4-af7b-dcc52823d5fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c952938d-c2e7-44e1-adfb-0da7db424527', 3, 'III', 'Adagio', 'Oboe Concerto in D minor, TWV 51:d1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 D단조 TWV 51:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c952938d-c2e7-44e1-adfb-0da7db424527'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5481a67-7f98-4e10-9296-27e35ffc4966', 4, 'IV', '[Allegro]', 'Oboe Concerto in D minor, TWV 51:d1: IV. [Allegro]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 D단조 TWV 51:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5481a67-7f98-4e10-9296-27e35ffc4966'
);


-- TWV 51:e1 오보에 협주곡 E단조 TWV 51:e1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 E단조 TWV 51:e1', 'Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1', 'album', NULL, 'TWV', '51:e1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 E단조 TWV 51:e1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5bd26c9-c835-4c45-8ad3-de2c1a9a796b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5bd26c9-c835-4c45-8ad3-de2c1a9a796b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 E단조 TWV 51:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5bd26c9-c835-4c45-8ad3-de2c1a9a796b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dacf72b3-5ea2-44b8-b9ca-937bd876ef3b', 1, 'I', 'Andante', 'Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 E단조 TWV 51:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dacf72b3-5ea2-44b8-b9ca-937bd876ef3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b735bf6-5e48-45ac-aff3-ad2e05b3c5d3', 2, 'II', 'Allegro molto', 'Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1: II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 E단조 TWV 51:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b735bf6-5e48-45ac-aff3-ad2e05b3c5d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950639b0-4941-4c47-8d54-26338444d535', 3, 'III', 'Largo', 'Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 E단조 TWV 51:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950639b0-4941-4c47-8d54-26338444d535'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dbe824e-9c53-48f9-afbd-39bf47caa3b7', 4, 'IV', 'Allegro', 'Concerto for Oboe, Strings, and Continuo in E minor, TWV 51:e1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 E단조 TWV 51:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dbe824e-9c53-48f9-afbd-39bf47caa3b7'
);


-- TWV 51:f1 오보에 협주곡 F단조 TWV 51:f1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 F단조 TWV 51:f1', 'Oboe Concerto in F minor, TWV 51:f1', 'album', NULL, 'TWV', '51:f1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 F단조 TWV 51:f1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53c2400c-19aa-46ea-8824-7230ee2cb60a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53c2400c-19aa-46ea-8824-7230ee2cb60a'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 F단조 TWV 51:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53c2400c-19aa-46ea-8824-7230ee2cb60a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5182ca11-ef00-4d31-94e0-34ccc1c85894', 1, 'I', 'Allegro', 'Oboe Concerto in F minor, TWV 51:f1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 F단조 TWV 51:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5182ca11-ef00-4d31-94e0-34ccc1c85894'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bee4cc60-42f2-4bf7-b469-07d648e86b64', 2, 'II', 'Largo', 'Oboe Concerto in F minor, TWV 51:f1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 F단조 TWV 51:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bee4cc60-42f2-4bf7-b469-07d648e86b64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c3b6420-defb-4d7d-bbd1-0dd0cb0f19d5', 3, 'III', 'Vivace', 'Oboe Concerto in F minor, TWV 51:f1: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 협주곡 F단조 TWV 51:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c3b6420-defb-4d7d-bbd1-0dd0cb0f19d5'
);


-- TWV 51:A2 오보에 다모레 협주곡 A장조 TWV 51:A2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 다모레 협주곡 A장조 TWV 51:A2', 'Concerto for Oboe D''Amore, Strings & Continuo in A major, TWV 51:A2', 'album', NULL, 'TWV', '51:A2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 다모레 협주곡 A장조 TWV 51:A2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98d5958d-7edb-4d04-b473-864f77a189b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98d5958d-7edb-4d04-b473-864f77a189b7'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98d5958d-7edb-4d04-b473-864f77a189b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d6e4e48-2c5f-49a3-a2f8-40cb4a0d5b9d', 1, 'I', 'Siciliano', 'Concerto for Oboe D''Amore, Strings & Continuo in A major, TWV 51:A2: I. Siciliano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6e4e48-2c5f-49a3-a2f8-40cb4a0d5b9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a685f9f-3993-45a5-93fd-63d7a0fc3e67', 2, 'II', 'Allegro', 'Concerto for Oboe D''Amore, Strings & Continuo in A major, TWV 51:A2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a685f9f-3993-45a5-93fd-63d7a0fc3e67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0df502ac-c306-4544-a799-9565417566d8', 3, 'III', 'Largo', 'Concerto for Oboe D''Amore, Strings & Continuo in A major, TWV 51:A2: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0df502ac-c306-4544-a799-9565417566d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f69a6c7-a21b-4a80-ad80-4632c0a885f6', 4, 'IV', 'Vivace', 'Concerto for Oboe D''Amore, Strings & Continuo in A major, TWV 51:A2: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f69a6c7-a21b-4a80-ad80-4632c0a885f6'
);


-- TWV 51:G3 오보에 다모레 협주곡 G장조 TWV 51:G3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 다모레 협주곡 G장조 TWV 51:G3', 'Concerto for Oboe d''amore in G major, TWV 51:G3', 'album', NULL, 'TWV', '51:G3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 다모레 협주곡 G장조 TWV 51:G3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4efd7d14-03ec-42d2-ab94-e74e4ac72076'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4efd7d14-03ec-42d2-ab94-e74e4ac72076'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4efd7d14-03ec-42d2-ab94-e74e4ac72076'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df909b7-b031-4d73-a537-e4a30b617bea', 1, 'I', 'Soave', 'Concerto for Oboe d’amore in G major, TWV 51:G3: I. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df909b7-b031-4d73-a537-e4a30b617bea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37064e21-0ff4-4ac0-99b9-ea18c1217125', 2, 'II', 'Allegro', 'Concerto for Oboe d’amore in G major, TWV 51:G3: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37064e21-0ff4-4ac0-99b9-ea18c1217125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54723c94-5aec-43e2-9516-45fbebd90583', 3, 'III', 'Adagio', 'Concerto for Oboe d’amore in G major, TWV 51:G3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54723c94-5aec-43e2-9516-45fbebd90583'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34efa840-02bf-4a9c-a37a-7f03817bb903', 4, 'IV', 'Vivace', 'Concerto for Oboe d’amore in G major, TWV 51:G3: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34efa840-02bf-4a9c-a37a-7f03817bb903'
);


-- TWV 51:A4 바이올린 협주곡 A장조 "개구리" TWV 51:A4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 A장조 "개구리" TWV 51:A4', 'Concerto in A major, TWV 51:A4, "Die Relinge"', 'album', NULL, 'TWV', '51:A4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa3b878-a220-4506-9acc-94136418a2b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8aa3b878-a220-4506-9acc-94136418a2b0'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8aa3b878-a220-4506-9acc-94136418a2b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7782bd42-66ab-40f8-a41f-8b24162dc7ad', 1, 'I', 'Allegro', 'Concerto in A major, TWV 51:A4, "Die Relinge": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7782bd42-66ab-40f8-a41f-8b24162dc7ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb42295c-3e18-4844-b93b-7b811c05ab50', 2, 'II', 'Adagio', 'Concerto in A major, TWV 51:A4, "Die Relinge": II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb42295c-3e18-4844-b93b-7b811c05ab50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5237591-cb3d-41cc-83bb-04465a6a735f', 3, 'III', 'Menuet', 'Concerto in A major, TWV 51:A4, "Die Relinge": III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5237591-cb3d-41cc-83bb-04465a6a735f'
);


-- TWV 51:a1 바이올린 협주곡 A단조 TWV 51:a1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 A단조 TWV 51:a1', 'Violin Concerto in A minor, TWV 51:a1', 'album', NULL, 'TWV', '51:a1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 A단조 TWV 51:a1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba65654-719c-437c-a1ec-5cd19695e8b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ba65654-719c-437c-a1ec-5cd19695e8b6'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A단조 TWV 51:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba65654-719c-437c-a1ec-5cd19695e8b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:750f6598-665a-4292-97e2-5066724bf234', 1, 'I', 'Adagio', 'Violin Concerto in A minor, TWV 51:a1: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A단조 TWV 51:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:750f6598-665a-4292-97e2-5066724bf234'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8bacfa-70b9-458b-8c15-46f09993fa55', 2, 'II', 'Allegro - Adagio', 'Violin Concerto in A minor, TWV 51:a1: II. Allegro - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A단조 TWV 51:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8bacfa-70b9-458b-8c15-46f09993fa55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc150c96-dfc0-4063-aef5-2c2a37a3ae01', 3, 'III', 'Presto', 'Violin Concerto in A minor, TWV 51:a1: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 A단조 TWV 51:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc150c96-dfc0-4063-aef5-2c2a37a3ae01'
);


-- TWV 51:fis1 바이올린 협주곡 F#단조 TWV 51:fis1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 F#단조 TWV 51:fis1', 'Violin Concerto in F-sharp minor, TWV 51:fis1', 'album', NULL, 'TWV', '51:fis1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 F#단조 TWV 51:fis1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '917b5b12-8059-4451-91a4-c2efb074890b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '917b5b12-8059-4451-91a4-c2efb074890b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '917b5b12-8059-4451-91a4-c2efb074890b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c311437c-281a-43b8-98bd-a1e109eb21a7', 1, 'I', 'Adagio', 'Violin Concerto in F-sharp minor, TWV 51:fis1: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c311437c-281a-43b8-98bd-a1e109eb21a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e6f148-e619-4a78-9b02-1706fd4f316e', 2, 'II', 'Allegro', 'Violin Concerto in F-sharp minor, TWV 51:fis1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e6f148-e619-4a78-9b02-1706fd4f316e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18338182-e44c-4103-8495-9475de07d012', 3, 'III', 'Adagio', 'Violin Concerto in F-sharp minor, TWV 51:fis1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18338182-e44c-4103-8495-9475de07d012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e131a2b-27ca-4aff-b906-f220957e6df1', 4, 'IV', 'Allegro', 'Violin Concerto in F-sharp minor, TWV 51:fis1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e131a2b-27ca-4aff-b906-f220957e6df1'
);


-- TWV 52:e1 리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1', 'Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1', 'album', NULL, 'TWV', '52:e1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c66461d2-19b3-40b8-806b-eb5c745c8881'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c66461d2-19b3-40b8-806b-eb5c745c8881'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c66461d2-19b3-40b8-806b-eb5c745c8881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c95ebef-8634-459f-a202-0a6dd6592b20', 1, 'I', 'Largo', 'Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c95ebef-8634-459f-a202-0a6dd6592b20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:338a63e5-8b01-4911-8504-2a582158efe2', 2, 'II', 'Allegro', 'Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:338a63e5-8b01-4911-8504-2a582158efe2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99d4e203-7c89-4d8d-a8cd-26b4e7d98b10', 3, 'III', 'Largo', 'Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d4e203-7c89-4d8d-a8cd-26b4e7d98b10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efb35239-72de-4479-a01b-5c6a35a8fe27', 4, 'IV', 'Presto', 'Concerto in E minor for Recorder, Traverso, Strings and Continuo, TWV 52:e1: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efb35239-72de-4479-a01b-5c6a35a8fe27'
);


-- TWV 52:a1 리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1', 'Concerto for Recorder and Viola da Gamba in A minor, TWV 52:a1', 'album', NULL, 'TWV', '52:a1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0bdf7d-ce68-4a1f-94c2-09f05646cf26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec0bdf7d-ce68-4a1f-94c2-09f05646cf26'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0bdf7d-ce68-4a1f-94c2-09f05646cf26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b1093be-3b40-490d-856f-9278a7eb03cb', 1, 'I', 'Grave', 'Concerto for Recorder and Viola da Gamba, TWV 52:a1: I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b1093be-3b40-490d-856f-9278a7eb03cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49f509a-b38a-4fe0-949b-1467da096b17', 2, 'II', 'Allegro', 'Concerto for Recorder and Viola da Gamba, TWV 52:a1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49f509a-b38a-4fe0-949b-1467da096b17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7943de92-15fa-4afc-ab76-ffe5bc05d068', 3, 'III', 'Dolce', 'Concerto for Recorder and Viola da Gamba, TWV 52:a1: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7943de92-15fa-4afc-ab76-ffe5bc05d068'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bfff7e9-87fd-4e0b-b702-356ca576d623', 4, 'IV', 'Allegro', 'Concerto for Recorder and Viola da Gamba, TWV 52:a1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bfff7e9-87fd-4e0b-b702-356ca576d623'
);


-- TWV 52:F1 리코더와 바순을 위한 협주곡 F장조 TWV 52:F1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1', 'Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1', 'album', NULL, 'TWV', '52:F1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bab79b7f-b472-4c45-ba33-a15cec63a855'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bab79b7f-b472-4c45-ba33-a15cec63a855'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bab79b7f-b472-4c45-ba33-a15cec63a855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8898eea6-a7fd-48b9-b0d0-5c1a33a0fa29', 1, 'I', 'Largo', 'Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8898eea6-a7fd-48b9-b0d0-5c1a33a0fa29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e638c3aa-fd62-4f94-9f53-96ef2745b6c5', 2, 'II', 'Vivace', 'Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e638c3aa-fd62-4f94-9f53-96ef2745b6c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6aeac80-a5d4-4337-983a-95d6bdb141e9', 3, 'III', 'Grave', 'Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6aeac80-a5d4-4337-983a-95d6bdb141e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:234d6816-d002-497b-86c6-24aed41e7e2f', 4, 'IV', 'Allegro', 'Concerto in F major for Recorder, Bassoon, Strings and Continuo, TWV 52:F1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:234d6816-d002-497b-86c6-24aed41e7e2f'
);


-- TWV 52:a2 두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2', 'Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2', 'album', NULL, 'TWV', '52:a2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e34540d0-1308-4a8b-991b-0e8e64c35dc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e34540d0-1308-4a8b-991b-0e8e64c35dc1'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e34540d0-1308-4a8b-991b-0e8e64c35dc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdc06a51-7035-4aca-83c1-64867c8fac3d', 1, 'I', 'Gravement', 'Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2: I. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc06a51-7035-4aca-83c1-64867c8fac3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bd2850-2e4f-42b5-8b20-4c83020c2009', 2, 'II', 'Vistement', 'Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2: II. Vistement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bd2850-2e4f-42b5-8b20-4c83020c2009'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65417ca1-bbee-4dda-86bd-79375685fb9e', 3, 'III', 'Largement', 'Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2: III. Largement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65417ca1-bbee-4dda-86bd-79375685fb9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6589cd1e-a284-40d2-9b84-a75fca6593a5', 4, 'IV', 'Vivement', 'Double Concerto in A minor for Two Tenor Recorders and String Orchestra, TWV 52:a2: IV. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6589cd1e-a284-40d2-9b84-a75fca6593a5'
);


-- TWV 52:G3 두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3', 'Concerto for Two Violas in G major, TWV 52:G3', 'album', NULL, 'TWV', '52:G3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8545b7f-e1b7-49f1-b10f-d9c93fdc6b5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8545b7f-e1b7-49f1-b10f-d9c93fdc6b5b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8545b7f-e1b7-49f1-b10f-d9c93fdc6b5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3628a19e-a51e-4a82-b225-96ac0db258ca', 1, 'I', 'Avec douceur', 'Concerto for Two Violas in G major, TWV 52:G3: I. Avec douceur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3628a19e-a51e-4a82-b225-96ac0db258ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fddaac30-a5a0-4909-949f-baf422258681', 2, 'II', 'Gaÿ', 'Concerto for Two Violas in G major, TWV 52:G3: II. Gaÿ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fddaac30-a5a0-4909-949f-baf422258681'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb6dba6-22ce-40f6-8463-9f52d5745d0d', 3, 'III', 'Largo', 'Concerto for Two Violas in G major, TWV 52:G3: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb6dba6-22ce-40f6-8463-9f52d5745d0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04a4e6cb-5169-46fb-a368-13be78ce22b2', 4, 'IV', 'Vivement', 'Concerto for Two Violas in G major, TWV 52:G3: IV. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a4e6cb-5169-46fb-a368-13be78ce22b2'
);


-- TWV 52:D1 두 대의 호른을 위한 협주곡 D장조 TWV 52:D1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1', 'Double Concerto for 2 Horns in D major, TWV 52:D1', 'album', NULL, 'TWV', '52:D1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bb19e51-dc78-4138-a469-b1bc2ee347e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bb19e51-dc78-4138-a469-b1bc2ee347e3'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bb19e51-dc78-4138-a469-b1bc2ee347e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d925f7-461f-473d-9bf8-15defde1194c', 1, 'I', 'Largo - Allegro', 'Double Concerto for 2 Horns in D major, TWV 52:D1: I. Largo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d925f7-461f-473d-9bf8-15defde1194c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ca12ad2-0b8b-499e-8acb-e31f183cced4', 2, 'II', 'Vivace', 'Double Concerto for 2 Horns in D major, TWV 52:D1: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ca12ad2-0b8b-499e-8acb-e31f183cced4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc722e1a-1d7d-43f2-9c24-5e0db7aee409', 3, 'III', 'Affettuoso', 'Double Concerto for 2 Horns in D major, TWV 52:D1: III. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc722e1a-1d7d-43f2-9c24-5e0db7aee409'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aab07119-5d5e-4797-bccd-5cd298197bfb', 4, 'IV', 'Allegro', 'Double Concerto for 2 Horns in D major, TWV 52:D1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab07119-5d5e-4797-bccd-5cd298197bfb'
);


-- TWV 52:Es1 두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1', 'Concerto for 2 Horns in E-flat major, TWV 52:Es1', 'album', NULL, 'TWV', '52:Es1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db4d725f-07a5-4b71-8fa3-8bf3f7cda3b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db4d725f-07a5-4b71-8fa3-8bf3f7cda3b3'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db4d725f-07a5-4b71-8fa3-8bf3f7cda3b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d8c147-acc4-44a5-89cf-26e91f7144f2', 1, 'I', 'Allegro', 'Concerto for 2 Horns in E-flat major, TWV 52:Es1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d8c147-acc4-44a5-89cf-26e91f7144f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8427160-5d60-4419-b272-87603ac5ea3e', 2, 'II', 'Largo', 'Concerto for 2 Horns in E-flat major, TWV 52:Es1: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8427160-5d60-4419-b272-87603ac5ea3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:378db87f-1e5f-4c58-9219-d2a7c8bf18f7', 3, 'III', 'Vivace', 'Concerto for 2 Horns in E-flat major, TWV 52:Es1: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:378db87f-1e5f-4c58-9219-d2a7c8bf18f7'
);


-- TWV 52:d1 두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1', 'Concerto for 2 Chalumeaux in D minor, TWV 52:d1', 'album', NULL, 'TWV', '52:d1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daa5db34-c029-421b-b3f5-f8f3825340ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'daa5db34-c029-421b-b3f5-f8f3825340ab'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daa5db34-c029-421b-b3f5-f8f3825340ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43c36e55-41b8-446d-a997-09ebc4178b1b', 1, 'I', 'Largo', 'Concerto for 2 Chalumeaux in D minor, TWV 52:d1: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43c36e55-41b8-446d-a997-09ebc4178b1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:350aaf2f-f500-42e7-a3a6-dcf7f39944c1', 2, 'II', 'Allegro', 'Concerto for 2 Chalumeaux in D minor, TWV 52:d1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:350aaf2f-f500-42e7-a3a6-dcf7f39944c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5b40c2d-5c6c-4334-adf4-1d4ad9968ec5', 3, 'III', 'Adagio', 'Concerto for 2 Chalumeaux in D minor, TWV 52:d1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5b40c2d-5c6c-4334-adf4-1d4ad9968ec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40eb2fde-f7c9-48cf-97d5-dcf54e5e857d', 4, 'IV', '(Vivace)', 'Concerto for 2 Chalumeaux in D minor, TWV 52:d1: IV. (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40eb2fde-f7c9-48cf-97d5-dcf54e5e857d'
);


-- TWV 53:D2 트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2', 'Concerto for 2 Oboes and Trumpet, TWV 53:D2', 'album', NULL, 'TWV', '53:D2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d1a4545-9cfe-4caa-9225-961ac2441fd5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d1a4545-9cfe-4caa-9225-961ac2441fd5'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d1a4545-9cfe-4caa-9225-961ac2441fd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46071076-2347-4373-8542-be890aaafed6', 1, 'I', 'Allegro', 'Concerto for 2 Oboes and Trumpet, TWV 53:D2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46071076-2347-4373-8542-be890aaafed6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5bb4081-399f-49ca-8930-3fc83ed7a9ee', 2, 'II', 'Adagio', 'Concerto for 2 Oboes and Trumpet, TWV 53:D2: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5bb4081-399f-49ca-8930-3fc83ed7a9ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745f939e-ba7d-4a31-ab4c-efd39bd99b8d', 3, 'III', 'Aria', 'Concerto for 2 Oboes and Trumpet, TWV 53:D2: III. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745f939e-ba7d-4a31-ab4c-efd39bd99b8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6295129d-4bac-4686-aa48-284026743bfb', 4, 'IV', 'Vivace', 'Concerto for 2 Oboes and Trumpet, TWV 53:D2: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6295129d-4bac-4686-aa48-284026743bfb'
);


-- TWV 54:D3 세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3', 'album', NULL, 'TWV', '54:D3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bc3b04c-e9e4-435e-a4ec-53e2716e5972'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bc3b04c-e9e4-435e-a4ec-53e2716e5972'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bc3b04c-e9e4-435e-a4ec-53e2716e5972'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:826ad2aa-9175-4c28-bf0a-0ccdc74230a1', 1, 'I', 'Intrada', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3: I. Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:826ad2aa-9175-4c28-bf0a-0ccdc74230a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4c0b6f7-236e-4abe-8a24-10aa22616556', 2, 'II', 'Grave', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3: II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4c0b6f7-236e-4abe-8a24-10aa22616556'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2977aa02-0002-4f1c-a4de-6a3d443ed0cf', 3, 'III', 'Allegro', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2977aa02-0002-4f1c-a4de-6a3d443ed0cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:997a2704-71e7-46b7-a60a-89369fb35ebd', 4, 'IV', 'Largo', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:997a2704-71e7-46b7-a60a-89369fb35ebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00eeb30c-0625-465f-8ae4-429abb808933', 5, 'V', 'Vivace', 'Concerto in D major for 3 Trumpets and Timpani, TWV 54:D3: V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00eeb30c-0625-465f-8ae4-429abb808933'
);


-- TWV 54:D2 세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2', 'Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2', 'album', NULL, 'TWV', '54:D2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19119709-70c8-4124-85d7-27d771895d8d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19119709-70c8-4124-85d7-27d771895d8d'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19119709-70c8-4124-85d7-27d771895d8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81343db9-7fb7-4f3d-99e5-499b5766696e', 1, 'I', 'Allegro', 'Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81343db9-7fb7-4f3d-99e5-499b5766696e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c26e0a-58fa-4ced-81dc-6f45dbb49be7', 2, 'II', 'Grave', 'Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2: II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c26e0a-58fa-4ced-81dc-6f45dbb49be7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e0fd15-edfa-4ad6-a4a9-37a7f4b5d502', 3, 'III', 'Presto', 'Concerto in D major for Three Horns, Violin and Orchestra, TWV 54:D2: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e0fd15-edfa-4ad6-a4a9-37a7f4b5d502'
);


-- TWV 43:G7 폴란드풍 협주곡 G장조 TWV 43:G7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴란드풍 협주곡 G장조 TWV 43:G7', 'Concerto polonois in G major, TWV 43:G7', 'album', NULL, 'TWV', '43:G7', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴란드풍 협주곡 G장조 TWV 43:G7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc9e2e4e-8fbc-4ee1-ae0e-4d44bbf6afb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc9e2e4e-8fbc-4ee1-ae0e-4d44bbf6afb2'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc9e2e4e-8fbc-4ee1-ae0e-4d44bbf6afb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e91aa221-edba-48f0-b78b-f19235f7016f', 1, 'I', 'Dolce', 'Concerto polonois in G major, TWV 43:G7: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e91aa221-edba-48f0-b78b-f19235f7016f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80248938-181b-4e65-9b83-0184466d6aed', 2, 'II', 'Allegro', 'Concerto polonois in G major, TWV 43:G7: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80248938-181b-4e65-9b83-0184466d6aed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eda7ffb2-f3c7-4b00-96e3-45226ba3de1a', 3, 'III', 'Largo', 'Concerto polonois in G major, TWV 43:G7: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eda7ffb2-f3c7-4b00-96e3-45226ba3de1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d69cf26c-0386-4c2c-aba2-61e3a347b11d', 4, 'IV', 'Allegro', 'Concerto polonois in G major, TWV 43:G7: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d69cf26c-0386-4c2c-aba2-61e3a347b11d'
);


-- None <작은 실내 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<작은 실내 음악>', 'Die kleine Cammer-Music', 'album', NULL, NULL, NULL, 1716, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<작은 실내 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e90a37af-8b42-442a-9381-93a025e1a101'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e90a37af-8b42-442a-9381-93a025e1a101'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e90a37af-8b42-442a-9381-93a025e1a101'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6', 1, NULL, 'B♭장조', 'Partita no. 1 in B-flat major, TWV 41:B1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c706370a-9e42-4e71-9e75-56c93b0b20df', 1, 'I', 'Preludio. Con affetto', 'Partita no. 1 in B-flat major, TWV 41:B1: I. Preludio. Con affetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c706370a-9e42-4e71-9e75-56c93b0b20df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd684d6a-2051-4276-a39d-de88f862ae43', 2, 'II', 'Aria 1. Presto', 'Partita no. 1 in B-flat major, TWV 41:B1: II. Aria 1. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd684d6a-2051-4276-a39d-de88f862ae43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:815ce40c-19aa-4625-a0b7-a6df7a6576c1', 3, 'III', 'Aria 2. Dolce', 'Partita no. 1 in B-flat major, TWV 41:B1: III: Aria 2. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:815ce40c-19aa-4625-a0b7-a6df7a6576c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18d8340a-4232-414e-954e-2223c4d08e8f', 4, 'IV', 'Aria 3. Vivace', 'Partita no. 1 in B-flat major, TWV 41:B1: IV. Aria 3. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d8340a-4232-414e-954e-2223c4d08e8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6dba9ef9-87e6-4dc7-8d3c-eeb80d1712f7', 5, 'V', 'Aria 4. Largo', 'Partita no. 1 in B-flat major, TWV 41:B1: V. Aria 4. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dba9ef9-87e6-4dc7-8d3c-eeb80d1712f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd94c756-6096-4c92-87d3-fe9b6d76ceca', 6, 'VI', 'Aria 5. Vivace', 'Partita no. 1 in B-flat major, TWV 41:B1: VI. Aria 5. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd94c756-6096-4c92-87d3-fe9b6d76ceca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0844bd52-9489-45eb-9b50-08f6afc66363', 7, 'VII', 'Aria 6. Allegro', 'Partita no. 1 in B-flat major, TWV 41:B1: VII. Aria 6. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3052129-c9e6-4371-855d-f958c8f675f6'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0844bd52-9489-45eb-9b50-08f6afc66363'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30', 2, NULL, 'G장조', 'Partita no. 2 in G major, TWV 41:G2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a77f0ebf-592a-4805-991e-66801d72f3c3', 1, 'I', 'Preludio. Siciliana', 'Partita no. 2 in G major, TWV 41:G2: I. Preludio. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a77f0ebf-592a-4805-991e-66801d72f3c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bfa270b-ef2a-4bfa-b086-cd2efa2cee50', 2, 'II', 'Aria 1. Allegro', 'Partita no. 2 in G major, TWV 41:G2: II. Aria 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bfa270b-ef2a-4bfa-b086-cd2efa2cee50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e72f1806-6204-4af8-9acb-3ab9eff7527f', 3, 'III', 'Aria 2. Allegro', 'Partita no. 2 in G major, TWV 41:G2: III. Aria 2. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e72f1806-6204-4af8-9acb-3ab9eff7527f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31872272-bc11-4108-b0c7-58a61025fdbd', 4, 'IV', 'Aria 3. Vivace', 'Partita no. 2 in G major, TWV 41:G2: IV. Aria 3. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31872272-bc11-4108-b0c7-58a61025fdbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b18524c-943a-47e0-865f-fb60ab98d6c6', 5, 'V', 'Aria 4. Affettuoso', 'Partita no. 2 in G major, TWV 41:G2: V. Aria 4. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b18524c-943a-47e0-865f-fb60ab98d6c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30dee15d-8f60-4aac-9ac9-08f78678f97f', 6, 'VI', 'Aria 5. Presto', 'Partita no. 2 in G major, TWV 41:G2: VI. Aria 5. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30dee15d-8f60-4aac-9ac9-08f78678f97f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df20bd49-20fd-4015-b3c7-64546d5787f3', 7, 'VII', 'Aria 6. Tempo di Minue', 'Partita no. 2 in G major, TWV 41:G2: VII. Aria 6. Tempo di Minue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c10af3cb-7189-44c3-a873-fdcfc37ada30'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df20bd49-20fd-4015-b3c7-64546d5787f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926', 3, NULL, 'C단조', 'Partita no. 3 in C minor, TWV 41:c1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1843cd2-4113-458a-9cd8-b668bb454ba2', 1, 'I', 'Preludio. Adagio', 'Partita no. 3 in C minor, TWV 41:c1: I. Preludio. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1843cd2-4113-458a-9cd8-b668bb454ba2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c8c0423-2223-4be2-b74a-8ff981e9f417', 2, 'II', 'Aria 1. Presto', 'Partita no. 3 in C minor, TWV 41:c1: II. Aria 1. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8c0423-2223-4be2-b74a-8ff981e9f417'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f11dfcbe-b067-4087-940a-f966bcb62c45', 3, 'III', 'Aria 2. Vivace', 'Partita no. 3 in C minor, TWV 41:c1: III. Aria 2. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f11dfcbe-b067-4087-940a-f966bcb62c45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de099ce0-8955-4a29-83eb-0984404978fd', 4, 'IV', 'Aria 3. Vivace', 'Partita no. 3 in C minor, TWV 41:c1: IV. Aria 3. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de099ce0-8955-4a29-83eb-0984404978fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:439c7095-ce0d-473e-9343-3e4e8259e65e', 5, 'V', 'Aria 4. Allegro', 'Partita no. 3 in C minor, TWV 41:c1: V. Aria 4. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:439c7095-ce0d-473e-9343-3e4e8259e65e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04e39ab4-ef60-4a4d-82c1-694940e3930e', 6, 'VI', 'Aria 5. Vivace', 'Partita no. 3 in C minor, TWV 41:c1: VI. Aria 5. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e39ab4-ef60-4a4d-82c1-694940e3930e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:612597a4-0bba-4909-81fa-1eac52a959a3', 7, 'VII', 'Aria 6. Presto', 'Partita no. 3 in C minor, TWV 41:c1: VII. Aria 6. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b806e378-9477-439a-9fa9-925c01ed7926'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:612597a4-0bba-4909-81fa-1eac52a959a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349', 4, NULL, 'G단조', 'Partita no. 4 in G minor, TWV 41:g2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79d61be7-a0a8-4d85-a518-e50b720b16fa', 1, 'I', 'Preludio. Grave', 'Partita no. 4 in G minor, TWV 41:g2: I. Preludio. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d61be7-a0a8-4d85-a518-e50b720b16fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41e92c7b-683b-493b-99bd-a3b53af9555f', 2, 'II', 'Aria 1. Allegro', 'Partita no. 4 in G minor, TWV 41:g2: II. Aria 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e92c7b-683b-493b-99bd-a3b53af9555f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3d28779-b18a-47ab-b68d-2bba2aee09be', 3, 'III', 'Aria 2. Allegro', 'Partita no. 4 in G minor, TWV 41:g2: III. Aria 2. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3d28779-b18a-47ab-b68d-2bba2aee09be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ddb6449a-82ce-47a7-8bb6-817c08e8dfb4', 4, 'IV', 'Aria 3. Tempo di Minue', 'Partita no. 4 in G minor, TWV 41:g2: IV. Aria 3. Tempo di Minue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb6449a-82ce-47a7-8bb6-817c08e8dfb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be22513e-95d1-4056-852b-81eaeb1fec2d', 5, 'V', 'Aria 4. Allegro', 'Partita no. 4 in G minor, TWV 41:g2: V. Aria 4. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be22513e-95d1-4056-852b-81eaeb1fec2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27fe7025-7d5d-4e93-9a1b-0ffae681e2e1', 6, 'VI', 'Aria 5. A tempo giusto', 'Partita no. 4 in G minor, TWV 41:g2: VI. Aria 5. A tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27fe7025-7d5d-4e93-9a1b-0ffae681e2e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:725c9bed-28ff-4ba1-a643-837c3cca81a9', 7, 'VII', 'Aria 6. Allegro assai', 'Partita no. 4 in G minor, TWV 41:g2: VII. Aria 6. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94546575-bec2-40b0-bcc1-991078798349'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:725c9bed-28ff-4ba1-a643-837c3cca81a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367', 5, NULL, 'E단조', 'Partita no. 5 in E minor, TWV 41:e1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f764372c-c69b-409c-b0ec-9eddbc2abc0f', 1, 'I', 'Preludio. Andante', 'Partita no. 5 in E minor, TWV 41:e1: I. Preludio. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f764372c-c69b-409c-b0ec-9eddbc2abc0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8a14c6d-583b-47b5-95fe-c7726b849c84', 2, 'II', 'Aria 1. Vivace', 'Partita no. 5 in E minor, TWV 41:e1: II. Aria 1. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a14c6d-583b-47b5-95fe-c7726b849c84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19cb387b-e42d-4491-b4cb-4a353d4ff18b', 3, 'III', 'Aria 2. Presto', 'Partita no. 5 in E minor, TWV 41:e1: III. Aria 2. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19cb387b-e42d-4491-b4cb-4a353d4ff18b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1eab639e-e546-44d9-a82c-a0fdd16c5868', 4, 'IV', 'Aria 3. Vivace', 'Partita no. 5 in E minor, TWV 41:e1: IV. Aria 3. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eab639e-e546-44d9-a82c-a0fdd16c5868'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fba79af1-a5ae-4c26-b8c2-4dade67c7e83', 5, 'V', 'Aria 4. Siciliana', 'Partita no. 5 in E minor, TWV 41:e1: V. Aria 4. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba79af1-a5ae-4c26-b8c2-4dade67c7e83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc185448-50d7-4498-a1cf-d44e686714a6', 6, 'VI', 'Aria 5. Presto', 'Partita no. 5 in E minor, TWV 41:e1: VI. Aria 5. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc185448-50d7-4498-a1cf-d44e686714a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50daddb7-2779-4110-850c-aabb589e160a', 7, 'VII', 'Aria 6. Vivace', 'Partita no. 5 in E minor, TWV 41:e1: VII. Aria 6. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ddf8a396-7964-4e50-a284-a0fbdf569367'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50daddb7-2779-4110-850c-aabb589e160a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a', 6, NULL, 'E♭장조', 'Partita no. 6 in E-flat major, TWV 41:Es1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c12f77a-f11c-4597-9b30-33fea99ae1e8', 1, 'I', 'Preludio. Affettuoso', 'Partita no. 6 in E-flat major, TWV 41:Es1: I. Preludio. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c12f77a-f11c-4597-9b30-33fea99ae1e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0bdc1e85-0424-4ec0-99a0-9605fce64770', 2, 'II', 'Aria 1. Presto', 'Partita no. 6 in E-flat major, TWV 41:Es1: II. Aria 1. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bdc1e85-0424-4ec0-99a0-9605fce64770'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09de4c5f-8805-4993-82ac-48b24a8b28a0', 3, 'III', 'Aria 2. Vivace', 'Partita no. 6 in E-flat major, TWV 41:Es1: III. Aria 2. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09de4c5f-8805-4993-82ac-48b24a8b28a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a41abd8d-4174-4dd4-a368-19ffc6e46afa', 4, 'IV', 'Aria 3. Tempo di Ciacona', 'Partita no. 6 in E-flat major, TWV 41:Es1: IV. Aria 3. Tempo di Ciacona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41abd8d-4174-4dd4-a368-19ffc6e46afa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a6cd561-0de4-4000-bf2a-dc9bb74bdca2', 5, 'V', 'Aria 4. Allegro', 'Partita no. 6 in E-flat major, TWV 41:Es1: V. Aria 4. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a6cd561-0de4-4000-bf2a-dc9bb74bdca2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcd107c3-21d2-483c-8772-bb116a9872d9', 6, 'VI', 'Aria 5. Allegro', 'Partita no. 6 in E-flat major, TWV 41:Es1: VI. Aria 5. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd107c3-21d2-483c-8772-bb116a9872d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57ec7960-75fd-4476-8190-19718d2fe070', 7, 'VII', 'Aria 6. Tempo di Minue', 'Partita no. 6 in E-flat major, TWV 41:Es1: VII. Aria 6. Tempo di Minue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f249e6d-f00d-47c2-9244-55740029ef2a'
WHERE p.composer_id = 11 AND p.title = '<작은 실내 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ec7960-75fd-4476-8190-19718d2fe070'
);


-- None 바이올린과 하프시코드를 위한 6개의 소나타 (1715)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 하프시코드를 위한 6개의 소나타 (1715)', '6 Sonates à violon seul accompagné par le clavessin', 'album', NULL, NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50385464-0d9d-4ead-9462-251687091863'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50385464-0d9d-4ead-9462-251687091863'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50385464-0d9d-4ead-9462-251687091863'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8', 1, NULL, 'G단조', 'Sonata no. 1 in G minor, TWV 41:g1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:558f554c-1adc-4122-8b45-982a2d0184a4', 1, 'I', 'Adagio', 'Sonata no. 1 in G minor, TWV 41:g1: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558f554c-1adc-4122-8b45-982a2d0184a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47096bba-e54e-4b43-ba6e-c5448886fdc9', 2, 'II', 'Allegro', 'Sonata no. 1 in G minor, TWV 41:g1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47096bba-e54e-4b43-ba6e-c5448886fdc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1a9ab24-a4e4-4406-8bb1-4680f71253d6', 3, 'III', 'Adagio', 'Sonata no. 1 in G minor, TWV 41:g1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a9ab24-a4e4-4406-8bb1-4680f71253d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72ba995c-7cb4-4d5c-904d-e4db869e3454', 4, 'IV', 'Vivace', 'Sonata no. 1 in G minor, TWV 41:g1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da191eb1-8f2d-4fab-9e28-f59af8eca7a8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72ba995c-7cb4-4d5c-904d-e4db869e3454'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc', 2, NULL, 'D장조', 'Sonata no. 2 in D, TWV 41:D1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ef6da7b-8921-4269-a1dd-e4cbb68dff55', 1, 'I', 'Allemanda, Largo', 'Sonata no. 2 in D, TWV 41:D1: I. Allemanda, Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ef6da7b-8921-4269-a1dd-e4cbb68dff55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de942e73-407e-4446-a5bf-cb747152e2c7', 2, 'II', 'Corrente, Vivace', 'Sonata no. 2 in D, TWV 41:D1: II. Corrente, Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de942e73-407e-4446-a5bf-cb747152e2c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4ed3ede-e6e9-4a52-90f5-02b49a36daab', 3, 'III', 'Sarabanda', 'Sonata no. 2 in D, TWV 41:D1: III. Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4ed3ede-e6e9-4a52-90f5-02b49a36daab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85b1285d-026d-40f1-b67f-c6629e93cd42', 4, 'IV', 'Gigue', 'Sonata no. 2 in D, TWV 41:D1: IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f004322-0b27-4a80-a2ab-122c2ea4c6dc'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85b1285d-026d-40f1-b67f-c6629e93cd42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138', 3, NULL, 'B단조', 'Sonata no. 3 in B minor, TWV 41:h1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:725917a8-62de-490a-8132-e136ccc16692', 1, 'I', 'Cantabile', 'Sonata no. 3 in B minor, TWV 41:h1: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:725917a8-62de-490a-8132-e136ccc16692'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a598711-e9e0-4d84-8a21-a2cf33a1c948', 2, 'II', 'Allegro assai', 'Sonata no. 3 in B minor, TWV 41:h1: II. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a598711-e9e0-4d84-8a21-a2cf33a1c948'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d770cb2-4881-4092-a840-0a0e33f194b1', 3, 'III', 'Andante', 'Sonata no. 3 in B minor, TWV 41:h1: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d770cb2-4881-4092-a840-0a0e33f194b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70d09a7b-a084-4766-b35a-172a64d885c5', 4, 'IV', 'Vivace', 'Sonata no. 3 in B minor, TWV 41:h1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c94298b1-edc4-4856-a2dd-94e24745c138'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d09a7b-a084-4766-b35a-172a64d885c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8', 4, NULL, 'G장조', 'Sonata no. 4 in G, TWV 41:G1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e430a651-62fe-49ab-87e3-dd6cd952689a', 1, 'I', 'Largo', 'Sonata no. 4 in G, TWV 41:G1: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e430a651-62fe-49ab-87e3-dd6cd952689a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34346a47-6851-4832-9e20-e774b7205f83', 2, 'II', 'Allegro', 'Sonata no. 4 in G, TWV 41:G1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34346a47-6851-4832-9e20-e774b7205f83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d6d547e-3de8-497f-b6fd-5912c8f2a13a', 3, 'III', 'Adagio', 'Sonata no. 4 in G, TWV 41:G1: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6d547e-3de8-497f-b6fd-5912c8f2a13a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a46aa5b-eed7-41ec-aec8-761e5145e2bd', 4, 'IV', 'Allegro', 'Sonata no. 4 in G, TWV 41:G1: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07c93c53-788f-49ef-9f45-3c7d8252f7b8'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a46aa5b-eed7-41ec-aec8-761e5145e2bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57', 5, NULL, 'A단조', 'Sonata no. 5 in A minor, TWV 41:a1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a81d4a72-07b5-41f7-bc8d-a9b4e5ac6d99', 1, 'I', 'Allemanda, Largo', 'Sonata no. 5 in A minor, TWV 41:a1: I. Allemanda, Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a81d4a72-07b5-41f7-bc8d-a9b4e5ac6d99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:613622ed-0f69-4ade-bc30-4a6de0e65a9f', 2, 'II', 'Corrente, Vivace', 'Sonata no. 5 in A minor, TWV 41:a1: II. Corrente, Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:613622ed-0f69-4ade-bc30-4a6de0e65a9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f07a44e-9eac-4b31-b03f-7720f0581e35', 3, 'III', 'Sarabanda', 'Sonata no. 5 in A minor, TWV 41:a1: III. Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f07a44e-9eac-4b31-b03f-7720f0581e35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1f88750-2af1-44b1-81bf-c53a3abd371c', 4, 'IV', 'Giga', 'Sonata no. 5 in A minor, TWV 41:a1: IV. Giga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b169be5a-2189-4194-a2ae-a7c9794c8a57'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f88750-2af1-44b1-81bf-c53a3abd371c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24', 6, NULL, 'A장조', 'Sonata no. 6 in A, TWV 41:A1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5fef4ee-502e-4c57-b156-084ad53ecb8c', 1, 'I', 'Allemanda, Largo', 'Sonata no. 6 in A, TWV 41:A1: I. Allemanda, Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5fef4ee-502e-4c57-b156-084ad53ecb8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16e91ffd-627f-47eb-9f27-1a532716997c', 2, 'II', 'Corrente, Allegro', 'Sonata no. 6 in A, TWV 41:A1: II. Corrente, Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e91ffd-627f-47eb-9f27-1a532716997c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f73ce9f-0974-47a2-85fa-ed7ce0990d9e', 3, 'III', 'Sarabanda', 'Sonata no. 6 in A, TWV 41:A1: III. Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f73ce9f-0974-47a2-85fa-ed7ce0990d9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d390413-8031-4abe-8045-69f5414294fc', 4, 'IV', 'Giga', 'Sonata no. 6 in A, TWV 41:A1: IV. Giga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d98e510-c60e-40eb-94d8-716fd0822a24'
WHERE p.composer_id = 11 AND p.title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d390413-8031-4abe-8045-69f5414294fc'
);


-- TWV 40:101–106 베이스 없는 6개의 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베이스 없는 6개의 소나타', 'Sonates sans basse à deux Flutes traverses ou à deux Violons ou à deux Flutes à bec', 'album', 'TWV 40:101–106', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베이스 없는 6개의 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a1965d-0713-459a-86c9-17bba711385c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5a1965d-0713-459a-86c9-17bba711385c'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a1965d-0713-459a-86c9-17bba711385c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb', 1, NULL, 'B♭장조', 'Sonata for two recorders no. 2 in B-flat major, TWV 40:101', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:960ad1a2-5fab-4483-9033-d41eb924d805', 1, 'I', 'Soave', 'Sonata for two recorders no. 2 in B-flat major, TWV 40:101: I. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:960ad1a2-5fab-4483-9033-d41eb924d805'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ae71f73-b884-44c8-b142-1f3543df8f23', 2, 'II', 'Allegro', 'Sonata for two recorders no. 2 in B-flat major, TWV 40:101: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae71f73-b884-44c8-b142-1f3543df8f23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac44c68b-2774-443a-9121-1d748dfcd514', 3, 'III', 'Andante', 'Sonata for two recorders no. 2 in B-flat major, TWV 40:101: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac44c68b-2774-443a-9121-1d748dfcd514'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:778bbb17-3874-4279-9939-78790bd95d6a', 4, 'IV', 'Allegro', 'Sonata for two recorders no. 2 in B-flat major, TWV 40:101: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:700d519c-ad19-47cb-b44b-33b8f6d3bfbb'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:778bbb17-3874-4279-9939-78790bd95d6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3', 2, NULL, 'F장조', 'Sonata for two recorders no. 1 in F major, TWV 40:102', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e41b55fd-2377-421f-8494-56960496a9d5', 1, 'I', 'Dolce', 'Sonata for two recorders no. 1 in F major, TWV 40:102: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e41b55fd-2377-421f-8494-56960496a9d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a22b3df4-cf07-4a7d-b56f-b10e87b48efa', 2, 'II', 'Allegro', 'Sonata for two recorders no. 1 in F major, TWV 40:102: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a22b3df4-cf07-4a7d-b56f-b10e87b48efa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6118d718-5c3e-4fda-854b-c06f0f23b178', 3, 'III', 'Largo', 'Sonata for two recorders no. 1 in F major, TWV 40:102: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6118d718-5c3e-4fda-854b-c06f0f23b178'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b37d87df-9132-4602-886e-e0eb5414ef55', 4, 'IV', 'Vivace', 'Sonata for two recorders no. 1 in F major, TWV 40:102: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce87fd7e-d681-4c71-a9c4-822dbfff8ae3'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b37d87df-9132-4602-886e-e0eb5414ef55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4', 3, NULL, 'C장조', 'Sonata for two recorders no. 3 in C major, TWV 40:103', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e33fb1d6-56ca-464b-b496-4b55c3f3b01d', 1, 'I', 'Siciliana', 'Sonata for two recorders no. 3 in C major, TWV 40:103: I. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e33fb1d6-56ca-464b-b496-4b55c3f3b01d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69f73d9d-5fac-4df7-b457-4ec3d15bc7fd', 2, 'II', 'Vivace', 'Sonata for two recorders no. 3 in C major, TWV 40:103: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f73d9d-5fac-4df7-b457-4ec3d15bc7fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97be4eb6-a856-4e02-9195-c212b4886c13', 3, 'III', 'Andante', 'Sonata for two recorders no. 3 in C major, TWV 40:103: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97be4eb6-a856-4e02-9195-c212b4886c13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:505cdcd0-d9bc-4a08-8a99-bac669ce6831', 4, 'IV', 'Allegro', 'Sonata for two recorders no. 3 in C major, TWV 40:103: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0d8f38e-26b2-4962-bac1-e079e0e7d3a4'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505cdcd0-d9bc-4a08-8a99-bac669ce6831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40', 4, NULL, 'G단조', 'Sonata for two recorders no. 4 in G minor, TWV 40:104', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e305d54-0512-4de6-9fe9-1bfc9ad7f81e', 1, 'I', 'Largo', 'Sonata for two recorders no. 4 in G minor, TWV 40:104: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e305d54-0512-4de6-9fe9-1bfc9ad7f81e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb73d4c4-f39f-49c0-b4bd-037017540d3a', 2, 'II', 'Allegro', 'Sonata for two recorders no. 4 in G minor, TWV 40:104: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb73d4c4-f39f-49c0-b4bd-037017540d3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e6db2bb-2141-48fc-a6f9-809b1ee54c7e', 3, 'III', 'Affettuoso', 'Sonata for two recorders no. 4 in G minor, TWV 40:104: III. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e6db2bb-2141-48fc-a6f9-809b1ee54c7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:232aba65-6968-4949-8e15-d8de89781ded', 4, 'IV', 'Vivace', 'Sonata for two recorders no. 4 in G minor, TWV 40:104: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36fde5a4-54b0-4205-8b6e-4ba390ef6b40'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:232aba65-6968-4949-8e15-d8de89781ded'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672', 5, NULL, 'B단조', 'Sonata no. 5 in B minor, TWV 40:105', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73267fa3-b956-4960-91f1-ca237fbaef2b', 1, 'I', 'Siciliano', 'Sonata no. 5 in B minor, TWV 40:105: I. Siciliano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73267fa3-b956-4960-91f1-ca237fbaef2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7238daee-89bf-4391-98e4-8566ac5cae04', 2, 'II', 'Vivace', 'Sonata no. 5 in B minor, TWV 40:105: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7238daee-89bf-4391-98e4-8566ac5cae04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd3c0141-03b2-41c3-9f75-583b0ac6050b', 3, 'III', 'Gratioso', 'Sonata no. 5 in B minor, TWV 40:105: III. Gratioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd3c0141-03b2-41c3-9f75-583b0ac6050b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae176801-c62b-49f1-b476-f33c7a8e80f8', 4, 'IV', 'Allegro', 'Sonata no. 5 in B minor, TWV 40:105: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef3536a5-5b0b-43fe-9a85-0cc08dac5672'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae176801-c62b-49f1-b476-f33c7a8e80f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07', 6, NULL, 'G장조', 'Sonata for two recorders no. 6 in G major, TWV 40:106', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae2f80ec-91f0-4ddb-a809-243d6ead063b', 1, 'I', 'Affettuoso', 'Sonata for two recorders no. 6 in G major, TWV 40:106: I. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae2f80ec-91f0-4ddb-a809-243d6ead063b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:651a5e8a-9034-4208-942c-d024a5c46353', 2, 'II', 'Presto', 'Sonata for two recorders no. 6 in G major, TWV 40:106: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:651a5e8a-9034-4208-942c-d024a5c46353'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02d5a54a-1567-4439-9303-c29b40f9d68a', 3, 'III', 'Soave', 'Sonata for two recorders no. 6 in G major, TWV 40:106: III. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d5a54a-1567-4439-9303-c29b40f9d68a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11d5a4d9-fc39-4a9d-934a-e14a5af905d9', 4, 'IV', 'Spirituoso', 'Sonata for two recorders no. 6 in G major, TWV 40:106: IV. Spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0554915-e71e-4bb2-9a74-b2a886c95c07'
WHERE p.composer_id = 11 AND p.title = '베이스 없는 6개의 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11d5a4d9-fc39-4a9d-934a-e14a5af905d9'
);


-- TWV 40:2–13 무반주 플루트를 위한 12개의 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 플루트를 위한 12개의 환상곡', '12 Fantasias for Flute without Bass, TWV 40:2-13', 'album', 'TWV 40:2–13', NULL, NULL, 1733, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 플루트를 위한 12개의 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b77958-aa1e-4e71-9427-17c45476b88b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38b77958-aa1e-4e71-9427-17c45476b88b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b77958-aa1e-4e71-9427-17c45476b88b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea00c09-3064-4ee7-b6fa-740f74eee0ec', 1, NULL, 'A장조', 'Fantasia no. 1 in A major, TWV 40:2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea00c09-3064-4ee7-b6fa-740f74eee0ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f47a498-3b3b-3a01-b891-5f2effacbc5f', 1, 'I', 'Vivace', 'Fantasia 1 in A major, TWV 40:2: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ea00c09-3064-4ee7-b6fa-740f74eee0ec'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f47a498-3b3b-3a01-b891-5f2effacbc5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d988b7bc-385e-383d-990b-1f8b75e114d8', 2, 'II', 'Allegro', 'Fantasia 1 in A major, TWV 40:2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ea00c09-3064-4ee7-b6fa-740f74eee0ec'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d988b7bc-385e-383d-990b-1f8b75e114d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0', 2, NULL, 'A단조', 'Fantasia no. 2 in A minor, TWV 40:3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90c6a2ec-db53-3077-ba1b-ba33ccac98ef', 1, 'I', 'Grave', 'Fantasia no. 2 in A minor, TWV 40:3: I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c6a2ec-db53-3077-ba1b-ba33ccac98ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8d4847a-0cc3-4b5b-8b6a-a4c7bdc466f6', 2, 'II', 'Vivace', 'Fantasia no. 2 in A minor, TWV 40:3: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8d4847a-0cc3-4b5b-8b6a-a4c7bdc466f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2876d7e5-5f27-39eb-984a-ce978daac1ad', 3, 'III', 'Adagio', 'Fantasia no. 2 in A minor, TWV 40:3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2876d7e5-5f27-39eb-984a-ce978daac1ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f69c68b5-b254-3a67-a604-cba74d001797', 4, 'IV', 'Allegro', 'Fantasia no. 2 in A minor, TWV 40:3: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70ff576-aae0-4479-bbc3-81429d96dae0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69c68b5-b254-3a67-a604-cba74d001797'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1edf5aad-6625-4e81-b11a-896bc309e95a', 3, NULL, 'B단조', 'Fantasia no. 3 in B minor, TWV 40:4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1edf5aad-6625-4e81-b11a-896bc309e95a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ea068f7-6efb-3361-858a-d45f7040b701', 1, 'I', 'Largo - Vivace', 'Fantasia no. 3 in B minor, TWV 40:4: I. Largo - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1edf5aad-6625-4e81-b11a-896bc309e95a'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea068f7-6efb-3361-858a-d45f7040b701'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0155011-ae35-3561-9328-ae6be4a2300c', 2, 'II', 'Allegro', 'Fantasia no. 3 in B minor, TWV 40:4: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1edf5aad-6625-4e81-b11a-896bc309e95a'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0155011-ae35-3561-9328-ae6be4a2300c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02a09def-41ab-417f-a467-2ced766c79dc', 4, NULL, 'B♭장조', 'Fantasia no. 4 in B-flat major, TWV 40:5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02a09def-41ab-417f-a467-2ced766c79dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:844f703e-11d1-3f26-bf7f-71d916a588a1', 1, 'I', 'Andante', 'Fantasia no. 4 in B-flat major, TWV 40:5: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02a09def-41ab-417f-a467-2ced766c79dc'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:844f703e-11d1-3f26-bf7f-71d916a588a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eebbc2f8-77f9-3156-8fc9-5f18896b90b8', 2, 'II', 'Allegro', 'Fantasia no. 4 in B-flat major, TWV 40:5: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02a09def-41ab-417f-a467-2ced766c79dc'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eebbc2f8-77f9-3156-8fc9-5f18896b90b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:115d7c07-d0d5-367d-a3e2-c7000584203a', 3, 'III', 'Presto', 'Fantasia no. 4 in B-flat major, TWV 40:5: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02a09def-41ab-417f-a467-2ced766c79dc'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:115d7c07-d0d5-367d-a3e2-c7000584203a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2754c912-c331-422a-9e40-9ba40d9c68c1', 5, NULL, 'C장조', 'Fantasia no. 5 in C major, TWV 40:6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2754c912-c331-422a-9e40-9ba40d9c68c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9b99eee-6523-4178-90ef-a4a42d5961b6', 1, 'I', 'Presto. Largo. Presto. Largo', 'Fantasia no. 5 in C major, TWV 40:6: I. Presto. Largo. Presto. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2754c912-c331-422a-9e40-9ba40d9c68c1'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9b99eee-6523-4178-90ef-a4a42d5961b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc47cce9-81d5-43dd-b703-983067099782', 2, 'II', 'Allegro', 'Fantasia no. 5 in C major, TWV 40:6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2754c912-c331-422a-9e40-9ba40d9c68c1'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc47cce9-81d5-43dd-b703-983067099782'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dba88481-383f-4ef1-b773-ac5c636860ac', 3, 'III', 'Allegro', 'Fantasia no. 5 in C major, TWV 40:6: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2754c912-c331-422a-9e40-9ba40d9c68c1'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba88481-383f-4ef1-b773-ac5c636860ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9554b9af-6c23-4b6f-bc5f-a99b9ed7ece0', 6, NULL, 'D단조', 'Fantasia no. 6 in D minor, TWV 40:7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9554b9af-6c23-4b6f-bc5f-a99b9ed7ece0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab8a1173-21f9-3bfd-88d6-1853a3da7258', 1, 'I', 'Dolce', 'Fantasia no. 6 in D minor, TWV 40:7: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9554b9af-6c23-4b6f-bc5f-a99b9ed7ece0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab8a1173-21f9-3bfd-88d6-1853a3da7258'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2a4d178-51a9-3663-930f-94f5e2bac2eb', 2, 'II', 'Allegro', 'Fantasia no. 6 in D minor, TWV 40:7: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9554b9af-6c23-4b6f-bc5f-a99b9ed7ece0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2a4d178-51a9-3663-930f-94f5e2bac2eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2510f5b-6192-399f-9dc1-94d6cf816e85', 3, 'III', 'Spirituoso', 'Fantasia no. 6 in D minor, TWV 40:7: III. Spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9554b9af-6c23-4b6f-bc5f-a99b9ed7ece0'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2510f5b-6192-399f-9dc1-94d6cf816e85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f698b0-a6fd-488e-8aff-359df49883ea', 7, NULL, 'D장조', 'Fantasia no. 7 in D major, TWV 40:8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f698b0-a6fd-488e-8aff-359df49883ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52b1b296-9d9f-39c0-a186-4b94fbd00bf1', 1, 'I', 'Alla Francese', 'Fantasia no. 7 in D major, TWV 40:8: I. Alla Francese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80f698b0-a6fd-488e-8aff-359df49883ea'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b1b296-9d9f-39c0-a186-4b94fbd00bf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbc61026-676d-3b4f-bb69-1e174e1176d2', 2, 'II', 'Presto', 'Fantasia no. 7 in D major, TWV 40:8: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80f698b0-a6fd-488e-8aff-359df49883ea'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc61026-676d-3b4f-bb69-1e174e1176d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e8535e4-e0ad-490b-abb7-d099acbdb071', 8, NULL, 'E단조', 'Fantasia no. 8 in E minor, TWV 40:9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e8535e4-e0ad-490b-abb7-d099acbdb071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc819394-ae8d-3dcb-8730-0ec2eb98279f', 1, 'I', 'Largo', 'Fantasia no. 8 in E minor, TWV 40:9: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e8535e4-e0ad-490b-abb7-d099acbdb071'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc819394-ae8d-3dcb-8730-0ec2eb98279f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdf7a1f5-9c9d-37bb-b0ae-84d1bcdc87b4', 2, 'II', 'Spirituoso', 'Fantasia no. 8 in E minor, TWV 40:9: II. Spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e8535e4-e0ad-490b-abb7-d099acbdb071'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdf7a1f5-9c9d-37bb-b0ae-84d1bcdc87b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c3e448f-f6c0-3b3a-803f-e189520457b3', 3, 'III', 'Allegro', 'Fantasia no. 8 in E minor, TWV 40:9: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e8535e4-e0ad-490b-abb7-d099acbdb071'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c3e448f-f6c0-3b3a-803f-e189520457b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c444a617-e0bd-4c93-a4f9-af8ad76dc80c', 9, NULL, 'E장조', 'Fantasia no. 9 in E major, TWV 40:10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c444a617-e0bd-4c93-a4f9-af8ad76dc80c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0077a597-6337-3a5d-8b29-977aa5f5c22b', 1, 'I', 'Affettuoso', 'Fantasia no. 9 in E major, TWV 40:10: I. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c444a617-e0bd-4c93-a4f9-af8ad76dc80c'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0077a597-6337-3a5d-8b29-977aa5f5c22b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd8fb91e-ed63-39cd-a468-e47645573d85', 2, 'II', 'Allegro', 'Fantasia no. 9 in E major, TWV 40:10: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c444a617-e0bd-4c93-a4f9-af8ad76dc80c'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd8fb91e-ed63-39cd-a468-e47645573d85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03fe464d-6caf-3d41-b638-f18260f6ef6d', 3, 'III', 'Grave - Vivace', 'Fantasia no. 9 in E major, TWV 40:10: III. Grave - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c444a617-e0bd-4c93-a4f9-af8ad76dc80c'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03fe464d-6caf-3d41-b638-f18260f6ef6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d4f460-c84d-48b7-bd0d-d4ba38bc4bec', 10, NULL, 'F#단조', 'Fantasia no. 10 in F-sharp minor, TWV 40:11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d4f460-c84d-48b7-bd0d-d4ba38bc4bec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f451c70c-9eb4-338f-af88-995fb6cd7422', 1, 'I', 'A tempo giusto', 'Fantasia no. 10 in F-sharp minor, TWV 40:11: I. A tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72d4f460-c84d-48b7-bd0d-d4ba38bc4bec'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f451c70c-9eb4-338f-af88-995fb6cd7422'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9187e25a-fe06-33e5-8bf6-1f2aa722fea3', 2, 'II', 'Presto', 'Fantasia no. 10 in F-sharp minor, TWV 40:11: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72d4f460-c84d-48b7-bd0d-d4ba38bc4bec'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9187e25a-fe06-33e5-8bf6-1f2aa722fea3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c09d9554-ec20-379b-a774-30baec350405', 3, 'III', 'Moderato', 'Fantasia no. 10 in F-sharp minor, TWV 40:11: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72d4f460-c84d-48b7-bd0d-d4ba38bc4bec'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c09d9554-ec20-379b-a774-30baec350405'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:681cc9ba-192a-4f2c-8961-12b34b23c5e7', 11, NULL, 'G장조', 'Fantasia no. 11 in G major, TWV 40:12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:681cc9ba-192a-4f2c-8961-12b34b23c5e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a57a24bb-b307-3496-a0f0-5988ba2657f6', 1, 'I', 'Allegro', 'Fantasia no. 11 in G major, TWV 40:12: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:681cc9ba-192a-4f2c-8961-12b34b23c5e7'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a57a24bb-b307-3496-a0f0-5988ba2657f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e716dc6-99cd-303c-9cc3-1a9c2386dbcd', 2, 'II', 'Adagio – Vivace', 'Fantasia no. 11 in G major, TWV 40:12: II. Adagio – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:681cc9ba-192a-4f2c-8961-12b34b23c5e7'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e716dc6-99cd-303c-9cc3-1a9c2386dbcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1ac6625-d8d0-355a-92d1-bf337cbc865b', 3, 'III', 'Allegro', 'Fantasia no. 11 in G major, TWV 40:12: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:681cc9ba-192a-4f2c-8961-12b34b23c5e7'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ac6625-d8d0-355a-92d1-bf337cbc865b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08c74d1a-a3d7-4ba3-8570-c29b8809e0f5', 12, NULL, 'G단조', 'Fantasia no. 12 in G minor, TWV 40:13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08c74d1a-a3d7-4ba3-8570-c29b8809e0f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4a1ed00-3784-30f0-8623-41f3befed3e6', 1, 'I', 'Grave - Allegro', 'Fantasia no. 12 in G minor, TWV 40:13: I. Grave - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08c74d1a-a3d7-4ba3-8570-c29b8809e0f5'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a1ed00-3784-30f0-8623-41f3befed3e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66e711e0-afff-312c-bcf9-afa5a23eb099', 2, 'II', 'Presto', 'Fantasia no. 12 in G minor, TWV 40:13: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08c74d1a-a3d7-4ba3-8570-c29b8809e0f5'
WHERE p.composer_id = 11 AND p.title = '무반주 플루트를 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66e711e0-afff-312c-bcf9-afa5a23eb099'
);


-- TWV 40:14–25 무반주 바이올린을 위한 12개의 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 바이올린을 위한 12개의 환상곡', '12 Fantasias for Violin without Bass, TWV 40:14-25', 'album', 'TWV 40:14–25', NULL, NULL, 1735, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 바이올린을 위한 12개의 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fb90abe-398d-4589-b376-02ecd4d4dfcd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fb90abe-398d-4589-b376-02ecd4d4dfcd'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fb90abe-398d-4589-b376-02ecd4d4dfcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250', 1, NULL, 'B♭장조', 'Fantasia in B-flat major, TWV 40:14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f038fdbb-2b1c-42fd-a738-1e13db7cd564', 1, 'I', 'Largo', 'Fantasia in B-flat major, TWV 40:14: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f038fdbb-2b1c-42fd-a738-1e13db7cd564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecdbe9dd-60ed-4103-b511-b4e8527a1557', 2, 'II', 'Allegro', 'Fantasia in B-flat major, TWV 40:14: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecdbe9dd-60ed-4103-b511-b4e8527a1557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37ebbfd3-351a-42ac-a001-1f56dcf2195b', 3, 'III', 'Grave', 'Fantasia in B-flat major, TWV 40:14: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37ebbfd3-351a-42ac-a001-1f56dcf2195b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38ca3d9a-2aa5-4b2e-8409-6488e604621d', 4, 'IV', 'Allegro', 'Fantasia in B-flat major, TWV 40:14: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f4b6592-46b5-4dbd-8a9b-2ce35304a250'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38ca3d9a-2aa5-4b2e-8409-6488e604621d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18f3f53d-f9a6-4b40-a743-8e7d915d7565', 2, NULL, 'G장조', 'Fantasia in G major, TWV 40:15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f3f53d-f9a6-4b40-a743-8e7d915d7565'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f836d7fc-020b-413b-9353-e9903fb8c302', 1, 'I', 'Largo', 'Fantasia in G major, TWV 40:15: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18f3f53d-f9a6-4b40-a743-8e7d915d7565'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f836d7fc-020b-413b-9353-e9903fb8c302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b7960df-3dea-400a-adc7-ab1feda00498', 2, 'II', 'Allegro', 'Fantasia in G major, TWV 40:15: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18f3f53d-f9a6-4b40-a743-8e7d915d7565'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7960df-3dea-400a-adc7-ab1feda00498'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb525502-3190-4aa5-9a32-ea9c7d5421b6', 3, 'III', 'Allegro', 'Fantasia in G major, TWV 40:15: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18f3f53d-f9a6-4b40-a743-8e7d915d7565'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb525502-3190-4aa5-9a32-ea9c7d5421b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f60fa992-88b9-45dd-9a1a-342031ca73dd', 3, NULL, 'F단조', 'Fantasia in F minor, TWV 40:16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f60fa992-88b9-45dd-9a1a-342031ca73dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dd76eea-406b-4e7a-aa6d-a4a0f5d54049', 1, 'I', 'Adagio', 'Fantasia in F minor, TWV 40:16: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f60fa992-88b9-45dd-9a1a-342031ca73dd'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd76eea-406b-4e7a-aa6d-a4a0f5d54049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:236de617-5b0b-428f-9730-e577efab2669', 2, 'II', 'Presto', 'Fantasia in F minor, TWV 40:16: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f60fa992-88b9-45dd-9a1a-342031ca73dd'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236de617-5b0b-428f-9730-e577efab2669'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14f99a02-7d92-426f-aa01-73b5184858af', 3, 'III', 'Grave - Vivace', 'Fantasia in F minor, TWV 40:16: III. Grave - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f60fa992-88b9-45dd-9a1a-342031ca73dd'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f99a02-7d92-426f-aa01-73b5184858af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f882988-7f6a-4955-903f-204ffdacaeea', 4, NULL, 'D장조', 'Fantasia in D major, TWV 40:17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f882988-7f6a-4955-903f-204ffdacaeea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d78b8d07-1cd1-44a0-a682-4b8c0c0c77ee', 1, 'I', 'Vivace', 'Fantasia in D major, TWV 40:17: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f882988-7f6a-4955-903f-204ffdacaeea'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78b8d07-1cd1-44a0-a682-4b8c0c0c77ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92cde4d6-2a39-4d9a-9aba-0ceb92c6fafa', 2, 'II', 'Grave', 'Fantasia in D major, TWV 40:17: II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f882988-7f6a-4955-903f-204ffdacaeea'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92cde4d6-2a39-4d9a-9aba-0ceb92c6fafa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61b62664-3dbe-418f-9894-829a69cd2879', 3, 'III', 'Allegro', 'Fantasia in D major, TWV 40:17: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f882988-7f6a-4955-903f-204ffdacaeea'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b62664-3dbe-418f-9894-829a69cd2879'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9823a8da-1603-4496-93a1-385ca4ba287b', 5, NULL, 'A장조', 'Fantasia in A major, TWV 40:18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9823a8da-1603-4496-93a1-385ca4ba287b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aef1102a-2176-46a4-a475-67dcefc6af79', 1, 'I', 'Allegro - Presto - Allegro - Presto', 'Fantasia in A major, TWV 40:18: I. Allegro - Presto - Allegro - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9823a8da-1603-4496-93a1-385ca4ba287b'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aef1102a-2176-46a4-a475-67dcefc6af79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54497d39-4120-4197-9a94-0e696d572fe7', 2, 'II', 'Andante', 'Fantasia in A major, TWV 40:18: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9823a8da-1603-4496-93a1-385ca4ba287b'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54497d39-4120-4197-9a94-0e696d572fe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:629b029a-ac78-41d8-b34b-aa591ff5019e', 3, 'III', 'Allegro', 'Fantasia in A major, TWV 40:18: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9823a8da-1603-4496-93a1-385ca4ba287b'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:629b029a-ac78-41d8-b34b-aa591ff5019e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494', 6, NULL, 'E단조', 'Fantasia in E minor, TWV 40:19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12309620-0b98-4270-8a73-2d9fa0765903', 1, 'I', 'Grave', 'Fantasia in E minor, TWV 40:19: I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12309620-0b98-4270-8a73-2d9fa0765903'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b8f546c-6eb0-40df-aae4-ab546cc1431f', 2, 'II', 'Presto', 'Fantasia in E minor, TWV 40:19: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b8f546c-6eb0-40df-aae4-ab546cc1431f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83ee6c58-318d-4bd5-946e-f5dd124c921f', 3, 'III', 'Siciliana', 'Fantasia in E minor, TWV 40:19: III. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83ee6c58-318d-4bd5-946e-f5dd124c921f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7af31a79-b98d-4a79-a14a-9ee8b509c5f7', 4, 'IV', 'Allegro', 'Fantasia in E minor, TWV 40:19: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:895646a4-5c6c-4fdd-b882-34c282b97494'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7af31a79-b98d-4a79-a14a-9ee8b509c5f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302', 7, NULL, 'E♭장조', 'Fantasia in E-flat major, TWV 40:20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ff76167-8c5c-4927-b10c-25acb878bf89', 1, 'I', 'Dolce', 'Fantasia in E-flat major, TWV 40:20: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff76167-8c5c-4927-b10c-25acb878bf89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88519445-143f-4860-a029-9f9e9160022b', 2, 'II', 'Allegro', 'Fantasia in E-flat major, TWV 40:20: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88519445-143f-4860-a029-9f9e9160022b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0aa3e09-1ebd-42d2-97e3-c32c4992b326', 3, 'III', 'Largo', 'Fantasia in E-flat major, TWV 40:20: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0aa3e09-1ebd-42d2-97e3-c32c4992b326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6afa362d-e93b-4aa6-a5cd-071bd4779aea', 4, 'IV', 'Presto', 'Fantasia in E-flat major, TWV 40:20: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ab54709-4630-4119-952b-621d945cc302'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6afa362d-e93b-4aa6-a5cd-071bd4779aea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd21e4db-9106-4e3f-82b1-b8a7590d421f', 8, NULL, 'E장조', 'Fantasia in E major, TWV 40:21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd21e4db-9106-4e3f-82b1-b8a7590d421f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f6705cf-5d1d-4eda-82a9-7c4bb997bbc5', 1, 'I', 'Piacevolmente', 'Fantasia in E major, TWV 40:21: I. Piacevolmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd21e4db-9106-4e3f-82b1-b8a7590d421f'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f6705cf-5d1d-4eda-82a9-7c4bb997bbc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:466452d2-dce4-4a49-8d3a-7bdb3685baf8', 2, 'II', 'Spirituoso', 'Fantasia in E major, TWV 40:21: II. Spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd21e4db-9106-4e3f-82b1-b8a7590d421f'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:466452d2-dce4-4a49-8d3a-7bdb3685baf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04f2a556-886e-4672-bb86-f606d83d39ff', 3, 'III', 'Allegro', 'Fantasia in E major, TWV 40:21: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd21e4db-9106-4e3f-82b1-b8a7590d421f'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f2a556-886e-4672-bb86-f606d83d39ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d383fc9e-d93c-49c3-b75b-059efa33f2e5', 9, NULL, 'B단조', 'Fantasia in B minor, TWV 40:22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d383fc9e-d93c-49c3-b75b-059efa33f2e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca90be14-4e63-4c3b-8c3f-b7835393fe05', 1, 'I', 'Siciliana', 'Fantasia in B minor, TWV 40:22: I. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d383fc9e-d93c-49c3-b75b-059efa33f2e5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca90be14-4e63-4c3b-8c3f-b7835393fe05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd4d42c3-d4e6-4463-ba23-6b61549874d1', 2, 'II', 'Vivace', 'Fantasia in B minor, TWV 40:22: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d383fc9e-d93c-49c3-b75b-059efa33f2e5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4d42c3-d4e6-4463-ba23-6b61549874d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0db25ca-2883-4802-a56f-13caba5295a2', 3, 'III', 'Allegro', 'Fantasia in B minor, TWV 40:22: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d383fc9e-d93c-49c3-b75b-059efa33f2e5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0db25ca-2883-4802-a56f-13caba5295a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9620171-cdd1-4e12-a3f2-635018e353f5', 10, NULL, 'D장조', 'Fantasia in D major, TWV 40:23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9620171-cdd1-4e12-a3f2-635018e353f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dda6ee51-84d1-4ac0-b167-d4a4e4b32e66', 1, 'I', 'Presto', 'Fantasia in D major, TWV 40:23: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9620171-cdd1-4e12-a3f2-635018e353f5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dda6ee51-84d1-4ac0-b167-d4a4e4b32e66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc9ce48b-834d-4a05-8848-7ae004ea40db', 2, 'II', 'Largo', 'Fantasia in D major, TWV 40:23: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9620171-cdd1-4e12-a3f2-635018e353f5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9ce48b-834d-4a05-8848-7ae004ea40db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49cef774-b943-4c6c-8ccd-0733f0f20111', 3, 'III', 'Allegro', 'Fantasia in D major, TWV 40:23: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9620171-cdd1-4e12-a3f2-635018e353f5'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49cef774-b943-4c6c-8ccd-0733f0f20111'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb0294f0-9120-4e0e-9319-ad072fbfed3a', 11, NULL, 'F장조', 'Fantasia in F major, TWV 40:24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb0294f0-9120-4e0e-9319-ad072fbfed3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:310ea6d3-ddb0-4501-93d7-9afa6943424b', 1, 'I', 'Un poco vivace', 'Fantasia in F major, TWV 40:24: I. Un poco vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb0294f0-9120-4e0e-9319-ad072fbfed3a'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:310ea6d3-ddb0-4501-93d7-9afa6943424b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3afe3fee-f61b-4b10-a42d-b4391f691ab1', 2, 'II', 'Soave', 'Fantasia in F major, TWV 40:24: II. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb0294f0-9120-4e0e-9319-ad072fbfed3a'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3afe3fee-f61b-4b10-a42d-b4391f691ab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05a061f0-b62d-4218-aaca-931cd4f091d4', 3, 'III', 'Allegro', 'Fantasia in F major, TWV 40:24: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb0294f0-9120-4e0e-9319-ad072fbfed3a'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a061f0-b62d-4218-aaca-931cd4f091d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad99baca-3e16-4a36-b256-90786cd89a40', 12, NULL, 'A단조', 'Fantasia in A minor, TWV 40:25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad99baca-3e16-4a36-b256-90786cd89a40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10499aa6-daf6-4417-9fed-e614a26e2d39', 1, 'I', 'Moderato', 'Fantasia in A minor, TWV 40:25: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad99baca-3e16-4a36-b256-90786cd89a40'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10499aa6-daf6-4417-9fed-e614a26e2d39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a11b527e-c08e-4e7e-9636-be843037d703', 2, 'II', 'Vivace', 'Fantasia in A minor, TWV 40:25: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad99baca-3e16-4a36-b256-90786cd89a40'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11b527e-c08e-4e7e-9636-be843037d703'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:549df4a8-f356-4e61-a4ab-70e60f9dfcfc', 3, 'III', 'Presto', 'Fantasia in A minor, TWV 40:25: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad99baca-3e16-4a36-b256-90786cd89a40'
WHERE p.composer_id = 11 AND p.title = '무반주 바이올린을 위한 12개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:549df4a8-f356-4e61-a4ab-70e60f9dfcfc'
);


-- TWV 33:1–36 하프시코드를 위한 36개의 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드를 위한 36개의 환상곡', '36 Fantasias for harpsichord, TWV 33', 'album', 'TWV 33:1–36', NULL, NULL, 1733, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드를 위한 36개의 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffe5b9fd-61be-4ff9-8993-61ca89c7ae20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ffe5b9fd-61be-4ff9-8993-61ca89c7ae20'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffe5b9fd-61be-4ff9-8993-61ca89c7ae20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8843fbb9-389b-4a7f-b6ce-7a5336ed4e12', 1, NULL, 'D장조', '36 Fantasias for harpsichord, TWV 33: No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8843fbb9-389b-4a7f-b6ce-7a5336ed4e12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8df5888-7cee-4e15-a396-87b0c0353382', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 1 in D major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8843fbb9-389b-4a7f-b6ce-7a5336ed4e12'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8df5888-7cee-4e15-a396-87b0c0353382'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3238af0-a2b1-48d8-b88a-73a17739c01d', 2, 'II', 'Adagio', '36 Fantasias for harpsichord, TWV 33: No. 1 in D major: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8843fbb9-389b-4a7f-b6ce-7a5336ed4e12'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3238af0-a2b1-48d8-b88a-73a17739c01d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e389c6d-03a5-49fd-8a1a-3eee22b641c2', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 1 in D major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8843fbb9-389b-4a7f-b6ce-7a5336ed4e12'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e389c6d-03a5-49fd-8a1a-3eee22b641c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a62f3224-c854-44e5-8c95-8a1cd67b3511', 2, NULL, 'D단조', '36 Fantasias for harpsichord, TWV 33: No. 2 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a62f3224-c854-44e5-8c95-8a1cd67b3511'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ebfa2f4-dac3-468c-8fe0-636c5a94ff71', 1, 'I', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 2 in D minor: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a62f3224-c854-44e5-8c95-8a1cd67b3511'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebfa2f4-dac3-468c-8fe0-636c5a94ff71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9eab47d8-5448-469c-9246-b19c9a2957a1', 2, 'II', 'Adagio', '36 Fantasias for harpsichord, TWV 33: No. 2 in D minor: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a62f3224-c854-44e5-8c95-8a1cd67b3511'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eab47d8-5448-469c-9246-b19c9a2957a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:284480bb-3a17-4037-8b7e-59846761551a', 3, 'III', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 2 in D minor: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a62f3224-c854-44e5-8c95-8a1cd67b3511'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:284480bb-3a17-4037-8b7e-59846761551a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f3b7802-b020-4ecc-b64d-54533590c53a', 3, NULL, 'E장조', '36 Fantasias for harpsichord, TWV 33: No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f3b7802-b020-4ecc-b64d-54533590c53a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f996873-d352-40ff-bd07-d8e063c356ad', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 3 in E major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3b7802-b020-4ecc-b64d-54533590c53a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f996873-d352-40ff-bd07-d8e063c356ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f71c403-78c3-4258-b7b1-2f4d4403b667', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 3 in E major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3b7802-b020-4ecc-b64d-54533590c53a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f71c403-78c3-4258-b7b1-2f4d4403b667'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e905ad74-96a1-4cea-9ad8-a31f4fb64de7', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 3 in E major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3f3b7802-b020-4ecc-b64d-54533590c53a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e905ad74-96a1-4cea-9ad8-a31f4fb64de7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:031ddd36-cbee-451c-bced-5c58d3be25d2', 4, NULL, 'E단조', '36 Fantasias for harpsichord, TWV 33: No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031ddd36-cbee-451c-bced-5c58d3be25d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bfce900-df47-46aa-a5c6-e9e760d58502', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 4 in E minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:031ddd36-cbee-451c-bced-5c58d3be25d2'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bfce900-df47-46aa-a5c6-e9e760d58502'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d48d3ee-db88-4c98-8feb-5faed078a2fb', 2, 'II', 'Dolce', '36 Fantasias for harpsichord, TWV 33: No. 4 in E minor: II. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:031ddd36-cbee-451c-bced-5c58d3be25d2'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d48d3ee-db88-4c98-8feb-5faed078a2fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f0a915a-88e5-4e2b-976d-2e41f225361f', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 4 in E minor: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:031ddd36-cbee-451c-bced-5c58d3be25d2'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0a915a-88e5-4e2b-976d-2e41f225361f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6978c055-7221-4a1e-84c3-7925ebd23f70', 5, NULL, 'F장조', '36 Fantasias for harpsichord, TWV 33: No. 5 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6978c055-7221-4a1e-84c3-7925ebd23f70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13bc94b2-c9da-40f9-8341-85b6a613719c', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 5 in F major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6978c055-7221-4a1e-84c3-7925ebd23f70'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13bc94b2-c9da-40f9-8341-85b6a613719c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d46d5b8-a79a-44c2-9b4b-798ce6a7e2ef', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 5 in F major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6978c055-7221-4a1e-84c3-7925ebd23f70'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d46d5b8-a79a-44c2-9b4b-798ce6a7e2ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1acfb048-0e7d-47ca-8027-24d8542cd9e2', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 5 in F major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6978c055-7221-4a1e-84c3-7925ebd23f70'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acfb048-0e7d-47ca-8027-24d8542cd9e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9631133-bde9-46c1-ab5c-42718a1d8e9d', 6, NULL, 'F단조', '36 Fantasias for harpsichord, TWV 33: No. 6 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9631133-bde9-46c1-ab5c-42718a1d8e9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0737c04d-69ca-471b-a37d-dec845badb19', 1, 'I', 'Tempo di Minuetto', '36 Fantasias for harpsichord, TWV 33: No. 6 in F minor: I. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9631133-bde9-46c1-ab5c-42718a1d8e9d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0737c04d-69ca-471b-a37d-dec845badb19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b38f647a-be4b-4e66-bb84-e6bf7cdb97d6', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 6 in F minor: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9631133-bde9-46c1-ab5c-42718a1d8e9d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b38f647a-be4b-4e66-bb84-e6bf7cdb97d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31917a3a-45f5-4cf9-9e2d-7be0c4f69b7c', 3, 'III', 'Tempo di Minuetto', '36 Fantasias for harpsichord, TWV 33: No. 6 in F minor: III. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9631133-bde9-46c1-ab5c-42718a1d8e9d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31917a3a-45f5-4cf9-9e2d-7be0c4f69b7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbae4d45-efd2-4b71-b80b-edfbdfd52da0', 7, NULL, 'G장조', '36 Fantasias for harpsichord, TWV 33: No. 7 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbae4d45-efd2-4b71-b80b-edfbdfd52da0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9965f22-005c-4d31-9931-0f0200b4fb88', 1, 'I', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 7 in G major: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbae4d45-efd2-4b71-b80b-edfbdfd52da0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9965f22-005c-4d31-9931-0f0200b4fb88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16adf73b-7ae8-45d9-9e09-0d5693f0ae42', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 7 in G major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbae4d45-efd2-4b71-b80b-edfbdfd52da0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16adf73b-7ae8-45d9-9e09-0d5693f0ae42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1e90f0b-fe07-4424-a8de-3ce508eb42bf', 3, 'III', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 7 in G major: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbae4d45-efd2-4b71-b80b-edfbdfd52da0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e90f0b-fe07-4424-a8de-3ce508eb42bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c53cc41-f803-4cc0-96e7-b1ed4e5ee71a', 8, NULL, 'G단조', '36 Fantasias for harpsichord, TWV 33: No. 8 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c53cc41-f803-4cc0-96e7-b1ed4e5ee71a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb9d71b8-79ce-49f1-b8f4-e9c2a07a6e27', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 8 in G minor: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3c53cc41-f803-4cc0-96e7-b1ed4e5ee71a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb9d71b8-79ce-49f1-b8f4-e9c2a07a6e27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd40b667-db90-4bfa-960d-8beccb4e1b75', 2, 'II', 'Cantabile', '36 Fantasias for harpsichord, TWV 33: No. 8 in G minor: II. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3c53cc41-f803-4cc0-96e7-b1ed4e5ee71a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd40b667-db90-4bfa-960d-8beccb4e1b75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5adaee35-331c-4943-ad9e-8191c0174dcc', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 8 in G minor: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3c53cc41-f803-4cc0-96e7-b1ed4e5ee71a'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5adaee35-331c-4943-ad9e-8191c0174dcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2d0c736-1c8a-450a-9ef8-8a6c3fc1fecc', 9, NULL, 'A장조', '36 Fantasias for harpsichord, TWV 33: No. 9 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2d0c736-1c8a-450a-9ef8-8a6c3fc1fecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44b544f4-8061-4ad7-a82d-0a31b1e3a654', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 9 in A major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2d0c736-1c8a-450a-9ef8-8a6c3fc1fecc'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44b544f4-8061-4ad7-a82d-0a31b1e3a654'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2f1738d-7fec-4a07-a9ef-b846d05bae9f', 2, 'II', 'Grave', '36 Fantasias for harpsichord, TWV 33: No. 9 in A major: II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2d0c736-1c8a-450a-9ef8-8a6c3fc1fecc'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f1738d-7fec-4a07-a9ef-b846d05bae9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd2c25ac-e354-4ed9-bd61-ec2ba6e0b337', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 9 in A major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2d0c736-1c8a-450a-9ef8-8a6c3fc1fecc'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd2c25ac-e354-4ed9-bd61-ec2ba6e0b337'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff22273e-3deb-41cc-afd1-b355856003f8', 10, NULL, 'A단조', '36 Fantasias for harpsichord, TWV 33: No. 10 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff22273e-3deb-41cc-afd1-b355856003f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b66b1d79-2948-4b09-a00a-5d3d2ec5ff73', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 10 in A minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff22273e-3deb-41cc-afd1-b355856003f8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66b1d79-2948-4b09-a00a-5d3d2ec5ff73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f95c7d8-3a79-4cd5-89d7-162f398e244c', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 10 in A minor: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff22273e-3deb-41cc-afd1-b355856003f8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f95c7d8-3a79-4cd5-89d7-162f398e244c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:984916ff-50ab-4c6a-8e6b-bd2530f26ce8', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 10 in A minor: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff22273e-3deb-41cc-afd1-b355856003f8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984916ff-50ab-4c6a-8e6b-bd2530f26ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5418cb9-40d8-4df7-8ea9-14590e8d43cf', 11, NULL, 'B♭장조', '36 Fantasias for harpsichord, TWV 33: No. 11 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5418cb9-40d8-4df7-8ea9-14590e8d43cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45cf8d08-024d-4e92-91b8-5c5933375900', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 11 in B-flat major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5418cb9-40d8-4df7-8ea9-14590e8d43cf'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cf8d08-024d-4e92-91b8-5c5933375900'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a2ac180-d572-4c6b-8a26-abaf8d6e763f', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 11 in B-flat major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5418cb9-40d8-4df7-8ea9-14590e8d43cf'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a2ac180-d572-4c6b-8a26-abaf8d6e763f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a045f414-3dcb-48b5-a2ad-f73f37f2bab9', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 11 in B-flat major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5418cb9-40d8-4df7-8ea9-14590e8d43cf'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a045f414-3dcb-48b5-a2ad-f73f37f2bab9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cecdd26-18df-457c-aa9d-92586d983a7c', 12, NULL, 'E♭장조', '36 Fantasias for harpsichord, TWV 33: No. 12 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cecdd26-18df-457c-aa9d-92586d983a7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eee30888-74a5-4200-bf0b-3bc4cb8cf56e', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 12 in E-flat major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cecdd26-18df-457c-aa9d-92586d983a7c'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eee30888-74a5-4200-bf0b-3bc4cb8cf56e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edad28b9-c66e-4f96-8347-fb0fc5a01f40', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 12 in E-flat major: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cecdd26-18df-457c-aa9d-92586d983a7c'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edad28b9-c66e-4f96-8347-fb0fc5a01f40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af73027c-5bc2-488f-ae9f-7370f5646b0d', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 12 in E-flat major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4cecdd26-18df-457c-aa9d-92586d983a7c'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af73027c-5bc2-488f-ae9f-7370f5646b0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca', 13, NULL, 'C단조', '36 Fantasias for harpsichord, TWV 33: No. 13 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfebd03a-6a29-472d-a699-d6ce169d920d', 1, 'I', 'Tendrement', '36 Fantasias for harpsichord, TWV 33: No. 13 in C minor: I. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfebd03a-6a29-472d-a699-d6ce169d920d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:910c044e-0b43-45a2-b4ab-31991af11675', 2, 'II', 'Vivement', '36 Fantasias for harpsichord, TWV 33: No. 13 in C minor: II. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:910c044e-0b43-45a2-b4ab-31991af11675'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e25f60c0-9332-421f-a8b7-56ff385737b7', 3, 'III', 'Tendrement', '36 Fantasias for harpsichord, TWV 33: No. 13 in C minor: III. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e25f60c0-9332-421f-a8b7-56ff385737b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5998086a-234b-43b5-b347-3ababfaf386c', 4, 'IV', 'Très vite', '36 Fantasias for harpsichord, TWV 33: No. 13 in C minor: IV. Très vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7d904d2-38dd-4f96-a566-28594534c1ca'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5998086a-234b-43b5-b347-3ababfaf386c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096', 14, NULL, 'C장조', '36 Fantasias for harpsichord, TWV 33: No. 14 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25efcc74-5dc3-4dbd-8121-69958e13a13a', 1, 'I', 'Gravement', '36 Fantasias for harpsichord, TWV 33: No. 14 in C major: I. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25efcc74-5dc3-4dbd-8121-69958e13a13a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1b02318-b4cd-4079-b8c8-80608ec59376', 2, 'II', 'Gayment', '36 Fantasias for harpsichord, TWV 33: No. 14 in C major: II. Gayment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b02318-b4cd-4079-b8c8-80608ec59376'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1169570-9f07-495f-aa0f-973b9c91dac1', 3, 'III', 'Gravement', '36 Fantasias for harpsichord, TWV 33: No. 14 in C major: III. Gravement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1169570-9f07-495f-aa0f-973b9c91dac1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cde15df-a47a-4b61-8352-716eae3134cf', 4, 'IV', 'Allegrement', '36 Fantasias for harpsichord, TWV 33: No. 14 in C major: IV. Allegrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ba6a1f-2dba-4e01-9932-c2d815141096'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cde15df-a47a-4b61-8352-716eae3134cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5', 15, NULL, 'B단조', '36 Fantasias for harpsichord, TWV 33: No. 15 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b689571-a575-4867-8a4b-714f79effcbe', 1, 'I', 'Pompeusement', '36 Fantasias for harpsichord, TWV 33: No. 15 in B minor: I. Pompeusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b689571-a575-4867-8a4b-714f79effcbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e361e069-5d16-4d31-81c9-fef4fd55004b', 2, 'II', 'Allegrement', '36 Fantasias for harpsichord, TWV 33: No. 15 in B minor: II. Allegrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e361e069-5d16-4d31-81c9-fef4fd55004b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85af97cb-10ed-4b32-a645-d968996e2235', 3, 'III', 'Pompeusement', '36 Fantasias for harpsichord, TWV 33: No. 15 in B minor: III. Pompeusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85af97cb-10ed-4b32-a645-d968996e2235'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b4ac159-f7a4-487b-a4f8-a2ea9e9a80fb', 4, 'IV', 'Gayment', '36 Fantasias for harpsichord, TWV 33: No. 15 in B minor: IV. Gayment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e327e9e-6e41-4ebd-8fc1-d7d587081ba5'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4ac159-f7a4-487b-a4f8-a2ea9e9a80fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900', 16, NULL, 'D장조', '36 Fantasias for harpsichord, TWV 33: No. 16 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ed9ad7c-b4fc-443f-911a-a14337407039', 1, 'I', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 16 in D major: I. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ed9ad7c-b4fc-443f-911a-a14337407039'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1181bac4-3951-41e4-a56b-8acd74365172', 2, 'II', 'Vivement', '36 Fantasias for harpsichord, TWV 33: No. 16 in D major: II. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1181bac4-3951-41e4-a56b-8acd74365172'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e072793a-0ccb-46d1-aa3c-bbeef60e4d5e', 3, 'III', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 16 in D major: III. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e072793a-0ccb-46d1-aa3c-bbeef60e4d5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ec8aece-853b-4b1a-8c51-2dd25ab88003', 4, 'IV', 'Vite', '36 Fantasias for harpsichord, TWV 33: No. 16 in D major: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa03fa2e-c443-411a-8325-b8d0c2696900'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec8aece-853b-4b1a-8c51-2dd25ab88003'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d', 17, NULL, 'G단조', '36 Fantasias for harpsichord, TWV 33: No. 17 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79f5eca7-e068-43ef-959f-3456a2e9a6b8', 1, 'I', 'Melodieusement', '36 Fantasias for harpsichord, TWV 33: No. 17 in G minor: I. Melodieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79f5eca7-e068-43ef-959f-3456a2e9a6b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c90d112-6c84-4bbb-b6e6-94190cde9981', 2, 'II', 'Spirituellement', '36 Fantasias for harpsichord, TWV 33: No. 17 in G minor: II. Spirituellement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c90d112-6c84-4bbb-b6e6-94190cde9981'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5792080b-3311-4c9c-8f7e-dd48c01cec77', 3, 'III', 'Mélodieusement', '36 Fantasias for harpsichord, TWV 33: No. 17 in G minor: III. Mélodieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5792080b-3311-4c9c-8f7e-dd48c01cec77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8feecfc0-7cdf-4104-a3b1-ef69ab44347a', 4, 'IV', 'Vite', '36 Fantasias for harpsichord, TWV 33: No. 17 in G minor: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38f8e803-ac3d-4728-998e-edf7747fe72d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8feecfc0-7cdf-4104-a3b1-ef69ab44347a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865', 18, NULL, 'B♭장조', '36 Fantasias for harpsichord, TWV 33: No. 18 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e2a1caf-6856-4dbe-9fa5-a5734bf14311', 1, 'I', 'Tendrement', '36 Fantasias for harpsichord, TWV 33: No. 18 in B-flat major: I. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e2a1caf-6856-4dbe-9fa5-a5734bf14311'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d758006-69fd-423b-964e-d41a9ba1b167', 2, 'II', 'Gayment', '36 Fantasias for harpsichord, TWV 33: No. 18 in B-flat major: II. Gayment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d758006-69fd-423b-964e-d41a9ba1b167'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c18e8a3c-a8b6-45ec-9bef-136906751ce7', 3, 'III', 'Tendrement', '36 Fantasias for harpsichord, TWV 33: No. 18 in B-flat major: III. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18e8a3c-a8b6-45ec-9bef-136906751ce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4515e9f8-d5f3-4cde-b7b3-abffb54efca0', 4, 'IV', 'Vite', '36 Fantasias for harpsichord, TWV 33: No. 18 in B-flat major: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d7d2c70f-3801-4498-9271-c9a5dbb2f865'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4515e9f8-d5f3-4cde-b7b3-abffb54efca0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7', 19, NULL, 'A단조', '36 Fantasias for harpsichord, TWV 33: No. 19 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16e9ae01-d69c-476d-8a43-d3252d161ff9', 1, 'I', 'Lentement', '36 Fantasias for harpsichord, TWV 33: No. 19 in A minor: I. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e9ae01-d69c-476d-8a43-d3252d161ff9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fdfd179-d153-4d53-afcd-9bc69431b84e', 2, 'II', 'Allègrement', '36 Fantasias for harpsichord, TWV 33: No. 19 in A minor: II. Allègrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fdfd179-d153-4d53-afcd-9bc69431b84e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9286c961-e601-4db6-a451-b44aa54c3568', 3, 'III', 'Lentement', '36 Fantasias for harpsichord, TWV 33: No. 19 in A minor: III. Lentement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9286c961-e601-4db6-a451-b44aa54c3568'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f0dc1f3-4095-4d99-9864-0af8c4a1940f', 4, 'IV', 'Vivement', '36 Fantasias for harpsichord, TWV 33: No. 19 in A minor: IV. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a169cc55-420f-49e5-8e06-97136f0e26d7'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f0dc1f3-4095-4d99-9864-0af8c4a1940f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825', 20, NULL, 'A장조', '36 Fantasias for harpsichord, TWV 33: No. 20 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12a17a71-e325-40d9-8c44-2520c060e0d5', 1, 'I', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 20 in A major: I. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12a17a71-e325-40d9-8c44-2520c060e0d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9aac24da-41b3-4d74-b1c9-e5dd8d2d51ec', 2, 'II', 'Vite', '36 Fantasias for harpsichord, TWV 33: No. 20 in A major: II. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aac24da-41b3-4d74-b1c9-e5dd8d2d51ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e7e691f-48c0-4a5a-ab65-3236116d7e2d', 3, 'III', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 20 in A major: III. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e7e691f-48c0-4a5a-ab65-3236116d7e2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3da35e57-60a6-42d0-857b-60e929d591c7', 4, 'IV', 'Gayment', '36 Fantasias for harpsichord, TWV 33: No. 20 in A major: IV. Gayment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1473a32-c955-4183-9eef-546e24ac0825'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3da35e57-60a6-42d0-857b-60e929d591c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056', 21, NULL, 'E단조', '36 Fantasias for harpsichord, TWV 33: No. 21 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56c5129f-36b2-4c5e-ae98-dbb9c5d15c47', 1, 'I', 'I.-flateusement', '36 Fantasias for harpsichord, TWV 33: No. 21 in E minor: I.-flateusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c5129f-36b2-4c5e-ae98-dbb9c5d15c47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0509079-3706-497b-a4f2-138ef32c8df6', 2, 'II', 'Vivement', '36 Fantasias for harpsichord, TWV 33: No. 21 in E minor: II. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0509079-3706-497b-a4f2-138ef32c8df6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:310b817a-c257-4cd7-966b-16f26695876e', 3, 'III', 'III.-flateusement', '36 Fantasias for harpsichord, TWV 33: No. 21 in E minor: III.-flateusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:310b817a-c257-4cd7-966b-16f26695876e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72dbf32d-aecf-48f1-a857-43d393f50c59', 4, 'IV', 'Très vite', '36 Fantasias for harpsichord, TWV 33: No. 21 in E minor: IV. Très vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d33bbd1d-aa91-47f6-ad52-3f80b3407056'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72dbf32d-aecf-48f1-a857-43d393f50c59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee', 22, NULL, 'G장조', '36 Fantasias for harpsichord, TWV 33: No. 22 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01064c09-f984-433e-9183-026e73452b44', 1, 'I', 'Modérément', '36 Fantasias for harpsichord, TWV 33: No. 22 in G major: I. Modérément', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01064c09-f984-433e-9183-026e73452b44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:610a888b-f0ad-41be-9653-9e9458e0420c', 2, 'II', 'Vivement', '36 Fantasias for harpsichord, TWV 33: No. 22 in G major: II. Vivement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610a888b-f0ad-41be-9653-9e9458e0420c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36cea7d4-e6ba-445e-9a20-a15546a0acb8', 3, 'III', 'Modérément', '36 Fantasias for harpsichord, TWV 33: No. 22 in G major: III. Modérément', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36cea7d4-e6ba-445e-9a20-a15546a0acb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26bfd12a-8095-47eb-ae5b-e694b36791e6', 4, 'IV', 'Gayment', '36 Fantasias for harpsichord, TWV 33: No. 22 in G major: IV. Gayment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f68d5e22-3418-40aa-ab95-7d7661d1e6ee'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26bfd12a-8095-47eb-ae5b-e694b36791e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904', 23, NULL, 'G단조', '36 Fantasias for harpsichord, TWV 33: No. 23 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c68463d-4486-4317-bcce-cf194abedde0', 1, 'I', 'Pompeusement', '36 Fantasias for harpsichord, TWV 33: No. 23 in G minor: I. Pompeusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c68463d-4486-4317-bcce-cf194abedde0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05a7fe40-56db-43a6-a126-d5f762b48da2', 2, 'II', 'Allègrement', '36 Fantasias for harpsichord, TWV 33: No. 23 in G minor: II. Allègrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a7fe40-56db-43a6-a126-d5f762b48da2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0198fa7e-53c9-4363-a01c-c00cd648d05e', 3, 'III', 'Pompeusement', '36 Fantasias for harpsichord, TWV 33: No. 23 in G minor: III. Pompeusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0198fa7e-53c9-4363-a01c-c00cd648d05e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68fc32af-3d80-4c20-b2c9-082e6cbca8ca', 4, 'IV', 'Vite', '36 Fantasias for harpsichord, TWV 33: No. 23 in G minor: IV. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:279b58f6-f0cc-4ce4-93c5-9a6615f93904'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68fc32af-3d80-4c20-b2c9-082e6cbca8ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3', 24, NULL, 'B♭장조', '36 Fantasias for harpsichord, TWV 33: No. 24 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd7d30c4-e2f6-4169-84cd-1645cf474772', 1, 'I', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 24 in B-flat major: I. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd7d30c4-e2f6-4169-84cd-1645cf474772'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c26b861-6cd1-4493-b2b9-f15cdcba4643', 2, 'II', 'Gaillardement', '36 Fantasias for harpsichord, TWV 33: No. 24 in B-flat major: II. Gaillardement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c26b861-6cd1-4493-b2b9-f15cdcba4643'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00aa0cb9-8afd-4eff-a964-6835402eaa28', 3, 'III', 'Gratieusement', '36 Fantasias for harpsichord, TWV 33: No. 24 in B-flat major: III. Gratieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00aa0cb9-8afd-4eff-a964-6835402eaa28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26f66659-a5ab-4af9-b568-324a1faeb459', 4, 'IV', 'Vitement', '36 Fantasias for harpsichord, TWV 33: No. 24 in B-flat major: IV. Vitement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:586fe624-dd09-4b9f-a393-064b1a5823c3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26f66659-a5ab-4af9-b568-324a1faeb459'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40c58119-debd-4827-94a7-b2dc970e93b8', 25, NULL, 'F장조', '36 Fantasias for harpsichord, TWV 33: No. 25 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c58119-debd-4827-94a7-b2dc970e93b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69b199af-f3ee-4582-9340-09a66cac4814', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 25 in F major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40c58119-debd-4827-94a7-b2dc970e93b8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69b199af-f3ee-4582-9340-09a66cac4814'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a86c7753-7f72-487e-bf92-d2ce005ab243', 2, 'II', 'Tempo giusto', '36 Fantasias for harpsichord, TWV 33: No. 25 in F major: II. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40c58119-debd-4827-94a7-b2dc970e93b8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a86c7753-7f72-487e-bf92-d2ce005ab243'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0bfd4d90-39da-4a4e-9a13-55abfef50393', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 25 in F major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40c58119-debd-4827-94a7-b2dc970e93b8'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bfd4d90-39da-4a4e-9a13-55abfef50393'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63e1f1a8-7bfb-4455-9d5d-fc534fbf6a6d', 26, NULL, 'D단조', '36 Fantasias for harpsichord, TWV 33: No. 26 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63e1f1a8-7bfb-4455-9d5d-fc534fbf6a6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:171e7843-0a44-4c3d-a4db-906a4cdcbce3', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 26 in D minor: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63e1f1a8-7bfb-4455-9d5d-fc534fbf6a6d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:171e7843-0a44-4c3d-a4db-906a4cdcbce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d39362e4-c7d2-4e68-965e-66e408a98562', 2, 'II', 'Largo', '36 Fantasias for harpsichord, TWV 33: No. 26 in D minor: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63e1f1a8-7bfb-4455-9d5d-fc534fbf6a6d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d39362e4-c7d2-4e68-965e-66e408a98562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ec01e3a-ebaf-4cba-a3a3-187cc11e7cdb', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 26 in D minor: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63e1f1a8-7bfb-4455-9d5d-fc534fbf6a6d'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec01e3a-ebaf-4cba-a3a3-187cc11e7cdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bccc4a8e-5d70-460d-9a9c-f0461b9a9ae9', 27, NULL, 'E단조', '36 Fantasias for harpsichord, TWV 33: No. 27 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bccc4a8e-5d70-460d-9a9c-f0461b9a9ae9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20192ea6-8e23-4f4f-b238-443bfebe949d', 1, 'I', 'Tempo giusto', '36 Fantasias for harpsichord, TWV 33: No. 27 in E minor: I. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bccc4a8e-5d70-460d-9a9c-f0461b9a9ae9'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20192ea6-8e23-4f4f-b238-443bfebe949d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1454dca-4d15-4b95-b0b1-d697e8a93b0e', 2, 'II', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 27 in E minor: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bccc4a8e-5d70-460d-9a9c-f0461b9a9ae9'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1454dca-4d15-4b95-b0b1-d697e8a93b0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:245fae9c-94f1-4ba7-ba54-e1c507b46a19', 3, 'III', 'Tempo giusto', '36 Fantasias for harpsichord, TWV 33: No. 27 in E minor: III. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bccc4a8e-5d70-460d-9a9c-f0461b9a9ae9'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:245fae9c-94f1-4ba7-ba54-e1c507b46a19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ca6e750-07a8-444f-8ef9-7f3fd10c6a81', 28, NULL, 'G장조', '36 Fantasias for harpsichord, TWV 33: No. 28 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ca6e750-07a8-444f-8ef9-7f3fd10c6a81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:327322de-ba49-4e7f-96a2-b84fd9f66b04', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 28 in G major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ca6e750-07a8-444f-8ef9-7f3fd10c6a81'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:327322de-ba49-4e7f-96a2-b84fd9f66b04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fad8f7f0-275f-42ee-98ba-1c7676c6e1a8', 2, 'II', 'Dolce', '36 Fantasias for harpsichord, TWV 33: No. 28 in G major: II. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ca6e750-07a8-444f-8ef9-7f3fd10c6a81'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad8f7f0-275f-42ee-98ba-1c7676c6e1a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:389cd904-d056-473a-8017-208c9fc78712', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 28 in G major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ca6e750-07a8-444f-8ef9-7f3fd10c6a81'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389cd904-d056-473a-8017-208c9fc78712'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f1c573-4551-408c-a82e-17a7780c22b0', 29, NULL, 'G단조', '36 Fantasias for harpsichord, TWV 33: No. 29 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f1c573-4551-408c-a82e-17a7780c22b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0325bbf-976f-43b2-8aed-f8ea9f0815af', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 29 in G minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1f1c573-4551-408c-a82e-17a7780c22b0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0325bbf-976f-43b2-8aed-f8ea9f0815af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9e98545-e990-4627-8013-a23aa83d20d4', 2, 'II', 'Soave', '36 Fantasias for harpsichord, TWV 33: No. 29 in G minor: II. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1f1c573-4551-408c-a82e-17a7780c22b0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9e98545-e990-4627-8013-a23aa83d20d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41cd30fd-034a-4ebd-8a59-fcff5823ccb6', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 29 in G minor: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1f1c573-4551-408c-a82e-17a7780c22b0'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41cd30fd-034a-4ebd-8a59-fcff5823ccb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96b444d7-3379-49a1-84a9-2a47d0386fe1', 30, NULL, 'C단조', '36 Fantasias for harpsichord, TWV 33: No. 30 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96b444d7-3379-49a1-84a9-2a47d0386fe1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83184aea-f769-4379-ae3d-a7a02f0900ec', 1, 'I', 'Gratioso', '36 Fantasias for harpsichord, TWV 33: No. 30 in C minor: I. Gratioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96b444d7-3379-49a1-84a9-2a47d0386fe1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83184aea-f769-4379-ae3d-a7a02f0900ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8acea6d2-bdcf-4639-8801-05afe0d7a4be', 2, 'II', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 30 in C minor: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96b444d7-3379-49a1-84a9-2a47d0386fe1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8acea6d2-bdcf-4639-8801-05afe0d7a4be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae664690-69f3-4634-ab18-4572c28e88ad', 3, 'III', 'Gratioso', '36 Fantasias for harpsichord, TWV 33: No. 30 in C minor: III. Gratioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96b444d7-3379-49a1-84a9-2a47d0386fe1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae664690-69f3-4634-ab18-4572c28e88ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8815e824-c701-4f29-ab29-90871bcdb7e3', 31, NULL, 'A장조', '36 Fantasias for harpsichord, TWV 33: No. 31 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8815e824-c701-4f29-ab29-90871bcdb7e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:124da20f-5058-4a1c-9984-3b7caaf3e327', 1, 'I', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 31 in A major: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8815e824-c701-4f29-ab29-90871bcdb7e3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:124da20f-5058-4a1c-9984-3b7caaf3e327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41f54506-1395-4b78-8dc4-398008d9c2a3', 2, 'II', 'Arioso', '36 Fantasias for harpsichord, TWV 33: No. 31 in A major: II. Arioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8815e824-c701-4f29-ab29-90871bcdb7e3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41f54506-1395-4b78-8dc4-398008d9c2a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4acc2d41-9cf3-426f-a87f-8c7b7e32a95e', 3, 'III', 'Presto', '36 Fantasias for harpsichord, TWV 33: No. 31 in A major: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8815e824-c701-4f29-ab29-90871bcdb7e3'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4acc2d41-9cf3-426f-a87f-8c7b7e32a95e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4870d471-9d99-466c-b211-089170d2673e', 32, NULL, 'A단조', '36 Fantasias for harpsichord, TWV 33: No. 32 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4870d471-9d99-466c-b211-089170d2673e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a57410f0-bc6e-41ee-b2b2-64f3c0347f23', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 32 in A minor: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4870d471-9d99-466c-b211-089170d2673e'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a57410f0-bc6e-41ee-b2b2-64f3c0347f23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:532e2c07-1bbc-40bb-81b0-bfd58e03a48a', 2, 'II', 'Minuet', '36 Fantasias for harpsichord, TWV 33: No. 32 in A minor: II. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4870d471-9d99-466c-b211-089170d2673e'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:532e2c07-1bbc-40bb-81b0-bfd58e03a48a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cca5ea61-f4ed-415f-821f-c39a6664ae33', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 32 in A minor: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4870d471-9d99-466c-b211-089170d2673e'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca5ea61-f4ed-415f-821f-c39a6664ae33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9e2d72c-6d25-4d73-924f-74c140c9b405', 33, NULL, 'B단조', '36 Fantasias for harpsichord, TWV 33: No. 33 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e2d72c-6d25-4d73-924f-74c140c9b405'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a3dc9e4-bcec-4b6f-86d3-a8b23e4231c1', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 33 in B minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9e2d72c-6d25-4d73-924f-74c140c9b405'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3dc9e4-bcec-4b6f-86d3-a8b23e4231c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:815b2d12-efb9-4ee7-b0a1-506ff51ab998', 2, 'II', 'Con pompa', '36 Fantasias for harpsichord, TWV 33: No. 33 in B minor: II. Con pompa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9e2d72c-6d25-4d73-924f-74c140c9b405'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:815b2d12-efb9-4ee7-b0a1-506ff51ab998'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f284ea0-62eb-46fe-9fd5-5e914724e6bb', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 33 in B minor: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e9e2d72c-6d25-4d73-924f-74c140c9b405'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f284ea0-62eb-46fe-9fd5-5e914724e6bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e75e3ca-794a-409d-be6d-9ea7090a3798', 34, NULL, 'D장조', '36 Fantasias for harpsichord, TWV 33: No. 34 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e75e3ca-794a-409d-be6d-9ea7090a3798'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8ad6b40-e32d-48ad-b2b5-ea82f08674c0', 1, 'I', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 34 in D major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e75e3ca-794a-409d-be6d-9ea7090a3798'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ad6b40-e32d-48ad-b2b5-ea82f08674c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c77df277-487f-4fb6-b57b-1ec1d189ae3d', 2, 'II', 'Dolce', '36 Fantasias for harpsichord, TWV 33: No. 34 in D major: II. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e75e3ca-794a-409d-be6d-9ea7090a3798'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c77df277-487f-4fb6-b57b-1ec1d189ae3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abfc9a65-db1e-4f8a-83bf-8d0148856f40', 3, 'III', 'Allegro', '36 Fantasias for harpsichord, TWV 33: No. 34 in D major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e75e3ca-794a-409d-be6d-9ea7090a3798'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abfc9a65-db1e-4f8a-83bf-8d0148856f40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4568589-5dce-4121-8dfe-ab9f3d63bac1', 35, NULL, 'E♭장조', '36 Fantasias for harpsichord, TWV 33: No. 35 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4568589-5dce-4121-8dfe-ab9f3d63bac1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:989f2dda-3848-4b4e-bbff-bc53dffbb8bf', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 35 in E-flat major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4568589-5dce-4121-8dfe-ab9f3d63bac1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989f2dda-3848-4b4e-bbff-bc53dffbb8bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbd910dd-678e-4512-bdf0-dd23678ac811', 2, 'II', 'Moderato', '36 Fantasias for harpsichord, TWV 33: No. 35 in E-flat major: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4568589-5dce-4121-8dfe-ab9f3d63bac1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd910dd-678e-4512-bdf0-dd23678ac811'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fbb8508-5340-49d4-954c-e321fcbb152e', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 35 in E-flat major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4568589-5dce-4121-8dfe-ab9f3d63bac1'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fbb8508-5340-49d4-954c-e321fcbb152e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b26011-58a4-4acd-9166-76e1020a7435', 36, NULL, 'B♭장조', '36 Fantasias for harpsichord, TWV 33: No. 36 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b26011-58a4-4acd-9166-76e1020a7435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b15ae513-a2cf-4f23-824f-d572d8eb3878', 1, 'I', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 36 in B-flat major: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82b26011-58a4-4acd-9166-76e1020a7435'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b15ae513-a2cf-4f23-824f-d572d8eb3878'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcbb9147-f76f-4f17-91fe-e124695c4e4e', 2, 'II', 'Arioso', '36 Fantasias for harpsichord, TWV 33: No. 36 in B-flat major: II. Arioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82b26011-58a4-4acd-9166-76e1020a7435'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbb9147-f76f-4f17-91fe-e124695c4e4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee62ca15-36e1-415f-9a0f-d49b1d5c0714', 3, 'III', 'Vivace', '36 Fantasias for harpsichord, TWV 33: No. 36 in B-flat major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82b26011-58a4-4acd-9166-76e1020a7435'
WHERE p.composer_id = 11 AND p.title = '하프시코드를 위한 36개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee62ca15-36e1-415f-9a0f-d49b1d5c0714'
);


-- None 6개의 협주곡과 6개의 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 협주곡과 6개의 모음곡', '6 Concerts et 6 Suites pour le Clavessin et la Traversière, etc.', 'album', NULL, NULL, NULL, 1734, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 협주곡과 6개의 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94f156d5-bb4c-468b-845c-2ab4564b58ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94f156d5-bb4c-468b-845c-2ab4564b58ad'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94f156d5-bb4c-468b-845c-2ab4564b58ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a7fb229-e8f4-4b74-8e95-6be1b27d2497', 1, NULL, '협주곡 D장조', 'Concerto in D major, TWV 42:D6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a7fb229-e8f4-4b74-8e95-6be1b27d2497'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e', 2, NULL, '협주곡 G단조', 'Concerto No. 2 in G minor TWV 42:g2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:304017d0-f5ec-4d0f-b62d-8f421b67a9fc', 1, 'I', 'Largo', 'Concerto No. 2 in G minor TWV 42:g2: 1. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304017d0-f5ec-4d0f-b62d-8f421b67a9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d068bf1e-3e34-4249-9111-c417c97c8113', 2, 'II', 'Vivace', 'Concerto No. 2 in G minor TWV 42:g2: 2. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d068bf1e-3e34-4249-9111-c417c97c8113'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0667f305-0dd2-4d80-a817-abde90c9db55', 3, 'III', 'Soave', 'Concerto No. 2 in G minor TWV 42:g2: 3. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0667f305-0dd2-4d80-a817-abde90c9db55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0605b94c-114c-4fdb-8a11-f5137b40f48a', 4, 'IV', 'Vivace', 'Concerto No. 2 in G minor TWV 42:g2: 4. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:07b69f1d-4b3d-46a7-9c8c-68e28a20be6e'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0605b94c-114c-4fdb-8a11-f5137b40f48a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462', 3, NULL, '협주곡 A장조', 'Concerto in A major for traverse flute, harpsichord and continuo, TWV 42:A3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1cd0ca3a-9a2e-4975-91b3-b3533fad426c', 1, 'I', 'tempo giusto', 'Concerto in A major for traverse flute, harpsichord and continuo, TWV 42:A3: I. tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cd0ca3a-9a2e-4975-91b3-b3533fad426c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55cc66c9-7083-44ab-9df5-1f2faca20d4b', 2, 'II', 'Vivace', 'Concerto in A major for traverse flute, harpsichord and continuo, TWV 42:A3: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55cc66c9-7083-44ab-9df5-1f2faca20d4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a5cbdfe-c16d-4eea-91d5-cb57112724b3', 3, 'III', 'Adagio', 'Concerto in A major for traverse flute, harpsichord and continuo, TWV 42:A3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5cbdfe-c16d-4eea-91d5-cb57112724b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2c546dc-b15c-480c-b3f6-0a65b97301be', 4, 'IV', 'Presto', 'Concerto in A major for traverse flute, harpsichord and continuo, TWV 42:A3: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b7c94a-7215-40e4-a78b-35da8fd1b462'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c546dc-b15c-480c-b3f6-0a65b97301be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2d790a5-b854-4b5b-84b0-347226a06296', 4, NULL, '협주곡 E단조', 'Concerto in E minor, TWV 42:e3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2d790a5-b854-4b5b-84b0-347226a06296'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc243132-e991-4df3-a0fb-e11af4784149', 5, NULL, '협주곡 B단조', 'Concerto in B minor, TWV 42:h1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc243132-e991-4df3-a0fb-e11af4784149'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcdcfd5b-969f-4a26-bd88-26c1838b8fcb', 6, NULL, '협주곡 A단조', 'Concerto in A minor, TWV 42:a2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcdcfd5b-969f-4a26-bd88-26c1838b8fcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06a21ebb-666c-4ee9-b7f0-976069b141ed', 7, NULL, '모음곡 G장조', 'Suite in G major, TWV 42:G4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06a21ebb-666c-4ee9-b7f0-976069b141ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd003b37-7bef-46ea-8e0a-233eb411a3f2', 8, NULL, '모음곡 B♭장조', 'Suite in B-flat major, TWV 42:B2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd003b37-7bef-46ea-8e0a-233eb411a3f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5', 9, NULL, '모음곡 B단조', 'Suite in B minor, TWV 42:h2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e04b8cd8-3f60-4da3-b9f3-fe6b79526c64', 1, 'I', 'Soave / Allegro', 'Suite in B minor, TWV 42:h2: I. Soave / Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e04b8cd8-3f60-4da3-b9f3-fe6b79526c64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e97cc7e0-80fe-4593-b4e3-d233bde339b3', 2, 'II', 'Tempo di Menuet I / II', 'Suite in B minor, TWV 42:h2: II. Tempo di Menuet I / II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e97cc7e0-80fe-4593-b4e3-d233bde339b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e27cb976-42f7-4cbf-990c-b7a1249c3e62', 3, 'III', 'Vivace', 'Suite in B minor, TWV 42:h2: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e27cb976-42f7-4cbf-990c-b7a1249c3e62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7ae4a1d-d1de-452b-b3bd-aecd6c8d69f0', 4, 'IV', 'Presto', 'Suite in B minor, TWV 42:h2: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ae4a1d-d1de-452b-b3bd-aecd6c8d69f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e10631a7-7414-4f4f-bac4-e92fb86cf8f7', 5, 'V', 'Vivace', 'Suite in B minor, TWV 42:h2: V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10631a7-7414-4f4f-bac4-e92fb86cf8f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d14f1314-42c6-4b49-859c-ac59ac854acd', 6, 'VI', 'Allegro', 'Suite in B minor, TWV 42:h2: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14f1314-42c6-4b49-859c-ac59ac854acd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71789e7b-39d2-4174-beae-e9d22b29125b', 7, 'VII', 'Allegro', 'Suite in B minor, TWV 42:h2: VII. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d307c045-e006-413b-96dc-50dfa0e049c5'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71789e7b-39d2-4174-beae-e9d22b29125b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917e65a3-f147-4ee6-b48d-8bd6662c7623', 10, NULL, '모음곡 E장조', 'Suite in E major, TWV 42:E2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917e65a3-f147-4ee6-b48d-8bd6662c7623'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be', 11, NULL, '모음곡 A단조', 'Suite in A minor, TWV 42:a3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79e57c21-6980-42d3-9fa8-469ff3a87c85', 1, 'I', 'Largo - Vivace', 'Suite in A minor, TWV 42:a3: I. Largo - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e57c21-6980-42d3-9fa8-469ff3a87c85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ca130d6-ff63-4949-aee6-e2c3bfbccbe6', 2, 'II', 'Un poco vivace', 'Suite in A minor, TWV 42:a3: II. Un poco vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ca130d6-ff63-4949-aee6-e2c3bfbccbe6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b10b471-1c48-499b-b54c-f6254cefa5dc', 3, 'III', 'Andante', 'Suite in A minor, TWV 42:a3: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b10b471-1c48-499b-b54c-f6254cefa5dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1f9eb41-676e-421f-8317-200aff1ca1c8', 4, 'IV', 'Presto', 'Suite in A minor, TWV 42:a3: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f9eb41-676e-421f-8317-200aff1ca1c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1a147f9-e212-463b-966d-6d4ec18e47f1', 5, 'V', 'Un poco vivace', 'Suite in A minor, TWV 42:a3: V. Un poco vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a147f9-e212-463b-966d-6d4ec18e47f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e83f8c9-55ad-4d15-89dd-6c377ae8e49f', 6, 'VI', 'Vivace', 'Suite in A minor, TWV 42:a3: VI. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e83f8c9-55ad-4d15-89dd-6c377ae8e49f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:168adda2-6a25-47f0-bad9-0d9a32abb628', 7, 'VII', 'Allegro', 'Suite in A minor, TWV 42:a3: VII. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:11fee96e-1d8d-4c8b-97aa-1e8d28deb3be'
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:168adda2-6a25-47f0-bad9-0d9a32abb628'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ccf954c-19d9-4418-8f65-fc89072c1208', 12, NULL, '모음곡 D단조', 'Suite in D minor, TWV 42:d3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 협주곡과 6개의 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ccf954c-19d9-4418-8f65-fc89072c1208'
);


-- TWV 40:118–123 6개의 카논풍 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 카논풍 소나타', '6 Canonic Sonatas, TWV 40:118–123', 'album', 'TWV 40:118–123', NULL, NULL, 1738, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 카논풍 소나타'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77cb0fee-6802-40dc-a3b0-493698d7e925', 1, NULL, 'G장조', 'Canonic Duo no. 1 in G major, TWV 40:118', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77cb0fee-6802-40dc-a3b0-493698d7e925'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d756516-8eda-45ac-bc89-c653486f0d80', 1, 'I', 'Vivace', 'Canonic Duo no. 1 in G major, TWV 40:118: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:77cb0fee-6802-40dc-a3b0-493698d7e925'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d756516-8eda-45ac-bc89-c653486f0d80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91e27d65-05c8-4625-92c5-48762c45de23', 2, 'II', 'Adagio', 'Canonic Duo no. 1 in G major, TWV 40:118: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:77cb0fee-6802-40dc-a3b0-493698d7e925'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91e27d65-05c8-4625-92c5-48762c45de23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b43c01d-ce89-43b8-aab2-b8d9aead8f09', 3, 'III', 'Allegro', 'Canonic Duo no. 1 in G major, TWV 40:118: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:77cb0fee-6802-40dc-a3b0-493698d7e925'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b43c01d-ce89-43b8-aab2-b8d9aead8f09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5126db47-422a-46c6-a3b7-79d2f8caa1fa', 2, NULL, 'G단조', 'Canonic Duo no. 2 in G minor, TWV 40:119', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5126db47-422a-46c6-a3b7-79d2f8caa1fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9f651f6-f3b7-4572-b19c-52d185637de2', 1, 'I', 'Presto', 'Canonic Duo no. 2 in G minor, TWV 40:119: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5126db47-422a-46c6-a3b7-79d2f8caa1fa'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f651f6-f3b7-4572-b19c-52d185637de2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27efe300-0896-457f-93df-edc432a98716', 2, 'II', 'Largo', 'Canonic Duo no. 2 in G minor, TWV 40:119: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5126db47-422a-46c6-a3b7-79d2f8caa1fa'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27efe300-0896-457f-93df-edc432a98716'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c61c62ff-125b-4b3d-be49-d2ac3429ddee', 3, 'III', 'Vivace', 'Canonic Duo no. 2 in G minor, TWV 40:119: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5126db47-422a-46c6-a3b7-79d2f8caa1fa'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c61c62ff-125b-4b3d-be49-d2ac3429ddee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93917ba0-bc69-4892-87e0-01012ea1b618', 3, NULL, 'D장조', 'Canonic Duo no. 3 in D major, TWV 40:120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93917ba0-bc69-4892-87e0-01012ea1b618'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1074bf63-e641-4b43-9cec-39e4bc995440', 1, 'I', 'Spirituoso', 'Canonic Duo no. 3 in D major, TWV 40:120: I. Spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93917ba0-bc69-4892-87e0-01012ea1b618'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1074bf63-e641-4b43-9cec-39e4bc995440'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:308277c2-9ffa-4c2f-9cfc-a4b07bd44611', 2, 'II', 'Larghetto', 'Canonic Duo no. 3 in D major, TWV 40:120: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93917ba0-bc69-4892-87e0-01012ea1b618'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:308277c2-9ffa-4c2f-9cfc-a4b07bd44611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23697c03-079c-456c-abae-14e3526af936', 3, 'III', 'Allegro assai', 'Canonic Duo no. 3 in D major, TWV 40:120: III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93917ba0-bc69-4892-87e0-01012ea1b618'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23697c03-079c-456c-abae-14e3526af936'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a468fce-5965-4fed-95c7-37d8f1602ab8', 4, NULL, 'D단조', 'Canonic Duo no. 4 in D minor, TWV 40:121', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a468fce-5965-4fed-95c7-37d8f1602ab8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6d7dee4-d247-4377-864c-381ecf4ac68c', 1, 'I', 'Vivace ma moderato', 'Canonic Duo no. 4 in D minor, TWV 40:121: I. Vivace ma moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a468fce-5965-4fed-95c7-37d8f1602ab8'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6d7dee4-d247-4377-864c-381ecf4ac68c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:feda7647-4de3-452a-9de9-4ebaa54c2265', 2, 'II', 'Piacevole, non largo', 'Canonic Duo no. 4 in D minor, TWV 40:121: II. Piacevole, non largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a468fce-5965-4fed-95c7-37d8f1602ab8'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feda7647-4de3-452a-9de9-4ebaa54c2265'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a642350c-d0f7-4616-a4ec-9ab4debba11d', 3, 'III', 'Presto', 'Canonic Duo no. 4 in D minor, TWV 40:121: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a468fce-5965-4fed-95c7-37d8f1602ab8'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a642350c-d0f7-4616-a4ec-9ab4debba11d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:telemann:telemann-canon:5', 5, NULL, 'A장조', 'A장조', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:telemann:telemann-canon:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc9c985-5706-44b1-8266-a57efbe0b190', 6, NULL, 'A단조', 'Canonic Duo no. 6 in A minor, TWV 40:123', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc9c985-5706-44b1-8266-a57efbe0b190'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b85d21d8-ce91-41c1-9876-d1616cd78181', 1, 'I', 'Vivace', 'Canonic Duo no. 6 in A minor, TWV 40:123: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc9c985-5706-44b1-8266-a57efbe0b190'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b85d21d8-ce91-41c1-9876-d1616cd78181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ecb513a-c523-4654-a920-01bf1fe0d1e4', 2, 'II', 'Soave', 'Canonic Duo no. 6 in A minor, TWV 40:123: II. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc9c985-5706-44b1-8266-a57efbe0b190'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ecb513a-c523-4654-a920-01bf1fe0d1e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d0dec63-dcd4-4df7-a02e-aa4feddbc892', 3, 'III', 'Allegro assai', 'Canonic Duo no. 6 in A minor, TWV 40:123: III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5dc9c985-5706-44b1-8266-a57efbe0b190'
WHERE p.composer_id = 11 AND p.title = '6개의 카논풍 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0dec63-dcd4-4df7-a02e-aa4feddbc892'
);


-- None <음악 연습>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<음악 연습>', 'Essercizii musici', 'album', NULL, NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<음악 연습>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edd9053e-f0ac-4686-8b22-c5b3200bebd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'edd9053e-f0ac-4686-8b22-c5b3200bebd3'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'edd9053e-f0ac-4686-8b22-c5b3200bebd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899', 1, NULL, '바이올린 솔로 F장조', 'Essercizii Musici: Solo No. 1 for violin & continuo in F major, TWV 41:F4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e941e87-d2ce-4294-8367-f3368665feda', 1, 'I', 'Andante', 'Essercizii Musici: Solo No. 1 for violin & continuo in F major, TWV 41:F4: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e941e87-d2ce-4294-8367-f3368665feda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5ef7a7c-fc40-491d-8291-c41f41b0b94a', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 1 for violin & continuo in F major, TWV 41:F4: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ef7a7c-fc40-491d-8291-c41f41b0b94a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0c84b1c-4432-4d26-8346-3fb9b0849637', 3, 'III', 'Siciliano', 'Essercizii Musici: Solo No. 1 for violin & continuo in F major, TWV 41:F4: III. Siciliano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c84b1c-4432-4d26-8346-3fb9b0849637'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3acbce94-fa01-4ff8-9dd6-4eddf342d8df', 4, 'IV', 'Allegro', 'Essercizii Musici: Solo No. 1 for violin & continuo in F major, TWV 41:F4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:270c844c-df52-4f8c-8bb5-891167527899'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3acbce94-fa01-4ff8-9dd6-4eddf342d8df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087', 2, NULL, '리코더·오보에 트리오 C단조', 'Essercizii Musici: Trio No. 1 for recorder, oboe & continuo in C minor, TWV 42:c2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9041cf58-0ab3-420c-8be7-9ad3f94c7d24', 1, 'I', 'Largo', 'Essercizii Musici: Trio No. 1 for recorder, oboe & continuo in C minor, TWV 42:c2: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9041cf58-0ab3-420c-8be7-9ad3f94c7d24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb275568-b884-4c8c-b500-f79ab4d1bb09', 2, 'II', 'Vivace', 'Essercizii Musici: Trio No. 1 for recorder, oboe & continuo in C minor, TWV 42:c2: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb275568-b884-4c8c-b500-f79ab4d1bb09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3c9e32d-fedc-48bd-9b6c-d55837026137', 3, 'III', 'Andante', 'Essercizii Musici: Trio No. 1 for recorder, oboe & continuo in C minor, TWV 42:c2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3c9e32d-fedc-48bd-9b6c-d55837026137'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a56a3f84-a3c2-4059-aa3d-7a2297c6a446', 4, 'IV', 'Allegro', 'Essercizii Musici: Trio No. 1 for recorder, oboe & continuo in C minor, TWV 42:c2: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3302bcc7-cfd5-41a9-8be7-c865223e1087'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56a3f84-a3c2-4059-aa3d-7a2297c6a446'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0', 3, NULL, '플루트 솔로 D장조', 'Essercizii Musici: Solo No. 2 for flute & continuo in D major, TWV 41:D9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d11e9b4f-aef8-41f8-a3c1-61db45d64664', 1, 'I', 'Largo', 'Essercizii Musici: Solo No. 2 for flute & continuo in D major, TWV 41:D9: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11e9b4f-aef8-41f8-a3c1-61db45d64664'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb9d5d27-cc58-41d9-975c-e175e16c2b55', 2, 'II', 'Vivace', 'Essercizii Musici: Solo No. 2 for flute & continuo in D major, TWV 41:D9: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb9d5d27-cc58-41d9-975c-e175e16c2b55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b5d678e-131b-4465-8a04-68212f658066', 3, 'III', 'Dolce', 'Essercizii Musici: Solo No. 2 for flute & continuo in D major, TWV 41:D9: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b5d678e-131b-4465-8a04-68212f658066'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:014d26a0-e7f2-4e40-90b6-c8f36387f269', 4, 'IV', 'Allegro', 'Essercizii Musici: Solo No. 2 for flute & continuo in D major, TWV 41:D9: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ef9cb566-0d36-49a3-807f-d48d16354bc0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014d26a0-e7f2-4e40-90b6-c8f36387f269'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3', 4, NULL, '비올라 다 감바·하프시코드 트리오 G장조', 'Essercizii Musici: Trio No. 2 for viola da gamba, harpsichord & continuo in G major, TWV 42:G6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fee74fa8-779d-49c6-93a0-0b8e4c634799', 1, 'I', 'Andante', 'Essercizii Musici: Trio No. 2 for viola da gamba, harpsichord & continuo in G major, TWV 42:G6: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fee74fa8-779d-49c6-93a0-0b8e4c634799'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6d22d84-c61b-48ca-8ea8-bb27afcb9417', 2, 'II', 'Allegro', 'Essercizii Musici: Trio No. 2 for viola da gamba, harpsichord & continuo in G major, TWV 42:G6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6d22d84-c61b-48ca-8ea8-bb27afcb9417'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74b0935b-1eab-4a33-967b-0fb130386aa9', 3, 'III', 'Largo', 'Essercizii Musici: Trio No. 2 for viola da gamba, harpsichord & continuo in G major, TWV 42:G6: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b0935b-1eab-4a33-967b-0fb130386aa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd04e4bd-eb8d-49a0-814b-b906e8d55779', 4, 'IV', 'Presto', 'Essercizii Musici: Trio No. 2 for viola da gamba, harpsichord & continuo in G major, TWV 42:G6: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2b197529-f5fe-4f05-815a-a6b8cdff25c3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd04e4bd-eb8d-49a0-814b-b906e8d55779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a', 5, NULL, '비올라 다 감바 솔로 A단조', 'Essercizii Musici: Solo No. 3 for viola da gamba & continuo in A minor, TWV 41:a6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59148e63-3080-41e4-bbca-78a31b1b786f', 1, 'I', 'Largo', 'Essercizii Musici: Solo No. 3 for viola da gamba & continuo in A minor, TWV 41:a6: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59148e63-3080-41e4-bbca-78a31b1b786f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f58f5448-3e04-4305-af76-1777aa1dda80', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 3 for viola da gamba & continuo in A minor, TWV 41:a6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f58f5448-3e04-4305-af76-1777aa1dda80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:522b287c-1fd8-4377-82b7-e2fd76d14c83', 3, 'III', 'Soave', 'Essercizii Musici: Solo No. 3 for viola da gamba & continuo in A minor, TWV 41:a6: III. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522b287c-1fd8-4377-82b7-e2fd76d14c83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1f3cf4a-ff3f-4800-b1d9-99b037e3e0af', 4, 'IV', 'Allegro', 'Essercizii Musici: Solo No. 3 for viola da gamba & continuo in A minor, TWV 41:a6: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87b8fd0f-c8e2-4b54-9978-0f0b42ec977a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f3cf4a-ff3f-4800-b1d9-99b037e3e0af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3', 6, NULL, '바이올린·오보에 트리오 G단조', 'Essercizii Musici: Trio No. 3 for violin, oboe & continuo in G minor, TWV 42:g5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5978c7c-5052-42ba-88cd-f7ccf04c3001', 1, 'I', 'Mesto', 'Essercizii Musici: Trio No. 3 for violin, oboe & continuo in G minor, TWV 42:g5: I. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5978c7c-5052-42ba-88cd-f7ccf04c3001'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3281d72f-0f8e-4de2-b650-a3b507de8414', 2, 'II', 'Allegro', 'Essercizii Musici: Trio No. 3 for violin, oboe & continuo in G minor, TWV 42:g5: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3281d72f-0f8e-4de2-b650-a3b507de8414'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51f13cd2-6b63-4e5d-b4e0-c0bb99371963', 3, 'III', 'Andante - Largo - Andante', 'Essercizii Musici: Trio No. 3 for violin, oboe & continuo in G minor, TWV 42:g5: III. Andante - Largo - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f13cd2-6b63-4e5d-b4e0-c0bb99371963'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c89fc18b-3239-42b2-9f32-9598dd6b7424', 4, 'IV', 'Vivace', 'Essercizii Musici: Trio No. 3 for violin, oboe & continuo in G minor, TWV 42:g5: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcfcee96-dd4e-4116-b2a5-a8250b8935a3'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89fc18b-3239-42b2-9f32-9598dd6b7424'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829', 7, NULL, '리코더 솔로 D단조', 'Essercizii musici: VII. Sonata in d, TWV 41:d4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b678e17c-72e5-414e-8bce-671fcdadcc0f', 1, 'I', 'Affetuoso', 'Essercizii musici: VII. Sonata in d, TWV 41:d4: I. Affetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b678e17c-72e5-414e-8bce-671fcdadcc0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28452c01-6fd0-47e6-889e-d97c275459f0', 2, 'II', 'Presto', 'Essercizii musici: VII. Sonata in d, TWV 41:d4: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28452c01-6fd0-47e6-889e-d97c275459f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d7980f1-7062-40c9-92e9-1885f5efb04d', 3, 'III', 'Grave', 'Essercizii musici: VII. Sonata in d, TWV 41:d4: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7980f1-7062-40c9-92e9-1885f5efb04d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:774517ea-da51-44c2-b22e-b7251271266b', 4, 'IV', 'Allegro', 'Essercizii musici: VII. Sonata in d, TWV 41:d4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a79a96f3-035f-409c-9c19-b2a77b28e829'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774517ea-da51-44c2-b22e-b7251271266b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2', 8, NULL, '플루트·하프시코드 트리오 A장조', 'Essercizii Musici: Trio No. 4 for flute, harpsichord & continuo in A major, TWV 42:A6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b033c4b4-371c-4894-92e2-31bf73c5ec69', 1, 'I', 'Largo', 'Essercizii Musici: Trio No. 4 for flute, harpsichord & continuo in A major, TWV 42:A6: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b033c4b4-371c-4894-92e2-31bf73c5ec69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00533d90-62ca-43af-a587-5cbdbba037e7', 2, 'II', 'Allegro', 'Essercizii Musici: Trio No. 4 for flute, harpsichord & continuo in A major, TWV 42:A6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00533d90-62ca-43af-a587-5cbdbba037e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9da17ada-5323-4d5e-9f04-da5858eb34b7', 3, 'III', 'Largo', 'Essercizii Musici: Trio No. 4 for flute, harpsichord & continuo in A major, TWV 42:A6: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9da17ada-5323-4d5e-9f04-da5858eb34b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2593a52-fb26-408f-8eeb-19d3645981b7', 4, 'IV', 'Vivace', 'Essercizii Musici: Trio No. 4 for flute, harpsichord & continuo in A major, TWV 42:A6: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a06dc0e-2f53-4559-8558-65b71b7ce2e2'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2593a52-fb26-408f-8eeb-19d3645981b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee', 9, NULL, '오보에 솔로 B♭장조', 'Essercizii Musici: Solo No. 5 for oboe & continuo in B flat major, TWV 41:B6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b4b89d5-f2cf-44b8-8a5f-c7ade8618e8c', 1, 'I', 'Adagio', 'Essercizii Musici: Solo No. 5 for oboe & continuo in B flat major, TWV 41:B6: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4b89d5-f2cf-44b8-8a5f-c7ade8618e8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df78c480-7cb7-44f9-a566-41ce136dbb79', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 5 for oboe & continuo in B flat major, TWV 41:B6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df78c480-7cb7-44f9-a566-41ce136dbb79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ccfbfb75-1591-4024-8865-a2a640dd57b0', 3, 'III', 'Cantabile', 'Essercizii Musici: Solo No. 5 for oboe & continuo in B flat major, TWV 41:B6: III. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccfbfb75-1591-4024-8865-a2a640dd57b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05a5e11d-4fd0-4658-801e-beb33893aaac', 4, 'IV', 'Vivace', 'Essercizii Musici: Solo No. 5 for oboe & continuo in B flat major, TWV 41:B6: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac4f9aae-4953-49f6-ac5b-271cecab1fee'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a5e11d-4fd0-4658-801e-beb33893aaac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5', 10, NULL, '리코더·바이올린 트리오 A단조', 'Essercizii Musici: Trio No. 5 for recorder, violin & continuo in A minor, TWV 42:a4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f16b975-7719-4de0-82df-204ff59199ec', 1, 'I', 'Largo', 'Essercizii Musici: Trio No. 5 for recorder, violin & continuo in A minor, TWV 42:a4: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f16b975-7719-4de0-82df-204ff59199ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ece3198-e605-40eb-805e-37bce6c3859a', 2, 'II', 'Vivace', 'Essercizii Musici: Trio No. 5 for recorder, violin & continuo in A minor, TWV 42:a4: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ece3198-e605-40eb-805e-37bce6c3859a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8dd8e9be-4505-41bf-a965-59ac06afb93e', 3, 'III', 'Affettuoso', 'Essercizii Musici: Trio No. 5 for recorder, violin & continuo in A minor, TWV 42:a4: III. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd8e9be-4505-41bf-a965-59ac06afb93e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6edeb434-42cb-4216-a753-de8e461fb8f1', 4, 'IV', 'Allegro', 'Essercizii Musici: Trio No. 5 for recorder, violin & continuo in A minor, TWV 42:a4: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea9314eb-6737-4f9f-a570-63717f00daa5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6edeb434-42cb-4216-a753-de8e461fb8f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119', 11, NULL, '하프시코드 솔로 C장조', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b84b818-5d21-43d6-93ae-706f3f001203', 1, 'I', 'Largo', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b84b818-5d21-43d6-93ae-706f3f001203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f72f7af2-a5f8-4afc-bce2-0ef7689becbd', 2, 'II', 'Allemanda', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: II. Allemanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f72f7af2-a5f8-4afc-bce2-0ef7689becbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f0a53f8-515b-4836-8963-8cc8043e4919', 3, 'III', 'Lura', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: III. Lura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f0a53f8-515b-4836-8963-8cc8043e4919'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0783adc-d603-4d0d-ba98-375dd2854d38', 4, 'IV', 'Corrente', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: IV. Corrente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0783adc-d603-4d0d-ba98-375dd2854d38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca8858dd-690c-4468-9a47-409c47f43627', 5, 'V', 'Minue I & II', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: V. Minue I & II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca8858dd-690c-4468-9a47-409c47f43627'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca66ec76-8525-4a1c-a254-18810dfd4943', 6, 'VI', 'Giga', 'Essercizii Musici: Solo No. 6 for harpsichord in C major, TWV 32:3: VI. Giga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:055195f3-6267-4ac9-88f3-f8adb8cc4119'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca66ec76-8525-4a1c-a254-18810dfd4943'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16', 12, NULL, '플루트·비올라 다 감바 트리오 B단조', 'Sonata à flauto traverso, viola da gamba e cembalo in B minor, TWV 42:h4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b6a9508-1629-43ee-ada9-0acfe10c76ff', 1, 'I', 'Largo', 'Sonata à flauto traverso, viola da gamba e cembalo in B minor, TWV 42:h4: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b6a9508-1629-43ee-ada9-0acfe10c76ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:076dcc1c-5d2d-490d-877a-082c30952848', 2, 'II', 'Vivace', 'Sonata à flauto traverso, viola da gamba e cembalo in B minor, TWV 42:h4: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:076dcc1c-5d2d-490d-877a-082c30952848'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47c0a873-837c-487a-9175-2e9d04090e13', 3, 'III', 'Dolce', 'Sonata à flauto traverso, viola da gamba e cembalo in B minor, TWV 42:h4: III. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c0a873-837c-487a-9175-2e9d04090e13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3129b256-d19f-4321-afa8-42a949a377b2', 4, 'IV', 'Vivace', 'Sonata à flauto traverso, viola da gamba e cembalo in B minor, TWV 42:h4: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18a63d3f-efcd-4157-8fe5-e6cb14a4fd16'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3129b256-d19f-4321-afa8-42a949a377b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8', 13, NULL, '바이올린 솔로 A장조', 'Essercizii Musici: Solo No. 7 for violin & continuo in A major, TWV 41:A6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64c162d5-c4e9-41f5-ae79-8bc173f8703e', 1, 'I', 'Dolce', 'Essercizii Musici: Solo No. 7 for violin & continuo in A major, TWV 41:A6: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c162d5-c4e9-41f5-ae79-8bc173f8703e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58610b18-01ca-480c-95ba-8bf9ad89ee38', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 7 for violin & continuo in A major, TWV 41:A6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58610b18-01ca-480c-95ba-8bf9ad89ee38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81bff153-0b80-4a8e-8a8e-907deda2b434', 3, 'III', 'Grave', 'Essercizii Musici: Solo No. 7 for violin & continuo in A major, TWV 41:A6: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81bff153-0b80-4a8e-8a8e-907deda2b434'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66eba6fc-3f4f-4bcb-b01e-31e2d662be9b', 4, 'IV', 'Allegro', 'Essercizii Musici: Solo No. 7 for violin & continuo in A major, TWV 41:A6: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6217485b-5ed0-43ca-8454-6e5cfb4368d8'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66eba6fc-3f4f-4bcb-b01e-31e2d662be9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55948273-7051-458b-bebd-6bed31959e6e', 14, NULL, '리코더·비올라 다 감바 트리오 F장조', 'Essercizii Musici: Trio No. 7 for recorder, viola da gamba & continuo in F major, TWV 42:F3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55948273-7051-458b-bebd-6bed31959e6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aaa85ebd-8741-4fd8-9203-9b5eee38f93d', 1, 'I', 'Vivace', 'Essercizii Musici: Trio No. 7 for recorder, viola da gamba & continuo in F major, TWV 42:F3: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55948273-7051-458b-bebd-6bed31959e6e'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa85ebd-8741-4fd8-9203-9b5eee38f93d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37570acf-46e5-454e-ae38-53a84cb4e61a', 2, 'II', 'Mesto', 'Essercizii Musici: Trio No. 7 for recorder, viola da gamba & continuo in F major, TWV 42:F3: II. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55948273-7051-458b-bebd-6bed31959e6e'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37570acf-46e5-454e-ae38-53a84cb4e61a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e08b386-4757-4964-ae71-0fefba65ca74', 3, 'III', 'Allegro', 'Essercizii Musici: Trio No. 7 for recorder, viola da gamba & continuo in F major, TWV 42:F3: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55948273-7051-458b-bebd-6bed31959e6e'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e08b386-4757-4964-ae71-0fefba65ca74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb', 15, NULL, '플루트 솔로 G장조', 'Essercizii Musici: Solo No. 8 for flute & continuo in G major, TWV 41:G9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1018744c-ad2c-4d40-b01e-c6ef0c7e4841', 1, 'I', 'Cantabile', 'Essercizii Musici: Solo No. 8 for flute & continuo in G major, TWV 41:G9: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1018744c-ad2c-4d40-b01e-c6ef0c7e4841'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d31d07d9-1764-441c-a9ab-6ace3128d61c', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 8 for flute & continuo in G major, TWV 41:G9: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d31d07d9-1764-441c-a9ab-6ace3128d61c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:766f35cb-ef98-4377-9858-eefa4d030d4d', 3, 'III', 'Affettuoso', 'Essercizii Musici: Solo No. 8 for flute & continuo in G major, TWV 41:G9: III. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766f35cb-ef98-4377-9858-eefa4d030d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4fa7eaa8-ddd5-4fc6-af0b-083e2ea30527', 4, 'IV', 'Allegro', 'Essercizii Musici: Solo No. 8 for flute & continuo in G major, TWV 41:G9: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7365fe88-76ff-4e70-b4e3-d87425264bdb'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fa7eaa8-ddd5-4fc6-af0b-083e2ea30527'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786', 16, NULL, '리코더·하프시코드 트리오 B♭장조', 'Trio Sonata in B-flat major, TWV 42:B4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3217d4b0-bb28-4898-85e2-96b6fca544ac', 1, 'I', 'Dolce', 'Trio Sonata in B-flat major, TWV 42:B4: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3217d4b0-bb28-4898-85e2-96b6fca544ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b265068-6fe2-4fda-9a36-421f7a0c8c41', 2, 'II', 'Vivace', 'Trio Sonata in B-flat major, TWV 42:B4: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b265068-6fe2-4fda-9a36-421f7a0c8c41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92a88884-fc09-42a9-903f-75bceb600881', 3, 'III', 'Siciliana', 'Trio Sonata in B-flat major, TWV 42:B4: III. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a88884-fc09-42a9-903f-75bceb600881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2bcfbf6-66fb-490e-af78-c7eda032604b', 4, 'IV', 'Vivace', 'Trio Sonata in B-flat major, TWV 42:B4: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276e43a7-c222-40c9-b1c4-688e5e71c786'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2bcfbf6-66fb-490e-af78-c7eda032604b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64', 17, NULL, '비올라 다 감바 솔로 E단조', 'Essercizii Musici: Solo No. 9 for viola da gamba & continuo in E minor, TWV 41:e5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a494f489-87f8-481e-b5de-02f8fc23a194', 1, 'I', 'Cantabile', 'Essercizii Musici: Solo No. 9 for viola da gamba & continuo in E minor, TWV 41:e5: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a494f489-87f8-481e-b5de-02f8fc23a194'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f83bdc1f-9670-4057-a984-f79b4fcc3f10', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 9 for viola da gamba & continuo in E minor, TWV 41:e5: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83bdc1f-9670-4057-a984-f79b4fcc3f10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09695c19-09f1-4011-bac4-f53de3188afc', 3, 'III', 'Recitativo – Arioso (G major)', 'Essercizii Musici: Solo No. 9 for viola da gamba & continuo in E minor, TWV 41:e5: III. Recitativo – Arioso (G major)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09695c19-09f1-4011-bac4-f53de3188afc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe1901e9-6dae-462e-91f1-3653ae4ae9ec', 4, 'IV', 'Vivace', 'Essercizii Musici: Solo No. 9 for viola da gamba & continuo in E minor, TWV 41:e5: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a06672fb-aec7-4c1a-97e2-0077bbf03e64'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe1901e9-6dae-462e-91f1-3653ae4ae9ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396', 18, NULL, '플루트·바이올린 트리오 E장조', 'Essercizii Musici: Trio No. 9 for flute, violin & continuo in E major, TWV 42:E4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31500009-aa39-481b-9472-1c7869224bcb', 1, 'I', 'Soave', 'Essercizii Musici: Trio No. 9 for flute, violin & continuo in E major, TWV 42:E4: I. Soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31500009-aa39-481b-9472-1c7869224bcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a617856b-2f62-4a5a-9c65-2c467a26f30a', 2, 'II', 'Presto', 'Essercizii Musici: Trio No. 9 for flute, violin & continuo in E major, TWV 42:E4: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a617856b-2f62-4a5a-9c65-2c467a26f30a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f6f0a2f-627b-4213-8dc1-beffdd01dd26', 3, 'III', 'Andante', 'Essercizii Musici: Trio No. 9 for flute, violin & continuo in E major, TWV 42:E4: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f6f0a2f-627b-4213-8dc1-beffdd01dd26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0262e1c0-0ce7-4a12-99df-a2e6365b8136', 4, 'IV', 'Scherzando', 'Essercizii Musici: Trio No. 9 for flute, violin & continuo in E major, TWV 42:E4: IV. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d87e606-4cb2-4bd4-8fb1-685795601396'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0262e1c0-0ce7-4a12-99df-a2e6365b8136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691dbe3b-770f-429e-b9fb-228d43f03bf5', 19, NULL, '리코더 솔로 C장조', 'Essercizii Musici: Solo No. 10 for recorder & continuo in C major, TWV 41:C5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691dbe3b-770f-429e-b9fb-228d43f03bf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47c65902-cece-415b-9204-deac42bdbaae', 1, 'I', 'Adagio - Allegro - Adagio - Allegro', 'Essercizii Musici: Solo No. 10 for recorder & continuo in C major, TWV 41:C5: I. Adagio - Allegro - Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:691dbe3b-770f-429e-b9fb-228d43f03bf5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c65902-cece-415b-9204-deac42bdbaae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59fcb397-bf62-4141-b803-c78539c3ffb2', 2, 'II', 'Larghetto', 'Essercizii Musici: Solo No. 10 for recorder & continuo in C major, TWV 41:C5: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:691dbe3b-770f-429e-b9fb-228d43f03bf5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59fcb397-bf62-4141-b803-c78539c3ffb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99e31dce-47e5-4aec-98d0-794d6b96080d', 3, 'III', 'Vivace', 'Essercizii Musici: Solo No. 10 for recorder & continuo in C major, TWV 41:C5: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:691dbe3b-770f-429e-b9fb-228d43f03bf5'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e31dce-47e5-4aec-98d0-794d6b96080d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a', 20, NULL, '바이올린·비올라 다 감바 트리오 D장조', 'Essercizii Musici: Trio No. 10 for violin, viola da gamba & continuo in D major, TWV 42:D9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dcb03f6-be12-4375-86d7-05a8ce3d45b3', 1, 'I', 'Dolce', 'Essercizii Musici: Trio No. 10 for violin, viola da gamba & continuo in D major, TWV 42:D9: I. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcb03f6-be12-4375-86d7-05a8ce3d45b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f35ca80-4e7e-4562-ac91-769e455ddf25', 2, 'II', 'Presto', 'Essercizii Musici: Trio No. 10 for violin, viola da gamba & continuo in D major, TWV 42:D9: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f35ca80-4e7e-4562-ac91-769e455ddf25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58838fef-0305-4987-a96f-fe5b75a99d1d', 3, 'III', 'Pastorale', 'Essercizii Musici: Trio No. 10 for violin, viola da gamba & continuo in D major, TWV 42:D9: III. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58838fef-0305-4987-a96f-fe5b75a99d1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3ab8bf0-f088-4fbc-bded-d83b2c33d425', 4, 'IV', 'Vivace', 'Essercizii Musici: Trio No. 10 for violin, viola da gamba & continuo in D major, TWV 42:D9: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e79a9e-0b3a-49b9-aca4-be3b1e6b243a'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3ab8bf0-f088-4fbc-bded-d83b2c33d425'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19', 21, NULL, '오보에 솔로 E단조', 'Essercizii Musici: Solo No. 11 for oboe & continuo in E minor, TWV 41:e6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89cc33da-309c-45fe-a107-88e2641c1ab2', 1, 'I', 'Largo', 'Essercizii Musici: Solo No. 11 for oboe & continuo in E minor, TWV 41:e6: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89cc33da-309c-45fe-a107-88e2641c1ab2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd6c82b3-097b-4a5e-917d-e90967ca623a', 2, 'II', 'Allegro', 'Essercizii Musici: Solo No. 11 for oboe & continuo in E minor, TWV 41:e6: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6c82b3-097b-4a5e-917d-e90967ca623a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:318fa0af-2dfa-4014-a5d1-be335c43be39', 3, 'III', 'Grave', 'Essercizii Musici: Solo No. 11 for oboe & continuo in E minor, TWV 41:e6: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318fa0af-2dfa-4014-a5d1-be335c43be39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:320bea1b-5dab-4bdc-95e5-b443ef1a2767', 4, 'IV', 'Vivace', 'Essercizii Musici: Solo No. 11 for oboe & continuo in E minor, TWV 41:e6: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a23ddd3-4764-49a7-9292-62871aa47a19'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320bea1b-5dab-4bdc-95e5-b443ef1a2767'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0', 22, NULL, '플루트·오보에 트리오 D단조', 'Essercizii Musici: Trio No. 11 for flute, oboe & continuo in D minor, TWV 42:d4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c961d1a-caf3-46bb-9771-fef5a2fa35d4', 1, 'I', 'Largo', 'Essercizii Musici: Trio No. 11 for flute, oboe & continuo in D minor, TWV 42:d4 I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c961d1a-caf3-46bb-9771-fef5a2fa35d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bba0602-045a-4d37-a068-69c64931f8af', 2, 'II', 'Allegro', 'Essercizii Musici: Trio No. 11 for flute, oboe & continuo in D minor, TWV 42:d4 II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bba0602-045a-4d37-a068-69c64931f8af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f279447-b1e5-499e-9a7a-524ac2a3ed65', 3, 'III', 'Affettuoso', 'Essercizii Musici: Trio No. 11 for flute, oboe & continuo in D minor, TWV 42:d4 III. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f279447-b1e5-499e-9a7a-524ac2a3ed65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:739524e6-132f-483c-bad3-03411b442051', 4, 'IV', 'Presto', 'Essercizii Musici: Trio No. 11 for flute, oboe & continuo in D minor, TWV 42:d4 IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad1ecaed-2ab7-4265-9e3b-8867749ad0d0'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739524e6-132f-483c-bad3-03411b442051'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7', 23, NULL, '하프시코드 솔로 F장조', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:588a5e95-7bd5-4259-ab37-52bdbcc5c07c', 1, 'I', 'Cantabile', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:588a5e95-7bd5-4259-ab37-52bdbcc5c07c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6eecb244-3396-472d-91cc-25b3590b2082', 2, 'II', 'Bourrée', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: II. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eecb244-3396-472d-91cc-25b3590b2082'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87ece808-be98-40ce-a4d3-5a9c3b29ef14', 3, 'III', 'Sarabande', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87ece808-be98-40ce-a4d3-5a9c3b29ef14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6de369c-dd27-4776-a648-e7c013e8cfe7', 4, 'IV', 'Gavotte', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6de369c-dd27-4776-a648-e7c013e8cfe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d79dd8d-fe9c-4905-85d4-f6d92762f828', 5, 'V', 'Passepied', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: V. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d79dd8d-fe9c-4905-85d4-f6d92762f828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44a0abde-89d0-439f-a447-b6db1a6529f0', 6, 'VI', 'Gigue', 'Essercizii Musici: Solo No. 12 for harpsichord in F major, TWV 32:4: VI. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a3bbec0-f023-48db-965f-faadf7f1dfe7'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44a0abde-89d0-439f-a447-b6db1a6529f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f', 24, NULL, '오보에·하프시코드 트리오 E♭장조', 'Trio Sonata in E-flat major, TWV 42:Es3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9aa2706-2e1e-46b2-9726-b57cfc46570e', 1, 'I', 'Largo', 'Trio Sonata in E-flat major, TWV 42:Es3: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9aa2706-2e1e-46b2-9726-b57cfc46570e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f047e9c3-9003-40f7-a834-a6f645776f25', 2, 'II', 'Vivace', 'Trio Sonata in E-flat major, TWV 42:Es3: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f047e9c3-9003-40f7-a834-a6f645776f25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c234acb3-f0af-4d97-805e-e40b562ee445', 3, 'III', 'Mesto', 'Trio Sonata in E-flat major, TWV 42:Es3: III. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c234acb3-f0af-4d97-805e-e40b562ee445'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acbfd547-2534-44bc-a35d-fe065846f11f', 4, 'IV', 'Vivace', 'Trio Sonata in E-flat major, TWV 42:Es3: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78b5cb9d-4bdb-47e2-9851-762c32c82a6f'
WHERE p.composer_id = 11 AND p.title = '<음악 연습>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acbfd547-2534-44bc-a35d-fe065846f11f'
);


-- TWV 41:f1 바순 소나타 F단조 TWV 41:f1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바순 소나타 F단조 TWV 41:f1', 'Recorder Sonata in F minor, TWV 41:f1', 'album', NULL, 'TWV', '41:f1', 1728, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바순 소나타 F단조 TWV 41:f1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1298a-8fa1-4cb9-9fba-2e86ae82ca82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ef1298a-8fa1-4cb9-9fba-2e86ae82ca82'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바순 소나타 F단조 TWV 41:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1298a-8fa1-4cb9-9fba-2e86ae82ca82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c86b274b-3cc2-4548-9953-1154d35c1bdb', 1, 'I', 'Triste', 'Recorder Sonata in F minor, TWV 41:f1: I. Triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바순 소나타 F단조 TWV 41:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c86b274b-3cc2-4548-9953-1154d35c1bdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aee4f770-b592-4180-84d6-794c5f6f8d77', 2, 'II', 'Allegro', 'Recorder Sonata in F minor, TWV 41:f1: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바순 소나타 F단조 TWV 41:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee4f770-b592-4180-84d6-794c5f6f8d77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd6bff82-ea89-4f87-8898-74950e8cd40c', 3, 'III', 'Andante', 'Recorder Sonata in F minor, TWV 41:f1: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바순 소나타 F단조 TWV 41:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd6bff82-ea89-4f87-8898-74950e8cd40c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:344e8b21-b386-4bda-8d05-5143b2d17900', 4, 'IV', 'Vivace', 'Recorder Sonata in F minor, TWV 41:f1: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '바순 소나타 F단조 TWV 41:f1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:344e8b21-b386-4bda-8d05-5143b2d17900'
);


-- TWV 40:201 네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201', 'Concerto for Four Violins in G major, TWV 40:201', 'album', NULL, 'TWV', '40:201', NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8cd0321-bea1-4305-9b2b-be9eeabcf87e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8cd0321-bea1-4305-9b2b-be9eeabcf87e'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8cd0321-bea1-4305-9b2b-be9eeabcf87e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fc8ec75-e303-494c-ac48-0c67758a824a', 1, 'I', 'Largo e staccato', 'Concerto for Four Violins in G major, TWV 40:201: I. Largo e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fc8ec75-e303-494c-ac48-0c67758a824a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ad121ad-3789-440c-9e45-97827ace0beb', 2, 'II', 'Allegro', 'Concerto for Four Violins in G major, TWV 40:201: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ad121ad-3789-440c-9e45-97827ace0beb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aefb0d8-88b7-40d6-9c83-b7bc36934c0d', 3, 'III', 'Adagio', 'Concerto for Four Violins in G major, TWV 40:201: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aefb0d8-88b7-40d6-9c83-b7bc36934c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731ddde2-27d3-404d-aacc-edb7079c820c', 4, 'IV', 'Vivace', 'Concerto for Four Violins in G major, TWV 40:201: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731ddde2-27d3-404d-aacc-edb7079c820c'
);


-- TWV 21:9 오페라 <인내심 많은 소크라테스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <인내심 많은 소크라테스>', 'Der geduldige Socrates (Patient Socrates), TWV 21:9', 'song', 'TWV 21:9', NULL, NULL, 1721, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <인내심 많은 소크라테스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00bc4fc1-6285-499e-9e7f-6c9f67555b0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00bc4fc1-6285-499e-9e7f-6c9f67555b0b'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <인내심 많은 소크라테스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00bc4fc1-6285-499e-9e7f-6c9f67555b0b'
);


-- TWV 21:15 오페라 <핌피노네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <핌피노네>', 'Pimpinone, TWV 21:15', 'song', 'TWV 21:15', NULL, NULL, 1725, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <핌피노네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '548833a0-0fd5-4926-84c4-09e2c267212d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '548833a0-0fd5-4926-84c4-09e2c267212d'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <핌피노네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '548833a0-0fd5-4926-84c4-09e2c267212d'
);


-- TWV 21:18 오페라 <오르페우스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오르페우스>', 'Orpheus oder Die wunderbars Bestandigkeit der Liebe, TWV 21:18', 'song', 'TWV 21:18', NULL, NULL, 1726, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오르페우스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b721c5fc-2676-4ffa-9faf-7d248bb353b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b721c5fc-2676-4ffa-9faf-7d248bb353b4'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <오르페우스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b721c5fc-2676-4ffa-9faf-7d248bb353b4'
);


-- TWV 21:24 오페라 <미리바이스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <미리바이스>', 'Miriways, TWV 21:24', 'song', 'TWV 21:24', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <미리바이스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aa32afd-ca5b-457b-b057-b9aa5a0f4e91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9aa32afd-ca5b-457b-b057-b9aa5a0f4e91'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <미리바이스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aa32afd-ca5b-457b-b057-b9aa5a0f4e91'
);


-- TWV 21:25 오페라 <에마와 에긴하르트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에마와 에긴하르트>', 'Emma und Eginhard, TWV 21:25', 'song', 'TWV 21:25', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에마와 에긴하르트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08f1b5a3-8aa0-492e-8cb9-5b5c070e5f5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08f1b5a3-8aa0-492e-8cb9-5b5c070e5f5a'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <에마와 에긴하르트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08f1b5a3-8aa0-492e-8cb9-5b5c070e5f5a'
);


-- TWV 21:27 오페라 <플라비우스 베르타리두스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <플라비우스 베르타리두스>', 'Flavius Bertaridus, König der Longobarden', 'song', 'TWV 21:27', NULL, NULL, 1729, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <플라비우스 베르타리두스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72af1ef7-1236-4ae4-9489-0ab38fae8c39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72af1ef7-1236-4ae4-9489-0ab38fae8c39'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <플라비우스 베르타리두스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72af1ef7-1236-4ae4-9489-0ab38fae8c39'
);


-- TWV 21:32 오페라 <카마초의 결혼식에 간 돈키호테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <카마초의 결혼식에 간 돈키호테>', 'Don Quichotte auf der Hochzeit des Comacho, TWV 21:32', 'song', 'TWV 21:32', NULL, NULL, 1761, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <카마초의 결혼식에 간 돈키호테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f174678-3389-431c-b04d-788d03693dc0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f174678-3389-431c-b04d-788d03693dc0'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오페라 <카마초의 결혼식에 간 돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f174678-3389-431c-b04d-788d03693dc0'
);


-- TWV 5:1 브로케스 수난곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '브로케스 수난곡', 'Brockes-Passion, TWV 5:1', 'song', 'TWV 5:1', NULL, NULL, 1716, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '브로케스 수난곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c98524a6-743a-407b-84b9-8511ac864818'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c98524a6-743a-407b-84b9-8511ac864818'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '브로케스 수난곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c98524a6-743a-407b-84b9-8511ac864818'
);


-- TWV 5:13 누가 수난곡 (1728)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '누가 수난곡 (1728)', 'Lukaspassion, TWV 5:13 "Israel, achigeliebtes Vater-Herz!"', 'song', 'TWV 5:13', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '누가 수난곡 (1728)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00dfc1fc-7af9-414b-b1e9-1317fd6c777d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00dfc1fc-7af9-414b-b1e9-1317fd6c777d'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '누가 수난곡 (1728)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00dfc1fc-7af9-414b-b1e9-1317fd6c777d'
);


-- TWV 5:30 요한 수난곡 (1745)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '요한 수난곡 (1745)', 'Johannes-Passion TWV 5:30', 'song', 'TWV 5:30', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '요한 수난곡 (1745)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13bcf4a3-17bf-49fb-96b0-ed0fbb5abeb1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13bcf4a3-17bf-49fb-96b0-ed0fbb5abeb1'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '요한 수난곡 (1745)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13bcf4a3-17bf-49fb-96b0-ed0fbb5abeb1'
);


-- TWV 5:31 마태 수난곡 (1746)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마태 수난곡 (1746)', 'Matthäus Passion, TWV 5:31 "Lasst uns mit Ernst betrachten"', 'song', 'TWV 5:31', NULL, NULL, 1746, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마태 수난곡 (1746)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc69e5e-bc78-4db4-ab4d-13ac96aaf8a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8bc69e5e-bc78-4db4-ab4d-13ac96aaf8a3'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '마태 수난곡 (1746)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc69e5e-bc78-4db4-ab4d-13ac96aaf8a3'
);


-- TWV 5:44 마가 수난곡 (1759)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마가 수난곡 (1759)', 'Markus-Passion TWV 5:44', 'song', 'TWV 5:44', NULL, NULL, 1759, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마가 수난곡 (1759)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5375dd2e-76ee-4470-bf17-76ffcaa2e820'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5375dd2e-76ee-4470-bf17-76ffcaa2e820'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '마가 수난곡 (1759)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5375dd2e-76ee-4470-bf17-76ffcaa2e820'
);


-- TWV 5:6 오라토리오 <예수의 죽음>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <예수의 죽음>', 'Der Tod Jesu, TWV 5:6', 'song', 'TWV 5:6', NULL, NULL, 1755, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <예수의 죽음>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0a580bb-29ef-4b8e-976f-2646c6c1d81e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0a580bb-29ef-4b8e-976f-2646c6c1d81e'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오라토리오 <예수의 죽음>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0a580bb-29ef-4b8e-976f-2646c6c1d81e'
);


-- TWV 6:4 오라토리오 <메시아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <메시아>', 'Der Messias TWV 6:4', 'song', 'TWV 6:4', NULL, NULL, 1759, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <메시아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7dd52d76-0cd8-4e0a-b256-0c4e1725db53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7dd52d76-0cd8-4e0a-b256-0c4e1725db53'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오라토리오 <메시아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7dd52d76-0cd8-4e0a-b256-0c4e1725db53'
);


-- TWV 6:7 오라토리오 <부활>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <부활>', 'Die Auferstehung, TWV 6:7', 'song', 'TWV 6:7', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <부활>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '626ec15d-afd4-47a0-9464-22511a605dd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '626ec15d-afd4-47a0-9464-22511a605dd3'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오라토리오 <부활>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '626ec15d-afd4-47a0-9464-22511a605dd3'
);


-- TWV 6:8 오라토리오 <심판의 날>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <심판의 날>', 'Der Tag des Gerichts, TWV 6:8', 'song', 'TWV 6:8', NULL, NULL, 1762, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <심판의 날>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd985bca3-93c1-4b4c-8a1e-5702262f7155'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd985bca3-93c1-4b4c-8a1e-5702262f7155'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '오라토리오 <심판의 날>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd985bca3-93c1-4b4c-8a1e-5702262f7155'
);


-- TWV 20:39 칸타타 <하루의 때>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <하루의 때>', 'Die Tageszeiten, TWV 20:39', 'song', 'TWV 20:39', NULL, NULL, 1757, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <하루의 때>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5aed7d9-ef61-4c8f-85f5-6d060d245b3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5aed7d9-ef61-4c8f-85f5-6d060d245b3e'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '칸타타 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5aed7d9-ef61-4c8f-85f5-6d060d245b3e'
);


-- TWV 20:37 칸타타 <카나리아를 위한 장송 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <카나리아를 위한 장송 음악>', 'Trauer-musik eines kunsterfahrenen Canarienvogels, TWV 20:37', 'song', 'TWV 20:37', NULL, NULL, 1737, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <카나리아를 위한 장송 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98a45924-5441-453e-829e-4656702a25cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98a45924-5441-453e-829e-4656702a25cf'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '칸타타 <카나리아를 위한 장송 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98a45924-5441-453e-829e-4656702a25cf'
);


-- TWV 20:41 칸타타 <이노>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <이노>', 'Ino, TWV 20:41', 'song', 'TWV 20:41', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <이노>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5412f8be-f887-49af-99ef-0d798e9969bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5412f8be-f887-49af-99ef-0d798e9969bd'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '칸타타 <이노>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5412f8be-f887-49af-99ef-0d798e9969bd'
);


-- TWV 14:12 칸타타 <Gott, man lobet dich in der Stille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Gott, man lobet dich in der Stille>', 'Cantata, "Gott, man lobet dich in der Stille", TWV 14:12', 'song', 'TWV 14:12', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Gott, man lobet dich in der Stille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0b0e63a-13d0-4262-969d-6c8856b101c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0b0e63a-13d0-4262-969d-6c8856b101c7'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '칸타타 <Gott, man lobet dich in der Stille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0b0e63a-13d0-4262-969d-6c8856b101c7'
);


-- TWV 9:17 마니피카트 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트 C장조', 'Lateinisches Magnificat C-Dur, TVWV 9:17', 'song', 'TWV 9:17', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 11
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabe2126-d2c7-4ef7-9cd2-19a6ea058197'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fabe2126-d2c7-4ef7-9cd2-19a6ea058197'
FROM pieces p
WHERE p.composer_id = 11 AND p.title = '마니피카트 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabe2126-d2c7-4ef7-9cd2-19a6ea058197'
);

-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 C장조 "수상 음악" TWV 55:C3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 G장조 "고대와 현대의 민족들" TWV 55:G4' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 B♭장조 "민족들" TWV 55:B5' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 F장조 "알스터 강의 메아리" TWV 55:F11' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 B♭장조 "부를레스크" TWV 55:B8' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 G장조 "라 비자르" TWV 55:G2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 G단조 "라 샹장트" TWV 55:g2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 C장조 "라 부퐁" TWV 55:C5' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 B♭장조 "라 부르스" TWV 55:B11' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 11 AND title = '관현악 모음곡 G단조 TWV 55:g4' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE composer_id = 11 AND title = '비올라 다 감바와 현을 위한 모음곡 D장조 TWV 55:D6' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'sinfonia'
WHERE composer_id = 11 AND title = '<귀뚜라미 교향곡> TWV 50:1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'sinfonia'
WHERE composer_id = 11 AND title = '신포니아 스피리투오사 D장조 TWV 44:1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '트럼펫 협주곡 D장조 TWV 51:D7' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '호른 협주곡 D장조 TWV 51:D8' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '플루트 협주곡 D장조 TWV 51:D2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '플루트 협주곡 E장조 TWV 51:E1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '플루트 협주곡 B단조 TWV 51:h1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '리코더 협주곡 C장조 TWV 51:C1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '리코더 협주곡 F장조 TWV 51:F1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 협주곡 C단조 TWV 51:c1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 협주곡 D단조 TWV 51:d1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 협주곡 E단조 TWV 51:e1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 협주곡 F단조 TWV 51:f1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 다모레 협주곡 A장조 TWV 51:A2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 11 AND title = '오보에 다모레 협주곡 G장조 TWV 51:G3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 11 AND title = '바이올린 협주곡 A장조 "개구리" TWV 51:A4' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 11 AND title = '바이올린 협주곡 A단조 TWV 51:a1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 11 AND title = '바이올린 협주곡 F#단조 TWV 51:fis1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '리코더와 플루트를 위한 협주곡 E단조 TWV 52:e1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '리코더와 비올라 다 감바를 위한 협주곡 A단조 TWV 52:a1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '리코더와 바순을 위한 협주곡 F장조 TWV 52:F1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '두 대의 리코더를 위한 협주곡 A단조 TWV 52:a2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '두 대의 비올라를 위한 협주곡 G장조 TWV 52:G3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '두 대의 호른을 위한 협주곡 D장조 TWV 52:D1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '두 대의 호른을 위한 협주곡 E♭장조 TWV 52:Es1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '두 대의 샬뤼모를 위한 협주곡 D단조 TWV 52:d1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '트럼펫과 두 대의 오보에를 위한 협주곡 D장조 TWV 53:D2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '세 대의 트럼펫과 팀파니를 위한 협주곡 D장조 TWV 54:D3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '세 대의 호른과 바이올린을 위한 협주곡 D장조 TWV 54:D2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 11 AND title = '폴란드풍 협주곡 G장조 TWV 43:G7' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 11 AND title = '<작은 실내 음악>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 11 AND title = '바이올린과 하프시코드를 위한 6개의 소나타 (1715)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 11 AND title = '베이스 없는 6개의 소나타' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 11 AND title = '무반주 플루트를 위한 12개의 환상곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 11 AND title = '무반주 바이올린을 위한 12개의 환상곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'fantasia'
WHERE composer_id = 11 AND title = '하프시코드를 위한 36개의 환상곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 11 AND title = '6개의 협주곡과 6개의 모음곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 11 AND title = '6개의 카논풍 소나타' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 11 AND title = '<음악 연습>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 11 AND title = '바순 소나타 F단조 TWV 41:f1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 11 AND title = '네 대의 바이올린을 위한 협주곡 G장조 TWV 40:201' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <인내심 많은 소크라테스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <핌피노네>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <오르페우스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <미리바이스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <에마와 에긴하르트>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <플라비우스 베르타리두스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 11 AND title = '오페라 <카마초의 결혼식에 간 돈키호테>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '브로케스 수난곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '누가 수난곡 (1728)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '요한 수난곡 (1745)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '마태 수난곡 (1746)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '마가 수난곡 (1759)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '오라토리오 <예수의 죽음>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '오라토리오 <메시아>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '오라토리오 <부활>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'oratorio_passion'
WHERE composer_id = 11 AND title = '오라토리오 <심판의 날>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 11 AND title = '칸타타 <하루의 때>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 11 AND title = '칸타타 <카나리아를 위한 장송 음악>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 11 AND title = '칸타타 <이노>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 11 AND title = '칸타타 <Gott, man lobet dich in der Stille>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 11 AND title = '마니피카트 C장조' AND genre IS NULL AND form_key IS NULL;
