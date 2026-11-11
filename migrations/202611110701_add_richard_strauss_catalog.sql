-- 리하르트 슈트라우스(composer_id 498) 작품 목록. 지금은 「차라투스트라는 이렇게 말했다」 한 곡뿐이다.
-- 작품 93개(새 92 + 기존 차라투스트라), 세트·다악장 작품 안 곡 305개, 장르·형식.
--
-- 4차 자동 규칙은 MusicBrainz 의 based on·other version·revision of 관계가 있는 작품을 편곡·다른 판으로 보고 빼서
-- 「살로메」·「낙소스섬의 아리아드네」·「군트람」·「첼로 소나타」가 빠지고 CD-ROM 곡 같은 잡음이 들어갔다.
-- 그래서 작품을 손으로 고르고(교향시·오페라·발레·협주곡·실내악·피아노곡·작품번호 있는 가곡집·합창곡),
-- 곡은 MusicBrainz parts 순서대로 붙였다. 자료와 생성기:
--   seed_pipeline/curation/richard-strauss-catalog-2026-11-11/(works.tsv, build.py) → catalog-wave4 gen_catalog.py
-- 차라투스트라(비교 구간 있음)는 제목·설명·링크를 두고 MBID 와 9개 단락만 잇는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- Op. 30 교향시 <차라투스트라는 이렇게 말했다>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Einleitung', part.name_en = 'Also sprach Zarathustra, op. 30: I. Einleitung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:e6fa06fd-e6e7-363b-adf8-5d45fe99eaa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6fa06fd-e6e7-363b-adf8-5d45fe99eaa8', 1, 'I', 'Einleitung', 'Also sprach Zarathustra, op. 30: I. Einleitung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6fa06fd-e6e7-363b-adf8-5d45fe99eaa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Von den Hinterweltlern', part.name_en = 'Also sprach Zarathustra, op. 30: II. Von den Hinterweltlern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:7e7c0142-5fa7-3c27-8daf-474a4e1f25c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e7c0142-5fa7-3c27-8daf-474a4e1f25c4', 2, 'II', 'Von den Hinterweltlern', 'Also sprach Zarathustra, op. 30: II. Von den Hinterweltlern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e7c0142-5fa7-3c27-8daf-474a4e1f25c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Von der großen Sehnsucht', part.name_en = 'Also sprach Zarathustra, op. 30: III. Von der großen Sehnsucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:d0c5869d-effb-3420-91b9-19e06b4ff0e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c5869d-effb-3420-91b9-19e06b4ff0e5', 3, 'III', 'Von der großen Sehnsucht', 'Also sprach Zarathustra, op. 30: III. Von der großen Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c5869d-effb-3420-91b9-19e06b4ff0e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Von den Freuden und Leidenschaften', part.name_en = 'Also sprach Zarathustra, op. 30: IV. Von den Freuden und Leidenschaften',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:a73e1d23-c5e7-319b-9655-304ff0ecdd4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a73e1d23-c5e7-319b-9655-304ff0ecdd4f', 4, 'IV', 'Von den Freuden und Leidenschaften', 'Also sprach Zarathustra, op. 30: IV. Von den Freuden und Leidenschaften', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a73e1d23-c5e7-319b-9655-304ff0ecdd4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Das Grablied', part.name_en = 'Also sprach Zarathustra, op. 30: V. Das Grablied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:6c19c48a-4388-37e7-b1b8-188bf938b51a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c19c48a-4388-37e7-b1b8-188bf938b51a', 5, 'V', 'Das Grablied', 'Also sprach Zarathustra, op. 30: V. Das Grablied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c19c48a-4388-37e7-b1b8-188bf938b51a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Von der Wissenschaft', part.name_en = 'Also sprach Zarathustra, op. 30: VI. Von der Wissenschaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:f5e0f78e-979a-3cd5-ba08-9b9551820497' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5e0f78e-979a-3cd5-ba08-9b9551820497', 6, 'VI', 'Von der Wissenschaft', 'Also sprach Zarathustra, op. 30: VI. Von der Wissenschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5e0f78e-979a-3cd5-ba08-9b9551820497'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Der Genesende', part.name_en = 'Also sprach Zarathustra, op. 30: VII. Der Genesende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:385b5618-3882-3057-87ff-4ccdfe727c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:385b5618-3882-3057-87ff-4ccdfe727c6b', 7, 'VII', 'Der Genesende', 'Also sprach Zarathustra, op. 30: VII. Der Genesende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:385b5618-3882-3057-87ff-4ccdfe727c6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Das Tanzlied', part.name_en = 'Also sprach Zarathustra, op. 30: VIII. Das Tanzlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:92926182-6499-390e-a97c-aa2b713958c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92926182-6499-390e-a97c-aa2b713958c0', 8, 'VIII', 'Das Tanzlied', 'Also sprach Zarathustra, op. 30: VIII. Das Tanzlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92926182-6499-390e-a97c-aa2b713958c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Nachtwandlerlied', part.name_en = 'Also sprach Zarathustra, op. 30: IX. Nachtwandlerlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26025 AND p.composer_id = 498 AND part.part_key = 'musicbrainz:302ca58e-cc69-3532-ba2a-853aec4a9e46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:302ca58e-cc69-3532-ba2a-853aec4a9e46', 9, 'IX', 'Nachtwandlerlied', 'Also sprach Zarathustra, op. 30: IX. Nachtwandlerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26025 AND p.composer_id = 498
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:302ca58e-cc69-3532-ba2a-853aec4a9e46'
);


-- Op. 16 교향적 환상곡 <이탈리아에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 환상곡 <이탈리아에서>', 'Aus Italien', 'album', 'Op. 16', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 환상곡 <이탈리아에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf9e5b4c-0ae9-469e-af1c-480eec38b526'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf9e5b4c-0ae9-469e-af1c-480eec38b526'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향적 환상곡 <이탈리아에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf9e5b4c-0ae9-469e-af1c-480eec38b526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc3c26a3-339d-4394-bc60-8252ccc09a13', 1, 'I', 'Andante. Auf der Campagna', 'Aus Italien, op. 16: I. Andante. Auf der Campagna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향적 환상곡 <이탈리아에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc3c26a3-339d-4394-bc60-8252ccc09a13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef743449-a510-4188-9ad2-c8277059dc68', 2, 'II', 'Allegro molto con brio. In Roms Ruinen', 'Aus Italien, op. 16: II. Allegro molto con brio. In Roms Ruinen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향적 환상곡 <이탈리아에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef743449-a510-4188-9ad2-c8277059dc68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c434ab10-770a-4363-a875-7805fbc535e6', 3, 'III', 'Andantino. Am Strande von Sorrent', 'Aus Italien, op. 16: III. Andantino. Am Strande von Sorrent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향적 환상곡 <이탈리아에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c434ab10-770a-4363-a875-7805fbc535e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1031d27-e437-4c1e-b90a-c90c9ead6380', 4, 'IV', 'Finale: Allegro molto. Neapolitanisches Volksleben', 'Aus Italien, op. 16: IV. Finale: Allegro molto. Neapolitanisches Volksleben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향적 환상곡 <이탈리아에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1031d27-e437-4c1e-b90a-c90c9ead6380'
);


-- Op. 20 교향시 <돈 후안>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <돈 후안>', 'Don Juan', 'song', 'Op. 20', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <돈 후안>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd3e8e99-6170-3383-8aa7-f0cbf86e6dd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd3e8e99-6170-3383-8aa7-f0cbf86e6dd2'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈 후안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd3e8e99-6170-3383-8aa7-f0cbf86e6dd2'
);


-- Op. 23 교향시 <맥베스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <맥베스>', 'Macbeth', 'song', 'Op. 23', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <맥베스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a681621-bd5a-3b41-b3c0-12ffb8e4c744'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a681621-bd5a-3b41-b3c0-12ffb8e4c744'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <맥베스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a681621-bd5a-3b41-b3c0-12ffb8e4c744'
);


-- Op. 24 교향시 <죽음과 변용>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <죽음과 변용>', 'Tod und Verklärung, op. 24', 'album', 'Op. 24', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <죽음과 변용>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab56a448-e668-3432-8cbc-4839b2c9f76a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab56a448-e668-3432-8cbc-4839b2c9f76a'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <죽음과 변용>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab56a448-e668-3432-8cbc-4839b2c9f76a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:393c1806-2963-4a56-95cb-32c25deeccb7', 1, 'I', 'Largo', 'Tod und Verklärung, op. 24: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <죽음과 변용>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:393c1806-2963-4a56-95cb-32c25deeccb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75115c7c-7ce4-4512-a9a5-19ab45e6a5e7', 2, 'II', 'Allegro molto agitato', 'Tod und Verklärung, op. 24: II. Allegro molto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <죽음과 변용>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75115c7c-7ce4-4512-a9a5-19ab45e6a5e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a653286-a15f-490f-9aa1-a65a2ec6dc74', 3, 'III', 'Meno mosso', 'Tod und Verklärung, op. 24: III. Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <죽음과 변용>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a653286-a15f-490f-9aa1-a65a2ec6dc74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db0015f-fec4-4fe5-8767-b237bde826d6', 4, 'IV', 'Moderato', 'Tod und Verklärung, op. 24: IV. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <죽음과 변용>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db0015f-fec4-4fe5-8767-b237bde826d6'
);


-- Op. 28 교향시 <틸 오일렌슈피겔의 유쾌한 장난>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <틸 오일렌슈피겔의 유쾌한 장난>', 'Till Eulenspiegels lustige Streiche', 'song', 'Op. 28', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <틸 오일렌슈피겔의 유쾌한 장난>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4c3bb91-929f-3daf-9b6b-171678700358'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4c3bb91-929f-3daf-9b6b-171678700358'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <틸 오일렌슈피겔의 유쾌한 장난>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4c3bb91-929f-3daf-9b6b-171678700358'
);


-- Op. 35 교향시 <돈키호테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <돈키호테>', 'Don Quixote', 'album', 'Op. 35', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <돈키호테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55f0a8a1-102b-4b27-a6ba-1305e64e0674'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55f0a8a1-102b-4b27-a6ba-1305e64e0674'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55f0a8a1-102b-4b27-a6ba-1305e64e0674'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3f73619-b47b-3472-ba81-ad630b653980', 1, 'I', 'Introduction', 'Don Quixote, op. 35: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f73619-b47b-3472-ba81-ad630b653980'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:649d6a9d-2db6-4277-879e-9042ca5c0c35', 2, 'II', 'Theme and Variations', 'Don Quixote, op. 35: II. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:649d6a9d-2db6-4277-879e-9042ca5c0c35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe9bbcfa-6ff2-33e1-96e9-7a152a4120a0', 3, 'III', 'Epilogue: Don Quixote''s Mind Clears. Death of Don Quixote', 'Don Quixote, op. 35: III. Epilogue: Don Quixote''s Mind Clears. Death of Don Quixote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <돈키호테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9bbcfa-6ff2-33e1-96e9-7a152a4120a0'
);


-- Op. 40 교향시 <영웅의 생애>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <영웅의 생애>', 'Ein Heldenleben', 'album', 'Op. 40', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <영웅의 생애>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0ee1792-12e0-33de-9c44-7b31eacfa867'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0ee1792-12e0-33de-9c44-7b31eacfa867'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0ee1792-12e0-33de-9c44-7b31eacfa867'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd29b0db-5e98-3ee9-961c-66117b32c488', 1, 'I', 'Der Held', 'Ein Heldenleben, op. 40: I. Der Held', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd29b0db-5e98-3ee9-961c-66117b32c488'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5323cc1b-6b77-341f-8db4-b2b274fb3c26', 2, 'II', 'Des Helden Widersacher', 'Ein Heldenleben, op. 40: II. Des Helden Widersacher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5323cc1b-6b77-341f-8db4-b2b274fb3c26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ebb72f9-8996-32b6-bd80-eb8ac1547bf1', 3, 'III', 'Des Helden Gefährtin', 'Ein Heldenleben, op. 40: III. Des Helden Gefährtin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ebb72f9-8996-32b6-bd80-eb8ac1547bf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e149f6b-aa7c-3b1f-b086-5e6d8d2a6a9b', 4, 'IV', 'Des Helden Walstatt', 'Ein Heldenleben, op. 40: IV. Des Helden Walstatt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e149f6b-aa7c-3b1f-b086-5e6d8d2a6a9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:174ca133-b974-3a00-aa44-8721bed2458e', 5, 'V', 'Des Helden Friedenswerke', 'Ein Heldenleben, op. 40: V. Des Helden Friedenswerke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174ca133-b974-3a00-aa44-8721bed2458e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:641f68f3-f1f5-36fb-88f1-613c5ae8fc95', 6, 'VI', 'Des Helden Weltflucht und Vollendung', 'Ein Heldenleben, op. 40: VI. Des Helden Weltflucht und Vollendung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향시 <영웅의 생애>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:641f68f3-f1f5-36fb-88f1-613c5ae8fc95'
);


-- Op. 53 <가정 교향곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<가정 교향곡>', 'Symphonia Domestica', 'album', 'Op. 53', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<가정 교향곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f506b87-6fa0-494b-8547-1f027c8b7178'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f506b87-6fa0-494b-8547-1f027c8b7178'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f506b87-6fa0-494b-8547-1f027c8b7178'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:186a0416-7880-3cad-ba2d-ca5e9955c011', 1, 'I', 'Theme I. Bewegt - Theme II. Sehr lebhaft - Theme III. Ruhig', 'Symphonia Domestica, op. 53: I. Theme I. Bewegt - Theme II. Sehr lebhaft - Theme III. Ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:186a0416-7880-3cad-ba2d-ca5e9955c011'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f960b0a8-5a5c-39f1-b484-76b9a478d3d6', 2, 'II', 'Scherzo. Munter', 'Symphonia Domestica, op. 53: II. Scherzo. Munter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f960b0a8-5a5c-39f1-b484-76b9a478d3d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ee36772-94a0-3cb4-b5a4-785577e8aab6', 3, 'II', 'Wiegenlied: Mäßig langsam', 'Symphonia Domestica, op. 53: II. Wiegenlied: Mäßig langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ee36772-94a0-3cb4-b5a4-785577e8aab6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08ac7e9f-bd4b-39f7-b87c-c78c3cac2adc', 4, 'III', 'Adagio. Langsam', 'Symphonia Domestica, op. 53: III. Adagio. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ac7e9f-bd4b-39f7-b87c-c78c3cac2adc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1a8037d-2161-3efc-a340-e3df09545493', 5, 'IV', 'Finale. Sehr lebhaft', 'Symphonia Domestica, op. 53: IV. Finale. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<가정 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1a8037d-2161-3efc-a340-e3df09545493'
);


-- Op. 64 <알프스 교향곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<알프스 교향곡>', 'Eine Alpensinfonie', 'album', 'Op. 64', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<알프스 교향곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21e81734-0ada-42ce-b1d2-fb5e9180dd79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21e81734-0ada-42ce-b1d2-fb5e9180dd79'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21e81734-0ada-42ce-b1d2-fb5e9180dd79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d93d275-dac0-3640-a4f6-6d8df14e9d92', 1, 'I', 'Nacht', 'Eine Alpensinfonie, op. 64: I. Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d93d275-dac0-3640-a4f6-6d8df14e9d92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd08e83-f1e4-3df3-90b4-d589a5306461', 2, 'II', 'Sonnenaufgang', 'Eine Alpensinfonie, op. 64: II. Sonnenaufgang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd08e83-f1e4-3df3-90b4-d589a5306461'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6891ea23-d372-3862-a9c1-e07975a25dd9', 3, 'III', 'Der Anstieg', 'Eine Alpensinfonie, op. 64: III. Der Anstieg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6891ea23-d372-3862-a9c1-e07975a25dd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e9d80e-ea80-3daa-ba8b-31c0ebe6abd9', 4, 'IV', 'Der Eintritt in der Wald', 'Eine Alpensinfonie, op. 64: IV. Der Eintritt in der Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e9d80e-ea80-3daa-ba8b-31c0ebe6abd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4cb8557-26c3-3faa-9661-0bf2746212eb', 5, 'V', 'Wanderung neben dem Bache', 'Eine Alpensinfonie, op. 64: V. Wanderung neben dem Bache', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4cb8557-26c3-3faa-9661-0bf2746212eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e98068a4-a6b1-34c7-9e47-77c810f9a06f', 6, 'VI', 'Am Wasserfall', 'Eine Alpensinfonie, op. 64: VI. Am Wasserfall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e98068a4-a6b1-34c7-9e47-77c810f9a06f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7db11a-4088-3487-974f-f34f2c8af07a', 7, 'VII', 'Erscheinung', 'Eine Alpensinfonie, op. 64: VII. Erscheinung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7db11a-4088-3487-974f-f34f2c8af07a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:487a5f7a-bcd9-31ce-a71f-29b05f0d6428', 8, 'VIII', 'Auf blumigen Wiesen', 'Eine Alpensinfonie, op. 64: VIII. Auf blumigen Wiesen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:487a5f7a-bcd9-31ce-a71f-29b05f0d6428'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e4c9e5-f050-38d4-a4e1-9e794341051b', 9, 'IX', 'Auf der Alm', 'Eine Alpensinfonie, op. 64: IX. Auf der Alm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e4c9e5-f050-38d4-a4e1-9e794341051b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d457eef6-65aa-3a09-9470-a0b3049bd6b8', 10, 'X', 'Durch Dickicht und Gestrüpp auf Irrwegen', 'Eine Alpensinfonie, op. 64: X. Durch Dickicht und Gestrüpp auf Irrwegen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d457eef6-65aa-3a09-9470-a0b3049bd6b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dd4bdc7-b4e0-3be4-83c6-0aa6bf1c2fef', 11, 'XI', 'Auf dem Gletscher', 'Eine Alpensinfonie, op. 64: XI. Auf dem Gletscher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dd4bdc7-b4e0-3be4-83c6-0aa6bf1c2fef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2fdf1d3-d2e4-33b0-87be-7de3581f5518', 12, 'XII', 'Gefahrvolle Augenblicke', 'Eine Alpensinfonie, op. 64: XII. Gefahrvolle Augenblicke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2fdf1d3-d2e4-33b0-87be-7de3581f5518'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86ef3930-4663-30bd-9651-8eae92daaf7e', 13, 'XIII', 'Auf dem Gipfel', 'Eine Alpensinfonie, op. 64: XIII. Auf dem Gipfel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86ef3930-4663-30bd-9651-8eae92daaf7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7f7408-4996-3b8f-b839-77db746b41b1', 14, 'XIV', 'Vision', 'Eine Alpensinfonie, op. 64: XIV. Vision', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7f7408-4996-3b8f-b839-77db746b41b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ea4164-27f8-3eaa-8d77-9e4f15516ca5', 15, 'XV', 'Nebel steigen auf', 'Eine Alpensinfonie, op. 64: XV. Nebel steigen auf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ea4164-27f8-3eaa-8d77-9e4f15516ca5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d5baea1-b940-3d26-b55c-4794dea9876b', 16, 'XVI', 'Die Sonne verdüstert sich allmählich', 'Eine Alpensinfonie, op. 64: XVI. Die Sonne verdüstert sich allmählich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5baea1-b940-3d26-b55c-4794dea9876b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fda44a7a-9d28-3dc4-89d9-b7af70771fe4', 17, 'XVII', 'Elegie', 'Eine Alpensinfonie, op. 64: XVII. Elegie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda44a7a-9d28-3dc4-89d9-b7af70771fe4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3faa26bb-232d-3799-9c25-6a5e0fbddf3f', 18, 'XVIII', 'Stille vor dem Sturm', 'Eine Alpensinfonie, op. 64: XVIII. Stille vor dem Sturm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3faa26bb-232d-3799-9c25-6a5e0fbddf3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299d192e-871d-3b96-a7f7-89fd8ed1393f', 19, 'XIX', 'Gewitter und Sturm, Abstieg', 'Eine Alpensinfonie, op. 64: XIX. Gewitter und Sturm, Abstieg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299d192e-871d-3b96-a7f7-89fd8ed1393f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1122bc4-50eb-350c-8ca5-569fda684af4', 20, 'XX', 'Sonnenuntergang', 'Eine Alpensinfonie, op. 64: XX. Sonnenuntergang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1122bc4-50eb-350c-8ca5-569fda684af4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cdb82ca-1bbc-3366-b024-43adaf743e28', 21, 'XXI', 'Ausklang', 'Eine Alpensinfonie, op. 64: XXI. Ausklang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cdb82ca-1bbc-3366-b024-43adaf743e28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:446035fe-9e34-3eba-97ef-a9f4bdfb76ac', 22, 'XXII', 'Nacht', 'Eine Alpensinfonie, op. 64: XXII. Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<알프스 교향곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:446035fe-9e34-3eba-97ef-a9f4bdfb76ac'
);


-- TrV 290 23대의 독주 현악기를 위한 <메타모르포젠>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '23대의 독주 현악기를 위한 <메타모르포젠>', 'Metamorphosen, study for 23 solo strings', 'song', 'TrV 290', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '23대의 독주 현악기를 위한 <메타모르포젠>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '152ab7f6-7fbc-3541-8165-ed43201ef1b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '152ab7f6-7fbc-3541-8165-ed43201ef1b2'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '23대의 독주 현악기를 위한 <메타모르포젠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '152ab7f6-7fbc-3541-8165-ed43201ef1b2'
);


-- Op. 61 <축전 전주곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<축전 전주곡>', 'Festliches Präludium', 'song', 'Op. 61', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<축전 전주곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47d2f615-af16-3b7b-a7c0-88ad18b3c5e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47d2f615-af16-3b7b-a7c0-88ad18b3c5e3'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<축전 전주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47d2f615-af16-3b7b-a7c0-88ad18b3c5e3'
);


-- Op. 84 <일본 축전 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<일본 축전 음악>', 'Japanische Festmusik', 'song', 'Op. 84', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<일본 축전 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e92b81d9-86d9-4348-908c-665eb25e35f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e92b81d9-86d9-4348-908c-665eb25e35f6'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<일본 축전 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e92b81d9-86d9-4348-908c-665eb25e35f6'
);


-- Op. 60 모음곡 <서민 귀족>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <서민 귀족>', 'Der Bürger als Edelmann', 'album', 'Op. 60', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <서민 귀족>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '570b4a8b-7b29-4e2e-9615-3aff940cb964'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '570b4a8b-7b29-4e2e-9615-3aff940cb964'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '570b4a8b-7b29-4e2e-9615-3aff940cb964'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80db6b03-7c0b-4dad-b272-d0c11883f46d', 1, 'I', 'Overtüre', 'Le Bourgeois gentilhomme, op. 60: I. Overtüre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80db6b03-7c0b-4dad-b272-d0c11883f46d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:575485f9-be6b-4c7e-87bc-0fce4560baf4', 2, 'II', 'Menuett', 'Le Bourgeois gentilhomme, op. 60: II. Menuett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:575485f9-be6b-4c7e-87bc-0fce4560baf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f4a628-6a01-4414-9f01-4f0e060b6b25', 3, 'III', 'Der Fechtmeister', 'Le Bourgeois gentilhomme, op. 60: III. Der Fechtmeister', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f4a628-6a01-4414-9f01-4f0e060b6b25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cd82f1a-2a1a-4493-98fe-1c7e75cfcf41', 4, 'IV', 'Auftritt und Tanz der Schneider', 'Le bourgeois gentilhomme, op. 60: IV. Auftritt und Tanz der Schneider', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cd82f1a-2a1a-4493-98fe-1c7e75cfcf41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb3bc947-3215-4dff-80ee-73887fe52db6', 5, 'V', 'Menuett des Lully', 'Le bourgeois gentilhomme, op. 60: V. Menuett des Lully', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb3bc947-3215-4dff-80ee-73887fe52db6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fa534ed-b07b-44ab-8853-cd80725cca23', 6, 'VI', 'Courante', 'Le bourgeois gentilhomme, op. 60: VI. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa534ed-b07b-44ab-8853-cd80725cca23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c76f9aa-31dc-4924-8cd3-c6a4803c22b8', 7, 'VII', 'Auftritt des Cléonte', 'Le bourgeois gentilhomme, op. 60: VII. Auftritt des Cléonte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c76f9aa-31dc-4924-8cd3-c6a4803c22b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b66d7c4-2c10-4206-95c2-7326c7bdd3df', 8, 'VIII', 'Vorspiel zum 2. Aufzug', 'Le bourgeois gentilhomme, op. 60: VIII. Vorspiel zum 2. Aufzug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b66d7c4-2c10-4206-95c2-7326c7bdd3df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ca3559-b75d-4fa5-8072-f7c6aee01b37', 9, 'IX', 'Das Diner', 'Le bourgeois gentilhomme, op. 60: IX. Das Diner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '모음곡 <서민 귀족>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ca3559-b75d-4fa5-8072-f7c6aee01b37'
);


-- Op. 7 13대의 관악기를 위한 세레나데 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '13대의 관악기를 위한 세레나데 E♭장조', 'Serenade for 13 Wind Instruments in E-flat major', 'song', 'Op. 7', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '13대의 관악기를 위한 세레나데 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f11905-d3ef-4dc1-9b42-7f7c7737635e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4f11905-d3ef-4dc1-9b42-7f7c7737635e'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 세레나데 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f11905-d3ef-4dc1-9b42-7f7c7737635e'
);


-- Op. 4 13대의 관악기를 위한 모음곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '13대의 관악기를 위한 모음곡 B♭장조', 'Suite for 13 wind instruments in B-flat major', 'album', 'Op. 4', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '13대의 관악기를 위한 모음곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97429dfb-f836-47ae-bf2b-f68d1933d31a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97429dfb-f836-47ae-bf2b-f68d1933d31a'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 모음곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97429dfb-f836-47ae-bf2b-f68d1933d31a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede514d5-cd44-4552-8930-2a4d5043da04', 1, NULL, 'Praeludium', 'Suite in B-flat major, op. 4: 1. Praeludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 모음곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede514d5-cd44-4552-8930-2a4d5043da04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e4f15d6-bd46-4056-8523-ddaad21dd50b', 2, NULL, 'Romanze', 'Suite in B-flat major, op. 4: 2. Romanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 모음곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e4f15d6-bd46-4056-8523-ddaad21dd50b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe40db95-5e81-44be-b648-d8ecd895cc78', 3, NULL, 'Gavotte', 'Suite in B-flat major, op. 4: 3. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 모음곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe40db95-5e81-44be-b648-d8ecd895cc78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66b4f737-9428-4b27-b0e9-d8753e73ad9b', 4, NULL, 'Introduktion und Fuge', 'Suite in B-flat major, op. 4: 4. Introduktion und Fuge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '13대의 관악기를 위한 모음곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66b4f737-9428-4b27-b0e9-d8753e73ad9b'
);


-- TrV 288 관악 소나티네 1번 F장조 "병자의 작업실에서"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 소나티네 1번 F장조 "병자의 작업실에서"', 'Sonatina no. 1 in F major “From the Workshop of an Invalid”', 'album', 'TrV 288', NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 소나티네 1번 F장조 "병자의 작업실에서"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb592590-bdbc-4c14-a9ab-9133a074d1a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb592590-bdbc-4c14-a9ab-9133a074d1a5'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 1번 F장조 "병자의 작업실에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb592590-bdbc-4c14-a9ab-9133a074d1a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba87df0-393f-4915-a046-382cf116f71b', 1, NULL, 'Allegro moderato', 'Sonatina no. 1 in F major “Aus der Werkstatt eines Invaliden”, AV 135: 1. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 1번 F장조 "병자의 작업실에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba87df0-393f-4915-a046-382cf116f71b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63063a52-6e08-4e0b-9dc2-279d8d45b46c', 2, NULL, 'Romanze und Menuett. Andante - Tempo di Menuetto - Andante', 'Sonatina no. 1 in F major “Aus der Werkstatt eines Invaliden”, AV 135: 2. Romanze und Menuett. Andante - Tempo di Menuetto - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 1번 F장조 "병자의 작업실에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63063a52-6e08-4e0b-9dc2-279d8d45b46c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e202dc9e-5874-48c2-b598-8ae9dc56e358', 3, NULL, 'Finale. Allegro molto', 'Sonatina no. 1 in F major “Aus der Werkstatt eines Invaliden”, AV 135: 3. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 1번 F장조 "병자의 작업실에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e202dc9e-5874-48c2-b598-8ae9dc56e358'
);


-- TrV 291 관악 소나티네 2번 E♭장조 "즐거운 작업실"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 소나티네 2번 E♭장조 "즐거운 작업실"', 'Sonatina no. 2 in E-flat major “Fröhliche Werkstatt”', 'album', 'TrV 291', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c0138be-face-40ab-85e2-3bf85a20ad39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c0138be-face-40ab-85e2-3bf85a20ad39'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c0138be-face-40ab-85e2-3bf85a20ad39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af8315fb-4c32-4b78-bd06-66ab817f28fb', 1, NULL, 'Allegro con brio', 'Sonatina no. 2 in E-flat major (Symphony for Winds) “Fröhliche Werkstatt”, AV 143: 1. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af8315fb-4c32-4b78-bd06-66ab817f28fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:434b2b5a-8d2e-46fb-a34f-3e3ab391c411', 2, NULL, 'Andantino, sehr gemächlich', 'Sonatina no. 2 in E-flat major (Symphony for Winds) “Fröhliche Werkstatt”, AV 143: 2. Andantino, sehr gemächlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:434b2b5a-8d2e-46fb-a34f-3e3ab391c411'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c9074d-998b-404e-9f85-e1693d924390', 3, NULL, 'Menuett. Etwas lebhaft - Cantabile - Tempo primo', 'Sonatina no. 2 in E-flat major (Symphony for Winds) “Fröhliche Werkstatt”, AV 143: 3. Menuett. Etwas lebhaft - Cantabile - Tempo primo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c9074d-998b-404e-9f85-e1693d924390'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2717fcdd-5c51-4ac0-bb41-ac0004effdc9', 4, NULL, 'Einleitung und Allegro. Andante - Allegro', 'Sonatina no. 2 in E-flat major (Symphony for Winds) “Fröhliche Werkstatt”, AV 143: 4. Einleitung und Allegro. Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2717fcdd-5c51-4ac0-bb41-ac0004effdc9'
);


-- Op. 86 쿠프랭의 건반 작품에 의한 디베르티멘토

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쿠프랭의 건반 작품에 의한 디베르티멘토', 'Divertimento, op. 86', 'album', 'Op. 86', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쿠프랭의 건반 작품에 의한 디베르티멘토'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccd2cbeb-1489-404c-9911-e62099602ecc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccd2cbeb-1489-404c-9911-e62099602ecc'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccd2cbeb-1489-404c-9911-e62099602ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d5cd224-6e47-4fdc-bc45-bf59adce62dc', 1, 'I', 'La Visionnaire', 'Divertimento, op. 86: I. La Visionnaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d5cd224-6e47-4fdc-bc45-bf59adce62dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f9363a-f07c-47ed-8906-c02e4d0f4d0d', 2, 'II', 'Musette de Choisy / La fine Madelon / La douce Janneton / La Sézile / Musette de Taverny', 'Divertimento, op. 86: II. Musette de Choisy / La fine Madelon / La douce Janneton / La Sézile / Musette de Taverny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f9363a-f07c-47ed-8906-c02e4d0f4d0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b135cfc3-2384-4037-bbb0-92a4f6949d2f', 3, 'III', 'Le Tic-Toc-Choc / La Lutine', 'Divertimento, op. 86: III. Le Tic-Toc-Choc / La Lutine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b135cfc3-2384-4037-bbb0-92a4f6949d2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:811fdd54-8f4f-4b22-8d41-e17115fbe514', 4, 'IV', 'Les Fauvettes plaintives', 'Divertimento, op. 86: IV. Les Fauvettes plaintives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:811fdd54-8f4f-4b22-8d41-e17115fbe514'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ad899b7-76c4-479a-878c-b7f31ac12a7b', 5, 'V', 'Le Trophée / L''Anguille / Les jeunes Seigneurs / La Linotte effarouchée', 'Divertimento, op. 86: V. Le Trophée / L''Anguille / Les jeunes Seigneurs / La Linotte effarouchée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ad899b7-76c4-479a-878c-b7f31ac12a7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdc3f859-aaef-495b-88ca-8688a9b31659', 6, 'VI', 'Les Tours de passe-passe', 'Divertimento, op. 86: VI. Les Tours de passe-passe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdc3f859-aaef-495b-88ca-8688a9b31659'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7242cae0-5884-4dd8-ae91-ac35409eb804', 7, 'VII', 'Les Ombres errantes', 'Divertimento, op. 86: VII. Les Ombres errantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7242cae0-5884-4dd8-ae91-ac35409eb804'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bfffd3e-02e3-4757-a3f5-9985c2d1aba4', 8, 'VIII', 'Les Brimborions / La Badine', 'Divertimento, op. 86: VIII. Les Brimborions / La Badine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bfffd3e-02e3-4757-a3f5-9985c2d1aba4'
);


-- TrV 245 쿠프랭의 건반 작품에 의한 무곡 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쿠프랭의 건반 작품에 의한 무곡 모음곡', 'Tanzsuite aus Klavierstücken von François Couperin', 'album', 'TrV 245', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f9622cd-cf8b-4983-9c19-981994aed884'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f9622cd-cf8b-4983-9c19-981994aed884'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f9622cd-cf8b-4983-9c19-981994aed884'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29be58d8-3992-4259-a173-5756c6aef529', 1, 'I', 'Einzug und Feierlicher Reigen (Pavane)', 'Tanzsuite: I. Einzug und Feierlicher Reigen (Pavane)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29be58d8-3992-4259-a173-5756c6aef529'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d7483a-c30c-421f-98d7-e0dab6502f0a', 2, 'II', 'Courante', 'Tanzsuite: II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d7483a-c30c-421f-98d7-e0dab6502f0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40ae73fe-496e-48d5-9c35-c48d2ae2026f', 3, 'III', 'Carillon', 'Tanzsuite: III. Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ae73fe-496e-48d5-9c35-c48d2ae2026f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:895003b0-2280-4284-b924-7e03cf827b37', 4, 'IV', 'Sarabande', 'Tanzsuite: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:895003b0-2280-4284-b924-7e03cf827b37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c34241a-c818-4ffa-ba43-1f5be0b08984', 5, 'V', 'Gavotte', 'Tanzsuite: V. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c34241a-c818-4ffa-ba43-1f5be0b08984'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbb146dd-4721-4b04-94ae-8e62736f1899', 6, 'VI', 'Wirbeltanz', 'Tanzsuite: VI. Wirbeltanz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbb146dd-4721-4b04-94ae-8e62736f1899'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ef3ad23-455b-45f3-8477-7b6856f906d3', 7, 'VII', 'Allemande', 'Tanzsuite: VII. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ef3ad23-455b-45f3-8477-7b6856f906d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77caad2a-a5bf-4386-bc3b-7227e9cf5146', 8, 'VIII', 'March', 'Tanzsuite: VIII. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77caad2a-a5bf-4386-bc3b-7227e9cf5146'
);


-- Op. 57 2개의 군대 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 군대 행진곡', '2 Militärmärsche für großes Orchester', 'song', 'Op. 57', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 군대 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00099ef6-db0b-42a3-ab22-32cd53b38398'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00099ef6-db0b-42a3-ab22-32cd53b38398'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '2개의 군대 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00099ef6-db0b-42a3-ab22-32cd53b38398'
);


-- TrV 94 교향곡 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 D단조', 'Symphony no. 1 in D minor, TrV 94, AV 69 (1880)', 'album', 'TrV 94', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f81b4035-505b-49aa-8193-3666bb4d1a39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f81b4035-505b-49aa-8193-3666bb4d1a39'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f81b4035-505b-49aa-8193-3666bb4d1a39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d6ac57a-2910-4422-9ac3-7c452875672f', 1, NULL, 'Andante maestoso-Allegro', 'Symphony in D minor, AV 69: Andante maestoso-Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d6ac57a-2910-4422-9ac3-7c452875672f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36806187-0f04-4aa3-af40-d7d2b915ebb1', 2, NULL, 'Andante', 'Symphony in D minor, AV 69: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36806187-0f04-4aa3-af40-d7d2b915ebb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00af9e09-24d0-42a9-83cc-9708b49d5466', 3, NULL, 'Scherzo. Molto allegro, leggiero', 'Symphony in D minor, AV 69: Scherzo. Molto allegro, leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00af9e09-24d0-42a9-83cc-9708b49d5466'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4e7de31-bd6e-421d-b46a-cc22f6753ead', 4, NULL, 'Finale. Allegro maestoso', 'Symphony in D minor, AV 69: Finale. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4e7de31-bd6e-421d-b46a-cc22f6753ead'
);


-- Op. 12 교향곡 2번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 F단조', 'Symphony no. 2 in F minor', 'album', 'Op. 12', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e221421-b094-4f80-a029-ace4c0875024'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e221421-b094-4f80-a029-ace4c0875024'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e221421-b094-4f80-a029-ace4c0875024'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60e090ae-b76a-4ccc-acf5-84ca6002508c', 1, NULL, 'Allegro ma non troppo', 'Symphony no. 2 in F minor, op. 12 (TrV 126): 1. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60e090ae-b76a-4ccc-acf5-84ca6002508c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10809c80-bd5b-4a7d-8e72-c4a2785cf8b6', 2, NULL, 'Scherzo: Presto', 'Symphony no. 2 in F minor, op. 12 (TrV 126): 2. Scherzo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10809c80-bd5b-4a7d-8e72-c4a2785cf8b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df67ed7-6f62-45b7-af58-fa2eb4adc4b8', 3, NULL, 'Andante cantabile', 'Symphony no. 2 in F minor, op. 12 (TrV 126): 3. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df67ed7-6f62-45b7-af58-fa2eb4adc4b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd8685e7-955f-4216-a7ee-b9ec524d8a9e', 4, NULL, 'Allegro assai, molto appassionato', 'Symphony no. 2 in F minor, op. 12 (TrV 126): 4. Allegro assai, molto appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '교향곡 2번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd8685e7-955f-4216-a7ee-b9ec524d8a9e'
);


-- Op. 8 바이올린 협주곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 D단조', 'Violin Concerto in D minor', 'album', 'Op. 8', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72313445-d1a7-4951-9e6e-90152bbedeed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72313445-d1a7-4951-9e6e-90152bbedeed'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72313445-d1a7-4951-9e6e-90152bbedeed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02633e84-f2a7-3692-a2b0-754ac35e867a', 1, 'I', 'Allegro', 'Violin Concerto in D minor, op. 8: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02633e84-f2a7-3692-a2b0-754ac35e867a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3fa5e06-7061-3760-80f6-6f17943e4f4a', 2, 'II', 'Lento', 'Violin Concerto in D minor, op. 8: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3fa5e06-7061-3760-80f6-6f17943e4f4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c0da1d4-872f-3f4c-bac0-4e173bebc641', 3, 'III', 'Rondo', 'Violin Concerto in D minor, op. 8: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 협주곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0da1d4-872f-3f4c-bac0-4e173bebc641'
);


-- Op. 11 호른 협주곡 1번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 협주곡 1번 E♭장조', 'Waldhornkonzert Es-Dur nr. 1', 'album', 'Op. 11', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 협주곡 1번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49db064f-bf29-4b61-ac09-45354713eb11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49db064f-bf29-4b61-ac09-45354713eb11'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49db064f-bf29-4b61-ac09-45354713eb11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d91a415e-dd0b-43f4-9dd5-8417be8f02a0', 1, 'I', 'Allegro', 'Konzert für Horn und Orchester Nr. 1 Es-dur, op. 11: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d91a415e-dd0b-43f4-9dd5-8417be8f02a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5fb3a56-4909-44f0-919b-7ae31b47e4de', 2, 'II', 'Andante', 'Konzert für Horn und Orchester Nr. 1 Es-dur, op. 11: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5fb3a56-4909-44f0-919b-7ae31b47e4de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb9347c2-febe-4d91-ac67-75aeef5a7691', 3, 'III', 'Rondo (Allegro)', 'Konzert für Horn und Orchester Nr. 1 Es-dur, op. 11: III. Rondo (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb9347c2-febe-4d91-ac67-75aeef5a7691'
);


-- AV 132 호른 협주곡 2번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 협주곡 2번 E♭장조', 'Konzert für Horn und Orchester Nr. 2 Es-Dur, AV 132', 'album', 'AV 132', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 협주곡 2번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65d65e0f-218c-495f-b849-343a8d7c0a83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65d65e0f-218c-495f-b849-343a8d7c0a83'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65d65e0f-218c-495f-b849-343a8d7c0a83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a0b99e8-1d0a-4046-bd6f-b79605c54f39', 1, 'I', 'Allegro', 'Konzert für Horn und Orchester Nr. 2 Es-Dur, AV 132: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a0b99e8-1d0a-4046-bd6f-b79605c54f39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79275f89-cdd0-44d6-85cf-cbc69473eb36', 2, 'II', 'Andante con moto', 'Konzert für Horn und Orchester Nr. 2 Es-Dur, AV 132: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79275f89-cdd0-44d6-85cf-cbc69473eb36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54fe0c29-c8d0-4b5f-a467-a8aecf244eba', 3, 'III', 'Rondo (Allegro molto)', 'Konzert für Horn und Orchester Nr. 2 Es-Dur, AV 132: III. Rondo (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '호른 협주곡 2번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54fe0c29-c8d0-4b5f-a467-a8aecf244eba'
);


-- TrV 292 오보에 협주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 D장조', 'Oboe Concerto in D major, TrV 292, AV 144', 'album', 'TrV 292', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6f3c770-0bd8-4a6d-abdc-cfaabe9815ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6f3c770-0bd8-4a6d-abdc-cfaabe9815ee'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오보에 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6f3c770-0bd8-4a6d-abdc-cfaabe9815ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa4a16f-1c3e-40b7-aaa2-e9bd60e1d9a7', 1, 'I', 'Allegro moderato', 'Oboe Concerto in D major: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오보에 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa4a16f-1c3e-40b7-aaa2-e9bd60e1d9a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25e85c4d-2d92-4755-82cf-d6a2627f2950', 2, 'II', 'Andante', 'Oboe Concerto in D major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오보에 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e85c4d-2d92-4755-82cf-d6a2627f2950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43122f50-d707-4c05-9469-cef64659ab39', 3, 'III', 'Vivace', 'Oboe Concerto in D major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오보에 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43122f50-d707-4c05-9469-cef64659ab39'
);


-- TrV 145 피아노와 관현악을 위한 부를레스케 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 부를레스케 D단조', 'Burleske in D minor, TrV 145', 'song', 'TrV 145', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 부를레스케 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '589eea6b-9de6-30fd-af43-79717e493092'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '589eea6b-9de6-30fd-af43-79717e493092'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노와 관현악을 위한 부를레스케 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '589eea6b-9de6-30fd-af43-79717e493092'
);


-- TrV 293 클라리넷과 바순을 위한 이중 콘체르티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷과 바순을 위한 이중 콘체르티노', 'Duett-Concertino for Clarinet, Bassoon and Strings', 'album', 'TrV 293', NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷과 바순을 위한 이중 콘체르티노'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acacaead-8eed-463f-b666-7dda831e73ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acacaead-8eed-463f-b666-7dda831e73ec'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '클라리넷과 바순을 위한 이중 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acacaead-8eed-463f-b666-7dda831e73ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec2a65d4-5e2d-4635-a878-2ab10827beaf', 1, 'I', 'Allegro moderato', 'Duett-Concertino for Clarinet, Bassoon and Strings: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '클라리넷과 바순을 위한 이중 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec2a65d4-5e2d-4635-a878-2ab10827beaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0b24851-4273-4754-a987-30ea07addb56', 2, 'II', 'Andante', 'Duett-Concertino for Clarinet, Bassoon and Strings: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '클라리넷과 바순을 위한 이중 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0b24851-4273-4754-a987-30ea07addb56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ab1046d-42d1-49de-ada2-79a5971ca42e', 3, 'III', 'Rondo. Allegro ma non troppo', 'Duett-Concertino for Clarinet, Bassoon and Strings: III. Rondo. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '클라리넷과 바순을 위한 이중 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ab1046d-42d1-49de-ada2-79a5971ca42e'
);


-- Op. 74 왼손 피아노와 관현악을 위한 <판아테나이아 행렬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왼손 피아노와 관현악을 위한 <판아테나이아 행렬>', 'Panathenäenzug', 'song', 'Op. 74', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왼손 피아노와 관현악을 위한 <판아테나이아 행렬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449aaeb6-c7dd-4fed-8255-c4976b3e3e97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '449aaeb6-c7dd-4fed-8255-c4976b3e3e97'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '왼손 피아노와 관현악을 위한 <판아테나이아 행렬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449aaeb6-c7dd-4fed-8255-c4976b3e3e97'
);


-- AV 75 첼로와 관현악을 위한 로망스 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 관현악을 위한 로망스 F장조', 'Romanze in F major for Violoncello & Orchestra, AV 75', 'song', 'AV 75', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 관현악을 위한 로망스 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f42a374-3b5d-40f9-abf9-e871bd6c353e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f42a374-3b5d-40f9-abf9-e871bd6c353e'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '첼로와 관현악을 위한 로망스 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f42a374-3b5d-40f9-abf9-e871bd6c353e'
);


-- Op. 2 현악 4중주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 A장조', 'String Quartet in A major', 'album', 'Op. 2', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '846a4d8b-674b-4f83-b963-ffe829006bef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '846a4d8b-674b-4f83-b963-ffe829006bef'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '현악 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '846a4d8b-674b-4f83-b963-ffe829006bef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd958476-3ab9-4cc3-9098-d52a693c2de3', 1, NULL, 'Allegro', 'String Quartet in A major, op. 2: 1. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '현악 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd958476-3ab9-4cc3-9098-d52a693c2de3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3229e806-8e0e-4ba6-baf3-b40f8f149713', 2, NULL, 'Scherzo - Trio', 'String Quartet in A major, op. 2: 2. Scherzo - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '현악 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3229e806-8e0e-4ba6-baf3-b40f8f149713'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e148049-ff91-4623-9d19-70ce43f955c2', 3, NULL, 'Andante cantabile', 'String Quartet in A major, op. 2: 3. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '현악 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e148049-ff91-4623-9d19-70ce43f955c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da38de0d-3207-4918-83aa-2a7ae1dbf3ab', 4, NULL, 'Allegro vivace', 'String Quartet in A major, op. 2: 4. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '현악 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da38de0d-3207-4918-83aa-2a7ae1dbf3ab'
);


-- Op. 6 첼로 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 F장조', 'Cello Sonata in F major', 'album', 'Op. 6', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea045f7f-110c-4b2a-8895-c6a46e09f242'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea045f7f-110c-4b2a-8895-c6a46e09f242'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '첼로 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea045f7f-110c-4b2a-8895-c6a46e09f242'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48bba365-ff7b-4f7c-943c-99b6b21458bf', 1, NULL, 'Allegro con brio', 'Cello Sonata in F major, for cello and piano: 1. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '첼로 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48bba365-ff7b-4f7c-943c-99b6b21458bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2890f130-1046-4341-972a-693cecb9560e', 2, NULL, 'Andante ma non troppo', 'Cello Sonata in F major, for cello and piano: 2. Andante ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '첼로 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2890f130-1046-4341-972a-693cecb9560e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab0abc3-c682-4086-8fba-5a7f247c00bf', 3, NULL, 'Finale: Allegro vivo', 'Cello Sonata in F major, for cello and piano: 3. Finale: Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '첼로 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab0abc3-c682-4086-8fba-5a7f247c00bf'
);


-- Op. 13 피아노 4중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 C단조', 'Piano Quartet in C minor', 'album', 'Op. 13', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4d9c63-1f86-48d4-a074-2701143e4e53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d4d9c63-1f86-48d4-a074-2701143e4e53'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4d9c63-1f86-48d4-a074-2701143e4e53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:accde99d-b308-3112-acc7-daf7617188a6', 1, 'I', 'Allegro', 'Piano Quartet in C minor, op. 13: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:accde99d-b308-3112-acc7-daf7617188a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e8a8f59-568e-3a38-b111-ff833e3ef130', 2, 'II', 'Scherzo. Presto - Molto meno mosso - Tempo I', 'Piano Quartet in C minor, op. 13: II. Scherzo. Presto - Molto meno mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e8a8f59-568e-3a38-b111-ff833e3ef130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1830fabe-1f17-30e7-abce-719083d51e8e', 3, 'III', 'Andante', 'Piano Quartet in C minor, op. 13: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1830fabe-1f17-30e7-abce-719083d51e8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa316989-d4c7-3872-b7b1-bac489d6b83f', 4, 'IV', 'Finale vivace', 'Piano Quartet in C minor, op. 13: IV. Finale vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 4중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa316989-d4c7-3872-b7b1-bac489d6b83f'
);


-- Op. 18 바이올린 소나타 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 E♭장조', 'Sonata for Violin and Piano in E-flat major', 'album', 'Op. 18', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9d8cbfd-f381-4c41-8a88-ca4be6bd094c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9d8cbfd-f381-4c41-8a88-ca4be6bd094c'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 소나타 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9d8cbfd-f381-4c41-8a88-ca4be6bd094c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:603f6f87-8c49-3fd9-9040-78deaeeefb3d', 1, 'I', 'Allegro ma non troppo', 'Sonata for Violin and Piano in E-flat major, op. 18: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 소나타 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:603f6f87-8c49-3fd9-9040-78deaeeefb3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389d3600-54f2-37f4-ba06-5062e5363648', 2, 'II', 'Improvisation. Andante cantabile', 'Sonata for Violin and Piano in E-flat major, op. 18: II. Improvisation. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 소나타 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389d3600-54f2-37f4-ba06-5062e5363648'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2280a32b-c38b-3a7c-8860-d855ae6ac617', 3, 'III', 'Finale. Andante - Allegro', 'Sonata for Violin and Piano in E-flat major, op. 18: III. Finale. Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '바이올린 소나타 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2280a32b-c38b-3a7c-8860-d855ae6ac617'
);


-- TrV 53 피아노 3중주 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 1번 A장조', 'Piano Trio no. 1 in A major', 'album', 'TrV 53', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac13dad-4f03-4438-944c-233db519ceeb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ac13dad-4f03-4438-944c-233db519ceeb'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac13dad-4f03-4438-944c-233db519ceeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bf6b5e0-6bd4-465b-b3ef-134176ff5f8e', 1, NULL, 'Allegro moderato', 'Piano Trio no. 1 in A major: 1. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bf6b5e0-6bd4-465b-b3ef-134176ff5f8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4be2728-6f08-4b95-a90d-51f1e0edf26c', 2, NULL, 'Adagio', 'Piano Trio no. 1 in A major: 2. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4be2728-6f08-4b95-a90d-51f1e0edf26c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8a4d3e5-92cd-4e89-a9f3-a98257e73b49', 3, NULL, 'Tempo di Menuetto ma non lento', 'Piano Trio no. 1 in A major: 3. Tempo di Menuetto ma non lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8a4d3e5-92cd-4e89-a9f3-a98257e73b49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21a2d363-90d2-4e0f-be8b-a71906258c6b', 4, NULL, 'Allegro vivace', 'Piano Trio no. 1 in A major: 4. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a2d363-90d2-4e0f-be8b-a71906258c6b'
);


-- TrV 71 피아노 3중주 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 2번 D장조', 'Piano Trio no. 2 in D major, for violin, cello and piano', 'album', 'TrV 71', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f4d019c-b6b4-4bfb-b23d-a8fd510eecb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f4d019c-b6b4-4bfb-b23d-a8fd510eecb9'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f4d019c-b6b4-4bfb-b23d-a8fd510eecb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:009cf4b4-7ba2-4b6e-9d72-d4a969e9f0a6', 1, NULL, 'Allegro moderato', 'Piano Trio no. 2 in D major, for violin, cello and piano: 1. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009cf4b4-7ba2-4b6e-9d72-d4a969e9f0a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da5d0e05-4452-4b28-8700-5889562bc04d', 2, NULL, 'Andante cantabile ma non troppo', 'Piano Trio no. 2 in D major, for violin, cello and piano: 2. Andante cantabile ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da5d0e05-4452-4b28-8700-5889562bc04d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e02b95-786f-4442-9d19-9ab327160226', 3, NULL, 'Scherzo: Allegro assai', 'Piano Trio no. 2 in D major, for violin, cello and piano: 3. Scherzo: Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e02b95-786f-4442-9d19-9ab327160226'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcec799f-2c81-41a6-a428-87906bc068b4', 4, NULL, 'Finale: Lento assai - Allegro vivace', 'Piano Trio no. 2 in D major, for violin, cello and piano: 4. Finale: Lento assai - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 3중주 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcec799f-2c81-41a6-a428-87906bc068b4'
);


-- Op. 5 피아노 소나타 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 B단조', 'Sonata for Piano in B minor, op. 5', 'album', 'Op. 5', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87d735a0-cf85-4ab8-a74d-df60bc3d8618'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87d735a0-cf85-4ab8-a74d-df60bc3d8618'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87d735a0-cf85-4ab8-a74d-df60bc3d8618'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e51a896-bbfd-3cf4-8dc4-7d7f917d4f77', 1, 'I', 'Allegro molto appassionato', 'Sonata for Piano in B minor, op. 5: I. Allegro molto appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e51a896-bbfd-3cf4-8dc4-7d7f917d4f77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461f27a3-70e1-3124-a8e9-4326140ee23a', 2, 'II', 'Adagio cantabile', 'Sonata for Piano in B minor, op. 5: II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461f27a3-70e1-3124-a8e9-4326140ee23a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f3de515-546f-3744-99f0-5c11d67ae48f', 3, 'III', 'Scherzo. Presto - Trio. Un poco piu lento', 'Sonata for Piano in B minor, op. 5: III. Scherzo. Presto - Trio. Un poco piu lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f3de515-546f-3744-99f0-5c11d67ae48f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6e26d0e-d0eb-3c20-ab35-8ad28bc9aba0', 4, 'IV', 'Finale. Allegretto vivo', 'Sonata for Piano in B minor, op. 5: IV. Finale. Allegretto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6e26d0e-d0eb-3c20-ab35-8ad28bc9aba0'
);


-- Op. 3 5개의 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 피아노 소품', 'Klavierstücke', 'album', 'Op. 3', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5176091a-cf2f-43c5-a86c-027cf7c5f665'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5176091a-cf2f-43c5-a86c-027cf7c5f665'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5176091a-cf2f-43c5-a86c-027cf7c5f665'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8908b87-d40f-310a-ac9d-09237c91823d', 1, NULL, 'Andante in B-flat major', 'Five Piano Pieces, op. 3: No. 1. Andante in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8908b87-d40f-310a-ac9d-09237c91823d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a5762b-4d27-30f6-b672-b51e8b8efc51', 2, NULL, 'Allegro vivace scherzando in E-flat major', 'Five Piano Pieces, op. 3: No. 2. Allegro vivace scherzando in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a5762b-4d27-30f6-b672-b51e8b8efc51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df2c224a-b47a-3c6e-8c06-67b7f750c42a', 3, NULL, 'Largo in C minor', 'Five Piano Pieces, op. 3: No. 3. Largo in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df2c224a-b47a-3c6e-8c06-67b7f750c42a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e1827bb-ca31-3dca-b8d0-b4fd362c2abf', 4, NULL, 'Allegro molto in A-flat major', 'Five Piano Pieces, op. 3: No. 4. Allegro molto in A-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e1827bb-ca31-3dca-b8d0-b4fd362c2abf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80885625-24dd-3931-bb17-20929b4ac6d0', 5, NULL, 'Allegro marcatissimo in D-flat major', 'Five Piano Pieces, op. 3: No. 5. Allegro marcatissimo in D-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80885625-24dd-3931-bb17-20929b4ac6d0'
);


-- Op. 9 <분위기 그림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<분위기 그림>', 'Stimmungsbilder, op. 9', 'album', 'Op. 9', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<분위기 그림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80c3ca3-c499-448f-94b2-2caa9269638b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd80c3ca3-c499-448f-94b2-2caa9269638b'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80c3ca3-c499-448f-94b2-2caa9269638b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f97dc94-141b-4958-8d03-3ab8e5e1f1c1', 1, NULL, 'Auf stillem Waldespfad', 'Stimmungsbilder, op. 9 no. 1: Auf stillem Waldespfad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f97dc94-141b-4958-8d03-3ab8e5e1f1c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1047ecf9-df4e-4f73-826b-610f17f6f2fa', 2, NULL, 'An einsamer Quelle', 'Stimmungsbilder, op. 9 no. 2: An einsamer Quelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1047ecf9-df4e-4f73-826b-610f17f6f2fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfbf2492-7e12-4c1f-98eb-fbf682540d69', 3, NULL, 'Intermezzo', 'Stimmungsbilder, op. 9 no. 3: Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfbf2492-7e12-4c1f-98eb-fbf682540d69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3739c9-ca16-44af-bcce-53c2bd04509d', 4, NULL, 'Träumerei', 'Stimmungsbilder, op. 9 no. 4: Träumerei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3739c9-ca16-44af-bcce-53c2bd04509d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6ffd301-a828-4df7-81cf-2eb41b857cd0', 5, NULL, 'Heidebild', 'Stimmungsbilder, op. 9 no. 5: Heidebild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<분위기 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6ffd301-a828-4df7-81cf-2eb41b857cd0'
);


-- Op. 25 오페라 <군트람>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <군트람>', 'Guntram', 'song', 'Op. 25', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <군트람>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ad18739-cdf9-490d-917c-575eb5dd47c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ad18739-cdf9-490d-917c-575eb5dd47c8'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <군트람>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ad18739-cdf9-490d-917c-575eb5dd47c8'
);


-- Op. 50 오페라 <포이어스노트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <포이어스노트>', 'Feuersnot, Singgedicht in 1 act', 'song', 'Op. 50', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <포이어스노트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac72a18e-c707-4320-886b-2afba2923812'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac72a18e-c707-4320-886b-2afba2923812'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <포이어스노트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac72a18e-c707-4320-886b-2afba2923812'
);


-- Op. 54 오페라 <살로메>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <살로메>', 'Salome', 'song', 'Op. 54', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <살로메>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8c369d7-ea18-43d0-81c5-da078e8a5ee4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8c369d7-ea18-43d0-81c5-da078e8a5ee4'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <살로메>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8c369d7-ea18-43d0-81c5-da078e8a5ee4'
);


-- Op. 58 오페라 <엘렉트라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <엘렉트라>', 'Elektra', 'song', 'Op. 58', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <엘렉트라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349ee8f3-b962-420e-908c-5d87ac842ea0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '349ee8f3-b962-420e-908c-5d87ac842ea0'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <엘렉트라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349ee8f3-b962-420e-908c-5d87ac842ea0'
);


-- Op. 59 오페라 <장미의 기사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <장미의 기사>', 'Der Rosenkavalier', 'song', 'Op. 59', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <장미의 기사>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18e6d250-1e75-499c-804b-865da45f8ddb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18e6d250-1e75-499c-804b-865da45f8ddb'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <장미의 기사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18e6d250-1e75-499c-804b-865da45f8ddb'
);


-- Op. 60 오페라 <낙소스섬의 아리아드네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <낙소스섬의 아리아드네>', 'Ariadne auf Naxos', 'song', 'Op. 60', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <낙소스섬의 아리아드네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '086272af-a8e0-4e13-a908-39c931ec47f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '086272af-a8e0-4e13-a908-39c931ec47f9'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <낙소스섬의 아리아드네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '086272af-a8e0-4e13-a908-39c931ec47f9'
);


-- Op. 65 오페라 <그림자 없는 여인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <그림자 없는 여인>', 'Die Frau ohne Schatten', 'song', 'Op. 65', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <그림자 없는 여인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9ec168a-fe03-4e73-ae6e-3399156b0ad7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9ec168a-fe03-4e73-ae6e-3399156b0ad7'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <그림자 없는 여인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9ec168a-fe03-4e73-ae6e-3399156b0ad7'
);


-- Op. 72 오페라 <인테르메초>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <인테르메초>', 'Intermezzo', 'song', 'Op. 72', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <인테르메초>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14f9456a-5f6b-4c12-935c-499d95b9479d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14f9456a-5f6b-4c12-935c-499d95b9479d'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <인테르메초>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14f9456a-5f6b-4c12-935c-499d95b9479d'
);


-- Op. 75 오페라 <이집트의 헬레나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이집트의 헬레나>', 'Die ägyptische Helena', 'song', 'Op. 75', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이집트의 헬레나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7449f91e-0a2f-44f7-9dc4-4be95247d9a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7449f91e-0a2f-44f7-9dc4-4be95247d9a7'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <이집트의 헬레나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7449f91e-0a2f-44f7-9dc4-4be95247d9a7'
);


-- Op. 79 오페라 <아라벨라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아라벨라>', 'Arabella', 'song', 'Op. 79', NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아라벨라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e86fba-e45b-4945-b1b0-e9b1af00fa79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99e86fba-e45b-4945-b1b0-e9b1af00fa79'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <아라벨라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99e86fba-e45b-4945-b1b0-e9b1af00fa79'
);


-- Op. 80 오페라 <말 없는 여인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <말 없는 여인>', 'Die schweigsame Frau', 'song', 'Op. 80', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <말 없는 여인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b673bcf1-2ed9-4f04-932d-d12d8e14f097'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b673bcf1-2ed9-4f04-932d-d12d8e14f097'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <말 없는 여인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b673bcf1-2ed9-4f04-932d-d12d8e14f097'
);


-- Op. 81 오페라 <평화의 날>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <평화의 날>', 'Friedenstag', 'song', 'Op. 81', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <평화의 날>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69c9cee4-f938-4b2b-a2c8-ac9418aa8708'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69c9cee4-f938-4b2b-a2c8-ac9418aa8708'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <평화의 날>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69c9cee4-f938-4b2b-a2c8-ac9418aa8708'
);


-- Op. 82 오페라 <다프네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <다프네>', 'Daphne', 'song', 'Op. 82', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <다프네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad0c585e-85dc-49e1-a67f-089dce1e0203'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad0c585e-85dc-49e1-a67f-089dce1e0203'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <다프네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad0c585e-85dc-49e1-a67f-089dce1e0203'
);


-- Op. 83 오페라 <다나에의 사랑>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <다나에의 사랑>', 'Die Liebe der Danae', 'song', 'Op. 83', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <다나에의 사랑>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5945db5f-609e-4cf6-bf6d-3e11e393def5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5945db5f-609e-4cf6-bf6d-3e11e393def5'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <다나에의 사랑>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5945db5f-609e-4cf6-bf6d-3e11e393def5'
);


-- Op. 85 오페라 <카프리치오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <카프리치오>', 'Capriccio', 'song', 'Op. 85', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <카프리치오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbf9e9f9-8ca4-4f80-89b5-5c72b4da497d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbf9e9f9-8ca4-4f80-89b5-5c72b4da497d'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '오페라 <카프리치오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbf9e9f9-8ca4-4f80-89b5-5c72b4da497d'
);


-- Op. 63 발레 <요셉의 전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <요셉의 전설>', 'Josephslegende, op. 63', 'song', 'Op. 63', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <요셉의 전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb110f7e-a6e5-4bd4-a4c1-199f4fbad2f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb110f7e-a6e5-4bd4-a4c1-199f4fbad2f5'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '발레 <요셉의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb110f7e-a6e5-4bd4-a4c1-199f4fbad2f5'
);


-- Op. 70 발레 <휘핑크림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <휘핑크림>', 'Schlagobers', 'song', 'Op. 70', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <휘핑크림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eef62485-7d93-436b-9420-d653e893c1cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eef62485-7d93-436b-9420-d653e893c1cc'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '발레 <휘핑크림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eef62485-7d93-436b-9420-d653e893c1cc'
);


-- Op. 38 멜로드라마 <이녹 아든>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <이녹 아든>', 'Enoch Arden', 'song', 'Op. 38', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <이녹 아든>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daf3dfaa-bbea-43c6-b1c5-04424b5a2e22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'daf3dfaa-bbea-43c6-b1c5-04424b5a2e22'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '멜로드라마 <이녹 아든>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daf3dfaa-bbea-43c6-b1c5-04424b5a2e22'
);


-- AV 150 연가곡집 <네 개의 마지막 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <네 개의 마지막 노래>', 'Vier letzte Lieder, AV 150', 'album', 'AV 150', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <네 개의 마지막 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07393065-1123-4d65-b5e7-26e78f0ad0a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07393065-1123-4d65-b5e7-26e78f0ad0a6'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07393065-1123-4d65-b5e7-26e78f0ad0a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35145aa9-c8f1-33fd-adda-12b23dc1d9d9', 1, 'I', '봄 (Frühling)', 'Vier letzte Lieder, AV 150: I. „Frühling“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35145aa9-c8f1-33fd-adda-12b23dc1d9d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd82ce57-ce32-330c-a6fe-595aacf32dfb', 2, 'II', '9월 (September)', 'Vier letzte Lieder, AV 150: II. „September“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd82ce57-ce32-330c-a6fe-595aacf32dfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5e3e01f-8621-3a48-84e5-1439efb3547d', 3, 'III', '잠자리에 들 때 (Beim Schlafengehen)', 'Vier letzte Lieder, AV 150: III. „Beim Schlafengehen“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5e3e01f-8621-3a48-84e5-1439efb3547d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4faff8e-eb5f-38eb-9a9e-f0d834e657c9', 4, 'IV', '저녁노을에 (Im Abendrot)', 'Vier letzte Lieder, AV 150: IV. „Im Abendrot“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <네 개의 마지막 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4faff8e-eb5f-38eb-9a9e-f0d834e657c9'
);


-- Op. 10 <마지막 잎새>에 의한 8개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<마지막 잎새>에 의한 8개의 가곡', '8 Gedichte aus »Letzte Blätter«', 'album', 'Op. 10', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<마지막 잎새>에 의한 8개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a587143c-255a-4b18-91f3-015bd4994212'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a587143c-255a-4b18-91f3-015bd4994212'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a587143c-255a-4b18-91f3-015bd4994212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4050841-5bf0-4e1a-bc4e-b3f536bfd30b', 1, NULL, '헌정 (Zueignung)', 'Zueignung, op. 10 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4050841-5bf0-4e1a-bc4e-b3f536bfd30b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e41312-1800-4ca8-b0de-8c1085696a3b', 2, NULL, 'Nichts', 'Nichts, op. 10 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e41312-1800-4ca8-b0de-8c1085696a3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b0fd814-3028-3a8d-aeb2-9491a31dc0c5', 3, NULL, '밤 (Die Nacht)', 'Die Nacht, op. 10 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b0fd814-3028-3a8d-aeb2-9491a31dc0c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d4c774d-451c-47eb-a465-beff82bc3faa', 4, NULL, 'Die Georgine', 'Die Georgine, op. 10 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d4c774d-451c-47eb-a465-beff82bc3faa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe7257a5-154b-3808-8d22-6d905dd7d564', 5, NULL, 'Geduld', 'Geduld, op. 10 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe7257a5-154b-3808-8d22-6d905dd7d564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bcc132-4dd2-483a-9080-04c62e54e7d7', 6, NULL, 'Die Verschwiegenen', 'Die Verschwiegenen, op. 10 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bcc132-4dd2-483a-9080-04c62e54e7d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23e65ca0-2c5c-3f17-a87e-cdd46f571f3e', 7, NULL, 'Zeitlose', 'Zeitlose, op. 10 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23e65ca0-2c5c-3f17-a87e-cdd46f571f3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c779170f-79df-3e71-b149-e8b266c6f03a', 8, NULL, '만령절 (Allerseelen)', 'Allerseelen, op. 10 no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<마지막 잎새>에 의한 8개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c779170f-79df-3e71-b149-e8b266c6f03a'
);


-- Op. 15 5개의 가곡 Op. 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 15', '5 Lieder for middle voice and piano', 'album', NULL, 'Op.', '15', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 15'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2758210c-dcec-442e-8291-09bc9e2f532f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2758210c-dcec-442e-8291-09bc9e2f532f'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2758210c-dcec-442e-8291-09bc9e2f532f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f17252-2b6f-4f76-a182-d6f7da90ea4d', 1, NULL, 'Madrigal', 'Madrigal, op. 15 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f17252-2b6f-4f76-a182-d6f7da90ea4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8efe5107-6a97-40eb-88a0-16bac219b6df', 2, NULL, 'Winternacht', 'Winternacht, op. 15 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efe5107-6a97-40eb-88a0-16bac219b6df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd8bfafa-c3a8-3b94-ba95-9903bda7783e', 3, NULL, 'Lob des Leidens', 'Lob des Leidens, op. 15 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd8bfafa-c3a8-3b94-ba95-9903bda7783e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe86c38a-6f48-4b85-b042-a88855bdc584', 4, NULL, 'Aus den Liedern der Trauer', 'Aus den Liedern der Trauer, op. 15 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe86c38a-6f48-4b85-b042-a88855bdc584'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7170365a-ae71-3874-9c80-bdd3e05191de', 5, NULL, 'Heimkehr', 'Heimkehr, op. 15 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7170365a-ae71-3874-9c80-bdd3e05191de'
);


-- Op. 17 6개의 가곡 Op. 17

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 17', '6 Lieder', 'album', NULL, 'Op.', '17', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 17'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd52bcac7-6bbd-451b-a1fb-2436f1d51311'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd52bcac7-6bbd-451b-a1fb-2436f1d51311'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd52bcac7-6bbd-451b-a1fb-2436f1d51311'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa794d05-4150-30e9-a8f0-888742f64012', 1, NULL, 'Seitdem dein Aug''', 'Seitdem dein Aug'', op. 17 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa794d05-4150-30e9-a8f0-888742f64012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff3ed8d-9878-31aa-a569-950f6d28dca6', 2, NULL, '세레나데 (Ständchen)', 'Ständchen, op. 17 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff3ed8d-9878-31aa-a569-950f6d28dca6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1093dbd1-3e87-3de3-b145-c34881c1bd32', 3, NULL, 'Das Geheimnis', 'Das Geheimnis, op. 17 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1093dbd1-3e87-3de3-b145-c34881c1bd32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3a0e88d-5732-4ca6-97a0-61bf91843fd0', 4, NULL, 'Aus den Liedern der Trauer', 'Aus den Liedern der Trauer, op. 17 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3a0e88d-5732-4ca6-97a0-61bf91843fd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53a697d2-b094-4d5d-8729-5e6346fbc046', 5, NULL, 'Nur Mut!', 'Nur Mut!, op. 17 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53a697d2-b094-4d5d-8729-5e6346fbc046'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e54a09c-366b-4403-bca5-a2dec3cce053', 6, NULL, 'Barcarole', 'Barcarole, op. 17 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e54a09c-366b-4403-bca5-a2dec3cce053'
);


-- Op. 19 <연꽃잎>에 의한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<연꽃잎>에 의한 6개의 가곡', '6 Lieder aus »Lotosblätter«, op. 19', 'album', 'Op. 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<연꽃잎>에 의한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7ed648a-963e-40ec-9026-61941d8d0359'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7ed648a-963e-40ec-9026-61941d8d0359'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7ed648a-963e-40ec-9026-61941d8d0359'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d5937a-9c49-4435-a293-48680445b1d8', 1, NULL, 'Wozu noch, Mädchen', 'Wozu noch, Mädchen, op. 19 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d5937a-9c49-4435-a293-48680445b1d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16cb93be-fcf7-4928-878f-dfe61764a932', 2, NULL, 'Breit'' über mein Haupt dein schwarzes Haar', 'Breit'' über mein Haupt dein schwarzes Haar, op. 19 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16cb93be-fcf7-4928-878f-dfe61764a932'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c07e123b-887e-364f-aa8f-63d9694001b6', 3, NULL, 'Schön sind, doch kalt die Himmelssterne', 'Schön sind, doch kalt die Himmelssterne, op. 19 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c07e123b-887e-364f-aa8f-63d9694001b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23d60d64-91be-3b03-807c-5952cc034e67', 4, NULL, 'Wie sollten wir geheim sie halten', 'Wie sollten wir geheim sie halten, op. 19 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23d60d64-91be-3b03-807c-5952cc034e67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6852cdbc-8df6-4485-88ab-3f31b6093e8e', 5, NULL, 'Hoffen und wieder verzagen', 'Hoffen und wieder verzagen, op. 19 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6852cdbc-8df6-4485-88ab-3f31b6093e8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60fdcaa1-76dd-4b10-a920-bae1d9a48806', 6, NULL, 'Mein Herz ist stumm, mein Herz ist kalt', 'Mein Herz ist stumm, mein Herz ist kalt, op. 19 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<연꽃잎>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60fdcaa1-76dd-4b10-a920-bae1d9a48806'
);


-- Op. 21 <소박한 노래> 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<소박한 노래> 5개의 가곡', 'Schlichte Weisen', 'album', 'Op. 21', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<소박한 노래> 5개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbce8f7-5b26-4983-b402-0bd5a117ca94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcbce8f7-5b26-4983-b402-0bd5a117ca94'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbce8f7-5b26-4983-b402-0bd5a117ca94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beb695bb-24c2-4cc6-9d17-9494a741b9e3', 1, NULL, 'All mein’ Gedanken', 'All mein’ Gedanken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beb695bb-24c2-4cc6-9d17-9494a741b9e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94100b59-aaef-35e8-a8b5-4fabced1b5a6', 2, NULL, 'Du meines Herzens Krönelein', 'Du meines Herzens Krönelein, op. 21 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94100b59-aaef-35e8-a8b5-4fabced1b5a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f8e6cfc-e460-3d0a-9f14-7a59a736208c', 3, NULL, 'Ach Lieb, ich muss nun scheiden', 'Ach Lieb, ich muss nun scheiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f8e6cfc-e460-3d0a-9f14-7a59a736208c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2a39661-6f6f-4e29-a513-7543c8f067a2', 4, NULL, 'Ach weh mir unglückhaftem Mann', 'Ach weh mir unglückhaftem Mann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2a39661-6f6f-4e29-a513-7543c8f067a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c5f99c-7ab0-42f6-b22b-1b6da7626b89', 5, NULL, 'Die Frauen sind oft fromm und still', 'Die Frauen sind oft fromm und still, op. 21 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소박한 노래> 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c5f99c-7ab0-42f6-b22b-1b6da7626b89'
);


-- Op. 22 <소녀의 꽃> 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<소녀의 꽃> 4개의 가곡', 'Mädchenblumen, op. 22', 'album', 'Op. 22', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<소녀의 꽃> 4개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc3beaf2-1cac-475b-873d-277f9f4f0292'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc3beaf2-1cac-475b-873d-277f9f4f0292'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소녀의 꽃> 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc3beaf2-1cac-475b-873d-277f9f4f0292'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae742a96-0ae1-434d-b793-1d0e69dc26d6', 1, NULL, 'Kornblumen', 'Mädchenblumen, op. 22: Nr. 1. Kornblumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소녀의 꽃> 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae742a96-0ae1-434d-b793-1d0e69dc26d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:040db7a0-fb42-46a2-b3c5-0bfa6b9633ea', 2, NULL, 'Mohnblumen', 'Mädchenblumen, op. 22: Nr. 2. Mohnblumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소녀의 꽃> 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040db7a0-fb42-46a2-b3c5-0bfa6b9633ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d769d85a-cce2-487d-8859-046107df74dd', 3, NULL, 'Epheu', 'Mädchenblumen, op. 22: Nr. 3. Epheu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소녀의 꽃> 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d769d85a-cce2-487d-8859-046107df74dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a46e084-317b-4782-9783-626c0c7ae7f9', 4, NULL, 'Wasserrose', 'Mädchenblumen, op. 22: Nr. 4. Wasserrose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<소녀의 꽃> 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a46e084-317b-4782-9783-626c0c7ae7f9'
);


-- Op. 26 2개의 가곡 Op. 26

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡 Op. 26', '2 Lieder, op. 26', 'album', NULL, 'Op.', '26', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡 Op. 26'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '280a3fcd-63e3-43d1-887c-198b19fa17d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '280a3fcd-63e3-43d1-887c-198b19fa17d8'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '2개의 가곡 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '280a3fcd-63e3-43d1-887c-198b19fa17d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad44a00-fecd-42e5-989a-45a7161996d1', 1, NULL, 'Frühlingsgedränge', 'Frühlingsgedränge, op. 26 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '2개의 가곡 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad44a00-fecd-42e5-989a-45a7161996d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9283c22a-95eb-4d91-a12a-ca5da1eea967', 2, NULL, 'Wärst du mein', 'Wärst du mein, op. 26 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '2개의 가곡 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9283c22a-95eb-4d91-a12a-ca5da1eea967'
);


-- Op. 27 4개의 가곡 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 Op. 27', '4 Lieder, op. 27', 'album', NULL, 'Op.', '27', 1894, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e4bcd2d-a829-441e-b701-c0235dc7cab1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e4bcd2d-a829-441e-b701-c0235dc7cab1'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e4bcd2d-a829-441e-b701-c0235dc7cab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67604a79-f727-3aeb-b694-f8ab14594296', 1, NULL, '쉬어라, 내 영혼아 (Ruhe, meine Seele)', 'Ruhe, meine Seele, op. 27 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67604a79-f727-3aeb-b694-f8ab14594296'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3675fd2-cd54-32c1-af33-8c00decc418f', 2, NULL, '체칠리에 (Cäcilie)', 'Cäcilie, op. 27 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3675fd2-cd54-32c1-af33-8c00decc418f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:856c2d60-e097-3ed9-a7e4-5f3e4fb7ebf3', 3, NULL, '은밀한 초대 (Heimliche Aufforderung)', 'Heimliche Aufforderung, op. 27 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856c2d60-e097-3ed9-a7e4-5f3e4fb7ebf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:606a9c9b-707c-3aef-b286-fd373416162b', 4, NULL, '내일! (Morgen!)', 'Morgen!, op. 27 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:606a9c9b-707c-3aef-b286-fd373416162b'
);


-- Op. 29 3개의 가곡 Op. 29

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 가곡 Op. 29', '3 Lieder for voice and piano', 'album', NULL, 'Op.', '29', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 가곡 Op. 29'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c1c4aa0-6b31-4331-ae3e-d44e2242aaef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c1c4aa0-6b31-4331-ae3e-d44e2242aaef'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '3개의 가곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c1c4aa0-6b31-4331-ae3e-d44e2242aaef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:755dc57d-9acf-3bbd-8d31-354fbc652752', 1, NULL, 'Traum durch die Dämmerung', 'Traum durch die Dämmerung, op. 29 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '3개의 가곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:755dc57d-9acf-3bbd-8d31-354fbc652752'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:683ae2e0-1fa7-342f-8f6e-a771c72133ee', 2, NULL, 'Schlagende Herzen', 'Schlagende Herzen, op. 29 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '3개의 가곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:683ae2e0-1fa7-342f-8f6e-a771c72133ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b88203-3174-486b-8b81-2891935217f4', 3, NULL, 'Nachtgang', 'Nachtgang, op. 29 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '3개의 가곡 Op. 29' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b88203-3174-486b-8b81-2891935217f4'
);


-- Op. 31 4개의 가곡 Op. 31

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 Op. 31', '4 Lieder, op. 31', 'album', NULL, 'Op.', '31', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 Op. 31'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4668c055-b6ac-45ab-a77d-147ec121c478'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4668c055-b6ac-45ab-a77d-147ec121c478'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4668c055-b6ac-45ab-a77d-147ec121c478'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76a51d6e-8e57-4e89-a2cd-f3f3a61cd997', 1, NULL, 'Blauer Sommer', 'Blauer Sommer, op. 31 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a51d6e-8e57-4e89-a2cd-f3f3a61cd997'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fd1038f-7af5-4069-838c-372a8aa21d20', 2, NULL, 'Wenn', 'Wenn, op. 31 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fd1038f-7af5-4069-838c-372a8aa21d20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87755f74-aae6-485c-99ea-e0991ff2bb9f', 3, NULL, 'Weißer Jasmin', 'Weißer Jasmin, op. 31 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87755f74-aae6-485c-99ea-e0991ff2bb9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ebe96de-a169-3cd5-8e06-2e48eff5956b', 4, NULL, 'Stiller Gang', 'Stiller Gang, op. 31 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ebe96de-a169-3cd5-8e06-2e48eff5956b'
);


-- Op. 32 5개의 가곡 Op. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 32', '5 Lieder for voice and piano', 'album', NULL, 'Op.', '32', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98dfeafe-1295-492c-ae03-90404fd73c7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98dfeafe-1295-492c-ae03-90404fd73c7d'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98dfeafe-1295-492c-ae03-90404fd73c7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b499a058-3fd2-3d51-92cb-54579b03b747', 1, NULL, 'Ich trage meine Minne', 'Ich trage meine Minne, op. 32 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b499a058-3fd2-3d51-92cb-54579b03b747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:639dd5c7-1a9b-4b98-8ce4-85f937f55271', 2, NULL, 'Sehnsucht', 'Sehnsucht, op. 32 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:639dd5c7-1a9b-4b98-8ce4-85f937f55271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c488553f-f97c-3cf3-aa39-5b357dc679b3', 3, NULL, 'Liebeshymnus', 'Liebeshymnus, op. 32 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c488553f-f97c-3cf3-aa39-5b357dc679b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d5bd455-43a6-4df5-90c6-540670d0a7fa', 4, NULL, 'O süßer Mai', 'O süßer Mai, op. 32 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5bd455-43a6-4df5-90c6-540670d0a7fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1b863f6-5aab-4522-95e9-944bbdc9da7f', 5, NULL, 'Himmelsboten', 'Himmelsboten, op. 32 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1b863f6-5aab-4522-95e9-944bbdc9da7f'
);


-- Op. 33 목소리와 관현악을 위한 4개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리와 관현악을 위한 4개의 노래', '4 Gesänge for voice and orchestra', 'album', 'Op. 33', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리와 관현악을 위한 4개의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc83004-a104-4fb5-b0e4-74e4d07739c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8bc83004-a104-4fb5-b0e4-74e4d07739c6'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 4개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8bc83004-a104-4fb5-b0e4-74e4d07739c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:504c7e4b-d4a1-4220-8382-0cf8040bea0e', 1, NULL, 'Verführung', 'Verführung, op. 33 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 4개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:504c7e4b-d4a1-4220-8382-0cf8040bea0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d742e6b9-ecf3-3924-987e-4e0152e33c69', 2, NULL, 'Gesang der Apollopriesterin', 'Gesang der Apollopriesterin, op. 33 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 4개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d742e6b9-ecf3-3924-987e-4e0152e33c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e08c82-f505-4747-8e47-5b1bee4c3b6e', 3, NULL, 'Hymnus', 'Hymnus, op. 33 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 4개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e08c82-f505-4747-8e47-5b1bee4c3b6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7a8de2-73af-446c-9088-e20e73fe95b5', 4, NULL, 'Pilgers Morgenlied', 'Pilgers Morgenlied, op. 33 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 4개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7a8de2-73af-446c-9088-e20e73fe95b5'
);


-- Op. 36 4개의 가곡 Op. 36

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡 Op. 36', '4 Lieder for voice and piano', 'album', NULL, 'Op.', '36', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡 Op. 36'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fddd394-1ff2-45d5-8d03-4584eac67913'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5fddd394-1ff2-45d5-8d03-4584eac67913'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fddd394-1ff2-45d5-8d03-4584eac67913'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:249f8cd5-4e77-3856-98b7-12258c4bcef3', 1, NULL, 'Das Rosenband', 'Das Rosenband, op. 36 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:249f8cd5-4e77-3856-98b7-12258c4bcef3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:654664ea-1214-484c-99ee-4ee24fe8e1d1', 2, NULL, 'Für fünfzehn Pfennige', 'Für fünfzehn Pfennige, op. 36 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:654664ea-1214-484c-99ee-4ee24fe8e1d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fa4efcc-b61c-3eda-bcf8-73c7de902de8', 3, NULL, 'Hat gesagt, bleibt''s nicht dabei', 'Hat gesagt, bleibt''s nicht dabei, op. 36 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fa4efcc-b61c-3eda-bcf8-73c7de902de8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef671ca4-fa07-4197-b141-6d8192f194ba', 4, NULL, 'Anbetung', 'Anbetung, op. 36 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '4개의 가곡 Op. 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef671ca4-fa07-4197-b141-6d8192f194ba'
);


-- Op. 37 6개의 가곡 Op. 37

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 37', '6 Lieder for voice and piano', 'album', NULL, 'Op.', '37', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 37'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566d3434-8321-42ad-beaf-5f4966a326b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '566d3434-8321-42ad-beaf-5f4966a326b5'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566d3434-8321-42ad-beaf-5f4966a326b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac4cbc3-08b2-4e5c-aa4f-3c8c9aedb935', 1, NULL, 'Glückes genug', 'Glückes genug, op. 37 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac4cbc3-08b2-4e5c-aa4f-3c8c9aedb935'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:290e76fe-84f2-46f8-b6fe-97d0bdef71bf', 2, NULL, 'Ich liebe dich', 'Ich liebe dich, op. 37 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:290e76fe-84f2-46f8-b6fe-97d0bdef71bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a642b120-f819-372a-b788-69737c55cdef', 3, NULL, 'Meinem Kinde', 'Meinem Kinde, op. 37 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a642b120-f819-372a-b788-69737c55cdef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:224781d6-4f59-39d9-ad92-d68d37fd43a5', 4, NULL, 'Du bist mein Auge', 'Du bist mein Auge, op. 37 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224781d6-4f59-39d9-ad92-d68d37fd43a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79e100bf-a97d-4c98-9109-5f4f1b36d1ea', 5, NULL, 'Herr Lenz', 'Herr Lenz, op. 37 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79e100bf-a97d-4c98-9109-5f4f1b36d1ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a3eab54-9238-4401-b4e5-8aad2ba09780', 6, NULL, 'Hochzeitlich Lied', 'Hochzeitlich Lied, op. 37 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 37' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3eab54-9238-4401-b4e5-8aad2ba09780'
);


-- Op. 39 5개의 가곡 Op. 39

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 39', '5 Lieder for voice and piano', 'album', NULL, 'Op.', '39', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 39'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5593a6f2-1f85-4682-b305-ddd9be624207'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5593a6f2-1f85-4682-b305-ddd9be624207'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5593a6f2-1f85-4682-b305-ddd9be624207'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fed4f97-70ad-4d50-ad06-a90c06c844eb', 1, NULL, 'Leises Lied', 'Leises Lied, op. 39 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fed4f97-70ad-4d50-ad06-a90c06c844eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a919bfb3-4dc9-4862-8223-ee6029a71bcb', 2, NULL, 'Junghexenlied', 'Junghexenlied, op. 39 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a919bfb3-4dc9-4862-8223-ee6029a71bcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:956c5d90-0975-457e-bc24-a693feb52e85', 3, NULL, 'Der Arbeitsmann', 'Der Arbeitsmann, op. 39 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:956c5d90-0975-457e-bc24-a693feb52e85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0965f193-6d79-354d-99c5-f295aa223860', 4, NULL, 'Befreit', 'Befreit, op. 39 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0965f193-6d79-354d-99c5-f295aa223860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc8730a-f46d-4a79-9405-9ff617d66074', 5, NULL, 'Lied an meinen Sohn', 'Lied an meinen Sohn, op. 39 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc8730a-f46d-4a79-9405-9ff617d66074'
);


-- Op. 41 5개의 가곡 Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 41', '5 Lieder for voice and piano', 'album', NULL, 'Op.', '41', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 41'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5aeb858f-e26c-4361-a535-b41ae9365cc8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5aeb858f-e26c-4361-a535-b41ae9365cc8'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5aeb858f-e26c-4361-a535-b41ae9365cc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e333a1b2-8ee2-3919-9c2c-723761f14892', 1, NULL, '자장가 (Wiegenlied)', 'Wiegenlied, op. 41 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e333a1b2-8ee2-3919-9c2c-723761f14892'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68f1e17e-2f1f-4804-b848-26fa5e04f915', 2, NULL, 'In der Campagna', 'In der Campagna, op. 41 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68f1e17e-2f1f-4804-b848-26fa5e04f915'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7bf2331-f9cf-45be-afb2-7244d1f7b5c5', 3, NULL, 'Am Ufer', 'Am Ufer, op. 41 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7bf2331-f9cf-45be-afb2-7244d1f7b5c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f2f5d4-05e2-43c4-bee3-ec5603a1ef71', 4, NULL, 'Bruder Liederlich', 'Bruder Liederlich, op. 41 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f2f5d4-05e2-43c4-bee3-ec5603a1ef71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20edaf31-1100-41c8-89da-153be97b9fc9', 5, NULL, 'Leise Lieder', 'Leise Lieder, op. 41 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20edaf31-1100-41c8-89da-153be97b9fc9'
);


-- Op. 43 옛 독일 시인들의 시에 의한 3개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '옛 독일 시인들의 시에 의한 3개의 노래', 'Gesänge älterer deutscher Dichter, for voice and piano', 'album', 'Op. 43', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '옛 독일 시인들의 시에 의한 3개의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f16574e-8f56-4d97-811c-21f2202cdc3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f16574e-8f56-4d97-811c-21f2202cdc3b'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '옛 독일 시인들의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f16574e-8f56-4d97-811c-21f2202cdc3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84d7663c-b0d9-4f22-8b9d-ac811f2cd0fd', 1, NULL, 'An Sie', 'An Sie, op. 43 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '옛 독일 시인들의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84d7663c-b0d9-4f22-8b9d-ac811f2cd0fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:811c1274-545c-4cd3-ba18-29a7a5934756', 2, NULL, 'Muttertändelei', 'Muttertändelei, op. 43 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '옛 독일 시인들의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:811c1274-545c-4cd3-ba18-29a7a5934756'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbe8f5cd-6284-47d9-b15d-cd788cb7a922', 3, NULL, 'Die Ulme zu Hirsau', 'Die Ulme zu Hirsau, op. 43 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '옛 독일 시인들의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbe8f5cd-6284-47d9-b15d-cd788cb7a922'
);


-- Op. 44 목소리와 관현악을 위한 2개의 큰 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리와 관현악을 위한 2개의 큰 노래', '2 Größere Gesänge', 'album', 'Op. 44', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리와 관현악을 위한 2개의 큰 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83fda295-f653-4a8c-b36e-d77a0c66a914'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83fda295-f653-4a8c-b36e-d77a0c66a914'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 2개의 큰 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83fda295-f653-4a8c-b36e-d77a0c66a914'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd1c5033-5db7-4e55-81a1-f33f85b791c9', 1, NULL, 'Notturno', '2 Größere Gesänge: 1. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 2개의 큰 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd1c5033-5db7-4e55-81a1-f33f85b791c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56125297-1f9a-4440-bb6e-9eb9dafa4859', 2, NULL, 'Nächtlicher Gang', '2 Größere Gesänge: 2. Nächtlicher Gang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 2개의 큰 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56125297-1f9a-4440-bb6e-9eb9dafa4859'
);


-- Op. 46 5개의 가곡 Op. 46

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 46', '5 Gedichte', 'album', NULL, 'Op.', '46', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 46'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3c46ba1-980f-4914-bb47-162705c327cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3c46ba1-980f-4914-bb47-162705c327cf'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3c46ba1-980f-4914-bb47-162705c327cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e549649-241c-4187-8e9c-099d16bed274', 1, NULL, 'Ein Obdach gegen Sturm und Regen', 'Ein Obdach gegen Sturm und Regen, op. 46 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e549649-241c-4187-8e9c-099d16bed274'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2292ebe2-55c6-4b2a-9f6e-314a8202cc43', 2, NULL, 'Gestern war ich Atlas', 'Gestern war ich Atlas, op. 46 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2292ebe2-55c6-4b2a-9f6e-314a8202cc43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67ab0995-ceba-4b78-96a0-1ce25792154b', 3, NULL, 'Die sieben Siegel', 'Die sieben Siegel, op. 46 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67ab0995-ceba-4b78-96a0-1ce25792154b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f801b696-f968-4af4-bd38-ae11bf19aba6', 4, NULL, 'Morgenrot', 'Morgenrot, op. 46 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f801b696-f968-4af4-bd38-ae11bf19aba6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76ea9b0f-0e01-4b2a-9bec-41e8ff85091b', 5, NULL, 'Ich sehe wie in einem Spiegel', 'Ich sehe wie in einem Spiegel, op. 46 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76ea9b0f-0e01-4b2a-9bec-41e8ff85091b'
);


-- Op. 47 5개의 가곡 Op. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 47', '5 Lieder for voice and piano', 'album', NULL, 'Op.', '47', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 47'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b32a2083-e6f9-48bd-919e-df352ad3602a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b32a2083-e6f9-48bd-919e-df352ad3602a'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b32a2083-e6f9-48bd-919e-df352ad3602a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dc83bb2-5a94-40db-8373-4baf82a2a7ee', 1, NULL, 'Auf ein Kind', 'Auf ein Kind, op. 47 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc83bb2-5a94-40db-8373-4baf82a2a7ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c05eb2a-db90-3a9e-85c9-950a205164e5', 2, NULL, 'Des Dichters Abendgang', 'Des Dichters Abendgang, op. 47 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c05eb2a-db90-3a9e-85c9-950a205164e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a533e486-ab1c-4921-8dfc-d1a56b455c04', 3, NULL, 'Rückleben', 'Rückleben, op. 47 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a533e486-ab1c-4921-8dfc-d1a56b455c04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29030a96-29fb-4b0a-b51e-a6efe111dd92', 4, NULL, 'Einkehr', 'Einkehr, op. 47 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29030a96-29fb-4b0a-b51e-a6efe111dd92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cec4ec00-deba-4b91-b0b4-c05263d27ef2', 5, NULL, 'Von den sieben Zechbrüdern', 'Von den sieben Zechbrüdern, op. 47 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec4ec00-deba-4b91-b0b4-c05263d27ef2'
);


-- Op. 48 5개의 가곡 Op. 48

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡 Op. 48', '5 Lieder for voice and piano', 'album', NULL, 'Op.', '48', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡 Op. 48'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77ccb657-6650-4f83-b143-682dfb1b181f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77ccb657-6650-4f83-b143-682dfb1b181f'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77ccb657-6650-4f83-b143-682dfb1b181f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c96b6c-e5af-3116-87be-350c03878c30', 1, NULL, 'Freundliche Vision', 'Freundliche Vision, op. 48 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c96b6c-e5af-3116-87be-350c03878c30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7035f0-3b9d-3268-92c9-3627f225368a', 2, NULL, 'Ich schwebe', 'Ich schwebe, op. 48 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7035f0-3b9d-3268-92c9-3627f225368a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b56a284f-90ad-3cfe-b72a-6dfc60685658', 3, NULL, 'Kling!', 'Kling!, op. 48 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b56a284f-90ad-3cfe-b72a-6dfc60685658'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cf32c0e-8259-32cc-80b5-372e2443bf54', 4, NULL, 'Winterweihe', 'Winterweihe, op. 48 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cf32c0e-8259-32cc-80b5-372e2443bf54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96df4798-e7fa-47b1-a756-b6f267658882', 5, NULL, 'Winterliebe', 'Winterliebe, op. 48 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96df4798-e7fa-47b1-a756-b6f267658882'
);


-- Op. 49 8개의 가곡 Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 가곡 Op. 49', '8 Lieder for voice and piano', 'album', NULL, 'Op.', '49', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 가곡 Op. 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7a84d65-d28b-467d-a85b-7da766e7857a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7a84d65-d28b-467d-a85b-7da766e7857a'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7a84d65-d28b-467d-a85b-7da766e7857a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2f15b4d-5afc-34d2-b492-dd6636e091a6', 1, NULL, 'Waldseligkeit', 'Waldseligkeit, op. 49 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2f15b4d-5afc-34d2-b492-dd6636e091a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece56e0e-d320-411b-b082-cc5b61535728', 2, NULL, 'In goldener Fülle', 'In goldener Fülle, op. 49 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece56e0e-d320-411b-b082-cc5b61535728'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2715c72-fd20-39a4-848d-45af5638f5b7', 3, NULL, 'Wiegenliedchen', 'Wiegenliedchen, op. 49 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2715c72-fd20-39a4-848d-45af5638f5b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0e08bd6-8bf5-4698-b756-ca9a7ee93048', 4, NULL, 'Das Lied des Steinklopfers', 'Das Lied des Steinklopfers, op. 49 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0e08bd6-8bf5-4698-b756-ca9a7ee93048'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d9904c-3de5-4134-ae73-1d6e1f1ed2a2', 5, NULL, 'Sie wissen’s nicht', 'Sie wissen’s nicht, op. 49 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d9904c-3de5-4134-ae73-1d6e1f1ed2a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6a0c7ca-8d58-4ad7-9bb0-cc1ea32be7b4', 6, NULL, 'Junggesellenschwur', 'Junggesellenschwur, op. 49 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6a0c7ca-8d58-4ad7-9bb0-cc1ea32be7b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c6ffa37-4871-48dd-9621-33794e384fb8', 7, NULL, 'Wer lieben will, muß leiden', 'Wer lieben will, muß leiden, op. 49 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c6ffa37-4871-48dd-9621-33794e384fb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1f664f2-360a-4c7d-b02d-59051bde57a4', 8, NULL, 'Ach, was Kummer, Qual und Schmerzen', 'Ach, was Kummer, Qual und Schmerzen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '8개의 가곡 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1f664f2-360a-4c7d-b02d-59051bde57a4'
);


-- Op. 56 6개의 가곡 Op. 56

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 56', '6 Lieder for voice and piano', 'album', NULL, 'Op.', '56', NULL, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 56'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24aaeae9-e697-49ee-bd8f-0076ae6a4720'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24aaeae9-e697-49ee-bd8f-0076ae6a4720'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24aaeae9-e697-49ee-bd8f-0076ae6a4720'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bfac281-e67b-47c8-be09-081cc4fc244c', 1, NULL, 'Gefunden', 'Gefunden, op. 56 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bfac281-e67b-47c8-be09-081cc4fc244c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e259503-9f59-4100-861b-81cfe511cc82', 2, NULL, 'Blindenklage', 'Blindenklage, op. 56 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e259503-9f59-4100-861b-81cfe511cc82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:550826db-850e-403d-9b92-eba37e2446c6', 3, NULL, 'Im Spätboot', 'Im Spätboot, op. 56 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:550826db-850e-403d-9b92-eba37e2446c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f06cf2-78ad-37d2-81f5-1e7518d38b27', 4, NULL, 'Mit deinen blauen Augen', 'Mit deinen blauen Augen, op. 56 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f06cf2-78ad-37d2-81f5-1e7518d38b27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40381af9-8f87-3223-be23-04304fa2cd53', 5, NULL, 'Frühlingsfeier', 'Frühlingsfeier, op. 56 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40381af9-8f87-3223-be23-04304fa2cd53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72c56a4e-b2f7-4c72-b642-58c85b646054', 6, NULL, 'Die heiligen drei Könige aus Morgenland', 'Die heiligen drei Könige aus Morgenland, op. 56 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72c56a4e-b2f7-4c72-b642-58c85b646054'
);


-- Op. 66 연가곡집 <상인의 거울>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <상인의 거울>', 'Krämerspiegel', 'album', 'Op. 66', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <상인의 거울>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f137233c-6fa4-43ed-b6da-4f18a17ce9d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f137233c-6fa4-43ed-b6da-4f18a17ce9d5'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f137233c-6fa4-43ed-b6da-4f18a17ce9d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c40583a0-f30a-4113-81a1-97cc6b22b23a', 1, NULL, 'Es war einmal ein Bock', 'Krämerspiegel, op. 66: No. 1. Es war einmal ein Bock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c40583a0-f30a-4113-81a1-97cc6b22b23a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e114db4-6332-431e-be06-35b2b22aed13', 2, NULL, 'Einst kam der Bock als Bote', 'Krämerspiegel, op. 66: No. 2. Einst kam der Bock als Bote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e114db4-6332-431e-be06-35b2b22aed13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25031c18-04a3-4fe0-9eb3-027f7a7058dd', 3, NULL, 'Es liebte einst ein Hase', 'Krämerspiegel, op. 66: No. 3. Es liebte einst ein Hase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25031c18-04a3-4fe0-9eb3-027f7a7058dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e9994bc-98d2-4374-b5b0-d1c5c5521302', 4, NULL, 'Drei Masken sah ich am Himmel stehn', 'Krämerspiegel, op. 66: No. 4. Drei Masken sah ich am Himmel stehn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9994bc-98d2-4374-b5b0-d1c5c5521302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba732840-79cf-48f5-a209-2bfa5582af0d', 5, NULL, 'Hast du ein Tongedicht vollbracht', 'Krämerspiegel, op. 66: No. 5. Hast du ein Tongedicht vollbracht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba732840-79cf-48f5-a209-2bfa5582af0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e01f926-3c20-44d4-9b42-07d1943e3533', 6, NULL, 'O lieber Künstler sei ermahnt', 'Krämerspiegel, op. 66: No. 6. O lieber Künstler sei ermahnt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e01f926-3c20-44d4-9b42-07d1943e3533'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7abba7a4-d7e9-48d1-a3ae-ac450a023e68', 7, NULL, 'Unser Feind ist, grosser Gott', 'Krämerspiegel, op. 66: No. 7. Unser Feind ist, grosser Gott', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7abba7a4-d7e9-48d1-a3ae-ac450a023e68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26935ca9-333c-42b8-8a3e-2bf29b89b21f', 8, NULL, 'Von Händlern wird die Kunst bedroht', 'Krämerspiegel, op. 66: No. 8. Von Händlern wird die Kunst bedroht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26935ca9-333c-42b8-8a3e-2bf29b89b21f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6ab7264-9a51-48ff-acda-b413bb8b2cf2', 9, NULL, 'Es war mal eine Wanze', 'Krämerspiegel, op. 66: No. 9. Es war mal eine Wanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ab7264-9a51-48ff-acda-b413bb8b2cf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0077c9e3-46f5-4b98-ac54-b09ac0d9f8c9', 10, NULL, 'Die Künstler sind die Schöpfer', 'Krämerspiegel, op. 66: No. 10. Die Künstler sind die Schöpfer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0077c9e3-46f5-4b98-ac54-b09ac0d9f8c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64654719-c16b-4776-8aed-465a95f50d2c', 11, NULL, 'Die Händler und die Macher', 'Krämerspiegel, op. 66: No. 11. Die Händler und die Macher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64654719-c16b-4776-8aed-465a95f50d2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e82aa6-9cd1-484f-b1f5-7874f66e6bd1', 12, NULL, 'O Schröpferschwarm, o Händlerkreis', 'Krämerspiegel, op. 66: No. 12. O Schröpferschwarm, o Händlerkreis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '연가곡집 <상인의 거울>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e82aa6-9cd1-484f-b1f5-7874f66e6bd1'
);


-- Op. 67 6개의 가곡 Op. 67

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 67', '6 Lieder', 'album', NULL, 'Op.', '67', 1918, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 67'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b886a99a-76c1-4240-a7ea-c049e1e22953'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b886a99a-76c1-4240-a7ea-c049e1e22953'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b886a99a-76c1-4240-a7ea-c049e1e22953'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090ccbb3-e9af-383f-b8fa-d99a243f1ec1', 1, NULL, 'Wie erkenn'' ich mei Traulieb?', 'Ophelia-Lieder, op. 67 no. 1: Three songs after William Shakespeare: "Wie erkenn'' ich mei Traulieb?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090ccbb3-e9af-383f-b8fa-d99a243f1ec1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3491d1-b2a6-358a-97e5-d544bda9fda0', 2, NULL, 'Guten Morgen, ''s ist Sankt Valentinstag', 'Ophelia-Lieder, op. 67 no. 2: Three songs after William Shakespeare: "Guten Morgen, ''s ist Sankt Valentinstag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3491d1-b2a6-358a-97e5-d544bda9fda0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03529692-2c80-3a21-9fbb-3a5a9a1dd35a', 3, NULL, 'Sie trugen ihn auf der Bahre bloß', 'Ophelia-Lieder, op. 67 no. 3: Three songs after William Shakespeare: "Sie trugen ihn auf der Bahre bloß"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03529692-2c80-3a21-9fbb-3a5a9a1dd35a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b82b0fb7-b928-4f0e-b071-c503405388b6', 4, NULL, 'Wer wird von der Welt verlangen', 'Wer wird von der Welt verlangen, op. 67 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b82b0fb7-b928-4f0e-b071-c503405388b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87ca3803-3678-41dd-a2a5-0cb014423432', 5, NULL, 'Hab’ ich euch denn je geraten', 'Hab’ ich euch denn je geraten, op. 67 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87ca3803-3678-41dd-a2a5-0cb014423432'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc9f9356-bdac-492f-a7c1-b381d7b6fbc6', 6, NULL, 'Wanderers Gemütsruhe', 'Wanderers Gemütsruhe, op. 67 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '6개의 가곡 Op. 67' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9f9356-bdac-492f-a7c1-b381d7b6fbc6'
);


-- Op. 68 브렌타노의 시에 의한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '브렌타노의 시에 의한 6개의 가곡', '6 Lieder nach Gedichten von Clemens Brentano', 'album', 'Op. 68', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '브렌타노의 시에 의한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4eb6a19d-ee65-4353-b639-4956ebd9e213'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4eb6a19d-ee65-4353-b639-4956ebd9e213'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4eb6a19d-ee65-4353-b639-4956ebd9e213'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28fb4d9f-04df-3f3f-ac10-2712ae61589e', 1, NULL, 'An die Nacht', 'An die Nacht, op. 68 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28fb4d9f-04df-3f3f-ac10-2712ae61589e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1e90616-caa2-3bc4-99ad-32f1af3def96', 2, NULL, 'Ich wollt ein Sträußlein binden', 'Ich wollt ein Sträußlein binden, op. 68 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1e90616-caa2-3bc4-99ad-32f1af3def96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13921912-4fb0-3a75-92a3-f5ff08425d4d', 3, NULL, 'Säusle, liebe Myrte', 'Säusle, liebe Myrte, op. 68 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13921912-4fb0-3a75-92a3-f5ff08425d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af573ce6-430b-3653-bdc2-b2494b0e3dc4', 4, NULL, 'Als mir Dein Lied erklang', 'Als mir Dein Lied erklang, op. 68 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af573ce6-430b-3653-bdc2-b2494b0e3dc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8af8f9d7-bde3-3470-918f-a8aec157348a', 5, NULL, 'Amor', 'Amor, op. 68 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8af8f9d7-bde3-3470-918f-a8aec157348a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad3f3611-6b5b-3525-8c7e-26e8130c489c', 6, NULL, 'Lied der Frauen', 'Lied der Frauen, op. 68 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '브렌타노의 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3f3611-6b5b-3525-8c7e-26e8130c489c'
);


-- Op. 69 5개의 작은 가곡 Op. 69

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 작은 가곡 Op. 69', '5 Kleine Lieder', 'album', NULL, 'Op.', '69', 1918, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 작은 가곡 Op. 69'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '422fce97-46b3-4222-a239-da71fdd09f9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '422fce97-46b3-4222-a239-da71fdd09f9c'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '422fce97-46b3-4222-a239-da71fdd09f9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450c7f47-5562-4de4-a41e-f646ff2c1c31', 1, NULL, 'Der Stern', 'Der Stern, op. 69 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450c7f47-5562-4de4-a41e-f646ff2c1c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a65b0a-b292-4963-ae41-376bf15dcaa6', 2, NULL, 'Der Pokal', 'Der Pokal, op. 69 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a65b0a-b292-4963-ae41-376bf15dcaa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc174eb-2c60-385a-a2df-4124af787577', 3, NULL, 'Einerlei', 'Einerlei, op. 69 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc174eb-2c60-385a-a2df-4124af787577'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bc4f33c-f4cd-4039-97bd-4658b78f530c', 4, NULL, 'Waldesfahrt', 'Waldesfahrt, op. 69 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bc4f33c-f4cd-4039-97bd-4658b78f530c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db6440a9-6097-3a2f-ac0b-4980cce26fb2', 5, NULL, 'Schlechtes Wetter', 'Schlechtes Wetter, op. 69 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '5개의 작은 가곡 Op. 69' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db6440a9-6097-3a2f-ac0b-4980cce26fb2'
);


-- Op. 71 목소리와 관현악을 위한 3개의 찬가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리와 관현악을 위한 3개의 찬가', 'Drei Hymnen', 'album', 'Op. 71', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리와 관현악을 위한 3개의 찬가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46287a23-471c-4048-9f9f-a57f71fbe773'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46287a23-471c-4048-9f9f-a57f71fbe773'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 3개의 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46287a23-471c-4048-9f9f-a57f71fbe773'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e61d9ff-98df-4e6b-b8ca-7ccb1a94ab27', 1, 'I', 'Hymne an die Liebe', 'Drei Hymnen, op. 71: I. Hymne an die Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 3개의 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e61d9ff-98df-4e6b-b8ca-7ccb1a94ab27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd9de80d-bd27-41fb-a50f-50f06db5e5bc', 2, 'II', 'Rückkehr in die Heimat', 'Drei Hymnen, op. 71: II. Rückkehr in die Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 3개의 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd9de80d-bd27-41fb-a50f-50f06db5e5bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ca6f5c7-a3d9-4721-bb6b-e531d9996a1d', 3, 'III', 'Die Liebe', 'Drei Hymnen, op. 71: III. Die Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '목소리와 관현악을 위한 3개의 찬가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ca6f5c7-a3d9-4721-bb6b-e531d9996a1d'
);


-- Op. 77 <동방의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<동방의 노래>', 'Gesänge des Orients, op. 77', 'album', 'Op. 77', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<동방의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0ce2820-2636-47a8-9df1-a6eed46b749b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c0ce2820-2636-47a8-9df1-a6eed46b749b'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c0ce2820-2636-47a8-9df1-a6eed46b749b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96657ac4-e253-4bce-9d56-0c4b44731ddb', 1, NULL, 'Ihre Augen', 'Ihre Augen, op. 77 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96657ac4-e253-4bce-9d56-0c4b44731ddb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ae3687b-649a-4792-9d64-21d2a57d7733', 2, NULL, 'Schwung', 'Schwung, op. 77 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ae3687b-649a-4792-9d64-21d2a57d7733'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e11cf0-55d0-45e0-8083-a83c65c5835b', 3, NULL, 'Liebesgeschenke', 'Liebesgeschenke, op. 77 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e11cf0-55d0-45e0-8083-a83c65c5835b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b648ec1c-fecd-4ca6-8d37-69caed6b392f', 4, NULL, 'Die Allmächtige', 'Die Allmächtige, op. 77 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b648ec1c-fecd-4ca6-8d37-69caed6b392f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803311ce-f0ac-40ed-a70a-eccf94ec3750', 5, NULL, 'Huldigung', 'Huldigung, op. 77 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<동방의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803311ce-f0ac-40ed-a70a-eccf94ec3750'
);


-- Op. 62 <독일 모테트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<독일 모테트>', 'Deutsche Motette', 'song', 'Op. 62', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<독일 모테트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c71449d9-56cb-4b54-a709-14c481368550'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c71449d9-56cb-4b54-a709-14c481368550'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '<독일 모테트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c71449d9-56cb-4b54-a709-14c481368550'
);


-- Op. 34 무반주 합창을 위한 2개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 합창을 위한 2개의 노래', '2 Gesänge', 'album', 'Op. 34', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 합창을 위한 2개의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c16709d-2f44-447f-bc65-8e3a28d276c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c16709d-2f44-447f-bc65-8e3a28d276c7'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '무반주 합창을 위한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c16709d-2f44-447f-bc65-8e3a28d276c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b12b699e-bbea-4485-b6d0-7bd9a71ab1ce', 1, NULL, 'Der Abend', 'Der Abend, op. 34 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '무반주 합창을 위한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b12b699e-bbea-4485-b6d0-7bd9a71ab1ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82054b2e-ff9f-43ae-90f2-a0d55fa3bf21', 2, NULL, 'Hymne', 'Hymne, op. 34 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '무반주 합창을 위한 2개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82054b2e-ff9f-43ae-90f2-a0d55fa3bf21'
);


-- Op. 14 합창과 관현악을 위한 <방랑자의 폭풍의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 관현악을 위한 <방랑자의 폭풍의 노래>', 'Wandrers Sturmlied', 'song', 'Op. 14', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 관현악을 위한 <방랑자의 폭풍의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31957245-c44f-42dc-a274-40ad03934b6b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31957245-c44f-42dc-a274-40ad03934b6b'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '합창과 관현악을 위한 <방랑자의 폭풍의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31957245-c44f-42dc-a274-40ad03934b6b'
);


-- Op. 52 합창과 관현악을 위한 발라드 <타유페르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 관현악을 위한 발라드 <타유페르>', 'Taillefer, ballad for soprano, tenor, baritone, chorus and orchestra', 'song', 'Op. 52', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 관현악을 위한 발라드 <타유페르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd71a6a9c-142c-4e79-9e68-7543cef83d6a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd71a6a9c-142c-4e79-9e68-7543cef83d6a'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '합창과 관현악을 위한 발라드 <타유페르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd71a6a9c-142c-4e79-9e68-7543cef83d6a'
);


-- Op. 76 남성 합창과 관현악을 위한 <하루의 때>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창과 관현악을 위한 <하루의 때>', 'Die Tageszeiten', 'album', 'Op. 76', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 498
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창과 관현악을 위한 <하루의 때>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14abde4c-9dba-4930-b7a3-17366e0a0e7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14abde4c-9dba-4930-b7a3-17366e0a0e7d'
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '남성 합창과 관현악을 위한 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14abde4c-9dba-4930-b7a3-17366e0a0e7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3679565-540a-4f6b-a8b6-0cc3dd8a9963', 1, 'I', 'Der Morgen', 'Die Tageszeiten: I. Der Morgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '남성 합창과 관현악을 위한 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3679565-540a-4f6b-a8b6-0cc3dd8a9963'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12966da4-cd85-45d5-9b77-368270025801', 2, 'II', 'Mittagsruh', 'Die Tageszeiten: II. Mittagsruh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '남성 합창과 관현악을 위한 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12966da4-cd85-45d5-9b77-368270025801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:887b092c-1927-4b77-a6ed-419e6ea66f3c', 3, 'III', 'Der Abend', 'Die Tageszeiten: III. Der Abend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '남성 합창과 관현악을 위한 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:887b092c-1927-4b77-a6ed-419e6ea66f3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e98981e1-cea5-408f-876e-46d26f1d2e12', 4, 'IV', '밤 (Die Nacht)', 'Die Tageszeiten: IV. Die Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 498 AND p.title = '남성 합창과 관현악을 위한 <하루의 때>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e98981e1-cea5-408f-876e-46d26f1d2e12'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향적 환상곡 <이탈리아에서>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <돈 후안>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <맥베스>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <죽음과 변용>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <틸 오일렌슈피겔의 유쾌한 장난>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <돈키호테>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '교향시 <영웅의 생애>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '<가정 교향곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 498 AND title = '<알프스 교향곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 498 AND title = '23대의 독주 현악기를 위한 <메타모르포젠>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 498 AND title = '<축전 전주곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 498 AND title = '<일본 축전 음악>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 498 AND title = '모음곡 <서민 귀족>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'serenade'
WHERE composer_id = 498 AND title = '13대의 관악기를 위한 세레나데 E♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'serenade'
WHERE composer_id = 498 AND title = '13대의 관악기를 위한 모음곡 B♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'serenade'
WHERE composer_id = 498 AND title = '관악 소나티네 1번 F장조 "병자의 작업실에서"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'serenade'
WHERE composer_id = 498 AND title = '관악 소나티네 2번 E♭장조 "즐거운 작업실"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 498 AND title = '쿠프랭의 건반 작품에 의한 디베르티멘토' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 498 AND title = '쿠프랭의 건반 작품에 의한 무곡 모음곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'dance_march'
WHERE composer_id = 498 AND title = '2개의 군대 행진곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 498 AND title = '교향곡 1번 D단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 498 AND title = '교향곡 2번 F단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 498 AND title = '바이올린 협주곡 D단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 498 AND title = '호른 협주곡 1번 E♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 498 AND title = '호른 협주곡 2번 E♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 498 AND title = '오보에 협주곡 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE composer_id = 498 AND title = '피아노와 관현악을 위한 부를레스케 D단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 498 AND title = '클라리넷과 바순을 위한 이중 콘체르티노' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE composer_id = 498 AND title = '왼손 피아노와 관현악을 위한 <판아테나이아 행렬>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE composer_id = 498 AND title = '첼로와 관현악을 위한 로망스 F장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 498 AND title = '현악 4중주 A장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 498 AND title = '첼로 소나타 F장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'piano_chamber'
WHERE composer_id = 498 AND title = '피아노 4중주 C단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 498 AND title = '바이올린 소나타 E♭장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'piano_chamber'
WHERE composer_id = 498 AND title = '피아노 3중주 1번 A장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'piano_chamber'
WHERE composer_id = 498 AND title = '피아노 3중주 2번 D장조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'sonata'
WHERE composer_id = 498 AND title = '피아노 소나타 B단조' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 498 AND title = '5개의 피아노 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 498 AND title = '<분위기 그림>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <군트람>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <포이어스노트>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <살로메>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <엘렉트라>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <장미의 기사>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <낙소스섬의 아리아드네>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <그림자 없는 여인>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <인테르메초>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <이집트의 헬레나>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <아라벨라>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <말 없는 여인>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <평화의 날>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <다프네>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <다나에의 사랑>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 498 AND title = '오페라 <카프리치오>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'ballet'
WHERE composer_id = 498 AND title = '발레 <요셉의 전설>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'ballet'
WHERE composer_id = 498 AND title = '발레 <휘핑크림>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 498 AND title = '멜로드라마 <이녹 아든>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '연가곡집 <네 개의 마지막 노래>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '<마지막 잎새>에 의한 8개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 15' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '6개의 가곡 Op. 17' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '<연꽃잎>에 의한 6개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '<소박한 노래> 5개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '<소녀의 꽃> 4개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '2개의 가곡 Op. 26' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '4개의 가곡 Op. 27' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '3개의 가곡 Op. 29' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '4개의 가곡 Op. 31' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 32' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '목소리와 관현악을 위한 4개의 노래' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '4개의 가곡 Op. 36' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '6개의 가곡 Op. 37' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 39' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 41' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '옛 독일 시인들의 시에 의한 3개의 노래' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '목소리와 관현악을 위한 2개의 큰 노래' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 46' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 47' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 가곡 Op. 48' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '8개의 가곡 Op. 49' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '6개의 가곡 Op. 56' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '연가곡집 <상인의 거울>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '6개의 가곡 Op. 67' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '브렌타노의 시에 의한 6개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '5개의 작은 가곡 Op. 69' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '목소리와 관현악을 위한 3개의 찬가' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 498 AND title = '<동방의 노래>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 498 AND title = '<독일 모테트>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 498 AND title = '무반주 합창을 위한 2개의 노래' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 498 AND title = '합창과 관현악을 위한 <방랑자의 폭풍의 노래>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 498 AND title = '합창과 관현악을 위한 발라드 <타유페르>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 498 AND title = '남성 합창과 관현악을 위한 <하루의 때>' AND genre IS NULL AND form_key IS NULL;
