-- 무치오 클레멘티(composer_id 25) 작품 목록. 지금은 「소나티네 Op. 36」·「그라두스 아드 파르나숨」·「버림받은 디도」 세 곡뿐이다.
-- 새 작품 39개(작품번호별 피아노 소나타 묶음·낱개 소나타, 카프리치오·토카타·변주곡·몬페리나, 교향곡 Op. 18·WoO 32~35,
-- 피아노 협주곡), 묶음 안 소나타·악장 318개, 장르·형식.
--
-- 4차 자동 규칙 대신 작품을 손으로 고르고(위키백과 작품 목록 대조), 곡은 MusicBrainz parts 순서대로 붙였다. 자료와 생성기:
--   seed_pipeline/curation/composer-catalog-2026-11-12/(build.py, clementi/works.tsv) → catalog-wave4 gen_catalog.py
-- 기존 세 곡은 제목·설명·링크를 두고 MBID 와 곡만 잇는다. 「소나티네 Op. 36」에는 6곡과 악장을 붙이고,
-- 「버림받은 디도」(비교 구간·「처음 듣는다면」 카드 있음)는 새 「피아노 소나타 Op. 50」의 3번 곡으로 잇는다.
-- 「그라두스 아드 파르나숨」은 MusicBrainz 에 곡이 권마다 하나뿐이라 MBID 만 잇는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- Op. 36 소나티네 Op. 36 (1~6번)

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8277788d-de9c-4586-bbb3-d48b671304a8'
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8277788d-de9c-4586-bbb3-d48b671304a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '소나티네 1번 C장조', part.name_en = 'Sonatina in C major, op. 36 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1', 1, NULL, '소나티네 1번 C장조', 'Sonatina in C major, op. 36 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:675ce8dd-95a3-48c0-9b28-b09be1eeee20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:675ce8dd-95a3-48c0-9b28-b09be1eeee20', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675ce8dd-95a3-48c0-9b28-b09be1eeee20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:133028bb-4fc1-49c1-88f2-f3dd6758b33a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:133028bb-4fc1-49c1-88f2-f3dd6758b33a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:133028bb-4fc1-49c1-88f2-f3dd6758b33a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:aeccc72c-ad01-4234-bc31-614c444dd96a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aeccc72c-ad01-4234-bc31-614c444dd96a', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6735db5-79f2-4ff5-9bc0-149130d04bc1'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeccc72c-ad01-4234-bc31-614c444dd96a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '소나티네 2번 G장조', part.name_en = 'Sonatina in G major, op. 36 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45', 2, NULL, '소나티네 2번 G장조', 'Sonatina in G major, op. 36 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:dc47dd3f-3ee7-4ff1-b0a0-1294cb8111ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc47dd3f-3ee7-4ff1-b0a0-1294cb8111ec', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc47dd3f-3ee7-4ff1-b0a0-1294cb8111ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:8beda4ce-4a69-4d73-9aa2-189cf7e92e74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8beda4ce-4a69-4d73-9aa2-189cf7e92e74', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8beda4ce-4a69-4d73-9aa2-189cf7e92e74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:4903f387-3aa4-43bd-91a0-f936a368304e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4903f387-3aa4-43bd-91a0-f936a368304e', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72dcd08b-1d13-48b0-93f7-611042120b45'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4903f387-3aa4-43bd-91a0-f936a368304e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '소나티네 3번 C장조', part.name_en = 'Sonatina in C major, op. 36 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a', 3, NULL, '소나티네 3번 C장조', 'Sonatina in C major, op. 36 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spiritoso', part.name_en = 'I. Spiritoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:8cf356e7-9d4a-4147-8b8c-1b70284d5d6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cf356e7-9d4a-4147-8b8c-1b70284d5d6e', 1, 'I', 'Spiritoso', 'I. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cf356e7-9d4a-4147-8b8c-1b70284d5d6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Un poco adagio', part.name_en = 'II. Un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:62a9c4f6-7ff4-47c1-885a-b067d3e3b94c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62a9c4f6-7ff4-47c1-885a-b067d3e3b94c', 2, 'II', 'Un poco adagio', 'II. Un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a9c4f6-7ff4-47c1-885a-b067d3e3b94c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:fada1f9f-5a9d-416a-9241-6ad96151c62b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fada1f9f-5a9d-416a-9241-6ad96151c62b', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:521d8d63-ea92-479e-9903-8c291b3a607a'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fada1f9f-5a9d-416a-9241-6ad96151c62b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '소나티네 4번 F장조', part.name_en = 'Sonatina in F major, op. 36 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2', 4, NULL, '소나티네 4번 F장조', 'Sonatina in F major, op. 36 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Con spirito', part.name_en = 'I. Con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:41b6590d-4dfe-481a-8a74-c6e0da1bcd86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41b6590d-4dfe-481a-8a74-c6e0da1bcd86', 1, 'I', 'Con spirito', 'I. Con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b6590d-4dfe-481a-8a74-c6e0da1bcd86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con espressione', part.name_en = 'II. Andante con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:0c5ef81e-77ed-49ed-8537-d2ddb677a30f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c5ef81e-77ed-49ed-8537-d2ddb677a30f', 2, 'II', 'Andante con espressione', 'II. Andante con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c5ef81e-77ed-49ed-8537-d2ddb677a30f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:e3e4c07c-5a21-4ef9-82f0-126d1db1f9f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3e4c07c-5a21-4ef9-82f0-126d1db1f9f7', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7294d5b5-2f0f-461e-a359-6b14fe28f6f2'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e4c07c-5a21-4ef9-82f0-126d1db1f9f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '소나티네 5번 G장조', part.name_en = 'Sonatina in G major, op. 36 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87', 5, NULL, '소나티네 5번 G장조', 'Sonatina in G major, op. 36 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:9474170c-07ef-4a7e-b533-0686274ef2c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9474170c-07ef-4a7e-b533-0686274ef2c8', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9474170c-07ef-4a7e-b533-0686274ef2c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Swiss Air. Allegro moderato', part.name_en = 'II. Swiss Air. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:ae8d633e-e031-47c3-b695-8c913492770b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae8d633e-e031-47c3-b695-8c913492770b', 2, 'II', 'Swiss Air. Allegro moderato', 'II. Swiss Air. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae8d633e-e031-47c3-b695-8c913492770b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '론도. Allegro di molto', part.name_en = 'III. Rondo. Allegro di molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:992b46f3-9987-4238-8394-cf6d55df112e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:992b46f3-9987-4238-8394-cf6d55df112e', 3, 'III', '론도. Allegro di molto', 'III. Rondo. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:675555d7-7d5e-45ef-8729-474df7091c87'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:992b46f3-9987-4238-8394-cf6d55df112e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '소나티네 6번 D장조', part.name_en = 'Sonatina in D major, op. 36 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca', 6, NULL, '소나티네 6번 D장조', 'Sonatina in D major, op. 36 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con spirito', part.name_en = 'I. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:0d9703e5-bef0-4353-9b3b-e7c9338ad4e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d9703e5-bef0-4353-9b3b-e7c9338ad4e4', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d9703e5-bef0-4353-9b3b-e7c9338ad4e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto spiritoso', part.name_en = 'II. Allegretto spiritoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 113 AND p.composer_id = 25 AND part.part_key = 'musicbrainz:38b247bc-3e46-4803-bfa0-841aa7478987' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38b247bc-3e46-4803-bfa0-841aa7478987', 2, 'II', 'Allegretto spiritoso', 'II. Allegretto spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8e570b3-3e40-4edc-bdc3-ddb789b3ceca'
WHERE p.id = 113 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38b247bc-3e46-4803-bfa0-841aa7478987'
);


-- Op. 44 그라두스 아드 파르나숨

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2c66253-9fdb-4c7a-8b76-c203c62fe4f8'
FROM pieces p
WHERE p.id = 114 AND p.composer_id = 25
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2c66253-9fdb-4c7a-8b76-c203c62fe4f8'
);


-- WoO 13 피아노 소나타 A♭장조 WoO 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 A♭장조 WoO 13', 'Sonata in A-flat major, WoO 13', 'album', NULL, 'WoO', '13', 1765, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 A♭장조 WoO 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c17f763-f43d-4400-885a-4e102e3ff0ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c17f763-f43d-4400-885a-4e102e3ff0ee'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 A♭장조 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c17f763-f43d-4400-885a-4e102e3ff0ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21ebbfc5-bfb4-4739-9472-ef2daaf617f8', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 A♭장조 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ebbfc5-bfb4-4739-9472-ef2daaf617f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e1d0799-54ff-4d0e-9c6f-ec4837e132ea', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 A♭장조 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e1d0799-54ff-4d0e-9c6f-ec4837e132ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33f13de6-b7ce-49b2-bf5f-05101674855e', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 A♭장조 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33f13de6-b7ce-49b2-bf5f-05101674855e'
);


-- WoO 14 피아노 소나타 G장조 WoO 14

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 G장조 WoO 14', 'Sonata in G major, WoO 14', 'album', NULL, 'WoO', '14', 1768, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 G장조 WoO 14'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3de36f0-57cd-4a94-9736-58b3d9ce295c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3de36f0-57cd-4a94-9736-58b3d9ce295c'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 G장조 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3de36f0-57cd-4a94-9736-58b3d9ce295c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e530c18-c96a-4ae5-9c4e-719ab2412d6f', 1, NULL, 'Allegro', 'Allegro from Sonata in G major, WoO 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 G장조 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e530c18-c96a-4ae5-9c4e-719ab2412d6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fe7c3cb-438f-4745-96ee-1e0e49c1e6d8', 2, 'II', 'Allegro assai', 'II. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 G장조 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fe7c3cb-438f-4745-96ee-1e0e49c1e6d8'
);


-- Op. 1 피아노 소나타 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 1', '6 Piano Sonatas, op. 1', 'album', NULL, 'Op.', '1', 1771, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af0a9289-25cd-4c08-b18a-d058c35ecf9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af0a9289-25cd-4c08-b18a-d058c35ecf9e'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af0a9289-25cd-4c08-b18a-d058c35ecf9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53bfd285-11c7-44a1-82fb-05815bf9c3bd', 1, NULL, '피아노 소나타 1번 E♭장조', 'Sonata in E-flat major, op. 1 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53bfd285-11c7-44a1-82fb-05815bf9c3bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78f70282-7199-411b-ba32-547f218840fb', 1, 'I', 'Allegro con comodo', 'I. Allegro con comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:53bfd285-11c7-44a1-82fb-05815bf9c3bd'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78f70282-7199-411b-ba32-547f218840fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be9edcc7-0d02-4192-97e3-65234d8a6e1c', 2, 'II', 'Tempo di minuetto', 'II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:53bfd285-11c7-44a1-82fb-05815bf9c3bd'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be9edcc7-0d02-4192-97e3-65234d8a6e1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f7caa4-d1d5-4b11-8c8e-f365be283321', 2, NULL, '피아노 소나타 2번 G장조', 'Sonata in G major, op. 1 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f7caa4-d1d5-4b11-8c8e-f365be283321'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b43aded-46ce-4a98-82c5-d7159e6465e4', 1, 'I', 'Spiritoso', 'I. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3f7caa4-d1d5-4b11-8c8e-f365be283321'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b43aded-46ce-4a98-82c5-d7159e6465e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0089e1ac-32c8-41d0-99d0-b685d8314225', 2, 'II', 'Allegro assai', 'II. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3f7caa4-d1d5-4b11-8c8e-f365be283321'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0089e1ac-32c8-41d0-99d0-b685d8314225'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62f160a1-c31f-4706-bf36-7293f525ad2d', 3, NULL, '피아노 소나타 3번 B♭장조', 'Sonata in B-flat major, op. 1 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f160a1-c31f-4706-bf36-7293f525ad2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97f65c07-b452-4aff-b4ea-9ee03ec74bde', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62f160a1-c31f-4706-bf36-7293f525ad2d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f65c07-b452-4aff-b4ea-9ee03ec74bde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d09c095-dde6-4e37-8253-ce51ea87d90c', 2, 'II', 'Andantino grazioso', 'II. Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62f160a1-c31f-4706-bf36-7293f525ad2d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d09c095-dde6-4e37-8253-ce51ea87d90c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a009ccec-0d12-45ae-be3d-90fdc9dc9390', 4, NULL, '피아노 소나타 4번 F장조', 'Sonata in F major, op. 1 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a009ccec-0d12-45ae-be3d-90fdc9dc9390'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81249b30-bd11-4e64-a29a-09b4de076042', 1, 'I', 'Spiritoso', 'I. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a009ccec-0d12-45ae-be3d-90fdc9dc9390'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81249b30-bd11-4e64-a29a-09b4de076042'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bdec0f7-50b1-43d4-9ce8-b0c340069e26', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a009ccec-0d12-45ae-be3d-90fdc9dc9390'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bdec0f7-50b1-43d4-9ce8-b0c340069e26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ccc1c595-b2d5-4b47-9d75-396dbf97301c', 3, 'III', '론도', 'III. Rondeaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a009ccec-0d12-45ae-be3d-90fdc9dc9390'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc1c595-b2d5-4b47-9d75-396dbf97301c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08bd5854-2427-40de-a847-593131a65b9e', 5, NULL, '피아노 소나타 5번 A장조', 'Sonata in A major, op. 1 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08bd5854-2427-40de-a847-593131a65b9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e4a2d25-10d1-4ff2-9d42-18e33513d96b', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08bd5854-2427-40de-a847-593131a65b9e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e4a2d25-10d1-4ff2-9d42-18e33513d96b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfe365a1-0be5-40a4-bab8-8550bce2cd42', 2, 'II', 'Tempo di menuetto. Grazioso', 'II. Tempo di menuetto. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08bd5854-2427-40de-a847-593131a65b9e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfe365a1-0be5-40a4-bab8-8550bce2cd42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a52659-7cab-406b-ba46-a01a29042641', 6, NULL, '피아노 소나타 6번 E장조', 'Sonata in E major, op. 1 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a52659-7cab-406b-ba46-a01a29042641'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b82706f-ed9a-4670-b78d-d3918569e7f2', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a52659-7cab-406b-ba46-a01a29042641'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b82706f-ed9a-4670-b78d-d3918569e7f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57f0391c-caf9-40df-8ee6-902cd22d0a9c', 2, 'II', '론도. Grazioso', 'II. Rondeau. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a52659-7cab-406b-ba46-a01a29042641'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57f0391c-caf9-40df-8ee6-902cd22d0a9c'
);


-- Op. 1a 피아노 소나타 Op. 1a

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 1a', '5 Piano Sonatas and a Duet, op. 1a', 'album', NULL, 'Op.', '1a', NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 1a'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8379cb63-2670-4912-a7d5-f6bf4115db8c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8379cb63-2670-4912-a7d5-f6bf4115db8c'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8379cb63-2670-4912-a7d5-f6bf4115db8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48efc964-dcb1-444b-bfa2-35a06e6b1830', 1, NULL, '피아노 소나타 1번 F장조', 'Sonata in F major op. 1a no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48efc964-dcb1-444b-bfa2-35a06e6b1830'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94356da8-499d-4396-9328-8975d117807d', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48efc964-dcb1-444b-bfa2-35a06e6b1830'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94356da8-499d-4396-9328-8975d117807d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f2b58a7-71fc-4e36-8718-2b8097209231', 2, 'II', 'Allegro. La pantoufle avec des Variations', 'II. Allegro. La pantoufle avec des Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48efc964-dcb1-444b-bfa2-35a06e6b1830'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f2b58a7-71fc-4e36-8718-2b8097209231'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0d6802-c537-45cd-8967-f0ba45efb4b4', 2, NULL, '피아노 소나타 2번 B♭장조', 'Sonata in B-flat major op. 1a no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0d6802-c537-45cd-8967-f0ba45efb4b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91c03139-93e4-40c9-b3b6-bd4cc8b51a3b', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b0d6802-c537-45cd-8967-f0ba45efb4b4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91c03139-93e4-40c9-b3b6-bd4cc8b51a3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0d02de1-6a2b-483a-8449-cdefaffd1d69', 2, 'II', 'Andantino grazioso', 'II. Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b0d6802-c537-45cd-8967-f0ba45efb4b4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0d02de1-6a2b-483a-8449-cdefaffd1d69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7760affa-3566-41f1-a6e0-b4cdeb687408', 3, 'III', 'Allegro. Air du balet de Mirza avec des Variations', 'III. Allegro. Air du balet de Mirza avec des Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7b0d6802-c537-45cd-8967-f0ba45efb4b4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7760affa-3566-41f1-a6e0-b4cdeb687408'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:490ae85b-51ae-4e8b-bafc-e73477dc8519', 3, NULL, '피아노 소나타 3번 G장조', 'Sonata in G major op. 1a no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:490ae85b-51ae-4e8b-bafc-e73477dc8519'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:843e4862-a1f1-403b-9876-d056436829eb', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:490ae85b-51ae-4e8b-bafc-e73477dc8519'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843e4862-a1f1-403b-9876-d056436829eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b8ea6b8-c732-44a0-87bc-899042b71d39', 2, 'II', 'Black Joke. Air anglaise avec des variations', 'II. Black Joke. Air anglaise avec des variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:490ae85b-51ae-4e8b-bafc-e73477dc8519'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b8ea6b8-c732-44a0-87bc-899042b71d39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b8b5af-ff3b-420b-b860-7520200f342e', 4, NULL, '피아노 소나타 4번 A장조', 'Sonata in A major op. 1a no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b8b5af-ff3b-420b-b860-7520200f342e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a26eb0b-082b-4e5e-aa0d-145a01d2d0c8', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1b8b5af-ff3b-420b-b860-7520200f342e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a26eb0b-082b-4e5e-aa0d-145a01d2d0c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2d76949-ab9a-4936-93da-277930a6a775', 2, 'II', 'Tempo di minuetto', 'II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b1b8b5af-ff3b-420b-b860-7520200f342e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 1a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2d76949-ab9a-4936-93da-277930a6a775'
);


-- Op. 2 피아노 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 2', '3 Piano Sonatas, op. 2', 'album', NULL, 'Op.', '2', 1779, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '860303cb-2cae-44b8-bcd1-bf9b7f9173bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '860303cb-2cae-44b8-bcd1-bf9b7f9173bd'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '860303cb-2cae-44b8-bcd1-bf9b7f9173bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8594cf17-512e-48be-9f0f-094a542e6140', 1, NULL, '피아노 소나타 2번 C장조', 'Sonata in C major, op. 2 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8594cf17-512e-48be-9f0f-094a542e6140'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f2a86aa-2100-4bc2-937d-8c06580a17e8', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8594cf17-512e-48be-9f0f-094a542e6140'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2a86aa-2100-4bc2-937d-8c06580a17e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae1af47c-4d97-44e1-9486-5e2b00d220ce', 2, 'II', '론도. Spiritoso', 'II. Rondeau. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8594cf17-512e-48be-9f0f-094a542e6140'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1af47c-4d97-44e1-9486-5e2b00d220ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76ee5fae-41e3-43d8-bd63-4c67ed7e3e3d', 2, NULL, '피아노 소나타 4번 A장조', 'Sonata in A major, op. 2 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76ee5fae-41e3-43d8-bd63-4c67ed7e3e3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:726e96c8-3190-4e2d-b71d-d15dc796f706', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76ee5fae-41e3-43d8-bd63-4c67ed7e3e3d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:726e96c8-3190-4e2d-b71d-d15dc796f706'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:970003f0-46fc-4287-8f4d-435846b9b36e', 2, 'II', 'Spiritoso', 'II. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76ee5fae-41e3-43d8-bd63-4c67ed7e3e3d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:970003f0-46fc-4287-8f4d-435846b9b36e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5242d918-ee65-48a9-9e8c-497faca36668', 3, NULL, '피아노 소나타 6번 B♭장조', 'Sonata in B-flat major, op. 2 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5242d918-ee65-48a9-9e8c-497faca36668'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b728eda6-fc33-45b8-a85a-bffd3dda4659', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5242d918-ee65-48a9-9e8c-497faca36668'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b728eda6-fc33-45b8-a85a-bffd3dda4659'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95b8f76e-c9b4-4149-a31b-cc7e986fc3e8', 2, 'II', 'Prestissimo', 'II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5242d918-ee65-48a9-9e8c-497faca36668'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b8f76e-c9b4-4149-a31b-cc7e986fc3e8'
);


-- Op. 7 피아노 소나타 Op. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 7', '3 Piano Sonatas, op. 7', 'album', NULL, 'Op.', '7', 1782, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8c97053-9c4e-4c0c-bd42-f6baf9bfbcc3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8c97053-9c4e-4c0c-bd42-f6baf9bfbcc3'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8c97053-9c4e-4c0c-bd42-f6baf9bfbcc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0ebc174-6177-4d9b-a7fa-01004adbe404', 1, NULL, '피아노 소나타 1번 E♭장조', 'Sonata in E-flat major, op. 7 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0ebc174-6177-4d9b-a7fa-01004adbe404'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a59c5a8-8538-4bec-93c1-0f9e247b6e98', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ebc174-6177-4d9b-a7fa-01004adbe404'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a59c5a8-8538-4bec-93c1-0f9e247b6e98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71e179e6-7bd5-46f5-9508-024c267ea87c', 2, 'II', 'Mesto', 'II. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ebc174-6177-4d9b-a7fa-01004adbe404'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e179e6-7bd5-46f5-9508-024c267ea87c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffabed16-57bd-4774-920a-56de0a53360b', 3, 'III', 'Allegretto spiritoso - Allegro - Tempo I', 'III. Allegretto spiritoso - Allegro - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0ebc174-6177-4d9b-a7fa-01004adbe404'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffabed16-57bd-4774-920a-56de0a53360b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5751016-bca3-494b-854c-5de0d39487f9', 2, NULL, '피아노 소나타 2번 C장조', 'Sonata in C major, op. 7 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5751016-bca3-494b-854c-5de0d39487f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27132cd9-5d03-4a47-ab38-45fb987fd389', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5751016-bca3-494b-854c-5de0d39487f9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27132cd9-5d03-4a47-ab38-45fb987fd389'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7386604f-77c4-41ac-82fa-6073e0671b21', 2, 'II', 'Allegretto con espressione - Allegro', 'II. Allegretto con espressione - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5751016-bca3-494b-854c-5de0d39487f9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7386604f-77c4-41ac-82fa-6073e0671b21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:537289d7-5fa9-43ac-b27b-8a47e8e9d6be', 3, NULL, '피아노 소나타 3번 G단조', 'Sonata in G minor, op. 7 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:537289d7-5fa9-43ac-b27b-8a47e8e9d6be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fda269d5-aeaf-4ac9-b204-624c5ba9a1a4', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:537289d7-5fa9-43ac-b27b-8a47e8e9d6be'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda269d5-aeaf-4ac9-b204-624c5ba9a1a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e2e4ac9-eb16-4897-9d0c-ccedc28fd742', 2, 'II', 'Cantabile e lento', 'II. Cantabile e lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:537289d7-5fa9-43ac-b27b-8a47e8e9d6be'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e2e4ac9-eb16-4897-9d0c-ccedc28fd742'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c353b07-9182-4cc9-a9f7-a705b5b7f537', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:537289d7-5fa9-43ac-b27b-8a47e8e9d6be'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c353b07-9182-4cc9-a9f7-a705b5b7f537'
);


-- Op. 8 피아노 소나타 Op. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 8', '3 Piano Sonatas, op. 8', 'album', NULL, 'Op.', '8', 1782, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf956d69-b4ad-4006-a836-6bfc20d2fcb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf956d69-b4ad-4006-a836-6bfc20d2fcb2'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf956d69-b4ad-4006-a836-6bfc20d2fcb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05021a05-de71-450d-a42c-e717e6b477d7', 1, NULL, '피아노 소나타 1번 G단조', 'Sonata in G minor, op. 8 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05021a05-de71-450d-a42c-e717e6b477d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4360aca-0f13-4884-be88-3a854194163a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05021a05-de71-450d-a42c-e717e6b477d7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4360aca-0f13-4884-be88-3a854194163a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c19d2153-14ab-4616-be0b-a11d8809ee46', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05021a05-de71-450d-a42c-e717e6b477d7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c19d2153-14ab-4616-be0b-a11d8809ee46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:835fa055-34b8-4f9e-a25a-4ff1cc1e1817', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05021a05-de71-450d-a42c-e717e6b477d7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:835fa055-34b8-4f9e-a25a-4ff1cc1e1817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aedb380b-c425-47f2-8f6d-94544c632125', 2, NULL, '피아노 소나타 2번 E♭장조', 'Sonata in E-flat major, op. 8 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aedb380b-c425-47f2-8f6d-94544c632125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:271d2d29-eff8-4b8b-a3c6-97e371246270', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aedb380b-c425-47f2-8f6d-94544c632125'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:271d2d29-eff8-4b8b-a3c6-97e371246270'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0551527b-8cc6-43cd-b078-666896a60e25', 2, 'II', 'Larghetto con espressivo', 'II. Larghetto con espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aedb380b-c425-47f2-8f6d-94544c632125'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0551527b-8cc6-43cd-b078-666896a60e25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92feed65-84d6-4788-bc4e-c4551a134cae', 3, 'III', '론도. Allegro', 'III. Rondeau. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aedb380b-c425-47f2-8f6d-94544c632125'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92feed65-84d6-4788-bc4e-c4551a134cae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d99c0af-26ea-44ad-890d-bf12ef97986c', 3, NULL, '피아노 소나타 3번 B♭장조', 'Sonata in B-flat major, op. 8 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d99c0af-26ea-44ad-890d-bf12ef97986c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6514985-c137-4324-8d98-814fafe912ce', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d99c0af-26ea-44ad-890d-bf12ef97986c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6514985-c137-4324-8d98-814fafe912ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee3248e4-c8fd-460a-a1c3-2bdd9f221d30', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d99c0af-26ea-44ad-890d-bf12ef97986c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee3248e4-c8fd-460a-a1c3-2bdd9f221d30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a00ceed2-983b-40ec-8878-b4e922845bbe', 3, 'III', '론도. Allegretto grazioso', 'III. Rondeau. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d99c0af-26ea-44ad-890d-bf12ef97986c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a00ceed2-983b-40ec-8878-b4e922845bbe'
);


-- Op. 9 피아노 소나타 Op. 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 9', '3 Piano Sonatas, op. 9', 'album', NULL, 'Op.', '9', 1783, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 9'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f28f6a8-a404-4c01-8402-220e0f1d55ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f28f6a8-a404-4c01-8402-220e0f1d55ec'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f28f6a8-a404-4c01-8402-220e0f1d55ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcbfbc6d-d5cb-4616-a094-d2fece5a0712', 1, NULL, '피아노 소나타 1번 B♭장조', 'Sonata in B-flat major, op. 9 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcbfbc6d-d5cb-4616-a094-d2fece5a0712'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc65070c-2d5a-4722-a421-b9dda1cbfb62', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcbfbc6d-d5cb-4616-a094-d2fece5a0712'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc65070c-2d5a-4722-a421-b9dda1cbfb62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ec7c15e-4834-4d99-9620-ae76709a9014', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcbfbc6d-d5cb-4616-a094-d2fece5a0712'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec7c15e-4834-4d99-9620-ae76709a9014'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9dbc9229-22f8-47d6-a121-5cc75e2a4213', 3, 'III', '론도. Prestissimo', 'III. Rondo. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dcbfbc6d-d5cb-4616-a094-d2fece5a0712'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbc9229-22f8-47d6-a121-5cc75e2a4213'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b6182c-4ffd-47e5-8858-0fed96e8d52d', 2, NULL, '피아노 소나타 2번 C장조', 'Sonata in C major, op. 9 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b6182c-4ffd-47e5-8858-0fed96e8d52d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:599e06da-fd07-44d0-a21b-24fa3ce66d9d', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3b6182c-4ffd-47e5-8858-0fed96e8d52d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:599e06da-fd07-44d0-a21b-24fa3ce66d9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:016dab04-1555-4391-9003-ad816ecda14b', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3b6182c-4ffd-47e5-8858-0fed96e8d52d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:016dab04-1555-4391-9003-ad816ecda14b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79c2c8c5-1111-4e4b-a199-1a41077485af', 3, 'III', '론도. Allegro spiritoso', 'III. Rondo. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3b6182c-4ffd-47e5-8858-0fed96e8d52d'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c2c8c5-1111-4e4b-a199-1a41077485af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2598faa-ab2a-4511-addb-a55a0c45f6e6', 3, NULL, '피아노 소나타 3번 E♭장조', 'Sonata in E-flat major, op. 9 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2598faa-ab2a-4511-addb-a55a0c45f6e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:174f94c3-d4ab-4c13-b6fa-a21c0ad71c7b', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2598faa-ab2a-4511-addb-a55a0c45f6e6'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174f94c3-d4ab-4c13-b6fa-a21c0ad71c7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d229ae0f-7d0d-462d-b6e7-fa290318ac0f', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2598faa-ab2a-4511-addb-a55a0c45f6e6'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d229ae0f-7d0d-462d-b6e7-fa290318ac0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b37bd0c-f041-4c9b-bd5b-94b492a1cd60', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2598faa-ab2a-4511-addb-a55a0c45f6e6'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b37bd0c-f041-4c9b-bd5b-94b492a1cd60'
);


-- Op. 10 피아노 소나타 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 10', '3 Piano Sonatas, op. 10', 'album', NULL, 'Op.', '10', 1783, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e589a942-b453-45ef-ac97-fb4563e65251'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e589a942-b453-45ef-ac97-fb4563e65251'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e589a942-b453-45ef-ac97-fb4563e65251'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db6ea689-fee9-4046-a1db-705941d63331', 1, NULL, '피아노 소나타 1번 A장조', 'Sonata in A major, op. 10. no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db6ea689-fee9-4046-a1db-705941d63331'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d048b455-18dc-430c-be41-aa91e07e9ee2', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db6ea689-fee9-4046-a1db-705941d63331'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d048b455-18dc-430c-be41-aa91e07e9ee2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50f045eb-b565-4bd5-9e9c-ec4084c0ad8e', 2, 'II', '미뉴에트. Allegretto con moto - Trio', 'II. Menuetto. Allegretto con moto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db6ea689-fee9-4046-a1db-705941d63331'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f045eb-b565-4bd5-9e9c-ec4084c0ad8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:901438c6-0289-4485-9c06-534bec419b44', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db6ea689-fee9-4046-a1db-705941d63331'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:901438c6-0289-4485-9c06-534bec419b44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d81192-c63e-4470-8de3-a21fd08461ac', 2, NULL, '피아노 소나타 2번 D장조', 'Sonata in D major, op. 10 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d81192-c63e-4470-8de3-a21fd08461ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6e1979b-cc10-40fc-92d1-17171ba08ca8', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54d81192-c63e-4470-8de3-a21fd08461ac'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e1979b-cc10-40fc-92d1-17171ba08ca8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:524d80d2-5dbf-45f4-b9d3-4c792c7452af', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54d81192-c63e-4470-8de3-a21fd08461ac'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524d80d2-5dbf-45f4-b9d3-4c792c7452af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d560e72b-f505-4f04-8ee3-9030bbf78d11', 3, NULL, '피아노 소나타 3번 B♭장조', 'Sonata in B-flat major, op. 10. no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d560e72b-f505-4f04-8ee3-9030bbf78d11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e4fa036-99e1-4ee1-9338-9d797c632920', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d560e72b-f505-4f04-8ee3-9030bbf78d11'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e4fa036-99e1-4ee1-9338-9d797c632920'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95d86369-7d21-4e52-bc4d-d747d90924af', 2, 'II', 'Andante con espressione', 'II. Andante con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d560e72b-f505-4f04-8ee3-9030bbf78d11'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d86369-7d21-4e52-bc4d-d747d90924af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8e3e117-135f-41e5-aa3a-94efa5443470', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d560e72b-f505-4f04-8ee3-9030bbf78d11'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e3e117-135f-41e5-aa3a-94efa5443470'
);


-- Op. 11, No. 1 피아노 소나타 E♭장조 Op. 11, No. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 E♭장조 Op. 11, No. 1', 'Sonata in E-flat major, op. 11 no. 1', 'album', NULL, 'Op.', '11, No. 1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 E♭장조 Op. 11, No. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c01c622-b28c-41f8-9260-b6843b6201ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c01c622-b28c-41f8-9260-b6843b6201ca'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 11, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c01c622-b28c-41f8-9260-b6843b6201ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91d9f5b6-0c02-4cb6-a70e-267769ad02ff', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 11, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d9f5b6-0c02-4cb6-a70e-267769ad02ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5528684-3933-422f-8707-38a9113e8d4c', 2, 'II', 'Larghetto con espressione', 'II. Larghetto con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 11, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5528684-3933-422f-8707-38a9113e8d4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fff7a0e-d5b5-4fb0-a383-cd67e9382b21', 3, 'III', '론도. Allegro di molto', 'III. Rondeau. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 11, No. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fff7a0e-d5b5-4fb0-a383-cd67e9382b21'
);


-- Op. 11, No. 2 토카타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 B♭장조', 'Toccata in B-flat major, op. 11 no. 2', 'song', 'Op. 11, No. 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a5e9906-22de-4187-864c-68692bd1a20f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a5e9906-22de-4187-864c-68692bd1a20f'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '토카타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a5e9906-22de-4187-864c-68692bd1a20f'
);


-- Op. 12 피아노 소나타 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 12', '4 Piano Sonatas, op. 12', 'album', NULL, 'Op.', '12', 1784, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8544e329-3864-4699-bc05-47cd00f84235'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8544e329-3864-4699-bc05-47cd00f84235'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8544e329-3864-4699-bc05-47cd00f84235'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63c4f156-84e6-49b9-b71c-13defd705d44', 1, NULL, '피아노 소나타 1번 B♭장조', 'Sonata in B-flat major, op. 12 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c4f156-84e6-49b9-b71c-13defd705d44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f77933b4-e6e9-42ff-9f2e-16b62f9c6c50', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c4f156-84e6-49b9-b71c-13defd705d44'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f77933b4-e6e9-42ff-9f2e-16b62f9c6c50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1680f5f-7552-44f1-af6a-0720da7d7032', 2, 'II', 'Larghetto con espressione', 'II. Larghetto con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c4f156-84e6-49b9-b71c-13defd705d44'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1680f5f-7552-44f1-af6a-0720da7d7032'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38526bb8-97a5-4ab3-95ba-43e25a8b4d5c', 3, 'III', 'Lindor with Variations. Allegretto', 'III. Lindor with Variations. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63c4f156-84e6-49b9-b71c-13defd705d44'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38526bb8-97a5-4ab3-95ba-43e25a8b4d5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1ffde47-d07c-4687-b345-b8a0c557cb9f', 2, NULL, '피아노 소나타 2번 E♭장조', 'Sonata in E-flat major, op. 12 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ffde47-d07c-4687-b345-b8a0c557cb9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ceea34b6-b784-47fc-b3bb-85408c127dcb', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a1ffde47-d07c-4687-b345-b8a0c557cb9f'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceea34b6-b784-47fc-b3bb-85408c127dcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:303fe564-9ee8-442d-a79d-4c7bcc7b5090', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a1ffde47-d07c-4687-b345-b8a0c557cb9f'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:303fe564-9ee8-442d-a79d-4c7bcc7b5090'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12d88438-20e8-4eba-bddb-cb7192fd1335', 3, 'III', '론도. Allegro assai', 'III. Rondo. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a1ffde47-d07c-4687-b345-b8a0c557cb9f'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d88438-20e8-4eba-bddb-cb7192fd1335'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f7ae20-606f-4b7a-8cef-7efb60720914', 3, NULL, '피아노 소나타 3번 F장조', 'Sonata in F major, op. 12 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f7ae20-606f-4b7a-8cef-7efb60720914'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2791620-6f54-4a33-b822-b86c10065b3c', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6f7ae20-606f-4b7a-8cef-7efb60720914'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2791620-6f54-4a33-b822-b86c10065b3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2943744b-5ee6-4105-adc1-53bf4cbaf493', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6f7ae20-606f-4b7a-8cef-7efb60720914'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2943744b-5ee6-4105-adc1-53bf4cbaf493'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b4b5c21-0cca-42e3-8f21-2677ea069a3d', 3, 'III', '론도. Allegro', 'III. Rondeau. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6f7ae20-606f-4b7a-8cef-7efb60720914'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4b5c21-0cca-42e3-8f21-2677ea069a3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efc9b5d4-801d-4e83-8574-326d15fc4618', 4, NULL, '피아노 소나타 4번 E♭장조', 'Sonata in E-flat major, op. 12. no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc9b5d4-801d-4e83-8574-326d15fc4618'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffb74226-a786-4740-8f67-27d663c0f9a8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc9b5d4-801d-4e83-8574-326d15fc4618'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb74226-a786-4740-8f67-27d663c0f9a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aabbeffa-11b3-4804-98a5-bd2cc67cc403', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc9b5d4-801d-4e83-8574-326d15fc4618'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aabbeffa-11b3-4804-98a5-bd2cc67cc403'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6d147eb-d8db-4b81-975f-33ea1e6e71ca', 3, 'III', '론도. Allegro con spirito', 'III. Rondeau. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc9b5d4-801d-4e83-8574-326d15fc4618'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6d147eb-d8db-4b81-975f-33ea1e6e71ca'
);


-- Op. 13 피아노 소나타 Op. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 13', '6 Sonatas, op. 13', 'album', NULL, 'Op.', '13', 1785, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0c03618-ac67-4c40-9e09-817b23074ee3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0c03618-ac67-4c40-9e09-817b23074ee3'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0c03618-ac67-4c40-9e09-817b23074ee3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d5fb05e-3563-4977-ad5f-f262073a24c0', 1, NULL, '피아노 소나타 4번 B♭장조', 'Sonata in B-flat major, op. 13 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5fb05e-3563-4977-ad5f-f262073a24c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffb9efdf-b7f6-4323-96b7-182dce80eac6', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d5fb05e-3563-4977-ad5f-f262073a24c0'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb9efdf-b7f6-4323-96b7-182dce80eac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62fcb144-0531-442e-bd0f-3e82d1f6c97f', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d5fb05e-3563-4977-ad5f-f262073a24c0'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62fcb144-0531-442e-bd0f-3e82d1f6c97f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9606b42a-1707-404e-8c80-b5698897ed03', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d5fb05e-3563-4977-ad5f-f262073a24c0'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9606b42a-1707-404e-8c80-b5698897ed03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64b00f64-79a2-48d5-a424-4c7b43a0671e', 2, NULL, '피아노 소나타 5번 F장조', 'Sonata in F major, op. 13 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b00f64-79a2-48d5-a424-4c7b43a0671e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b6c3e4b-adc8-46c9-b9a0-cb0943eefcba', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:64b00f64-79a2-48d5-a424-4c7b43a0671e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b6c3e4b-adc8-46c9-b9a0-cb0943eefcba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff07f16f-06bd-412c-a9bb-a5d9e5affaaf', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:64b00f64-79a2-48d5-a424-4c7b43a0671e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff07f16f-06bd-412c-a9bb-a5d9e5affaaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:313dbb6d-e93a-44b0-950a-49b5b068983a', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:64b00f64-79a2-48d5-a424-4c7b43a0671e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313dbb6d-e93a-44b0-950a-49b5b068983a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ec8613-e503-44ab-ad01-bcd4bd098148', 3, NULL, '피아노 소나타 6번 F단조', 'Sonata in F minor, op. 13 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ec8613-e503-44ab-ad01-bcd4bd098148'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7469dedd-123f-4c20-8ed3-6ed5227584d5', 1, 'I', 'Allegro agitato', 'I. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c8ec8613-e503-44ab-ad01-bcd4bd098148'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7469dedd-123f-4c20-8ed3-6ed5227584d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99d2e6bb-dd77-41cf-8814-f8718ce210ce', 2, 'II', 'Largo e sostenuto', 'II. Largo e sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c8ec8613-e503-44ab-ad01-bcd4bd098148'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d2e6bb-dd77-41cf-8814-f8718ce210ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c98896f-d5ba-4b90-a29c-361f316813c1', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c8ec8613-e503-44ab-ad01-bcd4bd098148'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c98896f-d5ba-4b90-a29c-361f316813c1'
);


-- Op. 16 피아노 소나타 D장조 "사냥"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 D장조 "사냥"', 'La chasse, op. 16', 'album', 'Op. 16', NULL, NULL, 1786, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 D장조 "사냥"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67ae8db2-3c68-4e17-8aba-8f96bb7a7743'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67ae8db2-3c68-4e17-8aba-8f96bb7a7743'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 D장조 "사냥"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67ae8db2-3c68-4e17-8aba-8f96bb7a7743'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30c12a19-3159-42f7-a5f7-86319ddd1cda', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 D장조 "사냥"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30c12a19-3159-42f7-a5f7-86319ddd1cda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cac42ddd-da90-4131-bbac-e63c777a31da', 2, 'II', 'Andante vivace', 'II. Andante vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 D장조 "사냥"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cac42ddd-da90-4131-bbac-e63c777a31da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd618297-5b28-495c-a13c-88e0beb573ff', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 D장조 "사냥"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd618297-5b28-495c-a13c-88e0beb573ff'
);


-- Op. 17 카프리치오 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 B♭장조', 'Capriccio in B-flat major, op. 17', 'song', 'Op. 17', NULL, NULL, 1787, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbcddea7-bb5a-4020-b0f1-d02464f0248e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbcddea7-bb5a-4020-b0f1-d02464f0248e'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '카프리치오 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbcddea7-bb5a-4020-b0f1-d02464f0248e'
);


-- Op. 18 교향곡 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 Op. 18', 'Two Symphonies, op. 18', 'album', NULL, 'Op.', '18', 1787, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 Op. 18'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efaaab97-ff97-4837-a347-3fe1859861ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efaaab97-ff97-4837-a347-3fe1859861ad'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efaaab97-ff97-4837-a347-3fe1859861ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf', 1, NULL, '교향곡 1번 B♭장조', 'Symphony in B-flat major, op. 18 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8360af6d-27db-444d-a02b-c0e5fa5efa26', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8360af6d-27db-444d-a02b-c0e5fa5efa26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b60c6dd8-f6f1-4780-8450-7943232ab618', 2, 'II', 'Un poco adagio', 'II. Un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60c6dd8-f6f1-4780-8450-7943232ab618'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d515ce0d-3bae-4385-9c8d-e2d6b577d323', 3, 'III', '미뉴에트. Allegretto - Trio', 'III. Minuetto. Allegretto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d515ce0d-3bae-4385-9c8d-e2d6b577d323'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6384ec8-9c2e-4cdc-9944-25373d956ab4', 4, 'IV', 'Allegro assai', 'IV. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c3bfac5e-aff7-437a-a1cd-38182fb8d6cf'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6384ec8-9c2e-4cdc-9944-25373d956ab4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1', 2, NULL, '교향곡 2번 D장조', 'Symphony in D major, op. 18 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2817678-2f17-4739-b850-7caec1fc2b32', 1, 'I', 'Grave - Allegro assai', 'I. Grave - Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2817678-2f17-4739-b850-7caec1fc2b32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c293a4af-f73d-4b88-855e-c96c1d2981f0', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c293a4af-f73d-4b88-855e-c96c1d2981f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c708781-95e0-424c-809b-8c0a1e51f67b', 3, 'III', 'Minuetto un poco allegro', 'III. Minuetto un poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c708781-95e0-424c-809b-8c0a1e51f67b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84de1a07-ad14-432f-9809-21a8484200f2', 4, 'IV', 'Allegro assai', 'IV. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:38dbf74a-3cb0-42b8-850e-0c264dba06e1'
WHERE p.composer_id = 25 AND p.title = '교향곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84de1a07-ad14-432f-9809-21a8484200f2'
);


-- Op. 19 <음악적 특성>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<음악적 특성>', 'Musical Characteristics, op. 19', 'album', 'Op. 19', NULL, NULL, 1787, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<음악적 특성>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc3a768b-b20b-4daf-ad50-2eb9b54f39b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc3a768b-b20b-4daf-ad50-2eb9b54f39b8'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc3a768b-b20b-4daf-ad50-2eb9b54f39b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b511805-0675-4eb9-aa58-63ff437380cd', 1, NULL, 'Prelude I alla Haydn', 'No. 1. Prelude I alla Haydn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b511805-0675-4eb9-aa58-63ff437380cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a41ffbaa-00df-4a91-b9a9-063701b9c6c3', 2, NULL, 'Prelude II alla Haydn', 'No. 2. Prelude II alla Haydn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41ffbaa-00df-4a91-b9a9-063701b9c6c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b386d8-c676-4694-a65d-e0c7f6a759fe', 3, NULL, 'Prelude I alla Kozeluch', 'No. 3. Prelude I alla Kozeluch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b386d8-c676-4694-a65d-e0c7f6a759fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb482d0-b1e8-4fb4-bc51-343cb7d1f3f5', 4, NULL, 'Prelude II alla Kozeluch', 'No. 4. Prelude II alla Kozeluch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb482d0-b1e8-4fb4-bc51-343cb7d1f3f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f8b01b-b3cf-40f4-96ac-2425bc453e9c', 5, NULL, 'Prelude I alla Mozart', 'No. 5. Prelude I alla Mozart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f8b01b-b3cf-40f4-96ac-2425bc453e9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65766de-e73f-4553-b414-933c48d34982', 6, NULL, 'Prelude II alla Mozart', 'No. 6. Prelude II alla Mozart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65766de-e73f-4553-b414-933c48d34982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c47b4d54-75f8-44d1-aebf-44710862bf6c', 7, NULL, 'Prelude I alla Sterkel', 'No. 7. Prelude I alla Sterkel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c47b4d54-75f8-44d1-aebf-44710862bf6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:377831de-b57a-46a9-a945-34c904789042', 8, NULL, 'Prelude II alla Sterkel', 'No. 8. Prelude II alla Sterkel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:377831de-b57a-46a9-a945-34c904789042'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c4344e-1eaa-43ae-9281-0e9fed3b08e3', 9, NULL, 'Prelude I alla Vanhal', 'No. 9. Prelude I alla Vanhal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c4344e-1eaa-43ae-9281-0e9fed3b08e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87cc2340-fd19-431d-9ba3-bbe1d7627abe', 10, NULL, 'Prelude II alla Vanhal', 'No. 10. Prelude II alla Vanhal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87cc2340-fd19-431d-9ba3-bbe1d7627abe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa342c4-97fe-4fae-a911-5b18882c1f45', 11, NULL, 'Prelude I alla Clementi', 'No. 11. Prelude I alla Clementi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa342c4-97fe-4fae-a911-5b18882c1f45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:298aa4cf-a815-453a-bd5b-c33f81f19f0f', 12, NULL, 'Prelude II alla Clementi', 'No. 12. Prelude II alla Clementi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<음악적 특성>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298aa4cf-a815-453a-bd5b-c33f81f19f0f'
);


-- Op. 20 피아노 소나타 C장조 Op. 20

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 C장조 Op. 20', 'Sonata in C major, op. 20', 'album', NULL, 'Op.', '20', 1787, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 C장조 Op. 20'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe2a8d92-a8ba-4dc9-b0b7-05e3ef6791dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe2a8d92-a8ba-4dc9-b0b7-05e3ef6791dc'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 C장조 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe2a8d92-a8ba-4dc9-b0b7-05e3ef6791dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:275844d4-cf55-4170-8dbe-59b10688cab3', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 C장조 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:275844d4-cf55-4170-8dbe-59b10688cab3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c368881-6b6e-4654-8bd3-89e4f809c335', 2, 'II', 'Larghetto con espressione', 'II. Larghetto con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 C장조 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c368881-6b6e-4654-8bd3-89e4f809c335'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b7e3c3-f0ba-4a49-9baa-9c7611c6b78c', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 C장조 Op. 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b7e3c3-f0ba-4a49-9baa-9c7611c6b78c'
);


-- WoO 3 피아노 소나타 F장조 WoO 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 F장조 WoO 3', 'Sonata in F major, WO3', 'album', NULL, 'WoO', '3', 1789, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 F장조 WoO 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea49850d-3445-4dba-bb9f-9d033e6be011'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea49850d-3445-4dba-bb9f-9d033e6be011'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 WoO 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea49850d-3445-4dba-bb9f-9d033e6be011'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:988e01fa-e89f-4207-89ed-8f2f7f2a8def', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 WoO 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:988e01fa-e89f-4207-89ed-8f2f7f2a8def'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d85c22e-aa81-460b-a4b4-6b3c61c731f2', 2, 'II', '론도. Spiritoso', 'II. Rondeau. Spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 WoO 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d85c22e-aa81-460b-a4b4-6b3c61c731f2'
);


-- Op. 23 피아노 소나타 Op. 23

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 23', '3 Piano Sonatas, op. 23', 'album', NULL, 'Op.', '23', 1790, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 23'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd1b7254-8887-4e8a-8c1f-dc6ad7d15821'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd1b7254-8887-4e8a-8c1f-dc6ad7d15821'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd1b7254-8887-4e8a-8c1f-dc6ad7d15821'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:276f6a76-2203-4a15-b84e-fa9bfc253c8e', 1, NULL, '피아노 소나타 1번 E♭장조', 'Sonata in E-flat major, op. 23 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276f6a76-2203-4a15-b84e-fa9bfc253c8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2594c39-5fee-4754-acaf-66b51b96ffec', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276f6a76-2203-4a15-b84e-fa9bfc253c8e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2594c39-5fee-4754-acaf-66b51b96ffec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83e8c806-1c13-4632-b342-86c232f29d6c', 2, 'II', '론도. Vivace', 'II. Rondeau. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276f6a76-2203-4a15-b84e-fa9bfc253c8e'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e8c806-1c13-4632-b342-86c232f29d6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf011fa8-56db-4cc6-b13f-4e6c404e6ae5', 2, NULL, '피아노 소나타 2번 F장조', 'Sonata in F major, op. 23 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf011fa8-56db-4cc6-b13f-4e6c404e6ae5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2fa5eb95-d87b-42c3-93df-b98df7665444', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf011fa8-56db-4cc6-b13f-4e6c404e6ae5'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa5eb95-d87b-42c3-93df-b98df7665444'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e35529e7-0604-440b-af02-ff796408b627', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf011fa8-56db-4cc6-b13f-4e6c404e6ae5'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e35529e7-0604-440b-af02-ff796408b627'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f63c759-2ba0-4dfe-8b43-795e93c91815', 3, 'III', '론도. Allegretto con spirito', 'III. Rondo. Allegretto con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf011fa8-56db-4cc6-b13f-4e6c404e6ae5'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f63c759-2ba0-4dfe-8b43-795e93c91815'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88bbe484-8153-439f-871f-d4df329534f1', 3, NULL, '피아노 소나타 3번 E♭장조', 'Sonata in E-flat major, op. 23 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88bbe484-8153-439f-871f-d4df329534f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8423c95b-0120-4966-a3c4-66d407137ce0', 1, 'I', 'Allegro con vivacita', 'I. Allegro con vivacita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88bbe484-8153-439f-871f-d4df329534f1'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8423c95b-0120-4966-a3c4-66d407137ce0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16c68c8f-ffeb-42fa-b11a-76bb22542300', 2, 'II', '주제와 변주. Allegretto vivace', 'II. Air with Variations. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88bbe484-8153-439f-871f-d4df329534f1'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c68c8f-ffeb-42fa-b11a-76bb22542300'
);


-- Op. 24 피아노 소나타 Op. 24

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 24', '2 Piano Sonatas, op. 24', 'album', NULL, 'Op.', '24', NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 24'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0a31fd2-adaf-47ec-9ba7-539b2e665b6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0a31fd2-adaf-47ec-9ba7-539b2e665b6c'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0a31fd2-adaf-47ec-9ba7-539b2e665b6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbf443b0-51ff-4a96-af92-c9e8ca726b89', 1, NULL, '피아노 소나타 1번 F장조', 'Sonata in F major, op. 24 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf443b0-51ff-4a96-af92-c9e8ca726b89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cef355f7-69b9-418d-931c-302a71bf1066', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbf443b0-51ff-4a96-af92-c9e8ca726b89'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cef355f7-69b9-418d-931c-302a71bf1066'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6567abec-99f0-42c5-93cc-395c40430bc7', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbf443b0-51ff-4a96-af92-c9e8ca726b89'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6567abec-99f0-42c5-93cc-395c40430bc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0fb5e7a8-81fb-4aa0-bbe6-a8b2430fdff6', 3, 'III', 'Arietta con variazione. Vivace', 'III. Arietta con variazione. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bbf443b0-51ff-4a96-af92-c9e8ca726b89'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fb5e7a8-81fb-4aa0-bbe6-a8b2430fdff6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37640ffb-6751-435a-bee6-3636dea2f1e9', 2, NULL, '피아노 소나타 2번 B♭장조', 'Sonata in B-flat major, op. 24 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37640ffb-6751-435a-bee6-3636dea2f1e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3961ece-ed91-46aa-911d-c0a51ebf2fcd', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37640ffb-6751-435a-bee6-3636dea2f1e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3961ece-ed91-46aa-911d-c0a51ebf2fcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:832498ec-5bb2-419c-bdf8-d9dee38dd020', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37640ffb-6751-435a-bee6-3636dea2f1e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:832498ec-5bb2-419c-bdf8-d9dee38dd020'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d17dab6b-10d8-4c0e-aedf-20bd2301f401', 3, 'III', '론도. Allegro assai', 'III. Rondo. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:37640ffb-6751-435a-bee6-3636dea2f1e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 24' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17dab6b-10d8-4c0e-aedf-20bd2301f401'
);


-- Op. 25 피아노 소나타 Op. 25

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 25', '6 Piano Sonatas, op. 25', 'album', NULL, 'Op.', '25', 1790, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 25'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d7fde80-99aa-42a1-bf0e-e4c4347d41ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d7fde80-99aa-42a1-bf0e-e4c4347d41ec'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d7fde80-99aa-42a1-bf0e-e4c4347d41ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d23d630-46a7-4b8e-aa68-09bfe69a5df9', 1, NULL, '피아노 소나타 1번 C장조', 'Sonata in C major, op. 25 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d23d630-46a7-4b8e-aa68-09bfe69a5df9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8a5d4b3-574d-4ffa-9afe-733c27c0e8da', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d23d630-46a7-4b8e-aa68-09bfe69a5df9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8a5d4b3-574d-4ffa-9afe-733c27c0e8da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5d996a9-9b49-4aaf-b4e4-b14d1c3d4717', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d23d630-46a7-4b8e-aa68-09bfe69a5df9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5d996a9-9b49-4aaf-b4e4-b14d1c3d4717'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb03d763-7e10-4be2-99de-930689e2b25e', 3, 'III', '론도. Presto', 'III. Rondeau. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d23d630-46a7-4b8e-aa68-09bfe69a5df9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb03d763-7e10-4be2-99de-930689e2b25e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6163bd02-80e5-4b26-90e3-9a41f979e5be', 2, NULL, '피아노 소나타 2번 G장조', 'Sonata in G major, op. 25 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6163bd02-80e5-4b26-90e3-9a41f979e5be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7200470b-1e2f-45a1-9e36-c145eddfd5f1', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6163bd02-80e5-4b26-90e3-9a41f979e5be'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7200470b-1e2f-45a1-9e36-c145eddfd5f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74d5ac04-5996-456d-9e82-eff47fa39924', 2, 'II', 'Rondo un poco allegro', 'II. Rondo un poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6163bd02-80e5-4b26-90e3-9a41f979e5be'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74d5ac04-5996-456d-9e82-eff47fa39924'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9996a20e-83cd-47f7-88a4-ef98f90dcb0a', 3, NULL, '피아노 소나타 3번 B♭장조', 'Sonata in B-flat major, op. 25 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9996a20e-83cd-47f7-88a4-ef98f90dcb0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56057d27-2bde-4974-bb8e-ae1f754f9b69', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9996a20e-83cd-47f7-88a4-ef98f90dcb0a'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56057d27-2bde-4974-bb8e-ae1f754f9b69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd99fca1-c12a-4a30-bc3f-ba77fc931e6c', 2, 'II', '론도. Vivace', 'II. Rondo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9996a20e-83cd-47f7-88a4-ef98f90dcb0a'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd99fca1-c12a-4a30-bc3f-ba77fc931e6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03f64e32-e66b-413f-9067-d11f7a2374ac', 4, NULL, '피아노 소나타 4번 A장조', 'Sonata in A major, op. 25 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f64e32-e66b-413f-9067-d11f7a2374ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:627940ce-15de-4881-a81b-ae8eaab03f6b', 1, 'I', 'Maestoso e cantabile', 'I. Maestoso e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03f64e32-e66b-413f-9067-d11f7a2374ac'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:627940ce-15de-4881-a81b-ae8eaab03f6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56bfa954-a333-4e05-993a-1fb1665d92a4', 2, 'II', 'Molto allegro', 'II. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:03f64e32-e66b-413f-9067-d11f7a2374ac'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56bfa954-a333-4e05-993a-1fb1665d92a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ae9f4f-b22f-4294-953f-becf38611e50', 5, NULL, '피아노 소나타 5번 F#단조', 'Sonata in F-sharp minor, op. 25 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ae9f4f-b22f-4294-953f-becf38611e50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f51af193-7138-4e16-9fb5-8cde33340477', 1, 'I', 'Più tosto allegro con espressione', 'I. Più tosto allegro con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:69ae9f4f-b22f-4294-953f-becf38611e50'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f51af193-7138-4e16-9fb5-8cde33340477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ef7b5b3-8b34-4930-aa3b-bbcbe9ad4e92', 2, 'II', 'Lento e patetico', 'II. Lento e patetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:69ae9f4f-b22f-4294-953f-becf38611e50'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ef7b5b3-8b34-4930-aa3b-bbcbe9ad4e92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:424a7f46-1807-4c2f-95ee-de5e2846304c', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:69ae9f4f-b22f-4294-953f-becf38611e50'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424a7f46-1807-4c2f-95ee-de5e2846304c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6cbe808-d56f-423d-b5ab-cae6b8435ad9', 6, NULL, '피아노 소나타 6번 D장조', 'Sonata in D major, op. 25 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6cbe808-d56f-423d-b5ab-cae6b8435ad9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83d03c17-50bf-4f01-814e-b831d9d1fc9f', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e6cbe808-d56f-423d-b5ab-cae6b8435ad9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83d03c17-50bf-4f01-814e-b831d9d1fc9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12d1309f-13d4-437c-9b91-4ee3bb266daf', 2, 'II', 'Un poco andante', 'II. Un poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e6cbe808-d56f-423d-b5ab-cae6b8435ad9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d1309f-13d4-437c-9b91-4ee3bb266daf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bded4fd9-70da-4057-ad7c-c757f0f813d7', 3, 'III', '론도. Allegro assai', 'III. Rondo. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e6cbe808-d56f-423d-b5ab-cae6b8435ad9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bded4fd9-70da-4057-ad7c-c757f0f813d7'
);


-- Op. 26 피아노 소나타 F장조 Op. 26

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 F장조 Op. 26', 'Sonata in F major, op. 26', 'album', NULL, 'Op.', '26', 1791, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 F장조 Op. 26'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835b634d-f27d-43ab-a7f6-065e3329f638'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '835b634d-f27d-43ab-a7f6-065e3329f638'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835b634d-f27d-43ab-a7f6-065e3329f638'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50852d33-678c-4745-b3d8-edda70df02f4', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50852d33-678c-4745-b3d8-edda70df02f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a531050-4988-4808-b95d-3a1450cf73c8', 2, 'II', '론도. Allegretto', 'II. Rondeau. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 F장조 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a531050-4988-4808-b95d-3a1450cf73c8'
);


-- Op. 33 피아노 소나타 Op. 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 33', '3 Piano Sonatas, op. 33', 'album', NULL, 'Op.', '33', 1794, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 33'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6799800a-5af4-4684-887b-d349e1da128f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6799800a-5af4-4684-887b-d349e1da128f'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6799800a-5af4-4684-887b-d349e1da128f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a867a5b-cace-499d-b51a-6d04af4ac94a', 1, NULL, '피아노 소나타 1번 A장조', 'Sonata in A major, op. 33 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a867a5b-cace-499d-b51a-6d04af4ac94a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8013df7-8548-4e1d-aefa-e427655248a6', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a867a5b-cace-499d-b51a-6d04af4ac94a'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8013df7-8548-4e1d-aefa-e427655248a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba4fce3a-ed3f-4fe4-ac08-c3853048352f', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1a867a5b-cace-499d-b51a-6d04af4ac94a'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4fce3a-ed3f-4fe4-ac08-c3853048352f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db129f17-101b-4a58-a174-82bb40b3714c', 2, NULL, '피아노 소나타 2번 F장조', 'Sonata in F major, op. 33 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db129f17-101b-4a58-a174-82bb40b3714c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b193505-34dd-42f0-8e6d-3b6f09748bf7', 1, 'I', 'Adagio - Allegro con fuoco', 'I. Adagio - Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db129f17-101b-4a58-a174-82bb40b3714c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b193505-34dd-42f0-8e6d-3b6f09748bf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ef6c5d4-9b0c-4591-b7dc-35f5ece58511', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db129f17-101b-4a58-a174-82bb40b3714c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef6c5d4-9b0c-4591-b7dc-35f5ece58511'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:503db788-00aa-4868-991d-d8415eac043c', 3, NULL, '피아노 소나타 3번 C장조', 'Sonata in C major, op. 33 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:503db788-00aa-4868-991d-d8415eac043c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fad12bdd-7189-4d22-baea-003e324f9ef6', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:503db788-00aa-4868-991d-d8415eac043c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad12bdd-7189-4d22-baea-003e324f9ef6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb48fe4f-15f5-4938-82dc-ea987da2b61c', 2, 'II', 'Adagio e cantabile con grand'' espressione', 'II. Adagio e cantabile con grand'' espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:503db788-00aa-4868-991d-d8415eac043c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb48fe4f-15f5-4938-82dc-ea987da2b61c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a14e82b4-85f1-405e-a44b-f370657977c9', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:503db788-00aa-4868-991d-d8415eac043c'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14e82b4-85f1-405e-a44b-f370657977c9'
);


-- Op. 34 피아노 소나타와 카프리치오 Op. 34

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타와 카프리치오 Op. 34', '2 Piano Sonatas and 2 Capriccios, op. 34', 'album', NULL, 'Op.', '34', 1795, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타와 카프리치오 Op. 34'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '939ce3da-ba61-4397-82d1-a5d1bba083f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '939ce3da-ba61-4397-82d1-a5d1bba083f4'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '939ce3da-ba61-4397-82d1-a5d1bba083f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0eeba0-0900-494e-b1d9-f88c7b8c03aa', 1, NULL, '피아노 소나타 1번 C장조', 'Sonata in C major, op. 34 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0eeba0-0900-494e-b1d9-f88c7b8c03aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7957e3a9-1293-4d6c-a37d-d4cf3e2e0d67', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b0eeba0-0900-494e-b1d9-f88c7b8c03aa'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7957e3a9-1293-4d6c-a37d-d4cf3e2e0d67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc881f01-c202-4e9e-9a90-315ce2a12463', 2, 'II', 'Un poco andante, quasi allegretto', 'II. Un poco andante, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b0eeba0-0900-494e-b1d9-f88c7b8c03aa'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc881f01-c202-4e9e-9a90-315ce2a12463'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:122a4581-0d5a-4cc4-877d-d36372ed624f', 3, 'III', '피날레. Allegro', 'III. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b0eeba0-0900-494e-b1d9-f88c7b8c03aa'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:122a4581-0d5a-4cc4-877d-d36372ed624f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b126657-7220-4dc2-a515-c3bdf08cdfb3', 2, NULL, '피아노 소나타 2번 G단조', 'Sonata in G minor, op. 34 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b126657-7220-4dc2-a515-c3bdf08cdfb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83eb76b8-686c-430c-8949-c35ded1b36e8', 1, 'I', 'Largo e sostenuto - Allegro con fuoco', 'I. Largo e sostenuto - Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b126657-7220-4dc2-a515-c3bdf08cdfb3'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83eb76b8-686c-430c-8949-c35ded1b36e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:618a49ba-17c3-4a52-a307-a29da41737cb', 2, 'II', 'Un poco adagio', 'II. Un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b126657-7220-4dc2-a515-c3bdf08cdfb3'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618a49ba-17c3-4a52-a307-a29da41737cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a24c4ed-6711-41bd-802d-19bb8ab21018', 3, 'III', '피날레. Molto allegro', 'III. Finale. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3b126657-7220-4dc2-a515-c3bdf08cdfb3'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a24c4ed-6711-41bd-802d-19bb8ab21018'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84057960-eb44-4eb8-b007-580b9ab31adb', 3, NULL, '카프리치오 3번 A장조', 'Capriccio in A major, op. 34 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84057960-eb44-4eb8-b007-580b9ab31adb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0285a20d-3c1e-4b7e-a391-4a1901075af2', 4, NULL, '카프리치오 4번 F장조', 'Capriccio in F major, op. 34 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타와 카프리치오 Op. 34' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0285a20d-3c1e-4b7e-a391-4a1901075af2'
);


-- WoO 12 피아노 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 C장조', 'Piano Concerto in C major', 'album', 'WoO 12', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92e90947-9d30-40dd-b075-fa3c74699900'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92e90947-9d30-40dd-b075-fa3c74699900'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92e90947-9d30-40dd-b075-fa3c74699900'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb04239-36e6-4649-b8a5-3940d8fa23b0', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb04239-36e6-4649-b8a5-3940d8fa23b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452ab04e-5baa-4ee9-9b0b-868e4a3141b6', 2, 'II', 'Adagio e cantabile con grand'' espressione', 'II. Adagio e cantabile con grand'' espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452ab04e-5baa-4ee9-9b0b-868e4a3141b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4959f70-02bc-4448-95ad-ef3a9cd7a991', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4959f70-02bc-4448-95ad-ef3a9cd7a991'
);


-- Op. 37 피아노 소나타 Op. 37

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 37', '3 Piano Sonatas, op. 37', 'album', NULL, 'Op.', '37', 1798, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 37'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '948ede86-3ea5-4405-912d-320871c61448'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '948ede86-3ea5-4405-912d-320871c61448'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '948ede86-3ea5-4405-912d-320871c61448'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04fa7041-1e71-4db1-ab40-19acbf1236e9', 1, NULL, '피아노 소나타 1번 C장조', 'Sonata in C major, op. 37 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04fa7041-1e71-4db1-ab40-19acbf1236e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0cff6d5d-a921-48a9-9f60-5dfc2feb9567', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:04fa7041-1e71-4db1-ab40-19acbf1236e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cff6d5d-a921-48a9-9f60-5dfc2feb9567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbfd95c0-30c5-44d7-bf8f-458bd921c180', 2, 'II', 'Adagio sostenuto', 'II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:04fa7041-1e71-4db1-ab40-19acbf1236e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbfd95c0-30c5-44d7-bf8f-458bd921c180'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d529dbad-e129-4056-9f29-f7bacea5c294', 3, 'III', '피날레. Vivace', 'III. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:04fa7041-1e71-4db1-ab40-19acbf1236e9'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d529dbad-e129-4056-9f29-f7bacea5c294'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b88fb267-443c-466e-b495-a17612e66907', 2, NULL, '피아노 소나타 2번 G장조', 'Sonata in G major, op. 37 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88fb267-443c-466e-b495-a17612e66907'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5669c06f-3021-44e5-bd48-d07aa2dd71d8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b88fb267-443c-466e-b495-a17612e66907'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5669c06f-3021-44e5-bd48-d07aa2dd71d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65228b8e-37a6-46fe-a076-8f81b46160a8', 2, 'II', 'Adagio (in the Solemn Style)', 'II. Adagio (in the Solemn Style)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b88fb267-443c-466e-b495-a17612e66907'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65228b8e-37a6-46fe-a076-8f81b46160a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48274fd5-a62e-4d88-8fd2-c747a2bc72a3', 3, 'III', 'Allegro con spirito', 'III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b88fb267-443c-466e-b495-a17612e66907'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48274fd5-a62e-4d88-8fd2-c747a2bc72a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b62ccf98-6330-4b2d-8ddc-ecd245d15bc4', 3, NULL, '피아노 소나타 3번 D장조', 'Sonata in D major, op. 37 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62ccf98-6330-4b2d-8ddc-ecd245d15bc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:117f5da4-45ec-45e9-a4d9-d188aa7f35e8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b62ccf98-6330-4b2d-8ddc-ecd245d15bc4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:117f5da4-45ec-45e9-a4d9-d188aa7f35e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f9b2df7-0400-449f-8d56-6a19bd73c611', 2, 'II', 'Allegretto vivace', 'II. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b62ccf98-6330-4b2d-8ddc-ecd245d15bc4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f9b2df7-0400-449f-8d56-6a19bd73c611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9696170a-3e07-4a63-b9bb-62856882b08a', 3, 'III', '피날레. Presto', 'III. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b62ccf98-6330-4b2d-8ddc-ecd245d15bc4'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9696170a-3e07-4a63-b9bb-62856882b08a'
);


-- Op. 40 피아노 소나타 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 40', '3 Piano Sonatas, op. 40', 'album', NULL, 'Op.', '40', 1802, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eda9d9d8-8de2-48e9-8ed7-92170c488e74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eda9d9d8-8de2-48e9-8ed7-92170c488e74'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eda9d9d8-8de2-48e9-8ed7-92170c488e74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958', 1, NULL, '피아노 소나타 1번 G장조', 'Piano Sonata in G major, op. 40 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5460cf5-380d-479c-b790-a284dbe46d1b', 1, 'I', 'Allegro molto vivace', 'I. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5460cf5-380d-479c-b790-a284dbe46d1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a602a2a1-6c1d-4974-a174-1c340a9ba7ad', 2, 'II', 'Adagio. Sostenuto e cantabile', 'II. Adagio. Sostenuto e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a602a2a1-6c1d-4974-a174-1c340a9ba7ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4d93e3d-35f8-40ed-8884-48001c3013c9', 3, 'III', 'Allegro. Canone primo perpetuo, per moto retto - Canone secondo perpetuo, per moto contrario', 'III. Allegro. Canone primo perpetuo, per moto retto - Canone secondo perpetuo, per moto contrario', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4d93e3d-35f8-40ed-8884-48001c3013c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e059326-19a9-4766-91c9-89cf8ef3e995', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:827705d6-ba9a-488f-a567-c12932c76958'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e059326-19a9-4766-91c9-89cf8ef3e995'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18311fd3-0b37-4dc5-852c-f76c03d1f035', 2, NULL, '피아노 소나타 2번 B단조', 'Piano Sonata in B minor, op. 40 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18311fd3-0b37-4dc5-852c-f76c03d1f035'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:363ca665-b74b-4df7-8db1-b17ff5616c16', 1, 'I', 'Molto adagio e sostenuto - Allegro con fuoco, e con espressione', 'I. Molto adagio e sostenuto - Allegro con fuoco, e con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18311fd3-0b37-4dc5-852c-f76c03d1f035'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:363ca665-b74b-4df7-8db1-b17ff5616c16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcd208a2-20c7-4937-b969-aff5e666aac6', 2, 'II', 'Largo, mesto e patetico - Allegro - Tempo primo - Presto', 'II. Largo, mesto e patetico - Allegro - Tempo primo - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18311fd3-0b37-4dc5-852c-f76c03d1f035'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcd208a2-20c7-4937-b969-aff5e666aac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dc62e90-710d-4a26-9083-9130b76a6bcb', 3, NULL, '피아노 소나타 3번 D장조', 'Piano Sonata in D major, op. 40 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc62e90-710d-4a26-9083-9130b76a6bcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0ca5fc9-595d-45fe-ac8f-7b28848e3473', 1, 'I', 'Adagio molto - Allegro', 'I. Adagio molto - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc62e90-710d-4a26-9083-9130b76a6bcb'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ca5fc9-595d-45fe-ac8f-7b28848e3473'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2ff9b78-ab39-4523-b066-41703fa23572', 2, 'II', 'Adagio con molta espressione', 'II. Adagio con molta espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc62e90-710d-4a26-9083-9130b76a6bcb'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2ff9b78-ab39-4523-b066-41703fa23572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:139399c6-732c-4721-89ff-5a6f4ab82cfd', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3dc62e90-710d-4a26-9083-9130b76a6bcb'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139399c6-732c-4721-89ff-5a6f4ab82cfd'
);


-- Op. 41 피아노 소나타 E♭장조 Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 E♭장조 Op. 41', 'Sonata in E-flat major, op. 41', 'album', NULL, 'Op.', '41', 1803, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 E♭장조 Op. 41'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebf6562d-e095-43b7-a05e-4bd14dbefab1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ebf6562d-e095-43b7-a05e-4bd14dbefab1'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebf6562d-e095-43b7-a05e-4bd14dbefab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5c0627f-4932-45db-8ee4-1588eaa20fc8', 1, 'I', 'Allegro ma con grazia', 'I. Allegro ma con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c0627f-4932-45db-8ee4-1588eaa20fc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff4c3c24-0032-4b13-8cb2-db15b70e0037', 2, 'II', 'Adagio molto e con anima', 'II. Adagio molto e con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff4c3c24-0032-4b13-8cb2-db15b70e0037'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e67f4b33-f072-4d32-bc83-c3bd091741f9', 3, 'III', 'Allegro molto vivace', 'III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 E♭장조 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e67f4b33-f072-4d32-bc83-c3bd091741f9'
);


-- Op. 46 피아노 소나타 B♭장조 Op. 46

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 B♭장조 Op. 46', 'Sonata in B-flat major, op. 46', 'album', NULL, 'Op.', '46', 1820, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 B♭장조 Op. 46'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47b7c74d-d1eb-4532-8bb8-7548b7821031'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47b7c74d-d1eb-4532-8bb8-7548b7821031'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 B♭장조 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47b7c74d-d1eb-4532-8bb8-7548b7821031'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb5b666-f81f-4a60-a682-469ba22dcabb', 1, 'I', '서주. Larghetto cantabile - Allegro con brio', 'I. Introduzione. Larghetto cantabile - Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 B♭장조 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb5b666-f81f-4a60-a682-469ba22dcabb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84d324b6-f5fd-42ce-8639-405bbfbfa271', 2, 'II', 'Adagio cantabile e sostenuto', 'II. Adagio cantabile e sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 B♭장조 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84d324b6-f5fd-42ce-8639-405bbfbfa271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ea38f06-2dad-4d50-99fc-c2915d2237a2', 3, 'III', '피날레. Allegro con fuoco', 'III. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 B♭장조 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ea38f06-2dad-4d50-99fc-c2915d2237a2'
);


-- WoO 10 <돈 조반니>의 "Batti, batti"에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<돈 조반니>의 "Batti, batti"에 의한 변주곡', 'Variations on “Batti batti” from Mozart’s “Don Giovanni”, WoO 10', 'song', 'WoO 10', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<돈 조반니>의 "Batti, batti"에 의한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a2d1310-d75d-4ad0-bdea-db23a3743049'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a2d1310-d75d-4ad0-bdea-db23a3743049'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<돈 조반니>의 "Batti, batti"에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a2d1310-d75d-4ad0-bdea-db23a3743049'
);


-- Op. 47 2개의 카프리치오 Op. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 카프리치오 Op. 47', '2 Capriccios, op. 47', 'album', NULL, 'Op.', '47', 1821, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 카프리치오 Op. 47'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '901e0432-1f55-468b-b987-6c5976bc6c4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '901e0432-1f55-468b-b987-6c5976bc6c4b'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '901e0432-1f55-468b-b987-6c5976bc6c4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94aa1a57-bba4-48a7-91b6-be72f224db02', 1, NULL, '카프리치오 1번 E단조', 'Capriccio in E minor, op. 47 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94aa1a57-bba4-48a7-91b6-be72f224db02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30a62043-2ad9-49b6-8abf-5aba74ff84ef', 1, 'I', 'Adagio - Allegro agitato', 'I. Adagio - Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94aa1a57-bba4-48a7-91b6-be72f224db02'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30a62043-2ad9-49b6-8abf-5aba74ff84ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd52b632-03a5-4d9a-b368-d8fbfb1cd654', 2, 'II', 'Adagio sostenuto', 'II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94aa1a57-bba4-48a7-91b6-be72f224db02'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd52b632-03a5-4d9a-b368-d8fbfb1cd654'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:845cc110-2826-41f5-950e-489d7682cc61', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:94aa1a57-bba4-48a7-91b6-be72f224db02'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:845cc110-2826-41f5-950e-489d7682cc61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd3baa85-b25a-4c96-83e7-98a7fe27ecb7', 2, NULL, '카프리치오 2번 C장조', 'Capriccio in C major, op. 47 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd3baa85-b25a-4c96-83e7-98a7fe27ecb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d718c9c-dfa8-443c-ba75-63282801c788', 1, 'I', 'Adagio sostenuto - Allegro con espressione e passione', 'I. Adagio sostenuto - Allegro con espressione e passione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd3baa85-b25a-4c96-83e7-98a7fe27ecb7'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d718c9c-dfa8-443c-ba75-63282801c788'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:616fd028-2558-47dd-ad0f-4091858d1fc8', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd3baa85-b25a-4c96-83e7-98a7fe27ecb7'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:616fd028-2558-47dd-ad0f-4091858d1fc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a05204f6-2747-4256-90e4-bb8b81e2a094', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd3baa85-b25a-4c96-83e7-98a7fe27ecb7'
WHERE p.composer_id = 25 AND p.title = '2개의 카프리치오 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a05204f6-2747-4256-90e4-bb8b81e2a094'
);


-- Op. 48 <달빛 아래서>에 의한 환상곡과 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<달빛 아래서>에 의한 환상곡과 변주곡', 'Fantaisie and Variations on "Au clair de la lune", op. 48', 'song', 'Op. 48', NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<달빛 아래서>에 의한 환상곡과 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc40405e-59b8-49ab-b324-00c8e48f6aeb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc40405e-59b8-49ab-b324-00c8e48f6aeb'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '<달빛 아래서>에 의한 환상곡과 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc40405e-59b8-49ab-b324-00c8e48f6aeb'
);


-- Op. 49 12개의 몬페리나 Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '12개의 몬페리나 Op. 49', '12 monferrinas, op. 49', 'album', NULL, 'Op.', '49', 1821, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '12개의 몬페리나 Op. 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2849240c-bb6f-4431-bf11-14859d5c55c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2849240c-bb6f-4431-bf11-14859d5c55c3'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2849240c-bb6f-4431-bf11-14859d5c55c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:780c1b07-344b-46ac-85fa-8bbc2761f06b', 1, NULL, 'Allegro', 'No. 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:780c1b07-344b-46ac-85fa-8bbc2761f06b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17ce9f0-7be2-4ada-a4c1-5f0b5142b0fb', 2, NULL, 'Allegro non troppo', 'No. 2. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17ce9f0-7be2-4ada-a4c1-5f0b5142b0fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dda5ab0e-13de-4793-a655-fedd948eb8a6', 3, NULL, 'Allegretto con espressione', 'No. 3. Allegretto con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dda5ab0e-13de-4793-a655-fedd948eb8a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b30e20f2-cd8d-4949-b354-63a9907d6f5c', 4, NULL, 'Allegretto con molto', 'No. 4. Allegretto con molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b30e20f2-cd8d-4949-b354-63a9907d6f5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c1d5aee-772f-49d9-8cc8-e94dc08001f1', 5, NULL, 'Allegretto con grazia', 'No. 5. Allegretto con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c1d5aee-772f-49d9-8cc8-e94dc08001f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d16d4d50-6609-41b0-b15e-a7aa00b7db57', 6, NULL, 'Allegro', 'No. 6. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d16d4d50-6609-41b0-b15e-a7aa00b7db57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:818d9ab2-013e-4062-92a3-f4ceb4e47ff0', 7, NULL, 'Allegro vivace', 'No. 7. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:818d9ab2-013e-4062-92a3-f4ceb4e47ff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6850652-123e-4abc-9007-faae9c72a696', 8, NULL, 'Vivace assai', 'No. 8. Vivace assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6850652-123e-4abc-9007-faae9c72a696'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a2de036-efb8-4b3c-aa92-e5dd07238396', 9, NULL, 'Allegro moderato', 'No. 9. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a2de036-efb8-4b3c-aa92-e5dd07238396'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fff8dcdf-08d7-4bf0-b4be-a4902d3051e6', 10, NULL, 'Allegro moderato', 'No. 10. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff8dcdf-08d7-4bf0-b4be-a4902d3051e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24dc4dac-3d78-45ee-8f85-b26bb0735459', 11, NULL, 'Allegro non troppo', 'No. 11. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24dc4dac-3d78-45ee-8f85-b26bb0735459'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bae7efd-d677-4492-aadf-540cdfd72f48', 12, NULL, 'Allegro moderato', 'No. 12. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '12개의 몬페리나 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bae7efd-d677-4492-aadf-540cdfd72f48'
);


-- Op. 50 피아노 소나타 Op. 50

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 50', '3 Piano Sonatas, op. 50', 'album', NULL, 'Op.', '50', 1821, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 50'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7a9a139-fb34-44a5-9a87-078e33917142'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7a9a139-fb34-44a5-9a87-078e33917142'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7a9a139-fb34-44a5-9a87-078e33917142'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdbfb007-b060-4666-86fd-955beeb7dd42', 1, NULL, '피아노 소나타 1번 A장조', 'Sonata in A major, op. 50 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdbfb007-b060-4666-86fd-955beeb7dd42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa975dca-acd1-4ffb-ba44-347df7068016', 1, 'I', 'Allegro maestoso e con sentimento', 'I. Allegro maestoso e con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdbfb007-b060-4666-86fd-955beeb7dd42'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa975dca-acd1-4ffb-ba44-347df7068016'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ca2317e-69c1-4456-b9ec-376ec67e8de0', 2, 'II', 'Adagio sostenuto e patetico', 'II. Adagio sostenuto e patetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdbfb007-b060-4666-86fd-955beeb7dd42'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca2317e-69c1-4456-b9ec-376ec67e8de0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2146ef0e-c2a1-4c13-afc3-d0da9c25d75e', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bdbfb007-b060-4666-86fd-955beeb7dd42'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2146ef0e-c2a1-4c13-afc3-d0da9c25d75e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd9462a5-9550-45c6-8628-57175869dad1', 2, NULL, '피아노 소나타 2번 D단조', 'Sonata in D minor, op. 50 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd9462a5-9550-45c6-8628-57175869dad1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:226639da-dae9-4beb-9af9-203eb7282b68', 1, 'I', 'Allegro non troppo ma con energia', 'I. Allegro non troppo ma con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd9462a5-9550-45c6-8628-57175869dad1'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:226639da-dae9-4beb-9af9-203eb7282b68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a35b1f68-673f-4b00-adac-b7e272f74fcc', 2, 'II', 'Adagio con espressione', 'II. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd9462a5-9550-45c6-8628-57175869dad1'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a35b1f68-673f-4b00-adac-b7e272f74fcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a597667-1f93-429c-aa01-d4750f3890a0', 3, 'III', 'Allegro con fuoco, ma non troppo presto', 'III. Allegro con fuoco, ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd9462a5-9550-45c6-8628-57175869dad1'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a597667-1f93-429c-aa01-d4750f3890a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 115 AND linked.composer_id = 25), 'musicbrainz:52373e56-faab-4c9e-a7e7-51358b0241f7', 3, NULL, '피아노 소나타 3번 G단조 "버림받은 디도"', 'Sonata in G minor, op. 50 no. 3 "Didone abbandonata"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52373e56-faab-4c9e-a7e7-51358b0241f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46c7e09a-512d-4c6e-b774-e0533c75aefe', 1, 'I', 'Largo patetico e sostenuto - Allegro ma con espressione', 'I. Largo patetico e sostenuto - Allegro ma con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:52373e56-faab-4c9e-a7e7-51358b0241f7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46c7e09a-512d-4c6e-b774-e0533c75aefe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:085eebc2-2335-439c-801e-41eedcf89bad', 2, 'II', 'Adagio dolente', 'II. Adagio dolente -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:52373e56-faab-4c9e-a7e7-51358b0241f7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:085eebc2-2335-439c-801e-41eedcf89bad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aae00fef-d0d8-498c-b3f2-c148f1064d83', 3, 'III', 'Allegro agitato, e con disperazione', 'III. Allegro agitato, e con disperazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:52373e56-faab-4c9e-a7e7-51358b0241f7'
WHERE p.composer_id = 25 AND p.title = '피아노 소나타 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae00fef-d0d8-498c-b3f2-c148f1064d83'
);


-- WoO 32 교향곡 1번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 C장조', 'Symphony no. 1 in C major, WoO 32', 'album', 'WoO 32', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f182217-7281-40eb-af70-9fc12c0da709'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f182217-7281-40eb-af70-9fc12c0da709'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f182217-7281-40eb-af70-9fc12c0da709'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf19a325-17b8-4999-a06a-d3c0b8b1d89a', 1, 'I', 'Larghetto - Allegro vivace', 'I. Larghetto - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf19a325-17b8-4999-a06a-d3c0b8b1d89a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60652811-c4dc-4d2c-ab68-b4c8ade29d71', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60652811-c4dc-4d2c-ab68-b4c8ade29d71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dea659e-5d24-44a3-b269-a67eb0fa7864', 3, 'III', '미뉴에트. Allegretto - Trio', 'III. Minuetto. Allegretto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dea659e-5d24-44a3-b269-a67eb0fa7864'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e7a6253-8152-4222-9023-47dab5e4ddf7', 4, 'IV', '피날레. Allegro vivace - Animato e giocoso', 'IV. Finale. Allegro vivace - Animato e giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e7a6253-8152-4222-9023-47dab5e4ddf7'
);


-- WoO 33 교향곡 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 D장조', 'Symphony no. 2 in D major, WoO 33', 'album', 'WoO 33', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb1b02a0-1bc9-44e4-afb7-7e16259c08d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb1b02a0-1bc9-44e4-afb7-7e16259c08d3'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb1b02a0-1bc9-44e4-afb7-7e16259c08d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fddbc9d-ffc3-40b7-a907-0c2a3da68c79', 1, 'I', 'Adagio - Allegro', 'I. Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fddbc9d-ffc3-40b7-a907-0c2a3da68c79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:335a1056-53e3-4820-af1f-925940684ef5', 2, 'II', 'Larghetto cantabile', 'II. Larghetto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:335a1056-53e3-4820-af1f-925940684ef5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ca9e9bd-4beb-44c4-b52c-5dc1ce7e6b2c', 3, 'III', '미뉴에트. Allegretto', 'III. Minuetto: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ca9e9bd-4beb-44c4-b52c-5dc1ce7e6b2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7f5b481-959e-4d5e-b21c-088d756f69b3', 4, 'IV', '피날레. Presto', 'IV. Finale: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f5b481-959e-4d5e-b21c-088d756f69b3'
);


-- WoO 34 교향곡 3번 G장조 "그레이트 내셔널"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 G장조 "그레이트 내셔널"', 'Symphony no. 3 in G major, WoO 34, "Great National"', 'album', 'WoO 34', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 G장조 "그레이트 내셔널"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdb90bb9-a0d8-4535-8fd4-f36c9b4fb9a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdb90bb9-a0d8-4535-8fd4-f36c9b4fb9a6'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdb90bb9-a0d8-4535-8fd4-f36c9b4fb9a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62cf2430-9ce4-464c-9284-6132e6529689', 1, 'I', 'Andante sostenuto - Allegro con brio', 'I. Andante sostenuto - Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62cf2430-9ce4-464c-9284-6132e6529689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beabea97-f214-44df-80da-78bde654a36c', 2, 'II', 'Andante un poco mosso', 'II. Andante un poco mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beabea97-f214-44df-80da-78bde654a36c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f77f0c4-4cfd-4052-8849-a08b4595fdb4', 3, 'III', '미뉴에트. Allegretto', 'III. Minuetto: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f77f0c4-4cfd-4052-8849-a08b4595fdb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fee3c1f-a7fa-4e2d-9a03-803412e7c810', 4, 'IV', '피날레. Vivace', 'IV. Finale: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 3번 G장조 "그레이트 내셔널"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fee3c1f-a7fa-4e2d-9a03-803412e7c810'
);


-- WoO 35 교향곡 4번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 D장조', 'Symphony no. 4 in D major, WoO 35', 'album', 'WoO 35', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 25
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd50d20f2-ac51-4ed5-b19d-cc1d45740802'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd50d20f2-ac51-4ed5-b19d-cc1d45740802'
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 4번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd50d20f2-ac51-4ed5-b19d-cc1d45740802'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f45a48e-c66b-458b-9b7b-e8bcb9be07e8', 1, 'I', 'Andante sostenuto - Allegro vivace', 'I. Andante sostenuto - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 4번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f45a48e-c66b-458b-9b7b-e8bcb9be07e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b395d1e6-bb54-435d-a5b6-5790916353dd', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 4번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b395d1e6-bb54-435d-a5b6-5790916353dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6989221-51df-491b-ac8d-cf4726e379ec', 3, 'III', '미뉴에트. Allegro moderato', 'III. Minuetto: Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 4번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6989221-51df-491b-ac8d-cf4726e379ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e730028b-5546-4ec9-b765-5bdeb2ffd829', 4, 'IV', '피날레. Allegro vivace', 'IV. Finale: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 25 AND p.title = '교향곡 4번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e730028b-5546-4ec9-b765-5bdeb2ffd829'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 A♭장조 WoO 13' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 G장조 WoO 14' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 1a' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 2' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 7' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 8' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 9' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 10' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 E♭장조 Op. 11, No. 1' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'prelude_fugue'
WHERE composer_id = 25 AND title = '토카타 B♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 12' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 13' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 D장조 "사냥"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'fantasia'
WHERE composer_id = 25 AND title = '카프리치오 B♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 25 AND title = '교향곡 Op. 18' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'prelude_fugue'
WHERE composer_id = 25 AND title = '<음악적 특성>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 C장조 Op. 20' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 F장조 WoO 3' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 23' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 24' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 25' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 F장조 Op. 26' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 33' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타와 카프리치오 Op. 34' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'piano_concerto'
WHERE composer_id = 25 AND title = '피아노 협주곡 C장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 37' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 40' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 E♭장조 Op. 41' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 B♭장조 Op. 46' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'variations'
WHERE composer_id = 25 AND title = '<돈 조반니>의 "Batti, batti"에 의한 변주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'fantasia'
WHERE composer_id = 25 AND title = '2개의 카프리치오 Op. 47' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'variations'
WHERE composer_id = 25 AND title = '<달빛 아래서>에 의한 환상곡과 변주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'dance'
WHERE composer_id = 25 AND title = '12개의 몬페리나 Op. 49' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 25 AND title = '피아노 소나타 Op. 50' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 25 AND title = '교향곡 1번 C장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 25 AND title = '교향곡 2번 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 25 AND title = '교향곡 3번 G장조 "그레이트 내셔널"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 25 AND title = '교향곡 4번 D장조' AND genre IS NULL AND form_key IS NULL;
