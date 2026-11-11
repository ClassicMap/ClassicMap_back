-- 클라우디오 몬테베르디(composer_id 5) 작품 목록. 지금은 작곡가 화면에 4곡(오르페오·저녁기도·님프의 탄식·포페아의 대관)뿐이다.
-- 작품 39개(새 36 + 기존 3), 묶음·다악장 작품 안 곡 305개, 그 안 악장 18개, 장르·형식.
--
-- 출판 묶음 중심으로 손으로 골랐다: 마드리갈 1~9권, 3성부 칸초네타(1584), 스케르치 무지칼리(1607·1632), 모테트집(1582),
-- 종교곡집 <도덕적이고 영적인 숲>(1641)·<미사와 시편>(1650), 6성부 미사 "인 일로 템포레", 오페라 <울리세의 귀환>, 아리안나의 탄식, 따로 나온 모테트·노래 18.
-- 묶음 곡 순서·SV 번호는 영어 위키백과 작품 목록 세부 표(Stattkus 목록)를 따르고 MB 곡은 SV 번호로 찾았다. 자료와 생성기:
--   seed_pipeline/curation/baroque-catalog-2026-11-12/(build.py, monteverdi/works.tsv·parts.tsv) → catalog-wave4 gen_catalog.py
-- 기존 3곡은 제목·설명·링크를 두고 MBID 와 곡만 잇는다. 「님프의 탄식」(19)은 마드리갈 8권 안 곡으로 이어 최상위에서 빠진다(「처음 듣는다면」 카드는 그대로).
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- SV 318 오르페오

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20d389f8-b79b-4f38-a031-6db68c8d0901'
FROM pieces p
WHERE p.id = 17 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20d389f8-b79b-4f38-a031-6db68c8d0901'
);


-- SV 206 성모 마리아의 저녁기도

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c05338ae-3457-49fb-a042-fed834a34411'
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c05338ae-3457-49fb-a042-fed834a34411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Domine ad adiuvandum', part.name_en = 'Vespro della Beata Vergine, SV 206: I. "Deus in adiutorium" / II. Toccata "Domine ad adiuvandum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:563fd005-ffa4-37cf-94b3-1522d66ee30d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563fd005-ffa4-37cf-94b3-1522d66ee30d', 1, 'I', 'Domine ad adiuvandum', 'Vespro della Beata Vergine, SV 206: I. "Deus in adiutorium" / II. Toccata "Domine ad adiuvandum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563fd005-ffa4-37cf-94b3-1522d66ee30d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dixit Dominus', part.name_en = 'Vespro della Beata Vergine, SV 206: II. Psalmus I "Dixit Dominus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:03e4976b-3b53-34be-a9c3-664cc7f7a774' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03e4976b-3b53-34be-a9c3-664cc7f7a774', 2, 'II', 'Dixit Dominus', 'Vespro della Beata Vergine, SV 206: II. Psalmus I "Dixit Dominus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e4976b-3b53-34be-a9c3-664cc7f7a774'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nigra sum', part.name_en = 'Vespro della Beata Vergine, SV 206: III. Motetto "Nigra sum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:6405b815-5b54-3f0a-a77e-ea1352b47dbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6405b815-5b54-3f0a-a77e-ea1352b47dbd', 3, 'III', 'Nigra sum', 'Vespro della Beata Vergine, SV 206: III. Motetto "Nigra sum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6405b815-5b54-3f0a-a77e-ea1352b47dbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Laudate pueri Dominum', part.name_en = 'Vespro della Beata Vergine, SV 206: IV. Psalmus II "Laudate pueri Dominum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:301997ad-c361-361e-95cc-4d39d894622f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:301997ad-c361-361e-95cc-4d39d894622f', 4, 'IV', 'Laudate pueri Dominum', 'Vespro della Beata Vergine, SV 206: IV. Psalmus II "Laudate pueri Dominum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:301997ad-c361-361e-95cc-4d39d894622f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Pulchra es', part.name_en = 'Vespro della Beata Vergine, SV 206: V. Concerto "Pulchra es"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:3a10da61-b213-3d59-87df-67ff3d9a8e67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a10da61-b213-3d59-87df-67ff3d9a8e67', 5, 'V', 'Pulchra es', 'Vespro della Beata Vergine, SV 206: V. Concerto "Pulchra es"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a10da61-b213-3d59-87df-67ff3d9a8e67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Laetatus sum', part.name_en = 'Vespro della Beata Vergine, SV 206: VI. Psalmus III "Laetatus sum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:6461799b-e373-3dfe-aa7b-40db83774a96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6461799b-e373-3dfe-aa7b-40db83774a96', 6, 'VI', 'Laetatus sum', 'Vespro della Beata Vergine, SV 206: VI. Psalmus III "Laetatus sum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6461799b-e373-3dfe-aa7b-40db83774a96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Duo Seraphim', part.name_en = 'Vespro della Beata Vergine, SV 206: VII. Concerto "Duo Seraphim"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:26578ed9-be61-3444-a753-62af328cefba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26578ed9-be61-3444-a753-62af328cefba', 7, 'VII', 'Duo Seraphim', 'Vespro della Beata Vergine, SV 206: VII. Concerto "Duo Seraphim"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26578ed9-be61-3444-a753-62af328cefba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Nisi Dominus', part.name_en = 'Vespro della Beata Vergine, SV 206: VIII. Psalmus IV "Nisi Dominus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:64218544-673b-3f07-a34b-9f90281ff35f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64218544-673b-3f07-a34b-9f90281ff35f', 8, 'VIII', 'Nisi Dominus', 'Vespro della Beata Vergine, SV 206: VIII. Psalmus IV "Nisi Dominus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64218544-673b-3f07-a34b-9f90281ff35f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Audi coelum', part.name_en = 'Vespro della Beata Vergine, SV 206: IX. Concerto "Audi coelum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:f0f6ea9b-55fd-3568-8869-e32b6b913b7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0f6ea9b-55fd-3568-8869-e32b6b913b7e', 9, 'IX', 'Audi coelum', 'Vespro della Beata Vergine, SV 206: IX. Concerto "Audi coelum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0f6ea9b-55fd-3568-8869-e32b6b913b7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Lauda Jerusalem', part.name_en = 'Vespro della Beata Vergine, SV 206: X. Psalmus V "Lauda Jerusalem"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:684793f6-69e6-35e0-a394-fd1a354c7657' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684793f6-69e6-35e0-a394-fd1a354c7657', 10, 'X', 'Lauda Jerusalem', 'Vespro della Beata Vergine, SV 206: X. Psalmus V "Lauda Jerusalem"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684793f6-69e6-35e0-a394-fd1a354c7657'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Sonata sopra "Sancta Maria"', part.name_en = 'Vespro della Beata Vergine, SV 206: XI. Sonata sopra "Sancta Maria"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:8e91a915-614c-3aeb-baf8-9a1784ba8279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e91a915-614c-3aeb-baf8-9a1784ba8279', 11, 'XI', 'Sonata sopra "Sancta Maria"', 'Vespro della Beata Vergine, SV 206: XI. Sonata sopra "Sancta Maria"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e91a915-614c-3aeb-baf8-9a1784ba8279'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Ave maris stella', part.name_en = 'Vespro della Beata Vergine, SV 206: XII. Hymnus "Ave maris stella"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:99e40f69-ef0e-39d4-987d-509ad60daea2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99e40f69-ef0e-39d4-987d-509ad60daea2', 12, 'XII', 'Ave maris stella', 'Vespro della Beata Vergine, SV 206: XII. Hymnus "Ave maris stella"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e40f69-ef0e-39d4-987d-509ad60daea2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Magnificat (7성부)', part.name_en = 'Vespro della Beata Vergine, SV 206: XIII. Magnificat (I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:8b97d827-281f-42e8-bda5-6d68cbc7fddd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b97d827-281f-42e8-bda5-6d68cbc7fddd', 13, 'XIII', 'Magnificat (7성부)', 'Vespro della Beata Vergine, SV 206: XIII. Magnificat (I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b97d827-281f-42e8-bda5-6d68cbc7fddd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Magnificat (6성부)', part.name_en = 'Vespro della Beata Vergine, SV 206a: XIII. Magnificat (II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18 AND p.composer_id = 5 AND part.part_key = 'musicbrainz:a63cde36-5eeb-4fca-a947-13865a1c1bea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a63cde36-5eeb-4fca-a947-13865a1c1bea', 14, 'XIV', 'Magnificat (6성부)', 'Vespro della Beata Vergine, SV 206a: XIII. Magnificat (II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a63cde36-5eeb-4fca-a947-13865a1c1bea'
);


-- SV 308 포페아의 대관

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04da0699-cf05-4d95-9605-c8718501dd82'
FROM pieces p
WHERE p.id = 20 AND p.composer_id = 5
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04da0699-cf05-4d95-9605-c8718501dd82'
);


-- SV 325 오페라 <울리세의 귀환>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <울리세의 귀환>', 'Il ritorno d''Ulisse in patria, SV 325', 'song', 'SV 325', NULL, NULL, 1640, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <울리세의 귀환>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab3e6a0-00bb-4165-9e74-3ce286ee11dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ab3e6a0-00bb-4165-9e74-3ce286ee11dd'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '오페라 <울리세의 귀환>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab3e6a0-00bb-4165-9e74-3ce286ee11dd'
);


-- SV 22 오페라 <아리안나> 중 "아리안나의 탄식"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아리안나> 중 "아리안나의 탄식"', 'Lamento d’Arianna, SV 22', 'song', 'SV 22', NULL, NULL, 1608, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아리안나> 중 "아리안나의 탄식"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3794c42-4de1-348b-8bd7-696a9b1b56e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3794c42-4de1-348b-8bd7-696a9b1b56e7'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '오페라 <아리안나> 중 "아리안나의 탄식"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3794c42-4de1-348b-8bd7-696a9b1b56e7'
);


-- SV 1–21 3성부 칸초네타집

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 칸초네타집', 'Canzonette a tre voci, SV 1-21', 'album', 'SV 1–21', NULL, NULL, 1584, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 칸초네타집'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ce3b56b-b67a-4bda-b4b8-3871adbb1a9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ce3b56b-b67a-4bda-b4b8-3871adbb1a9c'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ce3b56b-b67a-4bda-b4b8-3871adbb1a9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:1', 1, NULL, 'Qual si può dir maggiore', 'Qual si può dir maggiore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:2', 2, NULL, 'Canzonette d''amore che m''uscite del cuore', 'Canzonette d''amore che m''uscite del cuore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bac2868-67a9-4114-bb98-3da9cf0fc995', 3, NULL, 'La fiera vista', 'La fiera vista, SV 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bac2868-67a9-4114-bb98-3da9cf0fc995'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:4', 4, NULL, 'Raggi, dov''è il mio bene', 'Raggi, dov''è il mio bene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:5', 5, NULL, 'Vita de l''alma mia', 'Vita de l''alma mia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:6', 6, NULL, 'Il mio martir tengo celat al cuore', 'Il mio martir tengo celat al cuore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:7', 7, NULL, 'Son questi i crespi crini e questo il viso', 'Son questi i crespi crini e questo il viso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:8', 8, NULL, 'Io mi vivea com'' Aquila mirando', 'Io mi vivea com'' Aquila mirando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:9', 9, NULL, 'Su su su che''l giorno è fore', 'Su su su che''l giorno è fore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9165ba81-5c5c-4f56-a83c-5e84b768b194', 10, NULL, 'Quando sperai del mio servir mercede', 'Quando sperai del mio servir mercede, SV 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9165ba81-5c5c-4f56-a83c-5e84b768b194'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181227ca-9449-4656-9230-739eac29a57f', 11, NULL, 'Come farò cuor mio quando mi parto', 'Come farò cuor mio quando mi parto, SV 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181227ca-9449-4656-9230-739eac29a57f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:12', 12, NULL, 'Corse a la morte il povero Narciso', 'Corse a la morte il povero Narciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:13', 13, NULL, 'Tu ridi sempre mai per darmi pene', 'Tu ridi sempre mai per darmi pene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:14', 14, NULL, 'Chi vuol veder d''inverno un dolc'' aprile', 'Chi vuol veder d''inverno un dolc'' aprile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:15', 15, NULL, 'Già mi credev'' un sol esser in cielo', 'Già mi credev'' un sol esser in cielo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:16', 16, NULL, 'Godi pur del bel sen felice pulce', 'Godi pur del bel sen felice pulce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:17', 17, NULL, 'Giulia quel petto giace un bel giardino', 'Giulia quel petto giace un bel giardino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:18', 18, NULL, 'Sì come crescon alla terra i fiori', 'Sì come crescon alla terra i fiori', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:19', 19, NULL, 'Io son Fenice e voi sete la fiamma', 'Io son Fenice e voi sete la fiamma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:20', 20, NULL, 'Chi vuol veder un bosco folto e spesso', 'Chi vuol veder un bosco folto e spesso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-1ce3b56b:21', 21, NULL, 'Hor care canzonette sicuramente andrete', 'Hor care canzonette sicuramente andrete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '3성부 칸초네타집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-1ce3b56b:21'
);


-- SV 23–39 마드리갈 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 1권', 'Madrigals, Book 1, SV 23–39', 'album', 'SV 23–39', NULL, NULL, 1587, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 1권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b2e6ed-372d-47ca-900e-b8198b147254'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07b2e6ed-372d-47ca-900e-b8198b147254'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b2e6ed-372d-47ca-900e-b8198b147254'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac400255-ef43-4938-97f8-8ad1407f9ff4', 1, NULL, 'Ch''ami la vita mia nel tuo bel nome', 'Ch''ami la vita mia nel tuo bel nome, SV 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac400255-ef43-4938-97f8-8ad1407f9ff4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17e9048c-ae54-4b6d-9c56-9f4f13f28904', 2, NULL, 'Se per avervi, ohime, donato il core', 'Se per avervi, ohime, donato il core, SV 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e9048c-ae54-4b6d-9c56-9f4f13f28904'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd210f09-c739-408b-818a-c1bf9b6bf07a', 3, NULL, 'A che tormi il ben mio', 'A che tormi il ben mio, SV 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd210f09-c739-408b-818a-c1bf9b6bf07a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180fd772-f51b-4aff-856e-4dfe11a0c244', 4, NULL, 'Amor, per tua merce vattene a quella', 'Amor, per tua merce vattene a quella, SV 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180fd772-f51b-4aff-856e-4dfe11a0c244'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26cb80f4-ee5e-4d8f-b531-381620104899', 5, NULL, 'Baci soavi e cari', 'Baci soavi e cari, SV 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26cb80f4-ee5e-4d8f-b531-381620104899'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16686e54-a563-4374-ac7a-5ae3bcdc3d24', 6, NULL, 'Se pur non mi consenti', 'Se pur non mi consenti, SV 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16686e54-a563-4374-ac7a-5ae3bcdc3d24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6810f50-9328-4a5d-a2e6-930f805a3c2e', 7, NULL, 'Filli cara ed amata', 'Filli cara ed amata, SV 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6810f50-9328-4a5d-a2e6-930f805a3c2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66f8a8b6-2893-4e8e-bd4c-2bf5e8b96d94', 8, NULL, 'Poiché del mio dolore', 'Poiché del mio dolore, SV 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66f8a8b6-2893-4e8e-bd4c-2bf5e8b96d94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ad9dbcc-1438-4955-aeee-a86879e7ca9e', 9, NULL, 'Fumia la pastorella', 'Fumia la pastorella, SV 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ad9dbcc-1438-4955-aeee-a86879e7ca9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb40da18-9d91-4155-8b72-7296628a6284', 10, NULL, 'Se nel partir da voi', 'Se nel partir da voi, SV 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb40da18-9d91-4155-8b72-7296628a6284'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07540113-aa87-43a8-9365-55c866820a95', 11, NULL, 'Tra mille fiamme e tra mille catene', 'Tra mille fiamme e tra mille catene, SV 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07540113-aa87-43a8-9365-55c866820a95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78cf70a4-24e7-4c3b-a11f-a52a3881b2dc', 12, NULL, 'Usciam, ninfe, omai fuor di questi boschi', 'Usciam, ninfe, omai fuor di questi boschi, SV 34', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78cf70a4-24e7-4c3b-a11f-a52a3881b2dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88983486-47b6-454b-88ff-882334fe0adf', 13, NULL, 'Questa ordì il laccio', 'Questa ordì il laccio, SV 35', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88983486-47b6-454b-88ff-882334fe0adf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f86743b-0802-4ec6-a276-fd04e7115969', 14, NULL, 'La vaga pastorella', 'La vaga pastorella, SV 36', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f86743b-0802-4ec6-a276-fd04e7115969'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840d43ce-59ce-4c6c-a0e4-5e5d97d4c8c2', 15, NULL, 'Amor s''il tuo ferire', 'Amor s''il tuo ferire, SV 37', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840d43ce-59ce-4c6c-a0e4-5e5d97d4c8c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ceac746-5266-4eb8-a433-c1e4e0052e46', 16, NULL, 'Donna s''io miro voi, giaccio divengo', 'Donna s''io miro voi, giaccio divengo, SV 38', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ceac746-5266-4eb8-a433-c1e4e0052e46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a287f85a-f8cb-41d3-808d-d2452ea97bdd', 17, NULL, 'Ardo, sì, ma non t''amo', 'Ardo, sì, ma non t’amo, SV 39', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a287f85a-f8cb-41d3-808d-d2452ea97bdd'
);


-- SV 40–59 마드리갈 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 2권', 'Madrigals, Book 2, SV 40–59', 'album', 'SV 40–59', NULL, NULL, 1590, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 2권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e99c451f-4952-4ed5-ba85-1386e4580bbe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e99c451f-4952-4ed5-ba85-1386e4580bbe'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e99c451f-4952-4ed5-ba85-1386e4580bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d0c116a-3575-4e79-a704-cb6ad4662805', 1, NULL, 'Non si levav''ancor l''alba novella', 'Non si levav’ancor l’alba novella, SV 40', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d0c116a-3575-4e79-a704-cb6ad4662805'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c85fc445-ca56-4de4-88cb-32d1010744f8', 2, NULL, 'Bevea Fillide mia e nel ber dolcemente', 'Bevea Fillide mia e nel ber dolcemente, SV 41', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85fc445-ca56-4de4-88cb-32d1010744f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a457825-f454-4caa-b3ea-9c5bffbd004c', 3, NULL, 'Dolcissimi legami di parole amorose', 'Dolcissimi legami di parole amorose, SV 42', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a457825-f454-4caa-b3ea-9c5bffbd004c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418da298-20db-427b-8054-855e6177f218', 4, NULL, 'Non giacinti o narcisi', 'Non giacinti o narcisi, SV 43', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418da298-20db-427b-8054-855e6177f218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8f5c8a9-01ce-4872-b517-d0befcce7c08', 5, NULL, 'Intorno a due vermiglie e vaghe labbra', 'Intorno a due vermiglie e vaghe labbra, SV 44', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8f5c8a9-01ce-4872-b517-d0befcce7c08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00aece23-1d2b-45cc-b26d-a86cd194a07b', 6, NULL, 'Non sono in queste rive fiori così vermigli', 'Non sono in queste rive fiori così vermigli, SV 45', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00aece23-1d2b-45cc-b26d-a86cd194a07b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c07990a-c8e5-40d1-8b09-7472775e0428', 7, NULL, 'Tutte le bocche belle in questo nero volto', 'Tutte le bocche belle in questo nero volto, SV 46', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c07990a-c8e5-40d1-8b09-7472775e0428'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:564c97c0-6dd4-403a-89d3-67c95e534977', 8, NULL, 'Donna, nel mio ritorno', 'Donna, nel mio ritorno, SV 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:564c97c0-6dd4-403a-89d3-67c95e534977'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9753dc4a-a195-4cc4-adfa-ff82f9a38221', 9, NULL, 'Quell''ombra esser vorrei', 'Quell’ombra esser vorrei, SV 48', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9753dc4a-a195-4cc4-adfa-ff82f9a38221'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed38c503-fda7-342f-a08c-1118418da9d6', 10, NULL, 'S''andasse Amor a caccia', 'S''andasse Amor a caccia SV 49', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed38c503-fda7-342f-a08c-1118418da9d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41b076f8-a556-42ec-be07-9582c5b292c2', 11, NULL, 'Mentre io miravo fiso de la mia donna', 'Mentre io miravo fiso de la mia donna, SV 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b076f8-a556-42ec-be07-9582c5b292c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9e4bd6-d021-4fda-9af5-3e9c76edf889', 12, NULL, 'Ecco mormorar l''onde e tremolar le fronde', 'Ecco mormorar l''onde e tremolar le fronde, SV 51', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9e4bd6-d021-4fda-9af5-3e9c76edf889'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37daf927-97b6-4e02-8769-14607d996c25', 13, NULL, 'Dolcemente dormiva la mia Clori', 'Dolcemente dormiva la mia Clori, SV 52', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37daf927-97b6-4e02-8769-14607d996c25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7eb1f2-f35d-4880-84d0-472e63cc2da3', 14, NULL, 'Se tu mi lassi, perfida', 'Se tu mi lassi, perfida, SV 53', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7eb1f2-f35d-4880-84d0-472e63cc2da3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9f90ee-2b42-4705-aa39-368f888c3097', 15, NULL, 'La bocc''onde l''asprissime parole solean uscir', 'La bocc’onde l’asprissime parole solean uscir, SV 54', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9f90ee-2b42-4705-aa39-368f888c3097'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8d0d92-d1c6-40d4-a3fa-8123c0ee1bff', 16, NULL, 'Crudel!, perchè mi fuggi?', 'Crudel!, perchè mi fuggi?, SV 55', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8d0d92-d1c6-40d4-a3fa-8123c0ee1bff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63259859-0113-45c4-9856-03fa0fd7ff37', 17, NULL, 'Questo specchio ti dono, Rosa tu dami', 'Questo specchio ti dono, Rosa tu dami, SV 56', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63259859-0113-45c4-9856-03fa0fd7ff37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e3eb18-eed2-43f8-a83f-dda817943016', 18, NULL, 'Non m''è grave''l morire', 'Non m’è grave’l morire, SV 57', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e3eb18-eed2-43f8-a83f-dda817943016'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f5ac6a0-ddd8-421d-8b35-0a11471b796f', 19, NULL, 'Ti spontò l''ali amor, la donna mia', 'Ti spontò l’ali amor, la donna mia, SV 58', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f5ac6a0-ddd8-421d-8b35-0a11471b796f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c47d4aaa-8631-4c56-bfb8-04b4ac01b694', 20, NULL, 'Cantai un tempo, e se fu dolc''il canto', 'Cantai un tempo, e se fu dolc’il canto, SV 59', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c47d4aaa-8631-4c56-bfb8-04b4ac01b694'
);


-- SV 60–74 마드리갈 3권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 3권', 'Terzo libro de madrigali, SV 60–74', 'album', 'SV 60–74', NULL, NULL, 1592, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 3권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927319c7-cf84-468f-aa3d-9194d539d374'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '927319c7-cf84-468f-aa3d-9194d539d374'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '927319c7-cf84-468f-aa3d-9194d539d374'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8df524ef-5b89-44e3-b15e-44ac7d2eb998', 1, NULL, 'La giovinetta pianta', 'La giovinetta pianta, SV 60', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8df524ef-5b89-44e3-b15e-44ac7d2eb998'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0611a530-ad21-4f65-b0ca-1fae97132ced', 2, NULL, 'O come è gran martire', 'O come è gran martire, SV 61', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0611a530-ad21-4f65-b0ca-1fae97132ced'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2024a7de-5e73-4edb-96ad-eb298fc1dec6', 3, NULL, 'Sovra tenere erbette e bianchi fiori', 'Sovra tenere erbette e bianchi fiori, SV 62', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2024a7de-5e73-4edb-96ad-eb298fc1dec6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d104d3a-9a1b-4c64-a89a-7f46cfb368ac', 4, NULL, 'O dolce anima mia', 'O dolce anima mia, SV 63', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d104d3a-9a1b-4c64-a89a-7f46cfb368ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b40efb8a-8353-4ec6-b64e-9a24cb0db611', 5, NULL, 'Stracciami pur il core', 'Stracciami pur il core, SV 64', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b40efb8a-8353-4ec6-b64e-9a24cb0db611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7b7dc0f-ee74-4c8b-be31-cb9702c5af03', 6, NULL, 'O rossignuol ch''in queste verdi fronde', 'O rossignuol ch’in queste verdi fronde, SV 65', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7b7dc0f-ee74-4c8b-be31-cb9702c5af03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bc0b146-eaca-4c72-9881-96ad228fed7a', 7, NULL, 'Se per estremo ardore morir potesse un core', 'Se per estremo ardore morir potesse un core, SV 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc0b146-eaca-4c72-9881-96ad228fed7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2551502-517a-4f85-ab0b-48399d61a147', 8, NULL, 'Vattene pur, crudel, con quella pace', 'Vattene pur, crudel, con quella pace, SV 67', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2551502-517a-4f85-ab0b-48399d61a147'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd6ef6f0-4da7-45d1-9b31-3f4aeb018cb0', 9, NULL, 'O Primavera', 'O Primavera SV 68', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd6ef6f0-4da7-45d1-9b31-3f4aeb018cb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a16b81-c87e-466a-b060-43bfa7926a5e', 10, NULL, 'Perfidissimo volto ben lusata bellezza', 'Perfidissimo volto ben lusata bellezza, SV 69', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a16b81-c87e-466a-b060-43bfa7926a5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ce7baff-0a84-41ee-ae4d-e2f2176e2cd9', 11, NULL, 'Ch''io non t''ami, cor mio', 'Ch’io non t’ami, cor mio, SV 70', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ce7baff-0a84-41ee-ae4d-e2f2176e2cd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4fbe187-e3c7-4508-89e5-5f0917594818', 12, NULL, 'Occhi un tempo mia vita', 'Occhi un tempo mia vita, SV 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4fbe187-e3c7-4508-89e5-5f0917594818'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a42e31b-1d3d-4d54-b5ea-eef0b958c379', 13, NULL, 'Vivrò fra i miei tormenti', 'Vivrò fra i miei tormenti, SV 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a42e31b-1d3d-4d54-b5ea-eef0b958c379'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82a0ed99-b590-4c2a-8fba-e769aab64bb7', 14, NULL, 'Lumi miei, cari lumi''', 'Lumi miei, cari lumi'', SV 73', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82a0ed99-b590-4c2a-8fba-e769aab64bb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4553a8bd-eb54-4408-b27d-a70aa956ea54', 15, NULL, 'Rimanti in pace a la dolente e bella Fillida', 'Rimanti in pace a la dolente e bella Fillida, SV 74', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4553a8bd-eb54-4408-b27d-a70aa956ea54'
);


-- SV 75–93 마드리갈 4권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 4권', 'Quarto libro de madrigali, SV 75–93', 'album', 'SV 75–93', NULL, NULL, 1603, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 4권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac8c341d-d871-4d2c-9924-061613c61236'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac8c341d-d871-4d2c-9924-061613c61236'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac8c341d-d871-4d2c-9924-061613c61236'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f39ca297-bb4b-4b83-8897-cacd3ddaa0e8', 1, NULL, 'Ah dolente partita, ah fin de la mia vita', 'Ah dolente partita, ah fin de la mia vita, SV 75', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f39ca297-bb4b-4b83-8897-cacd3ddaa0e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c90499-1d4f-42cb-936e-2e8271c97933', 2, NULL, 'Cor mio, mentre vi miro', 'Cor mio, mentre vi miro SV 76', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c90499-1d4f-42cb-936e-2e8271c97933'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:000e8e0b-f1a7-4ffc-ae06-1224b972e4f4', 3, NULL, 'Cor mio, non mori?', 'Cor mio, non mori? SV 77', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:000e8e0b-f1a7-4ffc-ae06-1224b972e4f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0930cb6-8709-4c1b-9a6b-13c3f8f12ae1', 4, NULL, 'Sfogava con le stelle', 'Sfogava con le stelle, SV 78', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0930cb6-8709-4c1b-9a6b-13c3f8f12ae1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18bd1531-8b8b-4c29-8fa5-6e76f1e7d9df', 5, NULL, 'Volgea l''anima mia soavemente', 'Volgea l''anima mia soavemente SV 79', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18bd1531-8b8b-4c29-8fa5-6e76f1e7d9df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9933191-5176-4caf-a677-761da471c5e3', 6, NULL, 'Anima mia, perdona', 'Anima mia, perdona SV 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9933191-5176-4caf-a677-761da471c5e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb162c39-98e6-4d9f-871d-f39278524e37', 7, NULL, 'Luci serene e chiare', 'Luci serene e chiare SV 81', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb162c39-98e6-4d9f-871d-f39278524e37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5095658d-5734-4ff6-b387-741c317eec10', 8, NULL, 'La piaga c''ho nel core', 'La piaga c''ho nel core SV 82', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5095658d-5734-4ff6-b387-741c317eec10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b33089ed-4e26-4118-ba46-cded29d4b781', 9, NULL, 'Voi pur da me partite, anima dura', 'Voi pur da me partite, anima dura SV 83', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b33089ed-4e26-4118-ba46-cded29d4b781'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a29da30-ef76-4c6d-ac83-ffb5a8850496', 10, NULL, 'A un giro sol de'' belli occhi lucenti', 'A un giro sol de'' belli occhi lucenti, SV 84', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a29da30-ef76-4c6d-ac83-ffb5a8850496'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96685787-958b-411f-afc8-97f9fc564071', 11, NULL, 'Ohimè, se tanto amate', 'Ohimè, se tanto amate SV 85', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96685787-958b-411f-afc8-97f9fc564071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0127f8c-0154-40fe-b95b-b0c4192714c8', 12, NULL, 'Io mi son giovinetta', 'Io mi son giovinetta, SV 86', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0127f8c-0154-40fe-b95b-b0c4192714c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cfdc219-589b-3d50-bfa5-e119146c800e', 13, NULL, 'Quel augellin che canta si dolcemente', 'Quel augellin che canta si dolcemente, SV 87', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfdc219-589b-3d50-bfa5-e119146c800e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ec6a16-44a5-4286-a280-3af501db8034', 14, NULL, 'Non più guerra, pietate', 'Non più guerra, pietate SV 88', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ec6a16-44a5-4286-a280-3af501db8034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ab23330-31af-4942-88ee-1049593b3912', 15, NULL, 'Sì, ch'' io vorrei morire', 'Sì, ch'' io vorrei morire, SV 89', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab23330-31af-4942-88ee-1049593b3912'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e64155e1-a121-49b4-87d1-87a53efd26e0', 16, NULL, 'Anima dolorosa', 'Anima dolorosa, SV 90', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e64155e1-a121-49b4-87d1-87a53efd26e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b7eb98c-162a-4588-8679-8717fd0ca600', 17, NULL, 'Anima del cor mio poi che da me misera me', 'Anima del cor mio poi che da me misera me, SV 91', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b7eb98c-162a-4588-8679-8717fd0ca600'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf3f5f5-c4f9-448c-b587-a6f824eec8ca', 18, NULL, 'Longe da te, cor mio', 'Longe da te, cor mio SV 92', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf3f5f5-c4f9-448c-b587-a6f824eec8ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e664e8fb-76d6-419d-8c0c-e4e9579573bb', 19, NULL, 'Piagn''e sospira', 'Piagn''e sospira SV 93', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 4권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e664e8fb-76d6-419d-8c0c-e4e9579573bb'
);


-- SV 94–106 마드리갈 5권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 5권', 'Quinto libro de madrigali, SV 94–106', 'album', 'SV 94–106', NULL, NULL, 1605, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 5권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '547f8bb7-1d38-42c6-aa83-52c3b3489acc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '547f8bb7-1d38-42c6-aa83-52c3b3489acc'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '547f8bb7-1d38-42c6-aa83-52c3b3489acc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50892264-abef-445d-b0d4-47c5d5083ac9', 1, NULL, 'Cruda Amarilli', 'Cruda Amarilli, SV 94', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50892264-abef-445d-b0d4-47c5d5083ac9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abfdeb03-ba55-4bb8-ac3e-fe87aa77f3d1', 2, NULL, 'O Mirtillo, Mirtill''anima mia', 'O Mirtillo, Mirtill’anima mia, SV 95', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abfdeb03-ba55-4bb8-ac3e-fe87aa77f3d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b64970ac-3185-4afa-a8e5-1d7c0d5970d5', 3, NULL, 'Era l''anima mia già presso a l''ultim'' hore', 'Era l’anima mia già presso a l’ultim’ hore, SV 96', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b64970ac-3185-4afa-a8e5-1d7c0d5970d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27062146-9fc0-44c6-9bec-e1970d149508', 4, NULL, 'Ecco Silvio', 'Ecco Silvio, SV 97', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27062146-9fc0-44c6-9bec-e1970d149508'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93b5a5c1-4a0c-41d0-9484-90f0db413ad1', 5, NULL, 'Ch''io t''ami', 'Ch’io t’ami, SV 98', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93b5a5c1-4a0c-41d0-9484-90f0db413ad1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdafc48a-80ef-4b08-9e27-7cc4e8bf5e90', 6, NULL, 'Che dar più vi poss''io?', 'Che dar più vi poss''io?, SV 99', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdafc48a-80ef-4b08-9e27-7cc4e8bf5e90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bbc3dba-e848-4a1f-819c-f112973bda49', 7, NULL, 'M''è più dolce il penar per Amarilli', 'M''è più dolce il penar per Amarilli, SV 100', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bbc3dba-e848-4a1f-819c-f112973bda49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8940caa-038c-4da4-b9bc-1bba41d17243', 8, NULL, 'Ahi come a un vago sol cortese giro', 'Ahi come a un vago sol cortese giro, SV 101', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8940caa-038c-4da4-b9bc-1bba41d17243'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:702156b6-b380-4122-b478-cb3583575e24', 9, NULL, 'Troppo ben può questo tiranno Amore', 'Troppo ben può questo tiranno Amore, SV 102', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:702156b6-b380-4122-b478-cb3583575e24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eb7b00a-ad11-42f9-9165-2299f5895c73', 10, NULL, 'Amor, se giusto sei', 'Amor, se giusto sei, SV 103', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eb7b00a-ad11-42f9-9165-2299f5895c73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d782816-bbbb-4bd1-ae0b-1de5b391c15e', 11, NULL, 'T''amo mia vita, la mia cara vita', 'T’amo mia vita, la mia cara vita, SV 104', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d782816-bbbb-4bd1-ae0b-1de5b391c15e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30ab552a-7b6e-4839-a40d-64d19c55b3e4', 12, NULL, 'E così a poco a poco torno farfalla', 'E così a poco a poco torno farfalla, SV 105', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30ab552a-7b6e-4839-a40d-64d19c55b3e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69e110fe-5b6a-46f7-b370-5822a2667547', 13, NULL, 'Questi vaghi concenti', 'Questi vaghi concenti, SV 106', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 5권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e110fe-5b6a-46f7-b370-5822a2667547'
);


-- SV 107–116 마드리갈 6권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 6권', 'Sesto libro de madrigali, SV 107–116', 'album', 'SV 107–116', NULL, NULL, 1614, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 6권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91e3534a-a2af-471e-a7e7-dc58ecdc5e21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91e3534a-a2af-471e-a7e7-dc58ecdc5e21'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91e3534a-a2af-471e-a7e7-dc58ecdc5e21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85926888-c6a4-32ef-99ee-6d1bc9a9d8e0', 1, NULL, 'Lamento d''Arianna (5성부)', 'Lamento d''Arianna "Lasciatemi morire", SV 107', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85926888-c6a4-32ef-99ee-6d1bc9a9d8e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9840c38-0842-340b-bce5-28c5585b150e', 2, NULL, 'Zefiro torna e''l bel tempo rimena', 'Zefiro torna e''l bel tempo rimena, SV 108', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9840c38-0842-340b-bce5-28c5585b150e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5118d6b1-5414-33e7-9cb0-0a5a4054fb5c', 3, NULL, 'Una donna fra l''altre', 'Una donna fra l''altre, SV 109', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5118d6b1-5414-33e7-9cb0-0a5a4054fb5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-91e3534a:4', 4, NULL, 'A dio Florida bella il cor piagato', 'A dio Florida bella il cor piagato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-91e3534a:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8fa3849-58ba-422b-be05-ac158eee76fb', 5, NULL, 'Sestina: Lagrime d''amante al sepolcro dell''amata', 'Sestina, SV 111', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8fa3849-58ba-422b-be05-ac158eee76fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f707070d-a282-338d-b9cd-e1fc348b36f3', 6, NULL, 'Ohimè il bel viso', 'Ohimè il bel viso, SV 112', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f707070d-a282-338d-b9cd-e1fc348b36f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-91e3534a:7', 7, NULL, 'Qui rise o Tirsi e qui ver me rivolse', 'Qui rise o Tirsi e qui ver me rivolse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-91e3534a:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-91e3534a:8', 8, NULL, 'Misero Alceo, dal caro albergo fore', 'Misero Alceo, dal caro albergo fore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-91e3534a:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a8f091-0838-38eb-ab23-17f08f19774b', 9, NULL, 'Batto, qui pianse Ergasto', 'Batto, qui pianse Ergasto, SV 115', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a8f091-0838-38eb-ab23-17f08f19774b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-91e3534a:10', 10, NULL, 'Presso un fiume tranquillo', 'Presso un fiume tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 6권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-91e3534a:10'
);


-- SV 117–145 마드리갈 7권 <콘체르토>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 7권 <콘체르토>', 'Settimo Libro de Madrigali, SV 117–145', 'album', 'SV 117–145', NULL, NULL, 1619, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 7권 <콘체르토>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02bd33ef-e21e-4700-aca4-16c27523212a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02bd33ef-e21e-4700-aca4-16c27523212a'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02bd33ef-e21e-4700-aca4-16c27523212a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6d69ea-24d0-4b78-a4d9-0135244ca59f', 1, NULL, 'Tempro la cetra', 'Settimo libro de madrigali: Tempro la cetra, SV 117', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6d69ea-24d0-4b78-a4d9-0135244ca59f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cab51568-23d5-41bd-b4e3-52393af1a3a2', 2, NULL, 'Non è di gentil core chi non arde d''amore', 'Non è di gentil core chi non arde d’amore, SV 118', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cab51568-23d5-41bd-b4e3-52393af1a3a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37dd7d51-734b-48d9-9b03-ddc19b9a3254', 3, NULL, 'A quest''olmo, a quest''ombre ed a quest''onde', 'A quest olmo, a quest ombre et a quest onde, SV. 119', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37dd7d51-734b-48d9-9b03-ddc19b9a3254'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8583af4d-16e8-3acc-812b-d8bfef56b3c9', 4, NULL, 'O come sei gentile', 'Concerto, settimo libro de madrigali, con altri generi di canti: O come sei gentile, SV 120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8583af4d-16e8-3acc-812b-d8bfef56b3c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943c3780-1f85-45ad-bd3c-42ea851c6511', 5, NULL, 'Io son pur vezzosetta pastorella', 'Io son pur vezzosetta pastorella, SV 121', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943c3780-1f85-45ad-bd3c-42ea851c6511'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:743e47dd-8319-46a8-a612-83fe6ac95136', 6, NULL, 'O viva fiamma, o miei sospiri ardenti', 'O viva fiamma, o miei sospiri ardenti, SV 122', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:743e47dd-8319-46a8-a612-83fe6ac95136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8293a859-0a79-4f59-ae4d-c9e23ac31093', 7, NULL, 'Vorrei baciarti, o Filli', 'Settimo libro de madrigali: Vorrei baciarti, o Filli, SV 123', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8293a859-0a79-4f59-ae4d-c9e23ac31093'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:217ac54d-3a0a-4479-867e-34ecbf93fa5b', 8, NULL, 'Dice la mia bellissima Licori', 'Dice la mia bellissima Licori, SV 124', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:217ac54d-3a0a-4479-867e-34ecbf93fa5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8032dea-5735-405b-ae86-50b15a2aae0d', 9, NULL, 'Ah, che non si conviene', 'Ah, che non si conviene, SV 125', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8032dea-5735-405b-ae86-50b15a2aae0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-02bd33ef:10', 10, NULL, 'Non vedrò mai le stelle', 'Non vedrò mai le stelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-02bd33ef:10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418929ba-6f8b-4980-8ceb-0be79286f90c', 11, NULL, 'Ecco vicine, o bella tigre', 'Ecco vicine, o bella tigre, SV 127', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418929ba-6f8b-4980-8ceb-0be79286f90c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1adad291-3010-47ef-909d-b1820e1fc184', 12, NULL, 'Perché fuggi tra salci', 'Settimo libro de'' madrigali: "Perché fuggi tra salci", SV 128', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1adad291-3010-47ef-909d-b1820e1fc184'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcad66e5-7d36-45ae-9d8c-be2546dbb982', 13, NULL, 'Tornate, o cari baci', '“Tornate, o cari baci”, SV 129', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcad66e5-7d36-45ae-9d8c-be2546dbb982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce17200-7628-4691-a375-f50b2ff87454', 14, NULL, 'Soave libertate già per si lunga etate', 'Soave libertate già per si lunga etate, SV 130', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce17200-7628-4691-a375-f50b2ff87454'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3689bf76-199f-4752-bd2e-67d51338d248', 15, NULL, 'S''el vostro cor, madonna', 'Settimo libro de madrigali: S''el vostro cor, madonna, SV 131', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3689bf76-199f-4752-bd2e-67d51338d248'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbdc5aed-b950-4715-9378-67dfcbde5441', 16, NULL, 'Interrotte speranze', 'Interrotte speranze, SV 132', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbdc5aed-b950-4715-9378-67dfcbde5441'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc8769bc-75d4-40c2-8518-a03366db6121', 17, NULL, 'Augellin che la voce al canto spieghi', 'Augellin che la voce al canto spieghi, SV 133', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc8769bc-75d4-40c2-8518-a03366db6121'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad809e7-a6bd-4e4d-b234-b19b069e5fdb', 18, NULL, 'Vaga su spina ascosa', 'Madrigals, Book 7: Vaga su spina ascosa, SV 134', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad809e7-a6bd-4e4d-b234-b19b069e5fdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b09ba5fa-5c88-47a8-bfd9-c278573d327d', 19, NULL, 'Eccomi pronta ai baci', 'Eccomi pronta ai baci, SV 135', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09ba5fa-5c88-47a8-bfd9-c278573d327d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6a0f56-a6b7-4474-95b7-1f12b65dfc7a', 20, NULL, 'Parlo, miser''o taccio?', 'Settimo libro de madrigali: Parlo, miser''o taccio?, SV 136', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6a0f56-a6b7-4474-95b7-1f12b65dfc7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:878241c9-91ba-44d3-bccc-c90b251a80d3', 21, NULL, 'Tu dormi, ah crudo core', 'Tu dormi, ah crudo core, SV 137', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:878241c9-91ba-44d3-bccc-c90b251a80d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0f069a2-3732-4b47-803a-52000576fc1d', 22, NULL, 'Al lume de le stelle', 'Al lume de le stelle, SV 138', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0f069a2-3732-4b47-803a-52000576fc1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21a36cdf-6824-438f-a7b0-2b548018231c', 23, NULL, 'Con che soavità, labbra odorate', 'Settimo libro de madrigali: Con che soavità, labbra odorate, SV 139', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a36cdf-6824-438f-a7b0-2b548018231c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24084f73-cfda-4f84-9ffa-88ce1fc80f34', 24, NULL, 'Ohimè, dov''è il mio ben', 'Ohimè dovè il mio ben, dov’è il mio core, SV 140', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24084f73-cfda-4f84-9ffa-88ce1fc80f34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5938e9ff-8743-49ce-a5fc-afb97ca8f0a4', 25, NULL, 'Se i languidi miei sguardi', 'Se i languidi miei sguardi, SV 141', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5938e9ff-8743-49ce-a5fc-afb97ca8f0a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a23fa041-a2f5-4673-9018-c825663409a4', 26, NULL, 'Se pur destina e vole', 'Se pur destina e vole, SV 142', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a23fa041-a2f5-4673-9018-c825663409a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b52325eb-7e5b-41ee-8fbe-d6e7ffb25ddc', 27, NULL, 'Chiome d''oro, bel tesoro', 'Chiome d’oro, bel tesoro, SV 143', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b52325eb-7e5b-41ee-8fbe-d6e7ffb25ddc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f418e5-8d7f-4ab7-b8d7-9ade8b83a20f', 28, NULL, 'Amor, che deggio far', 'Amor, che deggio far, SV 144', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f418e5-8d7f-4ab7-b8d7-9ade8b83a20f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45684d45-78f3-4581-8674-73ce11cf2480', 29, NULL, 'Tirsi e Clori', 'Tirsi e Clori, SV 145', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 7권 <콘체르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45684d45-78f3-4581-8674-73ce11cf2480'
);


-- SV 146–167 마드리갈 8권 <전쟁과 사랑의 마드리갈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 8권 <전쟁과 사랑의 마드리갈>', 'Ottavo Libro de’ Madrigali, SV 146–167', 'album', 'SV 146–167', NULL, NULL, 1638, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e05147a-3511-4bb3-a794-2242a0512c6a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e05147a-3511-4bb3-a794-2242a0512c6a'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e05147a-3511-4bb3-a794-2242a0512c6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f890fbf-099d-4fd1-84d1-6bd73d818ef8', 1, NULL, 'Altri canti d''Amor, tenero arciero', 'Altri canti d’Amor, tenero arciero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f890fbf-099d-4fd1-84d1-6bd73d818ef8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c78339d-44eb-4664-8969-06c256bcbdfc', 2, NULL, 'Hor che''l ciel e la terra e''l vento tace', 'Hor che’l ciel e la terra e’l vento tace SV 147', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c78339d-44eb-4664-8969-06c256bcbdfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b61c05e9-3ee5-4821-a2fb-0606c70ebe45', 1, 'I', 'E’l vento tace', 'Hor che’l ciel e la terra: I. E’l vento tace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c78339d-44eb-4664-8969-06c256bcbdfc'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61c05e9-3ee5-4821-a2fb-0606c70ebe45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:348fd63d-0d98-4e3e-9486-bdf2c471302e', 2, 'II', 'Cosi sol d’una chiara fonte viva', 'Hor che’l ciel e la terra: II. Cosi sol d’una chiara fonte viva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5c78339d-44eb-4664-8969-06c256bcbdfc'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:348fd63d-0d98-4e3e-9486-bdf2c471302e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6632b7e1-84da-47ed-b55b-396a029f1fd4', 3, NULL, 'Gira il nemico insidioso Amore', 'Gira il nemico insidioso Amore, SV 148', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6632b7e1-84da-47ed-b55b-396a029f1fd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497fb4dc-7599-49dc-af48-e49510768958', 4, NULL, 'Se vittorie sì belle', 'Se vittorie sì belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497fb4dc-7599-49dc-af48-e49510768958'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d47c3c61-0eb1-45b1-890c-c0a8cac61c3c', 5, NULL, 'Armato il cor d''adamantina fede', 'Armato il cor d’adamantina fede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47c3c61-0eb1-45b1-890c-c0a8cac61c3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19', 6, NULL, 'Ogni amante è guerrier', 'Ogni amante è guerrier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d5cc4bd-6e8d-477b-b763-22d608cb42ab', 1, 'I', 'Nel suo gran regno', 'Ogni amante e guerrier: I. Nel suo gran regno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d5cc4bd-6e8d-477b-b763-22d608cb42ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf4c011a-e0c7-4b7d-acb8-b373dc3a7b22', 2, 'II', 'Lo che cell’otio nacqui e d’otio vissi', 'Ogni amante e guerrier: II. Lo che cell’otio nacqui e d’otio vissi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf4c011a-e0c7-4b7d-acb8-b373dc3a7b22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e3bcf9e-9f49-4610-b964-ee2c7f182205', 3, 'III', 'Ma per quell’ampio Egeo spieghi le vele', 'Ogni amante e guerrier: III. Ma per quell’ampio Egeo spieghi le vele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e3bcf9e-9f49-4610-b964-ee2c7f182205'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7098af4b-863e-403e-9437-1529df62bafd', 4, 'IV', 'Riedi, ch’al nostro ardor, al nostro canto', 'Ogni amante e guerrier: IV. Riedi, ch’al nostro ardor, al nostro canto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e9ce319-b4fa-4018-b939-c3ffd8b34d19'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7098af4b-863e-403e-9437-1529df62bafd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5714492d-4c35-4bbd-ab09-3e373dd98099', 7, NULL, 'Ardo, avvampo, mi struggo, ardo: accorrete', 'Ardo, avvampo, mi struggo, ardo: accorrete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5714492d-4c35-4bbd-ab09-3e373dd98099'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6', 8, NULL, 'Il combattimento di Tancredi e Clorinda', 'Il combattimento di Tancredi e Clorinda, SV 153', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:501388bc-fd03-417f-9f7a-88c767faa34b', 1, 'I', 'Tancredi che Clorinda', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Tancredi che Clorinda"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501388bc-fd03-417f-9f7a-88c767faa34b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ecd4e764-019d-4152-a1c4-965877f342a2', 2, 'II', 'Sinfonia', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Sinfonia"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecd4e764-019d-4152-a1c4-965877f342a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1661b39e-65e0-40b9-9dfb-caf87412d87d', 3, 'III', 'Notte, che nel profondo oscuro seno', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Notte, che nel profondo oscuro seno"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1661b39e-65e0-40b9-9dfb-caf87412d87d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25d97ec2-ba31-4a82-81ea-2ff6026334f0', 4, 'IV', 'Non schivar, non parar', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Non schivar, non parar"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25d97ec2-ba31-4a82-81ea-2ff6026334f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dbdd637e-0148-4cca-a0e2-3225882618c0', 5, 'V', 'E stanco e anelante', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "E stanco e anelante"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbdd637e-0148-4cca-a0e2-3225882618c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff7a140a-d01c-49e1-a7dc-f0a56a9ff0e2', 6, 'VI', 'Così tacendo e rimirando', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Così tacendo e rimirando"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7a140a-d01c-49e1-a7dc-f0a56a9ff0e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e754fcb5-43f8-47a5-ad97-759324345512', 7, 'VII', 'Torna l’ira ne’ cori e li trasporta', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Torna l’ira ne’ cori e li trasporta"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e754fcb5-43f8-47a5-ad97-759324345512'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24b06e44-bbf0-4b9a-a2ec-c846a61f2c39', 8, 'VIII', 'Ma ecco omai l’ora fatal', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Ma ecco omai l’ora fatal"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24b06e44-bbf0-4b9a-a2ec-c846a61f2c39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf0db5ff-59bd-4f21-9bbc-8539ce8adc45', 9, 'IX', 'Amico, hai vinto', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "Amico, hai vinto"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf0db5ff-59bd-4f21-9bbc-8539ce8adc45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee694cfd-4648-4ff9-ace5-e98bc3d354db', 10, 'X', 'In queste voci', 'VIII. Madrigalbuch, Il combattimento di Tancredi e Clorinda, SV 153: "In queste voci"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f66471e-05a5-4185-ba7b-f6a157bffbb6'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee694cfd-4648-4ff9-ace5-e98bc3d354db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2e483f9-9bd6-434a-9c66-36ee20ab81e3', 9, NULL, 'Volgendo il ciel per l''immortal sentiero', 'Volgendo il ciel per l''immortal sentiero SV 154', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2e483f9-9bd6-434a-9c66-36ee20ab81e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:318b795f-a20c-416b-837e-e860476b6546', 10, NULL, 'Altri canti di Marte', 'Altri canti di Marte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318b795f-a20c-416b-837e-e860476b6546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c04899b-883f-4ba7-bd84-116b630960a3', 1, 'I', 'E di sua schiera', 'Altri canti di marte: I. E di sua schiera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:318b795f-a20c-416b-837e-e860476b6546'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c04899b-883f-4ba7-bd84-116b630960a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc7ccca2-7ef6-4962-91d9-95e880f6637e', 2, 'II', 'Due belli occhi fur l’armi onde traffitta', 'Altri canti di marte: II. Due belli occhi fur l’armi onde traffitta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:318b795f-a20c-416b-837e-e860476b6546'
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc7ccca2-7ef6-4962-91d9-95e880f6637e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c392a951-3e79-44f8-9c4e-8aa93a48bbb7', 11, NULL, 'Vago augelletto che cantando vai', 'Vago augelletto che cantando vai, SV 156', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c392a951-3e79-44f8-9c4e-8aa93a48bbb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eab5133-7047-4148-9422-8a69e57d2ca0', 12, NULL, 'Mentre vaga angioletta', 'Mentre vaga angioletta, SV 157', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eab5133-7047-4148-9422-8a69e57d2ca0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c74fafad-96eb-4662-bd56-e8ffb57d859d', 13, NULL, 'Ardo e scoprir, ahi lasso, io non ardisco', 'Ardo e scoprir, ahi lasso, io non ardisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c74fafad-96eb-4662-bd56-e8ffb57d859d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb6ac4c9-ca45-4f2a-91c0-d8a3168a7dda', 14, NULL, 'O sia tranquillo il mare o pien d''orgoglio', 'O sia tranquillo il mare o pien d’orgoglio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6ac4c9-ca45-4f2a-91c0-d8a3168a7dda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df37abdc-7741-46f5-9f33-b159a36a2a1b', 15, NULL, 'Ninfa che, scalza il piede e sciolto il crine', 'Ninfa che, scalza il piede e sciolto il crine, SV 160', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df37abdc-7741-46f5-9f33-b159a36a2a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf59a7d1-1dfa-4692-bec3-8b10c46355f5', 16, NULL, 'Dolcissimo uscignolo', 'Dolcissimo uscignolo, SV 161', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf59a7d1-1dfa-4692-bec3-8b10c46355f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d9ed72-3952-4132-af78-704650d8624a', 17, NULL, 'Chi vol haver felice e lieto il core', 'Chi vol haver felice e lieto il core, SV 162', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d9ed72-3952-4132-af78-704650d8624a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19 AND linked.composer_id = 5), 'musicbrainz:bc9eb6a9-b9cd-3b23-9332-17753cb1ed70', 18, NULL, 'Lamento della ninfa', 'Lamento della ninfa, SV 163', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc9eb6a9-b9cd-3b23-9332-17753cb1ed70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce99bdaf-1c27-44a0-931c-43b991857f47', 19, NULL, 'Perchè t''en fuggi, o Fillide?', 'Perchè t’en fuggi, o Fillide?, SV 164', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce99bdaf-1c27-44a0-931c-43b991857f47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:707dd6ea-3d0e-404c-a646-c195689a0d63', 20, NULL, 'Non partir, ritrosetta', 'Non partir, ritrosetta, SV 165', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:707dd6ea-3d0e-404c-a646-c195689a0d63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:254d561f-f1b0-46b4-be93-1210d8e7248f', 21, NULL, 'Sù, sù, sù pastorelli vezzosi', 'Sù, sù, sù pastorelli vezzosi, SV 166', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:254d561f-f1b0-46b4-be93-1210d8e7248f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0b27525-67cd-4dc3-9448-dad6466c2e33', 22, NULL, 'Il ballo delle ingrate', 'Il ballo delle ingrate in genere representativo, SV 167', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0b27525-67cd-4dc3-9448-dad6466c2e33'
);


-- SV 168–178 마드리갈 9권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마드리갈 9권', 'Il nono libro de madrigali, SV 168–178', 'album', 'SV 168–178', NULL, NULL, 1651, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마드리갈 9권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae036080-ec3c-4ffb-8236-95b841f1e0c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae036080-ec3c-4ffb-8236-95b841f1e0c3'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae036080-ec3c-4ffb-8236-95b841f1e0c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497fb4dc-7599-49dc-af48-e49510768958', 1, NULL, 'Se vittorie sì belle', 'Se vittorie sì belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497fb4dc-7599-49dc-af48-e49510768958'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d47c3c61-0eb1-45b1-890c-c0a8cac61c3c', 2, NULL, 'Armato il cor d''adamantina fede', 'Armato il cor d’adamantina fede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47c3c61-0eb1-45b1-890c-c0a8cac61c3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c74fafad-96eb-4662-bd56-e8ffb57d859d', 3, NULL, 'Ardo e scoprir, ahi lasso, io non ardisco', 'Ardo e scoprir, ahi lasso, io non ardisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c74fafad-96eb-4662-bd56-e8ffb57d859d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb6ac4c9-ca45-4f2a-91c0-d8a3168a7dda', 4, NULL, 'O sia tranquillo il mare o pien d''orgoglio', 'O sia tranquillo il mare o pien d’orgoglio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6ac4c9-ca45-4f2a-91c0-d8a3168a7dda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc133f33-bc64-45f9-88d9-1883fd0e95bc', 5, NULL, 'Bel pastor dal cui bel guardo', 'Bel pastor dal cui bel guardo, SV 168', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc133f33-bc64-45f9-88d9-1883fd0e95bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a01a1a35-0728-4f3b-96b2-9b8cf1195083', 6, NULL, 'Alcun non mi consigli', 'Alcun non mi consigli, SV 169', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a01a1a35-0728-4f3b-96b2-9b8cf1195083'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c9a2c4-e2a7-4cf6-9995-f0d91fb8ad9e', 7, NULL, 'Di far sempre gioire', 'Di far sempre gioire, SV 170', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c9a2c4-e2a7-4cf6-9995-f0d91fb8ad9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a257edc1-72ee-429f-8094-8d5abd521a7b', 8, NULL, 'Quando dentro al tuo seno', 'Quando dentro al tuo seno, SV 171', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a257edc1-72ee-429f-8094-8d5abd521a7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c586cfed-1434-4f35-ac3c-732cb72bb4a7', 9, NULL, 'Non voglio amare', 'Non voglio amare, SV 172', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c586cfed-1434-4f35-ac3c-732cb72bb4a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:020a9ea5-871d-487d-b892-de4b91e9b70e', 10, NULL, 'Come dolce hoggi l''auretta', 'Come dolce hoggi l''auretta, SV 173', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:020a9ea5-871d-487d-b892-de4b91e9b70e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a37c459-3dca-4444-9f94-d79e9b9c325b', 11, NULL, 'Alle danze, alle gioie, ai diletti', 'Alle danze, alle gioie, ai diletti, SV 174', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a37c459-3dca-4444-9f94-d79e9b9c325b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbe4dcf7-918e-449f-9b84-209341286a4e', 12, NULL, 'Perché se m''odiavi', 'Perche se m''odiaui, SV 175', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbe4dcf7-918e-449f-9b84-209341286a4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccce2aeb-31f0-4a2f-8cb0-48bbaa2e5528', 13, NULL, 'Sì ch''io vamo, occhi vaghi, occhi belli', 'Sì ch’io vamo, occhi vaghi, occhi belli, SV 176', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccce2aeb-31f0-4a2f-8cb0-48bbaa2e5528'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dabbeb9-326f-4065-bb99-bb8dbfa3e331', 14, NULL, 'Sù, sù, sù augelletti canori', 'Sù, sù, sù augelletti canori, SV 177', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dabbeb9-326f-4065-bb99-bb8dbfa3e331'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88976a68-42e0-44bb-9cbe-678a7d543299', 15, NULL, 'O mio bene, o mia vita', 'O mio bene, o mia vita, SV 178', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88976a68-42e0-44bb-9cbe-678a7d543299'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e52db41-48c0-36f0-b87b-102b1cfdb30f', 16, NULL, 'Zefiro torna', 'Madrigals, Book 9: "Zefiro torna", SV 251', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '마드리갈 9권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e52db41-48c0-36f0-b87b-102b1cfdb30f'
);


-- SV 230–245 스케르치 무지칼리 (1607)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르치 무지칼리 (1607)', 'Scherzi Musicali (1607) SV 230-245', 'album', 'SV 230–245', NULL, NULL, 1607, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르치 무지칼리 (1607)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeb09725-38a8-4454-bec3-737d84e8ce6e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aeb09725-38a8-4454-bec3-737d84e8ce6e'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeb09725-38a8-4454-bec3-737d84e8ce6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d067333-daea-4efe-9283-f99198aba51a', 1, NULL, 'I bei legami che stami intorno', 'I bei legami che stami intorno, SV 230', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d067333-daea-4efe-9283-f99198aba51a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f3023b-67e5-43ba-b353-14775f8ca31a', 2, NULL, 'Amarilli onde m''assale', 'Amarilli onde m''assale, SV 231', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f3023b-67e5-43ba-b353-14775f8ca31a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04570c84-732d-4df5-a240-a2650e348505', 3, NULL, 'Fugge il verno dei dolori', 'Fugge il verno dei dolori SV 232', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04570c84-732d-4df5-a240-a2650e348505'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4c4f4ae-15e1-4ad3-9c40-1bb6612f9700', 4, NULL, 'Quando l''alba in oriente', 'Quando l’alba in oriente, SV 233', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c4f4ae-15e1-4ad3-9c40-1bb6612f9700'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2759c955-fa42-4000-8d58-25ff91f44dfd', 5, NULL, 'Non così tosto io miro', 'Non così tosto io miro, SV 234', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2759c955-fa42-4000-8d58-25ff91f44dfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dfdf5a6-d5be-4c94-b1a8-8ba484f3cbdb', 6, NULL, 'Damigella tutta bella', 'Damigella tutta bella, SV 235', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dfdf5a6-d5be-4c94-b1a8-8ba484f3cbdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-aeb09725:7', 7, NULL, 'La pastorella mia spietata e rigida', 'La pastorella mia spietata e rigida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-aeb09725:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72926898-18e2-4b37-acb2-6b27d2325cf7', 8, NULL, 'O rosetta, che rosetta', 'O rosetta, che rosetta, SV 237', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72926898-18e2-4b37-acb2-6b27d2325cf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1436a7d3-94bd-423d-96c0-542e1677a38c', 9, NULL, 'Amorosa pupilletta che saetta', 'Amorosa pupilletta che saetta, SV 238', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1436a7d3-94bd-423d-96c0-542e1677a38c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ea8d9b-36e4-4322-975e-2b040060bf24', 10, NULL, 'Vaghi rai di cigli ardenti', 'Vaghi rai di cigli ardenti, SV 239', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ea8d9b-36e4-4322-975e-2b040060bf24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32f2b6ae-cf3e-4749-897d-f2282dd64538', 11, NULL, 'La violetta ch''en su l''herbetta', 'La violetta ch''en su l''herbetta, SV 240', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f2b6ae-cf3e-4749-897d-f2282dd64538'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-aeb09725:12', 12, NULL, 'Giovinetta ritrosetta', 'Giovinetta ritrosetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-aeb09725:12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e95b27-935e-4030-9e35-ee6ff2c650cf', 13, NULL, 'Dolci miei sospiri', 'Dolci miei sospiri, SV 242', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e95b27-935e-4030-9e35-ee6ff2c650cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:949610cb-20bb-4f39-9717-d0e368f767dd', 14, NULL, 'Clori amorosa d''amor rubella', 'Clori amorosa d’amor rubella, SV 243', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:949610cb-20bb-4f39-9717-d0e368f767dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f76fb11f-74ab-4e1d-8c9d-e4d61936b047', 15, NULL, 'Lidia spina del mio core', 'Lidia spina del mio core, SV 244', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f76fb11f-74ab-4e1d-8c9d-e4d61936b047'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-aeb09725:16', 16, NULL, 'Balletto: De la bellezza le dovute lodi', 'Balletto: De la bellezza le dovute lodi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1607)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-aeb09725:16'
);


-- SV 246–251 스케르치 무지칼리 (1632)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르치 무지칼리 (1632)', 'Scherzi Musicali (1632) SV 246-251', 'album', 'SV 246–251', NULL, NULL, 1632, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르치 무지칼리 (1632)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eda19c2a-4a66-410f-8f8c-4c320083b5eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eda19c2a-4a66-410f-8f8c-4c320083b5eb'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eda19c2a-4a66-410f-8f8c-4c320083b5eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f931b7aa-c480-4d74-a1d7-05ab267d47d7', 1, NULL, 'Maledetto sia l''aspetto', 'Maledetto sia l''aspetto, SV 246', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f931b7aa-c480-4d74-a1d7-05ab267d47d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:194e1695-6da3-429e-96e7-aa89d38d1312', 2, NULL, 'Quel sguardo sdegnosetto', 'Quel sguardo sdegnosetto, SV 247', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:194e1695-6da3-429e-96e7-aa89d38d1312'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4837a35-b5ba-4847-a029-5564aed1d81c', 3, NULL, 'Eri già tutta mia', 'Scherzi musicali: Eri già tutta mia, SV 248', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4837a35-b5ba-4847-a029-5564aed1d81c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2a4b04-0c5f-4fc4-b6fa-42ae7b4d834b', 4, NULL, 'Ecco di dolci raggi', 'Scherzi Musicali (1632): Ecco di dolci raggi, SV 249', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2a4b04-0c5f-4fc4-b6fa-42ae7b4d834b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:876a977a-ab24-4d21-970c-de15c13c34a8', 5, NULL, 'Io ch''armato sin hor', 'Io ch’armato sin hor, SV 249a:6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:876a977a-ab24-4d21-970c-de15c13c34a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cbe5d00-5efe-411c-be3b-9ecb6f80c8c0', 6, NULL, 'Et pur dunque vero', 'Scherzi musicali: Et pur dunque vero, SV 250', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cbe5d00-5efe-411c-be3b-9ecb6f80c8c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad5352e-448f-457d-8616-66df0417b341', 7, NULL, 'Zefiro torna e di soavi accenti', 'Scherzi Musicali (1632): Zefire torna e di soavi accenti (Ciaccona), SV 251', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '스케르치 무지칼리 (1632)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad5352e-448f-457d-8616-66df0417b341'
);


-- SV 207–229 모테트집 <Sacrae cantiunculae>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트집 <Sacrae cantiunculae>', 'Sacrae cantiunculae, SV 207–229', 'album', 'SV 207–229', NULL, NULL, 1582, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트집 <Sacrae cantiunculae>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354b1565-0218-46d5-bae9-bd9c3f1f5048', 1, NULL, 'Lapidabant Stephanum', 'Lapidabant Stephanum, SV 207', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354b1565-0218-46d5-bae9-bd9c3f1f5048'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:2', 2, NULL, 'Veni sponsa Christi', 'Veni sponsa Christi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a6eadb-1ee6-4da4-be1f-5a051a310490', 3, NULL, 'Ego sum pastor bonus', 'Ego sum pastor bonus SV 209', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a6eadb-1ee6-4da4-be1f-5a051a310490'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4ad08fb-c82a-432c-8599-df6f4ded4846', 4, NULL, 'Surge propera amica mea', 'Surge propera amica mea, SV 210', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4ad08fb-c82a-432c-8599-df6f4ded4846'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:5', 5, NULL, 'Ubi duo vel tres congregati fuerint', 'Ubi duo vel tres congregati fuerint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:6', 6, NULL, 'Quam pulchra es et quam decora amica mea', 'Quam pulchra es et quam decora amica mea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a055f3d-20c8-41f1-beba-19bfc731b533', 7, NULL, 'Ave Maria', 'Ave Maria, SV 213', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a055f3d-20c8-41f1-beba-19bfc731b533'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:8', 8, NULL, 'Domine pater et deus', 'Domine pater et deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:9', 9, NULL, 'Tu es pastor ovium', 'Tu es pastor ovium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:10', 10, NULL, 'O magnum pietatis', 'O magnum pietatis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:11', 11, NULL, 'O crux benedicta', 'O crux benedicta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e2a07d-d188-4ae8-a0b9-4dc105037868', 12, NULL, 'Hodie Christus natus est', 'Hodie Christus natus est, SV 218', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e2a07d-d188-4ae8-a0b9-4dc105037868'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:13', 13, NULL, 'O domine Jesu Christe adoro te', 'O domine Jesu Christe adoro te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:14', 14, NULL, 'Pater venit hora clarifica filium tuum', 'Pater venit hora clarifica filium tuum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:15', 15, NULL, 'In tua patientia possedisti animam tuam', 'In tua patientia possedisti animam tuam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:16', 16, NULL, 'Angelus ad pastores ait', 'Angelus ad pastores ait', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:17', 17, NULL, 'Salve crux pretiosa', 'Salve crux pretiosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:18', 18, NULL, 'Quia vidisti me Thoma credidisti', 'Quia vidisti me Thoma credidisti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:19', 19, NULL, 'Lauda Syon salvatorem', 'Lauda Syon salvatorem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55425202-07cf-4084-ad4c-fe5a58a5c3f1', 20, NULL, 'O bone Iesu illumina oculos meos', 'O bone Iesu illumina oculos meos, SV 226', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55425202-07cf-4084-ad4c-fe5a58a5c3f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2a8ee3f-833d-4756-9db5-3dd7b4ae2af4', 21, NULL, 'Surgens Jesus Dominus noster', 'Surgens Jesus Dominus noster, SV 227', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2a8ee3f-833d-4756-9db5-3dd7b4ae2af4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv207:22', 22, NULL, 'Qui vult venire post me abneget se', 'Qui vult venire post me abneget se', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv207:22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e13c6f7-387d-467b-9650-89876d107875', 23, NULL, 'Iusti tulerunt spolia impiorum', 'Iusti tulerunt spolia impiorum, SV 229', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트집 <Sacrae cantiunculae>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e13c6f7-387d-467b-9650-89876d107875'
);


-- SV 205 6성부 미사 "인 일로 템포레"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6성부 미사 "인 일로 템포레"', 'Missa da capella a sei voci "In illo tempore", SV 205', 'album', 'SV 205', NULL, NULL, 1610, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6성부 미사 "인 일로 템포레"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0b62ed-08d9-4caa-b088-db2706125a8d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be0b62ed-08d9-4caa-b088-db2706125a8d'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be0b62ed-08d9-4caa-b088-db2706125a8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f583f47-88e6-3736-af5e-b91d44d492df', 1, 'I', 'Kyrie', 'Messe Nr. 1 "In Illo Tempore": Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f583f47-88e6-3736-af5e-b91d44d492df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86f36e0c-4529-3532-9207-b6d15ebae2a0', 2, 'II', 'Gloria', 'Messe Nr. 1 "In Illo Tempore": Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86f36e0c-4529-3532-9207-b6d15ebae2a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78353b42-bae4-3249-a324-b0e0d3e34105', 3, 'III', 'Credo', 'Messe Nr. 1 "In Illo Tempore": Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78353b42-bae4-3249-a324-b0e0d3e34105'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d55fa93-de20-356e-b470-fa79fc7df05a', 4, 'IV', 'Sanctus', 'Messe Nr. 1 "In Illo Tempore": Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d55fa93-de20-356e-b470-fa79fc7df05a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9254bac8-31c0-3e56-a4d9-6b2118d79474', 5, 'V', 'Benedictus', 'Messe Nr. 1 "In Illo Tempore": Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9254bac8-31c0-3e56-a4d9-6b2118d79474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec191a8-ba1e-3ac1-9cdc-3b12c9e556b9', 6, 'VI', 'Agnus Dei', 'Messe Nr. 1 "In Illo Tempore": Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '6성부 미사 "인 일로 템포레"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec191a8-ba1e-3ac1-9cdc-3b12c9e556b9'
);


-- SV 252–288 종교곡집 <도덕적이고 영적인 숲>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교곡집 <도덕적이고 영적인 숲>', 'Selva morale e spirituale', 'album', 'SV 252–288', NULL, NULL, 1641, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교곡집 <도덕적이고 영적인 숲>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c47f7bc-19b2-4292-8a37-a83cfdff4295'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c47f7bc-19b2-4292-8a37-a83cfdff4295'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c47f7bc-19b2-4292-8a37-a83cfdff4295'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27e42cc2-8430-4175-9e55-112f94e6828d', 1, NULL, 'O ciechi, il tanto affaticar che giova', 'Selva morale e spirituale: O ciechi ciechi, SV 252', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27e42cc2-8430-4175-9e55-112f94e6828d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72c61a62-7949-41eb-937b-d01068f76f8d', 2, NULL, 'Voi ch''ascoltate', 'Selva morale e spirituale: Voi ch''ascoltate, SV 253', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72c61a62-7949-41eb-937b-d01068f76f8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eed4969-c702-49e3-840d-2f47de9b53b1', 3, NULL, 'È questa vita un lampo', 'Selva morale e spirituale: È questa vita un lampo, SV 254', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eed4969-c702-49e3-840d-2f47de9b53b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f7cf565-233b-40ac-b372-614b77454423', 4, NULL, 'Spuntava il dì', 'Selva morale e spirituale: Spuntava il dì, SV 255', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f7cf565-233b-40ac-b372-614b77454423'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ecfef56-cae4-49fd-b435-6730bdb0c3d5', 5, NULL, 'Chi vol che m''innamori', 'Selva morale e spirituale: Chi vol che m''innamori, SV 256', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ecfef56-cae4-49fd-b435-6730bdb0c3d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:384a3e95-485b-413d-9e7f-819695bd3af6', 6, NULL, 'Messa a 4 da capella', 'Selva morale e spirituale: Messa a 4 da capella, SV 257', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:384a3e95-485b-413d-9e7f-819695bd3af6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94cd5388-a891-4579-942e-384820321c04', 7, NULL, 'Gloria a 7', 'Selva morale e spirituale: Gloria in excelsis Deo "concertata", SV 258', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94cd5388-a891-4579-942e-384820321c04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c860177-9dcd-43f7-8c23-2d9804e9f0bb', 8, NULL, 'Crucifixus', 'Selva morale e spirituale: Crucifixus, SV 259', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c860177-9dcd-43f7-8c23-2d9804e9f0bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c4b5350-d5b1-4ea4-9ff0-43b7cac78564', 9, NULL, 'Et resurrexit', 'Selva morale e spirituale: Et resurrexit, SV 260', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4b5350-d5b1-4ea4-9ff0-43b7cac78564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e02d351-db37-46d9-8a49-ef99eb424c1d', 10, NULL, 'Et iterum venturus est', 'Selva morale e spirituale: Et iterum venturus est, SV 261', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e02d351-db37-46d9-8a49-ef99eb424c1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:786d1119-2d1e-38a7-93c9-0440ef197fbe', 11, NULL, 'Ab aeterno ordinata sum', 'Selva morale e spirituale: Ab aeterno ordinata sum, SV 262', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:786d1119-2d1e-38a7-93c9-0440ef197fbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24faccd0-5f4a-4695-a9b4-d33d544fa124', 12, NULL, 'Dixit Dominus I', 'Selva morale e spirituale: Dixit Dominus [I], SV 263', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24faccd0-5f4a-4695-a9b4-d33d544fa124'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb6d7ad-3261-4ffa-bfa0-f053f9ef662b', 13, NULL, 'Dixit Dominus II', 'Selva morale e spirituale: Dixit Dominus II a 8 [Psalm 109] SV 264', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb6d7ad-3261-4ffa-bfa0-f053f9ef662b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79e28e80-a3ea-46b7-9b69-512070d58807', 14, NULL, 'Confitebor tibi Domine I', 'Selva morale e spirituale: Confitebor tibi domine [I], SV 265 + 193', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e28e80-a3ea-46b7-9b69-512070d58807'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95601897-67c6-331b-956f-6f36af5b95a8', 15, NULL, 'Confitebor tibi Domine II', 'Selva morale e spirituale: Confitebor tibi Domine [II], SV 266 + 194', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95601897-67c6-331b-956f-6f36af5b95a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35850198-b6ab-3e95-97a7-1d1dc8156cae', 16, NULL, 'Confitebor tibi Domine III', 'Selva morale e spirituale: Confitebor tibi Domine [III], SV 267', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35850198-b6ab-3e95-97a7-1d1dc8156cae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-4c47f7bc:17', 17, NULL, 'Confitebor tibi Domine IIIa', 'Confitebor tibi Domine IIIa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-4c47f7bc:17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39aaac95-6db5-4847-a27b-4da684a5a080', 18, NULL, 'Beatus vir I', 'Selva morale e spirituale: Beatus vir I a 6 [Psalm 112] SV 268', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39aaac95-6db5-4847-a27b-4da684a5a080'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7c9c103-da44-421f-9929-a555f9bd6baa', 19, NULL, 'Beatus vir II', 'Selva morale e spirituale: Beatus vir [II], SV 269', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c9c103-da44-421f-9929-a555f9bd6baa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:281120c8-389e-44c9-894c-e61da412148b', 20, NULL, 'Laudate pueri Dominum I', 'Selva morale e spirituale: Laudate pueri Dominum a 5 (concertato), SV 270', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:281120c8-389e-44c9-894c-e61da412148b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcd3a526-5cc9-4690-ae20-9ddc5cea397d', 21, NULL, 'Laudate pueri Dominum II', 'Selva morale e spirituale: Laudate Pueri II a 5 [Psalm 112] SV 271', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd3a526-5cc9-4690-ae20-9ddc5cea397d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dafc53e-61fe-433f-95b1-40efa6c2f1c0', 22, NULL, 'Laudate Dominum omnes gentes I', 'Selva morale e spirituale: Laudate Dominum I a 5 [Psalm 116] SV 272', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dafc53e-61fe-433f-95b1-40efa6c2f1c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-4c47f7bc:23', 23, NULL, 'Laudate Dominum omnes gentes Ia', 'Laudate Dominum omnes gentes Ia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-4c47f7bc:23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14bd89d2-8b54-4802-bdb7-be7427ba4499', 24, NULL, 'Laudate Dominum omnes gentes II', 'Selva morale e spirituale: Laudate dominum omnes gentes [II], SV 273', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bd89d2-8b54-4802-bdb7-be7427ba4499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e892cc2c-2a70-42ec-8a96-d45a9d895bfb', 25, NULL, 'Laudate Dominum omnes gentes III', 'Selva morale e spirituale: Laudate Dominum omnes gentes (III), SV 274', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e892cc2c-2a70-42ec-8a96-d45a9d895bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8202966-078a-415f-8e04-a8657577d0bb', 26, NULL, 'Credidi propter quod locutus sum', 'Selva morale e spirituale: Credidi propter quod locutus sum, SV 275', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8202966-078a-415f-8e04-a8657577d0bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:852f30aa-fd69-4fa4-888f-20cadad2dbf4', 27, NULL, 'Memento domine David', 'Selva morale e spirituale: Memento domine David, SV 276', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:852f30aa-fd69-4fa4-888f-20cadad2dbf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e376c0e-99ad-4d54-8b11-5cbe96f846e4', 28, NULL, 'Sanctorum meritis I', 'Selva morale e spirituale: Sanctorum meritis [I], SV 277', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e376c0e-99ad-4d54-8b11-5cbe96f846e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:961fc323-beb1-4e22-9e12-498ff5eb3ea2', 29, NULL, 'Sanctorum meritis II', 'Selva morale e spirituale: Sanctorum meritis [II], SV 278', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:961fc323-beb1-4e22-9e12-498ff5eb3ea2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-4c47f7bc:30', 30, NULL, 'Deus tuorum militum I', 'Deus tuorum militum I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-4c47f7bc:30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-4c47f7bc:31', 31, NULL, 'Iste confessor I', 'Iste confessor I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-4c47f7bc:31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:638b6171-8411-3b3f-90eb-e4260cf7b5ea', 32, NULL, 'Iste confessor II', 'Selva morale e spirituale: Iste confessor Domini sacratus, SV 279', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:638b6171-8411-3b3f-90eb-e4260cf7b5ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-4c47f7bc:33', 33, NULL, 'Ut queant laxis', 'Ut queant laxis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-4c47f7bc:33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af72137d-9698-3a9a-970a-41703261fa60', 34, NULL, 'Deus tuorum militum II', 'Selva morale e spirituale: Deus tuorum militum [II], SV 280', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af72137d-9698-3a9a-970a-41703261fa60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c7b62a1-063b-4e34-a596-7be81906a003', 35, NULL, 'Magnificat I', 'Selva morale e spirituale: Magnificat a 8 [Hymn] SV 281', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c7b62a1-063b-4e34-a596-7be81906a003'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3417eba-cce2-40c2-800c-a4c826279ebd', 36, NULL, 'Magnificat II', 'Selva morale e spirituale: Magnificat [II], SV 282', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3417eba-cce2-40c2-800c-a4c826279ebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b24e9d7d-78af-47da-978a-cd0948904047', 37, NULL, 'Salve Regina I', 'Selva morale e spirituale: Salve Regina [I], SV 283', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24e9d7d-78af-47da-978a-cd0948904047'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f280126-3172-47bc-8c15-7cfd26309e4e', 38, NULL, 'Salve Regina II', 'Selva morale e spirituale: Salve Regina [II], SV 284', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f280126-3172-47bc-8c15-7cfd26309e4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace859db-a8d1-4fc4-8df7-8033e7055ac9', 39, NULL, 'Salve Regina III', 'Selva morale e spirituale: Salva Regina a 3 [III], SV 285', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace859db-a8d1-4fc4-8df7-8033e7055ac9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67916d6a-6293-4ae3-87f8-158c9d921fa0', 40, NULL, 'Jubilet tota civitas', 'Selva morale e spirituale: Jubilet tota civitas [Motet] SV 286', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67916d6a-6293-4ae3-87f8-158c9d921fa0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4350cbfb-1c29-4b29-8abc-653b82509696', 41, NULL, 'Laudate Dominum in sanctis eius', 'Selva morale e spirituale: Laudate dominum in sanctis eius, SV 287', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4350cbfb-1c29-4b29-8abc-653b82509696'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1101c1a0-6b5c-48b3-a9c8-21c90ab5093e', 42, NULL, 'Pianto della Madonna', 'Selva morale e spirituale: Pianto della Madonna, SV 288', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <도덕적이고 영적인 숲>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1101c1a0-6b5c-48b3-a9c8-21c90ab5093e'
);


-- SV 190–204 종교곡집 <미사와 시편>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '종교곡집 <미사와 시편>', 'Messa a quattro voci et salmi, SV 190–204', 'album', 'SV 190–204', NULL, NULL, 1650, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '종교곡집 <미사와 시편>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0219027-1e06-4da4-8a85-2f926719d0b1', 1, NULL, 'Messa a 4 voci da cappella', 'Messa a quattro voci da cappella, SV 190', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0219027-1e06-4da4-8a85-2f926719d0b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1e0def2-cdaa-4573-9b84-d0d03ab5f724', 2, NULL, 'Dixit Dominus I', 'Dixit Dominus, SV 191 (a 8 voci, coro e soli)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1e0def2-cdaa-4573-9b84-d0d03ab5f724'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e9b3350-3fe4-4e1a-adae-d5a5f652c602', 3, NULL, 'Dixit Dominus II', 'Dixit Dominus à 8, SV 192', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e9b3350-3fe4-4e1a-adae-d5a5f652c602'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv190:4', 4, NULL, 'Confitebor tibi Domine I', 'Confitebor tibi Domine I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv190:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:monteverdi:monteverdi-sv190:5', 5, NULL, 'Confitebor tibi Domine II', 'Confitebor tibi Domine II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:monteverdi:monteverdi-sv190:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:077fc94f-12be-48b9-a22b-da783a241710', 6, NULL, 'Beatus vir', 'Beatus vir, SV 195 (a 7 voci, coro, soli e orchestra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:077fc94f-12be-48b9-a22b-da783a241710'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b83893cb-97e2-473b-972a-63e5056291a8', 7, NULL, 'Laudate pueri Dominum', 'Laudate pueri dominum, SV 196 + 311', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b83893cb-97e2-473b-972a-63e5056291a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd0130b7-5052-3b31-ba3f-b78d36904a6a', 8, NULL, 'Laudate Dominum omnes gentes', 'Messa a quattro voce et salmi: Laudate Dominum, O omnes gentes, SV 197', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd0130b7-5052-3b31-ba3f-b78d36904a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d37ec492-72bd-44fa-b5bb-8cdc88e7b08d', 9, NULL, 'Laetatus sum I', 'Laetatus sum, SV 198 (a 6)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d37ec492-72bd-44fa-b5bb-8cdc88e7b08d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5a113c2-5671-42ec-8303-8187d1e0c8d5', 10, NULL, 'Laetatus sum II', 'Laetatus sum, SV 199 (coro a 5 voci)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5a113c2-5671-42ec-8303-8187d1e0c8d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9046123b-6be3-3a5c-bcf6-781dcce2b840', 11, NULL, 'Nisi Dominus I', 'Messa a quattro voce et salmi: Nisi Dominus aedificaverit domum, SV 200', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9046123b-6be3-3a5c-bcf6-781dcce2b840'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4253a0bd-4c89-41ed-aefd-2a247a6f76c6', 12, NULL, 'Nisi Dominus II', 'Nisi Dominus (II), SV 201', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4253a0bd-4c89-41ed-aefd-2a247a6f76c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8575b20b-f96d-4799-8f4d-f7c4d124d6f0', 13, NULL, 'Lauda Jerusalem I', 'Lauda Jerusalem, SV 202 (contro-tenore, baritono e basso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8575b20b-f96d-4799-8f4d-f7c4d124d6f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7e3a0f3-286e-41c3-9b69-5d085e1278ac', 14, NULL, 'Lauda Jerusalem II', 'Lauda Jerusalem à 5, SV 203', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7e3a0f3-286e-41c3-9b69-5d085e1278ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17ad8c5-bbf9-4ed2-af05-83206501c3e8', 15, NULL, 'Letanie della Beata Vergine', 'Letanie della Beata Vergine, SV 204', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '종교곡집 <미사와 시편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17ad8c5-bbf9-4ed2-af05-83206501c3e8'
);


-- SV 289 모테트 <Adoramus te, Christe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Adoramus te, Christe>', 'Adoramus te, Christe, SV 289', 'song', 'SV 289', NULL, NULL, 1620, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Adoramus te, Christe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a0f17d7-900d-4ece-9f85-d04e776a2bd3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a0f17d7-900d-4ece-9f85-d04e776a2bd3'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Adoramus te, Christe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a0f17d7-900d-4ece-9f85-d04e776a2bd3'
);


-- SV 293 모테트 <Cantate Domino>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Cantate Domino>', 'Cantate domino canticum novum a 6, SV 293', 'song', 'SV 293', NULL, NULL, 1620, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Cantate Domino>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93e27388-9696-4ed2-aa5b-ba3031797037'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93e27388-9696-4ed2-aa5b-ba3031797037'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Cantate Domino>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93e27388-9696-4ed2-aa5b-ba3031797037'
);


-- SV 294 모테트 <Christe, adoramus te>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Christe, adoramus te>', 'Christe, adoramus te, SV 294', 'song', 'SV 294', NULL, NULL, 1620, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Christe, adoramus te>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca834ac2-8f19-409d-a002-fa83a851a693'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca834ac2-8f19-409d-a002-fa83a851a693'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Christe, adoramus te>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca834ac2-8f19-409d-a002-fa83a851a693'
);


-- SV 298 모테트 <Domine, ne in furore tuo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Domine, ne in furore tuo>', 'Domine ne in furore tuo arguas me, SV 298', 'song', 'SV 298', NULL, NULL, 1620, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Domine, ne in furore tuo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69acb2f8-3973-4aa5-bb2c-0ef89eebe263'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69acb2f8-3973-4aa5-bb2c-0ef89eebe263'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Domine, ne in furore tuo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69acb2f8-3973-4aa5-bb2c-0ef89eebe263'
);


-- SV 301 모테트 <Ego flos campi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ego flos campi>', 'Ego flos campi, SV 301', 'song', 'SV 301', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ego flos campi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ae98a07-d222-4ef5-914a-90c14b247357'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ae98a07-d222-4ef5-914a-90c14b247357'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Ego flos campi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ae98a07-d222-4ef5-914a-90c14b247357'
);


-- SV 335 모테트 <Venite sitientes ad aquas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Venite sitientes ad aquas>', 'Venite sitientes ad aquas domini, SV 335', 'song', 'SV 335', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Venite sitientes ad aquas>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90e0736e-f4f9-4c7d-8f64-4f639ef8aaa0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90e0736e-f4f9-4c7d-8f64-4f639ef8aaa0'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Venite sitientes ad aquas>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90e0736e-f4f9-4c7d-8f64-4f639ef8aaa0'
);


-- SV 326 모테트 <Salve, o Regina>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Salve, o Regina>', 'Salve o regina, SV 326', 'song', 'SV 326', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Salve, o Regina>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25cfdfcf-b064-47e5-91f9-4a51efe646f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25cfdfcf-b064-47e5-91f9-4a51efe646f0'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Salve, o Regina>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25cfdfcf-b064-47e5-91f9-4a51efe646f0'
);


-- SV 300 모테트 <Ego dormio et cor meum vigilat>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Ego dormio et cor meum vigilat>', 'Ego dormio et cor meum vigilat, SV 300', 'song', 'SV 300', NULL, NULL, 1625, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Ego dormio et cor meum vigilat>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7eff4a9-2e78-499c-b979-67b13e7c4016'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7eff4a9-2e78-499c-b979-67b13e7c4016'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Ego dormio et cor meum vigilat>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7eff4a9-2e78-499c-b979-67b13e7c4016'
);


-- SV 317 모테트 <O quam pulchra es>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <O quam pulchra es>', 'O quam pulchra es amica mea, SV 317', 'song', 'SV 317', NULL, NULL, 1625, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <O quam pulchra es>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf13b18-b47c-4060-9814-2c2faff2798e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cf13b18-b47c-4060-9814-2c2faff2798e'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <O quam pulchra es>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf13b18-b47c-4060-9814-2c2faff2798e'
);


-- SV 297 모테트 <Currite populi, psallite timpanis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Currite populi, psallite timpanis>', 'Currite populi, psallite timpanis, SV 297', 'song', 'SV 297', NULL, NULL, 1625, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Currite populi, psallite timpanis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd878f9aa-4d2b-48b6-97b5-34a56e129618'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd878f9aa-4d2b-48b6-97b5-34a56e129618'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Currite populi, psallite timpanis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd878f9aa-4d2b-48b6-97b5-34a56e129618'
);


-- SV 327 모테트 <Salve Regina>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Salve Regina>', 'Salve Regina, SV 327 (voce sola)', 'song', 'SV 327', NULL, NULL, 1625, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Salve Regina>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87ece3e0-1227-4d45-92ae-34dff3456391'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87ece3e0-1227-4d45-92ae-34dff3456391'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Salve Regina>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87ece3e0-1227-4d45-92ae-34dff3456391'
);


-- SV 303 모테트 <Exulta filia Sion>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Exulta filia Sion>', 'Exulta filia Sion, SV 303', 'song', 'SV 303', NULL, NULL, 1629, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Exulta filia Sion>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdf1534f-f27f-4603-9a07-3434f67c2c62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cdf1534f-f27f-4603-9a07-3434f67c2c62'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Exulta filia Sion>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cdf1534f-f27f-4603-9a07-3434f67c2c62'
);


-- SV 328 모테트 <Sancta Maria, succurre miseris>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Sancta Maria, succurre miseris>', 'Sancta Maria succurre miseris, SV 328', 'song', 'SV 328', NULL, NULL, 1618, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Sancta Maria, succurre miseris>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f45d4c30-bacc-4a30-95b0-7d9cbb10265c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f45d4c30-bacc-4a30-95b0-7d9cbb10265c'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Sancta Maria, succurre miseris>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f45d4c30-bacc-4a30-95b0-7d9cbb10265c'
);


-- SV 336 모테트 <Venite videte martyrem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Venite videte martyrem>', 'Venite videte martirem, SV 336', 'song', 'SV 336', NULL, NULL, 1645, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Venite videte martyrem>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b368883b-d8d2-4203-a606-3dbb29f8119b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b368883b-d8d2-4203-a606-3dbb29f8119b'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '모테트 <Venite videte martyrem>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b368883b-d8d2-4203-a606-3dbb29f8119b'
);


-- SV 316 가곡 <Ohimè ch'io cado>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ohimè ch''io cado>', 'Quarto Scherzo delle ariose vaghezze, SV 316: "Ohimè ch''io cado, ohimè ch''inciampo"', 'song', 'SV 316', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ohimè ch''io cado>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '430594f3-990a-4ab3-a268-ed76c1d7e9ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '430594f3-990a-4ab3-a268-ed76c1d7e9ca'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '가곡 <Ohimè ch''io cado>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '430594f3-990a-4ab3-a268-ed76c1d7e9ca'
);


-- SV 310 가곡 <La mia Turca>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La mia Turca>', 'La mia Turca che d''Amor non ha fè, SV 310', 'song', 'SV 310', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La mia Turca>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd29a1e6e-c6b0-43e7-b5f4-6076c264cb94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd29a1e6e-c6b0-43e7-b5f4-6076c264cb94'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '가곡 <La mia Turca>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd29a1e6e-c6b0-43e7-b5f4-6076c264cb94'
);


-- SV 332 가곡 <Sì dolce è 'l tormento>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sì dolce è ''l tormento>', 'Sì dolce è''l tormento, SV 332', 'song', 'SV 332', NULL, NULL, 1624, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sì dolce è ''l tormento>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74e8c80a-901b-4a50-9bd3-734bf3cbab25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74e8c80a-901b-4a50-9bd3-734bf3cbab25'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '가곡 <Sì dolce è ''l tormento>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74e8c80a-901b-4a50-9bd3-734bf3cbab25'
);


-- SV 337 가곡 <Voglio di vita uscir>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Voglio di vita uscir>', 'Voglio di vita uscir, SV 337', 'song', 'SV 337', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 5
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Voglio di vita uscir>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8f0d11b-5c9c-4d14-9112-b4716013dabf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8f0d11b-5c9c-4d14-9112-b4716013dabf'
FROM pieces p
WHERE p.composer_id = 5 AND p.title = '가곡 <Voglio di vita uscir>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8f0d11b-5c9c-4d14-9112-b4716013dabf'
);

-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 5 AND title = '오페라 <울리세의 귀환>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'stage_excerpt'
WHERE composer_id = 5 AND title = '오페라 <아리안나> 중 "아리안나의 탄식"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '3성부 칸초네타집' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 1권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 2권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 3권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 4권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 5권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 6권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 7권 <콘체르토>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 8권 <전쟁과 사랑의 마드리갈>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '마드리갈 9권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 5 AND title = '스케르치 무지칼리 (1607)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 5 AND title = '스케르치 무지칼리 (1632)' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트집 <Sacrae cantiunculae>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'mass_requiem'
WHERE composer_id = 5 AND title = '6성부 미사 "인 일로 템포레"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '종교곡집 <도덕적이고 영적인 숲>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '종교곡집 <미사와 시편>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Adoramus te, Christe>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Cantate Domino>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Christe, adoramus te>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Domine, ne in furore tuo>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Ego flos campi>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Venite sitientes ad aquas>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Salve, o Regina>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Ego dormio et cor meum vigilat>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <O quam pulchra es>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Currite populi, psallite timpanis>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Salve Regina>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Exulta filia Sion>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Sancta Maria, succurre miseris>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 5 AND title = '모테트 <Venite videte martyrem>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 5 AND title = '가곡 <Ohimè ch''io cado>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 5 AND title = '가곡 <La mia Turca>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 5 AND title = '가곡 <Sì dolce è ''l tormento>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 5 AND title = '가곡 <Voglio di vita uscir>' AND genre IS NULL AND form_key IS NULL;
