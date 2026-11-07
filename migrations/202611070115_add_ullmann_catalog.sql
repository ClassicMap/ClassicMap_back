-- Viktor Ullmann 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 42개(묶음 8, 다악장 11, 낱곡 23),
-- 새 작품 4개, part 96개, 그 아래 0개.
-- seed 39개 중 38개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
--
-- 5차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave5-2026-11-07/<작곡가>/(catalog.json·seed_map.json).
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

-- None Beryozkele

UPDATE pieces piece
SET piece.title = 'Beryozkele', piece.title_en = 'Beryozkele',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25295 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 53 연가곡집 <Brezulinka (Three Yiddish Songs)> Op. 53

UPDATE pieces piece
SET piece.title = '연가곡집 <Brezulinka (Three Yiddish Songs)> Op. 53', piece.title_en = 'Brezulinka (Three Yiddish Songs), op. 53',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '53',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23081 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Berjoskele (The Little Birch)', part.name_en = 'Brezulinka (Three Yiddish Songs), op. 53: 1. Berjoskele (The Little Birch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23081 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:6e166c82-b68c-4e56-aed0-9b01ebeec0a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e166c82-b68c-4e56-aed0-9b01ebeec0a1', 1, NULL, 'Berjoskele (The Little Birch)', 'Brezulinka (Three Yiddish Songs), op. 53: 1. Berjoskele (The Little Birch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23081 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e166c82-b68c-4e56-aed0-9b01ebeec0a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Margaritkelech (Little Margaret)', part.name_en = 'Brezulinka (Three Yiddish Songs), op. 53: 2. Margaritkelech (Little Margaret)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23081 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:ceaef15b-20f2-4886-aa79-fa40d0896f2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceaef15b-20f2-4886-aa79-fa40d0896f2a', 2, NULL, 'Margaritkelech (Little Margaret)', 'Brezulinka (Three Yiddish Songs), op. 53: 2. Margaritkelech (Little Margaret)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23081 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceaef15b-20f2-4886-aa79-fa40d0896f2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Maydl in di Yorn (A Maiden No Longer Young)', part.name_en = 'Brezulinka (Three Yiddish Songs), op. 53: 3. A Maydl in di Yorn (A Maiden No Longer Young)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23081 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:10f0c3f6-6f98-4f49-8ea6-daa81f7f2f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10f0c3f6-6f98-4f49-8ea6-daa81f7f2f03', 3, NULL, 'A Maydl in di Yorn (A Maiden No Longer Young)', 'Brezulinka (Three Yiddish Songs), op. 53: 3. A Maydl in di Yorn (A Maiden No Longer Young)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23081 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10f0c3f6-6f98-4f49-8ea6-daa81f7f2f03'
);


-- None 오페라 <Der Kaiser von Atlantis>

UPDATE pieces piece
SET piece.title = '오페라 <Der Kaiser von Atlantis>', piece.title_en = 'Der Kaiser von Atlantis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25708 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hallo, hallo!', part.name_en = 'Der Kaiser von Atlantis: I. Hallo, hallo!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:7f390604-20f1-4fbe-84c6-06143a50ddae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f390604-20f1-4fbe-84c6-06143a50ddae', 1, 'I', 'Hallo, hallo!', 'Der Kaiser von Atlantis: I. Hallo, hallo!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f390604-20f1-4fbe-84c6-06143a50ddae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Präludium', part.name_en = 'Der Kaiser von Atlantis: II. Präludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:4d0ba2ff-8a7a-448d-ba5a-0cef78272f80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0ba2ff-8a7a-448d-ba5a-0cef78272f80', 2, 'II', 'Präludium', 'Der Kaiser von Atlantis: II. Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0ba2ff-8a7a-448d-ba5a-0cef78272f80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Der Mond geht auf den Firsten', part.name_en = 'Der Kaiser von Atlantis: III. Der Mond geht auf den Firsten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:f590910e-104a-4af9-8347-f353e5d82d47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f590910e-104a-4af9-8347-f353e5d82d47', 3, 'III', 'Der Mond geht auf den Firsten', 'Der Kaiser von Atlantis: III. Der Mond geht auf den Firsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f590910e-104a-4af9-8347-f353e5d82d47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lass sein. Was singst du da? – Tage, Tage', part.name_en = 'Der Kaiser von Atlantis: IV. Lass sein. Was singst du da? – Tage, Tage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:edd69971-0271-4df3-8cd1-6baf5e230a72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edd69971-0271-4df3-8cd1-6baf5e230a72', 4, 'IV', 'Lass sein. Was singst du da? – Tage, Tage', 'Der Kaiser von Atlantis: IV. Lass sein. Was singst du da? – Tage, Tage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd69971-0271-4df3-8cd1-6baf5e230a72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ich fühle mich wenig wohl', part.name_en = 'Der Kaiser von Atlantis: V. Ich fühle mich wenig wohl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:25da2c61-0da1-497b-8189-eaf50914a699' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25da2c61-0da1-497b-8189-eaf50914a699', 5, 'V', 'Ich fühle mich wenig wohl', 'Der Kaiser von Atlantis: V. Ich fühle mich wenig wohl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25da2c61-0da1-497b-8189-eaf50914a699'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Das waren Kriege', part.name_en = 'Der Kaiser von Atlantis: VI. Das waren Kriege',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:8c509310-ea30-4a68-a094-e19fea52af6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c509310-ea30-4a68-a094-e19fea52af6d', 6, 'VI', 'Das waren Kriege', 'Der Kaiser von Atlantis: VI. Das waren Kriege', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c509310-ea30-4a68-a094-e19fea52af6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Hallo, hallo! Achtung! Achtung!', part.name_en = 'Der Kaiser von Atlantis: VII. Hallo, hallo! Achtung! Achtung!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:d6f8058e-4fa5-4399-bc03-81383021b872' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6f8058e-4fa5-4399-bc03-81383021b872', 7, 'VII', 'Hallo, hallo! Achtung! Achtung!', 'Der Kaiser von Atlantis: VII. Hallo, hallo! Achtung! Achtung!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6f8058e-4fa5-4399-bc03-81383021b872'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Intermezzo “Totentanz”', part.name_en = 'Der Kaiser von Atlantis: VIII. Intermezzo “Totentanz”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:ff706e35-d047-4b30-97c5-24177901217c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff706e35-d047-4b30-97c5-24177901217c', 8, 'VIII', 'Intermezzo “Totentanz”', 'Der Kaiser von Atlantis: VIII. Intermezzo “Totentanz”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff706e35-d047-4b30-97c5-24177901217c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Wie spät ist es? – Bin ich wahnsinnig', part.name_en = 'Der Kaiser von Atlantis: IX. Wie spät ist es? – Bin ich wahnsinnig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:b7d82dd9-036d-4fc1-8cd6-2bfcf18847e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7d82dd9-036d-4fc1-8cd6-2bfcf18847e9', 9, 'IX', 'Wie spät ist es? – Bin ich wahnsinnig', 'Der Kaiser von Atlantis: IX. Wie spät ist es? – Bin ich wahnsinnig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7d82dd9-036d-4fc1-8cd6-2bfcf18847e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Intermezzo', part.name_en = 'Der Kaiser von Atlantis: X. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:da647690-362d-4292-985c-eecedac4d9ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da647690-362d-4292-985c-eecedac4d9ff', 10, 'X', 'Intermezzo', 'Der Kaiser von Atlantis: X. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da647690-362d-4292-985c-eecedac4d9ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Wer da? – Halt! Steh!', part.name_en = 'Der Kaiser von Atlantis: XI. Wer da? – Halt! Steh!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:792e0ef2-c35f-4f4f-bb7c-4913e63c51a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792e0ef2-c35f-4f4f-bb7c-4913e63c51a8', 11, 'XI', 'Wer da? – Halt! Steh!', 'Der Kaiser von Atlantis: XI. Wer da? – Halt! Steh!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792e0ef2-c35f-4f4f-bb7c-4913e63c51a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Ist’s wahr, dass es Landschaften gibt', part.name_en = 'Der Kaiser von Atlantis: XII. Ist’s wahr, dass es Landschaften gibt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:199f5c52-0a42-4735-abcc-cbd351fc6d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:199f5c52-0a42-4735-abcc-cbd351fc6d5b', 12, 'XII', 'Ist’s wahr, dass es Landschaften gibt', 'Der Kaiser von Atlantis: XII. Ist’s wahr, dass es Landschaften gibt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199f5c52-0a42-4735-abcc-cbd351fc6d5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Kommt fort von hier', part.name_en = 'Der Kaiser von Atlantis: XIII. Kommt fort von hier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:dc7e5147-b4be-4752-9b7c-5db65c6d316e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc7e5147-b4be-4752-9b7c-5db65c6d316e', 13, 'XIII', 'Kommt fort von hier', 'Der Kaiser von Atlantis: XIII. Kommt fort von hier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7e5147-b4be-4752-9b7c-5db65c6d316e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Schau, die Wolken', part.name_en = 'Der Kaiser von Atlantis: XIV. Schau, die Wolken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:8b2bda45-5b1a-4722-8b25-b6f129826b8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b2bda45-5b1a-4722-8b25-b6f129826b8f', 14, 'XIV', 'Schau, die Wolken', 'Der Kaiser von Atlantis: XIV. Schau, die Wolken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b2bda45-5b1a-4722-8b25-b6f129826b8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Tanz‐Intermezzo “Die lebenden Toten”', part.name_en = 'Der Kaiser von Atlantis: XV. Tanz‐Intermezzo “Die lebenden Toten”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:2d56919b-2964-47a4-8e5e-0cd949ec8425' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d56919b-2964-47a4-8e5e-0cd949ec8425', 15, 'XV', 'Tanz‐Intermezzo “Die lebenden Toten”', 'Der Kaiser von Atlantis: XV. Tanz‐Intermezzo “Die lebenden Toten”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d56919b-2964-47a4-8e5e-0cd949ec8425'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Wir sind um einen Kreuzer Süsses', part.name_en = 'Der Kaiser von Atlantis: XVI. Wir sind um einen Kreuzer Süsses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:835dec74-7216-46a4-852c-2a3ac5ae2c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:835dec74-7216-46a4-852c-2a3ac5ae2c6e', 16, 'XVI', 'Wir sind um einen Kreuzer Süsses', 'Der Kaiser von Atlantis: XVI. Wir sind um einen Kreuzer Süsses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:835dec74-7216-46a4-852c-2a3ac5ae2c6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Fünf, sechs, sieben – Nicht dran denken', part.name_en = 'Der Kaiser von Atlantis: XVII. Fünf, sechs, sieben – Nicht dran denken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:3c10a691-c75e-4bd0-bb7e-aedbc7c082da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c10a691-c75e-4bd0-bb7e-aedbc7c082da', 17, 'XVII', 'Fünf, sechs, sieben – Nicht dran denken', 'Der Kaiser von Atlantis: XVII. Fünf, sechs, sieben – Nicht dran denken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c10a691-c75e-4bd0-bb7e-aedbc7c082da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = 'Ich bin der Tod', part.name_en = 'Der Kaiser von Atlantis: XVIII. Ich bin der Tod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:407e9ecc-6b0e-4292-98c8-da3c6b87ae1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:407e9ecc-6b0e-4292-98c8-da3c6b87ae1e', 18, 'XVIII', 'Ich bin der Tod', 'Der Kaiser von Atlantis: XVIII. Ich bin der Tod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:407e9ecc-6b0e-4292-98c8-da3c6b87ae1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'XIX',
    part.name_ko = 'Von allem, was geschieht', part.name_en = 'Der Kaiser von Atlantis: XIX. Von allem, was geschieht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:9df95095-ef96-48a7-8afe-2561bf12ee44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df95095-ef96-48a7-8afe-2561bf12ee44', 19, 'XIX', 'Von allem, was geschieht', 'Der Kaiser von Atlantis: XIX. Von allem, was geschieht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df95095-ef96-48a7-8afe-2561bf12ee44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'XX',
    part.name_ko = 'Komm Tod, du unser werter Gast', part.name_en = 'Der Kaiser von Atlantis: XX. Komm Tod, du unser werter Gast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:bc84b1a6-1eff-4789-91fc-6f6b19e4d3e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc84b1a6-1eff-4789-91fc-6f6b19e4d3e9', 20, 'XX', 'Komm Tod, du unser werter Gast', 'Der Kaiser von Atlantis: XX. Komm Tod, du unser werter Gast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc84b1a6-1eff-4789-91fc-6f6b19e4d3e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = 'XXI',
    part.name_ko = 'Der Krieg ist aus! – Komm Tod', part.name_en = 'Der Kaiser von Atlantis: XXI. Der Krieg ist aus! – Komm Tod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25708 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:9eeb82c6-801a-49c1-a4b0-2b4437d222c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eeb82c6-801a-49c1-a4b0-2b4437d222c2', 21, 'XXI', 'Der Krieg ist aus! – Komm Tod', 'Der Kaiser von Atlantis: XXI. Der Krieg ist aus! – Komm Tod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25708 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eeb82c6-801a-49c1-a4b0-2b4437d222c2'
);


-- Op. 47 연가곡집 <Der Mensch und sein Tag> Op. 47

UPDATE pieces piece
SET piece.title = '연가곡집 <Der Mensch und sein Tag> Op. 47', piece.title_en = 'Der Mensch und sein Tag, op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25594 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gebete', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 8 Gebete',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:031ddcae-38d0-4292-90df-95f88f861bb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:031ddcae-38d0-4292-90df-95f88f861bb2', 1, NULL, 'Gebete', 'Der Mensch und sein Tag, op. 47: No. 8 Gebete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031ddcae-38d0-4292-90df-95f88f861bb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gesang', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 2 Gesang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:372d16db-22ff-4182-b382-07f03727aa96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:372d16db-22ff-4182-b382-07f03727aa96', 2, NULL, 'Gesang', 'Der Mensch und sein Tag, op. 47: No. 2 Gesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372d16db-22ff-4182-b382-07f03727aa96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Blüten', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 5 Blüten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:3fc25cf9-5537-44a9-900d-09c5a477af7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fc25cf9-5537-44a9-900d-09c5a477af7f', 3, NULL, 'Blüten', 'Der Mensch und sein Tag, op. 47: No. 5 Blüten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fc25cf9-5537-44a9-900d-09c5a477af7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Heimat', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 3 Heimat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:4500ec4d-92f5-4f4a-8bcf-d09ad41b1a7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4500ec4d-92f5-4f4a-8bcf-d09ad41b1a7a', 4, NULL, 'Heimat', 'Der Mensch und sein Tag, op. 47: No. 3 Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4500ec4d-92f5-4f4a-8bcf-d09ad41b1a7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Der Nachbar', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 7 Der Nachbar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:4c89c0e7-54f9-4372-bd9a-0da6612dcd83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c89c0e7-54f9-4372-bd9a-0da6612dcd83', 5, NULL, 'Der Nachbar', 'Der Mensch und sein Tag, op. 47: No. 7 Der Nachbar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c89c0e7-54f9-4372-bd9a-0da6612dcd83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Stille', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 12 Stille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:5c92c8c6-e8c3-46b5-9d40-9e293b02b61d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c92c8c6-e8c3-46b5-9d40-9e293b02b61d', 6, NULL, 'Stille', 'Der Mensch und sein Tag, op. 47: No. 12 Stille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c92c8c6-e8c3-46b5-9d40-9e293b02b61d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Verdämmern', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 10 Verdämmern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:94222f1c-be1c-4e6c-b184-0006cbfd173e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94222f1c-be1c-4e6c-b184-0006cbfd173e', 7, NULL, 'Verdämmern', 'Der Mensch und sein Tag, op. 47: No. 10 Verdämmern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94222f1c-be1c-4e6c-b184-0006cbfd173e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Gang in den Morgen', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 1 Gang in den Morgen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:a97a5d15-a043-4cd2-b27e-5e8709d26e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a97a5d15-a043-4cd2-b27e-5e8709d26e1d', 8, NULL, 'Gang in den Morgen', 'Der Mensch und sein Tag, op. 47: No. 1 Gang in den Morgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97a5d15-a043-4cd2-b27e-5e8709d26e1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Im Walde', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 9 Im Walde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:aa0d3d70-f88c-4a38-be52-9d06b2cc670a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0d3d70-f88c-4a38-be52-9d06b2cc670a', 9, NULL, 'Im Walde', 'Der Mensch und sein Tag, op. 47: No. 9 Im Walde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0d3d70-f88c-4a38-be52-9d06b2cc670a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Der Liebsten', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 4 Der Liebsten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:aae0a449-2be6-4d32-b29f-9632b3ffe6de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aae0a449-2be6-4d32-b29f-9632b3ffe6de', 10, NULL, 'Der Liebsten', 'Der Mensch und sein Tag, op. 47: No. 4 Der Liebsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae0a449-2be6-4d32-b29f-9632b3ffe6de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Nacht', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 11 Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:dbffd05d-ef27-4e05-81e9-726214c3fa9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbffd05d-ef27-4e05-81e9-726214c3fa9d', 11, NULL, 'Nacht', 'Der Mensch und sein Tag, op. 47: No. 11 Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbffd05d-ef27-4e05-81e9-726214c3fa9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'In der Stube', part.name_en = 'Der Mensch und sein Tag, op. 47: No. 6 In der Stube',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25594 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:df2d6b84-7351-46be-bf50-cb74a9306398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df2d6b84-7351-46be-bf50-cb74a9306398', 12, NULL, 'In der Stube', 'Der Mensch und sein Tag, op. 47: No. 6 In der Stube', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25594 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df2d6b84-7351-46be-bf50-cb74a9306398'
);


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24319 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 1. »… den 24. November 1663 wirde Otto von Rilke«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 1. »… den 24. November 1663 wirde Otto von Rilke«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 1. »… den 24. November 1663 wirde Otto von Rilke«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24042 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 2. »Reiten, reiten, reiten, durch den Tag«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 2. »Reiten, reiten, reiten, durch den Tag«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 2. »Reiten, reiten, reiten, durch den Tag«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23630 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 3. Ruhige Bewegung. »Jemand erzählt von seiner Mutter«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 3. Ruhige Bewegung. »Jemand erzählt von seiner Mutter«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 3. Ruhige Bewegung. »Jemand erzählt von seiner Mutter«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25868 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 4. Molto allegro. »Ein Tag durch den Tross«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 4. Molto allegro. »Ein Tag durch den Tross«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 4. Molto allegro. »Ein Tag durch den Tross«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25227 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 5. Allegretto cantabile. »Der von Langenau schreibt einen Brief«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 5. Allegretto cantabile. »Der von Langenau schreibt einen Brief«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Erster Teil. 5. Allegretto cantabile. »Der von Langenau schreibt einen Brief«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25206 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 1. Sehr ruhig. »Rast! Gast sein einmal«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 1. Sehr ruhig. »Rast! Gast sein einmal«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 1. Sehr ruhig. »Rast! Gast sein einmal«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24101 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 2. Allegro grazioso. »Als Mahl begann's«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 2. Allegro grazioso. »Als Mahl begann''s«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 2. Allegro grazioso. »Als Mahl begann''s«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23327 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 3. Adagio - Andante tranquillo. »Einer, der weiße Seide trägt«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 3. Adagio - Andante tranquillo. »Einer, der weiße Seide trägt«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 3. Adagio - Andante tranquillo. »Einer, der weiße Seide trägt«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23947 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 4. Unruhig, bewegt. »Die Turmstube ist dunkel«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 4. Unruhig, bewegt. »Die Turmstube ist dunkel«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 4. Unruhig, bewegt. »Die Turmstube ist dunkel«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25823 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 5. Andante. »Ist das der Morgen?«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 5. Andante. »Ist das der Morgen?«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 5. Andante. »Ist das der Morgen?«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24770 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 6. Allegro molto, agité. »Aber die Fahne ist nicht dabei«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 6. Allegro molto, agité. »Aber die Fahne ist nicht dabei«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 6. Allegro molto, agité. »Aber die Fahne ist nicht dabei«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25484 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 7. Prestissimo. »Er läuft um die Wette mit brennenden Gängen«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 7. Prestissimo. »Er läuft um die Wette mit brennenden Gängen«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 7. Prestissimo. »Er läuft um die Wette mit brennenden Gängen«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23530 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 8. Finale. Langsamer als in Nr. 2; mäßige Halbe. »Im nächsten Frühjahr«

UPDATE pieces piece
SET piece.title = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 8. Finale. Langsamer als in Nr. 2; mäßige Halbe. »Im nächsten Frühjahr«', piece.title_en = 'Die Weise von Liebe und Tod des Cornets Christoph Rilke: Zweiter Teil. 8. Finale. Langsamer als in Nr. 2; mäßige Halbe. »Im nächsten Frühjahr«',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23939 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drei Lieder nach Gedichten von Friedrich Hölderlin

UPDATE pieces piece
SET piece.title = 'Drei Lieder nach Gedichten von Friedrich Hölderlin', piece.title_en = 'Drei Lieder nach Gedichten von Friedrich Hölderlin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23077 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wo bist du?', part.name_en = 'Drei Lieder nach Gedichten von Friedrich Hölderlin: Nr. 1. Wo bist du?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23077 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:4f28c759-5543-469b-af54-c98b6cdb1ced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f28c759-5543-469b-af54-c98b6cdb1ced', 1, NULL, 'Wo bist du?', 'Drei Lieder nach Gedichten von Friedrich Hölderlin: Nr. 1. Wo bist du?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23077 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f28c759-5543-469b-af54-c98b6cdb1ced'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Frühling', part.name_en = 'Drei Lieder nach Gedichten von Friedrich Hölderlin: Nr. 2. Der Frühling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23077 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:8c46c4b7-7351-4ac7-8f4f-a84bd2487a00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c46c4b7-7351-4ac7-8f4f-a84bd2487a00', 2, NULL, 'Der Frühling', 'Drei Lieder nach Gedichten von Friedrich Hölderlin: Nr. 2. Der Frühling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23077 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c46c4b7-7351-4ac7-8f4f-a84bd2487a00'
);


-- Op. 37 Drei Lieder Op. 37

UPDATE pieces piece
SET piece.title = 'Drei Lieder Op. 37', piece.title_en = 'Drei Lieder, op. 37',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '37',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24322 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Schnitterlied, op. 37 no. 1', part.name_en = 'Schnitterlied, op. 37 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24322 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:803fb1be-fff8-45c6-af3b-e0ca665da4b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803fb1be-fff8-45c6-af3b-e0ca665da4b2', 1, NULL, 'Schnitterlied, op. 37 no. 1', 'Schnitterlied, op. 37 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24322 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803fb1be-fff8-45c6-af3b-e0ca665da4b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Säerspruch, op. 37 no. 2', part.name_en = 'Säerspruch, op. 37 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24322 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:0e251724-31aa-44ad-b9c8-39a8e3171e40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e251724-31aa-44ad-b9c8-39a8e3171e40', 2, NULL, 'Säerspruch, op. 37 no. 2', 'Säerspruch, op. 37 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24322 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e251724-31aa-44ad-b9c8-39a8e3171e40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Die Schweizer, op. 37 no. 3', part.name_en = 'Die Schweizer, op. 37 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24322 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:b2e85a07-ce97-4c14-905b-efc988f4bf38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e85a07-ce97-4c14-905b-efc988f4bf38', 3, NULL, 'Die Schweizer, op. 37 no. 3', 'Die Schweizer, op. 37 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24322 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e85a07-ce97-4c14-905b-efc988f4bf38'
);


-- Op. 29 연가곡집 <Drei Sonette aus dem Portugiesischen> Op. 29

UPDATE pieces piece
SET piece.title = '연가곡집 <Drei Sonette aus dem Portugiesischen> Op. 29', piece.title_en = 'Drei Sonette aus dem Portugiesischen, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25203 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sag immer wieder', part.name_en = 'Drei Sonette aus dem Portugiesischen, op. 29: Sag immer wieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25203 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:a18a69a6-1bac-4dac-bec5-34f0c39e053b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a18a69a6-1bac-4dac-bec5-34f0c39e053b', 1, NULL, 'Sag immer wieder', 'Drei Sonette aus dem Portugiesischen, op. 29: Sag immer wieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25203 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a18a69a6-1bac-4dac-bec5-34f0c39e053b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Briefe, nun mein!', part.name_en = 'Drei Sonette aus dem Portugiesischen, op. 29: Briefe, nun mein!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25203 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:e61e4006-303e-4ef8-ac9e-18f9fbe37260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e61e4006-303e-4ef8-ac9e-18f9fbe37260', 2, NULL, 'Briefe, nun mein!', 'Drei Sonette aus dem Portugiesischen, op. 29: Briefe, nun mein!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25203 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e61e4006-303e-4ef8-ac9e-18f9fbe37260'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sein erster Kuß', part.name_en = 'Drei Sonette aus dem Portugiesischen, op. 29: Sein erster Kuß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25203 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:f70760ed-58fc-4d28-ae15-d8a8ced703b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f70760ed-58fc-4d28-ae15-d8a8ced703b1', 3, NULL, 'Sein erster Kuß', 'Drei Sonette aus dem Portugiesischen, op. 29: Sein erster Kuß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25203 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f70760ed-58fc-4d28-ae15-d8a8ced703b1'
);


-- None Drei hebräische Knabenchöre

UPDATE pieces piece
SET piece.title = 'Drei hebräische Knabenchöre', piece.title_en = 'Drei hebräische Knabenchöre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24218 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hedad, Hedad, Gina Ktana!', part.name_en = 'Drei hebräische Knabenchöre: Hedad, Hedad, Gina Ktana!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24218 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:172f9aec-4b62-4ae3-9b33-043448ac7b5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:172f9aec-4b62-4ae3-9b33-043448ac7b5e', 1, NULL, 'Hedad, Hedad, Gina Ktana!', 'Drei hebräische Knabenchöre: Hedad, Hedad, Gina Ktana!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24218 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:172f9aec-4b62-4ae3-9b33-043448ac7b5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Haleluja! Bezilzele Schama', part.name_en = 'Drei hebräische Knabenchöre: Haleluja! Bezilzele Schama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24218 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:3b84e2d0-5ce9-41e6-8b19-1ddf492f57e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b84e2d0-5ce9-41e6-8b19-1ddf492f57e6', 2, NULL, 'Haleluja! Bezilzele Schama', 'Drei hebräische Knabenchöre: Haleluja! Bezilzele Schama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24218 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b84e2d0-5ce9-41e6-8b19-1ddf492f57e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A''mcha Jissrael Jibane', part.name_en = 'Drei hebräische Knabenchöre: A''mcha Jissrael Jibane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24218 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:d78b1448-81ea-433c-a648-f2f828b7a45c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d78b1448-81ea-433c-a648-f2f828b7a45c', 3, NULL, 'A''mcha Jissrael Jibane', 'Drei hebräische Knabenchöre: A''mcha Jissrael Jibane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24218 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78b1448-81ea-433c-a648-f2f828b7a45c'
);


-- None 칸타타 <Immer inmitten>

UPDATE pieces piece
SET piece.title = '칸타타 <Immer inmitten>', piece.title_en = 'Immer inmitten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25849 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lieder der Tröstung

UPDATE pieces piece
SET piece.title = 'Lieder der Tröstung', piece.title_en = 'Lieder der Tröstung',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24044 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Herbst', part.name_en = 'Lieder der Tröstung: No. 1. Herbst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24044 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:3989ad51-20d9-49b0-89e3-19c05d91ef5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3989ad51-20d9-49b0-89e3-19c05d91ef5d', 1, NULL, 'Herbst', 'Lieder der Tröstung: No. 1. Herbst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24044 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3989ad51-20d9-49b0-89e3-19c05d91ef5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tote wollen nicht verweilen', part.name_en = 'Lieder der Tröstung: No. 2. Tote wollen nicht verweilen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24044 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:ece44081-08ac-46d7-8689-65f8dcd0f7ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece44081-08ac-46d7-8689-65f8dcd0f7ad', 2, NULL, 'Tote wollen nicht verweilen', 'Lieder der Tröstung: No. 2. Tote wollen nicht verweilen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24044 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece44081-08ac-46d7-8689-65f8dcd0f7ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Erwachen zu Weihnachten', part.name_en = 'Lieder der Tröstung: No. 3. Erwachen zu Weihnachten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24044 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:84221f19-eb86-44d6-9742-7f81d38f3d75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84221f19-eb86-44d6-9742-7f81d38f3d75', 3, NULL, 'Erwachen zu Weihnachten', 'Lieder der Tröstung: No. 3. Erwachen zu Weihnachten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24044 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84221f19-eb86-44d6-9742-7f81d38f3d75'
);


-- None 가곡 <Little Cakewalk>

UPDATE pieces piece
SET piece.title = '가곡 <Little Cakewalk>', piece.title_en = 'Little Cakewalk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23125 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Menuett (Totentanz)

UPDATE pieces piece
SET piece.title = 'Menuett (Totentanz)', piece.title_en = 'Menuett (Totentanz)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24999 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 25 피아노 협주곡

UPDATE pieces piece
SET piece.title = '피아노 협주곡', piece.title_en = 'Piano Concerto, op. 25',
    piece.type = 'album', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23899 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Piano Concerto, op. 25: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23899 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:b569e58d-4029-4ca5-bc33-8e4131720d98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b569e58d-4029-4ca5-bc33-8e4131720d98', 1, 'I', 'Allegro con fuoco', 'Piano Concerto, op. 25: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23899 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b569e58d-4029-4ca5-bc33-8e4131720d98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo - Largo', part.name_en = 'Piano Concerto, op. 25: II. Andante tranquillo - Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23899 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:f68ade78-0eac-4bf2-a396-99dd973c83fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f68ade78-0eac-4bf2-a396-99dd973c83fa', 2, 'II', 'Andante tranquillo - Largo', 'Piano Concerto, op. 25: II. Andante tranquillo - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23899 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f68ade78-0eac-4bf2-a396-99dd973c83fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro - Vivo', part.name_en = 'Piano Concerto, op. 25: III. Allegro - Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23899 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:177d6f2a-ebd9-4d2d-90f6-a921e6fd2c8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:177d6f2a-ebd9-4d2d-90f6-a921e6fd2c8d', 3, 'III', 'Allegro - Vivo', 'Piano Concerto, op. 25: III. Allegro - Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23899 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:177d6f2a-ebd9-4d2d-90f6-a921e6fd2c8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'Piano Concerto, op. 25: IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23899 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:188756cc-403f-4800-9cdd-89ae5892df3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:188756cc-403f-4800-9cdd-89ae5892df3f', 4, 'IV', 'Allegro molto', 'Piano Concerto, op. 25: IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23899 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:188756cc-403f-4800-9cdd-89ae5892df3f'
);


-- None 피아노 소나타 4번

UPDATE pieces piece
SET piece.title = '피아노 소나타 4번', piece.title_en = 'Piano Sonata no. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23739 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Piano Sonata no. 4: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23739 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:998b71a5-fddf-4a17-958d-e4fb48c4342b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:998b71a5-fddf-4a17-958d-e4fb48c4342b', 1, 'I', 'Allegro vivace', 'Piano Sonata no. 4: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23739 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:998b71a5-fddf-4a17-958d-e4fb48c4342b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Piano Sonata no. 4: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23739 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:43d6b235-2cd0-4006-8c7f-8119a35620f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43d6b235-2cd0-4006-8c7f-8119a35620f4', 2, 'II', 'Adagio', 'Piano Sonata no. 4: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23739 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d6b235-2cd0-4006-8c7f-8119a35620f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Vivace molto - Presto', part.name_en = 'Piano Sonata no. 4: III. Finale: Vivace molto - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23739 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:71021094-05e4-4234-b242-60c2a0bc28a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71021094-05e4-4234-b242-60c2a0bc28a7', 3, 'III', 'Finale: Vivace molto - Presto', 'Piano Sonata no. 4: III. Finale: Vivace molto - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23739 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71021094-05e4-4234-b242-60c2a0bc28a7'
);


-- None 피아노 소나타 5번

UPDATE pieces piece
SET piece.title = '피아노 소나타 5번', piece.title_en = 'Piano Sonata no. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23386 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Piano Sonata no. 5: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23386 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:b70c8154-9ed1-4b4e-80b8-82f18e2a445c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b70c8154-9ed1-4b4e-80b8-82f18e2a445c', 1, 'I', 'Allegro con brio', 'Piano Sonata no. 5: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23386 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b70c8154-9ed1-4b4e-80b8-82f18e2a445c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Sonata no. 5: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23386 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:a44ffd84-955d-4d58-a071-7794925d1e39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a44ffd84-955d-4d58-a071-7794925d1e39', 2, 'II', 'Andante', 'Piano Sonata no. 5: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23386 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44ffd84-955d-4d58-a071-7794925d1e39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccatina: Vivace', part.name_en = 'Piano Sonata no. 5: III. Toccatina: Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23386 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:fe29479d-0bc0-44b1-b8a9-df68b3a24083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe29479d-0bc0-44b1-b8a9-df68b3a24083', 3, 'III', 'Toccatina: Vivace', 'Piano Sonata no. 5: III. Toccatina: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23386 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe29479d-0bc0-44b1-b8a9-df68b3a24083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Serenade: Comodo - Piu allegro', part.name_en = 'Piano Sonata no. 5: IV. Serenade: Comodo - Piu allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23386 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:5a209ace-6631-4aad-bba1-7f3ff3d6c6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a209ace-6631-4aad-bba1-7f3ff3d6c6a2', 4, 'IV', 'Serenade: Comodo - Piu allegro', 'Piano Sonata no. 5: IV. Serenade: Comodo - Piu allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23386 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a209ace-6631-4aad-bba1-7f3ff3d6c6a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale fugato: Allegro molto', part.name_en = 'Piano Sonata no. 5: V. Finale fugato: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23386 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:5d572915-17b0-4ef5-be3d-dd890ec70c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d572915-17b0-4ef5-be3d-dd890ec70c6b', 5, 'V', 'Finale fugato: Allegro molto', 'Piano Sonata no. 5: V. Finale fugato: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23386 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d572915-17b0-4ef5-be3d-dd890ec70c6b'
);


-- None 피아노 소나타 6번

UPDATE pieces piece
SET piece.title = '피아노 소나타 6번', piece.title_en = 'Piano Sonata no. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24933 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto - Andante poco adagio', part.name_en = 'Piano Sonata no. 6: I. Allegro molto - Andante poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24933 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:313fabba-b3f6-4f94-882e-a56de0667df7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313fabba-b3f6-4f94-882e-a56de0667df7', 1, 'I', 'Allegro molto - Andante poco adagio', 'Piano Sonata no. 6: I. Allegro molto - Andante poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24933 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313fabba-b3f6-4f94-882e-a56de0667df7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto grazioso', part.name_en = 'Piano Sonata no. 6: II. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24933 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:35617903-27a8-44fc-b413-2219ecc3989c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35617903-27a8-44fc-b413-2219ecc3989c', 2, 'II', 'Allegretto grazioso', 'Piano Sonata no. 6: II. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24933 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35617903-27a8-44fc-b413-2219ecc3989c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto, ma non troppo', part.name_en = 'Piano Sonata no. 6: III. Presto, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24933 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:328c42dc-e985-4ced-a72e-b6661db8e0e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328c42dc-e985-4ced-a72e-b6661db8e0e2', 3, 'III', 'Presto, ma non troppo', 'Piano Sonata no. 6: III. Presto, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24933 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328c42dc-e985-4ced-a72e-b6661db8e0e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tempo I [Allegro molto]', part.name_en = 'Piano Sonata no. 6: IV. Tempo I [Allegro molto]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24933 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:eb911570-f691-4db0-b165-facb244e3abf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb911570-f691-4db0-b165-facb244e3abf', 4, 'IV', 'Tempo I [Allegro molto]', 'Piano Sonata no. 6: IV. Tempo I [Allegro molto]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24933 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb911570-f691-4db0-b165-facb244e3abf'
);


-- None 피아노 소나타 7번

UPDATE pieces piece
SET piece.title = '피아노 소나타 7번', piece.title_en = 'Piano Sonata no. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24301 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, Gemächliche', part.name_en = 'Piano Sonata no. 7: I. Allegro, Gemächliche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24301 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:afb5c943-8457-4dd3-a4e6-bd152b5f7fac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb5c943-8457-4dd3-a4e6-bd152b5f7fac', 1, 'I', 'Allegro, Gemächliche', 'Piano Sonata no. 7: I. Allegro, Gemächliche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24301 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb5c943-8457-4dd3-a4e6-bd152b5f7fac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Alla marcia, ben misurato', part.name_en = 'Piano Sonata no. 7: II. Alla marcia, ben misurato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24301 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:44886b59-f55a-4f5e-a605-1aba109a3fa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44886b59-f55a-4f5e-a605-1aba109a3fa2', 2, 'II', 'Alla marcia, ben misurato', 'Piano Sonata no. 7: II. Alla marcia, ben misurato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24301 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44886b59-f55a-4f5e-a605-1aba109a3fa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio, ma con moto', part.name_en = 'Piano Sonata no. 7: III. Adagio, ma con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24301 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:180e83ff-5450-44a4-b5c7-851f0323ef92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180e83ff-5450-44a4-b5c7-851f0323ef92', 3, 'III', 'Adagio, ma con moto', 'Piano Sonata no. 7: III. Adagio, ma con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24301 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180e83ff-5450-44a4-b5c7-851f0323ef92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scherzo: Allegretto grazioso', part.name_en = 'Piano Sonata no. 7: IV. Scherzo: Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24301 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:a2b4e439-32fe-48a1-801b-e592c765b4fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2b4e439-32fe-48a1-801b-e592c765b4fe', 4, 'IV', 'Scherzo: Allegretto grazioso', 'Piano Sonata no. 7: IV. Scherzo: Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24301 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2b4e439-32fe-48a1-801b-e592c765b4fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Variationen und Fuge über ein hebräisches Volkslied', part.name_en = 'Piano Sonata no. 7: V. Variationen und Fuge über ein hebräisches Volkslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24301 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:e371b346-bd55-4201-9463-3138a6ef7fd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e371b346-bd55-4201-9463-3138a6ef7fd0', 5, 'V', 'Variationen und Fuge über ein hebräisches Volkslied', 'Piano Sonata no. 7: V. Variationen und Fuge über ein hebräisches Volkslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24301 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e371b346-bd55-4201-9463-3138a6ef7fd0'
);


-- None 가곡 <Schwer ist’s, das Schöne zu lassen>

UPDATE pieces piece
SET piece.title = '가곡 <Schwer ist’s, das Schöne zu lassen>', piece.title_en = 'Schwer ist’s, das Schöne zu lassen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23914 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 6개의 가곡

UPDATE pieces piece
SET piece.title = '6개의 가곡', piece.title_en = 'Six Songs, op. 17',
    piece.type = 'album', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23076 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'An Himmelfahrt', part.name_en = 'Six Songs, op. 17: I. An Himmelfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:7a4d6e20-3e1e-4ee1-855c-f35b0a4585d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a4d6e20-3e1e-4ee1-855c-f35b0a4585d4', 1, 'I', 'An Himmelfahrt', 'Six Songs, op. 17: I. An Himmelfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4d6e20-3e1e-4ee1-855c-f35b0a4585d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Drei Blumen', part.name_en = 'Six Songs, op. 17: II. Drei Blumen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:75785b1c-78bf-489b-95e3-0918ef66dcaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75785b1c-78bf-489b-95e3-0918ef66dcaa', 2, 'II', 'Drei Blumen', 'Six Songs, op. 17: II. Drei Blumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75785b1c-78bf-489b-95e3-0918ef66dcaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dreierlei Schutzgeister', part.name_en = 'Six Songs, op. 17: III. Dreierlei Schutzgeister',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:b1ddfb60-d2d1-4020-a48d-04991cbb334c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ddfb60-d2d1-4020-a48d-04991cbb334c', 3, 'III', 'Dreierlei Schutzgeister', 'Six Songs, op. 17: III. Dreierlei Schutzgeister', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ddfb60-d2d1-4020-a48d-04991cbb334c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Es Schleppt mein Schuh', part.name_en = 'Six Songs, op. 17: IV. Es Schleppt mein Schuh',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:1ed67031-5224-4e0e-a1f9-603557ffc0ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ed67031-5224-4e0e-a1f9-603557ffc0ba', 4, 'IV', 'Es Schleppt mein Schuh', 'Six Songs, op. 17: IV. Es Schleppt mein Schuh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ed67031-5224-4e0e-a1f9-603557ffc0ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Wie ist die Nacht', part.name_en = 'Six Songs, op. 17: V. Wie ist die Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:85fe72cd-b832-477d-ae85-9f638d618daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85fe72cd-b832-477d-ae85-9f638d618daa', 5, 'V', 'Wie ist die Nacht', 'Six Songs, op. 17: V. Wie ist die Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85fe72cd-b832-477d-ae85-9f638d618daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Aus dem Hauschen in den Garten', part.name_en = 'Six Songs, op. 17: VI. Aus dem Hauschen in den Garten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23076 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:11beebf2-3631-47f6-a751-d7ed885644a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11beebf2-3631-47f6-a751-d7ed885644a0', 6, 'VI', 'Aus dem Hauschen in den Garten', 'Six Songs, op. 17: VI. Aus dem Hauschen in den Garten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23076 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11beebf2-3631-47f6-a751-d7ed885644a0'
);


-- Op. 34 Six Sonnets de Louïze Labé Op. 34

UPDATE pieces piece
SET piece.title = 'Six Sonnets de Louïze Labé Op. 34', piece.title_en = 'Six Sonnets de Louïze Labé, op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24968 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Clere Vénus', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 1. Clere Vénus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:a42ff9c5-4f5f-4cbe-87c6-87b8772019eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a42ff9c5-4f5f-4cbe-87c6-87b8772019eb', 1, NULL, 'Clere Vénus', 'Six Sonnets de Louïze Labé, op. 34: No. 1. Clere Vénus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a42ff9c5-4f5f-4cbe-87c6-87b8772019eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'On voit mourir', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 2. On voit mourir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:808a65ac-f74f-4e06-be07-b941046c5705' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:808a65ac-f74f-4e06-be07-b941046c5705', 2, NULL, 'On voit mourir', 'Six Sonnets de Louïze Labé, op. 34: No. 2. On voit mourir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:808a65ac-f74f-4e06-be07-b941046c5705'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Je vis, je meurs', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 3. Je vis, je meurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:326e32b7-2743-4faf-ab2e-b538e66aba0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:326e32b7-2743-4faf-ab2e-b538e66aba0a', 3, NULL, 'Je vis, je meurs', 'Six Sonnets de Louïze Labé, op. 34: No. 3. Je vis, je meurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:326e32b7-2743-4faf-ab2e-b538e66aba0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Luth, compagnon', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 4. Luth, compagnon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:1ffede23-d44b-4487-98c5-75e047d58a06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ffede23-d44b-4487-98c5-75e047d58a06', 4, NULL, 'Luth, compagnon', 'Six Sonnets de Louïze Labé, op. 34: No. 4. Luth, compagnon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ffede23-d44b-4487-98c5-75e047d58a06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Baise m''encor', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 5. Baise m''encor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:3058c3e6-a58a-4d82-a68d-fb8f28bd6e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3058c3e6-a58a-4d82-a68d-fb8f28bd6e05', 5, NULL, 'Baise m''encor', 'Six Sonnets de Louïze Labé, op. 34: No. 5. Baise m''encor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3058c3e6-a58a-4d82-a68d-fb8f28bd6e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Oh si j''étais', part.name_en = 'Six Sonnets de Louïze Labé, op. 34: No. 6. Oh si j''étais',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24968 AND p.composer_id = 393 AND part.part_key = 'musicbrainz:47187a23-eb0f-4586-862f-bafcd977a540' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47187a23-eb0f-4586-862f-bafcd977a540', 6, NULL, 'Oh si j''étais', 'Six Sonnets de Louïze Labé, op. 34: No. 6. Oh si j''étais', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24968 AND p.composer_id = 393
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47187a23-eb0f-4586-862f-bafcd977a540'
);


-- None 가곡 <Sonnenuntergang>

UPDATE pieces piece
SET piece.title = '가곡 <Sonnenuntergang>', piece.title_en = 'Sonnenuntergang',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23566 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3a Variationen und Doppelfuge über ein Thema von Arnold Schönberg für Klavier

UPDATE pieces piece
SET piece.title = 'Variationen und Doppelfuge über ein Thema von Arnold Schönberg für Klavier', piece.title_en = 'Variationen und Doppelfuge über ein Thema von Arnold Schönberg für Klavier, op. 3a',
    piece.type = 'song', piece.opus_number = 'Op. 3a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25591 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Yiddish Songs for Choir

UPDATE pieces piece
SET piece.title = 'Yiddish Songs for Choir', piece.title_en = 'Yiddish Songs for Choir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25531 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zwei hebräische Chöre

UPDATE pieces piece
SET piece.title = 'Zwei hebräische Chöre', piece.title_en = 'Zwei hebräische Chöre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23078 AND piece.composer_id = 393
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 소나타 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 1번', 'Piano Sonata no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 393
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c10a0f-e798-46be-b9fd-71f2260f7ba3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9c10a0f-e798-46be-b9fd-71f2260f7ba3'
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c10a0f-e798-46be-b9fd-71f2260f7ba3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e34c2e90-83d4-4b21-bf04-ac86dc0b21cf', 1, 'I', 'Molto agitato', 'Piano Sonata no. 1: I. Molto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34c2e90-83d4-4b21-bf04-ac86dc0b21cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38fdb186-17d4-47ee-8a9f-27284c22d2d5', 2, 'II', 'Andante [quasi marcia funebre]', 'Piano Sonata no. 1: II. Andante [quasi marcia funebre]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38fdb186-17d4-47ee-8a9f-27284c22d2d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0a71af4-3cfc-4f16-ae10-eac9a2ed7e89', 3, 'III', 'Adagio - Presto', 'Piano Sonata no. 1: III. Adagio - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0a71af4-3cfc-4f16-ae10-eac9a2ed7e89'
);


-- None 피아노 소나타 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 2번', 'Piano Sonata no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 393
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52a3a746-cda4-486b-9156-ef6ca0bee7aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52a3a746-cda4-486b-9156-ef6ca0bee7aa'
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52a3a746-cda4-486b-9156-ef6ca0bee7aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cfdb6f-cd7d-4e50-b1d8-86c07c30ea0f', 1, 'I', 'Allegro energico e agitato', 'Piano Sonata no. 2: I. Allegro energico e agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cfdb6f-cd7d-4e50-b1d8-86c07c30ea0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7d1af42-20dc-44fd-93bd-7cb7e8856c82', 2, 'II', 'Moderato: Thema & Variationen', 'Piano Sonata no. 2: II. Moderato: Thema & Variationen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d1af42-20dc-44fd-93bd-7cb7e8856c82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d761156-69e4-4058-95df-33ded1d46939', 3, 'III', 'Prestissimo', 'Piano Sonata no. 2: III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d761156-69e4-4058-95df-33ded1d46939'
);


-- None 피아노 소나타 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 3번', 'Piano Sonata no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 393
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1707d9f6-7275-469b-880e-12b65b5c5efa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1707d9f6-7275-469b-880e-12b65b5c5efa'
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1707d9f6-7275-469b-880e-12b65b5c5efa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31b96502-d932-4239-8bf6-88bbe3aa63b1', 1, 'I', 'Allegro grazioso, ma agitato', 'Piano Sonata no. 3: I. Allegro grazioso, ma agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31b96502-d932-4239-8bf6-88bbe3aa63b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfc3039c-0d57-400e-b501-e9c27c6170b6', 2, 'II', 'Scherzo: Allegro violente', 'Piano Sonata no. 3: II. Scherzo: Allegro violente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfc3039c-0d57-400e-b501-e9c27c6170b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f5138ce-de4d-4166-9d5b-916aca722b4b', 3, 'III', 'Allegro grazioso', 'Piano Sonata no. 3: III. Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f5138ce-de4d-4166-9d5b-916aca722b4b'
);


-- None 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 393
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfd90893-afe3-4bba-819b-34b70f261574'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dfd90893-afe3-4bba-819b-34b70f261574'
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfd90893-afe3-4bba-819b-34b70f261574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12234587-cbb7-3444-8162-169e1ac27e25', 1, 'I', 'Allegro moderato', 'String Quartet no. 3: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12234587-cbb7-3444-8162-169e1ac27e25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79fb0ae-1957-494c-8d35-149e5fd667b6', 2, 'II', 'Presto', 'String Quartet no. 3: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79fb0ae-1957-494c-8d35-149e5fd667b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb2052ed-c766-4f7e-aee9-319f3413ec46', 3, 'III', 'Largo', 'String Quartet no. 3: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb2052ed-c766-4f7e-aee9-319f3413ec46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:121e9255-9e24-4e59-857e-aa1f08a00afd', 4, 'IV', 'Allegro vivace', 'String Quartet no. 3: IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 393 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:121e9255-9e24-4e59-857e-aa1f08a00afd'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 393 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24211
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
