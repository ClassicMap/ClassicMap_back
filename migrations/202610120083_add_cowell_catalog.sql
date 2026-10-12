-- 헨리 카웰 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 100개(묶음 13, 다악장 31, 낱곡 56),
-- 새 작품 6개, part 173개, 그 아래 5개.
-- seed 97개 중 94개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.
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

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Nine Ings (중복 19667)'
WHERE piece.id = 19667 AND piece.composer_id = 229 AND piece.title = 'Nine Ings'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 26 Simultaneous Mosaics

UPDATE pieces piece
SET piece.title = '26 Simultaneous Mosaics', piece.title_en = '26 Simultaneous Mosaics',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18243 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3 Irish Legends

UPDATE pieces piece
SET piece.title = '3 Irish Legends', piece.title_en = '3 Irish Legends',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17977 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Tides of Manaunaun', part.name_en = 'The Tides of Manaunaun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17977 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a4a3d70f-fb8b-40a6-b6c6-a6e26a76a7de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a3d70f-fb8b-40a6-b6c6-a6e26a76a7de', 1, NULL, 'The Tides of Manaunaun', 'The Tides of Manaunaun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17977 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a3d70f-fb8b-40a6-b6c6-a6e26a76a7de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Hero Sun', part.name_en = 'The Hero Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17977 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:9596b4bd-25c9-4372-833e-74a520b0ba23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9596b4bd-25c9-4372-833e-74a520b0ba23', 2, NULL, 'The Hero Sun', 'The Hero Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17977 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9596b4bd-25c9-4372-833e-74a520b0ba23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Voice of Lir', part.name_en = 'The Voice of Lir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17977 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:5e8b39a1-9e78-4a36-90b3-1bfafd868125' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e8b39a1-9e78-4a36-90b3-1bfafd868125', 3, NULL, 'The Voice of Lir', 'The Voice of Lir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17977 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e8b39a1-9e78-4a36-90b3-1bfafd868125'
);


-- None Aeolian Harp

UPDATE pieces piece
SET piece.title = 'Aeolian Harp', piece.title_en = 'Aeolian Harp',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17791 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air & Scherzo

UPDATE pieces piece
SET piece.title = 'Air & Scherzo', piece.title_en = 'Air & Scherzo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16096 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Air', part.name_en = 'Air & Scherzo: I. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16096 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0181f542-7b78-4397-a0ed-04e604f65830' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0181f542-7b78-4397-a0ed-04e604f65830', 1, 'I', 'Air', 'Air & Scherzo: I. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16096 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0181f542-7b78-4397-a0ed-04e604f65830'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Air & Scherzo: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16096 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2083f30e-5329-4fd1-9b4e-7b5e67288c88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2083f30e-5329-4fd1-9b4e-7b5e67288c88', 2, 'II', 'Scherzo', 'Air & Scherzo: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16096 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2083f30e-5329-4fd1-9b4e-7b5e67288c88'
);


-- None Air for Solo Violin and String Orchestra, HC 767/1a

UPDATE pieces piece
SET piece.title = 'Air for Solo Violin and String Orchestra, HC 767/1a', piece.title_en = 'Air for Solo Violin and String Orchestra, HC 767/1a',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17910 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None American Melting Pot, HC 594

UPDATE pieces piece
SET piece.title = 'American Melting Pot, HC 594', piece.title_en = 'American Melting Pot, HC 594',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16172 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chorale (Teutonic-American)', part.name_en = 'American Melting Pot, HC 594: I. Chorale (Teutonic-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f0970a5e-61f1-4af6-ab90-afb1850db176' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0970a5e-61f1-4af6-ab90-afb1850db176', 1, 'I', 'Chorale (Teutonic-American)', 'American Melting Pot, HC 594: I. Chorale (Teutonic-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0970a5e-61f1-4af6-ab90-afb1850db176'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air (African-American)', part.name_en = 'American Melting Pot, HC 594: II. Air (African-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:83e40996-30ae-4a72-be97-d26cb85393f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e40996-30ae-4a72-be97-d26cb85393f6', 2, 'II', 'Air (African-American)', 'American Melting Pot, HC 594: II. Air (African-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e40996-30ae-4a72-be97-d26cb85393f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Satire (French-American)', part.name_en = 'American Melting Pot, HC 594: III. Satire (French-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:422bd481-03b8-4fa1-aeec-c4acc0c38fae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:422bd481-03b8-4fa1-aeec-c4acc0c38fae', 3, 'III', 'Satire (French-American)', 'American Melting Pot, HC 594: III. Satire (French-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422bd481-03b8-4fa1-aeec-c4acc0c38fae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Alapria (Oriental-American)', part.name_en = 'American Melting Pot, HC 594: IV. Alapria (Oriental-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:63fa045b-10b1-4ffe-8935-449ebb835839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63fa045b-10b1-4ffe-8935-449ebb835839', 4, 'IV', 'Alapria (Oriental-American)', 'American Melting Pot, HC 594: IV. Alapria (Oriental-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63fa045b-10b1-4ffe-8935-449ebb835839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Slavic Dance (Slavic-American)', part.name_en = 'American Melting Pot, HC 594: V. Slavic Dance (Slavic-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ac52c11e-ee2d-451b-b30c-9d2a262e6e69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac52c11e-ee2d-451b-b30c-9d2a262e6e69', 5, 'V', 'Slavic Dance (Slavic-American)', 'American Melting Pot, HC 594: V. Slavic Dance (Slavic-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac52c11e-ee2d-451b-b30c-9d2a262e6e69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Rhumba With an Added Eighth Note (Latin-American)', part.name_en = 'American Melting Pot, HC 594: VI. Rhumba With an Added Eighth Note (Latin-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0797ac5b-e7f0-4484-945b-89cf5846e570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0797ac5b-e7f0-4484-945b-89cf5846e570', 6, 'VI', 'Rhumba With an Added Eighth Note (Latin-American)', 'American Melting Pot, HC 594: VI. Rhumba With an Added Eighth Note (Latin-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0797ac5b-e7f0-4484-945b-89cf5846e570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Square Dance (Celtic-American)', part.name_en = 'American Melting Pot, HC 594: VII. Square Dance (Celtic-American)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16172 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b0353013-0653-4a30-8fd1-e56ffd0f08af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0353013-0653-4a30-8fd1-e56ffd0f08af', 7, 'VII', 'Square Dance (Celtic-American)', 'American Melting Pot, HC 594: VII. Square Dance (Celtic-American)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16172 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0353013-0653-4a30-8fd1-e56ffd0f08af'
);


-- None Anger Dance

UPDATE pieces piece
SET piece.title = 'Anger Dance', piece.title_en = 'Anger Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19995 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Antiphony, HC 865

UPDATE pieces piece
SET piece.title = 'Antiphony, HC 865', piece.title_en = 'Antiphony, HC 865',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17673 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Atlantis

UPDATE pieces piece
SET piece.title = 'Atlantis', piece.title_en = 'Atlantis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16400 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Atlantis: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b911bb32-b734-4137-aa57-06f93aed63ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b911bb32-b734-4137-aa57-06f93aed63ea', 1, NULL, 'Introduction', 'Atlantis: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b911bb32-b734-4137-aa57-06f93aed63ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Shooting of the Moon', part.name_en = 'Atlantis: The Shooting of the Moon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7cc18422-07e3-45d3-9093-11b6978ab6b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cc18422-07e3-45d3-9093-11b6978ab6b3', 2, NULL, 'The Shooting of the Moon', 'Atlantis: The Shooting of the Moon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cc18422-07e3-45d3-9093-11b6978ab6b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Weeping of the Arsete of the Moon', part.name_en = 'Atlantis: The Weeping of the Arsete of the Moon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:85583a43-b708-414b-9193-9ed1df95d1bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85583a43-b708-414b-9193-9ed1df95d1bb', 3, NULL, 'The Weeping of the Arsete of the Moon', 'Atlantis: The Weeping of the Arsete of the Moon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85583a43-b708-414b-9193-9ed1df95d1bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Birth of the Sea Soul', part.name_en = 'Atlantis: Birth of the Sea Soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7e1e7229-0b76-46c7-956e-fa27ad519be4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e1e7229-0b76-46c7-956e-fa27ad519be4', 4, NULL, 'Birth of the Sea Soul', 'Atlantis: Birth of the Sea Soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e1e7229-0b76-46c7-956e-fa27ad519be4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Temptation of the Sea Soul by Monsters', part.name_en = 'Atlantis: Temptation of the Sea Soul by Monsters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b6e64bd3-1076-4632-8f17-f7bfa57f0693' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6e64bd3-1076-4632-8f17-f7bfa57f0693', 5, NULL, 'Temptation of the Sea Soul by Monsters', 'Atlantis: Temptation of the Sea Soul by Monsters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6e64bd3-1076-4632-8f17-f7bfa57f0693'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pleasure of the Sea Soul', part.name_en = 'Atlantis: Pleasure of the Sea Soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6750dc83-1424-4c0f-9533-ce3306c3bcea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6750dc83-1424-4c0f-9533-ce3306c3bcea', 6, NULL, 'Pleasure of the Sea Soul', 'Atlantis: Pleasure of the Sea Soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6750dc83-1424-4c0f-9533-ce3306c3bcea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Withdrawal of the Sea Soul to the Sea', part.name_en = 'Atlantis: Withdrawal of the Sea Soul to the Sea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1876338d-0bb2-4c07-9bf1-368743ba4c39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1876338d-0bb2-4c07-9bf1-368743ba4c39', 7, NULL, 'Withdrawal of the Sea Soul to the Sea', 'Atlantis: Withdrawal of the Sea Soul to the Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1876338d-0bb2-4c07-9bf1-368743ba4c39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Combat Between Sea & Earth Monsters', part.name_en = 'Atlantis: Combat Between Sea & Earth Monsters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1751b61e-1c64-448c-aff9-c50cac293257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1751b61e-1c64-448c-aff9-c50cac293257', 8, NULL, 'Combat Between Sea & Earth Monsters', 'Atlantis: Combat Between Sea & Earth Monsters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1751b61e-1c64-448c-aff9-c50cac293257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Triumph of the Sea Monster', part.name_en = 'Atlantis: The Triumph of the Sea Monster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16400 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f89387ed-ca70-4b7e-97c5-f2ec353e499c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f89387ed-ca70-4b7e-97c5-f2ec353e499c', 9, NULL, 'The Triumph of the Sea Monster', 'Atlantis: The Triumph of the Sea Monster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16400 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f89387ed-ca70-4b7e-97c5-f2ec353e499c'
);


-- None Celtic Set

UPDATE pieces piece
SET piece.title = 'Celtic Set', piece.title_en = 'Celtic Set',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18642 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Reel', part.name_en = 'Celtic Set: I. Reel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18642 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:9a19453a-e2e3-4527-ab03-89cd61a2ec9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a19453a-e2e3-4527-ab03-89cd61a2ec9a', 1, 'I', 'Reel', 'Celtic Set: I. Reel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18642 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a19453a-e2e3-4527-ab03-89cd61a2ec9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Caoine', part.name_en = 'Celtic Set: II. Caoine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18642 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:22d4fbb4-a03a-4528-b468-5efe43432f7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d4fbb4-a03a-4528-b468-5efe43432f7b', 2, 'II', 'Caoine', 'Celtic Set: II. Caoine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18642 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d4fbb4-a03a-4528-b468-5efe43432f7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Hornpipe', part.name_en = 'Celtic Set: III. Hornpipe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18642 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:bfed34ca-1e4a-4d39-a02b-84fe86752968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfed34ca-1e4a-4d39-a02b-84fe86752968', 3, 'III', 'Hornpipe', 'Celtic Set: III. Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18642 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfed34ca-1e4a-4d39-a02b-84fe86752968'
);


-- None Cleistogamy

UPDATE pieces piece
SET piece.title = 'Cleistogamy', piece.title_en = 'Cleistogamy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19079 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto Piccolo for piano and orchestra

UPDATE pieces piece
SET piece.title = 'Concerto Piccolo for piano and orchestra', piece.title_en = 'Concerto Piccolo for piano and orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17523 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto - Poco più mosso', part.name_en = 'Concerto Piccolo for piano and orchestra: I. Larghetto - Poco più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17523 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:bcdb7b37-4b02-4e42-b5bd-8de0b26e8309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcdb7b37-4b02-4e42-b5bd-8de0b26e8309', 1, 'I', 'Larghetto - Poco più mosso', 'Concerto Piccolo for piano and orchestra: I. Larghetto - Poco più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17523 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcdb7b37-4b02-4e42-b5bd-8de0b26e8309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante - A bit slower', part.name_en = 'Concerto Piccolo for piano and orchestra: II. Andante - A bit slower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17523 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1ccc10c5-4b11-4d34-a406-02742a501f00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ccc10c5-4b11-4d34-a406-02742a501f00', 2, 'II', 'Andante - A bit slower', 'Concerto Piccolo for piano and orchestra: II. Andante - A bit slower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17523 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ccc10c5-4b11-4d34-a406-02742a501f00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto - Più mosso', part.name_en = 'Concerto Piccolo for piano and orchestra: III. Allegretto - Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17523 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2bf9e7ba-90bc-4d46-972b-3291dcc65210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bf9e7ba-90bc-4d46-972b-3291dcc65210', 3, 'III', 'Allegretto - Più mosso', 'Concerto Piccolo for piano and orchestra: III. Allegretto - Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17523 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bf9e7ba-90bc-4d46-972b-3291dcc65210'
);


-- None Dance of Sport

UPDATE pieces piece
SET piece.title = 'Dance of Sport', piece.title_en = 'Dance of Sport',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17990 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deep Color

UPDATE pieces piece
SET piece.title = 'Deep Color', piece.title_en = 'Deep Color',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18174 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Domnu, the Mother of Waters, HC 426

UPDATE pieces piece
SET piece.title = 'Domnu, the Mother of Waters, HC 426', piece.title_en = 'Domnu, the Mother of Waters, HC 426',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19532 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dynamic Motion

UPDATE pieces piece
SET piece.title = 'Dynamic Motion', piece.title_en = 'Dynamic Motion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18996 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ensemble for String Orchestra, HC 380b

UPDATE pieces piece
SET piece.title = 'Ensemble for String Orchestra, HC 380b', piece.title_en = 'Ensemble for String Orchestra, HC 380b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16028 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto', part.name_en = 'Ensemble for String Orchestra, HC 380b: I. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16028 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:935580d4-9c59-4d26-abec-875d84448e9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:935580d4-9c59-4d26-abec-875d84448e9e', 1, 'I', 'Larghetto', 'Ensemble for String Orchestra, HC 380b: I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16028 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:935580d4-9c59-4d26-abec-875d84448e9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prestissimo', part.name_en = 'Ensemble for String Orchestra, HC 380b: II. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16028 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6df3c0c3-b579-439c-b155-c967049294b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6df3c0c3-b579-439c-b155-c967049294b4', 2, 'II', 'Prestissimo', 'Ensemble for String Orchestra, HC 380b: II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16028 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df3c0c3-b579-439c-b155-c967049294b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio sostenuto', part.name_en = 'Ensemble for String Orchestra, HC 380b: III. Adagio sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16028 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f9a02d23-9b4f-4bc3-bc5c-c6d980b3e4c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a02d23-9b4f-4bc3-bc5c-c6d980b3e4c9', 3, 'III', 'Adagio sostenuto', 'Ensemble for String Orchestra, HC 380b: III. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16028 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a02d23-9b4f-4bc3-bc5c-c6d980b3e4c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Ensemble for String Orchestra, HC 380b: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16028 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:721aadd4-a588-41e0-886e-62108301ee31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:721aadd4-a588-41e0-886e-62108301ee31', 4, 'IV', 'Allegro', 'Ensemble for String Orchestra, HC 380b: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16028 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:721aadd4-a588-41e0-886e-62108301ee31'
);


-- None Euphoria

UPDATE pieces piece
SET piece.title = 'Euphoria', piece.title_en = 'Euphoria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17102 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exultation

UPDATE pieces piece
SET piece.title = 'Exultation', piece.title_en = 'Exultation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19255 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fabric

UPDATE pieces piece
SET piece.title = 'Fabric', piece.title_en = 'Fabric',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19460 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fiddler's Jig (Flirtatious Jig), HC 771

UPDATE pieces piece
SET piece.title = 'Fiddler''s Jig (Flirtatious Jig), HC 771', piece.title_en = 'Fiddler''s Jig (Flirtatious Jig), HC 771',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19976 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five Encores to Dynamic Motion

UPDATE pieces piece
SET piece.title = 'Five Encores to Dynamic Motion', piece.title_en = 'Five Encores to Dynamic Motion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17008 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'What''s This', part.name_en = 'What''s This',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17008 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7da8333c-2b5a-4ca3-9f75-f29dbc0239f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7da8333c-2b5a-4ca3-9f75-f29dbc0239f7', 1, NULL, 'What''s This', 'What''s This', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17008 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7da8333c-2b5a-4ca3-9f75-f29dbc0239f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Amiable Conversation', part.name_en = 'Amiable Conversation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17008 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ee7a890d-8b5c-4f1b-bb9a-24a3410c612f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee7a890d-8b5c-4f1b-bb9a-24a3410c612f', 2, NULL, 'Amiable Conversation', 'Amiable Conversation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17008 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee7a890d-8b5c-4f1b-bb9a-24a3410c612f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Advertisement', part.name_en = 'Advertisement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17008 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:cb3d7ceb-88f6-4543-b54d-1ba2ce7596d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb3d7ceb-88f6-4543-b54d-1ba2ce7596d7', 3, NULL, 'Advertisement', 'Advertisement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17008 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb3d7ceb-88f6-4543-b54d-1ba2ce7596d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Antinomy', part.name_en = 'Antinomy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17008 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:e8425e71-e031-4f5d-9c75-d665cdcfbc73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8425e71-e031-4f5d-9c75-d665cdcfbc73', 4, NULL, 'Antinomy', 'Antinomy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17008 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8425e71-e031-4f5d-9c75-d665cdcfbc73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Time Table', part.name_en = 'Time Table',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17008 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d544b675-a17a-45da-91f5-a394f3eae5b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d544b675-a17a-45da-91f5-a394f3eae5b7', 5, NULL, 'Time Table', 'Time Table', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17008 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d544b675-a17a-45da-91f5-a394f3eae5b7'
);


-- None Four Combinations for Piano, Violin and Cello

UPDATE pieces piece
SET piece.title = 'Four Combinations for Piano, Violin and Cello', piece.title_en = 'Four Combinations for Piano, Violin and Cello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17874 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Four Combinations for Piano, Violin and Cello: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17874 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ea139ca4-fdbc-44f4-84c2-4a2f00706434' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea139ca4-fdbc-44f4-84c2-4a2f00706434', 1, 'I', 'Allegretto', 'Four Combinations for Piano, Violin and Cello: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17874 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea139ca4-fdbc-44f4-84c2-4a2f00706434'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Four Combinations for Piano, Violin and Cello: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17874 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:923a51b6-0780-45b8-adb4-6015ec2fca75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:923a51b6-0780-45b8-adb4-6015ec2fca75', 2, 'II', 'Largo', 'Four Combinations for Piano, Violin and Cello: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17874 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:923a51b6-0780-45b8-adb4-6015ec2fca75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Four Combinations for Piano, Violin and Cello: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17874 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:e46a8e48-cc3d-4033-a167-b6cc81210366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e46a8e48-cc3d-4033-a167-b6cc81210366', 3, 'III', 'Allegro', 'Four Combinations for Piano, Violin and Cello: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17874 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e46a8e48-cc3d-4033-a167-b6cc81210366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo', part.name_en = 'Four Combinations for Piano, Violin and Cello: IV. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17874 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:92db47be-ae85-4d10-b994-5866daed054b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92db47be-ae85-4d10-b994-5866daed054b', 4, 'IV', 'Largo', 'Four Combinations for Piano, Violin and Cello: IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17874 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92db47be-ae85-4d10-b994-5866daed054b'
);


-- None Four Declamations With Return

UPDATE pieces piece
SET piece.title = 'Four Declamations With Return', piece.title_en = 'Four Declamations With Return',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19165 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Irish Tales for piano and orchestra

UPDATE pieces piece
SET piece.title = 'Four Irish Tales for piano and orchestra', piece.title_en = 'Four Irish Tales for piano and orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19105 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Tides of Manaunaun. Largo', part.name_en = 'Four Irish Tales for piano and orchestra: I. The Tides of Manaunaun. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19105 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:60d3c239-61d2-4679-b07e-2b88859591c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d3c239-61d2-4679-b07e-2b88859591c8', 1, 'I', 'The Tides of Manaunaun. Largo', 'Four Irish Tales for piano and orchestra: I. The Tides of Manaunaun. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19105 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d3c239-61d2-4679-b07e-2b88859591c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Exultation. Allegro', part.name_en = 'Four Irish Tales for piano and orchestra: II. Exultation. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19105 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f05c2584-1903-458b-8d90-992a0b9e9305' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05c2584-1903-458b-8d90-992a0b9e9305', 2, 'II', 'Exultation. Allegro', 'Four Irish Tales for piano and orchestra: II. Exultation. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19105 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05c2584-1903-458b-8d90-992a0b9e9305'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Harp of Life. Largo', part.name_en = 'Four Irish Tales for piano and orchestra: III. The Harp of Life. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19105 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7d0c91c2-83ab-4903-9723-083c61ad8587' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d0c91c2-83ab-4903-9723-083c61ad8587', 3, 'III', 'The Harp of Life. Largo', 'Four Irish Tales for piano and orchestra: III. The Harp of Life. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19105 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0c91c2-83ab-4903-9723-083c61ad8587'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Lilt of the Reel. Allegro', part.name_en = 'Four Irish Tales for piano and orchestra: IV. The Lilt of the Reel. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19105 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:acb721b3-9aab-4054-a7ee-f1122ec3cb1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb721b3-9aab-4054-a7ee-f1122ec3cb1d', 4, 'IV', 'The Lilt of the Reel. Allegro', 'Four Irish Tales for piano and orchestra: IV. The Lilt of the Reel. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19105 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb721b3-9aab-4054-a7ee-f1122ec3cb1d'
);


-- None Gravely and Vigorously

UPDATE pieces piece
SET piece.title = 'Gravely and Vigorously', piece.title_en = 'Gravely and Vigorously',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18145 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Grinnell Fanfare

UPDATE pieces piece
SET piece.title = 'Grinnell Fanfare', piece.title_en = 'Grinnell Fanfare',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18400 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Heroic Dance

UPDATE pieces piece
SET piece.title = 'Heroic Dance', piece.title_en = 'Heroic Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16586 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homage a Rudhyar

UPDATE pieces piece
SET piece.title = 'Homage a Rudhyar', piece.title_en = 'Homage a Rudhyar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19538 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homage to Iran

UPDATE pieces piece
SET piece.title = 'Homage to Iran', piece.title_en = 'Homage to Iran',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18030 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante rubato', part.name_en = 'Homage to Iran: I. Andante rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18030 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:421ba5ba-b6ac-418b-bcc6-7548607d9ae0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:421ba5ba-b6ac-418b-bcc6-7548607d9ae0', 1, 'I', 'Andante rubato', 'Homage to Iran: I. Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18030 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:421ba5ba-b6ac-418b-bcc6-7548607d9ae0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Interlude: Presto', part.name_en = 'Homage to Iran: II. Interlude: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18030 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:5f294b90-a314-4a1b-a51d-4b355ff2e31b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f294b90-a314-4a1b-a51d-4b355ff2e31b', 2, 'II', 'Interlude: Presto', 'Homage to Iran: II. Interlude: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18030 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f294b90-a314-4a1b-a51d-4b355ff2e31b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante rubato', part.name_en = 'Homage to Iran: III. Andante rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18030 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a2d3d641-4a4e-4183-a24c-ed17e9867f36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2d3d641-4a4e-4183-a24c-ed17e9867f36', 3, 'III', 'Andante rubato', 'Homage to Iran: III. Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18030 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2d3d641-4a4e-4183-a24c-ed17e9867f36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con spirito', part.name_en = 'Homage to Iran: IV. Con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18030 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6103d8b9-22e7-4798-b5c9-c2e1e6a7cb59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6103d8b9-22e7-4798-b5c9-c2e1e6a7cb59', 4, 'IV', 'Con spirito', 'Homage to Iran: IV. Con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18030 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6103d8b9-22e7-4798-b5c9-c2e1e6a7cb59'
);


-- None Hymn and Fuguing Tune No. 3, HC 660

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune No. 3, HC 660', piece.title_en = 'Hymn and Fuguing Tune No. 3, HC 660',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18487 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymn and Fuguing Tune no. 10

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune no. 10', piece.title_en = 'Hymn and Fuguing Tune no. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15832 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Hymn and Fuguing Tune no. 10: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15832 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7fd2a3bf-866e-49ae-88c4-fb9f03932d18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd2a3bf-866e-49ae-88c4-fb9f03932d18', 1, NULL, 'Hymn', 'Hymn and Fuguing Tune no. 10: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15832 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd2a3bf-866e-49ae-88c4-fb9f03932d18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuguing Tune', part.name_en = 'Hymn and Fuguing Tune no. 10: Fuguing Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15832 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ea8c6e11-8245-4cd5-bde0-88d408f36f3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea8c6e11-8245-4cd5-bde0-88d408f36f3a', 2, NULL, 'Fuguing Tune', 'Hymn and Fuguing Tune no. 10: Fuguing Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15832 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8c6e11-8245-4cd5-bde0-88d408f36f3a'
);


-- None Hymn and Fuguing Tune no. 12

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune no. 12', piece.title_en = 'Hymn and Fuguing Tune no. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16549 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Hymn and Fuguing Tune no. 12: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16549 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:820a394e-96c5-4a35-bc1f-41386646b75b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:820a394e-96c5-4a35-bc1f-41386646b75b', 1, NULL, 'Hymn', 'Hymn and Fuguing Tune no. 12: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16549 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:820a394e-96c5-4a35-bc1f-41386646b75b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuguing Tune', part.name_en = 'Hymn and Fuguing Tune no. 12: Fuguing Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16549 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:5ff7a9ca-f271-438a-bb74-7564dc777741' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ff7a9ca-f271-438a-bb74-7564dc777741', 2, NULL, 'Fuguing Tune', 'Hymn and Fuguing Tune no. 12: Fuguing Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16549 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ff7a9ca-f271-438a-bb74-7564dc777741'
);


-- None Hymn and Fuguing Tune no. 2, HC 657

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune no. 2, HC 657', piece.title_en = 'Hymn and Fuguing Tune no. 2, HC 657',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19240 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Hymn and Fuguing Tune no. 2, HC 657: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19240 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:602bf6c5-d8ce-4bee-bb46-c4ef920fbbd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:602bf6c5-d8ce-4bee-bb46-c4ef920fbbd4', 1, NULL, 'Hymn', 'Hymn and Fuguing Tune no. 2, HC 657: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19240 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:602bf6c5-d8ce-4bee-bb46-c4ef920fbbd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuguing Tune', part.name_en = 'Hymn and Fuguing Tune no. 2, HC 657: Fuguing Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19240 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:8ff089c0-c94d-49d2-ae67-9a1e1134852b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff089c0-c94d-49d2-ae67-9a1e1134852b', 2, NULL, 'Fuguing Tune', 'Hymn and Fuguing Tune no. 2, HC 657: Fuguing Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19240 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff089c0-c94d-49d2-ae67-9a1e1134852b'
);


-- None Hymn and Fuguing Tune no. 5, HC 673a

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune no. 5, HC 673a', piece.title_en = 'Hymn and Fuguing Tune no. 5, HC 673a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19192 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Hymn and Fuguing Tune no. 5, HC 673a: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19192 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c8e9473a-84ce-494d-a2ca-091f782020a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8e9473a-84ce-494d-a2ca-091f782020a7', 1, NULL, 'Hymn', 'Hymn and Fuguing Tune no. 5, HC 673a: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19192 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8e9473a-84ce-494d-a2ca-091f782020a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuguing Tune', part.name_en = 'Hymn and Fuguing Tune no. 5, HC 673a: Fuguing Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19192 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1b6dcd5a-b4f7-4b11-8ec1-3077f8059680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b6dcd5a-b4f7-4b11-8ec1-3077f8059680', 2, NULL, 'Fuguing Tune', 'Hymn and Fuguing Tune no. 5, HC 673a: Fuguing Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19192 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b6dcd5a-b4f7-4b11-8ec1-3077f8059680'
);


-- None Hymn and Fuguing Tune no. 9, HC 758

UPDATE pieces piece
SET piece.title = 'Hymn and Fuguing Tune no. 9, HC 758', piece.title_en = 'Hymn and Fuguing Tune no. 9, HC 758',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18445 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Hymn and Fuguing Tune no. 9, HC 758: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18445 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:616a6fc3-c6ef-4a57-8b74-5347a1c0cf14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:616a6fc3-c6ef-4a57-8b74-5347a1c0cf14', 1, NULL, 'Hymn', 'Hymn and Fuguing Tune no. 9, HC 758: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18445 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:616a6fc3-c6ef-4a57-8b74-5347a1c0cf14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuguing Tune', part.name_en = 'Hymn and Fuguing Tune no. 9, HC 758: Fuguing Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18445 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7ab41285-4446-4f3e-8eeb-bef40dda105f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ab41285-4446-4f3e-8eeb-bef40dda105f', 2, NULL, 'Fuguing Tune', 'Hymn and Fuguing Tune no. 9, HC 758: Fuguing Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18445 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ab41285-4446-4f3e-8eeb-bef40dda105f'
);


-- None 찬가 8번

UPDATE pieces piece
SET piece.title = '찬가 8번', piece.title_en = 'Hymn, Chorale and Fuguing Tune no. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16246 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irish Jig (Allegro rubato), HC 415

UPDATE pieces piece
SET piece.title = 'Irish Jig (Allegro rubato), HC 415', piece.title_en = 'Irish Jig (Allegro rubato), HC 415',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16370 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irish Suite for String Piano and Small Orchestra

UPDATE pieces piece
SET piece.title = 'Irish Suite for String Piano and Small Orchestra', piece.title_en = 'Irish Suite for String Piano and Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19600 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Banshee', part.name_en = 'Irish Suite, for String Piano and Small Orchestra: I. The Banshee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19600 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0c46e625-c9ff-4c35-b4fa-cf8d49982287' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c46e625-c9ff-4c35-b4fa-cf8d49982287', 1, 'I', 'The Banshee', 'Irish Suite, for String Piano and Small Orchestra: I. The Banshee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19600 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c46e625-c9ff-4c35-b4fa-cf8d49982287'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Leprechaun', part.name_en = 'Irish Suite, for String Piano and Small Orchestra: II. The Leprechaun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19600 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:97769ab1-125b-495a-981b-86561838dbcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97769ab1-125b-495a-981b-86561838dbcd', 2, 'II', 'The Leprechaun', 'Irish Suite, for String Piano and Small Orchestra: II. The Leprechaun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19600 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97769ab1-125b-495a-981b-86561838dbcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Fairy Bells', part.name_en = 'Irish Suite, for String Piano and Small Orchestra: III. The Fairy Bells',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19600 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6eb381dd-0cd4-4901-9dc3-eb7564a1498d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eb381dd-0cd4-4901-9dc3-eb7564a1498d', 3, 'III', 'The Fairy Bells', 'Irish Suite, for String Piano and Small Orchestra: III. The Fairy Bells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19600 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eb381dd-0cd4-4901-9dc3-eb7564a1498d'
);


-- None Luther's Carol for his Son

UPDATE pieces piece
SET piece.title = 'Luther''s Carol for his Son', piece.title_en = 'Luther''s Carol for his Son',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18989 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Madras Symphony

UPDATE pieces piece
SET piece.title = 'Madras Symphony', piece.title_en = 'Madras Symphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19883 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Maestoso

UPDATE pieces piece
SET piece.title = 'Maestoso', piece.title_en = 'Maestoso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17360 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mosaic Quartet (String Quartet no. 3)

UPDATE pieces piece
SET piece.title = 'Mosaic Quartet (String Quartet no. 3)', piece.title_en = 'Mosaic Quartet (String Quartet no. 3)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18901 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Mosaic Quartet (String Quartet no. 3): III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18901 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:51766821-ab9e-44f2-97a9-db0fba23a6b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51766821-ab9e-44f2-97a9-db0fba23a6b9', 1, NULL, 'III', 'Mosaic Quartet (String Quartet no. 3): III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18901 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51766821-ab9e-44f2-97a9-db0fba23a6b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Mosaic Quartet (String Quartet no. 3): II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18901 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:95cbbbf7-2ab9-4b35-8a38-e1bbcc78c67f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95cbbbf7-2ab9-4b35-8a38-e1bbcc78c67f', 2, NULL, 'II', 'Mosaic Quartet (String Quartet no. 3): II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18901 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95cbbbf7-2ab9-4b35-8a38-e1bbcc78c67f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Mosaic Quartet (String Quartet no. 3): V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18901 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:bc5d8cba-e0bb-4534-805e-b0710e8dec6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5d8cba-e0bb-4534-805e-b0710e8dec6b', 3, NULL, 'V', 'Mosaic Quartet (String Quartet no. 3): V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18901 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5d8cba-e0bb-4534-805e-b0710e8dec6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Mosaic Quartet (String Quartet no. 3): I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18901 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d2a073c1-0032-479e-befd-cc7d26328ae0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2a073c1-0032-479e-befd-cc7d26328ae0', 4, NULL, 'I', 'Mosaic Quartet (String Quartet no. 3): I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18901 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2a073c1-0032-479e-befd-cc7d26328ae0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Mosaic Quartet (String Quartet no. 3): IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18901 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:eb464422-b63a-42e7-bdfe-d8a4c8f50f25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb464422-b63a-42e7-bdfe-d8a4c8f50f25', 5, NULL, 'IV', 'Mosaic Quartet (String Quartet no. 3): IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18901 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb464422-b63a-42e7-bdfe-d8a4c8f50f25'
);


-- None Movement for String Quartet (String Quartet no. 2)

UPDATE pieces piece
SET piece.title = 'Movement for String Quartet (String Quartet no. 2)', piece.title_en = 'Movement for String Quartet (String Quartet no. 2)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17033 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nine Ings

UPDATE pieces piece
SET piece.title = 'Nine Ings', piece.title_en = 'Nine Ings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17603 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Floating', part.name_en = 'Six Ings: 1. Floating',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b5943c4f-191d-4866-94b0-82d6fe5265c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5943c4f-191d-4866-94b0-82d6fe5265c1', 1, NULL, 'Floating', 'Six Ings: 1. Floating', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5943c4f-191d-4866-94b0-82d6fe5265c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Frisking', part.name_en = 'Six Ings: 2. Frisking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:32d4b634-04f2-4d78-ab4b-1d86d169dd36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32d4b634-04f2-4d78-ab4b-1d86d169dd36', 2, NULL, 'Frisking', 'Six Ings: 2. Frisking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d4b634-04f2-4d78-ab4b-1d86d169dd36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fleeting', part.name_en = 'Six Ings: 3. Fleeting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7b13b669-841e-42cd-8db6-29d5cad05533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b13b669-841e-42cd-8db6-29d5cad05533', 3, NULL, 'Fleeting', 'Six Ings: 3. Fleeting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b13b669-841e-42cd-8db6-29d5cad05533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scooting', part.name_en = 'Six Ings: 4. Scooting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:3079d077-ae91-4e30-af79-245d6462aec4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3079d077-ae91-4e30-af79-245d6462aec4', 4, NULL, 'Scooting', 'Six Ings: 4. Scooting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3079d077-ae91-4e30-af79-245d6462aec4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Waiting', part.name_en = 'Six Ings: 5. Waiting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a45d0c6f-284d-468c-afae-b6c2935128e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a45d0c6f-284d-468c-afae-b6c2935128e0', 5, NULL, 'Waiting', 'Six Ings: 5. Waiting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a45d0c6f-284d-468c-afae-b6c2935128e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Seething', part.name_en = 'Six Ings: 6. Seething',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:cab89df5-4170-48aa-ab6d-a3f9bf923bbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cab89df5-4170-48aa-ab6d-a3f9bf923bbd', 6, NULL, 'Seething', 'Six Ings: 6. Seething', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cab89df5-4170-48aa-ab6d-a3f9bf923bbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Whisking', part.name_en = 'Nine Ings: 7. Whisking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0ced3148-f473-440c-a7ea-0924d86f4589' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ced3148-f473-440c-a7ea-0924d86f4589', 7, NULL, 'Whisking', 'Nine Ings: 7. Whisking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ced3148-f473-440c-a7ea-0924d86f4589'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sneaking', part.name_en = 'Nine Ings: 8. Sneaking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ca6ad661-f046-4224-b19d-8a90d897c08a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca6ad661-f046-4224-b19d-8a90d897c08a', 8, NULL, 'Sneaking', 'Nine Ings: 8. Sneaking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6ad661-f046-4224-b19d-8a90d897c08a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Swaying', part.name_en = 'Nine Ings: 9. Swaying',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17603 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:8f9408b9-e206-42c3-bedc-099974ddb65d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f9408b9-e206-42c3-bedc-099974ddb65d', 9, NULL, 'Swaying', 'Nine Ings: 9. Swaying', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17603 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f9408b9-e206-42c3-bedc-099974ddb65d'
);


-- None Old American Country Set, HC 567

UPDATE pieces piece
SET piece.title = 'Old American Country Set, HC 567', piece.title_en = 'Old American Country Set, HC 567',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17477 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Blarneying Lilt', part.name_en = 'Old American Country Set, HC 567: I. Blarneying Lilt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17477 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2939dfd4-be39-4a78-a5fa-d90cdf7b4321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2939dfd4-be39-4a78-a5fa-d90cdf7b4321', 1, 'I', 'Blarneying Lilt', 'Old American Country Set, HC 567: I. Blarneying Lilt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17477 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2939dfd4-be39-4a78-a5fa-d90cdf7b4321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Meeting House', part.name_en = 'Old American Country Set, HC 567: II. Meeting House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17477 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:621232a6-eae6-4f7d-b925-701d87235a32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:621232a6-eae6-4f7d-b925-701d87235a32', 2, 'II', 'Meeting House', 'Old American Country Set, HC 567: II. Meeting House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17477 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621232a6-eae6-4f7d-b925-701d87235a32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Comallya', part.name_en = 'Old American Country Set, HC 567: III. Comallya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17477 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d1c7353d-d483-4f53-9762-b3d5b3f35f50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c7353d-d483-4f53-9762-b3d5b3f35f50', 3, 'III', 'Comallya', 'Old American Country Set, HC 567: III. Comallya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17477 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c7353d-d483-4f53-9762-b3d5b3f35f50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Charivari', part.name_en = 'Old American Country Set, HC 567: IV. Charivari',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17477 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7f461e73-139c-4c8a-a96b-cc57a8d70fca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f461e73-139c-4c8a-a96b-cc57a8d70fca', 4, 'IV', 'Charivari', 'Old American Country Set, HC 567: IV. Charivari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17477 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f461e73-139c-4c8a-a96b-cc57a8d70fca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Cornhuskin Hornpipe', part.name_en = 'Old American Country Set, HC 567: V. Cornhuskin Hornpipe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17477 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:bf789b4d-548d-4fe4-9713-7bd05b825cad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf789b4d-548d-4fe4-9713-7bd05b825cad', 5, 'V', 'Cornhuskin Hornpipe', 'Old American Country Set, HC 567: V. Cornhuskin Hornpipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17477 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf789b4d-548d-4fe4-9713-7bd05b825cad'
);


-- None Ongaku, HC 846

UPDATE pieces piece
SET piece.title = 'Ongaku, HC 846', piece.title_en = 'Ongaku, HC 846',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17524 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gagaku', part.name_en = 'Ongaku, HC 846: I. Gagaku',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17524 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:4c56e220-f1a8-4b3e-bb29-8820db747e5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c56e220-f1a8-4b3e-bb29-8820db747e5b', 1, 'I', 'Gagaku', 'Ongaku, HC 846: I. Gagaku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17524 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c56e220-f1a8-4b3e-bb29-8820db747e5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sankyoku', part.name_en = 'Ongaku, HC 846: II. Sankyoku',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17524 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:eab1757b-a257-4769-923d-adf68cf7b8fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eab1757b-a257-4769-923d-adf68cf7b8fb', 2, 'II', 'Sankyoku', 'Ongaku, HC 846: II. Sankyoku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17524 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eab1757b-a257-4769-923d-adf68cf7b8fb'
);


-- None Ostinato pianissimo

UPDATE pieces piece
SET piece.title = 'Ostinato pianissimo', piece.title_en = 'Ostinato pianissimo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19869 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Persian Set, HC 838

UPDATE pieces piece
SET piece.title = 'Persian Set, HC 838', piece.title_en = 'Persian Set, HC 838',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16816 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Persian Set, HC 838: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16816 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:e813eab1-9ef4-411d-82cb-00a9cd854ca7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e813eab1-9ef4-411d-82cb-00a9cd854ca7', 1, 'I', 'Moderato', 'Persian Set, HC 838: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16816 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e813eab1-9ef4-411d-82cb-00a9cd854ca7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Persian Set, HC 838: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16816 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f22abfed-0d90-4b4a-9dd0-baeaa1b6cc27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f22abfed-0d90-4b4a-9dd0-baeaa1b6cc27', 2, 'II', 'Allegretto', 'Persian Set, HC 838: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16816 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f22abfed-0d90-4b4a-9dd0-baeaa1b6cc27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Persian Set, HC 838: III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16816 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2a4876f2-dfc3-47f0-8b0a-8e3613aa9c69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a4876f2-dfc3-47f0-8b0a-8e3613aa9c69', 3, 'III', 'Lento', 'Persian Set, HC 838: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16816 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a4876f2-dfc3-47f0-8b0a-8e3613aa9c69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Persian Set, HC 838: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16816 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a092c07d-c1de-46f1-a82a-56ca075675d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a092c07d-c1de-46f1-a82a-56ca075675d1', 4, 'IV', 'Presto', 'Persian Set, HC 838: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16816 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a092c07d-c1de-46f1-a82a-56ca075675d1'
);


-- None 피아노 소품

UPDATE pieces piece
SET piece.title = '피아노 소품', piece.title_en = 'Piece for Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18263 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Piece for Piano with Strings

UPDATE pieces piece
SET piece.title = 'Piece for Piano with Strings', piece.title_en = 'Piece for Piano with Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18794 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polyphonica

UPDATE pieces piece
SET piece.title = 'Polyphonica', piece.title_en = 'Polyphonica',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16673 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pulse

UPDATE pieces piece
SET piece.title = 'Pulse', piece.title_en = 'Pulse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17453 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartet Euphometric

UPDATE pieces piece
SET piece.title = 'Quartet Euphometric', piece.title_en = 'Quartet Euphometric',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17298 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartet Romantic

UPDATE pieces piece
SET piece.title = 'Quartet Romantic', piece.title_en = 'Quartet Romantic',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17691 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Quartet Romantic: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17691 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:3eddf711-24cf-4afa-ae1d-e7034f57f860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eddf711-24cf-4afa-ae1d-e7034f57f860', 1, NULL, 'I', 'Quartet Romantic: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17691 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eddf711-24cf-4afa-ae1d-e7034f57f860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Quartet Romantic: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17691 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b0b792f8-6b0d-4c2e-ac3b-27cc52cc5776' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0b792f8-6b0d-4c2e-ac3b-27cc52cc5776', 2, NULL, 'II', 'Quartet Romantic: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17691 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0b792f8-6b0d-4c2e-ac3b-27cc52cc5776'
);


-- None 플루트 4중주

UPDATE pieces piece
SET piece.title = '플루트 4중주', piece.title_en = 'Quartet for Flute, Oboe, Cello and Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17319 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivace - Allegro', part.name_en = 'Quartet for Flute, Oboe, Cello and Harp: I. Vivace - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17319 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7ab2b063-818f-4bd9-9332-e285b35c33c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ab2b063-818f-4bd9-9332-e285b35c33c8', 1, 'I', 'Vivace - Allegro', 'Quartet for Flute, Oboe, Cello and Harp: I. Vivace - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17319 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ab2b063-818f-4bd9-9332-e285b35c33c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Quartet for Flute, Oboe, Cello and Harp: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17319 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d70bbb86-c7e4-4e00-bd73-68b751941322' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d70bbb86-c7e4-4e00-bd73-68b751941322', 2, 'II', 'Lento', 'Quartet for Flute, Oboe, Cello and Harp: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17319 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d70bbb86-c7e4-4e00-bd73-68b751941322'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Quartet for Flute, Oboe, Cello and Harp: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17319 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ba0dbdf1-5639-43a5-88c2-3cc0fac4c546' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba0dbdf1-5639-43a5-88c2-3cc0fac4c546', 3, 'III', 'Allegro moderato', 'Quartet for Flute, Oboe, Cello and Harp: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17319 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba0dbdf1-5639-43a5-88c2-3cc0fac4c546'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'Quartet for Flute, Oboe, Cello and Harp: IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17319 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:52616eee-1e57-48e6-8d17-53d38e454544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52616eee-1e57-48e6-8d17-53d38e454544', 4, 'IV', 'Allegretto', 'Quartet for Flute, Oboe, Cello and Harp: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17319 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52616eee-1e57-48e6-8d17-53d38e454544'
);


-- None Reel #2

UPDATE pieces piece
SET piece.title = 'Reel #2', piece.title_en = 'Reel #2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17341 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rhythmicana, HC 557

UPDATE pieces piece
SET piece.title = 'Rhythmicana, HC 557', piece.title_en = 'Rhythmicana, HC 557',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17907 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ritournell

UPDATE pieces piece
SET piece.title = 'Ritournell', piece.title_en = 'Ritournell',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17652 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondo for Brass

UPDATE pieces piece
SET piece.title = 'Rondo for Brass', piece.title_en = 'Rondo for Brass',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19039 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saturday Night at the Firehouse

UPDATE pieces piece
SET piece.title = 'Saturday Night at the Firehouse', piece.title_en = 'Saturday Night at the Firehouse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20012 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Set of Five

UPDATE pieces piece
SET piece.title = 'Set of Five', piece.title_en = 'Set of Five',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17266 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo sostenuto', part.name_en = 'Set of Five: I. Largo sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17266 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7dc7c3d4-3149-44be-85a9-9534c9c07c3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dc7c3d4-3149-44be-85a9-9534c9c07c3e', 1, 'I', 'Largo sostenuto', 'Set of Five: I. Largo sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17266 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc7c3d4-3149-44be-85a9-9534c9c07c3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Set of Five: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17266 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:4f69dbee-c9a6-4dde-b432-cb6a3e69ca6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f69dbee-c9a6-4dde-b432-cb6a3e69ca6b', 2, 'II', 'Allegro', 'Set of Five: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17266 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f69dbee-c9a6-4dde-b432-cb6a3e69ca6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Set of Five: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17266 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6eb2357e-d51a-4059-8560-7aa3f55e02bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eb2357e-d51a-4059-8560-7aa3f55e02bf', 3, 'III', 'Andante', 'Set of Five: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17266 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eb2357e-d51a-4059-8560-7aa3f55e02bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto leggiero', part.name_en = 'Set of Five: IV. Presto leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17266 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b2b73b6c-60c5-4adc-b6b9-33a8561b40db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2b73b6c-60c5-4adc-b6b9-33a8561b40db', 4, 'IV', 'Presto leggiero', 'Set of Five: IV. Presto leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17266 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2b73b6c-60c5-4adc-b6b9-33a8561b40db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vigoroso', part.name_en = 'Set of Five: V. Vigoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17266 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:34ede0b9-3691-4988-bd43-a1f5f70ad05e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ede0b9-3691-4988-bd43-a1f5f70ad05e', 5, 'V', 'Vigoroso', 'Set of Five: V. Vigoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17266 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ede0b9-3691-4988-bd43-a1f5f70ad05e'
);


-- None Set of Four

UPDATE pieces piece
SET piece.title = 'Set of Four', piece.title_en = 'Set of Four',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16372 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rondo', part.name_en = 'Set of Four: I. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16372 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:fc42fa45-9019-42a7-9131-0c7ccc4fffff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc42fa45-9019-42a7-9131-0c7ccc4fffff', 1, 'I', 'Rondo', 'Set of Four: I. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16372 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc42fa45-9019-42a7-9131-0c7ccc4fffff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ostinato', part.name_en = 'Set of Four: II. Ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16372 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:10f27a77-1df9-4049-ac78-64af0a07d8d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10f27a77-1df9-4049-ac78-64af0a07d8d1', 2, 'II', 'Ostinato', 'Set of Four: II. Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16372 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10f27a77-1df9-4049-ac78-64af0a07d8d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chorale', part.name_en = 'Set of Four: III. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16372 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6adbd33d-3401-468b-ab0a-8789ad723651' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6adbd33d-3401-468b-ab0a-8789ad723651', 3, 'III', 'Chorale', 'Set of Four: III. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16372 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6adbd33d-3401-468b-ab0a-8789ad723651'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue and Résumé', part.name_en = 'Set of Four: IV. Fugue and Résumé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16372 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:26c94254-8d97-46cf-9123-5a1ab937e9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26c94254-8d97-46cf-9123-5a1ab937e9f9', 4, 'IV', 'Fugue and Résumé', 'Set of Four: IV. Fugue and Résumé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16372 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26c94254-8d97-46cf-9123-5a1ab937e9f9'
);


-- None Set of Two Movements

UPDATE pieces piece
SET piece.title = 'Set of Two Movements', piece.title_en = 'Set of Two Movements',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18788 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Deep Color', part.name_en = 'Set of Two Movements: I. Deep Color',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18788 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:80764cfa-6500-47c4-8c2f-8301d24cd36a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80764cfa-6500-47c4-8c2f-8301d24cd36a', 1, 'I', 'Deep Color', 'Set of Two Movements: I. Deep Color', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18788 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80764cfa-6500-47c4-8c2f-8301d24cd36a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'High Color', part.name_en = 'Set of Two Movements: II. High Color',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18788 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0a2cfdf3-dab4-4b06-9a9b-7968fd98b124' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a2cfdf3-dab4-4b06-9a9b-7968fd98b124', 2, 'II', 'High Color', 'Set of Two Movements: II. High Color', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18788 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a2cfdf3-dab4-4b06-9a9b-7968fd98b124'
);


-- None Seven Paragraphs

UPDATE pieces piece
SET piece.title = 'Seven Paragraphs', piece.title_en = 'Seven Paragraphs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18239 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonietta for chamber orchestra

UPDATE pieces piece
SET piece.title = 'Sinfonietta for chamber orchestra', piece.title_en = 'Sinfonietta for chamber orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17771 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto', part.name_en = 'Sinfonietta for chamber orchestra: I. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17771 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:86a74587-b041-4995-b182-2f2e0a587976' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86a74587-b041-4995-b182-2f2e0a587976', 1, 'I', 'Larghetto', 'Sinfonietta for chamber orchestra: I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17771 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86a74587-b041-4995-b182-2f2e0a587976'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Presto - Poco meno mosso - Tempo I', part.name_en = 'Sinfonietta for chamber orchestra: II. Scherzo. Presto - Poco meno mosso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17771 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:8a14b14b-3f42-4300-9211-d20d81d72a93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a14b14b-3f42-4300-9211-d20d81d72a93', 2, 'II', 'Scherzo. Presto - Poco meno mosso - Tempo I', 'Sinfonietta for chamber orchestra: II. Scherzo. Presto - Poco meno mosso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17771 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a14b14b-3f42-4300-9211-d20d81d72a93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marked Passages. Allegro non troppo - Poco meno mosso - Tempo I - Presto', part.name_en = 'Sinfonietta for chamber orchestra: III. Marked Passages. Allegro non troppo - Poco meno mosso - Tempo I - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17771 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:92c7be60-61cb-43d1-8ebc-37e421ecf1d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92c7be60-61cb-43d1-8ebc-37e421ecf1d9', 3, 'III', 'Marked Passages. Allegro non troppo - Poco meno mosso - Tempo I - Presto', 'Sinfonietta for chamber orchestra: III. Marked Passages. Allegro non troppo - Poco meno mosso - Tempo I - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17771 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92c7be60-61cb-43d1-8ebc-37e421ecf1d9'
);


-- None Sinister Resonance

UPDATE pieces piece
SET piece.title = 'Sinister Resonance', piece.title_en = 'Sinister Resonance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16622 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Six Casual Developments

UPDATE pieces piece
SET piece.title = 'Six Casual Developments', piece.title_en = 'Six Casual Developments',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19384 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rubato', part.name_en = 'Six Casual Developments: I. Rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2a1d15de-744b-4495-907d-424286e05369' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a1d15de-744b-4495-907d-424286e05369', 1, 'I', 'Rubato', 'Six Casual Developments: I. Rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a1d15de-744b-4495-907d-424286e05369'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Six Casual Developments: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:26864e81-5bad-4a30-9226-3de5e939b175' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26864e81-5bad-4a30-9226-3de5e939b175', 2, 'II', 'Andante', 'Six Casual Developments: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26864e81-5bad-4a30-9226-3de5e939b175'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Six Casual Developments: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a36f1c1e-7a60-4996-baf4-0c8b8263fe30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a36f1c1e-7a60-4996-baf4-0c8b8263fe30', 3, 'III', 'Andante', 'Six Casual Developments: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a36f1c1e-7a60-4996-baf4-0c8b8263fe30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Six Casual Developments: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d5b11347-6ca8-4e65-ab61-eed0adfe4fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b11347-6ca8-4e65-ab61-eed0adfe4fed', 4, 'IV', 'Allegro', 'Six Casual Developments: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b11347-6ca8-4e65-ab61-eed0adfe4fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Six Casual Developments: V. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:74e99e7a-736c-4226-b2ac-25c6e8d5920c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74e99e7a-736c-4226-b2ac-25c6e8d5920c', 5, 'V', 'Adagio cantabile', 'Six Casual Developments: V. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e99e7a-736c-4226-b2ac-25c6e8d5920c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegretto con moto', part.name_en = 'Six Casual Developments: VI. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19384 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:9997b1f3-e48b-4068-aa14-043a1a4cc272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9997b1f3-e48b-4068-aa14-043a1a4cc272', 6, 'VI', 'Allegretto con moto', 'Six Casual Developments: VI. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19384 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9997b1f3-e48b-4068-aa14-043a1a4cc272'
);


-- None Slow Jig

UPDATE pieces piece
SET piece.title = 'Slow Jig', piece.title_en = 'Slow Jig',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18213 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린과 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타', piece.title_en = 'Sonata for Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18071 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hymn', part.name_en = 'Sonata for Violin and Piano: I. Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18071 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c95a906d-df28-49a7-b65b-6e05fd3b2d18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c95a906d-df28-49a7-b65b-6e05fd3b2d18', 1, 'I', 'Hymn', 'Sonata for Violin and Piano: I. Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18071 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c95a906d-df28-49a7-b65b-6e05fd3b2d18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In Fuguing Style', part.name_en = 'Sonata for Violin and Piano: II. In Fuguing Style',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18071 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ed617728-bed8-46b0-96e5-ce246a59e8f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed617728-bed8-46b0-96e5-ce246a59e8f7', 2, 'II', 'In Fuguing Style', 'Sonata for Violin and Piano: II. In Fuguing Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18071 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed617728-bed8-46b0-96e5-ce246a59e8f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ballad', part.name_en = 'Sonata for Violin and Piano: III. Ballad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18071 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b4af56c8-0799-4988-8716-76a363ac9b64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4af56c8-0799-4988-8716-76a363ac9b64', 3, 'III', 'Ballad', 'Sonata for Violin and Piano: III. Ballad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18071 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4af56c8-0799-4988-8716-76a363ac9b64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Jig', part.name_en = 'Sonata for Violin and Piano: IV. Jig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18071 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f4a10112-0e3c-4bb5-88ae-dafe6f72ec9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a10112-0e3c-4bb5-88ae-dafe6f72ec9c', 4, 'IV', 'Jig', 'Sonata for Violin and Piano: IV. Jig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18071 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a10112-0e3c-4bb5-88ae-dafe6f72ec9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale', part.name_en = 'Sonata for Violin and Piano: V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18071 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:26249845-7113-4a4c-9137-6ef9517a49a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26249845-7113-4a4c-9137-6ef9517a49a7', 5, 'V', 'Finale', 'Sonata for Violin and Piano: V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18071 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26249845-7113-4a4c-9137-6ef9517a49a7'
);


-- None Sound Form #1

UPDATE pieces piece
SET piece.title = 'Sound Form #1', piece.title_en = 'Sound Form #1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17186 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 "Quartett Pedantic"

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 "Quartett Pedantic"', piece.title_en = 'String Quartet no. 1 "Quartett Pedantic"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16822 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto - Allegro non troppo', part.name_en = 'String Quartet no. 1 "Quartett Pedantic": I. Andante sostenuto - Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16822 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:9417bc85-094d-40d5-9918-c0d610b7438b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9417bc85-094d-40d5-9918-c0d610b7438b', 1, 'I', 'Andante sostenuto - Allegro non troppo', 'String Quartet no. 1 "Quartett Pedantic": I. Andante sostenuto - Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16822 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9417bc85-094d-40d5-9918-c0d610b7438b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'String Quartet no. 1 "Quartett Pedantic": II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16822 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:72c2a1b7-0c29-4e8a-beca-fa438a5bb175' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72c2a1b7-0c29-4e8a-beca-fa438a5bb175', 2, 'II', 'Andante', 'String Quartet no. 1 "Quartett Pedantic": II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16822 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72c2a1b7-0c29-4e8a-beca-fa438a5bb175'
);


-- None Suite for Small Orchestra

UPDATE pieces piece
SET piece.title = 'Suite for Small Orchestra', piece.title_en = 'Suite for Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17884 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Suite for Small Orchestra: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17884 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c92f5e7a-7262-4701-99e3-2f91f505d2bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c92f5e7a-7262-4701-99e3-2f91f505d2bb', 1, 'I', 'Largo', 'Suite for Small Orchestra: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17884 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c92f5e7a-7262-4701-99e3-2f91f505d2bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chorale', part.name_en = 'Suite for Small Orchestra: II. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17884 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:18f2f92b-9fea-4d2d-a17b-0fa8ea5a2655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18f2f92b-9fea-4d2d-a17b-0fa8ea5a2655', 2, 'II', 'Chorale', 'Suite for Small Orchestra: II. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17884 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f2f92b-9fea-4d2d-a17b-0fa8ea5a2655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivo', part.name_en = 'Suite for Small Orchestra: III. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17884 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b8e89ebd-2b54-45e9-9a65-7bc539893075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8e89ebd-2b54-45e9-9a65-7bc539893075', 3, 'III', 'Vivo', 'Suite for Small Orchestra: III. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17884 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e89ebd-2b54-45e9-9a65-7bc539893075'
);


-- None Suite for Woodwind Quintet

UPDATE pieces piece
SET piece.title = 'Suite for Woodwind Quintet', piece.title_en = 'Suite for Woodwind Quintet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18672 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Suite for Woodwind Quintet: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18672 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:7c1dfd48-1ac1-4525-b8c2-b425a5c18755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1dfd48-1ac1-4525-b8c2-b425a5c18755', 1, 'I', 'Allegretto', 'Suite for Woodwind Quintet: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18672 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1dfd48-1ac1-4525-b8c2-b425a5c18755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Suite for Woodwind Quintet: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18672 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:3d1c7fe6-8782-4e70-8bcb-4f1df855ae0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d1c7fe6-8782-4e70-8bcb-4f1df855ae0c', 2, 'II', 'Allegro', 'Suite for Woodwind Quintet: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18672 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d1c7fe6-8782-4e70-8bcb-4f1df855ae0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Suite for Woodwind Quintet: III. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18672 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:22d0d106-fa58-48e4-b37f-b20c1367036b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d0d106-fa58-48e4-b37f-b20c1367036b', 3, 'III', 'Adagio cantabile', 'Suite for Woodwind Quintet: III. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18672 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d0d106-fa58-48e4-b37f-b20c1367036b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con moto', part.name_en = 'Suite for Woodwind Quintet: IV. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18672 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:be5955d5-0fc0-4d7b-ba8f-29cbf676a6d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be5955d5-0fc0-4d7b-ba8f-29cbf676a6d5', 4, 'IV', 'Allegro con moto', 'Suite for Woodwind Quintet: IV. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18672 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be5955d5-0fc0-4d7b-ba8f-29cbf676a6d5'
);


-- None 교향곡 11번 "Seven Rituals of Music"

UPDATE pieces piece
SET piece.title = '교향곡 11번 "Seven Rituals of Music"', piece.title_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16528 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:894d4641-1c7f-49be-a60f-2e9a59461246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894d4641-1c7f-49be-a60f-2e9a59461246', 1, 'I', 'Andantino', 'Symphony no. 11 "Seven Rituals of Music", HC 790: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894d4641-1c7f-49be-a60f-2e9a59461246'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:554536ca-8d54-44ee-9777-507eb9aa3408' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:554536ca-8d54-44ee-9777-507eb9aa3408', 2, 'II', 'Allegro', 'Symphony no. 11 "Seven Rituals of Music", HC 790: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:554536ca-8d54-44ee-9777-507eb9aa3408'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0ec14e9c-c05d-453d-a324-5517b2df4805' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec14e9c-c05d-453d-a324-5517b2df4805', 3, 'III', 'Lento', 'Symphony no. 11 "Seven Rituals of Music", HC 790: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec14e9c-c05d-453d-a324-5517b2df4805'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:60730eb7-c8e5-4cb4-ab12-7729cb15e231' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60730eb7-c8e5-4cb4-ab12-7729cb15e231', 4, 'IV', 'Presto', 'Symphony no. 11 "Seven Rituals of Music", HC 790: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60730eb7-c8e5-4cb4-ab12-7729cb15e231'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: V. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:56a56771-5ecc-4200-99fd-ad058dd2e1d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a56771-5ecc-4200-99fd-ad058dd2e1d6', 5, 'V', 'Adagio', 'Symphony no. 11 "Seven Rituals of Music", HC 790: V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a56771-5ecc-4200-99fd-ad058dd2e1d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Vivace', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: VI. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:11f31079-7a35-4147-9429-9598cc3026df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11f31079-7a35-4147-9429-9598cc3026df', 6, 'VI', 'Vivace', 'Symphony no. 11 "Seven Rituals of Music", HC 790: VI. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11f31079-7a35-4147-9429-9598cc3026df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 11 "Seven Rituals of Music", HC 790: VII. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16528 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:171d13bf-14fb-46e8-8947-2c708e2725b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:171d13bf-14fb-46e8-8947-2c708e2725b8', 7, 'VII', 'Andante', 'Symphony no. 11 "Seven Rituals of Music", HC 790: VII. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16528 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:171d13bf-14fb-46e8-8947-2c708e2725b8'
);


-- None 교향곡 15번 "Thesis"

UPDATE pieces piece
SET piece.title = '교향곡 15번 "Thesis"', piece.title_en = 'Symphony no. 15 "Thesis", HC 887',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18311 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 15 "Thesis", HC 887: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236', 1, NULL, 'I', 'Symphony no. 15 "Thesis", HC 887: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ia. Largo', part.name_en = 'Symphony no. 15 "Thesis", HC 887: Ia. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1a0e3951-df99-41b6-ae2f-7df7f1824780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a0e3951-df99-41b6-ae2f-7df7f1824780', 1, NULL, 'Ia. Largo', 'Symphony no. 15 "Thesis", HC 887: Ia. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0e3951-df99-41b6-ae2f-7df7f1824780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ib. Andante', part.name_en = 'Symphony no. 15 "Thesis", HC 887: Ib. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:ae8bb4dd-99de-4cce-b06c-524f18cbd5ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae8bb4dd-99de-4cce-b06c-524f18cbd5ac', 2, NULL, 'Ib. Andante', 'Symphony no. 15 "Thesis", HC 887: Ib. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae8bb4dd-99de-4cce-b06c-524f18cbd5ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ic. Presto', part.name_en = 'Symphony no. 15 "Thesis", HC 887: Ic. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:b8c05a61-0d24-4f0c-b1b4-d69cb3ae3c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8c05a61-0d24-4f0c-b1b4-d69cb3ae3c93', 3, NULL, 'Ic. Presto', 'Symphony no. 15 "Thesis", HC 887: Ic. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c05a61-0d24-4f0c-b1b4-d69cb3ae3c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Id. Allegretto', part.name_en = 'Symphony no. 15 "Thesis", HC 887: Id. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a1fd7e77-7b1d-470b-b567-64b746e579fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1fd7e77-7b1d-470b-b567-64b746e579fe', 4, NULL, 'Id. Allegretto', 'Symphony no. 15 "Thesis", HC 887: Id. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1fd7e77-7b1d-470b-b567-64b746e579fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ie. Allegro and Recapitulation', part.name_en = 'Symphony no. 15 "Thesis", HC 887: Ie. Allegro and Recapitulation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:0844029e-a3db-4783-ac04-b55a801b809b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0844029e-a3db-4783-ac04-b55a801b809b', 5, NULL, 'Ie. Allegro and Recapitulation', 'Symphony no. 15 "Thesis", HC 887: Ie. Allegro and Recapitulation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2bf9e72-098a-421b-aad7-ddada5c7b236'
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0844029e-a3db-4783-ac04-b55a801b809b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Symphony no. 15 "Thesis", HC 887: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18311 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6d06f389-a44e-422b-9ee5-f8d4b55b1c2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d06f389-a44e-422b-9ee5-f8d4b55b1c2e', 2, 'II', 'Moderato', 'Symphony no. 15 "Thesis", HC 887: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18311 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d06f389-a44e-422b-9ee5-f8d4b55b1c2e'
);


-- None Synchrony

UPDATE pieces piece
SET piece.title = 'Synchrony', piece.title_en = 'Synchrony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18324 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tall Tale

UPDATE pieces piece
SET piece.title = 'Tall Tale', piece.title_en = 'Tall Tale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17804 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Banshee

UPDATE pieces piece
SET piece.title = 'The Banshee', piece.title_en = 'The Banshee',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19091 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fairy Answer

UPDATE pieces piece
SET piece.title = 'The Fairy Answer', piece.title_en = 'The Fairy Answer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18262 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Harp of Life

UPDATE pieces piece
SET piece.title = 'The Harp of Life', piece.title_en = 'The Harp of Life',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17464 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Lilt of the Reel

UPDATE pieces piece
SET piece.title = 'The Lilt of the Reel', piece.title_en = 'The Lilt of the Reel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16076 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Snows of Fujiyama

UPDATE pieces piece
SET piece.title = 'The Snows of Fujiyama', piece.title_en = 'The Snows of Fujiyama',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19417 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Trumpet of Angus Og

UPDATE pieces piece
SET piece.title = 'The Trumpet of Angus Og', piece.title_en = 'The Trumpet of Angus Og',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17784 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Universal Flute

UPDATE pieces piece
SET piece.title = 'The Universal Flute', piece.title_en = 'The Universal Flute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18494 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Anti-Modernist Songs

UPDATE pieces piece
SET piece.title = 'Three Anti-Modernist Songs', piece.title_en = 'Three Anti-Modernist Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18358 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Who Wrote This Fiendish ''Rite of Spring''?"', part.name_en = '"Who Wrote This Fiendish ''Rite of Spring''?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18358 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c31bb9c9-2e45-42c6-bad4-a5ac5ae6c4ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c31bb9c9-2e45-42c6-bad4-a5ac5ae6c4ee', 1, NULL, '"Who Wrote This Fiendish ''Rite of Spring''?"', '"Who Wrote This Fiendish ''Rite of Spring''?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18358 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c31bb9c9-2e45-42c6-bad4-a5ac5ae6c4ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"A Sharp Where You''d Expect a Natural"', part.name_en = '"A Sharp Where You''d Expect a Natural"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18358 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:dd6fa878-1730-466a-a147-11c77c1cf9d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd6fa878-1730-466a-a147-11c77c1cf9d8', 2, NULL, '"A Sharp Where You''d Expect a Natural"', '"A Sharp Where You''d Expect a Natural"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18358 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd6fa878-1730-466a-a147-11c77c1cf9d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '"Hark! From the Pit a Fearsome Sound"', part.name_en = '"Hark! From the Pit a Fearsome Sound"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18358 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:f3797ae4-73eb-428a-b970-11a12e36186f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3797ae4-73eb-428a-b970-11a12e36186f', 3, NULL, '"Hark! From the Pit a Fearsome Sound"', '"Hark! From the Pit a Fearsome Sound"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18358 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3797ae4-73eb-428a-b970-11a12e36186f'
);


-- None Tiger

UPDATE pieces piece
SET piece.title = 'Tiger', piece.title_en = 'Tiger',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18815 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio in Nine Short Movements, HC 941

UPDATE pieces piece
SET piece.title = 'Trio in Nine Short Movements, HC 941', piece.title_en = 'Trio in Nine Short Movements, HC 941',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18290 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo tenuto', part.name_en = 'Trio in Nine Short Movements, HC 941: I. Largo tenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:591782ab-3d73-4c2e-9071-3fc0dfdb95f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591782ab-3d73-4c2e-9071-3fc0dfdb95f7', 1, 'I', 'Largo tenuto', 'Trio in Nine Short Movements, HC 941: I. Largo tenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591782ab-3d73-4c2e-9071-3fc0dfdb95f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Trio in Nine Short Movements, HC 941: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:3615a7cb-2603-4976-8508-525860a60610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3615a7cb-2603-4976-8508-525860a60610', 2, 'II', 'Allegretto', 'Trio in Nine Short Movements, HC 941: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3615a7cb-2603-4976-8508-525860a60610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Trio in Nine Short Movements, HC 941: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:a53274d7-f448-4c19-beb3-69f2bb623d6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a53274d7-f448-4c19-beb3-69f2bb623d6f', 3, 'III', 'Andante', 'Trio in Nine Short Movements, HC 941: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a53274d7-f448-4c19-beb3-69f2bb623d6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Trio in Nine Short Movements, HC 941: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:4fbc869c-2f5a-4c43-86b1-a27c71a40f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fbc869c-2f5a-4c43-86b1-a27c71a40f48', 4, 'IV', 'Allegro', 'Trio in Nine Short Movements, HC 941: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fbc869c-2f5a-4c43-86b1-a27c71a40f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Trio in Nine Short Movements, HC 941: V. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c3780c3a-fdca-4802-9e6a-7d678110d472' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3780c3a-fdca-4802-9e6a-7d678110d472', 5, 'V', 'Andante sostenuto', 'Trio in Nine Short Movements, HC 941: V. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3780c3a-fdca-4802-9e6a-7d678110d472'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro', part.name_en = 'Trio in Nine Short Movements, HC 941: VI. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6d5b925b-c71d-448c-adf6-a52efa4bc10f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d5b925b-c71d-448c-adf6-a52efa4bc10f', 6, 'VI', 'Allegro', 'Trio in Nine Short Movements, HC 941: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d5b925b-c71d-448c-adf6-a52efa4bc10f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegretto', part.name_en = 'Trio in Nine Short Movements, HC 941: VII. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1df9e0eb-3fc4-42b6-8dc9-8c4f7be03ddf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1df9e0eb-3fc4-42b6-8dc9-8c4f7be03ddf', 7, 'VII', 'Allegretto', 'Trio in Nine Short Movements, HC 941: VII. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1df9e0eb-3fc4-42b6-8dc9-8c4f7be03ddf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Trio in Nine Short Movements, HC 941: VIII. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:160615a2-e27b-4f89-85fe-3d77612c0471' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:160615a2-e27b-4f89-85fe-3d77612c0471', 8, 'VIII', 'Adagio cantabile', 'Trio in Nine Short Movements, HC 941: VIII. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:160615a2-e27b-4f89-85fe-3d77612c0471'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Allegro assai', part.name_en = 'Trio in Nine Short Movements, HC 941: IX. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18290 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:6acfcd0d-3d0c-41bc-8f6f-e194d4480efa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6acfcd0d-3d0c-41bc-8f6f-e194d4480efa', 9, 'IX', 'Allegro assai', 'Trio in Nine Short Movements, HC 941: IX. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18290 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6acfcd0d-3d0c-41bc-8f6f-e194d4480efa'
);


-- None Two Bits

UPDATE pieces piece
SET piece.title = 'Two Bits', piece.title_en = 'Two Bits',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18286 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A Tuneful Bit', part.name_en = 'Two Bits: I. A Tuneful Bit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18286 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c26f9a63-d335-402b-a889-7cdb2d8870f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26f9a63-d335-402b-a889-7cdb2d8870f5', 1, 'I', 'A Tuneful Bit', 'Two Bits: I. A Tuneful Bit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18286 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26f9a63-d335-402b-a889-7cdb2d8870f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A Blarneying Bit', part.name_en = 'Two Bits: II. A Blarneying Bit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18286 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:e1fb38bc-3e6b-4df6-8024-7ff291a0d1b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1fb38bc-3e6b-4df6-8024-7ff291a0d1b0', 2, 'II', 'A Blarneying Bit', 'Two Bits: II. A Blarneying Bit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18286 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1fb38bc-3e6b-4df6-8024-7ff291a0d1b0'
);


-- None Two Ritournelles

UPDATE pieces piece
SET piece.title = 'Two Ritournelles', piece.title_en = 'Two Ritournelles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20086 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Two Ritournelles: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20086 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:3f0228db-7a48-477d-8457-202052f572d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f0228db-7a48-477d-8457-202052f572d7', 1, NULL, 'Allegretto', 'Two Ritournelles: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20086 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0228db-7a48-477d-8457-202052f572d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Two Ritournelles: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20086 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:5913369a-d776-4725-8090-aaae1f0246f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5913369a-d776-4725-8090-aaae1f0246f5', 2, NULL, 'Andante', 'Two Ritournelles: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20086 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5913369a-d776-4725-8090-aaae1f0246f5'
);


-- None 2개의 가곡

UPDATE pieces piece
SET piece.title = '2개의 가곡', piece.title_en = 'Two Songs (Poems of Catherine Riegger)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16663 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sunset', part.name_en = 'Two Songs (Poems of Catherine Riegger): I. Sunset',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16663 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:14ffada7-eae0-4d52-9a0c-7673d8d654df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14ffada7-eae0-4d52-9a0c-7673d8d654df', 1, 'I', 'Sunset', 'Two Songs (Poems of Catherine Riegger): I. Sunset', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16663 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14ffada7-eae0-4d52-9a0c-7673d8d654df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rest', part.name_en = 'Two Songs (Poems of Catherine Riegger): II. Rest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16663 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:206eb2d3-059b-4146-8dcd-2066d1fd1c8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:206eb2d3-059b-4146-8dcd-2066d1fd1c8d', 2, 'II', 'Rest', 'Two Songs (Poems of Catherine Riegger): II. Rest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16663 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:206eb2d3-059b-4146-8dcd-2066d1fd1c8d'
);


-- None 관현악 변주곡

UPDATE pieces piece
SET piece.title = '관현악 변주곡', piece.title_en = 'Variations for Orchestra, HC 833',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16631 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations on Thirds, HC 882

UPDATE pieces piece
SET piece.title = 'Variations on Thirds, HC 882', piece.title_en = 'Variations on Thirds, HC 882',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20027 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso sostenuto', part.name_en = 'Variations on Thirds, HC 882: I. Maestoso sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:d00409d0-96a1-4946-a5f0-2a89829485f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d00409d0-96a1-4946-a5f0-2a89829485f3', 1, 'I', 'Maestoso sostenuto', 'Variations on Thirds, HC 882: I. Maestoso sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d00409d0-96a1-4946-a5f0-2a89829485f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Variations on Thirds, HC 882: II. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c74c9085-c5cc-441e-9e2a-b9b91ea9fa46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c74c9085-c5cc-441e-9e2a-b9b91ea9fa46', 2, 'II', 'Allegro non troppo', 'Variations on Thirds, HC 882: II. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c74c9085-c5cc-441e-9e2a-b9b91ea9fa46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Variations on Thirds, HC 882: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:2f6f4f1e-d395-4d48-9704-633d102870cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f6f4f1e-d395-4d48-9704-633d102870cd', 3, 'III', 'Andante', 'Variations on Thirds, HC 882: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6f4f1e-d395-4d48-9704-633d102870cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Variations on Thirds, HC 882: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:1292928a-dd4c-4a6f-b402-8b36650d3431' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1292928a-dd4c-4a6f-b402-8b36650d3431', 4, 'IV', 'Presto', 'Variations on Thirds, HC 882: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1292928a-dd4c-4a6f-b402-8b36650d3431'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Moderato con moto', part.name_en = 'Variations on Thirds, HC 882: V. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:9c81f4d2-453c-45a5-8078-1e305cadc8b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c81f4d2-453c-45a5-8078-1e305cadc8b4', 5, 'V', 'Moderato con moto', 'Variations on Thirds, HC 882: V. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c81f4d2-453c-45a5-8078-1e305cadc8b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro', part.name_en = 'Variations on Thirds, HC 882: VI. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20027 AND p.composer_id = 229 AND part.part_key = 'musicbrainz:c7b26da6-c294-4b67-9452-3ac5e936c562' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7b26da6-c294-4b67-9452-3ac5e936c562', 6, 'VI', 'Allegro', 'Variations on Thirds, HC 882: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20027 AND p.composer_id = 229
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7b26da6-c294-4b67-9452-3ac5e936c562'
);


-- None Vestiges

UPDATE pieces piece
SET piece.title = 'Vestiges', piece.title_en = 'Vestiges',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19877 AND piece.composer_id = 229
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 합주 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합주 협주곡', 'Concerto grosso', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합주 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '944b0104-5021-4ed1-ba24-f3cac8224e23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '944b0104-5021-4ed1-ba24-f3cac8224e23'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '944b0104-5021-4ed1-ba24-f3cac8224e23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed8b9482-53ed-4757-925f-faf406b49129', 1, 'I', 'Maestoso', 'Concerto grosso: I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed8b9482-53ed-4757-925f-faf406b49129'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5d64312-5273-4747-ac7a-7bc8254f9a7a', 2, 'II', 'Allegretto', 'Concerto grosso: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5d64312-5273-4747-ac7a-7bc8254f9a7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e01f8e48-6b9a-4a63-8d45-26aa9ff0a9b2', 3, 'III', 'Andante', 'Concerto grosso: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e01f8e48-6b9a-4a63-8d45-26aa9ff0a9b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4a0ed9b-17d0-4571-9ae6-263d5cace40a', 4, 'IV', 'Allegro', 'Concerto grosso: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4a0ed9b-17d0-4571-9ae6-263d5cace40a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be508615-5046-4c7f-a359-73f0bf64b81c', 5, 'V', 'Allegro', 'Concerto grosso: V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '합주 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be508615-5046-4c7f-a359-73f0bf64b81c'
);


-- None Elegie

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Elegie', 'Elegie', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Elegie'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '880996d0-f8f4-4d07-a582-b8193e8b74c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '880996d0-f8f4-4d07-a582-b8193e8b74c5'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = 'Elegie' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '880996d0-f8f4-4d07-a582-b8193e8b74c5'
);


-- None 가곡 <How Old Is Song?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <How Old Is Song?>', 'How Old Is Song?', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <How Old Is Song?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449319ca-81af-4c34-8283-bc5efa18c7f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '449319ca-81af-4c34-8283-bc5efa18c7f8'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '가곡 <How Old Is Song?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449319ca-81af-4c34-8283-bc5efa18c7f8'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8c7fa95-6886-477b-95bc-b30c20082b01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8c7fa95-6886-477b-95bc-b30c20082b01'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8c7fa95-6886-477b-95bc-b30c20082b01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c73865-ee2b-48b8-a6d6-9f00a913ade0', 1, 'I', 'Polyharmony', 'Piano Concerto: I. Polyharmony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c73865-ee2b-48b8-a6d6-9f00a913ade0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc340bd6-0a6b-44c4-87a3-e88dc27fbb61', 2, 'II', 'Tone Cluster', 'Piano Concerto: II. Tone Cluster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc340bd6-0a6b-44c4-87a3-e88dc27fbb61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d6d6ad-2cc7-482d-bbd1-51a471188a56', 3, 'III', 'Counter Rhythm', 'Piano Concerto: III. Counter Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d6d6ad-2cc7-482d-bbd1-51a471188a56'
);


-- None Return

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Return', 'Return', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Return'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '471635ab-01fd-4064-885e-25dd4cecb65d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '471635ab-01fd-4064-885e-25dd4cecb65d'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = 'Return' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '471635ab-01fd-4064-885e-25dd4cecb65d'
);


-- None 바이올린과 피아노를 위한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 모음곡', 'Suite for Violin and Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 229
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c371d87b-b348-4bc2-a7e1-370b5b36afb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c371d87b-b348-4bc2-a7e1-370b5b36afb0'
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c371d87b-b348-4bc2-a7e1-370b5b36afb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c23cb15-414a-4cdc-b937-731e2e87c67d', 1, 'I', 'Largo', 'Suite for Violin and Piano: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c23cb15-414a-4cdc-b937-731e2e87c67d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f71caa09-f2cb-49ba-b36d-8f5e7c6f6f06', 2, 'II', 'Allegretto', 'Suite for Violin and Piano: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f71caa09-f2cb-49ba-b36d-8f5e7c6f6f06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26267815-69b2-4a76-b60e-0423ea004c82', 3, 'III', 'Andante tranquillo', 'Suite for Violin and Piano: III. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26267815-69b2-4a76-b60e-0423ea004c82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf995c7-6d94-4d30-a423-f3659251ebbf', 4, 'IV', 'Allegro marcato', 'Suite for Violin and Piano: IV. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf995c7-6d94-4d30-a423-f3659251ebbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6878f6a5-feeb-4066-907d-59b4d0a4c5b0', 5, 'V', 'Andante calmato', 'Suite for Violin and Piano: V. Andante calmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6878f6a5-feeb-4066-907d-59b4d0a4c5b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff471e57-3f28-4d3b-859e-eab7eb92b4ab', 6, 'VI', 'Presto', 'Suite for Violin and Piano: VI. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 229 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff471e57-3f28-4d3b-859e-eab7eb92b4ab'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 229 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17307, 18581, 19667
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
