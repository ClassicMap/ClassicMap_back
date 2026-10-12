-- Kalevi Aho 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 99개(묶음 11, 다악장 51, 낱곡 37),
-- 새 작품 17개, part 272개, 그 아래 0개.
-- seed 100개 중 82개를 작품·part 에 잇고, 8개를 숨기고, 10개는 그대로 둔다.
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

-- None Acht Jahreszeiten

UPDATE pieces piece
SET piece.title = 'Acht Jahreszeiten', piece.title_en = 'Acht Jahreszeiten',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25682 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ernte', part.name_en = 'Acht Jahreszeiten: I. Ernte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bc4586f1-6a29-4429-a00c-81a97ded1b3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc4586f1-6a29-4429-a00c-81a97ded1b3f', 1, NULL, 'Ernte', 'Acht Jahreszeiten: I. Ernte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc4586f1-6a29-4429-a00c-81a97ded1b3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Herbstverfärbung', part.name_en = 'Acht Jahreszeiten: II. Herbstverfärbung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:73d79787-9320-4ae6-9c9c-b8d13a57cfa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73d79787-9320-4ae6-9c9c-b8d13a57cfa5', 2, NULL, 'Herbstverfärbung', 'Acht Jahreszeiten: II. Herbstverfärbung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73d79787-9320-4ae6-9c9c-b8d13a57cfa5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Schwarzer Schnee', part.name_en = 'Acht Jahreszeiten: III. Schwarzer Schnee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9aa1d55a-a8f9-4458-bad3-0c0b248d190c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aa1d55a-a8f9-4458-bad3-0c0b248d190c', 3, NULL, 'Schwarzer Schnee', 'Acht Jahreszeiten: III. Schwarzer Schnee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aa1d55a-a8f9-4458-bad3-0c0b248d190c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Weihnachtsdunkleheit', part.name_en = 'Acht Jahreszeiten: IV. Weihnachtsdunkleheit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0d64aba4-ec5f-435c-9c34-711d40b8619a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d64aba4-ec5f-435c-9c34-711d40b8619a', 4, NULL, 'Weihnachtsdunkleheit', 'Acht Jahreszeiten: IV. Weihnachtsdunkleheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d64aba4-ec5f-435c-9c34-711d40b8619a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Frostwinter', part.name_en = 'Acht Jahreszeiten: V. Frostwinter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9ff9fbc9-0a4e-45a3-add4-151d251f516e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ff9fbc9-0a4e-45a3-add4-151d251f516e', 5, NULL, 'Frostwinter', 'Acht Jahreszeiten: V. Frostwinter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ff9fbc9-0a4e-45a3-add4-151d251f516e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tragender Schnee', part.name_en = 'Acht Jahreszeiten: VI. Tragender Schnee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9b662ea9-26b8-441d-89d8-c51383c79016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b662ea9-26b8-441d-89d8-c51383c79016', 6, NULL, 'Tragender Schnee', 'Acht Jahreszeiten: VI. Tragender Schnee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b662ea9-26b8-441d-89d8-c51383c79016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Eisschmelze', part.name_en = 'Acht Jahreszeiten: VII. Eisschmelze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:edde3fd9-834d-421b-b14e-9e30e8eb25d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edde3fd9-834d-421b-b14e-9e30e8eb25d6', 7, NULL, 'Eisschmelze', 'Acht Jahreszeiten: VII. Eisschmelze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edde3fd9-834d-421b-b14e-9e30e8eb25d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Mitternachtssonne', part.name_en = 'Acht Jahreszeiten: Mitternachtssonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25682 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:165e6e8e-8331-4886-a5ac-d666b2280778' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:165e6e8e-8331-4886-a5ac-d666b2280778', 8, NULL, 'Mitternachtssonne', 'Acht Jahreszeiten: Mitternachtssonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25682 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:165e6e8e-8331-4886-a5ac-d666b2280778'
);


-- None Alles Vergängliche

UPDATE pieces piece
SET piece.title = 'Alles Vergängliche', piece.title_en = 'Alles Vergängliche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25195 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fantasia', part.name_en = 'Alles Vergängliche: I. Fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25195 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:3f3d657a-b619-4b93-a700-5eaf39cf01f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f3d657a-b619-4b93-a700-5eaf39cf01f5', 1, 'I', 'Fantasia', 'Alles Vergängliche: I. Fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25195 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f3d657a-b619-4b93-a700-5eaf39cf01f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fugue I', part.name_en = 'Alles Vergängliche: II. Fugue I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25195 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9909bd7b-74fa-41cd-be9e-6104b3b6c20a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9909bd7b-74fa-41cd-be9e-6104b3b6c20a', 2, 'II', 'Fugue I', 'Alles Vergängliche: II. Fugue I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25195 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9909bd7b-74fa-41cd-be9e-6104b3b6c20a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Alles Vergängliche: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25195 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c239699b-4a53-4570-9a13-53a96b813579' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c239699b-4a53-4570-9a13-53a96b813579', 3, 'III', 'Adagio', 'Alles Vergängliche: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25195 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c239699b-4a53-4570-9a13-53a96b813579'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue II (Toccata)', part.name_en = 'Alles Vergängliche: IV. Fugue II (Toccata)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25195 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:7abdca04-7d29-4f80-b2e6-e681713dc7c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7abdca04-7d29-4f80-b2e6-e681713dc7c5', 4, 'IV', 'Fugue II (Toccata)', 'Alles Vergängliche: IV. Fugue II (Toccata)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25195 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7abdca04-7d29-4f80-b2e6-e681713dc7c5'
);


-- None Am Horizont

UPDATE pieces piece
SET piece.title = 'Am Horizont', piece.title_en = 'Am Horizont',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23596 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Symphony no. 1

UPDATE pieces piece
SET piece.title = 'Chamber Symphony no. 1', piece.title_en = 'Chamber Symphony no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25334 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Symphony no. 2

UPDATE pieces piece
SET piece.title = 'Chamber Symphony no. 2', piece.title_en = 'Chamber Symphony no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24662 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Symphony no. 3

UPDATE pieces piece
SET piece.title = 'Chamber Symphony no. 3', piece.title_en = 'Chamber Symphony no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23640 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'jäätyivät umpeen levottomat vedet', part.name_en = 'Chamber Symphony no. 3: I. ...jäätyivät umpeen levottomat vedet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23640 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d1f069e1-300a-4e4c-aa64-ab07f4fda274' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1f069e1-300a-4e4c-aa64-ab07f4fda274', 1, 'I', 'jäätyivät umpeen levottomat vedet', 'Chamber Symphony no. 3: I. ...jäätyivät umpeen levottomat vedet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23640 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f069e1-300a-4e4c-aa64-ab07f4fda274'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'ah, olen kuullut villihanhien huudot', part.name_en = 'Chamber Symphony no. 3: II. ...ah, olen kuullut villihanhien huudot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23640 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:797bacfa-dd0c-4b98-8cd3-a82255ebb11c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:797bacfa-dd0c-4b98-8cd3-a82255ebb11c', 2, 'II', 'ah, olen kuullut villihanhien huudot', 'Chamber Symphony no. 3: II. ...ah, olen kuullut villihanhien huudot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23640 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:797bacfa-dd0c-4b98-8cd3-a82255ebb11c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'pitkät yöt sulavat', part.name_en = 'Chamber Symphony no. 3: III. ...pitkät yöt sulavat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23640 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:aca9c01f-1d75-4044-b846-00f312ea0e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aca9c01f-1d75-4044-b846-00f312ea0e09', 3, 'III', 'pitkät yöt sulavat', 'Chamber Symphony no. 3: III. ...pitkät yöt sulavat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23640 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aca9c01f-1d75-4044-b846-00f312ea0e09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'soutaa avomerta päin tulipunainen laiva', part.name_en = 'Chamber Symphony no. 3: IV. ...soutaa avomerta päin tulipunainen laiva',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23640 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d625a015-3e3d-403c-9930-34681fcbebd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d625a015-3e3d-403c-9930-34681fcbebd7', 4, 'IV', 'soutaa avomerta päin tulipunainen laiva', 'Chamber Symphony no. 3: IV. ...soutaa avomerta päin tulipunainen laiva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23640 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d625a015-3e3d-403c-9930-34681fcbebd7'
);


-- None 바순 협주곡

UPDATE pieces piece
SET piece.title = '바순 협주곡', piece.title_en = 'Concerto for Bassoon and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25765 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Concerto for Bassoon and Orchestra: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25765 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:47f2b19f-c9d5-4c7e-bded-fc5d7b4a2fd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f2b19f-c9d5-4c7e-bded-fc5d7b4a2fd8', 1, 'I', 'Andante', 'Concerto for Bassoon and Orchestra: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25765 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f2b19f-c9d5-4c7e-bded-fc5d7b4a2fd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Concerto for Bassoon and Orchestra: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25765 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:27f46ac7-6425-4fa0-b255-8288297cc9b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27f46ac7-6425-4fa0-b255-8288297cc9b6', 2, 'II', 'Vivace', 'Concerto for Bassoon and Orchestra: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25765 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27f46ac7-6425-4fa0-b255-8288297cc9b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Passacaglia (Adagio) e Cadenza', part.name_en = 'Concerto for Bassoon and Orchestra: III. Passacaglia (Adagio) e Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25765 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d696af64-58b1-42cc-a423-cb5c694d5943' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d696af64-58b1-42cc-a423-cb5c694d5943', 3, 'III', 'Passacaglia (Adagio) e Cadenza', 'Concerto for Bassoon and Orchestra: III. Passacaglia (Adagio) e Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25765 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d696af64-58b1-42cc-a423-cb5c694d5943'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Bassoon and Orchestra: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25765 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:deb7d1e0-4af9-48b1-8241-b77fc9755be5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deb7d1e0-4af9-48b1-8241-b77fc9755be5', 4, 'IV', 'Presto', 'Concerto for Bassoon and Orchestra: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25765 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deb7d1e0-4af9-48b1-8241-b77fc9755be5'
);


-- None 첼로 협주곡

UPDATE pieces piece
SET piece.title = '첼로 협주곡', piece.title_en = 'Concerto for Cello and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25320 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩=69 - Poco meno mosso - Più mosso - Presto - Meno mosso - Prestissimo', part.name_en = 'Concerto for Cello and Orchestra: I. ♩=69 - Poco meno mosso - Più mosso - Presto - Meno mosso - Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25320 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:014a39cb-2414-49b6-9c65-42629dcf9c2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:014a39cb-2414-49b6-9c65-42629dcf9c2b', 1, 'I', '♩=69 - Poco meno mosso - Più mosso - Presto - Meno mosso - Prestissimo', 'Concerto for Cello and Orchestra: I. ♩=69 - Poco meno mosso - Più mosso - Presto - Meno mosso - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25320 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014a39cb-2414-49b6-9c65-42629dcf9c2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩=92 - Tranquillo assai - Cadenza - Presto leggierissimo - ♩=52 e stringendo - Coda', part.name_en = 'Concerto for Cello and Orchestra: II. ♩=92 - Tranquillo assai - Cadenza - Presto leggierissimo - ♩=52 e stringendo - Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25320 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:3f911e74-a13b-4752-87df-dcb05f7a873f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f911e74-a13b-4752-87df-dcb05f7a873f', 2, 'II', '♩=92 - Tranquillo assai - Cadenza - Presto leggierissimo - ♩=52 e stringendo - Coda', 'Concerto for Cello and Orchestra: II. ♩=92 - Tranquillo assai - Cadenza - Presto leggierissimo - ♩=52 e stringendo - Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25320 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f911e74-a13b-4752-87df-dcb05f7a873f'
);


-- None 플루트 협주곡

UPDATE pieces piece
SET piece.title = '플루트 협주곡', piece.title_en = 'Concerto for Flute and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24960 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Misterioso, adagio', part.name_en = 'Concerto for Flute and Orchestra: I. Misterioso, adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24960 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:5b92c651-6af9-44f7-bda2-67c1f8622250' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b92c651-6af9-44f7-bda2-67c1f8622250', 1, 'I', 'Misterioso, adagio', 'Concerto for Flute and Orchestra: I. Misterioso, adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24960 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b92c651-6af9-44f7-bda2-67c1f8622250'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto, leggiero - attacca -', part.name_en = 'Concerto for Flute and Orchestra: II. Presto, leggiero - attacca -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24960 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:788090be-23e2-47a5-9dd9-e4160e5f7173' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:788090be-23e2-47a5-9dd9-e4160e5f7173', 2, 'II', 'Presto, leggiero - attacca -', 'Concerto for Flute and Orchestra: II. Presto, leggiero - attacca -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24960 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:788090be-23e2-47a5-9dd9-e4160e5f7173'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Epilogue', part.name_en = 'Concerto for Flute and Orchestra: III. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24960 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:65da82d6-142b-4411-b315-32f48642af6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65da82d6-142b-4411-b315-32f48642af6b', 3, 'III', 'Epilogue', 'Concerto for Flute and Orchestra: III. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24960 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65da82d6-142b-4411-b315-32f48642af6b'
);


-- None Concerto for Guitar and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Guitar and Chamber Orchestra', piece.title_en = 'Concerto for Guitar and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25617 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduzione', part.name_en = 'Concerto for Guitar and Chamber Orchestra: I. Introduzione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0b52f54a-6950-41af-a340-53731c8c6395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b52f54a-6950-41af-a340-53731c8c6395', 1, 'I', 'Introduzione', 'Concerto for Guitar and Chamber Orchestra: I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b52f54a-6950-41af-a340-53731c8c6395'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'Concerto for Guitar and Chamber Orchestra: II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:fa9078a9-128d-4a50-8c71-f12ea71d2062' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa9078a9-128d-4a50-8c71-f12ea71d2062', 2, 'II', 'Allegro molto', 'Concerto for Guitar and Chamber Orchestra: II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa9078a9-128d-4a50-8c71-f12ea71d2062'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Interludio', part.name_en = 'Concerto for Guitar and Chamber Orchestra: III. Interludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4528182c-ed43-44c6-a1c9-37b2eecba797' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4528182c-ed43-44c6-a1c9-37b2eecba797', 3, 'III', 'Interludio', 'Concerto for Guitar and Chamber Orchestra: III. Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4528182c-ed43-44c6-a1c9-37b2eecba797'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante cantabile', part.name_en = 'Concerto for Guitar and Chamber Orchestra: IV. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e26e183d-f594-46f6-a469-f02acededcb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e26e183d-f594-46f6-a469-f02acededcb0', 4, 'IV', 'Andante cantabile', 'Concerto for Guitar and Chamber Orchestra: IV. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e26e183d-f594-46f6-a469-f02acededcb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Misterioso', part.name_en = 'Concerto for Guitar and Chamber Orchestra: V. Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:246838e1-f52c-42a3-92fc-98f7dd6b2d30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:246838e1-f52c-42a3-92fc-98f7dd6b2d30', 5, 'V', 'Misterioso', 'Concerto for Guitar and Chamber Orchestra: V. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:246838e1-f52c-42a3-92fc-98f7dd6b2d30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Guitar and Chamber Orchestra: VI. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4e488c31-c8fe-4e27-aadd-beb291c916df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e488c31-c8fe-4e27-aadd-beb291c916df', 6, 'VI', 'Presto', 'Concerto for Guitar and Chamber Orchestra: VI. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e488c31-c8fe-4e27-aadd-beb291c916df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Epilogue', part.name_en = 'Concerto for Guitar and Chamber Orchestra: VII. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25617 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9174a720-ea78-4a23-933e-b20637cc87dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9174a720-ea78-4a23-933e-b20637cc87dd', 7, 'VII', 'Epilogue', 'Concerto for Guitar and Chamber Orchestra: VII. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25617 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9174a720-ea78-4a23-933e-b20637cc87dd'
);


-- None Concerto for Horn and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Horn and Chamber Orchestra', piece.title_en = 'Concerto for Horn and Chamber Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23867 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오보에 협주곡

UPDATE pieces piece
SET piece.title = '오보에 협주곡', piece.title_en = 'Concerto for Oboe and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23556 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lamento', part.name_en = 'Concerto for Oboe and Orchestra: I. Lamento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23556 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9e855df0-c9f4-4803-a2a8-d630fafd80c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e855df0-c9f4-4803-a2a8-d630fafd80c1', 1, 'I', 'Lamento', 'Concerto for Oboe and Orchestra: I. Lamento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23556 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e855df0-c9f4-4803-a2a8-d630fafd80c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto (–attacca–)', part.name_en = 'Concerto for Oboe and Orchestra: II. Presto (–attacca–)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23556 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9c41e8b9-80aa-4db1-bc28-6e06ebbe0e3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c41e8b9-80aa-4db1-bc28-6e06ebbe0e3a', 2, 'II', 'Presto (–attacca–)', 'Concerto for Oboe and Orchestra: II. Presto (–attacca–)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23556 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c41e8b9-80aa-4db1-bc28-6e06ebbe0e3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Interludium. Adagio (–attacca–)', part.name_en = 'Concerto for Oboe and Orchestra: III. Interludium. Adagio (–attacca–)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23556 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8d3e16fb-6024-4380-9f42-fcc9a74ea6be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d3e16fb-6024-4380-9f42-fcc9a74ea6be', 3, 'III', 'Interludium. Adagio (–attacca–)', 'Concerto for Oboe and Orchestra: III. Interludium. Adagio (–attacca–)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23556 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d3e16fb-6024-4380-9f42-fcc9a74ea6be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cadenza (–attacca–)', part.name_en = 'Concerto for Oboe and Orchestra: IV. Cadenza (–attacca–)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23556 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b631991d-a87a-40fa-9a69-8e66effafee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b631991d-a87a-40fa-9a69-8e66effafee6', 4, 'IV', 'Cadenza (–attacca–)', 'Concerto for Oboe and Orchestra: IV. Cadenza (–attacca–)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23556 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b631991d-a87a-40fa-9a69-8e66effafee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante cantabile – Adagio', part.name_en = 'Concerto for Oboe and Orchestra: V. Andante cantabile – Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23556 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6e7de6f2-5fd8-46cc-a518-ec4f21be788f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7de6f2-5fd8-46cc-a518-ec4f21be788f', 5, 'V', 'Andante cantabile – Adagio', 'Concerto for Oboe and Orchestra: V. Andante cantabile – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23556 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7de6f2-5fd8-46cc-a518-ec4f21be788f'
);


-- None 피아노 협주곡 2번

UPDATE pieces piece
SET piece.title = '피아노 협주곡 2번', piece.title_en = 'Concerto for Piano and String Orchestra (Piano Concerto no. 2)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23953 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23953 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:38a04660-31e8-42f3-bcb9-eab681b162c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38a04660-31e8-42f3-bcb9-eab681b162c0', 1, NULL, 'I', 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23953 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38a04660-31e8-42f3-bcb9-eab681b162c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23953 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:69193f89-a3ca-460f-87f7-4a95d4eea5e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69193f89-a3ca-460f-87f7-4a95d4eea5e5', 2, NULL, 'II', 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23953 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69193f89-a3ca-460f-87f7-4a95d4eea5e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23953 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ca429cca-e4f1-4bc8-adb0-8c4d960a5ead' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca429cca-e4f1-4bc8-adb0-8c4d960a5ead', 3, NULL, 'III', 'Concerto for Piano and String Orchestra (Piano Concerto no. 2): III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23953 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca429cca-e4f1-4bc8-adb0-8c4d960a5ead'
);


-- None Concerto for Recorder and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Recorder and Chamber Orchestra', piece.title_en = 'Concerto for Recorder and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23666 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Misterioso - Presto', part.name_en = 'Concerto for Recorder and Chamber Orchestra: I. Misterioso - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c7de4ef6-ddd3-483c-a192-845539becc20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7de4ef6-ddd3-483c-a192-845539becc20', 1, 'I', 'Misterioso - Presto', 'Concerto for Recorder and Chamber Orchestra: I. Misterioso - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7de4ef6-ddd3-483c-a192-845539becc20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quarter Note = 100', part.name_en = 'Concerto for Recorder and Chamber Orchestra: II. Quarter Note = 100',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:962e4019-6b68-4a39-b26e-d02b10ad52b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:962e4019-6b68-4a39-b26e-d02b10ad52b3', 2, 'II', 'Quarter Note = 100', 'Concerto for Recorder and Chamber Orchestra: II. Quarter Note = 100', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:962e4019-6b68-4a39-b26e-d02b10ad52b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Recorder and Chamber Orchestra: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:65e2478a-b5ed-41af-9edd-865bce09a46e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e2478a-b5ed-41af-9edd-865bce09a46e', 3, 'III', 'Presto', 'Concerto for Recorder and Chamber Orchestra: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e2478a-b5ed-41af-9edd-865bce09a46e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'Concerto for Recorder and Chamber Orchestra: IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6fee3ad7-9737-4f54-a2fa-4877a1813e93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fee3ad7-9737-4f54-a2fa-4877a1813e93', 4, 'IV', 'Allegretto', 'Concerto for Recorder and Chamber Orchestra: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fee3ad7-9737-4f54-a2fa-4877a1813e93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vivace', part.name_en = 'Concerto for Recorder and Chamber Orchestra: V. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:15c1c4b5-fb4d-4397-98e3-dbd71c94c533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15c1c4b5-fb4d-4397-98e3-dbd71c94c533', 5, 'V', 'Vivace', 'Concerto for Recorder and Chamber Orchestra: V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15c1c4b5-fb4d-4397-98e3-dbd71c94c533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Coda', part.name_en = 'Concerto for Recorder and Chamber Orchestra: VI. Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23666 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:1f8a68e9-bab5-47ad-a3e3-bd6495649bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f8a68e9-bab5-47ad-a3e3-bd6495649bef', 6, 'VI', 'Coda', 'Concerto for Recorder and Chamber Orchestra: VI. Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23666 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f8a68e9-bab5-47ad-a3e3-bd6495649bef'
);


-- None Concerto for Soprano Saxophone and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Soprano Saxophone and Chamber Orchestra', piece.title_en = 'Concerto for Soprano Saxophone and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23396 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Invocatio - Presto - Cadenza', part.name_en = 'Concerto for Soprano Saxophone and Chamber Orchestra: I. Invocatio - Presto - Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23396 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:96d7f807-b54c-4ee8-b03b-131d53740822' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d7f807-b54c-4ee8-b03b-131d53740822', 1, 'I', 'Invocatio - Presto - Cadenza', 'Concerto for Soprano Saxophone and Chamber Orchestra: I. Invocatio - Presto - Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23396 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d7f807-b54c-4ee8-b03b-131d53740822'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Misterioso, largo', part.name_en = 'Concerto for Soprano Saxophone and Chamber Orchestra: II. Misterioso, largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23396 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:57c5198b-366a-4fc3-b6a9-883fdfb5b4d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c5198b-366a-4fc3-b6a9-883fdfb5b4d3', 2, 'II', 'Misterioso, largo', 'Concerto for Soprano Saxophone and Chamber Orchestra: II. Misterioso, largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23396 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c5198b-366a-4fc3-b6a9-883fdfb5b4d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto marcato - Presto - Quasi epilogo', part.name_en = 'Concerto for Soprano Saxophone and Chamber Orchestra: III. Allegretto marcato - Presto - Quasi epilogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23396 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8d8bf4c2-892b-42d8-afec-fec086e3ee73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d8bf4c2-892b-42d8-afec-fec086e3ee73', 3, 'III', 'Allegretto marcato - Presto - Quasi epilogo', 'Concerto for Soprano Saxophone and Chamber Orchestra: III. Allegretto marcato - Presto - Quasi epilogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23396 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d8bf4c2-892b-42d8-afec-fec086e3ee73'
);


-- None Concerto for Tenor Saxophone and Small Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Tenor Saxophone and Small Orchestra', piece.title_en = 'Concerto for Tenor Saxophone and Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25461 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mesto', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: I. Mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:384f82a9-5b09-4af4-b9b9-2f1b6e2db3b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:384f82a9-5b09-4af4-b9b9-2f1b6e2db3b9', 1, 'I', 'Mesto', 'Concerto for Tenor Saxophone and Small Orchestra: I. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:384f82a9-5b09-4af4-b9b9-2f1b6e2db3b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Interludio I', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: II. Interludio I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ee09f280-f65c-4d07-babb-5764a4a87302' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee09f280-f65c-4d07-babb-5764a4a87302', 2, 'II', 'Interludio I', 'Concerto for Tenor Saxophone and Small Orchestra: II. Interludio I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee09f280-f65c-4d07-babb-5764a4a87302'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivacissimo, leggiero', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: III. Vivacissimo, leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:7d5cdf27-ac7d-4d8a-a823-df20c40f0624' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d5cdf27-ac7d-4d8a-a823-df20c40f0624', 3, 'III', 'Vivacissimo, leggiero', 'Concerto for Tenor Saxophone and Small Orchestra: III. Vivacissimo, leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d5cdf27-ac7d-4d8a-a823-df20c40f0624'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Interludio II', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: IV. Interludio II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c6de5240-d536-49c9-a401-4354f1d90a25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6de5240-d536-49c9-a401-4354f1d90a25', 4, 'IV', 'Interludio II', 'Concerto for Tenor Saxophone and Small Orchestra: IV. Interludio II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6de5240-d536-49c9-a401-4354f1d90a25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante, dolente', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: V. Andante, dolente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ef166878-af50-422c-8f7c-eb17252a786c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef166878-af50-422c-8f7c-eb17252a786c', 5, 'V', 'Andante, dolente', 'Concerto for Tenor Saxophone and Small Orchestra: V. Andante, dolente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef166878-af50-422c-8f7c-eb17252a786c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegretto ritmico', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: VI. Allegretto ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:79c7cae2-f611-487e-8f96-ad7eada601bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79c7cae2-f611-487e-8f96-ad7eada601bf', 6, 'VI', 'Allegretto ritmico', 'Concerto for Tenor Saxophone and Small Orchestra: VI. Allegretto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c7cae2-f611-487e-8f96-ad7eada601bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Cadenza', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: VII. Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e9d4197c-ecf6-4cfa-bd72-f00cd35790c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d4197c-ecf6-4cfa-bd72-f00cd35790c1', 7, 'VII', 'Cadenza', 'Concerto for Tenor Saxophone and Small Orchestra: VII. Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d4197c-ecf6-4cfa-bd72-f00cd35790c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Epilogo. Andante', part.name_en = 'Concerto for Tenor Saxophone and Small Orchestra: VIII. Epilogo. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25461 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e4b8796a-d177-4e75-914b-e5061b31dbac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b8796a-d177-4e75-914b-e5061b31dbac', 8, 'VIII', 'Epilogo. Andante', 'Concerto for Tenor Saxophone and Small Orchestra: VIII. Epilogo. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25461 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b8796a-d177-4e75-914b-e5061b31dbac'
);


-- None Concerto for Timpani and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Timpani and Orchestra', piece.title_en = 'Concerto for Timpani and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23059 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Barcarola', part.name_en = 'Concerto for Timpani and Orchestra: I. Barcarola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23059 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8f939b36-074b-436b-b6cb-9dba5820f2be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f939b36-074b-436b-b6cb-9dba5820f2be', 1, 'I', 'Barcarola', 'Concerto for Timpani and Orchestra: I. Barcarola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23059 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f939b36-074b-436b-b6cb-9dba5820f2be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo', part.name_en = 'Concerto for Timpani and Orchestra: II. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23059 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:87f0945e-13bb-42dc-afd5-d8213f6561e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f0945e-13bb-42dc-afd5-d8213f6561e8', 2, 'II', 'Intermezzo', 'Concerto for Timpani and Orchestra: II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23059 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f0945e-13bb-42dc-afd5-d8213f6561e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro ritmico', part.name_en = 'Concerto for Timpani and Orchestra: III. Allegro ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23059 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:90500212-b4b4-49de-9e96-6faad1bee224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90500212-b4b4-49de-9e96-6faad1bee224', 3, 'III', 'Allegro ritmico', 'Concerto for Timpani and Orchestra: III. Allegro ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23059 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90500212-b4b4-49de-9e96-6faad1bee224'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mesto', part.name_en = 'Concerto for Timpani and Orchestra: IV. Mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23059 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2c8f1e1e-387d-4300-99bb-68694b92dfac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c8f1e1e-387d-4300-99bb-68694b92dfac', 4, 'IV', 'Mesto', 'Concerto for Timpani and Orchestra: IV. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23059 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c8f1e1e-387d-4300-99bb-68694b92dfac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Presto', part.name_en = 'Concerto for Timpani and Orchestra: V. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23059 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2d59ba5d-c820-4e5c-b646-36bd00cfff6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d59ba5d-c820-4e5c-b646-36bd00cfff6f', 5, 'V', 'Presto', 'Concerto for Timpani and Orchestra: V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23059 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d59ba5d-c820-4e5c-b646-36bd00cfff6f'
);


-- None Concerto for Trumpet and Symphonic Wind Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Trumpet and Symphonic Wind Orchestra', piece.title_en = 'Concerto for Trumpet and Symphonic Wind Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24538 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Misterioso', part.name_en = 'Concerto for Trumpet and Symphonic Wind Orchestra: I. Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24538 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:be98501d-8170-4e6c-bc74-0597a1546612' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be98501d-8170-4e6c-bc74-0597a1546612', 1, 'I', 'Misterioso', 'Concerto for Trumpet and Symphonic Wind Orchestra: I. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24538 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be98501d-8170-4e6c-bc74-0597a1546612'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Concerto for Trumpet and Symphonic Wind Orchestra: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24538 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d3b5d4bd-233b-4433-85cf-c32d9a47fd5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3b5d4bd-233b-4433-85cf-c32d9a47fd5c', 2, 'II', 'Vivace', 'Concerto for Trumpet and Symphonic Wind Orchestra: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24538 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b5d4bd-233b-4433-85cf-c32d9a47fd5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo e cadenza', part.name_en = 'Concerto for Trumpet and Symphonic Wind Orchestra: III. Intermezzo e cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24538 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a9cea273-ffef-4d96-b7ec-9339ea838754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9cea273-ffef-4d96-b7ec-9339ea838754', 3, 'III', 'Intermezzo e cadenza', 'Concerto for Trumpet and Symphonic Wind Orchestra: III. Intermezzo e cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24538 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cea273-ffef-4d96-b7ec-9339ea838754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Capriccioso', part.name_en = 'Concerto for Trumpet and Symphonic Wind Orchestra: IV. Finale. Capriccioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24538 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bbb4f5c2-7023-4dfc-846f-ff262fdb3f3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb4f5c2-7023-4dfc-846f-ff262fdb3f3d', 4, 'IV', 'Finale. Capriccioso', 'Concerto for Trumpet and Symphonic Wind Orchestra: IV. Finale. Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24538 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb4f5c2-7023-4dfc-846f-ff262fdb3f3d'
);


-- None Concerto for Viola and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Viola and Chamber Orchestra', piece.title_en = 'Concerto for Viola and Chamber Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26010 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Contrabassoon Concerto

UPDATE pieces piece
SET piece.title = 'Contrabassoon Concerto', piece.title_en = 'Contrabassoon Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25565 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mesto', part.name_en = 'Contrabassoon Concerto: I. Mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25565 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0528cd7d-1541-4c47-8e54-0902f047bbce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0528cd7d-1541-4c47-8e54-0902f047bbce', 1, 'I', 'Mesto', 'Contrabassoon Concerto: I. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25565 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0528cd7d-1541-4c47-8e54-0902f047bbce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto', part.name_en = 'Contrabassoon Concerto: II. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25565 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b29f4dda-91d0-4e9b-853f-ffa02a8b1414' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29f4dda-91d0-4e9b-853f-ffa02a8b1414', 2, 'II', 'Presto', 'Contrabassoon Concerto: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25565 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29f4dda-91d0-4e9b-853f-ffa02a8b1414'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Misterioso', part.name_en = 'Contrabassoon Concerto: III. Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25565 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ebd742e6-31e1-4250-af80-b8bcf7cdf255' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebd742e6-31e1-4250-af80-b8bcf7cdf255', 3, 'III', 'Misterioso', 'Contrabassoon Concerto: III. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25565 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebd742e6-31e1-4250-af80-b8bcf7cdf255'
);


-- None Double Concerto for Cor anglais, Harp & Orchestra

UPDATE pieces piece
SET piece.title = 'Double Concerto for Cor anglais, Harp & Orchestra', piece.title_en = 'Double Concerto for Cor anglais, Harp & Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24124 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '[without title]', part.name_en = 'Double Concerto for Cor anglais, Harp & Orchestra: I. [without title]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24124 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e0b093db-cb6a-435b-91e3-ee3464b7ea1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b093db-cb6a-435b-91e3-ee3464b7ea1f', 1, 'I', '[without title]', 'Double Concerto for Cor anglais, Harp & Orchestra: I. [without title]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24124 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b093db-cb6a-435b-91e3-ee3464b7ea1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cadenza', part.name_en = 'Double Concerto for Cor anglais, Harp & Orchestra: II. Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24124 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:decfba0c-42f4-4d63-b65f-decda59b11ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:decfba0c-42f4-4d63-b65f-decda59b11ed', 2, 'II', 'Cadenza', 'Double Concerto for Cor anglais, Harp & Orchestra: II. Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24124 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:decfba0c-42f4-4d63-b65f-decda59b11ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Double Concerto for Cor anglais, Harp & Orchestra: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24124 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ecfcaca4-e534-4742-8f79-5a4ce12a2a6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecfcaca4-e534-4742-8f79-5a4ce12a2a6c', 3, 'III', 'Allegro', 'Double Concerto for Cor anglais, Harp & Orchestra: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24124 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecfcaca4-e534-4742-8f79-5a4ce12a2a6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Double Concerto for Cor anglais, Harp & Orchestra: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24124 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:f36cec63-31d1-49f0-a9d7-205e2759a6d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f36cec63-31d1-49f0-a9d7-205e2759a6d4', 4, 'IV', 'Adagio', 'Double Concerto for Cor anglais, Harp & Orchestra: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24124 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36cec63-31d1-49f0-a9d7-205e2759a6d4'
);


-- None Hiljaisuus

UPDATE pieces piece
SET piece.title = 'Hiljaisuus', piece.title_en = 'Hiljaisuus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25663 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Häämarssi I

UPDATE pieces piece
SET piece.title = 'Häämarssi I', piece.title_en = 'Häämarssi I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24278 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Häämarssi II

UPDATE pieces piece
SET piece.title = 'Häämarssi II', piece.title_en = 'Häämarssi II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25021 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ilo ja epäsymmetria (Joy and Asymmetry)

UPDATE pieces piece
SET piece.title = 'Ilo ja epäsymmetria (Joy and Asymmetry)', piece.title_en = 'Ilo ja epäsymmetria (Joy and Asymmetry)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25590 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Sateen syksyt (Rainy autumns)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): IV. Sateen syksyt (Rainy autumns)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:08f3719f-c9ff-4f22-b5e7-52dbe4950565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f3719f-c9ff-4f22-b5e7-52dbe4950565', 1, 'IV', 'Sateen syksyt (Rainy autumns)', 'Ilo ja epäsymmetria (Joy and Asymmetry): IV. Sateen syksyt (Rainy autumns)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f3719f-c9ff-4f22-b5e7-52dbe4950565'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'VII',
    part.name_ko = 'Seison tuulessa (I stand in the wind)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): VII. Seison tuulessa (I stand in the wind)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:1918a546-5f2e-4061-975b-42ba2156e647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1918a546-5f2e-4061-975b-42ba2156e647', 2, 'VII', 'Seison tuulessa (I stand in the wind)', 'Ilo ja epäsymmetria (Joy and Asymmetry): VII. Seison tuulessa (I stand in the wind)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1918a546-5f2e-4061-975b-42ba2156e647'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Suupielessä naurun hiljainen aihe (A hint of laughter in the corner of your mouth)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): III. Suupielessä naurun hiljainen aihe (A hint of laughter in the corner of your mouth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:21f5ddac-0c08-4022-b331-1c8b37006c41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f5ddac-0c08-4022-b331-1c8b37006c41', 3, 'III', 'Suupielessä naurun hiljainen aihe (A hint of laughter in the corner of your mouth)', 'Ilo ja epäsymmetria (Joy and Asymmetry): III. Suupielessä naurun hiljainen aihe (A hint of laughter in the corner of your mouth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f5ddac-0c08-4022-b331-1c8b37006c41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Aina olin (I was always)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): II. Aina olin (I was always)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6df9db26-7d7b-4c0e-b8a1-2a56cb856677' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6df9db26-7d7b-4c0e-b8a1-2a56cb856677', 4, 'II', 'Aina olin (I was always)', 'Ilo ja epäsymmetria (Joy and Asymmetry): II. Aina olin (I was always)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df9db26-7d7b-4c0e-b8a1-2a56cb856677'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tuoli seisoi (The chair stood)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): V. Tuoli seisoi (The chair stood)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:7d94edf0-17e1-44ec-83dd-f73773c16fa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d94edf0-17e1-44ec-83dd-f73773c16fa7', 5, 'V', 'Tuoli seisoi (The chair stood)', 'Ilo ja epäsymmetria (Joy and Asymmetry): V. Tuoli seisoi (The chair stood)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d94edf0-17e1-44ec-83dd-f73773c16fa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Kuljin nuoralla (I walked a tightrope)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): I. Kuljin nuoralla (I walked a tightrope)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:cd382e64-025e-45c7-a32e-693119e6448e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd382e64-025e-45c7-a32e-693119e6448e', 6, 'I', 'Kuljin nuoralla (I walked a tightrope)', 'Ilo ja epäsymmetria (Joy and Asymmetry): I. Kuljin nuoralla (I walked a tightrope)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd382e64-025e-45c7-a32e-693119e6448e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VI',
    part.name_ko = 'Kirkkaudessa (Out of the brightness)', part.name_en = 'Ilo ja epäsymmetria (Joy and Asymmetry): VI. Kirkkaudessa (Out of the brightness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25590 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:fc6fd564-5a5b-4181-ab5d-0eb6a7227941' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc6fd564-5a5b-4181-ab5d-0eb6a7227941', 7, 'VI', 'Kirkkaudessa (Out of the brightness)', 'Ilo ja epäsymmetria (Joy and Asymmetry): VI. Kirkkaudessa (Out of the brightness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25590 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc6fd564-5a5b-4181-ab5d-0eb6a7227941'
);


-- None In memoriam

UPDATE pieces piece
SET piece.title = 'In memoriam', piece.title_en = 'In memoriam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23831 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In memoriam Pehr Henrik Nordgren

UPDATE pieces piece
SET piece.title = 'In memoriam Pehr Henrik Nordgren', piece.title_en = 'In memoriam Pehr Henrik Nordgren',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25205 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kiinalaisia lauluja

UPDATE pieces piece
SET piece.title = 'Kiinalaisia lauluja', piece.title_en = 'Kiinalaisia lauluja',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23079 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Punainen aurinko', part.name_en = 'Kiinalaisia lauluja: I. Punainen aurinko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b813a428-afdd-4599-bceb-14bcd57fb216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b813a428-afdd-4599-bceb-14bcd57fb216', 1, 'I', 'Punainen aurinko', 'Kiinalaisia lauluja: I. Punainen aurinko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b813a428-afdd-4599-bceb-14bcd57fb216'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Miten taipuisa', part.name_en = 'Kiinalaisia lauluja: II. Miten taipuisa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c995eb0c-7114-4147-ae3e-2e5633d69eb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c995eb0c-7114-4147-ae3e-2e5633d69eb5', 2, 'II', 'Miten taipuisa', 'Kiinalaisia lauluja: II. Miten taipuisa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c995eb0c-7114-4147-ae3e-2e5633d69eb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Kultainen lintuhiusneula', part.name_en = 'Kiinalaisia lauluja: III. Kultainen lintuhiusneula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6962a3e4-e613-4415-a7df-3f9d5f2abf95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6962a3e4-e613-4415-a7df-3f9d5f2abf95', 3, 'III', 'Kultainen lintuhiusneula', 'Kiinalaisia lauluja: III. Kultainen lintuhiusneula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6962a3e4-e613-4415-a7df-3f9d5f2abf95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Yöllä, aivan päihdyksissä', part.name_en = 'Kiinalaisia lauluja: IV. Yöllä, aivan päihdyksissä',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:16564f36-2c4d-4b13-a77f-bea7672250d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16564f36-2c4d-4b13-a77f-bea7672250d5', 4, 'IV', 'Yöllä, aivan päihdyksissä', 'Kiinalaisia lauluja: IV. Yöllä, aivan päihdyksissä', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16564f36-2c4d-4b13-a77f-bea7672250d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Syksyn tuuli', part.name_en = 'Kiinalaisia lauluja: V. Syksyn tuuli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:3765b8eb-6b7e-404c-ba62-abd1a6ea6c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3765b8eb-6b7e-404c-ba62-abd1a6ea6c3a', 5, 'V', 'Syksyn tuuli', 'Kiinalaisia lauluja: V. Syksyn tuuli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3765b8eb-6b7e-404c-ba62-abd1a6ea6c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lumen keskellä kevään viesti', part.name_en = 'Kiinalaisia lauluja: VI. Lumen keskellä kevään viesti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23079 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:592034c0-294f-4a98-929e-e1425cf3650e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:592034c0-294f-4a98-929e-e1425cf3650e', 6, 'VI', 'Lumen keskellä kevään viesti', 'Kiinalaisia lauluja: VI. Lumen keskellä kevään viesti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23079 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:592034c0-294f-4a98-929e-e1425cf3650e'
);


-- None Kolme laulua Mawlana Rumin runoihin

UPDATE pieces piece
SET piece.title = 'Kolme laulua Mawlana Rumin runoihin', piece.title_en = 'Kolme laulua Mawlana Rumin runoihin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24903 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Kuolkaa! (Die!)', part.name_en = 'Kolme laulua Mawlana Rumin runoihin: III. Kuolkaa! (Die!)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24903 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:19728979-fb1e-49d5-b4aa-c963b715d4a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19728979-fb1e-49d5-b4aa-c963b715d4a0', 1, 'III', 'Kuolkaa! (Die!)', 'Kolme laulua Mawlana Rumin runoihin: III. Kuolkaa! (Die!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24903 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19728979-fb1e-49d5-b4aa-c963b715d4a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Kotiin! (Homewards!)', part.name_en = 'Kolme laulua Mawlana Rumin runoihin: I. Kotiin! (Homewards!)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24903 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2d009603-375b-4cc8-a415-9b84153b8a09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d009603-375b-4cc8-a415-9b84153b8a09', 2, 'I', 'Kotiin! (Homewards!)', 'Kolme laulua Mawlana Rumin runoihin: I. Kotiin! (Homewards!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24903 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d009603-375b-4cc8-a415-9b84153b8a09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Yksin sinä (You alone)', part.name_en = 'Kolme laulua Mawlana Rumin runoihin: II. Yksin sinä (You alone)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24903 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:92a67ca4-a240-41e5-b60d-7bc66f2405f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a67ca4-a240-41e5-b60d-7bc66f2405f2', 3, 'II', 'Yksin sinä (You alone)', 'Kolme laulua Mawlana Rumin runoihin: II. Yksin sinä (You alone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24903 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a67ca4-a240-41e5-b60d-7bc66f2405f2'
);


-- None Kysymysten kirja

UPDATE pieces piece
SET piece.title = 'Kysymysten kirja', piece.title_en = 'Kysymysten kirja',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23096 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Jos olenkin', part.name_en = 'Kysymysten kirja: I. Jos olenkin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:782809eb-b5c8-4f41-ba49-51086fdf8014' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:782809eb-b5c8-4f41-ba49-51086fdf8014', 1, 'I', 'Jos olenkin', 'Kysymysten kirja: I. Jos olenkin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782809eb-b5c8-4f41-ba49-51086fdf8014'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ruusun asu', part.name_en = 'Kysymysten kirja: II. Ruusun asu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9a2ecd23-db74-4d1f-b100-4fe1b1542707' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a2ecd23-db74-4d1f-b100-4fe1b1542707', 2, 'II', 'Ruusun asu', 'Kysymysten kirja: II. Ruusun asu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a2ecd23-db74-4d1f-b100-4fe1b1542707'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Merenneitojen kyynelet', part.name_en = 'Kysymysten kirja: III. Merenneitojen kyynelet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:815ad867-db59-40fa-a34d-133b1f8846a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:815ad867-db59-40fa-a34d-133b1f8846a2', 3, 'III', 'Merenneitojen kyynelet', 'Kysymysten kirja: III. Merenneitojen kyynelet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:815ad867-db59-40fa-a34d-133b1f8846a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Minne päättyy sateenkaari?', part.name_en = 'Kysymysten kirja: IV. Minne päättyy sateenkaari?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9b6656a9-e7da-43ee-8e77-09d105c3cb29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b6656a9-e7da-43ee-8e77-09d105c3cb29', 4, 'IV', 'Minne päättyy sateenkaari?', 'Kysymysten kirja: IV. Minne päättyy sateenkaari?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b6656a9-e7da-43ee-8e77-09d105c3cb29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Nainen unessa', part.name_en = 'Kysymysten kirja: V. Nainen unessa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:db2fd687-54ae-4b7d-a808-8e48cfb9b87d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db2fd687-54ae-4b7d-a808-8e48cfb9b87d', 5, 'V', 'Nainen unessa', 'Kysymysten kirja: V. Nainen unessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db2fd687-54ae-4b7d-a808-8e48cfb9b87d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Mitä merkitystä?', part.name_en = 'Kysymysten kirja: VI. Mitä merkitystä?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2b554fe4-6e87-4019-97f9-47dc9b717718' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b554fe4-6e87-4019-97f9-47dc9b717718', 6, 'VI', 'Mitä merkitystä?', 'Kysymysten kirja: VI. Mitä merkitystä?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b554fe4-6e87-4019-97f9-47dc9b717718'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Lapsuuteni kuollessa', part.name_en = 'Kysymysten kirja: VII. Lapsuuteni kuollessa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:24ceb65b-e284-4657-9dc1-ab9a4609be38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24ceb65b-e284-4657-9dc1-ab9a4609be38', 7, 'VII', 'Lapsuuteni kuollessa', 'Kysymysten kirja: VII. Lapsuuteni kuollessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24ceb65b-e284-4657-9dc1-ab9a4609be38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Tunneli', part.name_en = 'Kysymysten kirja: VIII. Tunneli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8f8a238c-b184-4d00-a57a-9bce5e8da87a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f8a238c-b184-4d00-a57a-9bce5e8da87a', 8, 'VIII', 'Tunneli', 'Kysymysten kirja: VIII. Tunneli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f8a238c-b184-4d00-a57a-9bce5e8da87a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Kun näen meren', part.name_en = 'Kysymysten kirja: IX. Kun näen meren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:5f6db10b-1ceb-4bed-a843-f639af9c2df5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6db10b-1ceb-4bed-a843-f639af9c2df5', 9, 'IX', 'Kun näen meren', 'Kysymysten kirja: IX. Kun näen meren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6db10b-1ceb-4bed-a843-f639af9c2df5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Kukkiva omenapuu', part.name_en = 'Kysymysten kirja: X. Kukkiva omenapuu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e15a4105-8061-4496-b4a4-99aa3cd7c21b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e15a4105-8061-4496-b4a4-99aa3cd7c21b', 10, 'X', 'Kukkiva omenapuu', 'Kysymysten kirja: X. Kukkiva omenapuu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e15a4105-8061-4496-b4a4-99aa3cd7c21b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Perhoset', part.name_en = 'Kysymysten kirja: XI. Perhoset',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23096 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:fe9d14e5-410b-462b-bdc2-7e0a48a61118' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe9d14e5-410b-462b-bdc2-7e0a48a61118', 11, 'XI', 'Perhoset', 'Kysymysten kirja: XI. Perhoset', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23096 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9d14e5-410b-462b-bdc2-7e0a48a61118'
);


-- None Lamento for Two Violas

UPDATE pieces piece
SET piece.title = 'Lamento for Two Violas', piece.title_en = 'Lamento for Two Violas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25489 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laulu maasta

UPDATE pieces piece
SET piece.title = 'Laulu maasta', piece.title_en = 'Laulu maasta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25161 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ludus solemnis

UPDATE pieces piece
SET piece.title = 'Ludus solemnis', piece.title_en = 'Ludus solemnis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24608 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minea

UPDATE pieces piece
SET piece.title = 'Minea', piece.title_en = 'Minea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24986 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nineteen Preludes

UPDATE pieces piece
SET piece.title = 'Nineteen Preludes', piece.title_en = 'Nineteen Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23661 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Nineteen Preludes: 1. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e7e84c24-e3a6-44d7-9ea1-5ee46d8a63ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7e84c24-e3a6-44d7-9ea1-5ee46d8a63ff', 1, NULL, 'Tranquillo', 'Nineteen Preludes: 1. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e84c24-e3a6-44d7-9ea1-5ee46d8a63ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Nineteen Preludes: 2. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:07b61d32-4510-455f-829f-09246d850d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07b61d32-4510-455f-829f-09246d850d45', 2, NULL, 'Allegro vivace', 'Nineteen Preludes: 2. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07b61d32-4510-455f-829f-09246d850d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Semplice', part.name_en = 'Nineteen Preludes: 3. Semplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ca7dd373-23c3-4fdc-8553-ae0a598b3a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7dd373-23c3-4fdc-8553-ae0a598b3a0a', 3, NULL, 'Semplice', 'Nineteen Preludes: 3. Semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7dd373-23c3-4fdc-8553-ae0a598b3a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Presto', part.name_en = 'Nineteen Preludes: 4. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:488c8c74-606a-4209-8659-c7c0500b3216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:488c8c74-606a-4209-8659-c7c0500b3216', 4, NULL, 'Presto', 'Nineteen Preludes: 4. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:488c8c74-606a-4209-8659-c7c0500b3216'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Grave', part.name_en = 'Nineteen Preludes: 5. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:1e655bcf-ef39-4d5d-a78f-bf8fedf8d661' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e655bcf-ef39-4d5d-a78f-bf8fedf8d661', 5, NULL, 'Grave', 'Nineteen Preludes: 5. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e655bcf-ef39-4d5d-a78f-bf8fedf8d661'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Maestoso', part.name_en = 'Nineteen Preludes: 6. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:ea7ba61d-83f5-446d-8523-945f28814bb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea7ba61d-83f5-446d-8523-945f28814bb9', 6, NULL, 'Maestoso', 'Nineteen Preludes: 6. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7ba61d-83f5-446d-8523-945f28814bb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Presto', part.name_en = 'Nineteen Preludes: 7. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8fd05b85-e814-4c90-ab5c-5f952bcdad2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fd05b85-e814-4c90-ab5c-5f952bcdad2c', 7, NULL, 'Presto', 'Nineteen Preludes: 7. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fd05b85-e814-4c90-ab5c-5f952bcdad2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Nineteen Preludes: 8. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:469d69c8-515b-4888-ab28-506a31ecf297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:469d69c8-515b-4888-ab28-506a31ecf297', 8, NULL, 'Allegretto', 'Nineteen Preludes: 8. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:469d69c8-515b-4888-ab28-506a31ecf297'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Lento assai', part.name_en = 'Nineteen Preludes: 9. Lento assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e1903981-4f88-40a2-9b2e-ae09050513e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1903981-4f88-40a2-9b2e-ae09050513e3', 9, NULL, 'Lento assai', 'Nineteen Preludes: 9. Lento assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1903981-4f88-40a2-9b2e-ae09050513e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Prestissimo', part.name_en = 'Nineteen Preludes: 10. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:65bcaeca-507b-4fc1-b8ed-561c59d37f73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65bcaeca-507b-4fc1-b8ed-561c59d37f73', 10, NULL, 'Prestissimo', 'Nineteen Preludes: 10. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65bcaeca-507b-4fc1-b8ed-561c59d37f73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Nineteen Preludes: 11. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:7f3efd3d-c417-405b-ac7c-64b0a7339cae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f3efd3d-c417-405b-ac7c-64b0a7339cae', 11, NULL, 'Andante', 'Nineteen Preludes: 11. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f3efd3d-c417-405b-ac7c-64b0a7339cae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Allegro - Maestoso', part.name_en = 'Nineteen Preludes: 12. Allegro - Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d1430e9d-d74b-48ba-859d-8029e8120208' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1430e9d-d74b-48ba-859d-8029e8120208', 12, NULL, 'Allegro - Maestoso', 'Nineteen Preludes: 12. Allegro - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1430e9d-d74b-48ba-859d-8029e8120208'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Nineteen Preludes: 13. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:55e45a09-f5e4-4d6a-9b00-95794e77f3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e45a09-f5e4-4d6a-9b00-95794e77f3c8', 13, NULL, 'Allegretto', 'Nineteen Preludes: 13. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e45a09-f5e4-4d6a-9b00-95794e77f3c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Grave', part.name_en = 'Nineteen Preludes: 14. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:827dced3-b2e3-48d0-8334-7279667e07f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:827dced3-b2e3-48d0-8334-7279667e07f6', 14, NULL, 'Grave', 'Nineteen Preludes: 14. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:827dced3-b2e3-48d0-8334-7279667e07f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Moderato grazioso', part.name_en = 'Nineteen Preludes: 15. Moderato grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:87888f7d-daff-4011-977d-967f67f81c83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87888f7d-daff-4011-977d-967f67f81c83', 15, NULL, 'Moderato grazioso', 'Nineteen Preludes: 15. Moderato grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87888f7d-daff-4011-977d-967f67f81c83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Nineteen Preludes: 16. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bf6758a0-ab37-463d-b064-d795983a5e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf6758a0-ab37-463d-b064-d795983a5e6c', 16, NULL, 'Moderato', 'Nineteen Preludes: 16. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf6758a0-ab37-463d-b064-d795983a5e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Andante - Allegro - Adagio', part.name_en = 'Nineteen Preludes: 17. Andante - Allegro - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:5f5389c0-ce81-4b7c-a19d-0d468aef70d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f5389c0-ce81-4b7c-a19d-0d468aef70d6', 17, NULL, 'Andante - Allegro - Adagio', 'Nineteen Preludes: 17. Andante - Allegro - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f5389c0-ce81-4b7c-a19d-0d468aef70d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Lento assai, esitante', part.name_en = 'Nineteen Preludes: 18. Lento assai, esitante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:76baf4e0-c921-4b6c-9ac1-f4005f6df5e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76baf4e0-c921-4b6c-9ac1-f4005f6df5e1', 18, NULL, 'Lento assai, esitante', 'Nineteen Preludes: 18. Lento assai, esitante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76baf4e0-c921-4b6c-9ac1-f4005f6df5e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Nineteen Preludes: 19. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23661 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b356038f-5d56-4c98-8add-4c13bc393f26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b356038f-5d56-4c98-8add-4c13bc393f26', 19, NULL, 'Tranquillo', 'Nineteen Preludes: 19. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23661 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b356038f-5d56-4c98-8add-4c13bc393f26'
);


-- None Nuku, lapsoseni

UPDATE pieces piece
SET piece.title = 'Nuku, lapsoseni', piece.title_en = 'Nuku, lapsoseni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24807 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pergamon (1990) für 4 Orchestergruppen, 4 Rezitatoren und Orgel

UPDATE pieces piece
SET piece.title = 'Pergamon (1990) für 4 Orchestergruppen, 4 Rezitatoren und Orgel', piece.title_en = 'Pergamon (1990) für 4 Orchestergruppen, 4 Rezitatoren und Orgel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23703 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 플루트 4중주

UPDATE pieces piece
SET piece.title = '플루트 4중주', piece.title_en = 'Quartet for Flute, Saxophone, Guitar and Percussion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24240 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Quartet for Flute, Saxophone, Guitar and Percussion: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24240 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:cab139e3-1b73-48f6-8a06-cf3464d42ba3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cab139e3-1b73-48f6-8a06-cf3464d42ba3', 1, NULL, 'I', 'Quartet for Flute, Saxophone, Guitar and Percussion: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24240 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cab139e3-1b73-48f6-8a06-cf3464d42ba3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Quartet for Flute, Saxophone, Guitar and Percussion: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24240 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0ade8551-999f-4ca0-abc6-d1aa855abef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ade8551-999f-4ca0-abc6-d1aa855abef4', 2, NULL, 'II', 'Quartet for Flute, Saxophone, Guitar and Percussion: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24240 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ade8551-999f-4ca0-abc6-d1aa855abef4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Quartet for Flute, Saxophone, Guitar and Percussion: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24240 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:8c4f893f-6f30-4039-99db-e4fcdc2a9b5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c4f893f-6f30-4039-99db-e4fcdc2a9b5b', 3, NULL, 'III', 'Quartet for Flute, Saxophone, Guitar and Percussion: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24240 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4f893f-6f30-4039-99db-e4fcdc2a9b5b'
);


-- None Quasi una fantasia

UPDATE pieces piece
SET piece.title = 'Quasi una fantasia', piece.title_en = 'Quasi una fantasia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25993 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass

UPDATE pieces piece
SET piece.title = 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass', piece.title_en = 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23647 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo - Vivace - Andante', part.name_en = 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: I. Largo - Vivace - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23647 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:cd3328f3-48c1-4183-8416-aa9341bac4d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd3328f3-48c1-4183-8416-aa9341bac4d5', 1, 'I', 'Largo - Vivace - Andante', 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: I. Largo - Vivace - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23647 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd3328f3-48c1-4183-8416-aa9341bac4d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro marcato - Presto', part.name_en = 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: II. Allegro marcato - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23647 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bd4313d0-47df-472b-9ca0-892acbcc8f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd4313d0-47df-472b-9ca0-892acbcc8f77', 2, 'II', 'Allegro marcato - Presto', 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: II. Allegro marcato - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23647 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd4313d0-47df-472b-9ca0-892acbcc8f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante espressivo - Allegro', part.name_en = 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: III. Andante espressivo - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23647 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b3c5931d-ba19-4f36-84ba-8db7682e94e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3c5931d-ba19-4f36-84ba-8db7682e94e0', 3, 'III', 'Andante espressivo - Allegro', 'Quintet for Alto Saxophone, Bassoon, Viola, Cello and Double Bass: III. Andante espressivo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23647 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c5931d-ba19-4f36-84ba-8db7682e94e0'
);


-- None Quintet for Bassoon and String Quartet

UPDATE pieces piece
SET piece.title = 'Quintet for Bassoon and String Quartet', piece.title_en = 'Quintet for Bassoon and String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24761 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouvertüre (Allegro)', part.name_en = 'Quintet for Bassoon and String Quartet: I. Ouvertüre (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:06b770a8-239c-3cae-8bca-7dcf13d6195b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b770a8-239c-3cae-8bca-7dcf13d6195b', 1, 'I', 'Ouvertüre (Allegro)', 'Quintet for Bassoon and String Quartet: I. Ouvertüre (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b770a8-239c-3cae-8bca-7dcf13d6195b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Parodie (Andante)', part.name_en = 'Quintet for Bassoon and String Quartet: II. Parodie (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:843ede2f-7554-3102-a7a7-9e00364b03ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:843ede2f-7554-3102-a7a7-9e00364b03ae', 2, 'II', 'Parodie (Andante)', 'Quintet for Bassoon and String Quartet: II. Parodie (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843ede2f-7554-3102-a7a7-9e00364b03ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo (Presto)', part.name_en = 'Quintet for Bassoon and String Quartet: III. Scherzo (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:69ae9e62-f93a-3efb-88cf-b9ab0fe1226c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ae9e62-f93a-3efb-88cf-b9ab0fe1226c', 3, 'III', 'Scherzo (Presto)', 'Quintet for Bassoon and String Quartet: III. Scherzo (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ae9e62-f93a-3efb-88cf-b9ab0fe1226c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cadenza (Prestissimo)', part.name_en = 'Quintet for Bassoon and String Quartet: IV. Cadenza (Prestissimo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6387ca5b-cd8e-348c-b39a-ed29c6763e87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6387ca5b-cd8e-348c-b39a-ed29c6763e87', 4, 'IV', 'Cadenza (Prestissimo)', 'Quintet for Bassoon and String Quartet: IV. Cadenza (Prestissimo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6387ca5b-cd8e-348c-b39a-ed29c6763e87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale (Allegretto)', part.name_en = 'Quintet for Bassoon and String Quartet: V. Finale (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9d82d310-8a33-3309-a577-1b398e559d41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d82d310-8a33-3309-a577-1b398e559d41', 5, 'V', 'Finale (Allegretto)', 'Quintet for Bassoon and String Quartet: V. Finale (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d82d310-8a33-3309-a577-1b398e559d41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Epilog (Andante)', part.name_en = 'Quintet for Bassoon and String Quartet: VI. Epilog (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24761 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d4d7cc5b-19c5-3d0d-bd53-1cbc1546f0ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d7cc5b-19c5-3d0d-bd53-1cbc1546f0ce', 6, 'VI', 'Epilog (Andante)', 'Quintet for Bassoon and String Quartet: VI. Epilog (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24761 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d7cc5b-19c5-3d0d-bd53-1cbc1546f0ce'
);


-- None Quintet for Clarinet and String Quartet

UPDATE pieces piece
SET piece.title = 'Quintet for Clarinet and String Quartet', piece.title_en = 'Quintet for Clarinet and String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23798 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ = 72 – Presto e leggierissimo', part.name_en = 'Quintet for Clarinet and String Quartet: I. ♩ = 72 – Presto e leggierissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23798 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4d746287-ccc7-402d-a776-b571f6dbe46f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d746287-ccc7-402d-a776-b571f6dbe46f', 1, 'I', '♩ = 72 – Presto e leggierissimo', 'Quintet for Clarinet and String Quartet: I. ♩ = 72 – Presto e leggierissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23798 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d746287-ccc7-402d-a776-b571f6dbe46f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = 116 – Andante', part.name_en = 'Quintet for Clarinet and String Quartet: II. ♩ = 116 – Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23798 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:03d891b0-3f70-4efc-b3e5-0f8e120c264a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d891b0-3f70-4efc-b3e5-0f8e120c264a', 2, 'II', '♩ = 116 – Andante', 'Quintet for Clarinet and String Quartet: II. ♩ = 116 – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23798 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d891b0-3f70-4efc-b3e5-0f8e120c264a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = 80 – Cadenza', part.name_en = 'Quintet for Clarinet and String Quartet: III. ♩ = 80 – Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23798 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d3884cc5-2edf-4668-94cf-c27ac666af6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3884cc5-2edf-4668-94cf-c27ac666af6b', 3, 'III', '♩ = 80 – Cadenza', 'Quintet for Clarinet and String Quartet: III. ♩ = 80 – Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23798 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3884cc5-2edf-4668-94cf-c27ac666af6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Furioso, Prestissimo', part.name_en = 'Quintet for Clarinet and String Quartet: IV. Furioso, Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23798 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bd217902-6cc7-45d2-8c35-781735c7d660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd217902-6cc7-45d2-8c35-781735c7d660', 4, 'IV', 'Furioso, Prestissimo', 'Quintet for Clarinet and String Quartet: IV. Furioso, Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23798 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd217902-6cc7-45d2-8c35-781735c7d660'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Epilogue. Andante', part.name_en = 'Quintet for Clarinet and String Quartet: V. Epilogue. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23798 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e37ccf8d-8937-449d-bc27-ac5a0f81e650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e37ccf8d-8937-449d-bc27-ac5a0f81e650', 5, 'V', 'Epilogue. Andante', 'Quintet for Clarinet and String Quartet: V. Epilogue. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23798 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e37ccf8d-8937-449d-bc27-ac5a0f81e650'
);


-- None 플루트 5중주

UPDATE pieces piece
SET piece.title = '플루트 5중주', piece.title_en = 'Quintet for Flute, Oboe, Violin, Viola and Cello',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24706 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintet for Horn and String Quartet

UPDATE pieces piece
SET piece.title = 'Quintet for Horn and String Quartet', piece.title_en = 'Quintet for Horn and String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23426 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Misterioso', part.name_en = 'Quintet for Horn and String Quartet: I. Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23426 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:063614dd-437f-438c-92a5-d0f3eeb4ed1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:063614dd-437f-438c-92a5-d0f3eeb4ed1f', 1, 'I', 'Misterioso', 'Quintet for Horn and String Quartet: I. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23426 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:063614dd-437f-438c-92a5-d0f3eeb4ed1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Con moto', part.name_en = 'Quintet for Horn and String Quartet: II. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23426 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a1bfacbf-f36e-4dd1-b145-2cd76ce6ebfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1bfacbf-f36e-4dd1-b145-2cd76ce6ebfe', 2, 'II', 'Con moto', 'Quintet for Horn and String Quartet: II. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23426 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1bfacbf-f36e-4dd1-b145-2cd76ce6ebfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Quintet for Horn and String Quartet: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23426 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b656ff09-30a1-443f-b08a-21f7f7724656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b656ff09-30a1-443f-b08a-21f7f7724656', 3, 'III', 'Adagio', 'Quintet for Horn and String Quartet: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23426 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b656ff09-30a1-443f-b08a-21f7f7724656'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'Quintet for Horn and String Quartet: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23426 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:1c9181db-141c-411d-a22a-75dc8f617cc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c9181db-141c-411d-a22a-75dc8f617cc5', 4, 'IV', 'Vivace', 'Quintet for Horn and String Quartet: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23426 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c9181db-141c-411d-a22a-75dc8f617cc5'
);


-- None Quintet for Oboe and String Quartet

UPDATE pieces piece
SET piece.title = 'Quintet for Oboe and String Quartet', piece.title_en = 'Quintet for Oboe and String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24471 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Quintet for Oboe and String Quartet: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24471 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:25e65e8a-085b-348b-82b8-ed6ab89ddeff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25e65e8a-085b-348b-82b8-ed6ab89ddeff', 1, 'I', 'Moderato', 'Quintet for Oboe and String Quartet: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24471 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e65e8a-085b-348b-82b8-ed6ab89ddeff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prestissimo', part.name_en = 'Quintet for Oboe and String Quartet: II. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24471 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:f9bb5966-7f38-32bb-ac7b-8a6318f5f267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bb5966-7f38-32bb-ac7b-8a6318f5f267', 2, 'II', 'Prestissimo', 'Quintet for Oboe and String Quartet: II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24471 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bb5966-7f38-32bb-ac7b-8a6318f5f267'
);


-- None Quintet for Oboe and String Quartet: I. Moderato - Più mosso - Prestissimo - Cadenza (Tempo rubato) - Allegretto

UPDATE pieces piece
SET piece.title = 'Quintet for Oboe and String Quartet: I. Moderato - Più mosso - Prestissimo - Cadenza (Tempo rubato) - Allegretto', piece.title_en = 'Quintet for Oboe and String Quartet: I. Moderato - Più mosso - Prestissimo - Cadenza (Tempo rubato) - Allegretto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24961 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintet for Oboe and String Quartet: II. Prestissimo - Passionato - Allegretto grazioso - Cadenza

UPDATE pieces piece
SET piece.title = 'Quintet for Oboe and String Quartet: II. Prestissimo - Passionato - Allegretto grazioso - Cadenza', piece.title_en = 'Quintet for Oboe and String Quartet: II. Prestissimo - Passionato - Allegretto grazioso - Cadenza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25796 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오보에 5중주

UPDATE pieces piece
SET piece.title = '오보에 5중주', piece.title_en = 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23500 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tranquillo – Allegretto ondeggiante', part.name_en = 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: I. Tranquillo – Allegretto ondeggiante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23500 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0aed3c56-bf6d-4e94-9b43-fa7e05567897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aed3c56-bf6d-4e94-9b43-fa7e05567897', 1, 'I', 'Tranquillo – Allegretto ondeggiante', 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: I. Tranquillo – Allegretto ondeggiante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23500 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aed3c56-bf6d-4e94-9b43-fa7e05567897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Toccata', part.name_en = 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: II. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23500 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c177ffb5-eba8-4bfc-bf07-a0828785ec4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c177ffb5-eba8-4bfc-bf07-a0828785ec4e', 2, 'II', 'Toccata', 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: II. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23500 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c177ffb5-eba8-4bfc-bf07-a0828785ec4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturno', part.name_en = 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: III. Nocturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23500 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c1fdb9e8-e80c-4e2d-8f6f-632a95941d19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1fdb9e8-e80c-4e2d-8f6f-632a95941d19', 3, 'III', 'Nocturno', 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: III. Nocturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23500 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1fdb9e8-e80c-4e2d-8f6f-632a95941d19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Burlesco', part.name_en = 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: IV. Burlesco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23500 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a4be866c-d2ed-49ae-b8dd-83be783a6097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4be866c-d2ed-49ae-b8dd-83be783a6097', 4, 'IV', 'Burlesco', 'Quintet for Oboe, Clarinet, Bassoon, Horn and Piano: IV. Burlesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23500 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4be866c-d2ed-49ae-b8dd-83be783a6097'
);


-- None Sieidi

UPDATE pieces piece
SET piece.title = 'Sieidi', piece.title_en = 'Sieidi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23280 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo I

UPDATE pieces piece
SET piece.title = 'Solo I', piece.title_en = 'Solo I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24839 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo II for Piano

UPDATE pieces piece
SET piece.title = 'Solo II for Piano', piece.title_en = 'Solo II for Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23625 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo III

UPDATE pieces piece
SET piece.title = 'Solo III', piece.title_en = 'Solo III',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23958 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ = 66', part.name_en = 'Solo III: I. ♩ = 66',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23958 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:27dacfd7-d44c-4be7-9e97-7cff32406a63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27dacfd7-d44c-4be7-9e97-7cff32406a63', 1, 'I', '♩ = 66', 'Solo III: I. ♩ = 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23958 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27dacfd7-d44c-4be7-9e97-7cff32406a63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto', part.name_en = 'Solo III: II. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23958 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9293c6bf-8a2c-4ee1-bc2b-f29dd2ef46f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9293c6bf-8a2c-4ee1-bc2b-f29dd2ef46f5', 2, 'II', 'Presto', 'Solo III: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23958 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9293c6bf-8a2c-4ee1-bc2b-f29dd2ef46f5'
);


-- None Solo IV

UPDATE pieces piece
SET piece.title = 'Solo IV', piece.title_en = 'Solo IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24269 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo IX for Oboe

UPDATE pieces piece
SET piece.title = 'Solo IX for Oboe', piece.title_en = 'Solo IX for Oboe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23699 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo V

UPDATE pieces piece
SET piece.title = 'Solo V', piece.title_en = 'Solo V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24409 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo X

UPDATE pieces piece
SET piece.title = 'Solo X', piece.title_en = 'Solo X',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24350 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo XI

UPDATE pieces piece
SET piece.title = 'Solo XI', piece.title_en = 'Solo XI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23397 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo XII — in memoriam EJR

UPDATE pieces piece
SET piece.title = 'Solo XII — in memoriam EJR', piece.title_en = 'Solo XII — in memoriam EJR',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24560 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo XIV

UPDATE pieces piece
SET piece.title = 'Solo XIV', piece.title_en = 'Solo XIV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23869 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata Concertante for Accordion and Strings

UPDATE pieces piece
SET piece.title = 'Sonata Concertante for Accordion and Strings', piece.title_en = 'Sonata Concertante for Accordion and Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25018 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ia. Prelude. Molto rubato', part.name_en = 'Sonata Concertante for Accordion and Strings: Ia. Prelude. Molto rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25018 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:28e676f2-938d-4216-ad62-c0e425554834' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28e676f2-938d-4216-ad62-c0e425554834', 1, NULL, 'Ia. Prelude. Molto rubato', 'Sonata Concertante for Accordion and Strings: Ia. Prelude. Molto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25018 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28e676f2-938d-4216-ad62-c0e425554834'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ib. Passacaglia', part.name_en = 'Sonata Concertante for Accordion and Strings: Ib. Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25018 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:20d93501-64c7-47e6-adf5-096c3ba02478' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d93501-64c7-47e6-adf5-096c3ba02478', 2, NULL, 'Ib. Passacaglia', 'Sonata Concertante for Accordion and Strings: Ib. Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25018 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d93501-64c7-47e6-adf5-096c3ba02478'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IIa. Prelude. Leggiero', part.name_en = 'Sonata Concertante for Accordion and Strings: IIa. Prelude. Leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25018 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:29320bbb-d488-42fa-aaff-0b46431bc94f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29320bbb-d488-42fa-aaff-0b46431bc94f', 3, NULL, 'IIa. Prelude. Leggiero', 'Sonata Concertante for Accordion and Strings: IIa. Prelude. Leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25018 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29320bbb-d488-42fa-aaff-0b46431bc94f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IIb. Fugue. Andante - Più mosso - Leggiero', part.name_en = 'Sonata Concertante for Accordion and Strings: IIb. Fugue. Andante - Più mosso - Leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25018 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:10d62ba4-eb98-4c71-816d-fa4883129076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d62ba4-eb98-4c71-816d-fa4883129076', 4, NULL, 'IIb. Fugue. Andante - Più mosso - Leggiero', 'Sonata Concertante for Accordion and Strings: IIb. Fugue. Andante - Più mosso - Leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25018 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d62ba4-eb98-4c71-816d-fa4883129076'
);


-- None Sonata for 2 Accordions

UPDATE pieces piece
SET piece.title = 'Sonata for 2 Accordions', piece.title_en = 'Sonata for 2 Accordions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25629 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude (Molto rubato) and Passacaglia', part.name_en = 'Sonata for 2 Accordions: I. Prelude (Molto rubato) and Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25629 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c72cf68c-f06a-4275-ab9d-61428e69fe95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c72cf68c-f06a-4275-ab9d-61428e69fe95', 1, 'I', 'Prelude (Molto rubato) and Passacaglia', 'Sonata for 2 Accordions: I. Prelude (Molto rubato) and Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25629 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72cf68c-f06a-4275-ab9d-61428e69fe95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prelude (Leggiero) and Fugue (Andante – Più mosso – Leggiero)', part.name_en = 'Sonata for 2 Accordions: II. Prelude (Leggiero) and Fugue (Andante – Più mosso – Leggiero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25629 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0e35318d-ad82-42f6-bc92-16e0ffe441f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e35318d-ad82-42f6-bc92-16e0ffe441f1', 2, 'II', 'Prelude (Leggiero) and Fugue (Andante – Più mosso – Leggiero)', 'Sonata for 2 Accordions: II. Prelude (Leggiero) and Fugue (Andante – Più mosso – Leggiero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25629 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e35318d-ad82-42f6-bc92-16e0ffe441f1'
);


-- None 오보에와 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '오보에와 피아노를 위한 소나타', piece.title_en = 'Sonata for Oboe and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25736 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Sonata for Oboe and Piano: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25736 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2f66746b-9c90-4d45-9125-93ef6fcdbac4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f66746b-9c90-4d45-9125-93ef6fcdbac4', 1, NULL, 'I', 'Sonata for Oboe and Piano: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25736 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f66746b-9c90-4d45-9125-93ef6fcdbac4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Sonata for Oboe and Piano: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25736 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:dc8a722e-2f42-4b3f-88bc-4cce7059e038' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc8a722e-2f42-4b3f-88bc-4cce7059e038', 2, NULL, 'II', 'Sonata for Oboe and Piano: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25736 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc8a722e-2f42-4b3f-88bc-4cce7059e038'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Sonata for Oboe and Piano: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25736 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:bb8cc662-6f13-4748-91c7-1bb79fe61aa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8cc662-6f13-4748-91c7-1bb79fe61aa9', 3, NULL, 'III', 'Sonata for Oboe and Piano: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25736 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8cc662-6f13-4748-91c7-1bb79fe61aa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Sonata for Oboe and Piano: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25736 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e763b4fc-d5f3-4648-bb12-e67acf2ec423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e763b4fc-d5f3-4648-bb12-e67acf2ec423', 4, NULL, 'IV', 'Sonata for Oboe and Piano: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25736 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e763b4fc-d5f3-4648-bb12-e67acf2ec423'
);


-- None 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Sonata for Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23064 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '[no tempo marking]', part.name_en = 'Sonata for Piano: I. [no tempo marking]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23064 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:455d31f5-c365-4e77-99ce-ac70a2b271d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:455d31f5-c365-4e77-99ce-ac70a2b271d0', 1, 'I', '[no tempo marking]', 'Sonata for Piano: I. [no tempo marking]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23064 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:455d31f5-c365-4e77-99ce-ac70a2b271d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'Sonata for Piano: II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23064 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0ac9cbaf-4551-4929-9b52-53d7b0f6cc6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ac9cbaf-4551-4929-9b52-53d7b0f6cc6d', 2, 'II', 'Allegro molto', 'Sonata for Piano: II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23064 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ac9cbaf-4551-4929-9b52-53d7b0f6cc6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tranquillo molto', part.name_en = 'Sonata for Piano: III. Tranquillo molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23064 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:538c2c55-32b8-4fe4-bf72-59d2967a97ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:538c2c55-32b8-4fe4-bf72-59d2967a97ec', 3, 'III', 'Tranquillo molto', 'Sonata for Piano: III. Tranquillo molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23064 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:538c2c55-32b8-4fe4-bf72-59d2967a97ec'
);


-- None 교향곡 11번

UPDATE pieces piece
SET piece.title = '교향곡 11번', piece.title_en = 'Symphony no. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23065 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 11 for Six Percussionists and Orchestra: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23065 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:67bb6fa9-7849-319a-b4ff-39de88c2d9b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67bb6fa9-7849-319a-b4ff-39de88c2d9b8', 1, NULL, 'I', 'Symphony no. 11 for Six Percussionists and Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23065 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67bb6fa9-7849-319a-b4ff-39de88c2d9b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante - Allegro ritmico', part.name_en = 'Symphony no. 11 for Six Percussionists and Orchestra: II. Andante - Allegro ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23065 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a37d0c20-6862-3b0c-86e8-4ca1b536b99e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a37d0c20-6862-3b0c-86e8-4ca1b536b99e', 2, NULL, 'Andante - Allegro ritmico', 'Symphony no. 11 for Six Percussionists and Orchestra: II. Andante - Allegro ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23065 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a37d0c20-6862-3b0c-86e8-4ca1b536b99e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Symphony no. 11 for Six Percussionists and Orchestra: III. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23065 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:cd8a78cf-9907-3b41-b405-b3a6709dfb62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd8a78cf-9907-3b41-b405-b3a6709dfb62', 3, NULL, 'Tranquillo', 'Symphony no. 11 for Six Percussionists and Orchestra: III. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23065 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd8a78cf-9907-3b41-b405-b3a6709dfb62'
);


-- None 교향곡 12번 "Luosto"

UPDATE pieces piece
SET piece.title = '교향곡 12번 "Luosto"', piece.title_en = 'Symphony no. 12 “Luosto”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24549 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Šamaanit', part.name_en = 'Symphony no. 12 “Luosto”: I. Šamaanit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24549 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:5eb96de8-c7ba-3db6-90a4-dbaef34fb188' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb96de8-c7ba-3db6-90a4-dbaef34fb188', 1, 'I', 'Šamaanit', 'Symphony no. 12 “Luosto”: I. Šamaanit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24549 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb96de8-c7ba-3db6-90a4-dbaef34fb188'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kaamos ja keskikesä', part.name_en = 'Symphony no. 12 “Luosto”: II. Kaamos ja keskikesä',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24549 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a597f1a7-644d-36c2-824d-fdb9d433c643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a597f1a7-644d-36c2-824d-fdb9d433c643', 2, 'II', 'Kaamos ja keskikesä', 'Symphony no. 12 “Luosto”: II. Kaamos ja keskikesä', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24549 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a597f1a7-644d-36c2-824d-fdb9d433c643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Laulu tunturissa', part.name_en = 'Symphony no. 12 “Luosto”: III. Laulu tunturissa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24549 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:09356472-0764-3678-b023-ff314b0125f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09356472-0764-3678-b023-ff314b0125f7', 3, 'III', 'Laulu tunturissa', 'Symphony no. 12 “Luosto”: III. Laulu tunturissa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24549 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09356472-0764-3678-b023-ff314b0125f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Myrsky tunturissa', part.name_en = 'Symphony no. 12 “Luosto”: IV. Myrsky tunturissa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24549 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:840711e8-32af-3dae-ac08-ae610f7c206a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840711e8-32af-3dae-ac08-ae610f7c206a', 4, 'IV', 'Myrsky tunturissa', 'Symphony no. 12 “Luosto”: IV. Myrsky tunturissa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24549 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840711e8-32af-3dae-ac08-ae610f7c206a'
);


-- None 교향곡 13번 "Sinfonisia luonnekuvia"

UPDATE pieces piece
SET piece.title = '교향곡 13번 "Sinfonisia luonnekuvia"', piece.title_en = 'Symphony no. 13 “Sinfonisia luonnekuvia”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23228 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 13 “Sinfonisia luonnekuvia”: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23228 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4cf5b384-2754-4022-a996-a9777fa3b628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cf5b384-2754-4022-a996-a9777fa3b628', 1, NULL, 'I', 'Symphony no. 13 “Sinfonisia luonnekuvia”: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23228 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cf5b384-2754-4022-a996-a9777fa3b628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Symphony no. 13 “Sinfonisia luonnekuvia”: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23228 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:77fc6c72-2b80-4922-a50d-9372647189a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77fc6c72-2b80-4922-a50d-9372647189a6', 2, NULL, 'II', 'Symphony no. 13 “Sinfonisia luonnekuvia”: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23228 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77fc6c72-2b80-4922-a50d-9372647189a6'
);


-- None 교향곡 14번 "Rituaaleja"

UPDATE pieces piece
SET piece.title = '교향곡 14번 "Rituaaleja"', piece.title_en = 'Symphony no. 14 "Rituaaleja"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23100 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Loitsu I (Kiihko)', part.name_en = 'Symphony no. 14 "Rituaaleja": Loitsu I (Kiihko)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:25a4c097-2edd-4595-b881-e5b67ebfd159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25a4c097-2edd-4595-b881-e5b67ebfd159', 1, NULL, 'Loitsu I (Kiihko)', 'Symphony no. 14 "Rituaaleja": Loitsu I (Kiihko)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a4c097-2edd-4595-b881-e5b67ebfd159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interludi I', part.name_en = 'Symphony no. 14 "Rituaaleja": Interludi I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:12b5f293-d48b-4647-a74a-a4f4ca3b9566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b5f293-d48b-4647-a74a-a4f4ca3b9566', 2, NULL, 'Interludi I', 'Symphony no. 14 "Rituaaleja": Interludi I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b5f293-d48b-4647-a74a-a4f4ca3b9566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Loitsu II (Kaiho ja vimma)', part.name_en = 'Symphony no. 14 "Rituaaleja": Loitsu II (Kaiho ja vimma)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:32e9c4e1-39f0-4127-94b7-cd4525545196' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32e9c4e1-39f0-4127-94b7-cd4525545196', 3, NULL, 'Loitsu II (Kaiho ja vimma)', 'Symphony no. 14 "Rituaaleja": Loitsu II (Kaiho ja vimma)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32e9c4e1-39f0-4127-94b7-cd4525545196'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Kulkue', part.name_en = 'Symphony no. 14 "Rituaaleja": Kulkue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:51fe0ac3-6d56-4bd0-8ef6-d91b05ff32b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51fe0ac3-6d56-4bd0-8ef6-d91b05ff32b0', 4, NULL, 'Kulkue', 'Symphony no. 14 "Rituaaleja": Kulkue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51fe0ac3-6d56-4bd0-8ef6-d91b05ff32b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Interludi II', part.name_en = 'Symphony no. 14 "Rituaaleja": Interludi II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d72582fc-ce38-4b8e-bc47-fa10e640e4f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d72582fc-ce38-4b8e-bc47-fa10e640e4f2', 5, NULL, 'Interludi II', 'Symphony no. 14 "Rituaaleja": Interludi II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d72582fc-ce38-4b8e-bc47-fa10e640e4f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Loitsu III (Lopetuksen mantra)', part.name_en = 'Symphony no. 14 "Rituaaleja": Loitsu III (Lopetuksen mantra)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23100 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c2720705-f652-4909-9823-3bdbb80881b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2720705-f652-4909-9823-3bdbb80881b3', 6, NULL, 'Loitsu III (Lopetuksen mantra)', 'Symphony no. 14 "Rituaaleja": Loitsu III (Lopetuksen mantra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23100 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2720705-f652-4909-9823-3bdbb80881b3'
);


-- None 교향곡 17번 "Symphonic Frescoes"

UPDATE pieces piece
SET piece.title = '교향곡 17번 "Symphonic Frescoes"', piece.title_en = 'Symphony no. 17 ‘Symphonic Frescoes’',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23259 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Syvyydestä (From the Deep)', part.name_en = 'Symphony no. 17 ‘Symphonic Frescoes’: I. Syvyydestä (From the Deep)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23259 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6ce74ce2-d26b-4ccf-be51-4a9965b0ea71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ce74ce2-d26b-4ccf-be51-4a9965b0ea71', 1, 'I', 'Syvyydestä (From the Deep)', 'Symphony no. 17 ‘Symphonic Frescoes’: I. Syvyydestä (From the Deep)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23259 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce74ce2-d26b-4ccf-be51-4a9965b0ea71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo macabre', part.name_en = 'Symphony no. 17 ‘Symphonic Frescoes’: II. Scherzo macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23259 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:397d4680-20b7-4fc4-ac81-e4ea3ae66cb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397d4680-20b7-4fc4-ac81-e4ea3ae66cb7', 2, 'II', 'Scherzo macabre', 'Symphony no. 17 ‘Symphonic Frescoes’: II. Scherzo macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23259 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397d4680-20b7-4fc4-ac81-e4ea3ae66cb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Kaukaisia lauluja (Distant Songs)', part.name_en = 'Symphony no. 17 ‘Symphonic Frescoes’: III. Kaukaisia lauluja (Distant Songs)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23259 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d7223492-c3f2-4e9c-8583-670ca058f55c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7223492-c3f2-4e9c-8583-670ca058f55c', 3, 'III', 'Kaukaisia lauluja (Distant Songs)', 'Symphony no. 17 ‘Symphonic Frescoes’: III. Kaukaisia lauluja (Distant Songs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23259 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7223492-c3f2-4e9c-8583-670ca058f55c'
);


-- None 교향곡 3번 "Sinfonia concertante"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "Sinfonia concertante"', piece.title_en = 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25135 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25135 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a9a457ca-c40f-37f3-ab21-673a9ba7be97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a457ca-c40f-37f3-ab21-673a9ba7be97', 1, 'I', 'Andante', 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25135 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a457ca-c40f-37f3-ab21-673a9ba7be97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prestissimo', part.name_en = 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": II. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25135 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:871188ce-9c5b-3446-ad17-d862b3e57cdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871188ce-9c5b-3446-ad17-d862b3e57cdc', 2, 'II', 'Prestissimo', 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25135 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871188ce-9c5b-3446-ad17-d862b3e57cdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25135 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:f271b709-820f-3bc2-8eeb-a5674269ab44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f271b709-820f-3bc2-8eeb-a5674269ab44', 3, 'III', 'Lento', 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25135 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f271b709-820f-3bc2-8eeb-a5674269ab44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25135 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4153c2e4-32ff-3189-b748-63e461e01745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4153c2e4-32ff-3189-b748-63e461e01745', 4, 'IV', 'Presto', 'Symphony no. 3 for Violin and Orchestra "Sinfonia concertante": IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25135 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4153c2e4-32ff-3189-b748-63e461e01745'
);


-- None 교향곡 7번 "Insect Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 7번 "Insect Symphony"', piece.title_en = 'Symphony no. 7 "Insect Symphony"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24001 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Tramp, the Parasitic Hymenopter and its Larva', part.name_en = 'Symphony no. 7 "Insect Symphony": I. The Tramp, the Parasitic Hymenopter and its Larva',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:58a37f92-84b6-4d02-8d56-4804aa063ade' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58a37f92-84b6-4d02-8d56-4804aa063ade', 1, 'I', 'The Tramp, the Parasitic Hymenopter and its Larva', 'Symphony no. 7 "Insect Symphony": I. The Tramp, the Parasitic Hymenopter and its Larva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58a37f92-84b6-4d02-8d56-4804aa063ade'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Butterflies (The Foxtrot and Tango of the Butterflies)', part.name_en = 'Symphony no. 7 "Insect Symphony": II. The Butterflies (The Foxtrot and Tango of the Butterflies)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:c4505e4e-e84f-49da-ad67-6f6311f6ec42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4505e4e-e84f-49da-ad67-6f6311f6ec42', 2, 'II', 'The Butterflies (The Foxtrot and Tango of the Butterflies)', 'Symphony no. 7 "Insect Symphony": II. The Butterflies (The Foxtrot and Tango of the Butterflies)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4505e4e-e84f-49da-ad67-6f6311f6ec42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Dung Beetles (Grief over the Stolen Ball of Dung)', part.name_en = 'Symphony no. 7 "Insect Symphony": III. The Dung Beetles (Grief over the Stolen Ball of Dung)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d7e2b4fb-dbca-4763-92b7-3c6d9d777bb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7e2b4fb-dbca-4763-92b7-3c6d9d777bb5', 3, 'III', 'The Dung Beetles (Grief over the Stolen Ball of Dung)', 'Symphony no. 7 "Insect Symphony": III. The Dung Beetles (Grief over the Stolen Ball of Dung)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7e2b4fb-dbca-4763-92b7-3c6d9d777bb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Grasshoppers', part.name_en = 'Symphony no. 7 "Insect Symphony": IV. The Grasshoppers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:dc7b4410-fbeb-4a4a-8cf8-caa71242321a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc7b4410-fbeb-4a4a-8cf8-caa71242321a', 4, 'IV', 'The Grasshoppers', 'Symphony no. 7 "Insect Symphony": IV. The Grasshoppers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7b4410-fbeb-4a4a-8cf8-caa71242321a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Ants (The Working Music of the Ants and War Marches I and II)', part.name_en = 'Symphony no. 7 "Insect Symphony": V. The Ants (The Working Music of the Ants and War Marches I and II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:2912bc4c-b996-4a45-9509-70d40d92ff50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2912bc4c-b996-4a45-9509-70d40d92ff50', 5, 'V', 'The Ants (The Working Music of the Ants and War Marches I and II)', 'Symphony no. 7 "Insect Symphony": V. The Ants (The Working Music of the Ants and War Marches I and II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2912bc4c-b996-4a45-9509-70d40d92ff50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Dayflies and Lullaby for the Dead Dayflies', part.name_en = 'Symphony no. 7 "Insect Symphony": VI. The Dayflies and Lullaby for the Dead Dayflies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24001 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:96e2914f-81a4-4f4f-975a-42177981a5c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e2914f-81a4-4f4f-975a-42177981a5c1', 6, 'VI', 'The Dayflies and Lullaby for the Dead Dayflies', 'Symphony no. 7 "Insect Symphony": VI. The Dayflies and Lullaby for the Dead Dayflies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24001 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e2914f-81a4-4f4f-975a-42177981a5c1'
);


-- None Syvien vesien juhla

UPDATE pieces piece
SET piece.title = 'Syvien vesien juhla', piece.title_en = 'Syvien vesien juhla',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25599 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tenorisaksofonikonsertto

UPDATE pieces piece
SET piece.title = 'Tenorisaksofonikonsertto', piece.title_en = 'Tenorisaksofonikonsertto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25793 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Interludes for Organ

UPDATE pieces piece
SET piece.title = 'Three Interludes for Organ', piece.title_en = 'Three Interludes for Organ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23306 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Interlude I', part.name_en = 'Three Interludes for Organ: Interlude I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23306 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0c918622-b9d8-4caa-bb40-d90307ce2d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c918622-b9d8-4caa-bb40-d90307ce2d45', 1, NULL, 'Interlude I', 'Three Interludes for Organ: Interlude I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23306 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c918622-b9d8-4caa-bb40-d90307ce2d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interlude II', part.name_en = 'Three Interludes for Organ: Interlude II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23306 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:62d339aa-8e82-43f8-85b0-a747508dbf15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62d339aa-8e82-43f8-85b0-a747508dbf15', 2, NULL, 'Interlude II', 'Three Interludes for Organ: Interlude II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23306 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62d339aa-8e82-43f8-85b0-a747508dbf15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Interlude III', part.name_en = 'Three Interludes for Organ: Interlude III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23306 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:44957c81-a696-4b6f-9d16-0351e25332d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44957c81-a696-4b6f-9d16-0351e25332d9', 3, NULL, 'Interlude III', 'Three Interludes for Organ: Interlude III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23306 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44957c81-a696-4b6f-9d16-0351e25332d9'
);


-- None Three Small Piano Pieces

UPDATE pieces piece
SET piece.title = 'Three Small Piano Pieces', piece.title_en = 'Three Small Piano Pieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24636 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Maestoso', part.name_en = 'Three Small Piano Pieces: 1. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24636 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:21498b22-af29-48b2-b5b3-e2f6a5296504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21498b22-af29-48b2-b5b3-e2f6a5296504', 1, NULL, 'Maestoso', 'Three Small Piano Pieces: 1. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24636 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21498b22-af29-48b2-b5b3-e2f6a5296504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Three Small Piano Pieces: 2. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24636 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:88e67d37-c041-4d38-bad4-f3cc09544ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88e67d37-c041-4d38-bad4-f3cc09544ef6', 2, NULL, 'Tranquillo', 'Three Small Piano Pieces: 2. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24636 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88e67d37-c041-4d38-bad4-f3cc09544ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Maestoso', part.name_en = 'Three Small Piano Pieces: 3. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24636 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b591f501-6118-42e5-90bc-b7ba867273d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b591f501-6118-42e5-90bc-b7ba867273d0', 3, NULL, 'Maestoso', 'Three Small Piano Pieces: 3. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24636 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b591f501-6118-42e5-90bc-b7ba867273d0'
);


-- None Trio for Clarinet, Viola and Piano

UPDATE pieces piece
SET piece.title = 'Trio for Clarinet, Viola and Piano', piece.title_en = 'Trio for Clarinet, Viola and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24579 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triple Concerto for Violin, Cello, Piano & Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra', piece.title_en = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25768 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lullaby. Andante', part.name_en = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: I. Lullaby. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25768 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:62f287c7-2e77-4752-831a-04e75a95108b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62f287c7-2e77-4752-831a-04e75a95108b', 1, 'I', 'Lullaby. Andante', 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: I. Lullaby. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25768 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f287c7-2e77-4752-831a-04e75a95108b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto', part.name_en = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: II. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25768 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:e5da908e-6930-4aad-a087-440999f6ff24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5da908e-6930-4aad-a087-440999f6ff24', 2, 'II', 'Presto', 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25768 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5da908e-6930-4aad-a087-440999f6ff24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tranquillo, misterioso', part.name_en = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: III. Tranquillo, misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25768 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:6efb34aa-e308-4eb4-883a-c688b62ff4fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6efb34aa-e308-4eb4-883a-c688b62ff4fe', 3, 'III', 'Tranquillo, misterioso', 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: III. Tranquillo, misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25768 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6efb34aa-e308-4eb4-883a-c688b62ff4fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante – Allegro molto', part.name_en = 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: IV. Andante – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25768 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:a999c1d8-1e07-48bd-a105-de388ab3f6b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a999c1d8-1e07-48bd-a105-de388ab3f6b5', 4, 'IV', 'Andante – Allegro molto', 'Triple Concerto for Violin, Cello, Piano & Chamber Orchestra: IV. Andante – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25768 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a999c1d8-1e07-48bd-a105-de388ab3f6b5'
);


-- None Trombone Concerto

UPDATE pieces piece
SET piece.title = 'Trombone Concerto', piece.title_en = 'Trombone Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23691 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tranquillo', part.name_en = 'Trombone Concerto: I. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23691 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:1a9e019a-2583-41a1-acbc-d52833d7871a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a9e019a-2583-41a1-acbc-d52833d7871a', 1, 'I', 'Tranquillo', 'Trombone Concerto: I. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23691 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a9e019a-2583-41a1-acbc-d52833d7871a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto', part.name_en = 'Trombone Concerto: II. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23691 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:b1ee341f-8084-4185-854a-f15657b91306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ee341f-8084-4185-854a-f15657b91306', 2, 'II', 'Presto', 'Trombone Concerto: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23691 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ee341f-8084-4185-854a-f15657b91306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Trombone Concerto: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23691 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:fec34593-94fa-4040-994c-4678794faeed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fec34593-94fa-4040-994c-4678794faeed', 3, 'III', 'Adagio', 'Trombone Concerto: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23691 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fec34593-94fa-4040-994c-4678794faeed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace - Tranquillo', part.name_en = 'Trombone Concerto: IV. Vivace - Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23691 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:99e7cfe2-0c2d-4893-b7f7-30de786fd756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99e7cfe2-0c2d-4893-b7f7-30de786fd756', 4, 'IV', 'Vivace - Tranquillo', 'Trombone Concerto: IV. Vivace - Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23691 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e7cfe2-0c2d-4893-b7f7-30de786fd756'
);


-- None Tuba Concerto

UPDATE pieces piece
SET piece.title = 'Tuba Concerto', piece.title_en = 'Tuba Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24527 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Tuba Concerto: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24527 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:f566795f-8788-4468-8dee-4f1f393d5258' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f566795f-8788-4468-8dee-4f1f393d5258', 1, 'I', 'Andante', 'Tuba Concerto: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24527 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f566795f-8788-4468-8dee-4f1f393d5258'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro - Cadenza - Tempo I', part.name_en = 'Tuba Concerto: II. Allegro - Cadenza - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24527 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:3b3b7045-ea9c-460a-b614-1dd6e4cb124f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b3b7045-ea9c-460a-b614-1dd6e4cb124f', 2, 'II', 'Allegro - Cadenza - Tempo I', 'Tuba Concerto: II. Allegro - Cadenza - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24527 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b3b7045-ea9c-460a-b614-1dd6e4cb124f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Larghetto - Presto - Tempo I', part.name_en = 'Tuba Concerto: III. Larghetto - Presto - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24527 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d55d86c1-003e-4b54-9067-7bc195fd4148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d55d86c1-003e-4b54-9067-7bc195fd4148', 3, 'III', 'Larghetto - Presto - Tempo I', 'Tuba Concerto: III. Larghetto - Presto - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24527 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55d86c1-003e-4b54-9067-7bc195fd4148'
);


-- None Two Easy Piano Pieces for Children

UPDATE pieces piece
SET piece.title = 'Two Easy Piano Pieces for Children', piece.title_en = 'Two Easy Piano Pieces for Children',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23356 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Two Easy Piano Pieces for Children: 1. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23356 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4aefff6f-22ea-4bfb-b36a-b813cb8b0842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aefff6f-22ea-4bfb-b36a-b813cb8b0842', 1, NULL, 'Andante', 'Two Easy Piano Pieces for Children: 1. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23356 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aefff6f-22ea-4bfb-b36a-b813cb8b0842'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Two Easy Piano Pieces for Children: 2. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23356 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:47b45c18-7292-4d76-b175-41df6d1c44d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47b45c18-7292-4d76-b175-41df6d1c44d7', 2, NULL, 'Allegretto', 'Two Easy Piano Pieces for Children: 2. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23356 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47b45c18-7292-4d76-b175-41df6d1c44d7'
);


-- None 바이올린 협주곡 2번

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번', piece.title_en = 'Violin Concerto no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24932 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Violin Concerto no. 2: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24932 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:9bd36d6f-7d93-4d8e-ae17-22a03e605543' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bd36d6f-7d93-4d8e-ae17-22a03e605543', 1, 'I', 'Allegro', 'Violin Concerto no. 2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24932 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bd36d6f-7d93-4d8e-ae17-22a03e605543'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Violin Concerto no. 2: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24932 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:77043444-0f82-4075-9513-592ad2763776' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77043444-0f82-4075-9513-592ad2763776', 2, 'II', 'Adagio', 'Violin Concerto no. 2: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24932 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77043444-0f82-4075-9513-592ad2763776'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace. Leggiero', part.name_en = 'Violin Concerto no. 2: III. Vivace. Leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24932 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:86be3ee0-72a8-4553-9ffb-a92ec3ce9025' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86be3ee0-72a8-4553-9ffb-a92ec3ce9025', 3, 'III', 'Vivace. Leggiero', 'Violin Concerto no. 2: III. Vivace. Leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24932 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86be3ee0-72a8-4553-9ffb-a92ec3ce9025'
);


-- None 목관 5중주 1번

UPDATE pieces piece
SET piece.title = '목관 5중주 1번', piece.title_en = 'Wind Quintet no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23747 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Agitato - Cantando', part.name_en = 'Wind Quintet no. 1: I. Agitato - Cantando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23747 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:63b291cc-a3c2-46e3-acdc-8071c3c32424' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63b291cc-a3c2-46e3-acdc-8071c3c32424', 1, 'I', 'Agitato - Cantando', 'Wind Quintet no. 1: I. Agitato - Cantando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23747 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63b291cc-a3c2-46e3-acdc-8071c3c32424'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace, leggiero - Allegro marcato', part.name_en = 'Wind Quintet no. 1: II. Vivace, leggiero - Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23747 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:0fcf7aab-f35d-41c2-a6f8-e5b1768f827f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcf7aab-f35d-41c2-a6f8-e5b1768f827f', 2, 'II', 'Vivace, leggiero - Allegro marcato', 'Wind Quintet no. 1: II. Vivace, leggiero - Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23747 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcf7aab-f35d-41c2-a6f8-e5b1768f827f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marziale, pesante - Furioso - Tempo I', part.name_en = 'Wind Quintet no. 1: III. Marziale, pesante - Furioso - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23747 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:5503a9a5-69ec-4978-8e35-aa146c3f4647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5503a9a5-69ec-4978-8e35-aa146c3f4647', 3, 'III', 'Marziale, pesante - Furioso - Tempo I', 'Wind Quintet no. 1: III. Marziale, pesante - Furioso - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23747 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5503a9a5-69ec-4978-8e35-aa146c3f4647'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante, con tristezza', part.name_en = 'Wind Quintet no. 1: IV. Andante, con tristezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23747 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:95250392-7296-4538-91c1-5691f8475e22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95250392-7296-4538-91c1-5691f8475e22', 4, 'IV', 'Andante, con tristezza', 'Wind Quintet no. 1: IV. Andante, con tristezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23747 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95250392-7296-4538-91c1-5691f8475e22'
);


-- None 목관 5중주 2번

UPDATE pieces piece
SET piece.title = '목관 5중주 2번', piece.title_en = 'Wind Quintet no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24308 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ruhig beginnend - Bewegter - Meno mosso', part.name_en = 'Wind Quintet no. 2: I. Ruhig beginnend - Bewegter - Meno mosso ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24308 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:d46aa6fe-846c-4ef8-af0c-88066f714756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d46aa6fe-846c-4ef8-af0c-88066f714756', 1, 'I', 'Ruhig beginnend - Bewegter - Meno mosso', 'Wind Quintet no. 2: I. Ruhig beginnend - Bewegter - Meno mosso ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24308 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d46aa6fe-846c-4ef8-af0c-88066f714756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Schnell, wild', part.name_en = 'Wind Quintet no. 2: II. Schnell, wild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24308 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:917b892f-e8cc-43c2-95ef-fad3b5229352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917b892f-e8cc-43c2-95ef-fad3b5229352', 2, 'II', 'Schnell, wild', 'Wind Quintet no. 2: II. Schnell, wild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24308 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917b892f-e8cc-43c2-95ef-fad3b5229352'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ruhig fließend', part.name_en = 'Wind Quintet no. 2: III. Ruhig fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24308 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:407d196b-edc1-4d8d-89c9-3703b7bda590' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:407d196b-edc1-4d8d-89c9-3703b7bda590', 3, 'III', 'Ruhig fließend', 'Wind Quintet no. 2: III. Ruhig fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24308 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:407d196b-edc1-4d8d-89c9-3703b7bda590'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lebhaft', part.name_en = 'Wind Quintet no. 2: IV. Lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24308 AND p.composer_id = 359 AND part.part_key = 'musicbrainz:4b1d10d8-7591-4a15-9564-4b63806fa370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b1d10d8-7591-4a15-9564-4b63806fa370', 4, 'IV', 'Lebhaft', 'Wind Quintet no. 2: IV. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24308 AND p.composer_id = 359
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b1d10d8-7591-4a15-9564-4b63806fa370'
);


-- None 첼로 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡 2번', 'Cello Concerto no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e1e142e-c70f-4aa1-a7aa-818f06092c69'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e1e142e-c70f-4aa1-a7aa-818f06092c69'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e1e142e-c70f-4aa1-a7aa-818f06092c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:236b81bd-c5a3-4ff4-85bb-7a2a8d706453', 1, 'I', 'Berceuse', 'Cello Concerto no. 2: I. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236b81bd-c5a3-4ff4-85bb-7a2a8d706453'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62314320-3df8-42ee-8f53-03efeed71f42', 2, 'II', 'Presto', 'Cello Concerto no. 2: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62314320-3df8-42ee-8f53-03efeed71f42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f375bdf-43f9-498b-ae0c-f03f491de380', 3, 'III', 'Adagio', 'Cello Concerto no. 2: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f375bdf-43f9-498b-ae0c-f03f491de380'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3710afb9-1941-4cab-988a-57d8e28a6476', 4, 'IV', 'Allegretto', 'Cello Concerto no. 2: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3710afb9-1941-4cab-988a-57d8e28a6476'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c469fd0-f1a3-4090-9d56-36b8aa5bc558', 5, 'V', 'Epilogue', 'Cello Concerto no. 2: V. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '첼로 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c469fd0-f1a3-4090-9d56-36b8aa5bc558'
);


-- None 클라리넷 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 협주곡', 'Clarinet Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '472e2d90-4763-4106-8384-666dc386ee4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '472e2d90-4763-4106-8384-666dc386ee4e'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '472e2d90-4763-4106-8384-666dc386ee4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25a1e0ed-af00-484d-a24c-6c29565a124a', 1, 'I', 'Tempestoso', 'Clarinet Concerto: I. Tempestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a1e0ed-af00-484d-a24c-6c29565a124a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed397d02-8b21-4282-aad4-bb79a3c22067', 2, 'II', 'Cadenza. Tranquillo', 'Clarinet Concerto: II. Cadenza. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed397d02-8b21-4282-aad4-bb79a3c22067'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7435b97b-0e14-4267-a238-adb78d3d79a5', 3, 'III', 'Vivace, con brio', 'Clarinet Concerto: III. Vivace, con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7435b97b-0e14-4267-a238-adb78d3d79a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f378b3ba-3eb7-4baa-82ea-6550fb6f9a70', 4, 'IV', 'Adagio, mesto', 'Clarinet Concerto: IV. Adagio, mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f378b3ba-3eb7-4baa-82ea-6550fb6f9a70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61d52d89-a66e-4f8f-9a77-6e06ea8741ad', 5, 'V', 'Epilogo. Misterioso', 'Clarinet Concerto: V. Epilogo. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61d52d89-a66e-4f8f-9a77-6e06ea8741ad'
);


-- None Epilogue

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Epilogue', 'Epilogue', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Epilogue'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f2b4e44-2060-409d-afa6-5ff074796c08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f2b4e44-2060-409d-afa6-5ff074796c08'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Epilogue' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f2b4e44-2060-409d-afa6-5ff074796c08'
);


-- None Hääsoitto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Hääsoitto', 'Hääsoitto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Hääsoitto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971153a8-fb65-4b2c-a248-bfc6fd8f434d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '971153a8-fb65-4b2c-a248-bfc6fd8f434d'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Hääsoitto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971153a8-fb65-4b2c-a248-bfc6fd8f434d'
);


-- None 피아노 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번', 'Piano Concerto no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c8c8294-ac25-4e45-86c7-41f4ff5ce652'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c8c8294-ac25-4e45-86c7-41f4ff5ce652'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c8c8294-ac25-4e45-86c7-41f4ff5ce652'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:234fd22a-bb9a-4728-b2c7-793e99c76a3d', 1, 'I', 'Allegro – Presto – Prestissimo – Meno mosso – Prestissimo', 'Piano Concerto no. 1: I. Allegro – Presto – Prestissimo – Meno mosso – Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:234fd22a-bb9a-4728-b2c7-793e99c76a3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a0f5f51-1f41-4809-9f69-92cb1f1343f9', 2, 'II', '♩ = 72', 'Piano Concerto no. 1: II. ♩ = 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a0f5f51-1f41-4809-9f69-92cb1f1343f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19a8314e-0121-4e1f-9c91-683563f87db5', 3, 'III', '♩ = 69 – Toccata. Allegro molto', 'Piano Concerto no. 1: III. ♩ = 69 – Toccata. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a8314e-0121-4e1f-9c91-683563f87db5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3ef9090-eae5-4fc5-9e92-9aae29bcb26e', 4, 'IV', '♩ = 54-58', 'Piano Concerto no. 1: IV. ♩ = 54-58', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ef9090-eae5-4fc5-9e92-9aae29bcb26e'
);


-- None 피아노 소나티네

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나티네', 'Sonatina for Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나티네'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76e76ec5-9106-4d66-a63b-41cad6fa3130'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76e76ec5-9106-4d66-a63b-41cad6fa3130'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76e76ec5-9106-4d66-a63b-41cad6fa3130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c32bc1b-ce87-45ca-96e4-a6f32609a7c1', 1, NULL, 'Toccata. Presto', 'Sonatina for Piano: 1. Toccata. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c32bc1b-ce87-45ca-96e4-a6f32609a7c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8188959b-0e07-4ad1-aed9-eee0b4f01dab', 2, NULL, 'Andante', 'Sonatina for Piano: 2. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8188959b-0e07-4ad1-aed9-eee0b4f01dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be14c331-5d7a-466a-ae9f-12dc836d0ab6', 3, NULL, 'Prestissimo', 'Sonatina for Piano: 3. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '피아노 소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be14c331-5d7a-466a-ae9f-12dc836d0ab6'
);


-- None 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f14ccbf-b5ae-4fb0-ac6b-0098b59af6c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f14ccbf-b5ae-4fb0-ac6b-0098b59af6c4'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f14ccbf-b5ae-4fb0-ac6b-0098b59af6c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9646f775-fe1e-489a-9cc4-ab4ff467a20d', 1, 'I', 'Moderato', 'String Quartet no. 1: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9646f775-fe1e-489a-9cc4-ab4ff467a20d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b769772-f8fd-46ad-abd1-1e0307f62700', 2, 'II', 'Andante – Vivace – Andante', 'String Quartet no. 1: II. Andante – Vivace – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b769772-f8fd-46ad-abd1-1e0307f62700'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc99bd6-bae2-44b9-bd61-11249c5b24a6', 3, 'III', 'Presto', 'String Quartet no. 1: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc99bd6-bae2-44b9-bd61-11249c5b24a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a855b258-5a5e-4739-a2a1-51edd28e60f5', 4, 'IV', 'Andante', 'String Quartet no. 1: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a855b258-5a5e-4739-a2a1-51edd28e60f5'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '405ca7f0-f4bc-4c04-bdf5-cb58443e4370'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '405ca7f0-f4bc-4c04-bdf5-cb58443e4370'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '405ca7f0-f4bc-4c04-bdf5-cb58443e4370'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53b2b64b-3097-4d1b-8009-7cf712a8fd82', 1, 'I', 'Adagio', 'String Quartet no. 2: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53b2b64b-3097-4d1b-8009-7cf712a8fd82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c031ea7-2ece-4f3c-981d-fdafd670d35a', 2, 'II', 'Presto', 'String Quartet no. 2: II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c031ea7-2ece-4f3c-981d-fdafd670d35a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b40f1a0-610c-4acf-a5f1-57f38f1beb55', 3, 'III', 'Adagio', 'String Quartet no. 2: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b40f1a0-610c-4acf-a5f1-57f38f1beb55'
);


-- None 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a1c6d94-7dc5-413d-8554-8e712f579bbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a1c6d94-7dc5-413d-8554-8e712f579bbc'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a1c6d94-7dc5-413d-8554-8e712f579bbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:131f1945-26e8-32b6-923e-6698cf630574', 1, 'I', 'Vivace', 'String Quartet no. 3: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131f1945-26e8-32b6-923e-6698cf630574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0272d75b-4726-3da7-b972-16d8fde6ee1c', 2, 'II', 'Andante', 'String Quartet no. 3: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0272d75b-4726-3da7-b972-16d8fde6ee1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05a63492-5317-37e0-b558-af2ec90215df', 3, 'III', 'Presto', 'String Quartet no. 3: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05a63492-5317-37e0-b558-af2ec90215df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:771202a3-43a3-3b38-9f54-49e766e3f142', 4, 'IV', 'Allegro non troppo', 'String Quartet no. 3: IV. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:771202a3-43a3-3b38-9f54-49e766e3f142'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b38aadc-ae53-3406-af2f-559523b2a2c5', 5, 'V', 'Presto', 'String Quartet no. 3: V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b38aadc-ae53-3406-af2f-559523b2a2c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7042383-87e6-316e-9b9c-a87249ee4560', 6, 'VI', 'Meno mosso', 'String Quartet no. 3: VI. Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7042383-87e6-316e-9b9c-a87249ee4560'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93f1eaac-00aa-3cd3-b7da-87128cc68fa3', 7, 'VII', 'Adagio', 'String Quartet no. 3: VII. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93f1eaac-00aa-3cd3-b7da-87128cc68fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d05d224-0f6c-3015-b52d-31902f418451', 8, 'VIII', 'Allegretto', 'String Quartet no. 3: VIII. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d05d224-0f6c-3015-b52d-31902f418451'
);


-- None Symphonic Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Symphonic Dances', 'Symphonic Dances', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Symphonic Dances'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86f8ee67-a688-4164-ba25-8fbfcc378874'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86f8ee67-a688-4164-ba25-8fbfcc378874'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86f8ee67-a688-4164-ba25-8fbfcc378874'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d2d109-3f82-3240-bc8a-270632553507', 1, 'I', 'Prelude', 'Symphonic Dances. Hommage à Uuno Klami: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d2d109-3f82-3240-bc8a-270632553507'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60074411-7e30-3790-bbe2-d2cde8156f4d', 2, 'II', 'Return of the Flames and Dance', 'Symphonic Dances. Hommage à Uuno Klami: II. Return of the Flames and Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60074411-7e30-3790-bbe2-d2cde8156f4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8c4bb5-67dc-3d1c-b804-4c429e43c426', 3, 'III', 'Grotesque Dance', 'Symphonic Dances. Hommage à Uuno Klami: III. Grotesque Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8c4bb5-67dc-3d1c-b804-4c429e43c426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:154ac75b-ae20-318c-b1c9-7c08cedfeaed', 4, 'IV', 'Dance of the Winds and Fires', 'Symphonic Dances. Hommage à Uuno Klami: IV. Dance of the Winds and Fires', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:154ac75b-ae20-318c-b1c9-7c08cedfeaed'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79364870-9ece-48e7-8506-23ae369beb2d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79364870-9ece-48e7-8506-23ae369beb2d'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79364870-9ece-48e7-8506-23ae369beb2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2786a0e4-20d6-4016-b116-381eecbdca3c', 1, 'I', 'Andante', 'Symphony no. 1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2786a0e4-20d6-4016-b116-381eecbdca3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:210a3ff6-fa39-40a6-93f4-d06b6ca55920', 2, 'II', 'Allegretto', 'Symphony no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:210a3ff6-fa39-40a6-93f4-d06b6ca55920'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0dbb2f4-e918-400f-b3a7-1ea0d2a74d59', 3, 'III', 'Presto', 'Symphony no. 1: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0dbb2f4-e918-400f-b3a7-1ea0d2a74d59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18e82978-5baa-4695-ae4c-18622f213319', 4, 'IV', 'Andante - Allegro non troppo', 'Symphony no. 1: IV. Andante - Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e82978-5baa-4695-ae4c-18622f213319'
);


-- None 교향곡 10번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 10번', 'Symphony no. 10', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 10번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08269d24-34d1-4c6a-b89a-8203682be504'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08269d24-34d1-4c6a-b89a-8203682be504'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 10번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08269d24-34d1-4c6a-b89a-8203682be504'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60bccf85-f33d-3509-a25f-8fc83d775579', 1, 'I', 'Allegro', 'Symphony no. 10: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 10번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60bccf85-f33d-3509-a25f-8fc83d775579'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a123865c-fd2a-3305-8063-5b40799b0446', 2, 'II', 'Prestissimo', 'Symphony no. 10: II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 10번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a123865c-fd2a-3305-8063-5b40799b0446'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aecfbf2-c973-34eb-875a-6a5bdd48a130', 3, 'III', 'Adagio', 'Symphony no. 10: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 10번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aecfbf2-c973-34eb-875a-6a5bdd48a130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b398abd1-a858-310b-a9f2-d00a0e2073f7', 4, 'IV', 'Vivacissimo', 'Symphony no. 10: IV. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 10번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b398abd1-a858-310b-a9f2-d00a0e2073f7'
);


-- None 교향곡 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번', 'Symphony no. 4', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0db70874-fbb0-4b51-ab2b-90db92a04a79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0db70874-fbb0-4b51-ab2b-90db92a04a79'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0db70874-fbb0-4b51-ab2b-90db92a04a79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7285fc95-f494-4541-940d-b243499570b1', 1, 'I', 'Adagio', 'Symphony no. 4: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7285fc95-f494-4541-940d-b243499570b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c1c5679-33c6-4e5c-89ca-1b9d126053d7', 2, 'II', 'Allegro - Presto', 'Symphony no. 4: II. Allegro - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c1c5679-33c6-4e5c-89ca-1b9d126053d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c717ce21-b2bc-447b-af3d-2dbdcd91e73e', 3, 'III', 'Lento', 'Symphony no. 4: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c717ce21-b2bc-447b-af3d-2dbdcd91e73e'
);


-- None 교향곡 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번', 'Symphony no. 5', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e1f47a4-ed81-3f25-a35b-572b019ebf1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e1f47a4-ed81-3f25-a35b-572b019ebf1c'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e1f47a4-ed81-3f25-a35b-572b019ebf1c'
);


-- None 교향곡 8번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번', 'Symphony no. 8', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20fbd033-9fa8-4631-9c5d-de47bdb3dd80'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20fbd033-9fa8-4631-9c5d-de47bdb3dd80'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20fbd033-9fa8-4631-9c5d-de47bdb3dd80'
);


-- None 교향곡 9번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 9번', 'Symphony no. 9', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 9번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b4b2df8-f87e-4838-80e1-bac6d20b5d0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b4b2df8-f87e-4838-80e1-bac6d20b5d0b'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b4b2df8-f87e-4838-80e1-bac6d20b5d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac0af6fc-25fc-4eb6-8ddb-c6d8f3d952b0', 1, 'I', 'Andante', 'Symphony no. 9: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac0af6fc-25fc-4eb6-8ddb-c6d8f3d952b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04a12d9b-13ad-424a-9b16-d55a78c38882', 2, 'II', 'Adagio', 'Symphony no. 9: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a12d9b-13ad-424a-9b16-d55a78c38882'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d084e825-da2d-4623-943a-b273813c2511', 3, 'III', 'Presto', 'Symphony no. 9: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d084e825-da2d-4623-943a-b273813c2511'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fab259fc-62b3-4dc3-8697-ed626135bb5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fab259fc-62b3-4dc3-8697-ed626135bb5e'
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fab259fc-62b3-4dc3-8697-ed626135bb5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0c4eb2b-f0cf-4c3f-a858-1bb24867b83f', 1, 'I', 'Andante', 'Violin Concerto: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0c4eb2b-f0cf-4c3f-a858-1bb24867b83f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efb43792-46b4-497c-9a39-97533fe89823', 2, 'II', 'Leggiero', 'Violin Concerto: II. Leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efb43792-46b4-497c-9a39-97533fe89823'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2495928c-a098-44d3-92a7-a7b340686293', 3, 'III', 'Tempo di valse', 'Violin Concerto: III. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2495928c-a098-44d3-92a7-a7b340686293'
);


-- 카탈로그에 대응이 없는 seed 작품 8개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 359 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23240, 23281, 23569, 23675, 23732, 24155, 25278, 25307
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
