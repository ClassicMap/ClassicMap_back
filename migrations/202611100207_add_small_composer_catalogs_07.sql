-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 7/9).
-- 작품 93개(새 7개), seed 96개 중 잇기 86·숨김 4·그대로 6.
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

-- ===== Mark O'Connor (composer_id 385) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 18개(묶음 0, 다악장 7, 낱곡 11),
-- 새 작품 0개, part 39개, 그 아래 0개.
-- seed 19개 중 18개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Americana Symphony

UPDATE pieces piece
SET piece.title = 'Americana Symphony', piece.title_en = 'Americana Symphony',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24424 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Brass Fanfare: Wide Open Spaces', part.name_en = 'Americana Symphony: I. Brass Fanfare: Wide Open Spaces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:8cfddefc-ffec-47c2-8048-adb5910e2e5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cfddefc-ffec-47c2-8048-adb5910e2e5e', 1, 'I', 'Brass Fanfare: Wide Open Spaces', 'Americana Symphony: I. Brass Fanfare: Wide Open Spaces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfddefc-ffec-47c2-8048-adb5910e2e5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'New World Fanciful Dance', part.name_en = 'Americana Symphony: II. New World Fanciful Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:8134e929-bebd-4183-aba1-3d33e81bbfa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8134e929-bebd-4183-aba1-3d33e81bbfa7', 2, 'II', 'New World Fanciful Dance', 'Americana Symphony: II. New World Fanciful Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8134e929-bebd-4183-aba1-3d33e81bbfa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Different Paths Towards Home', part.name_en = 'Americana Symphony: III. Different Paths Towards Home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:3900925a-fcec-4544-883a-b6f3c7072a26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3900925a-fcec-4544-883a-b6f3c7072a26', 3, 'III', 'Different Paths Towards Home', 'Americana Symphony: III. Different Paths Towards Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3900925a-fcec-4544-883a-b6f3c7072a26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Open Plains Hoedown', part.name_en = 'Americana Symphony: IV. Open Plains Hoedown',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:6aa32430-6cfc-4874-a565-97a3d9d27901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aa32430-6cfc-4874-a565-97a3d9d27901', 4, 'IV', 'Open Plains Hoedown', 'Americana Symphony: IV. Open Plains Hoedown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aa32430-6cfc-4874-a565-97a3d9d27901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Soaring Eagle, Setting Sun', part.name_en = 'Americana Symphony: V. Soaring Eagle, Setting Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:8d3c32f6-2021-4c1a-9096-769a4b9cfdf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d3c32f6-2021-4c1a-9096-769a4b9cfdf2', 5, 'V', 'Soaring Eagle, Setting Sun', 'Americana Symphony: V. Soaring Eagle, Setting Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d3c32f6-2021-4c1a-9096-769a4b9cfdf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Theme: Splendid Horizons', part.name_en = 'Americana Symphony: VI. Theme: Splendid Horizons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24424 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:89c69a83-545c-43fd-bccb-803c24b7c80c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89c69a83-545c-43fd-bccb-803c24b7c80c', 6, 'VI', 'Theme: Splendid Horizons', 'Americana Symphony: VI. Theme: Splendid Horizons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24424 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c69a83-545c-43fd-bccb-803c24b7c80c'
);


-- None Appalachia Waltz

UPDATE pieces piece
SET piece.title = 'Appalachia Waltz', piece.title_en = 'Appalachia Waltz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25288 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Caprice for Three

UPDATE pieces piece
SET piece.title = 'Caprice for Three', piece.title_en = 'Caprice for Three',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24439 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 카프리스 1번

UPDATE pieces piece
SET piece.title = '카프리스 1번', piece.title_en = 'Caprice no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24936 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 6번 "Old Brass"

UPDATE pieces piece
SET piece.title = '협주곡 6번 "Old Brass"', piece.title_en = 'Concerto no. 6 "Old Brass"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24076 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Road Is Smooth', part.name_en = 'Concerto no. 6 "Old Brass": I. The Road Is Smooth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24076 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:fc138a24-49be-4e64-9cd1-941bb19bdbd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc138a24-49be-4e64-9cd1-941bb19bdbd5', 1, 'I', 'The Road Is Smooth', 'Concerto no. 6 "Old Brass": I. The Road Is Smooth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24076 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc138a24-49be-4e64-9cd1-941bb19bdbd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Spanish Moss, Black Water', part.name_en = 'Concerto no. 6 "Old Brass": II. Spanish Moss, Black Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24076 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:416fb622-7707-462d-bfcb-50024cd7a034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416fb622-7707-462d-bfcb-50024cd7a034', 2, 'II', 'Spanish Moss, Black Water', 'Concerto no. 6 "Old Brass": II. Spanish Moss, Black Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24076 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416fb622-7707-462d-bfcb-50024cd7a034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fugue in Six Parts: "Graceand Charm"', part.name_en = 'Concerto no. 6 "Old Brass": III. Fugue in Six Parts: "Graceand Charm"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24076 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:c71ce493-8573-46e1-bc08-800cab0f1d63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c71ce493-8573-46e1-bc08-800cab0f1d63', 3, 'III', 'Fugue in Six Parts: "Graceand Charm"', 'Concerto no. 6 "Old Brass": III. Fugue in Six Parts: "Graceand Charm"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24076 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c71ce493-8573-46e1-bc08-800cab0f1d63'
);


-- None Folk Mass

UPDATE pieces piece
SET piece.title = 'Folk Mass', piece.title_en = 'Folk Mass',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23265 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VII',
    part.name_ko = 'Affirmation', part.name_en = 'Folk Mass: VII. Affirmation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:229623ff-c676-40e3-af98-7bbc3e87250d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:229623ff-c676-40e3-af98-7bbc3e87250d', 1, 'VII', 'Affirmation', 'Folk Mass: VII. Affirmation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:229623ff-c676-40e3-af98-7bbc3e87250d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Land of Canaan', part.name_en = 'Folk Mass: III. Land of Canaan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:2587a85f-36a4-4076-a6a7-6148f97003d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2587a85f-36a4-4076-a6a7-6148f97003d5', 2, 'III', 'Land of Canaan', 'Folk Mass: III. Land of Canaan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2587a85f-36a4-4076-a6a7-6148f97003d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Edification', part.name_en = 'Folk Mass: IV. Edification',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:97e58a1a-2da2-4d82-97a9-6f3ccffb8f16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e58a1a-2da2-4d82-97a9-6f3ccffb8f16', 3, 'IV', 'Edification', 'Folk Mass: IV. Edification', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e58a1a-2da2-4d82-97a9-6f3ccffb8f16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Battle', part.name_en = 'Folk Mass: V. Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:a683c424-aa87-4cb0-ba32-f9ce2bb1393b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a683c424-aa87-4cb0-ba32-f9ce2bb1393b', 4, 'V', 'Battle', 'Folk Mass: V. Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a683c424-aa87-4cb0-ba32-f9ce2bb1393b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Folk Mass: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:a9ad4757-6bab-441d-a212-828031c2991b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9ad4757-6bab-441d-a212-828031c2991b', 5, 'I', 'Introduction', 'Folk Mass: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9ad4757-6bab-441d-a212-828031c2991b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Recompence', part.name_en = 'Folk Mass: VI. Recompence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:b2a4dae6-4b86-478f-a91c-d95e4e18e884' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2a4dae6-4b86-478f-a91c-d95e4e18e884', 6, 'VI', 'Recompence', 'Folk Mass: VI. Recompence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a4dae6-4b86-478f-a91c-d95e4e18e884'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'for You a People Holy to the Lord', part.name_en = 'Folk Mass: II. for You a People Holy to the Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23265 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:b2b6b717-69cd-4fae-b6f8-774382240eaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2b6b717-69cd-4fae-b6f8-774382240eaf', 7, 'II', 'for You a People Holy to the Lord', 'Folk Mass: II. for You a People Holy to the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23265 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2b6b717-69cd-4fae-b6f8-774382240eaf'
);


-- None Let Us Move

UPDATE pieces piece
SET piece.title = 'Let Us Move', piece.title_en = 'Let Us Move',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23771 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None March of the Gypsy Fiddler

UPDATE pieces piece
SET piece.title = 'March of the Gypsy Fiddler', piece.title_en = 'March of the Gypsy Fiddler',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24487 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Movement I', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": I. Movement I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:3399bc8c-7962-4ebe-85fb-86d373fc98af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3399bc8c-7962-4ebe-85fb-86d373fc98af', 1, 'I', 'Movement I', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": I. Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3399bc8c-7962-4ebe-85fb-86d373fc98af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Movement II', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": II. Movement II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:36f71c75-0784-4fa4-b4be-660acf9b526e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36f71c75-0784-4fa4-b4be-660acf9b526e', 2, 'II', 'Movement II', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": II. Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36f71c75-0784-4fa4-b4be-660acf9b526e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Movement II', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": II. Movement II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:4690dee6-4e70-409e-bdb9-e9c78da2d58b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4690dee6-4e70-409e-bdb9-e9c78da2d58b', 3, 'II', 'Movement II', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": II. Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4690dee6-4e70-409e-bdb9-e9c78da2d58b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Movement I', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": I. Movement I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:69e8f71e-707a-4860-b3ec-1d63133ff004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69e8f71e-707a-4860-b3ec-1d63133ff004', 4, 'I', 'Movement I', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": I. Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e8f71e-707a-4860-b3ec-1d63133ff004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = 'Movement III', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": III. Movement III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:86458ae2-57a0-402d-b41a-2e1f1c4bc632' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86458ae2-57a0-402d-b41a-2e1f1c4bc632', 5, 'III', 'Movement III', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": III. Movement III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86458ae2-57a0-402d-b41a-2e1f1c4bc632'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Movement III', part.name_en = 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": III. Movement III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24487 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:b0194686-485d-4edb-b161-5b4bc7cb1145' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0194686-485d-4edb-b161-5b4bc7cb1145', 6, 'III', 'Movement III', 'Triple Concerto for Violin, Cello, Piano and Symphony Orchestra "March of the Gypsy Fiddler": III. Movement III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24487 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0194686-485d-4edb-b161-5b4bc7cb1145'
);


-- None Misty Moonlight Waltz

UPDATE pieces piece
SET piece.title = 'Misty Moonlight Waltz', piece.title_en = 'Misty Moonlight Waltz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24515 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Olympic Reel

UPDATE pieces piece
SET piece.title = 'Olympic Reel', piece.title_en = 'Olympic Reel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25848 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One Winter's Night

UPDATE pieces piece
SET piece.title = 'One Winter''s Night', piece.title_en = 'One Winter''s Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25362 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Poem for Carlita

UPDATE pieces piece
SET piece.title = 'Poem for Carlita', piece.title_en = 'Poem for Carlita',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23832 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song of the Liberty Bell

UPDATE pieces piece
SET piece.title = 'Song of the Liberty Bell', piece.title_en = 'Song of the Liberty Bell',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23880 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Cricket Dance

UPDATE pieces piece
SET piece.title = 'The Cricket Dance', piece.title_en = 'The Cricket Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23884 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fallen

UPDATE pieces piece
SET piece.title = 'The Fallen', piece.title_en = 'The Fallen',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25644 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'The Fallen: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25644 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:88506344-2046-4989-8f04-d034eaa77df0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88506344-2046-4989-8f04-d034eaa77df0', 1, NULL, 'I', 'The Fallen: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25644 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88506344-2046-4989-8f04-d034eaa77df0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'The Fallen: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25644 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:95da3e57-1b41-4450-9e42-7a7784d9bc34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95da3e57-1b41-4450-9e42-7a7784d9bc34', 2, NULL, 'II', 'The Fallen: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25644 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95da3e57-1b41-4450-9e42-7a7784d9bc34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'The Fallen: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25644 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:fc88ef6c-1295-45a9-a13a-d8174c7f881b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc88ef6c-1295-45a9-a13a-d8174c7f881b', 3, NULL, 'III', 'The Fallen: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25644 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc88ef6c-1295-45a9-a13a-d8174c7f881b'
);


-- None The Improvised Violin Concerto

UPDATE pieces piece
SET piece.title = 'The Improvised Violin Concerto', piece.title_en = 'The Improvised Violin Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24723 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Earth', part.name_en = 'The Improvised Violin Concerto: IV. Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:2b948538-1cd6-48cd-bea3-7690389a1321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b948538-1cd6-48cd-bea3-7690389a1321', 1, 'IV', 'Earth', 'The Improvised Violin Concerto: IV. Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b948538-1cd6-48cd-bea3-7690389a1321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Faith', part.name_en = 'The Improvised Violin Concerto: V. Faith',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:5547e075-23a3-4039-bf52-1284ed012a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5547e075-23a3-4039-bf52-1284ed012a39', 2, 'V', 'Faith', 'The Improvised Violin Concerto: V. Faith', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5547e075-23a3-4039-bf52-1284ed012a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Fire', part.name_en = 'The Improvised Violin Concerto: I. Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:6a5e72c2-31ba-4d7f-a21c-d877fbdecd57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a5e72c2-31ba-4d7f-a21c-d877fbdecd57', 3, 'I', 'Fire', 'The Improvised Violin Concerto: I. Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a5e72c2-31ba-4d7f-a21c-d877fbdecd57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Air', part.name_en = 'The Improvised Violin Concerto: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:6a95678b-b4d5-4a14-8668-296007d399ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a95678b-b4d5-4a14-8668-296007d399ee', 4, 'II', 'Air', 'The Improvised Violin Concerto: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a95678b-b4d5-4a14-8668-296007d399ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Faith', part.name_en = 'The Improvised Violin Concerto: V. Faith',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:7ef26169-7d0e-42f8-a898-14863ae3fb65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ef26169-7d0e-42f8-a898-14863ae3fb65', 5, 'V', 'Faith', 'The Improvised Violin Concerto: V. Faith', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ef26169-7d0e-42f8-a898-14863ae3fb65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Water', part.name_en = 'The Improvised Violin Concerto: III. Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:86c9ce95-1938-4cce-be37-2a70f5955d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c9ce95-1938-4cce-be37-2a70f5955d2a', 6, 'III', 'Water', 'The Improvised Violin Concerto: III. Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c9ce95-1938-4cce-be37-2a70f5955d2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'III',
    part.name_ko = 'Water', part.name_en = 'The Improvised Violin Concerto: III. Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:8defc1ed-b01f-41cb-986c-1ee965518589' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8defc1ed-b01f-41cb-986c-1ee965518589', 7, 'III', 'Water', 'The Improvised Violin Concerto: III. Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8defc1ed-b01f-41cb-986c-1ee965518589'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'I',
    part.name_ko = 'Fire', part.name_en = 'The Improvised Violin Concerto: I. Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:908e2d89-8420-4d0b-82cc-09dd04ce851b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:908e2d89-8420-4d0b-82cc-09dd04ce851b', 8, 'I', 'Fire', 'The Improvised Violin Concerto: I. Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:908e2d89-8420-4d0b-82cc-09dd04ce851b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IV',
    part.name_ko = 'Earth', part.name_en = 'The Improvised Violin Concerto: IV. Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:ae4b2594-5730-4df9-9102-7e1e43924fb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae4b2594-5730-4df9-9102-7e1e43924fb7', 9, 'IV', 'Earth', 'The Improvised Violin Concerto: IV. Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae4b2594-5730-4df9-9102-7e1e43924fb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'II',
    part.name_ko = 'Air', part.name_en = 'The Improvised Violin Concerto: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24723 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:c0b6144b-0252-4782-9546-b0df8692bd80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0b6144b-0252-4782-9546-b0df8692bd80', 10, 'II', 'Air', 'The Improvised Violin Concerto: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24723 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0b6144b-0252-4782-9546-b0df8692bd80'
);


-- None Trio no. 1, Poets and Prophets

UPDATE pieces piece
SET piece.title = 'Trio no. 1, Poets and Prophets', piece.title_en = 'Trio no. 1, Poets and Prophets',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25451 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Man in Black', part.name_en = 'Trio no. 1, Poets and Prophets: I. Man in Black',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25451 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:099d4b09-7e4b-48fb-838b-18b8ff37cf3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:099d4b09-7e4b-48fb-838b-18b8ff37cf3e', 1, 'I', 'Man in Black', 'Trio no. 1, Poets and Prophets: I. Man in Black', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25451 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:099d4b09-7e4b-48fb-838b-18b8ff37cf3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'My June', part.name_en = 'Trio no. 1, Poets and Prophets: III. My June',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25451 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:26abc09b-436f-4f08-a472-f2413115c19f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26abc09b-436f-4f08-a472-f2413115c19f', 2, 'III', 'My June', 'Trio no. 1, Poets and Prophets: III. My June', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25451 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26abc09b-436f-4f08-a472-f2413115c19f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'The Tennessee Two', part.name_en = 'Trio no. 1, Poets and Prophets: II. The Tennessee Two',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25451 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:44cca122-da81-4db9-9fab-441ed8dfd91a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44cca122-da81-4db9-9fab-441ed8dfd91a', 3, 'II', 'The Tennessee Two', 'Trio no. 1, Poets and Prophets: II. The Tennessee Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25451 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44cca122-da81-4db9-9fab-441ed8dfd91a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Hello, I''m Johnny Cash', part.name_en = 'Trio no. 1, Poets and Prophets: IV. Hello, I''m Johnny Cash',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25451 AND p.composer_id = 385 AND part.part_key = 'musicbrainz:ebdef347-33af-4cc6-9518-6e17cea7b7c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdef347-33af-4cc6-9518-6e17cea7b7c0', 4, 'IV', 'Hello, I''m Johnny Cash', 'Trio no. 1, Poets and Prophets: IV. Hello, I''m Johnny Cash', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25451 AND p.composer_id = 385
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdef347-33af-4cc6-9518-6e17cea7b7c0'
);


-- None Vistas

UPDATE pieces piece
SET piece.title = 'Vistas', piece.title_en = 'Vistas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24475 AND piece.composer_id = 385
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 385 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23411
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Bruno Bettinelli (composer_id 386) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 1, 다악장 4, 낱곡 2),
-- 새 작품 1개, part 41개, 그 아래 0개.
-- seed 6개 중 6개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Cinque preludi

UPDATE pieces piece
SET piece.title = 'Cinque preludi', piece.title_en = 'Cinque preludi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24844 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Cinque preludi: No. 1. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24844 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:2e2b1f2a-a987-49f6-817c-a304d02301fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e2b1f2a-a987-49f6-817c-a304d02301fb', 1, NULL, 'Tranquillo', 'Cinque preludi: No. 1. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24844 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e2b1f2a-a987-49f6-817c-a304d02301fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deciso e ritmato', part.name_en = 'Cinque preludi: No. 2. Deciso e ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24844 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:cace3966-ff4e-4697-8747-c766575cc1ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cace3966-ff4e-4697-8747-c766575cc1ad', 2, NULL, 'Deciso e ritmato', 'Cinque preludi: No. 2. Deciso e ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24844 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cace3966-ff4e-4697-8747-c766575cc1ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Cinque preludi: No. 3. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24844 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:33ed253a-91d7-466a-aae2-c0700e1d1893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ed253a-91d7-466a-aae2-c0700e1d1893', 3, NULL, 'Lento', 'Cinque preludi: No. 3. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24844 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ed253a-91d7-466a-aae2-c0700e1d1893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Veloce', part.name_en = 'Cinque preludi: No. 4. Veloce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24844 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:57f76399-42e3-4e23-94e3-0b1ca82d7ca3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57f76399-42e3-4e23-94e3-0b1ca82d7ca3', 4, NULL, 'Veloce', 'Cinque preludi: No. 4. Veloce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24844 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57f76399-42e3-4e23-94e3-0b1ca82d7ca3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Cinque preludi: No. 5. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24844 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:8d21addd-b326-4433-b28d-098e445c3a70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d21addd-b326-4433-b28d-098e445c3a70', 5, NULL, 'Allegro', 'Cinque preludi: No. 5. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24844 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d21addd-b326-4433-b28d-098e445c3a70'
);


-- None 피아노 환상곡

UPDATE pieces piece
SET piece.title = '피아노 환상곡', piece.title_en = 'Fantasia per pianoforte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23971 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preambolo', part.name_en = 'Fantasia per pianoforte: I. Preambolo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23971 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:ca1bb0f6-8377-46fe-b154-b83924ad4c6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca1bb0f6-8377-46fe-b154-b83924ad4c6c', 1, 'I', 'Preambolo', 'Fantasia per pianoforte: I. Preambolo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23971 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca1bb0f6-8377-46fe-b154-b83924ad4c6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ritmico', part.name_en = 'Fantasia per pianoforte: II. Ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23971 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:99fd2721-bd35-49da-94de-2e90e96717cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fd2721-bd35-49da-94de-2e90e96717cb', 2, 'II', 'Ritmico', 'Fantasia per pianoforte: II. Ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23971 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fd2721-bd35-49da-94de-2e90e96717cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Notturno', part.name_en = 'Fantasia per pianoforte: III. Notturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23971 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:3f4a4a72-e842-481e-8f49-a991ac280f59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f4a4a72-e842-481e-8f49-a991ac280f59', 3, 'III', 'Notturno', 'Fantasia per pianoforte: III. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23971 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f4a4a72-e842-481e-8f49-a991ac280f59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Intermezzo', part.name_en = 'Fantasia per pianoforte: IV. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23971 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:5a87dc71-8ac6-4924-b659-4f2f71ca5eb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a87dc71-8ac6-4924-b659-4f2f71ca5eb3', 4, 'IV', 'Intermezzo', 'Fantasia per pianoforte: IV. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23971 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a87dc71-8ac6-4924-b659-4f2f71ca5eb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fugato', part.name_en = 'Fantasia per pianoforte: V. Fugato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23971 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:45eeafae-50b3-4214-8718-034e5e44f74d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45eeafae-50b3-4214-8718-034e5e44f74d', 5, 'V', 'Fugato', 'Fantasia per pianoforte: V. Fugato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23971 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45eeafae-50b3-4214-8718-034e5e44f74d'
);


-- None Piccoli pezzi per pianoforte

UPDATE pieces piece
SET piece.title = 'Piccoli pezzi per pianoforte', piece.title_en = 'Piccoli pezzi per pianoforte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24285 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludietto', part.name_en = 'Piccoli pezzi per pianoforte: I. Preludietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:2b6df304-24be-41c8-bffc-b588f43a39ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b6df304-24be-41c8-bffc-b588f43a39ea', 1, 'I', 'Preludietto', 'Piccoli pezzi per pianoforte: I. Preludietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b6df304-24be-41c8-bffc-b588f43a39ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Movimento di valzer', part.name_en = 'Piccoli pezzi per pianoforte: II. Movimento di valzer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:a5e9c26d-3041-41b7-8064-6fb608d50ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e9c26d-3041-41b7-8064-6fb608d50ff5', 2, 'II', 'Movimento di valzer', 'Piccoli pezzi per pianoforte: II. Movimento di valzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e9c26d-3041-41b7-8064-6fb608d50ff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Piccola marcia', part.name_en = 'Piccoli pezzi per pianoforte: III. Piccola marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:c1152710-8f5c-42d4-84f5-778f49d5bd2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1152710-8f5c-42d4-84f5-778f49d5bd2a', 3, 'III', 'Piccola marcia', 'Piccoli pezzi per pianoforte: III. Piccola marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1152710-8f5c-42d4-84f5-778f49d5bd2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Canto breve', part.name_en = 'Piccoli pezzi per pianoforte: IV. Canto breve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:917f35a3-6680-42b1-8c1e-ba0bc3419446' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917f35a3-6680-42b1-8c1e-ba0bc3419446', 4, 'IV', 'Canto breve', 'Piccoli pezzi per pianoforte: IV. Canto breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917f35a3-6680-42b1-8c1e-ba0bc3419446'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Barcarola', part.name_en = 'Piccoli pezzi per pianoforte: V. Barcarola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:3b7fa71f-81f9-46ac-955a-2d739bc60ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b7fa71f-81f9-46ac-955a-2d739bc60ea8', 5, 'V', 'Barcarola', 'Piccoli pezzi per pianoforte: V. Barcarola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7fa71f-81f9-46ac-955a-2d739bc60ea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Romanza', part.name_en = 'Piccoli pezzi per pianoforte: VI. Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:7f8e2478-72d5-4836-ae38-c91d5b3b25b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f8e2478-72d5-4836-ae38-c91d5b3b25b6', 6, 'VI', 'Romanza', 'Piccoli pezzi per pianoforte: VI. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f8e2478-72d5-4836-ae38-c91d5b3b25b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Pensierino', part.name_en = 'Piccoli pezzi per pianoforte: VII. Pensierino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:83da4021-5656-4b97-97be-d451514bf4d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83da4021-5656-4b97-97be-d451514bf4d8', 7, 'VII', 'Pensierino', 'Piccoli pezzi per pianoforte: VII. Pensierino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83da4021-5656-4b97-97be-d451514bf4d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Preludietto', part.name_en = 'Piccoli pezzi per pianoforte: VIII. Preludietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:7f66ed35-e518-4116-a8ef-8c177ca0d2d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f66ed35-e518-4116-a8ef-8c177ca0d2d4', 8, 'VIII', 'Preludietto', 'Piccoli pezzi per pianoforte: VIII. Preludietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f66ed35-e518-4116-a8ef-8c177ca0d2d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Cornamusa', part.name_en = 'Piccoli pezzi per pianoforte: IX. Cornamusa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:6ba1c142-2211-4d85-a6d7-8adc569a71b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ba1c142-2211-4d85-a6d7-8adc569a71b7', 9, 'IX', 'Cornamusa', 'Piccoli pezzi per pianoforte: IX. Cornamusa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ba1c142-2211-4d85-a6d7-8adc569a71b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Eco', part.name_en = 'Piccoli pezzi per pianoforte: X. Eco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:f0100d8b-ea20-447f-8eb6-651f06fdca53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0100d8b-ea20-447f-8eb6-651f06fdca53', 10, 'X', 'Eco', 'Piccoli pezzi per pianoforte: X. Eco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0100d8b-ea20-447f-8eb6-651f06fdca53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Canzoncina', part.name_en = 'Piccoli pezzi per pianoforte: XI. Canzoncina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:de775992-18dc-45bf-a12a-1b55c55c771b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de775992-18dc-45bf-a12a-1b55c55c771b', 11, 'XI', 'Canzoncina', 'Piccoli pezzi per pianoforte: XI. Canzoncina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de775992-18dc-45bf-a12a-1b55c55c771b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Canone', part.name_en = 'Piccoli pezzi per pianoforte: XII. Canone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:9f5ca916-28b2-4c98-bbcd-7f413227727e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f5ca916-28b2-4c98-bbcd-7f413227727e', 12, 'XII', 'Canone', 'Piccoli pezzi per pianoforte: XII. Canone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f5ca916-28b2-4c98-bbcd-7f413227727e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Improvviso', part.name_en = 'Piccoli pezzi per pianoforte: XIII. Improvviso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:05625db9-69ec-4518-aa33-9fe6d106db04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05625db9-69ec-4518-aa33-9fe6d106db04', 13, 'XIII', 'Improvviso', 'Piccoli pezzi per pianoforte: XIII. Improvviso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05625db9-69ec-4518-aa33-9fe6d106db04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Ninna nanna', part.name_en = 'Piccoli pezzi per pianoforte: XIV. Ninna nanna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:259e13eb-1838-4140-814a-7907131dc6b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:259e13eb-1838-4140-814a-7907131dc6b0', 14, 'XIV', 'Ninna nanna', 'Piccoli pezzi per pianoforte: XIV. Ninna nanna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259e13eb-1838-4140-814a-7907131dc6b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Marcia', part.name_en = 'Piccoli pezzi per pianoforte: XV. Marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:e7088e7f-67bf-4111-bffc-8523ce692931' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7088e7f-67bf-4111-bffc-8523ce692931', 15, 'XV', 'Marcia', 'Piccoli pezzi per pianoforte: XV. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7088e7f-67bf-4111-bffc-8523ce692931'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Notturnino', part.name_en = 'Piccoli pezzi per pianoforte: XVI. Notturnino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:95b3b342-579a-4000-9773-c328bf26156a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95b3b342-579a-4000-9773-c328bf26156a', 16, 'XVI', 'Notturnino', 'Piccoli pezzi per pianoforte: XVI. Notturnino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b3b342-579a-4000-9773-c328bf26156a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Preludietto', part.name_en = 'Piccoli pezzi per pianoforte: XVII. Preludietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:d478db54-1761-4e91-a856-4638c90611ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d478db54-1761-4e91-a856-4638c90611ef', 17, 'XVII', 'Preludietto', 'Piccoli pezzi per pianoforte: XVII. Preludietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d478db54-1761-4e91-a856-4638c90611ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = 'Toccata', part.name_en = 'Piccoli pezzi per pianoforte: XVIII. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24285 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:030d1aa8-8cca-4664-b517-373fc7a7dd76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:030d1aa8-8cca-4664-b517-373fc7a7dd76', 18, 'XVIII', 'Toccata', 'Piccoli pezzi per pianoforte: XVIII. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24285 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:030d1aa8-8cca-4664-b517-373fc7a7dd76'
);


-- None 전주곡

UPDATE pieces piece
SET piece.title = '전주곡', piece.title_en = 'Preludio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25891 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sintesi

UPDATE pieces piece
SET piece.title = 'Sintesi', piece.title_en = 'Sintesi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23922 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Sintesi: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:1c0af70e-85f0-4bc8-be47-ee2b08ac5798' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c0af70e-85f0-4bc8-be47-ee2b08ac5798', 1, 'I', 'Preludio', 'Sintesi: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0af70e-85f0-4bc8-be47-ee2b08ac5798'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Monodia', part.name_en = 'Sintesi: II. Monodia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:156b2463-605e-4068-b0a8-48f2d0a2a12c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:156b2463-605e-4068-b0a8-48f2d0a2a12c', 2, 'II', 'Monodia', 'Sintesi: II. Monodia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:156b2463-605e-4068-b0a8-48f2d0a2a12c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Armonia', part.name_en = 'Sintesi: III. Armonia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:03e0f09f-4e07-4872-8100-1c5c4e68f015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03e0f09f-4e07-4872-8100-1c5c4e68f015', 3, 'III', 'Armonia', 'Sintesi: III. Armonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e0f09f-4e07-4872-8100-1c5c4e68f015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Polifonia', part.name_en = 'Sintesi: IV. Polifonia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:3fca5882-1dbf-4e9b-931d-8e3199f6a87e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fca5882-1dbf-4e9b-931d-8e3199f6a87e', 4, 'IV', 'Polifonia', 'Sintesi: IV. Polifonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fca5882-1dbf-4e9b-931d-8e3199f6a87e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Notturno', part.name_en = 'Sintesi: V. Notturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:845e2641-1a82-45b2-b2e2-e2130164b617' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:845e2641-1a82-45b2-b2e2-e2130164b617', 5, 'V', 'Notturno', 'Sintesi: V. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:845e2641-1a82-45b2-b2e2-e2130164b617'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Capriccio', part.name_en = 'Sintesi: VI. Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:422c00f3-afda-478f-9552-fa10adab6566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:422c00f3-afda-478f-9552-fa10adab6566', 6, 'VI', 'Capriccio', 'Sintesi: VI. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422c00f3-afda-478f-9552-fa10adab6566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Omaggio a Dallapiccola', part.name_en = 'Sintesi: VII. Omaggio a Dallapiccola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:d92136f6-4ba7-48db-a0a5-7a79eace536d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d92136f6-4ba7-48db-a0a5-7a79eace536d', 7, 'VII', 'Omaggio a Dallapiccola', 'Sintesi: VII. Omaggio a Dallapiccola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92136f6-4ba7-48db-a0a5-7a79eace536d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Omaggio a Petrassi', part.name_en = 'Sintesi: VIII. Omaggio a Petrassi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:ae9a2e16-774a-4e88-a31d-a241d52453b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae9a2e16-774a-4e88-a31d-a241d52453b0', 8, 'VIII', 'Omaggio a Petrassi', 'Sintesi: VIII. Omaggio a Petrassi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae9a2e16-774a-4e88-a31d-a241d52453b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Ostinato', part.name_en = 'Sintesi: IX. Ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:0de45242-1e17-49ee-8333-eaf1732e2426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0de45242-1e17-49ee-8333-eaf1732e2426', 9, 'IX', 'Ostinato', 'Sintesi: IX. Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de45242-1e17-49ee-8333-eaf1732e2426'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Toccata', part.name_en = 'Sintesi: X. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23922 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:23b04608-a1ba-4c0b-b8dd-6d3714d83285' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23b04608-a1ba-4c0b-b8dd-6d3714d83285', 10, 'X', 'Toccata', 'Sintesi: X. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23922 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23b04608-a1ba-4c0b-b8dd-6d3714d83285'
);


-- None Suite agreste

UPDATE pieces piece
SET piece.title = 'Suite agreste', piece.title_en = 'Suite agreste',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25183 AND piece.composer_id = 386
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Passeggiata nel bosco', part.name_en = 'Suite agreste: I. Passeggiata nel bosco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25183 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:cec29378-ec47-4b5f-8263-b1df1e5eefae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cec29378-ec47-4b5f-8263-b1df1e5eefae', 1, 'I', 'Passeggiata nel bosco', 'Suite agreste: I. Passeggiata nel bosco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25183 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec29378-ec47-4b5f-8263-b1df1e5eefae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danza di contadini', part.name_en = 'Suite agreste: II. Danza di contadini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25183 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:05adecda-4449-41f3-a66e-567c7c46ce4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05adecda-4449-41f3-a66e-567c7c46ce4e', 2, 'II', 'Danza di contadini', 'Suite agreste: II. Danza di contadini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25183 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05adecda-4449-41f3-a66e-567c7c46ce4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Corse sui prati', part.name_en = 'Suite agreste: III. Corse sui prati',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25183 AND p.composer_id = 386 AND part.part_key = 'musicbrainz:3ae9c65e-8284-4e74-a9a6-879bf536387c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ae9c65e-8284-4e74-a9a6-879bf536387c', 3, 'III', 'Corse sui prati', 'Suite agreste: III. Corse sui prati', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25183 AND p.composer_id = 386
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ae9c65e-8284-4e74-a9a6-879bf536387c'
);


-- None Studio da concerto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Studio da concerto', 'Studio da concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 386
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Studio da concerto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7950dfbe-04ad-42ca-8cc5-06a53864948e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7950dfbe-04ad-42ca-8cc5-06a53864948e'
FROM pieces p
WHERE p.composer_id = 386 AND p.title = 'Studio da concerto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7950dfbe-04ad-42ca-8cc5-06a53864948e'
);

-- 숨길 seed 작품 없음

-- ===== Geoffrey Bush (composer_id 387) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 5, 다악장 3, 낱곡 7),
-- 새 작품 2개, part 54개, 그 아래 0개.
-- seed 14개 중 13개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <'Twas in the Year that King Uzziah Died>

UPDATE pieces piece
SET piece.title = '가곡 <''Twas in the Year that King Uzziah Died>', piece.title_en = '''Twas in the Year that King Uzziah Died',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23819 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <A Christmas Cantata>

UPDATE pieces piece
SET piece.title = '칸타타 <A Christmas Cantata>', piece.title_en = 'A Christmas Cantata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25963 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude - Lullay Jesu', part.name_en = 'A Christmas Cantata: 1. Prelude - Lullay Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901', 1, NULL, 'Prelude - Lullay Jesu', 'A Christmas Cantata: 1. Prelude - Lullay Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The First Good Joy That Mary Had', part.name_en = 'A Christmas Cantata: 2. The First Good Joy That Mary Had',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040', 2, NULL, 'The First Good Joy That Mary Had', 'A Christmas Cantata: 2. The First Good Joy That Mary Had', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'When Jesus Christ Was Four Years Old', part.name_en = 'A Christmas Cantata: 3. When Jesus Christ Was Four Years Old',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9', 3, NULL, 'When Jesus Christ Was Four Years Old', 'A Christmas Cantata: 3. When Jesus Christ Was Four Years Old', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Little Jesus, Sweetly Sleep', part.name_en = 'A Christmas Cantata: 4. Little Jesus, Sweetly Sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608', 4, NULL, 'Little Jesus, Sweetly Sleep', 'A Christmas Cantata: 4. Little Jesus, Sweetly Sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rejoice O Make We Merry, Both More & Less', part.name_en = 'A Christmas Cantata: 5. Rejoice O Make We Merry, Both More & Less',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b', 5, NULL, 'Rejoice O Make We Merry, Both More & Less', 'A Christmas Cantata: 5. Rejoice O Make We Merry, Both More & Less', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I Sing of a Maiden', part.name_en = 'A Christmas Cantata: 6. I Sing of a Maiden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544', 6, NULL, 'I Sing of a Maiden', 'A Christmas Cantata: 6. I Sing of a Maiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'By By Lullay, Thou Little Tiny Child', part.name_en = 'A Christmas Cantata: 7. By By Lullay, Thou Little Tiny Child',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e', 7, NULL, 'By By Lullay, Thou Little Tiny Child', 'A Christmas Cantata: 7. By By Lullay, Thou Little Tiny Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Epilogue/I Saw Three Ships Come Sailing In', part.name_en = 'A Christmas Cantata: 8. Epilogue/I Saw Three Ships Come Sailing In',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2', 8, NULL, 'Epilogue/I Saw Three Ships Come Sailing In', 'A Christmas Cantata: 8. Epilogue/I Saw Three Ships Come Sailing In', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2'
);


-- None A Little Concerto on Themes of Thomas Arne

UPDATE pieces piece
SET piece.title = 'A Little Concerto on Themes of Thomas Arne', piece.title_en = 'A Little Concerto on Themes of Thomas Arne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25589 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'A Little Concerto on Themes of Thomas Arne: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec', 1, 'I', 'Andante', 'A Little Concerto on Themes of Thomas Arne: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'A Little Concerto on Themes of Thomas Arne: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df', 2, 'II', 'Allegro', 'A Little Concerto on Themes of Thomas Arne: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Siciliano', part.name_en = 'A Little Concerto on Themes of Thomas Arne: III. Siciliano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80', 3, 'III', 'Siciliano', 'A Little Concerto on Themes of Thomas Arne: III. Siciliano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'A Little Concerto on Themes of Thomas Arne: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6', 4, 'IV', 'Vivace', 'A Little Concerto on Themes of Thomas Arne: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6'
);


-- None 오보에 협주곡

UPDATE pieces piece
SET piece.title = '오보에 협주곡', piece.title_en = 'Concerto for Oboe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25697 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Consort Music

UPDATE pieces piece
SET piece.title = 'Consort Music', piece.title_en = 'Consort Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25332 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Song without Words', part.name_en = 'Consort Music: I. Song without Words',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471', 1, 'I', 'Song without Words', 'Consort Music: I. Song without Words', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Valse', part.name_en = 'Consort Music: II. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6', 2, 'II', 'Valse', 'Consort Music: II. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ballade', part.name_en = 'Consort Music: III. Ballade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf', 3, 'III', 'Ballade', 'Consort Music: III. Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Caprice', part.name_en = 'Consort Music: IV. Caprice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645', 4, 'IV', 'Caprice', 'Consort Music: IV. Caprice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Cradle Song', part.name_en = 'Consort Music: V. Cradle Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b', 5, 'V', 'Cradle Song', 'Consort Music: V. Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Finale', part.name_en = 'Consort Music: VI. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa', 6, 'VI', 'Finale', 'Consort Music: VI. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa'
);


-- None 가곡 <Cuisine Provençale>

UPDATE pieces piece
SET piece.title = '가곡 <Cuisine Provençale>', piece.title_en = 'Cuisine Provençale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24375 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <In Praise of Mary>

UPDATE pieces piece
SET piece.title = '칸타타 <In Praise of Mary>', piece.title_en = 'In Praise of Mary',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24158 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Love for such a cherry lip>

UPDATE pieces piece
SET piece.title = '가곡 <Love for such a cherry lip>', piece.title_en = 'Love for such a cherry lip',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24338 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Mirabile misterium (A great and mighty wonder)>

UPDATE pieces piece
SET piece.title = '연가곡집 <Mirabile misterium (A great and mighty wonder)>', piece.title_en = 'Mirabile misterium (A great and mighty wonder)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25588 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A marvellous thing have I mused in my mind', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 1. A marvellous thing have I mused in my mind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32', 1, NULL, 'A marvellous thing have I mused in my mind', 'Mirabile misterium (A great and mighty wonder): No. 1. A marvellous thing have I mused in my mind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'About th field they pipèd right', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 2. About th field they pipèd right',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0', 2, NULL, 'About th field they pipèd right', 'Mirabile misterium (A great and mighty wonder): No. 2. About th field they pipèd right', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'There is a flow''r sprung of a tree', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 3. There is a flow''r sprung of a tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21', 3, NULL, 'There is a flow''r sprung of a tree', 'Mirabile misterium (A great and mighty wonder): No. 3. There is a flow''r sprung of a tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jesu Christ, my leman sweet', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 4. Jesu Christ, my leman sweet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a', 4, NULL, 'Jesu Christ, my leman sweet', 'Mirabile misterium (A great and mighty wonder): No. 4. Jesu Christ, my leman sweet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Blessed Mary, moder virginal', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 5. Blessed Mary, moder virginal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766', 5, NULL, 'Blessed Mary, moder virginal', 'Mirabile misterium (A great and mighty wonder): No. 5. Blessed Mary, moder virginal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'When I see on Rose Jesu, my leman', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 6. When I see on Rose Jesu, my leman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91', 6, NULL, 'When I see on Rose Jesu, my leman', 'Mirabile misterium (A great and mighty wonder): No. 6. When I see on Rose Jesu, my leman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Out of your sleep arise and wake', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 7. Out of your sleep arise and wake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559', 7, NULL, 'Out of your sleep arise and wake', 'Mirabile misterium (A great and mighty wonder): No. 7. Out of your sleep arise and wake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559'
);


-- None Summer Serenade

UPDATE pieces piece
SET piece.title = 'Summer Serenade', piece.title_en = 'Summer Serenade',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23310 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue "Worship ye that lovers be this May"', part.name_en = 'Summer Serenade: I. Prologue "Worship ye that lovers be this May"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477', 1, 'I', 'Prologue "Worship ye that lovers be this May"', 'Summer Serenade: I. Prologue "Worship ye that lovers be this May"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Madrigal "Love is a sickness full of woes"', part.name_en = 'Summer Serenade: II. Madrigal "Love is a sickness full of woes"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8', 2, 'II', 'Madrigal "Love is a sickness full of woes"', 'Summer Serenade: II. Madrigal "Love is a sickness full of woes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo "Love is a pretty frenzy"', part.name_en = 'Summer Serenade: III. Scherzo "Love is a pretty frenzy"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8', 3, 'III', 'Scherzo "Love is a pretty frenzy"', 'Summer Serenade: III. Scherzo "Love is a pretty frenzy"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dirge “O Rose, thou art sick”', part.name_en = 'Summer Serenade: IV. Dirge “O Rose, thou art sick”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f', 4, 'IV', 'Dirge “O Rose, thou art sick”', 'Summer Serenade: IV. Dirge “O Rose, thou art sick”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Aubade "Pack, clouds, away"', part.name_en = 'Summer Serenade: V. Aubade "Pack, clouds, away"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879', 5, 'V', 'Aubade "Pack, clouds, away"', 'Summer Serenade: V. Aubade "Pack, clouds, away"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Nocturne "Music, when soft voices die"', part.name_en = 'Summer Serenade: VI. Nocturne "Music, when soft voices die"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de', 6, 'VI', 'Nocturne "Music, when soft voices die"', 'Summer Serenade: VI. Nocturne "Music, when soft voices die"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Finale "Pleasure it is, I wis, to hear the birdés sing"', part.name_en = 'Summer Serenade: VII. Finale "Pleasure it is, I wis, to hear the birdés sing"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f', 7, 'VII', 'Finale "Pleasure it is, I wis, to hear the birdés sing"', 'Summer Serenade: VII. Finale "Pleasure it is, I wis, to hear the birdés sing"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f'
);


-- None Three Songs of Ben Jonson

UPDATE pieces piece
SET piece.title = 'Three Songs of Ben Jonson', piece.title_en = 'Three Songs of Ben Jonson',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23733 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Echo''s Lament for Narcissus', part.name_en = 'Three Songs of Ben Jonson: No. 1. Echo''s Lament for Narcissus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45', 1, NULL, 'Echo''s Lament for Narcissus', 'Three Songs of Ben Jonson: No. 1. Echo''s Lament for Narcissus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Kiss', part.name_en = 'Three Songs of Ben Jonson: No. 2. The Kiss',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d', 2, NULL, 'The Kiss', 'Three Songs of Ben Jonson: No. 2. The Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Rebuke', part.name_en = 'Three Songs of Ben Jonson: No. 3. A Rebuke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2', 3, NULL, 'A Rebuke', 'Three Songs of Ben Jonson: No. 3. A Rebuke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2'
);


-- None Yorick

UPDATE pieces piece
SET piece.title = 'Yorick', piece.title_en = 'Yorick',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25342 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <archy at the zoo>

UPDATE pieces piece
SET piece.title = '연가곡집 <archy at the zoo>', piece.title_en = 'archy at the zoo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24696 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'centipede', part.name_en = 'archy at the zoo: No. 1. centipede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0', 1, NULL, 'centipede', 'archy at the zoo: No. 1. centipede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'camel and giraffe', part.name_en = 'archy at the zoo: No. 2. camel and giraffe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9', 2, NULL, 'camel and giraffe', 'archy at the zoo: No. 2. camel and giraffe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'hippopotamus', part.name_en = 'archy at the zoo: No. 3. hippopotamus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3', 3, NULL, 'hippopotamus', 'archy at the zoo: No. 3. hippopotamus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'hen', part.name_en = 'archy at the zoo: No. 4. hen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89', 4, NULL, 'hen', 'archy at the zoo: No. 4. hen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'octopus', part.name_en = 'archy at the zoo: No. 5. octopus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a', 5, NULL, 'octopus', 'archy at the zoo: No. 5. octopus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'man and monkey', part.name_en = 'archy at the zoo: No. 6. man and monkey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e', 6, NULL, 'man and monkey', 'archy at the zoo: No. 6. man and monkey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'penguin', part.name_en = 'archy at the zoo: No. 7. penguin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:08e3788c-039b-4301-8129-828157526839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e3788c-039b-4301-8129-828157526839', 7, NULL, 'penguin', 'archy at the zoo: No. 7. penguin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e3788c-039b-4301-8129-828157526839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'ichneumon', part.name_en = 'archy at the zoo: No. 8. ichneumon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6', 8, NULL, 'ichneumon', 'archy at the zoo: No. 8. ichneumon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'shark', part.name_en = 'archy at the zoo: No. 9. shark',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272', 9, NULL, 'shark', 'archy at the zoo: No. 9. shark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'young whale', part.name_en = 'archy at the zoo: No. 10. young whale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391', 10, NULL, 'young whale', 'archy at the zoo: No. 10. young whale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 387
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a485d0d-587a-41f6-b7d2-32671f0fde09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a485d0d-587a-41f6-b7d2-32671f0fde09'
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a485d0d-587a-41f6-b7d2-32671f0fde09'
);


-- None 연가곡집 <Yesterday>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Yesterday>', 'Yesterday', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 387
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Yesterday>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1975ae34-99ab-4acc-8e1d-edafc9dd1912', 1, NULL, 'Daniel Brent', 'Yesterday: No. 1. Daniel Brent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1975ae34-99ab-4acc-8e1d-edafc9dd1912'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5142646-90d2-4b97-8fe7-cd5cc133bbbf', 2, NULL, 'Lady Jane Grey', 'Yesterday: No. 2. Lady Jane Grey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5142646-90d2-4b97-8fe7-cd5cc133bbbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48e9e39-3094-4f7a-bc7b-9bd6c4e533b9', 3, NULL, 'Smuggler''s Song', 'Yesterday: No. 3. Smuggler''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48e9e39-3094-4f7a-bc7b-9bd6c4e533b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8cb044c-c325-4081-856c-34bb3a55f5ff', 4, NULL, 'Mistletoe', 'Yesterday: No. 4. Mistletoe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8cb044c-c325-4081-856c-34bb3a55f5ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18be0a82-847c-4763-97e2-bb9addddc1ac', 5, NULL, 'Sleigh Ride', 'Yesterday: No. 5. Sleigh Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18be0a82-847c-4763-97e2-bb9addddc1ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1af9e30-c569-4bd2-9bbf-ebfabf1e7bdc', 6, NULL, 'By the Tamar', 'Yesterday: No. 6. By the Tamar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1af9e30-c569-4bd2-9bbf-ebfabf1e7bdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6b40d7-d11a-4a57-9d89-bd0ec4ca2faf', 7, NULL, 'Morwenstow: A dialogue', 'Yesterday: No. 7. Morwenstow: A dialogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6b40d7-d11a-4a57-9d89-bd0ec4ca2faf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514bad78-0014-4436-8934-a0866e501ada', 8, NULL, 'Transience', 'Yesterday: No. 8. Transience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514bad78-0014-4436-8934-a0866e501ada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f189df3-3dd5-45de-96ec-31c6b2bcde36', 9, NULL, 'Wishes', 'Yesterday: No. 9. Wishes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f189df3-3dd5-45de-96ec-31c6b2bcde36'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 387 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23738
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Charles Sanford Skilton (composer_id 388) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 0, 낱곡 5),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Cheyenne War‐Dance

UPDATE pieces piece
SET piece.title = 'Cheyenne War‐Dance', piece.title_en = 'Cheyenne War‐Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25888 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kikapoo Social Dance

UPDATE pieces piece
SET piece.title = 'Kikapoo Social Dance', piece.title_en = 'Kikapoo Social Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23475 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shawnee Indian Hunting Dance

UPDATE pieces piece
SET piece.title = 'Shawnee Indian Hunting Dance', piece.title_en = 'Shawnee Indian Hunting Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24666 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sioux Flute Serenade

UPDATE pieces piece
SET piece.title = 'Sioux Flute Serenade', piece.title_en = 'Sioux Flute Serenade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23296 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Indian Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Two Indian Dances', 'Two Indian Dances', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 388
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Two Indian Dances'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
FROM pieces p
WHERE p.composer_id = 388 AND p.title = 'Two Indian Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
);

-- 숨길 seed 작품 없음

-- ===== Henri Mulet (composer_id 391) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 10개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Carillon-sortie en ré majeur

UPDATE pieces piece
SET piece.title = 'Carillon-sortie en ré majeur', piece.title_en = 'Carillon-sortie en ré majeur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24869 AND piece.composer_id = 391
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Esquisses byzantines

UPDATE pieces piece
SET piece.title = 'Esquisses byzantines', piece.title_en = 'Esquisses byzantines',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25552 AND piece.composer_id = 391
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nef', part.name_en = 'Esquisses byzantines: I. Nef',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8', 1, 'I', 'Nef', 'Esquisses byzantines: I. Nef', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vitrail', part.name_en = 'Esquisses byzantines: II. Vitrail',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f', 2, 'II', 'Vitrail', 'Esquisses byzantines: II. Vitrail', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rosace', part.name_en = 'Esquisses byzantines: III. Rosace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132', 3, 'III', 'Rosace', 'Esquisses byzantines: III. Rosace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Chapelle des morts', part.name_en = 'Esquisses byzantines: IV. Chapelle des morts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4', 4, 'IV', 'Chapelle des morts', 'Esquisses byzantines: IV. Chapelle des morts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Campanile', part.name_en = 'Esquisses byzantines: V. Campanile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b', 5, 'V', 'Campanile', 'Esquisses byzantines: V. Campanile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Procession', part.name_en = 'Esquisses byzantines: VI. Procession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261', 6, 'VI', 'Procession', 'Esquisses byzantines: VI. Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Chant funèbre', part.name_en = 'Esquisses byzantines: VII. Chant funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e', 7, 'VII', 'Chant funèbre', 'Esquisses byzantines: VII. Chant funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Noël', part.name_en = 'Esquisses byzantines: VIII. Noël',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02', 8, 'VIII', 'Noël', 'Esquisses byzantines: VIII. Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'In Paradisum', part.name_en = 'Esquisses byzantines: IX. In Paradisum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62', 9, 'IX', 'In Paradisum', 'Esquisses byzantines: IX. In Paradisum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Tu es Petra', part.name_en = 'Esquisses byzantines: X. Tu es Petra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a', 10, 'X', 'Tu es Petra', 'Esquisses byzantines: X. Tu es Petra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a'
);

-- 숨길 seed 작품 없음

-- ===== Geoffrey Toye (composer_id 392) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 발레 <The Haunted Ballroom>

UPDATE pieces piece
SET piece.title = '발레 <The Haunted Ballroom>', piece.title_en = 'The Haunted Ballroom',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23370 AND piece.composer_id = 392
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'The Haunted Ballroom: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23370 AND p.composer_id = 392 AND part.part_key = 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93', 1, NULL, 'Waltz', 'The Haunted Ballroom: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23370 AND p.composer_id = 392
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93'
);

-- 숨길 seed 작품 없음

-- ===== Pierre Certon (composer_id 395) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 0, 다악장 0, 낱곡 13),
-- 새 작품 2개, part 0개, 그 아래 0개.
-- seed 13개 중 11개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.

-- None C'Est Trop Parlé de Bacchus

UPDATE pieces piece
SET piece.title = 'C''Est Trop Parlé de Bacchus', piece.title_en = 'C''Est Trop Parlé de Bacchus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25385 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <C'est grand pitié quant argent fault>

UPDATE pieces piece
SET piece.title = '가곡 <C''est grand pitié quant argent fault>', piece.title_en = 'C''est grand pitié quant argent fault',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25338 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None De profundis

UPDATE pieces piece
SET piece.title = 'De profundis', piece.title_en = 'De profundis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24063 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En languissant avoir secours j'attens

UPDATE pieces piece
SET piece.title = 'En languissant avoir secours j''attens', piece.title_en = 'En languissant avoir secours j''attens',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24971 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exultate Justi in Domino

UPDATE pieces piece
SET piece.title = 'Exultate Justi in Domino', piece.title_en = 'Exultate Justi in Domino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24618 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je l'ay aimé>

UPDATE pieces piece
SET piece.title = '가곡 <Je l''ay aimé>', piece.title_en = 'Je l''ay aimé',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24825 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je suis un demidieu>

UPDATE pieces piece
SET piece.title = '가곡 <Je suis un demidieu>', piece.title_en = 'Je suis un demidieu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24303 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La, la, la, la je ne l'ose dire>

UPDATE pieces piece
SET piece.title = '가곡 <La, la, la, la je ne l''ose dire>', piece.title_en = 'La, la, la, la je ne l''ose dire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23088 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Adonai

UPDATE pieces piece
SET piece.title = 'O Adonai', piece.title_en = 'O Adonai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25743 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Que n'est elle auprès de moy>

UPDATE pieces piece
SET piece.title = '가곡 <Que n''est elle auprès de moy>', piece.title_en = 'Que n''est elle auprès de moy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24502 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ung Verd Galland>

UPDATE pieces piece
SET piece.title = '가곡 <Ung Verd Galland>', piece.title_en = 'Ung Verd Galland',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25354 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Inviolata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Inviolata>', 'Inviolata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 395
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Inviolata>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13ca48bc-e20e-471f-9f9f-e08d965016f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13ca48bc-e20e-471f-9f9f-e08d965016f7'
FROM pieces p
WHERE p.composer_id = 395 AND p.title = '모테트 <Inviolata>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13ca48bc-e20e-471f-9f9f-e08d965016f7'
);


-- None Super flumina Babylonis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Super flumina Babylonis', 'Super flumina Babylonis', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 395
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Super flumina Babylonis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f08e5f-b44a-4280-a46a-817cd511d950'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9f08e5f-b44a-4280-a46a-817cd511d950'
FROM pieces p
WHERE p.composer_id = 395 AND p.title = 'Super flumina Babylonis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f08e5f-b44a-4280-a46a-817cd511d950'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 395 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25666
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Gustave Doret (composer_id 398) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Heureux celui qui revoit sa patrie

UPDATE pieces piece
SET piece.title = 'Heureux celui qui revoit sa patrie', piece.title_en = 'Heureux celui qui revoit sa patrie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16468 AND piece.composer_id = 398
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 프랑수아 바쟁 (composer_id 400) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 3, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 23개, 그 아래 19개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Le Voyage en Chine>

UPDATE pieces piece
SET piece.title = '오페라 <Le Voyage en Chine>', piece.title_en = 'Le Voyage en Chine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25497 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Voyage en Chine: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf', 1, NULL, 'Acte I', 'Le Voyage en Chine: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', part.name_en = 'Le Voyage en Chine: Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690', 1, NULL, 'Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', 'Le Voyage en Chine: Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff', 2, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', part.name_en = 'Le Voyage en Chine: Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c', 3, NULL, 'Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', 'Le Voyage en Chine: Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8', 4, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4', 5, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790', 6, NULL, 'Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', 'Le Voyage en Chine: Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9', 7, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c', 8, NULL, 'Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', 'Le Voyage en Chine: Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', part.name_en = 'Le Voyage en Chine: Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c', 9, NULL, 'Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', 'Le Voyage en Chine: Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9', 10, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', part.name_en = 'Le Voyage en Chine: Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f', 11, NULL, 'Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', 'Le Voyage en Chine: Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. Ouverture', part.name_en = 'Le Voyage en Chine: Acte I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9', 12, NULL, 'Acte I. Ouverture', 'Le Voyage en Chine: Acte I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Voyage en Chine: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a', 2, NULL, 'Acte III', 'Le Voyage en Chine: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. “En Chine, en Chine” (Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte III. “En Chine, en Chine” (Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0', 1, NULL, 'Acte III. “En Chine, en Chine” (Kernoisan)', 'Le Voyage en Chine: Acte III. “En Chine, en Chine” (Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b', 2, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3', 3, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6', 4, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Quand le soleil sur notre monde” (Pompéry)', part.name_en = 'Le Voyage en Chine: Acte III. “Quand le soleil sur notre monde” (Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a', 5, NULL, 'Acte III. “Quand le soleil sur notre monde” (Pompéry)', 'Le Voyage en Chine: Acte III. “Quand le soleil sur notre monde” (Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Faut-il hisser, capitaine” (Tous)', part.name_en = 'Le Voyage en Chine: Acte III. “Faut-il hisser, capitaine” (Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c', 6, NULL, 'Acte III. “Faut-il hisser, capitaine” (Tous)', 'Le Voyage en Chine: Acte III. “Faut-il hisser, capitaine” (Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Voguons, la mer est belle” (Chœur)', part.name_en = 'Le Voyage en Chine: Acte III. “Voguons, la mer est belle” (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8', 7, NULL, 'Acte III. “Voguons, la mer est belle” (Chœur)', 'Le Voyage en Chine: Acte III. “Voguons, la mer est belle” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8'
);


-- None Le Voyage en Chine: Acte II

UPDATE pieces piece
SET piece.title = 'Le Voyage en Chine: Acte II', piece.title_en = 'Le Voyage en Chine: Acte II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24055 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86', 1, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b', 2, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', part.name_en = 'Le Voyage en Chine: Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a', 3, NULL, 'Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', 'Le Voyage en Chine: Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7', 4, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Je suis Breton” (Kernoisan, Pompéry)', part.name_en = 'Le Voyage en Chine: Acte II. “Je suis Breton” (Kernoisan, Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244', 5, NULL, 'Acte II. “Je suis Breton” (Kernoisan, Pompéry)', 'Le Voyage en Chine: Acte II. “Je suis Breton” (Kernoisan, Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Six cailloux, cinq cailloux” (Rosenville)', part.name_en = 'Le Voyage en Chine: Acte II. “Six cailloux, cinq cailloux” (Rosenville)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b', 6, NULL, 'Acte II. “Six cailloux, cinq cailloux” (Rosenville)', 'Le Voyage en Chine: Acte II. “Six cailloux, cinq cailloux” (Rosenville)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af', 7, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', part.name_en = 'Le Voyage en Chine: Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9', 8, NULL, 'Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', 'Le Voyage en Chine: Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e', 9, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', part.name_en = 'Le Voyage en Chine: Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107', 10, NULL, 'Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', 'Le Voyage en Chine: Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107'
);


-- None 오페레타 <Maître Pathelin>

UPDATE pieces piece
SET piece.title = '오페레타 <Maître Pathelin>', piece.title_en = 'Maître Pathelin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24897 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '“Veux-tu bien ranger la boutique” (Josseaume, Charlot)', part.name_en = 'Maître Pathelin: “Veux-tu bien ranger la boutique” (Josseaume, Charlot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9', 1, NULL, '“Veux-tu bien ranger la boutique” (Josseaume, Charlot)', 'Maître Pathelin: “Veux-tu bien ranger la boutique” (Josseaume, Charlot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Romance “Je pense à vous quand je m''éveille“ (Charlot)', part.name_en = 'Maître Pathelin: Romance “Je pense à vous quand je m''éveille“ (Charlot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63', 2, NULL, 'Romance “Je pense à vous quand je m''éveille“ (Charlot)', 'Maître Pathelin: Romance “Je pense à vous quand je m''éveille“ (Charlot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '“Quel air de probité” (Pathelin, Josseaume)', part.name_en = 'Maître Pathelin: “Quel air de probité” (Pathelin, Josseaume)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03', 3, NULL, '“Quel air de probité” (Pathelin, Josseaume)', 'Maître Pathelin: “Quel air de probité” (Pathelin, Josseaume)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Maître Pathelin: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e', 4, NULL, 'Ouverture', 'Maître Pathelin: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '“Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', part.name_en = 'Maître Pathelin: “Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476', 5, NULL, '“Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', 'Maître Pathelin: “Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La romance de maître Pathelin', part.name_en = 'La romance de maître Pathelin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077', 6, NULL, 'La romance de maître Pathelin', 'La romance de maître Pathelin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '“Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', part.name_en = 'Maître Pathelin: “Nous ferons ripaille (Pathelin, Guillemette, Bobinette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1', 7, NULL, '“Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', 'Maître Pathelin: “Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '“Quand on allait te faire pendre” (Pathelin, Aignelet)', part.name_en = 'Maître Pathelin: “Quand on allait te faire pendre” (Pathelin, Aignelet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2', 8, NULL, '“Quand on allait te faire pendre” (Pathelin, Aignelet)', 'Maître Pathelin: “Quand on allait te faire pendre” (Pathelin, Aignelet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '“Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', part.name_en = 'Maître Pathelin: “Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d', 9, NULL, '“Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', 'Maître Pathelin: “Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '“C''est effroyable” (Tous)', part.name_en = 'Maître Pathelin: “C''est effroyable” (Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097', 10, NULL, '“C''est effroyable” (Tous)', 'Maître Pathelin: “C''est effroyable” (Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '“Quel triste sort (Aignelet)', part.name_en = 'Maître Pathelin: “Quel triste sort (Aignelet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3', 11, NULL, '“Quel triste sort (Aignelet)', 'Maître Pathelin: “Quel triste sort (Aignelet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3'
);

-- 숨길 seed 작품 없음

-- ===== Hisato Ohzawa (composer_id 401) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 2, 낱곡 0),
-- 새 작품 1개, part 7개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 피아노 협주곡 3번 "Kamikaze"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 3번 "Kamikaze"', piece.title_en = 'Piano Concerto No. 3 "Kamikaze"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24848 AND piece.composer_id = 401
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto maestoso - Allegro assai', part.name_en = 'Piano Concerto No. 3 "Kamikaze": I. Larghetto maestoso - Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85', 1, 'I', 'Larghetto maestoso - Allegro assai', 'Piano Concerto No. 3 "Kamikaze": I. Larghetto maestoso - Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = 'Piano Concerto No. 3 "Kamikaze": II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a', 2, 'II', 'Andante cantabile', 'Piano Concerto No. 3 "Kamikaze": II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato - Allegro - Vivace', part.name_en = 'Piano Concerto No. 3 "Kamikaze": III. Allegro moderato - Allegro - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4', 3, 'III', 'Allegro moderato - Allegro - Vivace', 'Piano Concerto No. 3 "Kamikaze": III. Allegro moderato - Allegro - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4'
);


-- None 교향곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번', 'Symphony No. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 401
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d5601e6-1d5a-4029-a529-0140db708d12', 1, 'I', 'Allegretto risoluto - Allegro', 'Symphony No. 3 "Symphony of the Founding of Japan": I. Allegretto risoluto - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d5601e6-1d5a-4029-a529-0140db708d12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcddfe3-00e1-43f6-a503-4690e7085fc7', 2, 'II', 'Adagio grazioso', 'Symphony No. 3 "Symphony of the Founding of Japan": II. Adagio grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcddfe3-00e1-43f6-a503-4690e7085fc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19625ca9-bf11-43fc-8cdb-3eb2a64126d3', 3, 'III', 'Moderato (Menuet con fantasia)', 'Symphony No. 3 "Symphony of the Founding of Japan": III. Moderato (Menuet con fantasia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19625ca9-bf11-43fc-8cdb-3eb2a64126d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:575b5fa9-2bc0-414c-be83-acb75cb97cac', 4, 'IV', 'Allegro non troppo con fuoco', 'Symphony No. 3 "Symphony of the Founding of Japan": IV. Allegro non troppo con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:575b5fa9-2bc0-414c-be83-acb75cb97cac'
);

-- 숨길 seed 작품 없음

-- ===== 아서 버거 (composer_id 404) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ideas of Order

UPDATE pieces piece
SET piece.title = 'Ideas of Order', piece.title_en = 'Ideas of Order',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25528 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perspectives II

UPDATE pieces piece
SET piece.title = 'Perspectives II', piece.title_en = 'Perspectives II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25754 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polyphony

UPDATE pieces piece
SET piece.title = 'Polyphony', piece.title_en = 'Polyphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24355 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude, Aria and Waltz

UPDATE pieces piece
SET piece.title = 'Prelude, Aria and Waltz', piece.title_en = 'Prelude, Aria and Waltz',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25536 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude, Aria and Waltz: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd', 1, NULL, 'Prelude', 'Prelude, Aria and Waltz: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aria', part.name_en = 'Prelude, Aria and Waltz: Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:7020b71a-a124-4625-9a60-700650526412' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7020b71a-a124-4625-9a60-700650526412', 2, NULL, 'Aria', 'Prelude, Aria and Waltz: Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7020b71a-a124-4625-9a60-700650526412'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Prelude, Aria and Waltz: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1', 3, NULL, 'Waltz', 'Prelude, Aria and Waltz: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1'
);


-- None Serenade Concertante

UPDATE pieces piece
SET piece.title = 'Serenade Concertante', piece.title_en = 'Serenade Concertante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24879 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Murray Boren (composer_id 406) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 0개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- 숨길 seed 작품 없음

-- ===== Waldemar Kazanecki (composer_id 408) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 영화음악 <Cygańska jesień>

UPDATE pieces piece
SET piece.title = '영화음악 <Cygańska jesień>', piece.title_en = 'Cygańska jesień',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25777 AND piece.composer_id = 408
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For One String

UPDATE pieces piece
SET piece.title = 'For One String', piece.title_en = 'For One String',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26000 AND piece.composer_id = 408
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Geoffrey Shaw (composer_id 409) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <For the beauty of the earth>

UPDATE pieces piece
SET piece.title = '가곡 <For the beauty of the earth>', piece.title_en = 'For the beauty of the earth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24429 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Glad That I Live Am I>

UPDATE pieces piece
SET piece.title = '가곡 <Glad That I Live Am I>', piece.title_en = 'Glad That I Live Am I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25814 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations on an Old Carol Tune

UPDATE pieces piece
SET piece.title = 'Variations on an Old Carol Tune', piece.title_en = 'Variations on an Old Carol Tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24620 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Nicholas O'Neill (composer_id 414) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ave verum corpus

UPDATE pieces piece
SET piece.title = 'Ave verum corpus', piece.title_en = 'Ave verum corpus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24918 AND piece.composer_id = 414
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Bernardo Adam Ferrero (composer_id 416) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 0개를 작품·part 에 잇고, 0개를 숨기고, 4개는 그대로 둔다.

-- 숨길 seed 작품 없음

-- ===== 쿠르트 슈베르치크 (composer_id 420) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 0, 다악장 5, 낱곡 2),
-- 새 작품 0개, part 22개, 그 아래 0개.
-- seed 7개 중 7개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 86 Adieu Satie

UPDATE pieces piece
SET piece.title = 'Adieu Satie', piece.title_en = 'Adieu Satie, op. 86',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24258 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Parade', part.name_en = 'Adieu Satie, op. 86: I. Parade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6', 1, 'I', 'Parade', 'Adieu Satie, op. 86: I. Parade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Darius en vacances', part.name_en = 'Adieu Satie, op. 86: II. Darius en vacances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44', 2, 'II', 'Darius en vacances', 'Adieu Satie, op. 86: II. Darius en vacances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Coq et l''Arlequin', part.name_en = 'Adieu Satie, op. 86: III. Le Coq et l''Arlequin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f', 3, 'III', 'Le Coq et l''Arlequin', 'Adieu Satie, op. 86: III. Le Coq et l''Arlequin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gymnopédie', part.name_en = 'Adieu Satie, op. 86: IV. Gymnopédie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12', 4, 'IV', 'Gymnopédie', 'Adieu Satie, op. 86: IV. Gymnopédie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Clownerie acrobatique', part.name_en = 'Adieu Satie, op. 86: V. Clownerie acrobatique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed', 5, 'V', 'Clownerie acrobatique', 'Adieu Satie, op. 86: V. Clownerie acrobatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed'
);


-- Op. 65 Baumgesänge

UPDATE pieces piece
SET piece.title = 'Baumgesänge', piece.title_en = 'Baumgesänge, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25257 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Breit gesungen (Cantabile, ma pesante)', part.name_en = 'Baumgesänge, op. 65: I. Breit gesungen (Cantabile, ma pesante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017', 1, 'I', 'Breit gesungen (Cantabile, ma pesante)', 'Baumgesänge, op. 65: I. Breit gesungen (Cantabile, ma pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lebhaft, Agressiv (Vivace)', part.name_en = 'Baumgesänge, op. 65: II. Lebhaft, Agressiv (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08', 2, 'II', 'Lebhaft, Agressiv (Vivace)', 'Baumgesänge, op. 65: II. Lebhaft, Agressiv (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bleischwer (Molto pesante)', part.name_en = 'Baumgesänge, op. 65: III. Bleischwer (Molto pesante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4', 3, 'III', 'Bleischwer (Molto pesante)', 'Baumgesänge, op. 65: III. Bleischwer (Molto pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr gedehnt (Allagare il Tempo)', part.name_en = 'Baumgesänge, op. 65: IV. Sehr gedehnt (Allagare il Tempo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81', 4, 'IV', 'Sehr gedehnt (Allagare il Tempo)', 'Baumgesänge, op. 65: IV. Sehr gedehnt (Allagare il Tempo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Beweglich (Poco rubato)', part.name_en = 'Baumgesänge, op. 65: V. Beweglich (Poco rubato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5', 5, 'V', 'Beweglich (Poco rubato)', 'Baumgesänge, op. 65: V. Beweglich (Poco rubato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lebhaft, Agressiv (Vivace)', part.name_en = 'Baumgesänge, op. 65: VI. Lebhaft, Agressiv (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494', 6, 'VI', 'Lebhaft, Agressiv (Vivace)', 'Baumgesänge, op. 65: VI. Lebhaft, Agressiv (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494'
);


-- Op. 33 Epilog zu Rosamunde

UPDATE pieces piece
SET piece.title = 'Epilog zu Rosamunde', piece.title_en = 'Epilog zu Rosamunde, op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24990 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 101 Herr K entdeckt Amerika

UPDATE pieces piece
SET piece.title = 'Herr K entdeckt Amerika', piece.title_en = 'Herr K entdeckt Amerika, op. 101',
    piece.type = 'album', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25715 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Überfahrt', part.name_en = 'Herr K entdeckt Amerika, op. 101: I. Überfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c', 1, 'I', 'Überfahrt', 'Herr K entdeckt Amerika, op. 101: I. Überfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Im Hotel', part.name_en = 'Herr K entdeckt Amerika, op. 101: II. Im Hotel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4', 2, 'II', 'Im Hotel', 'Herr K entdeckt Amerika, op. 101: II. Im Hotel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Unterwegs', part.name_en = 'Herr K entdeckt Amerika, op. 101: III. Unterwegs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037', 3, 'III', 'Unterwegs', 'Herr K entdeckt Amerika, op. 101: III. Unterwegs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Das Naturtheater von Oklahoma', part.name_en = 'Herr K entdeckt Amerika, op. 101: IV. Das Naturtheater von Oklahoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096', 4, 'IV', 'Das Naturtheater von Oklahoma', 'Herr K entdeckt Amerika, op. 101: IV. Das Naturtheater von Oklahoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096'
);


-- None Locken-House/Un-Locked

UPDATE pieces piece
SET piece.title = 'Locken-House/Un-Locked', piece.title_en = 'Locken-House/Un-Locked',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24324 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 104 Nachtmusiken

UPDATE pieces piece
SET piece.title = 'Nachtmusiken', piece.title_en = 'Nachtmusiken, op. 104',
    piece.type = 'album', piece.opus_number = 'Op. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24342 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Janáček ist mir im Traum erschienen', part.name_en = 'Nachtmusiken, op. 104: I. Janáček ist mir im Traum erschienen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1', 1, 'I', 'Janáček ist mir im Traum erschienen', 'Nachtmusiken, op. 104: I. Janáček ist mir im Traum erschienen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wienerlied', part.name_en = 'Nachtmusiken, op. 104: II. Wienerlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2', 2, 'II', 'Wienerlied', 'Nachtmusiken, op. 104: II. Wienerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'for David Drew', part.name_en = 'Nachtmusiken, op. 104: III. ... for David Drew',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11', 3, 'III', 'for David Drew', 'Nachtmusiken, op. 104: III. ... for David Drew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Geschwindmarsch', part.name_en = 'Nachtmusiken, op. 104: IV. Geschwindmarsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43', 4, 'IV', 'Geschwindmarsch', 'Nachtmusiken, op. 104: IV. Geschwindmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Flucht', part.name_en = 'Nachtmusiken, op. 104: V. Flucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63', 5, 'V', 'Flucht', 'Nachtmusiken, op. 104: V. Flucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63'
);


-- None Unterwegs nach Heiligenstadt

UPDATE pieces piece
SET piece.title = 'Unterwegs nach Heiligenstadt', piece.title_en = 'Unterwegs nach Heiligenstadt',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23571 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Energico', part.name_en = 'Unterwegs nach Heiligenstadt: I. Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23571 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8', 1, 'I', 'Energico', 'Unterwegs nach Heiligenstadt: I. Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23571 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tranquillo', part.name_en = 'Unterwegs nach Heiligenstadt: II. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23571 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0', 2, 'II', 'Tranquillo', 'Unterwegs nach Heiligenstadt: II. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23571 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0'
);

-- 숨길 seed 작품 없음

-- ===== José Luis Turina (composer_id 422) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Divertimento, Aria y Serenata

UPDATE pieces piece
SET piece.title = 'Divertimento, Aria y Serenata', piece.title_en = 'Divertimento, Aria y Serenata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24180 AND piece.composer_id = 422
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movimiento

UPDATE pieces piece
SET piece.title = 'Movimiento', piece.title_en = 'Movimiento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23541 AND piece.composer_id = 422
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 장프랑수아 르쉬외르 (composer_id 423) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 16개, 그 아래 0개.
-- seed 6개 중 5개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Hymne pour l’inauguration d’un temple de la Liberté

UPDATE pieces piece
SET piece.title = 'Hymne pour l’inauguration d’un temple de la Liberté', piece.title_en = 'Hymne pour l’inauguration d’un temple de la Liberté',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24321 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marche du Sacre de Napoléon 1er

UPDATE pieces piece
SET piece.title = 'Marche du Sacre de Napoléon 1er', piece.title_en = 'Marche du Sacre de Napoléon 1er',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23060 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oratorios pour le couronnement des princes souverains de la chrétienté

UPDATE pieces piece
SET piece.title = 'Oratorios pour le couronnement des princes souverains de la chrétienté', piece.title_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24606 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino religioso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Andantino religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4', 1, NULL, 'Andantino religioso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Andantino religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto pomposo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95', 2, NULL, 'Allegretto pomposo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro pomposo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0', 3, NULL, 'Allegro pomposo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3', 4, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf', 5, NULL, 'Allegretto', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Moderato religioso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465', 6, NULL, 'Moderato religioso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'In poco lento cum antique caractere', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: In poco lento cum antique caractere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8', 7, NULL, 'In poco lento cum antique caractere', 'Oratorios pour le couronnement des princes souverains de la chrétienté: In poco lento cum antique caractere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lento sempre', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Lento sempre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4', 8, NULL, 'Lento sempre', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Lento sempre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65', 9, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Allegro spirituoso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro spirituoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9', 10, NULL, 'Allegro spirituoso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Moderato nobile', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato nobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8', 11, NULL, 'Moderato nobile', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato nobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Allegro fieramente', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro fieramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280', 12, NULL, 'Allegro fieramente', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro fieramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Gracioso affettuoso, ma fieramente', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Gracioso affettuoso, ma fieramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0', 13, NULL, 'Gracioso affettuoso, ma fieramente', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Gracioso affettuoso, ma fieramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Allegretto pomposo e nobile', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo e nobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1', 14, NULL, 'Allegretto pomposo e nobile', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo e nobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32', 15, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Moderato affettuoso collo stele antico', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato affettuoso collo stele antico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08', 16, NULL, 'Moderato affettuoso collo stele antico', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato affettuoso collo stele antico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08'
);


-- None 모테트 <Tu es Petrus>

UPDATE pieces piece
SET piece.title = '모테트 <Tu es Petrus>', piece.title_en = 'Tu es Petrus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24978 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Unxerunt Salomonem>

UPDATE pieces piece
SET piece.title = '모테트 <Unxerunt Salomonem>', piece.title_en = 'Unxerunt Salomonem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23649 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 423 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23860
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Jaroslav Krček (composer_id 425) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Mše č.9

UPDATE pieces piece
SET piece.title = 'Mše č.9', piece.title_en = 'Mše č.9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25103 AND piece.composer_id = 425
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Mše č.9: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a', 1, NULL, 'Kyrie', 'Mše č.9: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Mše č.9: Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8', 2, NULL, 'Gloria', 'Mše č.9: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Credo', part.name_en = 'Mše č.9: Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd', 3, NULL, 'Credo', 'Mše č.9: Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Mše č.9: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af', 4, NULL, 'Sanctus', 'Mše č.9: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Benedictus', part.name_en = 'Mše č.9: Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899', 5, NULL, 'Benedictus', 'Mše č.9: Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Mše č.9: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486', 6, NULL, 'Agnus Dei', 'Mše č.9: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486'
);

-- 숨길 seed 작품 없음
