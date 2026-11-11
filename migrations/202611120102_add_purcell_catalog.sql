-- 헨리 퍼셀(composer_id 8) 작품 목록. 지금은 작곡가 화면에 5곡(디도와 아이네이아스·디도의 탄식·요정 여왕·메리 여왕의 장례식 음악·압델라자르)뿐이다.
-- 작품 62개(새 58 + 기존 4), 묶음·다악장 작품 안 곡 194개, 그 안 악장 123개, 장르·형식.
--
-- 작품은 손으로 골랐다: 세미 오페라·가면극 4, 부수음악 11, 송가 14, 찬가·모테트·예배 음악 14, 종교 가곡 3, 노래 4, 기악 8
-- (비올 판타지아와 인 노미네, 3성부 소나타 1683·4성부 소나타 1697, 하프시코드 모음곡 1696 은 출판·자필 묶음).
-- 곡은 MusicBrainz parts 순서, 순서가 없는 송가는 곡 없이 두고, 손으로 엮은 묶음은 parts.tsv 순서다. 자료와 생성기:
--   seed_pipeline/curation/baroque-catalog-2026-11-12/(build.py, purcell/works.tsv·parts.tsv) → catalog-wave4 gen_catalog.py
-- 기존 4곡은 제목·설명·링크를 두고 MBID 와 곡만 잇는다. 「디도의 탄식」(35)은 오페라 대목이라 손대지 않는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- Z 626 오페라 <디도와 아이네이아스>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0043a9b7-1636-4c76-b73d-a53b323ec89f'
FROM pieces p
WHERE p.id = 34 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0043a9b7-1636-4c76-b73d-a53b323ec89f'
);


-- Z 629 세미 오페라 <요정 여왕>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6a5bb32-a3cd-4264-bcef-017b7bfa4006'
FROM pieces p
WHERE p.id = 36 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6a5bb32-a3cd-4264-bcef-017b7bfa4006'
);


-- Z 860 메리 여왕의 장례식 음악

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f07e744-d38f-4913-91a1-ca1bffef94ee'
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f07e744-d38f-4913-91a1-ca1bffef94ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '행진곡', part.name_en = 'Funeral Music on the Death of Queen Mary: I. March, Z. 860',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:d96aa317-bf90-3ded-bbd3-93d08882f19b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d96aa317-bf90-3ded-bbd3-93d08882f19b', 1, 'I', '행진곡', 'Funeral Music on the Death of Queen Mary: I. March, Z. 860', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d96aa317-bf90-3ded-bbd3-93d08882f19b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '찬가 <Man that is born of a woman>', part.name_en = 'Funeral Music on the Death of Queen Mary: II. Anthem, Z. 27 “Man that is born of a woman"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:d92b7b2c-b29c-3929-816b-8d8ea0c9645f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d92b7b2c-b29c-3929-816b-8d8ea0c9645f', 2, 'II', '찬가 <Man that is born of a woman>', 'Funeral Music on the Death of Queen Mary: II. Anthem, Z. 27 “Man that is born of a woman"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92b7b2c-b29c-3929-816b-8d8ea0c9645f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '칸초나', part.name_en = 'Funeral Music on the Death of Queen Mary: III. Canzona, Z. 860',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:be87eefb-1c10-3994-880f-833cdae8f72e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be87eefb-1c10-3994-880f-833cdae8f72e', 3, 'III', '칸초나', 'Funeral Music on the Death of Queen Mary: III. Canzona, Z. 860', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be87eefb-1c10-3994-880f-833cdae8f72e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '찬가 <In the midst of life>', part.name_en = 'Funeral Music on the Death of Queen Mary: IV. In the midst of life, Z. 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:6227dd3e-63eb-38cc-8c4e-f7db48d1eb84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6227dd3e-63eb-38cc-8c4e-f7db48d1eb84', 4, 'IV', '찬가 <In the midst of life>', 'Funeral Music on the Death of Queen Mary: IV. In the midst of life, Z. 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6227dd3e-63eb-38cc-8c4e-f7db48d1eb84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '칸초나', part.name_en = 'Funeral Music on the Death of Queen Mary: V. Canzona, Z. 860',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:668e3b8a-b2f7-34c8-9808-492b02f7d2ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:668e3b8a-b2f7-34c8-9808-492b02f7d2ae', 5, 'V', '칸초나', 'Funeral Music on the Death of Queen Mary: V. Canzona, Z. 860', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:668e3b8a-b2f7-34c8-9808-492b02f7d2ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '찬가 <Thou knowest, Lord>', part.name_en = 'Funeral Music on the Death of Queen Mary: VI. Anthem, Z. 58c "Thou knowest, Lord"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:a28e5059-080a-45b6-aae5-5e91708f0b87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a28e5059-080a-45b6-aae5-5e91708f0b87', 6, 'VI', '찬가 <Thou knowest, Lord>', 'Funeral Music on the Death of Queen Mary: VI. Anthem, Z. 58c "Thou knowest, Lord"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a28e5059-080a-45b6-aae5-5e91708f0b87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '행진곡', part.name_en = 'Funeral Music on the Death of Queen Mary: VII. March, Z. 860',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 37 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:92f28f68-a930-33a3-927d-d6a1dd58d022' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92f28f68-a930-33a3-927d-d6a1dd58d022', 7, 'VII', '행진곡', 'Funeral Music on the Death of Queen Mary: VII. March, Z. 860', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 37 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92f28f68-a930-33a3-927d-d6a1dd58d022'
);


-- Z 570 <압델라자르> 모음곡

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8fa953a-3b99-4af9-92f9-e2008237321e'
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8fa953a-3b99-4af9-92f9-e2008237321e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:31b51227-6250-4c11-ad30-9dc8b180cd94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31b51227-6250-4c11-ad30-9dc8b180cd94', 1, 'I', 'Overture', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31b51227-6250-4c11-ad30-9dc8b180cd94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rondeau', part.name_en = 'Incidental Music for Abdelazer, or, the Moor’s Revenge, Z 570: II. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:a9b40102-2591-4100-be02-fc436d745527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b40102-2591-4100-be02-fc436d745527', 2, 'II', 'Rondeau', 'Incidental Music for Abdelazer, or, the Moor’s Revenge, Z 570: II. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b40102-2591-4100-be02-fc436d745527'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Air in D', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: III. Air in D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:48331b5e-cbd3-40c4-9960-7ec0cbe4128a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48331b5e-cbd3-40c4-9960-7ec0cbe4128a', 3, 'III', 'Air in D', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: III. Air in D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48331b5e-cbd3-40c4-9960-7ec0cbe4128a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air in G', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: IV. Air in G',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:fec9cd28-05ec-4330-89a6-ac807c814a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fec9cd28-05ec-4330-89a6-ac807c814a16', 4, 'IV', 'Air in G', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: IV. Air in G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fec9cd28-05ec-4330-89a6-ac807c814a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Minuett in G', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: V. Minuett in G',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:d47b07ec-f0ca-4380-a14e-c60c966a506e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d47b07ec-f0ca-4380-a14e-c60c966a506e', 5, 'V', 'Minuett in G', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: V. Minuett in G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47b07ec-f0ca-4380-a14e-c60c966a506e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Air in g', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VI. Air in g',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:c60b4173-83d8-48e8-a1de-1f389976fd9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c60b4173-83d8-48e8-a1de-1f389976fd9b', 6, 'VI', 'Air in g', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VI. Air in g', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c60b4173-83d8-48e8-a1de-1f389976fd9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Jigg in g', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VII. Jigg in g',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:f3b922c8-43dd-49ff-b459-021f3af9ce78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b922c8-43dd-49ff-b459-021f3af9ce78', 7, 'VII', 'Jigg in g', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VII. Jigg in g', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b922c8-43dd-49ff-b459-021f3af9ce78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Hornpipe', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VIII. Hornpipe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:66c8df26-022c-4e40-b92e-fab052470db4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66c8df26-022c-4e40-b92e-fab052470db4', 8, 'VIII', 'Hornpipe', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: VIII. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66c8df26-022c-4e40-b92e-fab052470db4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Air in g', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: IX. Air in g',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:f297b2a5-7042-4c5e-b9f4-18841dd3ec65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f297b2a5-7042-4c5e-b9f4-18841dd3ec65', 9, 'IX', 'Air in g', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: IX. Air in g', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f297b2a5-7042-4c5e-b9f4-18841dd3ec65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Air', part.name_en = 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 38 AND p.composer_id = 8 AND part.part_key = 'musicbrainz:4634913a-3d85-3286-a5cb-ee2013cd4454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4634913a-3d85-3286-a5cb-ee2013cd4454', 10, 'X', 'Air', 'Incidental Music for Abdelazer, or, the Moor''s Revenge, Z 570: Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 38 AND p.composer_id = 8
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4634913a-3d85-3286-a5cb-ee2013cd4454'
);


-- Z 627 세미 오페라 <디오클레시안>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세미 오페라 <디오클레시안>', 'The Prophetess, or The History of Dioclesian, Z. 627', 'song', 'Z 627', NULL, NULL, 1690, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세미 오페라 <디오클레시안>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb0c2505-d585-4c4e-9e84-845e68fdc23b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb0c2505-d585-4c4e-9e84-845e68fdc23b'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '세미 오페라 <디오클레시안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb0c2505-d585-4c4e-9e84-845e68fdc23b'
);


-- Z 628 세미 오페라 <아서 왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세미 오페라 <아서 왕>', 'King Arthur, Z. 628', 'song', 'Z 628', NULL, NULL, 1691, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세미 오페라 <아서 왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5528d03-0f4b-4e93-bc8f-2f02d2425b48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5528d03-0f4b-4e93-bc8f-2f02d2425b48'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '세미 오페라 <아서 왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5528d03-0f4b-4e93-bc8f-2f02d2425b48'
);


-- Z 630 세미 오페라 <인도의 여왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세미 오페라 <인도의 여왕>', 'The Indian Queen, Z. 630', 'song', 'Z 630', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세미 오페라 <인도의 여왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7df68bbd-3379-4dde-9df9-db34a00461c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7df68bbd-3379-4dde-9df9-db34a00461c1'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '세미 오페라 <인도의 여왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7df68bbd-3379-4dde-9df9-db34a00461c1'
);


-- Z 632 가면극 <아테네의 타이먼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가면극 <아테네의 타이먼>', 'Timon of Athens', 'song', 'Z 632', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가면극 <아테네의 타이먼>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7aa8abcd-8eb4-478f-8ec2-b5e3e3ebab44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7aa8abcd-8eb4-478f-8ec2-b5e3e3ebab44'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '가면극 <아테네의 타이먼>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7aa8abcd-8eb4-478f-8ec2-b5e3e3ebab44'
);


-- Z 572 부수음악 <암피트리온>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <암피트리온>', 'Amphitryon, Z. 572', 'album', 'Z 572', NULL, NULL, 1690, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <암피트리온>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65320756-34d8-403c-80ee-fbfe5e5e50fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65320756-34d8-403c-80ee-fbfe5e5e50fc'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65320756-34d8-403c-80ee-fbfe5e5e50fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24014c2f-c8c7-312f-ab87-b5f60134aaf5', 1, 'I', 'Overture', 'Amphitryon, Z. 572 "The Two Sosias": I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24014c2f-c8c7-312f-ab87-b5f60134aaf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5aeae9a-6766-3f75-af77-9c432795862e', 2, 'II', 'Saraband', 'Amphitryon, Z. 572 "The Two Sosias": II. Saraband', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5aeae9a-6766-3f75-af77-9c432795862e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8577e889-df1b-3bc6-8de8-48d3a4dd3fb5', 3, 'III', 'Hornpipe', 'Amphitryon, Z. 572 "The Two Sosias": III. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8577e889-df1b-3bc6-8de8-48d3a4dd3fb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58c274da-2a30-3738-9a6a-e4cd91285dc0', 4, 'IV', 'Scotch Tune', 'Amphitryon, Z. 572 "The Two Sosias": IV. Scotch Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58c274da-2a30-3738-9a6a-e4cd91285dc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea12df3-5137-3a75-902b-8e0d3a81d9ff', 5, 'V', 'Air', 'Amphitryon, Z. 572 "The Two Sosias": V. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea12df3-5137-3a75-902b-8e0d3a81d9ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17e2b640-4f24-359c-a831-dde1f5db6c06', 6, 'VI', 'Minuet', 'Amphitryon, Z. 572 "The Two Sosias": VI. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e2b640-4f24-359c-a831-dde1f5db6c06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b671e529-caa2-32f5-a7cf-2d84825d72f1', 7, 'VII', 'Hornpipe', 'Amphitryon, Z. 572 "The Two Sosias": VII. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b671e529-caa2-32f5-a7cf-2d84825d72f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f2b6fc4-215a-36ae-97df-76a9887ad032', 8, 'VIII', 'Borree', 'Amphitryon, Z. 572 "The Two Sosias": VIII. Borree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <암피트리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2b6fc4-215a-36ae-97df-76a9887ad032'
);


-- Z 577 부수음악 <Distressed Innocence>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <Distressed Innocence>', 'Distressed Innocence, Z. 577', 'album', 'Z 577', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <Distressed Innocence>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61a43678-36f6-49c3-95aa-3a147c94f85f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61a43678-36f6-49c3-95aa-3a147c94f85f'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61a43678-36f6-49c3-95aa-3a147c94f85f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:209eada1-7191-4c7d-b1d7-33639b5af193', 1, 'I', 'Overture', 'Distress''d Innocence, Z. 577: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:209eada1-7191-4c7d-b1d7-33639b5af193'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1833dbdd-2e38-4afc-bce4-e3eaa40ab957', 2, 'II', 'Aire', 'Distress''d Innocence, Z. 577: II. Aire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1833dbdd-2e38-4afc-bce4-e3eaa40ab957'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b88ebe59-cdcc-42ce-9b4c-9ebfd5781aab', 3, 'III', 'Slow Aire', 'Distress''d Innocence, Z. 577: III. Slow Aire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88ebe59-cdcc-42ce-9b4c-9ebfd5781aab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b860bbcc-3eba-4af6-9d3f-91b23726d284', 4, 'IV', 'Aire', 'Distress''d Innocence, Z. 577: IV. Aire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b860bbcc-3eba-4af6-9d3f-91b23726d284'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5334a40d-1ec6-47bf-9d79-9e8f7e7b3450', 5, 'V', 'Hornpipe', 'Distress''d Innocence, Z. 577: V. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5334a40d-1ec6-47bf-9d79-9e8f7e7b3450'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73a527c4-d365-4fcf-919d-c62a31a1b38e', 6, 'VI', 'Rondeau', 'Distress''d Innocence, Z. 577: VI. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73a527c4-d365-4fcf-919d-c62a31a1b38e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7d6600-968c-47c8-a407-d6127037397c', 7, 'VII', 'Aire', 'Distress''d Innocence, Z. 577: VII. Aire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7d6600-968c-47c8-a407-d6127037397c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a9613a8-9b6d-4eab-843c-90bc96bf5d77', 8, 'VIII', 'Minuet', 'Distress''D Innocence, Z. 577: VIII. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <Distressed Innocence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a9613a8-9b6d-4eab-843c-90bc96bf5d77'
);


-- Z 597 부수음악 <The Gordian Knot Unty'd>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <The Gordian Knot Unty''d>', 'The Gordion Knot Unty’d, Z. 597', 'album', 'Z 597', NULL, NULL, 1691, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <The Gordian Knot Unty''d>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec08f227-700d-4372-8f6a-e6465756fa67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec08f227-700d-4372-8f6a-e6465756fa67'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec08f227-700d-4372-8f6a-e6465756fa67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3550c823-6b2d-3c24-a84e-65e187a766c5', 1, 'I', 'Overture', 'The Gordian Knot Unty’d, Z. 597: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3550c823-6b2d-3c24-a84e-65e187a766c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56007fdd-b4c3-366d-a8d5-22df23c4c2e3', 2, 'II', 'Air', 'The Gordian Knot Unty’d, Z. 597: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56007fdd-b4c3-366d-a8d5-22df23c4c2e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae6ab460-4a33-3512-bc0b-95164bbd4c2d', 3, 'III', 'Rondeau Minuet', 'The Gordian Knot Unty’d, Z. 597: III. Rondeau Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6ab460-4a33-3512-bc0b-95164bbd4c2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a68b0aaf-ffd1-3dfb-8451-9cace4fa0eac', 4, 'IV', 'Air', 'The Gordian Knot Unty’d, Z. 597: IV. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68b0aaf-ffd1-3dfb-8451-9cace4fa0eac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6726da2-c8b0-34fc-96b3-b9bc2df0c501', 5, 'V', 'Jig', 'The Gordian Knot Unty’d, Z. 597: V. Jig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6726da2-c8b0-34fc-96b3-b9bc2df0c501'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2fa0ad3-349c-3d53-9882-79e255fb1bcc', 6, 'VI', 'Chaconne', 'The Gordian Knot Unty’d, Z. 597: VI. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2fa0ad3-349c-3d53-9882-79e255fb1bcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e62d7162-1600-3ccf-b17b-2a3e6047d858', 7, 'VII', 'Air', 'The Gordian Knot Unty’d, Z. 597: VII. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e62d7162-1600-3ccf-b17b-2a3e6047d858'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:104a6191-a22d-3884-b4d1-eda2250fb33c', 8, 'VIII', 'Minuet', 'The Gordian Knot Unty’d, Z. 597: VIII. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Gordian Knot Unty''d>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104a6191-a22d-3884-b4d1-eda2250fb33c'
);


-- Z 600 부수음악 <The Libertine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <The Libertine>', 'The Libertine Destroyed, Z. 600', 'album', 'Z 600', NULL, NULL, 1692, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <The Libertine>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c8666e4-1a45-4e41-a015-469fdc8f3659'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c8666e4-1a45-4e41-a015-469fdc8f3659'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Libertine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c8666e4-1a45-4e41-a015-469fdc8f3659'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59cf0b07-2f50-4dca-b35a-7763c30d18f4', 1, 'I', 'Nymphs and shepherds / We come', 'The Libertine Destroyed, Z. 600: No. 1. "Nymphs and shepherds / We come"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Libertine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cf0b07-2f50-4dca-b35a-7763c30d18f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:061032ce-c137-43cc-8976-36d5d8903131', 2, 'II', 'Prelude and Song "Prepare, prepare, new guests draw near"', 'The Libertine Destroyed, Z. 600: No. 2. Prelude and Song "Prepare, prepare, new guests draw near"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Libertine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:061032ce-c137-43cc-8976-36d5d8903131'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aa0f666-1cc0-40af-b175-b178dd5ad9a1', 3, 'III', 'Prelude and Song "To arms, heroic prince"', 'The Libertine Destroyed, Z. 600: No. 3. Prelude and Song "To arms, heroic prince"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Libertine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa0f666-1cc0-40af-b175-b178dd5ad9a1'
);


-- Z 583 부수음악 <오이디푸스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <오이디푸스>', 'Oedipus, King of Thebes, Z. 583', 'album', 'Z 583', NULL, NULL, 1692, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <오이디푸스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f667a29a-3e6b-4eae-ac49-6192e21a8af6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f667a29a-3e6b-4eae-ac49-6192e21a8af6'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <오이디푸스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f667a29a-3e6b-4eae-ac49-6192e21a8af6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7921ad25-9d04-480e-a7be-88b671827579', 1, 'I', 'Hear, ye sullen pow''rs below', 'Oedipus, King of Thebes, Z. 583: I. Hear, ye sullen powʼrs below', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <오이디푸스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7921ad25-9d04-480e-a7be-88b671827579'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f511ef8-0600-3374-b4e0-b655bf314025', 2, 'II', 'Music for a while', 'Oedipus, King of Thebes, Z. 583: II. "Music for a While"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <오이디푸스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f511ef8-0600-3374-b4e0-b655bf314025'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f656805-5850-4147-943b-65fe9eca13ad', 3, 'III', 'Come away, do not stay', 'Oedipus, King of Thebes, Z. 583: III. Come away, do not stay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <오이디푸스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f656805-5850-4147-943b-65fe9eca13ad'
);


-- Z 607 부수음악 <The Old Bachelor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <The Old Bachelor>', 'The Old Bachelor, Z. 607', 'album', 'Z 607', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <The Old Bachelor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27c40aed-49ff-4b73-b068-aedc654939fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27c40aed-49ff-4b73-b068-aedc654939fb'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27c40aed-49ff-4b73-b068-aedc654939fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55979333-3937-3e62-a283-442593132199', 1, 'I', 'Overture', 'The Old Bachelor, Z. 607: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55979333-3937-3e62-a283-442593132199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f53ed57-009a-393f-aa06-c3f88d500b5f', 2, 'II', 'Hornpipe', 'The Old Bachelor, Z. 607: II. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f53ed57-009a-393f-aa06-c3f88d500b5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f70ded05-4ac7-37e9-8215-77328043b2c2', 3, 'III', 'Slow Air', 'The Old Bachelor, Z. 607: III. Slow Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f70ded05-4ac7-37e9-8215-77328043b2c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03e6fdab-2f28-3094-8378-611dad5b8fd5', 4, 'IV', 'Hornpipe', 'The Old Bachelor, Z. 607: IV. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e6fdab-2f28-3094-8378-611dad5b8fd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d71b12-a2f8-31fe-bd00-d3878ec42d06', 5, 'V', 'Rondeau', 'The Old Bachelor, Z. 607: V. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d71b12-a2f8-31fe-bd00-d3878ec42d06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c466eb48-6b2e-3b5e-97a0-e9536dd166de', 6, 'VI', 'Minuet', 'The Old Bachelor, Z. 607: VI. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c466eb48-6b2e-3b5e-97a0-e9536dd166de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d1b914-8395-344a-9bbf-e30d553d4fac', 7, 'VII', 'Bourree', 'The Old Bachelor, Z. 607: VII. Bourree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d1b914-8395-344a-9bbf-e30d553d4fac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:039e4f94-e2e7-3a74-a4ff-2c4d09f22939', 8, 'VIII', 'March', 'The Old Bachelor, Z. 607: VIII. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:039e4f94-e2e7-3a74-a4ff-2c4d09f22939'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:743f8854-88b2-3c18-bea8-b370ac74f640', 9, 'IX', 'Jig', 'The Old Bachelor, Z. 607: IX. Jig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:743f8854-88b2-3c18-bea8-b370ac74f640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:581eecd5-207e-4256-bd45-763fd3ddc5d9', 10, 'X', 'Thus to a Ripe, Consenting Maid', 'The Old Bachelor, Z. 607: X. Thus to a Ripe, Consenting Maid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:581eecd5-207e-4256-bd45-763fd3ddc5d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4cd5560-877b-4e13-92d6-2177fef73aa9', 11, 'XI', 'As Amoret and Thyrsis Lay', 'The Old Bachelor, Z. 607: XI. As Amoret and Thyrsis Lay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Old Bachelor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4cd5560-877b-4e13-92d6-2177fef73aa9'
);


-- Z 603 부수음악 <The Married Beau>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <The Married Beau>', 'The Married Beau, Z. 603 "The Curious Impertinent"', 'album', 'Z 603', NULL, NULL, 1694, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <The Married Beau>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91499999-6aa3-4f85-8797-33d4d024e6ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91499999-6aa3-4f85-8797-33d4d024e6ef'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91499999-6aa3-4f85-8797-33d4d024e6ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06e5034a-3c03-4dc7-a15f-26fb8df7d36d', 1, 'I', 'Overture', 'The Married Beau, Z. 603 "The Curious Impertinent": I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06e5034a-3c03-4dc7-a15f-26fb8df7d36d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e55305d-5db4-49e4-bef9-b243fad4d523', 2, 'II', 'Slow Air', 'The Married Beau, Z. 603 "The Curious Impertinent": II. Slow Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e55305d-5db4-49e4-bef9-b243fad4d523'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91a65588-ddda-46c3-a611-b3b1a82587da', 3, 'III', 'Hornpipe', 'The Married Beau, Z. 603 "The Curious Impertinent": III. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91a65588-ddda-46c3-a611-b3b1a82587da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27c63d3a-d40c-4a11-ac47-1a944c1a652f', 4, 'IV', 'Air', 'The Married Beau, Z. 603 "The Curious Impertinent": IV. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27c63d3a-d40c-4a11-ac47-1a944c1a652f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9742d03-c872-4152-b8a5-b10eadeff6ef', 5, 'V', 'Hornpipe', 'The Married Beau, Z. 603 "The Curious Impertinent": V. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9742d03-c872-4152-b8a5-b10eadeff6ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc038b4-670f-4b7e-91b9-ad9729a0939a', 6, 'VI', 'Jig', 'The Married Beau, Z. 603 "The Curious Impertinent": VI. Jig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc038b4-670f-4b7e-91b9-ad9729a0939a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c8bdf9-4443-4fad-98f0-24a7f19ccaca', 7, 'VII', 'Trumpet Air', 'The Married Beau, Z. 603 "The Curious Impertinent": VII. Trumpet Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c8bdf9-4443-4fad-98f0-24a7f19ccaca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5cc9868-4ed3-46a1-9fde-4a1ec3d11cee', 8, 'VIII', 'March', 'The Married Beau, Z. 603 "The Curious Impertinent": VIII. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5cc9868-4ed3-46a1-9fde-4a1ec3d11cee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44be9af5-24bf-483f-81f3-f51aec7e9f6d', 9, 'IX', 'Hornpipe on a Ground', 'The Married Beau, Z. 603 "The Curious Impertinent": IX. Hornpipe on a Ground', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Married Beau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44be9af5-24bf-483f-81f3-f51aec7e9f6d'
);


-- Z 611 부수음악 <The Virtuous Wife>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <The Virtuous Wife>', 'The Virtuous Wife, Z. 611', 'album', 'Z 611', NULL, NULL, 1694, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <The Virtuous Wife>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59ad74ee-0704-432c-8689-92fb9bce857a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59ad74ee-0704-432c-8689-92fb9bce857a'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59ad74ee-0704-432c-8689-92fb9bce857a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ce5814-f47f-4b8d-aa59-c9a632b663e5', 1, 'I', 'Overture', 'The Virtuous Wife, Z. 611, "Good Luck at Last": I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ce5814-f47f-4b8d-aa59-c9a632b663e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f25c857-30b6-4d94-8937-0987502e792d', 2, 'II', 'Song Tune', 'The Virtuous Wife, Z. 611, "Good Luck at Last": II. Song Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f25c857-30b6-4d94-8937-0987502e792d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a9bd5f-5a1e-42ae-9f33-9b78205f27a8', 3, 'III', 'Slow Air', 'The Virtuous Wife, Z. 611, “Good Luck at Last”: III. Slow Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a9bd5f-5a1e-42ae-9f33-9b78205f27a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8704e814-7d06-4f54-9dbc-c4bbc56303f1', 4, 'IV', 'Air', 'The Virtuous Wife, Z. 611, "Good Luck at Last": IV. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8704e814-7d06-4f54-9dbc-c4bbc56303f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feffee14-3176-4ba7-b018-67f45c598a1b', 5, 'V', 'Preludio', 'The Virtuous Wife, Z. 611, "Good Luck at Last": V. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feffee14-3176-4ba7-b018-67f45c598a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72fa2ee7-e418-4c43-b408-57503efd1319', 6, 'VI', 'Hornpipe', 'The Virtuous Wife, Z. 611, "Good Luck at Last": VI. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72fa2ee7-e418-4c43-b408-57503efd1319'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b487448-258e-4572-8225-83c5cc714f22', 7, 'VII', 'Minuet I', 'The Virtuous Wife, Z. 611, "Good Luck at Last": VII. Minuet I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b487448-258e-4572-8225-83c5cc714f22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef7a9d19-fd95-4738-a3e0-737ef35d2b46', 8, 'VIII', 'Minuet II', 'The Virtuous Wife, Z. 611, "Good Luck at Last": VII. Minuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <The Virtuous Wife>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef7a9d19-fd95-4738-a3e0-737ef35d2b46'
);


-- Z 574 부수음악 <본두카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <본두카>', 'Bonduca, or the British Heroine, Z. 574', 'song', 'Z 574', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <본두카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40e16d19-8629-454e-ad9c-6bba94f935ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40e16d19-8629-454e-ad9c-6bba94f935ae'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <본두카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40e16d19-8629-454e-ad9c-6bba94f935ae'
);


-- Z 585 부수음악 <파우사니아스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <파우사니아스>', 'Pausanias, the Betrayer of his Country, Z. 585', 'album', 'Z 585', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <파우사니아스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e5a678a-45eb-4152-bb34-52d4d5959c39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e5a678a-45eb-4152-bb34-52d4d5959c39'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <파우사니아스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e5a678a-45eb-4152-bb34-52d4d5959c39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bbd9fb7-1920-419b-a45e-dc73947010bf', 1, 'I', 'Sweeter than roses', 'Pausanias, the Betrayer of his Country, Z. 585: I. "Sweeter than roses"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <파우사니아스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bbd9fb7-1920-419b-a45e-dc73947010bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66f6171d-10d1-410e-b287-3ec8d0a903c4', 2, 'II', 'My dearest, my fairest', 'Pausanias, the Betrayer of his Country, Z. 585: II. "My dearest, my fairest"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <파우사니아스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66f6171d-10d1-410e-b287-3ec8d0a903c4'
);


-- Z 578 부수음악 <돈키호테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <돈키호테>', 'The Comical History of Don Quixote, Z. 578', 'song', 'Z 578', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <돈키호테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c017a91-d69e-4d0d-98dd-33921abdf1b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c017a91-d69e-4d0d-98dd-33921abdf1b2'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '부수음악 <돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c017a91-d69e-4d0d-98dd-33921abdf1b2'
);


-- Z 326 송가 <From those serene and rapturous joys>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <From those serene and rapturous joys>', 'Welcome Song - From Those Serene and Rapturous Joys, Z. 326', 'song', 'Z 326', NULL, NULL, 1684, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <From those serene and rapturous joys>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c60ec72c-64d0-4e81-9538-d47719b25d62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c60ec72c-64d0-4e81-9538-d47719b25d62'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <From those serene and rapturous joys>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c60ec72c-64d0-4e81-9538-d47719b25d62'
);


-- Z 343 송가 <Why, why are all the Muses mute?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Why, why are all the Muses mute?>', 'Ode, Z 343: "Why, why are all the Muses mute?"', 'album', 'Z 343', NULL, NULL, 1685, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Why, why are all the Muses mute?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e279d01c-2f8c-472f-a2e2-8e20a53f3c88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e279d01c-2f8c-472f-a2e2-8e20a53f3c88'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e279d01c-2f8c-472f-a2e2-8e20a53f3c88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f1298cc-5d13-4074-93d5-da397ca365c9', 1, 'I', 'Aria (Tenor) - Chorus - Symphony "Why, why are all the Muses mute?"', 'Ode, Z 343 "Why, why are all the Muses mute?": I. Aria (Tenor) - Chorus - Symphony "Why, why are all the Muses mute?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f1298cc-5d13-4074-93d5-da397ca365c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6943391b-7bb2-4495-b33e-ea1d7d56ec0a', 2, 'II', 'Aria (Tenor) - Chorus "When should each soul exalted be"', 'Ode, Z 343 "Why, why are all the Muses mute?": II. Aria (Tenor) - Chorus "When should each soul exalted be"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6943391b-7bb2-4495-b33e-ea1d7d56ec0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d20c83c6-bd85-4c4f-9515-762089e2f9b8', 3, 'III', 'Aria (Alto) - Ritornello "Britain, thou now art great"', 'Ode, Z 343 "Why, why are all the Muses mute?": III. Aria (Alto) - Ritornello "Britain, thou now art great"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d20c83c6-bd85-4c4f-9515-762089e2f9b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d1d0e35-f165-48b2-bca8-07c60a4d2b1a', 4, 'IV', 'Trio (Alto, Tenor, Bass) - Chorus "Look up, and to our Isle returning see"', 'Ode, Z 343 "Why, why are all the Muses mute?": IV. Trio (Alto, Tenor, Bass) - Chorus "Look up, and to our Isle returning see"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d1d0e35-f165-48b2-bca8-07c60a4d2b1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99541301-1312-432c-95d9-ebdd2ce91ab5', 5, 'V', 'Aria (Bass) - Duet (Sopranos I-II) "Accurs''d rebellion reared his head"', 'Ode, Z 343 "Why, why are all the Muses mute?": V. Aria (Bass) - Duet (Sopranos I-II) "Accurs''d rebellion reared his head"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99541301-1312-432c-95d9-ebdd2ce91ab5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fec4436-ac16-416d-a820-9ac093e61342', 6, 'VI', 'Ritornello - Duet (High Tenor, Bass) "Caesar for milder virtues honour''d more"', 'Ode, Z 343 "Why, why are all the Muses mute?": VI. Ritornello - Duet (High Tenor, Bass) "Caesar for milder virtues honour''d more"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fec4436-ac16-416d-a820-9ac093e61342'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:985975fd-9fdf-4590-96c7-75c57a713cec', 7, 'VII', 'Aria (Tenor) - Chorus "The many-headed beast is quelled at home"', 'Ode, Z 343 "Why, why are all the Muses mute?": VII. Aria (Tenor) - Chorus "The many-headed beast is quelled at home"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:985975fd-9fdf-4590-96c7-75c57a713cec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2331fb1-e76e-4c2d-9260-7db05cf2e99e', 8, 'VIII', 'Duet (Basses I-II) "In the equal balance laid"', 'Ode, Z 343 "Why, why are all the Muses mute?": VIII. Duet (Basses I-II) "In the equal balance laid"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2331fb1-e76e-4c2d-9260-7db05cf2e99e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5ad845-bd85-4af7-a452-243c20caef0c', 9, 'IX', 'Aria (Tenor) - Ritornello - Chorus "O how blest is the Isle to which Caesar is given"', 'Ode, Z 343 "Why, why are all the Muses mute?": IX. Aria (Tenor) - Ritornello - Chorus "O how blest is the Isle to which Caesar is given"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Why, why are all the Muses mute?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5ad845-bd85-4af7-a452-243c20caef0c'
);


-- Z 344 송가 <Ye tuneful Muses>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Ye tuneful Muses>', 'Ye tuneful muses (Welcome Ode for Charles II), for soloists, chorus & instruments, Z. 344', 'song', 'Z 344', NULL, NULL, 1686, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Ye tuneful Muses>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916174b9-7e7c-4313-b72d-593d45e4f76e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '916174b9-7e7c-4313-b72d-593d45e4f76e'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Ye tuneful Muses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '916174b9-7e7c-4313-b72d-593d45e4f76e'
);


-- Z 335 송가 <Sound the trumpet, beat the drum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Sound the trumpet, beat the drum>', 'Sound the trumpet, beat the drum (Welcome Ode for James II), for 2 altos, tenors, basses, chorus, strings & continuo, Z. 335', 'song', 'Z 335', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Sound the trumpet, beat the drum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a6be6b3-6685-4058-9749-844db68abb49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a6be6b3-6685-4058-9749-844db68abb49'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Sound the trumpet, beat the drum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a6be6b3-6685-4058-9749-844db68abb49'
);


-- Z 332 송가 <Now does the glorious day appear>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Now does the glorious day appear>', 'Now does the glorious day appear, Z. 332', 'song', 'Z 332', NULL, NULL, 1689, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Now does the glorious day appear>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c42de0-4dd5-4929-bd85-434b62b3425b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04c42de0-4dd5-4929-bd85-434b62b3425b'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Now does the glorious day appear>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04c42de0-4dd5-4929-bd85-434b62b3425b'
);


-- Z 333 송가 <Of old when heroes thought it base>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Of old when heroes thought it base>', 'Of old when heroes thought it base, Z. 333', 'song', 'Z 333', NULL, NULL, 1690, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Of old when heroes thought it base>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f61add-6deb-416c-84c2-c33d6452a4b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3f61add-6deb-416c-84c2-c33d6452a4b1'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Of old when heroes thought it base>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f61add-6deb-416c-84c2-c33d6452a4b1'
);


-- Z 338 송가 <Welcome, welcome, glorious morn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Welcome, welcome, glorious morn>', 'Ode, Z 338 "Welcome, welcome, glorious morn"', 'album', 'Z 338', NULL, NULL, 1691, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Welcome, welcome, glorious morn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '548b1630-3ba3-4c2a-bea0-d3c99fda1958'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '548b1630-3ba3-4c2a-bea0-d3c99fda1958'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '548b1630-3ba3-4c2a-bea0-d3c99fda1958'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcbfe00c-40ba-4f8a-8766-bbb14aa0fc1f', 1, 'I', 'Symphony', 'Ode, Z 338 "Welcome, welcome, glorious morn": I. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbfe00c-40ba-4f8a-8766-bbb14aa0fc1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fc1a6e6-410d-49bf-9dff-815337d1db00', 2, 'II', 'Aria (High Tenor) - Chorus "Welcome, welcome, glorious morn"', 'Ode, Z 338 "Welcome, welcome, glorious morn": II. Aria (High Tenor) - Chorus "Welcome, welcome, glorious morn"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fc1a6e6-410d-49bf-9dff-815337d1db00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b433144a-c4d5-475a-bb9f-4dafbd4bd075', 3, 'III', 'Duet (High Tenor, Bass) - Ritornello - Chorus "At thy return"', 'Ode, Z 338 "Welcome, welcome, glorious morn": III. Duet (High Tenor, Bass) - Ritornello - Chorus "At thy return"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b433144a-c4d5-475a-bb9f-4dafbd4bd075'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5fa0129-d6f8-486f-a73a-4530c75903f4', 4, 'IV', 'Duet (Alto, Bass) "Welcome as when three happy Kingdoms strove"', 'Ode, Z 338 "Welcome, welcome, glorious morn": IV. Duet (Alto, Bass) "Welcome as when three happy Kingdoms strove"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5fa0129-d6f8-486f-a73a-4530c75903f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28c4a53e-1401-4fb3-b67e-b89d3bfd6497', 5, 'V', 'Aria (Tenor) " THe mighty Goddess of this wealthy Isle"', 'Ode, Z 338 "Welcome, welcome, glorious morn": V. Aria (Tenor) " THe mighty Goddess of this wealthy Isle"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28c4a53e-1401-4fb3-b67e-b89d3bfd6497'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:500114b1-93d8-484c-a329-fc0d1598f66c', 6, 'VI', 'Trio (Alto, High Tenor, Bass) - Chorus - Ritornello "Full of Wonder and Delight"', 'Ode, Z 338 "Welcome, welcome, glorious morn": VI. Trio (Alto, High Tenor, Bass) - Chorus - Ritornello "Full of Wonder and Delight"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500114b1-93d8-484c-a329-fc0d1598f66c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77a59c83-fcbf-4461-b1f8-46c1f9a426a7', 7, 'VII', 'Aria (Tenor) - Chorus "And lo! a sacred Fury swell''d her Breast"', 'Ode, Z 338 "Welcome, welcome, glorious morn": VII. Aria (Tenor) - Chorus "And lo! a sacred Fury swell''d her Breast"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77a59c83-fcbf-4461-b1f8-46c1f9a426a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:724953f3-ff73-42f6-8334-ff5089f3f4d0', 8, 'VIII', 'Aria (Soprano) - Chorus "My Pray''rs are heard"', 'Ode, Z 338 "Welcome, welcome, glorious morn": VIII. Aria (Soprano) - Chorus "My Pray''rs are heard"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:724953f3-ff73-42f6-8334-ff5089f3f4d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6302059-79b9-43ed-9ae7-3f72d0c24e15', 9, 'IX', 'Duet (Basses I-II) "He to the Field by Honour call''d"', 'Ode, Z 338 "Welcome, welcome, glorious morn": IX. Duet (Basses I-II) "He to the Field by Honour call''d"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6302059-79b9-43ed-9ae7-3f72d0c24e15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:269a64ea-62f0-4d2f-814b-b72793bf2245', 10, 'X', 'Aria (High Tenor) "Whilst undisturb''d his happy Consort reigns"', 'Ode, Z 338 "Welcome, welcome, glorious morn": X. Aria (High Tenor) "Whilst undisturb''d his happy Consort reigns"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:269a64ea-62f0-4d2f-814b-b72793bf2245'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e9539a-62f9-4e0e-8ddd-9c3df0f765a5', 11, 'XI', 'Aria (Tenor) - Chorus "Sound, all ye Spheres"', 'Ode, Z 338 "Welcome, welcome, glorious morn": XI. Aria (Tenor) - Chorus "Sound, all ye Spheres"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Welcome, welcome, glorious morn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e9539a-62f9-4e0e-8ddd-9c3df0f765a5'
);


-- Z 331 송가 <Love's goddess sure was blind>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Love''s goddess sure was blind>', 'Birthday Ode for Queen Mary "Love''s Goddess Sure Was Blind", Z. 331', 'song', 'Z 331', NULL, NULL, 1692, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Love''s goddess sure was blind>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe52dcc8-0f43-47d8-b19a-eab1a6d556bd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe52dcc8-0f43-47d8-b19a-eab1a6d556bd'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Love''s goddess sure was blind>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe52dcc8-0f43-47d8-b19a-eab1a6d556bd'
);


-- Z 321 송가 <Celebrate this festival>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Celebrate this festival>', 'Celebrate This Festival, Z. 321', 'song', 'Z 321', NULL, NULL, 1693, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Celebrate this festival>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef4a952e-50c9-4620-a850-fe44d5f4265d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef4a952e-50c9-4620-a850-fe44d5f4265d'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Celebrate this festival>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef4a952e-50c9-4620-a850-fe44d5f4265d'
);


-- Z 323 송가 <오라, 너희 예술의 아들들아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <오라, 너희 예술의 아들들아>', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323', 'album', 'Z 323', NULL, NULL, 1694, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <오라, 너희 예술의 아들들아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31c4ff6c-609e-48be-8fba-2fee2a8af695'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31c4ff6c-609e-48be-8fba-2fee2a8af695'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31c4ff6c-609e-48be-8fba-2fee2a8af695'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd69fa48-4894-4c7c-af94-4866bf6c1fd4', 1, 'I', 'Ouverture', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd69fa48-4894-4c7c-af94-4866bf6c1fd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6c5c066-675c-4903-819f-3894bcfa7b86', 2, 'II', 'Come, ye sons of Art, come away', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: II. Come, ye sons of Art, come away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6c5c066-675c-4903-819f-3894bcfa7b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:079be544-2933-435f-a53a-4d8082b1f5a6', 3, 'III', 'Sound the Trumpet', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: III. Sound the Trumpet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:079be544-2933-435f-a53a-4d8082b1f5a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70ee0102-1d1a-4761-837a-a14d85ad7120', 4, 'IV', 'Come, ye sons of Art, come away', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: IV. Come, ye sons of Art, come away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70ee0102-1d1a-4761-837a-a14d85ad7120'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef0b4f64-28a1-4367-bc05-fefaebfc4bd2', 5, 'V', 'Strike the viol', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: V. Strike the viol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef0b4f64-28a1-4367-bc05-fefaebfc4bd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ef59891-152e-4204-b180-07ef12f40bec', 6, 'VI', 'The day that such a blessing', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: VI. The day that such a blessing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ef59891-152e-4204-b180-07ef12f40bec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95c2c081-a262-48e0-9085-ca266025e454', 7, 'VII', 'Bid the Virtues', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: VII. Bid the Virtues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95c2c081-a262-48e0-9085-ca266025e454'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:909785c5-0f8e-4fc6-9dea-3cb79f2dfd10', 8, 'VIII', 'These, are the sacred charms', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: VIII. These, are the sacred charms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:909785c5-0f8e-4fc6-9dea-3cb79f2dfd10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d913655-c966-4f64-be44-0d27652f319f', 9, 'IX', 'See Nature, rejoicing', 'Birthday Ode for Queen Mary "Come Ye Sons of Art", Z. 323: IX. See Nature, rejoicing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <오라, 너희 예술의 아들들아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d913655-c966-4f64-be44-0d27652f319f'
);


-- Z 342 송가 <Who can from joy refrain?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Who can from joy refrain?>', 'Who can from joy refrain?, Z. 342', 'song', 'Z 342', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Who can from joy refrain?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8af63f53-aecc-44de-a6c5-5e0f632fbad4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8af63f53-aecc-44de-a6c5-5e0f632fbad4'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '송가 <Who can from joy refrain?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8af63f53-aecc-44de-a6c5-5e0f632fbad4'
);


-- Z 339 성 체칠리아의 날을 위한 송가 <Welcome to all the pleasures>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 체칠리아의 날을 위한 송가 <Welcome to all the pleasures>', 'Welcome to all the pleasures, Z. 339', 'song', 'Z 339', NULL, NULL, 1683, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 체칠리아의 날을 위한 송가 <Welcome to all the pleasures>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5635da71-69fc-4b39-866a-901cf27dcef7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5635da71-69fc-4b39-866a-901cf27dcef7'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Welcome to all the pleasures>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5635da71-69fc-4b39-866a-901cf27dcef7'
);


-- Z 334 성 체칠리아의 날을 위한 송가 <Raise, raise the voice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>', 'Ode, Z 334: "Raise raise the voice"', 'album', 'Z 334', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d740bfa-4133-4684-8b6d-a0b17d690d21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d740bfa-4133-4684-8b6d-a0b17d690d21'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d740bfa-4133-4684-8b6d-a0b17d690d21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d308270-9e6e-405c-aa22-44152698a7b1', 1, 'I', 'Symphony', 'Ode, Z 334 "Raise raise the voice": I. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d308270-9e6e-405c-aa22-44152698a7b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1059036-a5b1-43c3-8990-daea640370d1', 2, 'II', 'Aria (Bass) - Chorus - Ritornello "Raise, raise the voice"', 'Ode, Z 334 "Raise raise the voice": II. Aria (Bass) - Chorus - Ritornello "Raise, raise the voice"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1059036-a5b1-43c3-8990-daea640370d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89c0553-2e89-4893-a8dc-42cd1d3600ed', 3, 'III', 'Aria (Soprano) - Trio (Soprano, Tenor, Bass) "The God himself says he''ll be present here"', 'Ode, Z 334 "Raise raise the voice": III. Aria (Soprano) - Trio (Soprano, Tenor, Bass) "The God himself says he''ll be present here"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89c0553-2e89-4893-a8dc-42cd1d3600ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c0c2610-8db9-41fe-9244-aa2a4d33c799', 4, 'IV', 'Aria (Soprano) - Chorus - Ritornello - Chorus "Mark how readily each pliant string"', 'Ode, Z 334 "Raise raise the voice": IV. Aria (Soprano) - Chorus - Ritornello - Chorus "Mark how readily each pliant string"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c0c2610-8db9-41fe-9244-aa2a4d33c799'
);


-- Z 328 성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>', '“Hail! Bright Cecilia”, Z. 328', 'album', 'Z 328', NULL, NULL, 1692, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad1c0dfb-9cb4-4106-8eb9-13bbbe423dbf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad1c0dfb-9cb4-4106-8eb9-13bbbe423dbf'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad1c0dfb-9cb4-4106-8eb9-13bbbe423dbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663049ae-ecbd-4be9-a7f1-ac06d512a15a', 1, 'I', 'Symphony', '“Hail! Bright Cecilia”, Z. 328: I. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663049ae-ecbd-4be9-a7f1-ac06d512a15a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67c213cb-d330-4284-9c8e-87d70b2c9a23', 2, 'II', 'Hail! Bright Cecilia', '“Hail! Bright Cecilia”, Z. 328: II. “Hail! Bright Cecilia”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67c213cb-d330-4284-9c8e-87d70b2c9a23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f510014-15f3-4122-90c5-fa2a64b73c83', 3, 'III', 'Hark! Hark! Each tree its silence breaks', '“Hail! Bright Cecilia”, Z. 328: III. “Hark! Hark! Each tree its silence breaks”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f510014-15f3-4122-90c5-fa2a64b73c83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25d525fa-4a0c-4189-895b-e75bcdcfe397', 4, 'IV', '’Tis nature’s voice', '“Hail! Bright Cecilia”, Z. 328: IV. “’Tis nature’s voice”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25d525fa-4a0c-4189-895b-e75bcdcfe397'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa180e4-d9ed-45a5-af90-636cc9aab01e', 5, 'V', 'Soul of the world', '“Hail! Bright Cecilia”, Z. 328: V. “Soul of the world”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa180e4-d9ed-45a5-af90-636cc9aab01e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35421482-792c-4277-a878-906937603048', 6, 'VI', 'Thou tun’st this world', '“Hail! Bright Cecilia”, Z. 328: VI. “Thou tun’st this world”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35421482-792c-4277-a878-906937603048'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22ef43fc-de12-4013-8fcf-25ab8a80d5ab', 7, 'VII', 'With that sublime celestial lay', '“Hail! Bright Cecilia”, Z. 328: VII. “With that sublime celestial lay”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22ef43fc-de12-4013-8fcf-25ab8a80d5ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ba0ee6-4433-43da-9b66-f483b9a4db99', 8, 'VIII', 'Wondrous machine!', '“Hail! Bright Cecilia”, Z. 328: VIII. “Wondrous machine!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ba0ee6-4433-43da-9b66-f483b9a4db99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75db4c23-39b8-4586-9d40-81fa02a4f6b8', 9, 'IX', 'The airy violin', '“Hail! Bright Cecilia”, Z. 328: IX. “The airy violin”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75db4c23-39b8-4586-9d40-81fa02a4f6b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba09ca4-6f87-4f01-9baa-600483c9662a', 10, 'X', 'In vain the am’rous flute', '“Hail! Bright Cecilia”, Z. 328: X. “In vain the am’rous flute”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba09ca4-6f87-4f01-9baa-600483c9662a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bdfac4e-0efc-4288-a65c-620bd9cf1541', 11, 'XI', 'The fife and all the harmony of war', '“Hail! Bright Cecilia”, Z. 328: XI. “The fife and all the harmony of war”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bdfac4e-0efc-4288-a65c-620bd9cf1541'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4c5a9dd-4fea-4afd-bc19-79782e6b0f6f', 12, 'XII', 'Let these amongst themselves contest', '“Hail! Bright Cecilia”, Z. 328: XII. “Let these amongst themselves contest”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4c5a9dd-4fea-4afd-bc19-79782e6b0f6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d3e435d-ab3e-488c-8afa-e3433829f7f7', 13, 'XIII', 'Hail! Bright Cecilia, hail to thee', '“Hail! Bright Cecilia”, Z. 328: XIII. “Hail! Bright Cecilia, hail to thee”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d3e435d-ab3e-488c-8afa-e3433829f7f7'
);


-- Z 15 찬가 <Hear my prayer, O Lord>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Hear my prayer, O Lord>', 'Hear My Prayer, O Lord, Z. 15', 'song', 'Z 15', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Hear my prayer, O Lord>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c55e424-513f-328b-b41d-d8976c167c43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c55e424-513f-328b-b41d-d8976c167c43'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <Hear my prayer, O Lord>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c55e424-513f-328b-b41d-d8976c167c43'
);


-- Z 19 대관식 찬가 <I was glad>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관식 찬가 <I was glad>', 'I was glad when they said unto me, Z. 19', 'song', 'Z 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관식 찬가 <I was glad>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '670cdde1-a562-40d6-bd84-5536a573800f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '670cdde1-a562-40d6-bd84-5536a573800f'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <I was glad>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '670cdde1-a562-40d6-bd84-5536a573800f'
);


-- Z 30 대관식 찬가 <My heart is inditing>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관식 찬가 <My heart is inditing>', 'My heart is inditing, Z. 30', 'album', 'Z 30', NULL, NULL, 1685, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관식 찬가 <My heart is inditing>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92449fad-7930-4e6b-b55f-f6ecec549f0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92449fad-7930-4e6b-b55f-f6ecec549f0b'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <My heart is inditing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92449fad-7930-4e6b-b55f-f6ecec549f0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f53dba62-3d13-4634-8f8f-49f63359fc15', 1, 'I', 'Symphony; My heart is inditing', 'My heart is inditing, Z. 30: I: Symphony; My heart is inditing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <My heart is inditing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f53dba62-3d13-4634-8f8f-49f63359fc15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63076f0d-5187-4634-8e78-13d56f5eec90', 2, 'II', 'She shall be brought unto the King', 'My heart is inditing, Z. 30: II. She shall be brought unto the King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <My heart is inditing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63076f0d-5187-4634-8e78-13d56f5eec90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45f74703-7328-488f-9b55-4be996af8520', 3, 'III', 'Symphony; Hearken, O daughter', 'My heart is inditing, Z. 30: III. Symphony; Hearken, O daughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <My heart is inditing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45f74703-7328-488f-9b55-4be996af8520'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35d0bb47-2f63-4e7b-b118-0b0b1c7a21a8', 4, 'IV', 'Praise the Lord, O Jerusalem', 'My heart is inditing, Z. 30: IV. Praise the Lord, O Jerusalem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '대관식 찬가 <My heart is inditing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35d0bb47-2f63-4e7b-b118-0b0b1c7a21a8'
);


-- Z 28 찬가 <My beloved spake>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <My beloved spake>', 'My beloved spake, Z. 28', 'album', 'Z 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <My beloved spake>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dba28577-f803-4c3d-ad27-70bd2fe9f138'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dba28577-f803-4c3d-ad27-70bd2fe9f138'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dba28577-f803-4c3d-ad27-70bd2fe9f138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a10c33a3-ce35-4c48-b568-71d8a20f3164', 1, 'I', 'Symphony', 'My beloved spake, Z. 28: I. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10c33a3-ce35-4c48-b568-71d8a20f3164'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee9db2f-9350-4082-9666-1c5ed7dc2607', 2, 'II', 'For lo! the winter is past', 'My beloved spake, Z. 28: II. For lo! the winter is past', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee9db2f-9350-4082-9666-1c5ed7dc2607'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39ed32e8-f212-4d3a-b785-412b6a4cfe4b', 3, 'III', 'And the time of the singing of birds is come', 'My beloved spake, Z. 28: III. And the time of the singing of birds is come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ed32e8-f212-4d3a-b785-412b6a4cfe4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de012ad-a6ba-4891-b97d-331c57a2b084', 4, 'IV', 'Symphony', 'My beloved spake, Z. 28: IV. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de012ad-a6ba-4891-b97d-331c57a2b084'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:924cce70-2291-45aa-8814-3ffb7ad09a4f', 5, 'V', 'My beloved is mine and I am his', 'My beloved spake, Z. 28: V. My beloved is mine and I am his', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <My beloved spake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:924cce70-2291-45aa-8814-3ffb7ad09a4f'
);


-- Z 35 찬가 <O God, thou art my God>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <O God, thou art my God>', 'O God, thou art my God, Z. 35', 'song', 'Z 35', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <O God, thou art my God>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7c8e0cf-8d28-4206-bb60-4511876b7eb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7c8e0cf-8d28-4206-bb60-4511876b7eb2'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O God, thou art my God>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7c8e0cf-8d28-4206-bb60-4511876b7eb2'
);


-- Z 44 찬가 <O sing unto the Lord a new song>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <O sing unto the Lord a new song>', 'O sing unto the Lord a new song, Z.44', 'album', 'Z 44', NULL, NULL, 1688, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <O sing unto the Lord a new song>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de87a82a-6846-4741-819a-f6e9def15d61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de87a82a-6846-4741-819a-f6e9def15d61'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de87a82a-6846-4741-819a-f6e9def15d61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:004fa494-273d-4aac-aaa5-f4f7bff5c695', 1, 'I', 'Symphony', 'O Sing Unto the Lord a New Song, Z. 44: I. Symphony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:004fa494-273d-4aac-aaa5-f4f7bff5c695'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e215fbb-f21b-43aa-a943-2042eba32d88', 2, 'II', 'O Sing Unto the Lord a New Song', 'O Sing Unto the Lord a New Song, Z. 44: II. O Sing Unto the Lord a New Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e215fbb-f21b-43aa-a943-2042eba32d88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9f77fc-4115-48cb-9d45-837de5fc3125', 3, 'III', 'Sing Unto the Lord and Praise His Name', 'O Sing Unto the Lord a New Song, Z. 44: III. Sing Unto the Lord and Praise His Name', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9f77fc-4115-48cb-9d45-837de5fc3125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9255ff3b-7bfd-4c15-bb8d-70e66a05cfc7', 4, 'IV', 'The Lord Is Great and Cannot Worthily Be Praised', 'O Sing Unto the Lord a New Song, Z. 44: IV. The Lord Is Great and Cannot Worthily Be Praised', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9255ff3b-7bfd-4c15-bb8d-70e66a05cfc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ce0d3af-01c1-4021-9017-aed423766a9a', 5, 'V', 'O Worship the Lord in the Beauty of Holiness', 'O Sing Unto the Lord a New Song, Z. 44: V. O Worship the Lord in the Beauty of Holiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ce0d3af-01c1-4021-9017-aed423766a9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6708d1b8-483e-4e2c-9c8f-0a16a74e167a', 6, 'VI', 'Tell It Out Among the Heathen That the Lord Is King', 'O Sing Unto the Lord a New Song, Z. 44: VI. Tell It Out Among the Heathen That the Lord Is King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <O sing unto the Lord a new song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6708d1b8-483e-4e2c-9c8f-0a16a74e167a'
);


-- Z 49 찬가 <Rejoice in the Lord alway>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Rejoice in the Lord alway>', 'Rejoice in the Lord Always, Z. 49', 'song', 'Z 49', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Rejoice in the Lord alway>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bfee663-178d-4a18-9075-ff974be95f53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9bfee663-178d-4a18-9075-ff974be95f53'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <Rejoice in the Lord alway>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bfee663-178d-4a18-9075-ff974be95f53'
);


-- Z 50 찬가 <Remember not, Lord, our offences>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Remember not, Lord, our offences>', 'Remember not, Lord, our offences, Z. 50', 'song', 'Z 50', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Remember not, Lord, our offences>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c253f6bc-a15d-3675-8be3-5c1065b684bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c253f6bc-a15d-3675-8be3-5c1065b684bc'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <Remember not, Lord, our offences>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c253f6bc-a15d-3675-8be3-5c1065b684bc'
);


-- Z 57 찬가 <They that go down to the sea in ships>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <They that go down to the sea in ships>', 'They that go down to the sea in ships, Z. 57', 'song', 'Z 57', NULL, NULL, 1685, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <They that go down to the sea in ships>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df07dcd3-fe49-4199-81a2-f0f3fe339fbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df07dcd3-fe49-4199-81a2-f0f3fe339fbc'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <They that go down to the sea in ships>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df07dcd3-fe49-4199-81a2-f0f3fe339fbc'
);


-- Z 61 찬가 <Thy word is a lantern unto my feet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Thy word is a lantern unto my feet>', 'Thy word is a lantern unto my feet, Z. 61', 'song', 'Z 61', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Thy word is a lantern unto my feet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3c2321-99c5-496a-a8ed-1d715659f12b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b3c2321-99c5-496a-a8ed-1d715659f12b'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '찬가 <Thy word is a lantern unto my feet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b3c2321-99c5-496a-a8ed-1d715659f12b'
);


-- Z 135 모테트 <Jehova, quam multi sunt hostes mei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Jehova, quam multi sunt hostes mei>', 'Jehova, quam multi sunt hostes mei, Z. 135', 'song', 'Z 135', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Jehova, quam multi sunt hostes mei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c149922-8267-4522-8c8a-be92318c9f15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c149922-8267-4522-8c8a-be92318c9f15'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '모테트 <Jehova, quam multi sunt hostes mei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c149922-8267-4522-8c8a-be92318c9f15'
);


-- Z 230 예배곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '예배곡 B♭장조', 'Complete Service in B-flat, Z. 230', 'song', 'Z 230', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '예배곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5ae0951-ce07-4d57-b54c-6f52da1e6f6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5ae0951-ce07-4d57-b54c-6f52da1e6f6c'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '예배곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5ae0951-ce07-4d57-b54c-6f52da1e6f6c'
);


-- Z 231 마니피카트와 눙크 디미티스 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트와 눙크 디미티스 G단조', 'Magnificat and Nunc dimittis in G minor, Z231', 'album', 'Z 231', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트와 눙크 디미티스 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b34a9b6-a4e2-49ef-a071-e26de5fd27c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b34a9b6-a4e2-49ef-a071-e26de5fd27c8'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '마니피카트와 눙크 디미티스 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b34a9b6-a4e2-49ef-a071-e26de5fd27c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae6b8b89-4f80-4051-a8cd-5277460d9bc8', 1, 'I', 'Magnificat', 'Magnificat and Nunc dimittis in G minor, Z231: Magnificat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '마니피카트와 눙크 디미티스 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6b8b89-4f80-4051-a8cd-5277460d9bc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b5c62c2-a2a6-4a1c-bdf2-e35aac9d0666', 2, 'II', 'Nunc dimittis', 'Magnificat and Nunc dimittis in G minor, Z231: Nunc dimittis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '마니피카트와 눙크 디미티스 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b5c62c2-a2a6-4a1c-bdf2-e35aac9d0666'
);


-- Z 232 테 데움과 유빌라테 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움과 유빌라테 D장조', 'Te Deum and Jubilate Deo, for St. Cecilia''s Day, Z. 232', 'album', 'Z 232', NULL, NULL, 1694, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움과 유빌라테 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ec167a6-cd3d-4cf4-9f0b-d4b93233d0ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ec167a6-cd3d-4cf4-9f0b-d4b93233d0ef'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '테 데움과 유빌라테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ec167a6-cd3d-4cf4-9f0b-d4b93233d0ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c35e877-5708-45c5-8c5b-c6c8361e7d58', 1, 'I', 'Te Deum', 'Te Deum and Jubilate Deo in D, Z. 232: Te Deum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '테 데움과 유빌라테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c35e877-5708-45c5-8c5b-c6c8361e7d58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1300d133-1767-4e65-accb-83f364946971', 2, 'II', 'Jubilate Deo', 'Te Deum and Jubilate Deo in D, Z. 232: Jubilate Deo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '테 데움과 유빌라테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1300d133-1767-4e65-accb-83f364946971'
);


-- Z 193 저녁 찬송 <Now that the sun hath veiled his light>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '저녁 찬송 <Now that the sun hath veiled his light>', 'An Evening Hymn, Z. 193 "Now that the sun hath veiled his light"', 'song', 'Z 193', NULL, NULL, 1688, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '저녁 찬송 <Now that the sun hath veiled his light>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a198f704-799c-399e-9229-e3b269528058'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a198f704-799c-399e-9229-e3b269528058'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '저녁 찬송 <Now that the sun hath veiled his light>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a198f704-799c-399e-9229-e3b269528058'
);


-- Z 192 종교 가곡 <Lord, what is man?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교 가곡 <Lord, what is man?>', 'Lord, what is Man?, Z. 192', 'song', 'Z 192', NULL, NULL, 1693, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교 가곡 <Lord, what is man?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38c43919-4957-37d5-b7d5-676cc33af3c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38c43919-4957-37d5-b7d5-676cc33af3c2'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '종교 가곡 <Lord, what is man?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38c43919-4957-37d5-b7d5-676cc33af3c2'
);


-- Z 196 종교 가곡 <The Blessed Virgin's Expostulation>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교 가곡 <The Blessed Virgin''s Expostulation>', 'The Blessed Virgin''s Expostulation', 'song', 'Z 196', NULL, NULL, 1693, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교 가곡 <The Blessed Virgin''s Expostulation>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f567ac96-b069-41c6-9eb2-2e62a5f9ef1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f567ac96-b069-41c6-9eb2-2e62a5f9ef1f'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '종교 가곡 <The Blessed Virgin''s Expostulation>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f567ac96-b069-41c6-9eb2-2e62a5f9ef1f'
);


-- Z 370 가곡 <From silent shades> "미친 베스"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <From silent shades> "미친 베스"', 'Mad Bess of Bedlam, Z. 370 "From Silent Shades and the Elysian Groves"', 'song', 'Z 370', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <From silent shades> "미친 베스"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f2dee0a-3bb8-49ab-a872-0da2dc53880a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f2dee0a-3bb8-49ab-a872-0da2dc53880a'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '가곡 <From silent shades> "미친 베스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f2dee0a-3bb8-49ab-a872-0da2dc53880a'
);


-- Z 406 가곡 <O Solitude>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O Solitude>', 'O Solitude, Z. 406', 'song', 'Z 406', NULL, NULL, 1687, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O Solitude>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25673227-2b84-357b-9525-865149907e9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25673227-2b84-357b-9525-865149907e9f'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '가곡 <O Solitude>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25673227-2b84-357b-9525-865149907e9f'
);


-- Z 379 가곡 <If music be the food of love>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <If music be the food of love>', 'If Music Be the Food of Love, Z. 379', 'song', 'Z 379', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <If music be the food of love>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5901d9b5-ee81-321e-9f46-579d343269cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5901d9b5-ee81-321e-9f46-579d343269cf'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '가곡 <If music be the food of love>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5901d9b5-ee81-321e-9f46-579d343269cf'
);


-- Z 383 여왕의 비가 <Incassum, Lesbia, rogas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여왕의 비가 <Incassum, Lesbia, rogas>', 'The Queen''s Epicedium, Z. 383 "Incassum Lesbia, incassum rogas"', 'song', 'Z 383', NULL, NULL, 1695, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여왕의 비가 <Incassum, Lesbia, rogas>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9ba237f-aa59-4ed3-b4d0-40b7a4cc383a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9ba237f-aa59-4ed3-b4d0-40b7a4cc383a'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '여왕의 비가 <Incassum, Lesbia, rogas>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9ba237f-aa59-4ed3-b4d0-40b7a4cc383a'
);


-- Z 730 샤코니 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤코니 G단조', 'Chacony in G minor for 2 violins, viola and continuo, Z. 730', 'song', 'Z 730', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤코니 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e13dc5f-4571-3340-9fc1-0ce8c5e7e29c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e13dc5f-4571-3340-9fc1-0ce8c5e7e29c'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '샤코니 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e13dc5f-4571-3340-9fc1-0ce8c5e7e29c'
);


-- Z 731 그라운드에 의한 3성부 판타지아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그라운드에 의한 3성부 판타지아', 'Fantasia, 3 parts on a Ground for three recorders, Z. 731', 'song', 'Z 731', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그라운드에 의한 3성부 판타지아'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '735a94d2-5c2c-39c8-80ae-6946defe0d1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '735a94d2-5c2c-39c8-80ae-6946defe0d1a'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '그라운드에 의한 3성부 판타지아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '735a94d2-5c2c-39c8-80ae-6946defe0d1a'
);


-- Z 732–747 비올 판타지아와 인 노미네

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올 판타지아와 인 노미네', 'Fantazias and In Nomines, Z. 732–747', 'album', 'Z 732–747', NULL, NULL, 1680, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올 판타지아와 인 노미네'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba4551f-5197-3b64-984f-cb7701bb4f73', 1, NULL, '판타지아 D단조 (3성부)', 'Fantasia for strings No. 1, Z. 732', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba4551f-5197-3b64-984f-cb7701bb4f73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1838ee6-d651-398e-95ee-5a1077c84c3b', 2, NULL, '판타지아 F장조 (3성부)', 'Fantasia for strings No. 2, Z. 733', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1838ee6-d651-398e-95ee-5a1077c84c3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:529bfa63-13b4-3f72-ae11-760f7ff22557', 3, NULL, '판타지아 G단조 (3성부)', 'Fantasia for strings No. 3, Z. 734', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:529bfa63-13b4-3f72-ae11-760f7ff22557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ec4b1e-e98d-3ac6-b45e-9e344603d19d', 4, NULL, '판타지아 G단조 (4성부)', 'Fantasia for strings No. 4, Z. 735', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ec4b1e-e98d-3ac6-b45e-9e344603d19d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc9658d9-c232-36cb-92d2-789b82cdee9b', 5, NULL, '판타지아 B♭장조 (4성부)', 'Fantasia for strings No. 5, Z. 736', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9658d9-c232-36cb-92d2-789b82cdee9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6635a4-056a-37fa-93bd-7847b620fb06', 6, NULL, '판타지아 F장조 (4성부)', 'Fantasia for strings No. 6, Z. 737', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6635a4-056a-37fa-93bd-7847b620fb06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7765904a-dbe6-3373-86fb-638fbfa4336d', 7, NULL, '판타지아 C단조 (4성부)', 'Fantasia for strings No. 7, Z. 738', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7765904a-dbe6-3373-86fb-638fbfa4336d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4649f1b9-3264-3c0a-9382-8caf1932de6f', 8, NULL, '판타지아 D단조 (4성부)', 'Fantasia for strings No. 8, Z. 739', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4649f1b9-3264-3c0a-9382-8caf1932de6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b3de139-250b-35ac-9d57-0b32defac974', 9, NULL, '판타지아 A단조 (4성부)', 'Fantasia for strings No. 9, Z. 740', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b3de139-250b-35ac-9d57-0b32defac974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f69f2d0-d8b8-3316-a9e6-61c814fdc210', 10, NULL, '판타지아 E단조 (4성부)', 'Fantasia for strings No. 10, Z. 741', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f69f2d0-d8b8-3316-a9e6-61c814fdc210'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2d9fa15-f97c-3d1c-8331-027a4405f10f', 11, NULL, '판타지아 G장조 (4성부)', 'Fantasia for strings No. 11, Z. 742', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2d9fa15-f97c-3d1c-8331-027a4405f10f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c636e9f6-85d1-36a3-8ac8-b7ab67a6d143', 12, NULL, '판타지아 D단조 (4성부)', 'Fantasia for strings No. 12, Z. 743', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c636e9f6-85d1-36a3-8ac8-b7ab67a6d143'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00607609-fe2d-388f-864e-679bffc00a25', 13, NULL, '한 음에 의한 판타지아 F장조 (5성부)', 'Fantasia for strings upon one note, Z. 745', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00607609-fe2d-388f-864e-679bffc00a25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05d31875-a72d-3ee0-93ee-8e86e01a5ec9', 14, NULL, '인 노미네 G단조 (6성부)', 'In nomine à 6 in G minor, Z. 746', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05d31875-a72d-3ee0-93ee-8e86e01a5ec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce9f3e0e-666c-3352-a5d2-fab605c09667', 15, NULL, '인 노미네 G단조 (7성부)', 'In Nomine in 7 parts, Z. 747', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '비올 판타지아와 인 노미네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce9f3e0e-666c-3352-a5d2-fab605c09667'
);


-- Z 780 바이올린 소나타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 G단조', 'Sonata for violin and basso continuo in G minor, Z. 780', 'album', 'Z 780', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69a0de34-6780-4d7e-9a1f-b8791f171760'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69a0de34-6780-4d7e-9a1f-b8791f171760'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '바이올린 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69a0de34-6780-4d7e-9a1f-b8791f171760'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffa82f71-1ac8-3693-98b3-d0675da40073', 1, 'I', 'Adagio', 'Sonata for violin and basso continuo in G minor, Z. 780: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '바이올린 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffa82f71-1ac8-3693-98b3-d0675da40073'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6dbf20d-a97b-3432-b30f-dc53f42e1464', 2, 'II', 'Allegro', 'Sonata for violin and basso continuo in G minor, Z. 780: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '바이올린 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6dbf20d-a97b-3432-b30f-dc53f42e1464'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c402fd7-a39e-3101-b5bf-4882ae3ebacf', 3, 'III', 'Largo', 'Sonata for violin and basso continuo in G minor, Z. 780: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '바이올린 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c402fd7-a39e-3101-b5bf-4882ae3ebacf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ced4fa46-12e5-3973-8cd4-3e0f81f4026a', 4, 'IV', 'Vivace', 'Sonata for violin and basso continuo in G minor, Z. 780: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '바이올린 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ced4fa46-12e5-3973-8cd4-3e0f81f4026a'
);


-- Z 790–801 3성부 소나타 Z 790–801

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 소나타 Z 790–801', 'Sonnata''s of III Parts, Z. 790–801', 'album', NULL, 'Z', '790–801', 1683, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 소나타 Z 790–801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328', 1, NULL, '소나타 G단조', 'Trio Sonata in 3 parts no. 1 in G minor, Z. 790', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d23f97a-aad1-3b8e-bb74-b6e3c7a378b3', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 1 in G minor, Z. 790: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d23f97a-aad1-3b8e-bb74-b6e3c7a378b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d902b980-44b4-3c30-9386-113351e676fc', 2, 'II', 'Vivace', 'Trio Sonata of 3 parts no. 1 in G minor, Z. 790: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d902b980-44b4-3c30-9386-113351e676fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:673ca001-a6cd-3453-b67b-cb250ea8f357', 3, 'III', 'Adagio, Presto', 'Trio Sonata of 3 parts no. 1 in G minor, Z. 790: III. Adagio, Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673ca001-a6cd-3453-b67b-cb250ea8f357'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a82917e0-4183-33e9-bae8-f00f3345ef6b', 4, 'IV', 'Largo', 'Trio Sonata of 3 parts no. 1 in G minor, Z. 790: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3305e213-aaed-42d8-a3e6-bd91a1028328'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a82917e0-4183-33e9-bae8-f00f3345ef6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a', 2, NULL, '소나타 B♭장조', 'Trio Sonata in 3 parts no. 2 in B-flat major, Z. 791', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87c59b0c-f176-386d-a635-405581d0ff03', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 2 in B-flat major, Z. 791: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c59b0c-f176-386d-a635-405581d0ff03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23add25b-0004-36b3-be8c-7ead85061304', 2, 'II', 'Largo, Presto', 'Trio Sonata of 3 parts no. 2 in B-flat major, Z. 791: II. Largo, Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23add25b-0004-36b3-be8c-7ead85061304'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5122c68c-3cbd-3f44-8f05-4df051b9e06a', 3, 'III', 'Adagio', 'Trio Sonata of 3 parts no. 2 in B-flat major, Z. 791: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5122c68c-3cbd-3f44-8f05-4df051b9e06a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc2d7d89-afcd-3d20-94b2-8434ae65d036', 4, 'IV', 'Allegro', 'Trio Sonata of 3 parts no. 2 in B-flat major, Z. 791: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1077ec37-a91e-4798-9551-76955fe4669a'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc2d7d89-afcd-3d20-94b2-8434ae65d036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feedf292-ea13-40c4-bdfe-862bfe1480d8', 3, NULL, '소나타 D단조', 'Trio Sonata in 3 parts no. 3 in D minor, Z. 792', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feedf292-ea13-40c4-bdfe-862bfe1480d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e54873d7-091b-30bf-8220-340d24056fd3', 1, 'I', 'Grave, Adagio', 'Trio Sonata of 3 parts no. 3 in D minor, Z. 792: I. Grave, Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:feedf292-ea13-40c4-bdfe-862bfe1480d8'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e54873d7-091b-30bf-8220-340d24056fd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15ec9eaf-8c45-3162-a47a-c74c179fa6dc', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 3 in D minor, Z. 792: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:feedf292-ea13-40c4-bdfe-862bfe1480d8'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15ec9eaf-8c45-3162-a47a-c74c179fa6dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef1aefbb-9994-3def-8818-4ebe7a5f3e22', 3, 'III', 'Poco Largo, Allegro', 'Trio Sonata of 3 parts no. 3 in D minor, Z. 792: III. Poco Largo, Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:feedf292-ea13-40c4-bdfe-862bfe1480d8'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef1aefbb-9994-3def-8818-4ebe7a5f3e22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae', 4, NULL, '소나타 F장조', 'Trio Sonata in 3 parts no. 4 in F major, Z. 793', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:382c1484-3224-3d5a-bf53-a972d99b3bf0', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 4 in F major, Z. 793: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:382c1484-3224-3d5a-bf53-a972d99b3bf0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ce3350b-82e8-33f2-9b5b-9febacce53d6', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 4 in F major, Z. 793: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce3350b-82e8-33f2-9b5b-9febacce53d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfb647f5-ad9e-3a28-811a-5484a2e4bf60', 3, 'III', 'Poco Largo', 'Trio Sonata of 3 parts no. 4 in F major, Z. 793: III. Poco Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb647f5-ad9e-3a28-811a-5484a2e4bf60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e80e696-5cab-3241-8804-56875c3d683d', 4, 'IV', 'Allegro', 'Trio Sonata of 3 parts no. 4 in F major, Z. 793: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f49ef788-78f1-4569-8b68-529b38fef7ae'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e80e696-5cab-3241-8804-56875c3d683d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5', 5, NULL, '소나타 A단조', 'Trio Sonata in 3 parts no. 5 in A minor, Z. 794', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afbb668c-f9b9-30e7-9c07-8a8f3739a044', 1, 'I', 'Canzona', 'Trio Sonata of 3 parts no. 5 in A minor, Z. 794: I. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afbb668c-f9b9-30e7-9c07-8a8f3739a044'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82012615-50d5-328c-8329-e50aa1dbb3b0', 2, 'II', 'Adagio', 'Trio Sonata of 3 parts no. 5 in A minor, Z. 794: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82012615-50d5-328c-8329-e50aa1dbb3b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30526f73-2655-3d43-8b68-0440ec79b1ec', 3, 'III', 'Largo', 'Trio Sonata of 3 parts no. 5 in A minor, Z. 794: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30526f73-2655-3d43-8b68-0440ec79b1ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0135043e-d34f-3dd4-83a8-d02887b587e6', 4, 'IV', 'Grave, Canzona', 'Trio Sonata of 3 parts no. 5 in A minor, Z. 794: IV. Grave, Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fa6fe63-0234-455c-8c92-4e2faad1acc5'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0135043e-d34f-3dd4-83a8-d02887b587e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee', 6, NULL, '소나타 C장조', 'Trio Sonata in 3 parts no. 6 in C major, Z. 795', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1e013df-1309-3937-a3e1-2f27fc600c32', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 6 in C major, Z. 795: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1e013df-1309-3937-a3e1-2f27fc600c32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e857aca0-b3c6-3f39-b6c2-600628f2b71f', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 6 in C major, Z. 795: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e857aca0-b3c6-3f39-b6c2-600628f2b71f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a90fea62-2354-34e3-bc63-f38ed006ffea', 3, 'III', 'Largo', 'Trio Sonata of 3 parts no. 6 in C major, Z. 795: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90fea62-2354-34e3-bc63-f38ed006ffea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb5ce3ce-86cc-33c3-9424-f38ea23a84c9', 4, 'IV', 'Allegro', 'Trio Sonata of 3 parts no. 6 in C major, Z. 795: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89842f90-f235-475d-a65a-578b613f49ee'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb5ce3ce-86cc-33c3-9424-f38ea23a84c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1', 7, NULL, '소나타 E단조', 'Trio Sonata in 3 parts no. 7 in E minor, Z. 796', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:282e16c1-c641-36bb-a0b0-63e01825cedc', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 7 in E minor, Z. 796: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:282e16c1-c641-36bb-a0b0-63e01825cedc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ce5067f-157b-3113-b355-417a78dc7097', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 7 in E minor, Z. 796: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce5067f-157b-3113-b355-417a78dc7097'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25083cbd-3dbb-3357-80c8-969e6109e080', 3, 'III', 'Largo', 'Trio Sonata of 3 parts no. 7 in E minor, Z. 796: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25083cbd-3dbb-3357-80c8-969e6109e080'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a0e458b-8fd8-3d4e-8e25-d6a09db235e5', 4, 'IV', 'Grave', 'Trio Sonata of 3 parts no. 7 in E minor, Z. 796: IV. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a0e458b-8fd8-3d4e-8e25-d6a09db235e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34175bac-b9b1-399a-8ea1-bdf63d3b2668', 5, 'V', 'Vivace', 'Trio Sonata of 3 parts no. 7 in E minor, Z. 796: V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4af1591-0c06-4641-8a2c-bd8c455800c1'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34175bac-b9b1-399a-8ea1-bdf63d3b2668'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4315e9c8-fc59-41a2-af70-484c3528f345', 8, NULL, '소나타 G장조', 'Trio Sonata in 3 parts no. 8 in G major, Z. 797', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4315e9c8-fc59-41a2-af70-484c3528f345'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70ba3d61-f13b-32a2-a449-b5d196e9d9f9', 1, 'I', 'Canzona', 'Trio Sonata of 3 parts no. 8 in G major, Z. 797: I. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4315e9c8-fc59-41a2-af70-484c3528f345'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70ba3d61-f13b-32a2-a449-b5d196e9d9f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a913cd07-ae42-3cf8-a6e8-4075f9408ec9', 2, 'II', 'Poco Largo, Allegro', 'Trio Sonata of 3 parts no. 8 in G major, Z. 797: II. Poco Largo, Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4315e9c8-fc59-41a2-af70-484c3528f345'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a913cd07-ae42-3cf8-a6e8-4075f9408ec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:875a1a8f-59ab-3b55-9307-c0836ddaf843', 3, 'III', 'Grave, Vivace', 'Trio Sonata of 3 parts no. 8 in G major, Z. 797: III. Grave, Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4315e9c8-fc59-41a2-af70-484c3528f345'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875a1a8f-59ab-3b55-9307-c0836ddaf843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22', 9, NULL, '소나타 C단조', 'Trio Sonata in 3 parts no. 9 in C minor, Z. 798', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:886a58cd-06d5-3f8c-b67d-9ed173ce6030', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 9 in C minor, Z. 798: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:886a58cd-06d5-3f8c-b67d-9ed173ce6030'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1449ddaa-2c22-3618-991e-36966ed6814e', 2, 'II', 'Largo', 'Trio Sonata of 3 parts no. 9 in C minor, Z. 798: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1449ddaa-2c22-3618-991e-36966ed6814e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6be322ae-fc05-3868-b06c-0d4524491708', 3, 'III', 'Canzona, Adagio', 'Trio Sonata of 3 parts no. 9 in C minor, Z. 798: III. Canzona, Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6be322ae-fc05-3868-b06c-0d4524491708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:591d8383-3c31-3b18-b2b2-5945f8971025', 4, 'IV', 'Allegro', 'Trio Sonata of 3 parts no. 9 in C minor, Z. 798: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3156d30-3e7c-42af-8e43-8f8c3dcf7d22'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591d8383-3c31-3b18-b2b2-5945f8971025'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a84d0e66-27ea-4ae6-9380-4e1efad4fe0c', 10, NULL, '소나타 A장조', 'Trio Sonata in 3 parts no. 10 in A major, Z. 799', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84d0e66-27ea-4ae6-9380-4e1efad4fe0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19faa994-d6a4-3fc1-883b-580e0587d045', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 10 in A major, Z. 799: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a84d0e66-27ea-4ae6-9380-4e1efad4fe0c'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19faa994-d6a4-3fc1-883b-580e0587d045'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6683c342-ec11-3e4e-b774-aee22de41037', 2, 'II', 'Largo', 'Trio Sonata of 3 parts no. 10 in A major, Z. 799: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a84d0e66-27ea-4ae6-9380-4e1efad4fe0c'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6683c342-ec11-3e4e-b774-aee22de41037'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c369474-f29d-393e-9237-15e73bc45b25', 3, 'III', 'Grave, Presto', 'Trio Sonata of 3 parts no. 10 in A major, Z. 799: III. Grave, Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a84d0e66-27ea-4ae6-9380-4e1efad4fe0c'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c369474-f29d-393e-9237-15e73bc45b25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21', 11, NULL, '소나타 F단조', 'Trio Sonata in 3 parts no. 11 in F minor, Z. 800', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acdafff8-327b-31d5-8cd9-3a8ef056a509', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 11 in F minor, Z. 800: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acdafff8-327b-31d5-8cd9-3a8ef056a509'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:372eb198-e79c-3753-917f-f74a540763f9', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 11 in F minor, Z. 800: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372eb198-e79c-3753-917f-f74a540763f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c7add93-0d45-3498-81fe-047af37e86f4', 3, 'III', 'Adagio', 'Trio Sonata of 3 parts no. 11 in F minor, Z. 800: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c7add93-0d45-3498-81fe-047af37e86f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4897115-291a-39a8-9c44-acfea5b33d94', 4, 'IV', 'Largo', 'Trio Sonata of 3 parts no. 11 in F minor, Z. 800: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:522a54fa-4d6b-41c0-aaa4-e3670fd46a21'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4897115-291a-39a8-9c44-acfea5b33d94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc', 12, NULL, '소나타 D장조', 'Trio Sonata in 3 parts no. 12 in D major, Z. 801', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea30bbe1-1f86-35a4-bbd0-4ac0f81ff557', 1, 'I', 'Adagio', 'Trio Sonata of 3 parts no. 12 in D major, Z. 801: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea30bbe1-1f86-35a4-bbd0-4ac0f81ff557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79c9ffb7-1329-3ea9-bb00-c3b5fd6ca553', 2, 'II', 'Canzona', 'Trio Sonata of 3 parts no. 12 in D major, Z. 801: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c9ffb7-1329-3ea9-bb00-c3b5fd6ca553'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aebc0de5-c64d-310c-ac19-730607717490', 3, 'III', 'Poco Largo', 'Trio Sonata of 3 parts no. 12 in D major, Z. 801: III. Poco Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aebc0de5-c64d-310c-ac19-730607717490'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82e97fe3-184d-390a-838e-55ce67c7df2d', 4, 'IV', 'Grave, Presto', 'Trio Sonata of 3 parts no. 12 in D major, Z. 801: IV. Grave, Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82e97fe3-184d-390a-838e-55ce67c7df2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06159db7-daaf-3b6c-89ea-48922b702067', 5, 'V', 'Allegro', 'Trio Sonata of 3 parts no. 12 in D major, Z. 801: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c54b1a6-4262-4b85-8196-aacfe32a6ecc'
WHERE p.composer_id = 8 AND p.title = '3성부 소나타 Z 790–801' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06159db7-daaf-3b6c-89ea-48922b702067'
);


-- Z 802–811 4성부 소나타 Z 802–811

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 소나타 Z 802–811', 'Ten Sonata''s in Four Parts, Z. 802–811', 'album', NULL, 'Z', '802–811', 1697, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 소나타 Z 802–811'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d', 1, NULL, '소나타 B단조', 'Trio Sonata in 4 parts no. 1 in B minor, Z. 802', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f46adc2-756b-3c24-8009-ecc6a70bafb6', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 1 in B minor, Z. 802: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f46adc2-756b-3c24-8009-ecc6a70bafb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3a6742e-3b90-3b01-a450-05dd7bed5c08', 2, 'II', 'Canzona', 'Trio Sonata in 4 parts no. 1 in B minor, Z. 802: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3a6742e-3b90-3b01-a450-05dd7bed5c08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87eaa2e3-15ab-32a1-98d9-f28b4ea5530a', 3, 'III', 'Largo', 'Trio Sonata in 4 parts no. 1 in B minor, Z. 802: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87eaa2e3-15ab-32a1-98d9-f28b4ea5530a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6baa15b6-e0a8-308b-a99e-3c90e09d8464', 4, 'IV', 'Vivace', 'Trio Sonata in 4 parts no. 1 in B minor, Z. 802: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2abf2d69-b756-4459-a5f7-8361bfcef07d'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6baa15b6-e0a8-308b-a99e-3c90e09d8464'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1', 2, NULL, '소나타 E♭장조', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d80334bd-3c1e-3a13-8502-b9d904fe7d30', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d80334bd-3c1e-3a13-8502-b9d904fe7d30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:856de747-e7f0-3950-a8b1-8135ebf05b55', 2, 'II', 'Canzona (allegro)', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803: II. Canzona (allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856de747-e7f0-3950-a8b1-8135ebf05b55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69ea3350-ab08-3982-9fb7-e1dd8aa377f7', 3, 'III', 'Adagio', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ea3350-ab08-3982-9fb7-e1dd8aa377f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6122bae6-210b-3411-97a8-7bb72a40861a', 4, 'IV', 'Largo', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6122bae6-210b-3411-97a8-7bb72a40861a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eafe898b-7cd6-3579-9c61-0aaf712dd5fc', 5, 'V', 'Allegro', 'Trio Sonata in 4 parts no. 2 in E-flat major, Z. 803: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:afe1c48f-2e5b-4be8-b985-b9460d27e5d1'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eafe898b-7cd6-3579-9c61-0aaf712dd5fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae', 3, NULL, '소나타 A단조', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2188eb3-719f-3af5-89cf-9204024def1b', 1, 'I', 'Grave', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804: I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2188eb3-719f-3af5-89cf-9204024def1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1d07e82-5e94-3210-96d6-8690171a6ac3', 2, 'II', 'Largo', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d07e82-5e94-3210-96d6-8690171a6ac3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c435d8eb-52e3-3856-9e33-c20b48f4647f', 3, 'III', 'Adagio', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c435d8eb-52e3-3856-9e33-c20b48f4647f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9cd16ce-4caf-3d06-865a-aa26475669a2', 4, 'IV', 'Canzona', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804: IV. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9cd16ce-4caf-3d06-865a-aa26475669a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:240c8c48-64b5-306a-8267-332343a61e33', 5, 'V', 'Allegro - Grave', 'Trio Sonata in 4 parts no. 3 in A minor, Z. 804: V. Allegro - Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:86aae24b-8db0-4ef6-9e00-ed6d3e9873ae'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240c8c48-64b5-306a-8267-332343a61e33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a', 4, NULL, '소나타 D단조', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc10431e-e6b9-36b6-b317-aa584273ddc3', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc10431e-e6b9-36b6-b317-aa584273ddc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eafe2a55-e0be-304d-a843-9fa47c9edcb4', 2, 'II', 'Canzona', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eafe2a55-e0be-304d-a843-9fa47c9edcb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8bdc6af-143c-3044-9c63-2f9518c4b1af', 3, 'III', 'Adagio', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8bdc6af-143c-3044-9c63-2f9518c4b1af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:374b002e-41de-398b-a143-3ab4965098a4', 4, 'IV', 'Vivace', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:374b002e-41de-398b-a143-3ab4965098a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1eb7105-c3ec-3adb-995b-df8614db2ade', 5, 'V', 'Largo', 'Trio Sonata in 4 parts no. 4 in D minor, Z. 805: V. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a49bc71-9785-4b4a-ba91-529b2aad9f5a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1eb7105-c3ec-3adb-995b-df8614db2ade'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51', 5, NULL, '소나타 G단조', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf5163a0-92d1-3471-ad27-74437e9c0e9c', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf5163a0-92d1-3471-ad27-74437e9c0e9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b31b0aa6-2c81-3126-8a75-c3c4a8f0cbe3', 2, 'II', 'Canzona', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31b0aa6-2c81-3126-8a75-c3c4a8f0cbe3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf0c833c-e229-3474-9af9-719cf2cb6a05', 3, 'III', 'Largo', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0c833c-e229-3474-9af9-719cf2cb6a05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3b47e0a-8e79-3a35-92ab-c83fc15482f4', 4, 'IV', 'Adagio', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3b47e0a-8e79-3a35-92ab-c83fc15482f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:682dad3f-2b31-309f-af5c-6d09ce024c92', 5, 'V', 'Presto', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:682dad3f-2b31-309f-af5c-6d09ce024c92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:493a002d-cf65-3f3d-8189-901830524908', 6, 'VI', 'Allegro', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493a002d-cf65-3f3d-8189-901830524908'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23cce781-5fff-3152-bc4a-a244fe38777a', 7, 'VII', 'Adagio', 'Trio Sonata in 4 parts no. 5 in G minor, Z. 806: VII. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f95ced5-ad16-4195-8ba2-720860ba3e51'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23cce781-5fff-3152-bc4a-a244fe38777a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e263f6a4-47d0-3608-81ef-da8639050ccd', 6, NULL, '소나타 G단조 "샤콘"', 'Trio Sonata in 4 parts no. 6 in G minor (Chaconne), Z. 807', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e263f6a4-47d0-3608-81ef-da8639050ccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55', 7, NULL, '소나타 C장조', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a3104cf-fe68-3246-a372-005d84a45b97', 1, 'I', 'Vivace', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a3104cf-fe68-3246-a372-005d84a45b97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d36eb517-06af-3da1-815b-2980f3c1a50f', 2, 'II', 'Largo', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d36eb517-06af-3da1-815b-2980f3c1a50f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd779103-fcdb-3b56-8075-2d586a077e29', 3, 'III', 'Grave', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd779103-fcdb-3b56-8075-2d586a077e29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2d95d0d-ddb6-3fc4-baf7-851d9a16388b', 4, 'IV', 'Canzona', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: IV. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2d95d0d-ddb6-3fc4-baf7-851d9a16388b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b32455c6-34ee-34a5-bec1-41cc082b2904', 5, 'V', 'Allegro', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32455c6-34ee-34a5-bec1-41cc082b2904'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07997d20-a355-38b3-a787-a5e1c5947fad', 6, 'VI', 'Adagio', 'Trio Sonata in 4 parts no. 7 in C major, Z. 808: VI. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60a49267-36ef-4e6a-9520-f9c1e0829f55'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07997d20-a355-38b3-a787-a5e1c5947fad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f', 8, NULL, '소나타 G단조', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9ea4771-2d4f-30f1-8957-d62d20f68e77', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ea4771-2d4f-30f1-8957-d62d20f68e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ba23ee8-c852-3bbc-901c-52d661370472', 2, 'II', 'Canzona', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809: II. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba23ee8-c852-3bbc-901c-52d661370472'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10bbca2c-8a80-3e45-8156-628f566c6ce0', 3, 'III', 'Grave', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10bbca2c-8a80-3e45-8156-628f566c6ce0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ab28494-55ee-35ce-8ed0-a9399808aa6e', 4, 'IV', 'Largo', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab28494-55ee-35ce-8ed0-a9399808aa6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4b8d543-0697-3ef4-bcf3-0897eff3fe15', 5, 'V', 'Vivace', 'Trio Sonata in 4 parts no. 8 in G minor, Z. 809: V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6ef8ea01-e11e-4667-9b49-5095635f3c1f'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4b8d543-0697-3ef4-bcf3-0897eff3fe15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057', 9, NULL, '소나타 F장조', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04368e0a-0264-3516-93cd-44008409b7a4', 1, 'I', 'Vivace', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04368e0a-0264-3516-93cd-44008409b7a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21fe1194-befa-3254-9418-dcacad4fa0dd', 2, 'II', 'Adagio', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21fe1194-befa-3254-9418-dcacad4fa0dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34ba4b31-45d6-3b2b-a4cb-fdeef76a264a', 3, 'III', 'Canzona', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810: III. Canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ba4b31-45d6-3b2b-a4cb-fdeef76a264a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b0a2da-e93f-3b29-b89c-551cfd765f66', 4, 'IV', 'Grave', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810: IV. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b0a2da-e93f-3b29-b89c-551cfd765f66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afc28a06-748b-32f0-9486-580f7f702545', 5, 'V', 'Allegro', 'Trio Sonata in 4 parts no. 9 in F major, Z. 810: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:39fb2e9e-8f6b-4a6a-aee5-0ba775b9a057'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afc28a06-748b-32f0-9486-580f7f702545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a', 10, NULL, '소나타 D장조', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab6a0ec7-019c-3b21-be79-ba7c062d9348', 1, 'I', 'Adagio', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6a0ec7-019c-3b21-be79-ba7c062d9348'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c04ec005-afd4-39cb-b118-fb660e3dafdd', 2, 'II', 'Canzona (allegro)', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811: II. Canzona (allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c04ec005-afd4-39cb-b118-fb660e3dafdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2a9bf17-7bb9-38b3-925a-4cba636c1f99', 3, 'III', 'Grave', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811: III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a9bf17-7bb9-38b3-925a-4cba636c1f99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c67efa61-5f93-3557-a611-ee71d91c32df', 4, 'IV', 'Largo', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c67efa61-5f93-3557-a611-ee71d91c32df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7ac8f81-b85b-36d9-b3d1-3353a11d3af8', 5, 'V', 'Allegro', 'Trio Sonata in 4 parts no. 10 in D major, Z. 811: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7cb94fe7-a7dd-411f-a190-d708c34d0a1a'
WHERE p.composer_id = 8 AND p.title = '4성부 소나타 Z 802–811' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ac8f81-b85b-36d9-b3d1-3353a11d3af8'
);


-- Z 850 트럼펫 소나타 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트럼펫 소나타 D장조', 'Sonata for trumpet, strings, and basso continuo in D major, Z. 850', 'album', 'Z 850', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트럼펫 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b877e34-467f-472c-8b4f-db9bda08d14b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b877e34-467f-472c-8b4f-db9bda08d14b'
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '트럼펫 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b877e34-467f-472c-8b4f-db9bda08d14b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9429ea9b-dd07-3c5d-a6e3-808d97d239a7', 1, 'I', 'Allegro', 'Sonata for trumpet, strings, and basso continuo in D major, Z. 850: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '트럼펫 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9429ea9b-dd07-3c5d-a6e3-808d97d239a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1afd4cf-05dc-37db-8cde-89f4561f3785', 2, 'II', 'Adagio', 'Sonata for trumpet, strings, and basso continuo in D major, Z. 850: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '트럼펫 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1afd4cf-05dc-37db-8cde-89f4561f3785'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7128be2-b2ba-3261-b116-f6965b34dd65', 3, 'III', 'Presto', 'Sonata for trumpet, strings, and basso continuo in D major, Z. 850: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '트럼펫 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7128be2-b2ba-3261-b116-f6965b34dd65'
);


-- Z 660–669 하프시코드 모음곡 Z 660–669

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드 모음곡 Z 660–669', 'A Choice of Lessons for the Harpsichord or Spinnet, Z. 660–669', 'album', NULL, 'Z', '660–669', 1696, 'manual', 1
FROM composers c
WHERE c.id = 8
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드 모음곡 Z 660–669'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4', 1, NULL, '모음곡 G장조', 'Harpsichord Suite no. 1 in G major, Z. 660', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2001364a-2d52-3f3a-b603-a1ae312205cd', 1, 'I', 'Prelude', 'Harpsichord Suite no. 1 in G major, Z. 660: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2001364a-2d52-3f3a-b603-a1ae312205cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41099148-bd68-3b6d-9c3e-40f8c1e99779', 2, 'II', 'Almand', 'Harpsichord Suite no. 1 in G major, Z. 660: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41099148-bd68-3b6d-9c3e-40f8c1e99779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03c43c5b-626f-3067-91ea-d9848f583673', 3, 'III', 'Corant', 'Harpsichord Suite no. 1 in G major, Z. 660: III. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03c43c5b-626f-3067-91ea-d9848f583673'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7c589f1-fa9c-3c66-9677-13a6fa9e08fe', 4, 'IV', 'Minuet', 'Harpsichord Suite no. 1 in G major, Z. 660: IV. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c826514-b102-4dc0-aad9-5eebc8cb2aa4'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c589f1-fa9c-3c66-9677-13a6fa9e08fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a', 2, NULL, '모음곡 G단조', 'Harpsichord Suite no. 2 in G minor, Z. 661', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:131ed31d-5c03-39a0-9ec7-951854abbeb5', 1, 'I', 'Prelude', 'Harpsichord Suite no. 2 in G minor, Z. 661: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131ed31d-5c03-39a0-9ec7-951854abbeb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:beb5b109-d5b5-31f9-b30b-1f3a78c0b4b9', 2, 'II', 'Almand', 'Harpsichord Suite no. 2 in G minor, Z. 661: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beb5b109-d5b5-31f9-b30b-1f3a78c0b4b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:810f36e7-9668-3347-a9b8-f8313b8669b3', 3, 'III', 'Corant', 'Harpsichord Suite no. 2 in G minor, Z. 661: III. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:810f36e7-9668-3347-a9b8-f8313b8669b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf25a6bd-6c75-359b-bb66-5d27cda9feae', 4, 'IV', 'Sarabande', 'Harpsichord Suite no. 2 in G minor, Z. 661: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e5cb70c-3d6c-4ad3-807d-1004eb5b980a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf25a6bd-6c75-359b-bb66-5d27cda9feae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e5dcc6b-f6ad-4771-ba47-d45dcf03f0ae', 3, NULL, '모음곡 G장조', 'Harpsichord Suite no. 3 in G major, Z. 662', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e5dcc6b-f6ad-4771-ba47-d45dcf03f0ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c61f020e-3921-36f6-bdbc-d3d8c219c9eb', 1, 'I', 'Prelude', 'Harpsichord Suite no. 3 in G major, Z. 662: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e5dcc6b-f6ad-4771-ba47-d45dcf03f0ae'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c61f020e-3921-36f6-bdbc-d3d8c219c9eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e440cb82-1a18-3b9a-a21c-77d387e31435', 2, 'II', 'Almand', 'Harpsichord Suite no. 3 in G major, Z. 662: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e5dcc6b-f6ad-4771-ba47-d45dcf03f0ae'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e440cb82-1a18-3b9a-a21c-77d387e31435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8fdb57dd-e099-39b3-b716-cb22116a280c', 3, 'III', 'Corant', 'Harpsichord Suite no. 3 in G major, Z. 662: III. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e5dcc6b-f6ad-4771-ba47-d45dcf03f0ae'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fdb57dd-e099-39b3-b716-cb22116a280c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c', 4, NULL, '모음곡 A단조', 'Harpsichord Suite no. 4 in A minor, Z. 663', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21ad3a21-c2fe-32d7-a695-188f22f0f152', 1, 'I', 'Prelude', 'Harpsichord Suite no. 4 in A minor, Z. 663: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ad3a21-c2fe-32d7-a695-188f22f0f152'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5572922-2188-3ee4-879b-c7a4a473064c', 2, 'II', 'Almand', 'Harpsichord Suite no. 4 in A minor, Z. 663: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5572922-2188-3ee4-879b-c7a4a473064c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4968595e-a356-36f5-b98c-cf80377c390c', 3, 'III', 'Corante', 'Harpsichord Suite no. 4 in A minor, Z. 663: III. Corante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4968595e-a356-36f5-b98c-cf80377c390c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a35d05ed-0786-3a83-9aaa-45270a042011', 4, 'IV', 'Sarabande', 'Harpsichord Suite no. 4 in A minor, Z. 663: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2478a9d4-b454-4d4a-b42f-d4353fb1e56c'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a35d05ed-0786-3a83-9aaa-45270a042011'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9', 5, NULL, '모음곡 C장조', 'Harpsichord Suite no. 5 in C major, Z. 666', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b99972-aada-3973-9ccb-a71446a11dbb', 1, 'I', 'Prelude', 'Harpsichord Suite no. 5 in C major, Z. 666: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b99972-aada-3973-9ccb-a71446a11dbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e8f004d-b876-3e3a-ad3c-141b08a92931', 2, 'II', 'Almand', 'Harpsichord Suite no. 5 in C major, Z. 666: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e8f004d-b876-3e3a-ad3c-141b08a92931'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:afdd7743-f2e9-3848-8c3a-5b1fa37d5729', 3, 'III', 'Corant', 'Harpsichord Suite no. 5 in C major, Z. 666: III. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afdd7743-f2e9-3848-8c3a-5b1fa37d5729'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a52d824-2115-30ad-8d3d-e1d829078182', 4, 'IV', 'Sarabande', 'Harpsichord Suite no. 5 in C major, Z. 666: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:33e8b34e-002f-4c83-80ab-e0096764adb9'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a52d824-2115-30ad-8d3d-e1d829078182'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d271601-3547-4b5c-b64d-2dca83965027', 6, NULL, '모음곡 D장조', 'Harpsichord Suite no. 6 in D major, Z. 667', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d271601-3547-4b5c-b64d-2dca83965027'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5026d9a0-01b8-3aaf-a07e-ada8af01f75c', 1, 'I', 'Prelude', 'Harpsichord Suite no. 6 in D major, Z. 667: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d271601-3547-4b5c-b64d-2dca83965027'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5026d9a0-01b8-3aaf-a07e-ada8af01f75c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f672f3f-395a-36b2-8af8-583b0d62e1d3', 2, 'II', 'Almand', 'Harpsichord Suite no. 6 in D major, Z. 667: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d271601-3547-4b5c-b64d-2dca83965027'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f672f3f-395a-36b2-8af8-583b0d62e1d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:231d9f66-699d-38e8-80d6-a2bd178319d3', 3, 'III', 'Hornpipe', 'Harpsichord Suite no. 6 in D major, Z. 667: III. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d271601-3547-4b5c-b64d-2dca83965027'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:231d9f66-699d-38e8-80d6-a2bd178319d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445271b0-b397-44f6-ae00-5fa6d241c73f', 7, NULL, '모음곡 D단조', 'Harpsichord Suite no. 7 in D minor, Z. 668', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445271b0-b397-44f6-ae00-5fa6d241c73f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2f78ab5-5acf-36e5-8154-d707fde975b8', 1, 'I', 'Almand', 'Harpsichord Suite no. 7 in D minor, Z. 668: I. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445271b0-b397-44f6-ae00-5fa6d241c73f'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f78ab5-5acf-36e5-8154-d707fde975b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:136bc4cf-80bc-3942-b735-860ddfc565a1', 2, 'II', 'Corant', 'Harpsichord Suite no. 7 in D minor, Z. 668: II. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445271b0-b397-44f6-ae00-5fa6d241c73f'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:136bc4cf-80bc-3942-b735-860ddfc565a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9223c73-7810-3b17-bde0-6558ab921f9b', 3, 'III', 'Hornpipe', 'Harpsichord Suite no. 7 in D minor, Z. 668: III. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445271b0-b397-44f6-ae00-5fa6d241c73f'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9223c73-7810-3b17-bde0-6558ab921f9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a', 8, NULL, '모음곡 F장조', 'Harpsichord Suite no. 8 in F major, Z. 669', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:328678f8-4710-337a-bd83-91125e00d9cf', 1, 'I', 'Prelude', 'Harpsichord Suite no. 8 in F major, Z. 669: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328678f8-4710-337a-bd83-91125e00d9cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16cb2eec-0f43-33f1-93a9-93cb3db6471e', 2, 'II', 'Almand', 'Harpsichord Suite no. 8 in F major, Z. 669: II. Almand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16cb2eec-0f43-33f1-93a9-93cb3db6471e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f6dfde7-9492-32be-b1a7-7e40fdc1a6e6', 3, 'III', 'Corant', 'Harpsichord Suite no. 8 in F major, Z. 669: III. Corant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f6dfde7-9492-32be-b1a7-7e40fdc1a6e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7c93b8d-8bd0-3dac-94e3-ad84d99836e2', 4, 'IV', 'Minuet', 'Harpsichord Suite no. 8 in F major, Z. 669: IV. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a42a127a-b724-49c7-8e0b-d27644a4440a'
WHERE p.composer_id = 8 AND p.title = '하프시코드 모음곡 Z 660–669' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c93b8d-8bd0-3dac-94e3-ad84d99836e2'
);

-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 8 AND title = '세미 오페라 <디오클레시안>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 8 AND title = '세미 오페라 <아서 왕>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 8 AND title = '세미 오페라 <인도의 여왕>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_other'
WHERE composer_id = 8 AND title = '가면극 <아테네의 타이먼>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <암피트리온>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <Distressed Innocence>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <The Gordian Knot Unty''d>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <The Libertine>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <오이디푸스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <The Old Bachelor>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <The Married Beau>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <The Virtuous Wife>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <본두카>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <파우사니아스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'incidental'
WHERE composer_id = 8 AND title = '부수음악 <돈키호테>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <From those serene and rapturous joys>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Why, why are all the Muses mute?>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Ye tuneful Muses>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Sound the trumpet, beat the drum>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Now does the glorious day appear>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Of old when heroes thought it base>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Welcome, welcome, glorious morn>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Love''s goddess sure was blind>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Celebrate this festival>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <오라, 너희 예술의 아들들아>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '송가 <Who can from joy refrain?>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '성 체칠리아의 날을 위한 송가 <Welcome to all the pleasures>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '성 체칠리아의 날을 위한 송가 <Raise, raise the voice>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 8 AND title = '성 체칠리아의 날을 위한 송가 <Hail, bright Cecilia>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <Hear my prayer, O Lord>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '대관식 찬가 <I was glad>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '대관식 찬가 <My heart is inditing>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <My beloved spake>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <O God, thou art my God>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <O sing unto the Lord a new song>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <Rejoice in the Lord alway>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <Remember not, Lord, our offences>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <They that go down to the sea in ships>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '찬가 <Thy word is a lantern unto my feet>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '모테트 <Jehova, quam multi sunt hostes mei>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '예배곡 B♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '마니피카트와 눙크 디미티스 G단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '테 데움과 유빌라테 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '저녁 찬송 <Now that the sun hath veiled his light>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '종교 가곡 <Lord, what is man?>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 8 AND title = '종교 가곡 <The Blessed Virgin''s Expostulation>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 8 AND title = '가곡 <From silent shades> "미친 베스"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 8 AND title = '가곡 <O Solitude>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 8 AND title = '가곡 <If music be the food of love>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 8 AND title = '여왕의 비가 <Incassum, Lesbia, rogas>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE composer_id = 8 AND title = '샤코니 G단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE composer_id = 8 AND title = '그라운드에 의한 3성부 판타지아' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE composer_id = 8 AND title = '비올 판타지아와 인 노미네' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 8 AND title = '바이올린 소나타 G단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 8 AND title = '3성부 소나타 Z 790–801' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 8 AND title = '4성부 소나타 Z 802–811' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 8 AND title = '트럼펫 소나타 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'keyboard_suite'
WHERE composer_id = 8 AND title = '하프시코드 모음곡 Z 660–669' AND genre IS NULL AND form_key IS NULL;
