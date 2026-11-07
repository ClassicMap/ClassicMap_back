-- Henri Tomasi 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 37개(묶음 4, 다악장 17, 낱곡 16),
-- 새 작품 4개, part 77개, 그 아래 0개.
-- seed 34개 중 33개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None 발라드

UPDATE pieces piece
SET piece.title = '발라드', piece.title_en = 'Ballade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25563 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant corse

UPDATE pieces piece
SET piece.title = 'Chant corse', piece.title_en = 'Chant corse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23210 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chant hébraïque

UPDATE pieces piece
SET piece.title = 'Chant hébraïque', piece.title_en = 'Chant hébraïque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25635 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chants corses>

UPDATE pieces piece
SET piece.title = '가곡 <Chants corses>', piece.title_en = 'Chants corses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25118 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lamentu d’u trenu', part.name_en = 'Lamentu d’u trenu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25118 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:4c004ea1-892e-4bd9-ac21-557a45ded835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c004ea1-892e-4bd9-ac21-557a45ded835', 1, NULL, 'Lamentu d’u trenu', 'Lamentu d’u trenu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25118 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c004ea1-892e-4bd9-ac21-557a45ded835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sérénade complainte', part.name_en = 'Sérénade complainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25118 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:c1361ca7-88e6-4660-a908-873418582d34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1361ca7-88e6-4660-a908-873418582d34', 2, NULL, 'Sérénade complainte', 'Sérénade complainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25118 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1361ca7-88e6-4660-a908-873418582d34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nanna', part.name_en = 'Nanna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25118 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:688e540a-83c4-4692-96e6-7711c9f60278' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:688e540a-83c4-4692-96e6-7711c9f60278', 3, NULL, 'Nanna', 'Nanna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25118 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:688e540a-83c4-4692-96e6-7711c9f60278'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'U Meru pastore', part.name_en = 'U Meru pastore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25118 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:d59d3045-a49c-499c-b573-c3b4418a3878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d59d3045-a49c-499c-b573-c3b4418a3878', 4, NULL, 'U Meru pastore', 'U Meru pastore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25118 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59d3045-a49c-499c-b573-c3b4418a3878'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cantu di Malincunia', part.name_en = 'Cantu di Malincunia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25118 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:45d33d6e-69ad-4c6c-8d4c-120ff982cc3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d33d6e-69ad-4c6c-8d4c-120ff982cc3b', 5, NULL, 'Cantu di Malincunia', 'Cantu di Malincunia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25118 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d33d6e-69ad-4c6c-8d4c-120ff982cc3b'
);


-- None Cinq danses profanes et sacrées pour quintette á vent

UPDATE pieces piece
SET piece.title = 'Cinq danses profanes et sacrées pour quintette á vent', piece.title_en = 'Cinq danses profanes et sacrées pour quintette á vent',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24275 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Danse agreste. Allegretto', part.name_en = 'Cinq danses profanes et sacrées pour quintette á vent: No. 1. Danse agreste. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24275 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:2386cf59-b05a-4851-9259-23be54143e15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2386cf59-b05a-4851-9259-23be54143e15', 1, NULL, 'Danse agreste. Allegretto', 'Cinq danses profanes et sacrées pour quintette á vent: No. 1. Danse agreste. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24275 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2386cf59-b05a-4851-9259-23be54143e15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Danse profane. Scherzando', part.name_en = 'Cinq danses profanes et sacrées pour quintette á vent: No. 2. Danse profane. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24275 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:6cca2355-e925-4e63-82c2-94338ef3e928' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cca2355-e925-4e63-82c2-94338ef3e928', 2, NULL, 'Danse profane. Scherzando', 'Cinq danses profanes et sacrées pour quintette á vent: No. 2. Danse profane. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24275 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cca2355-e925-4e63-82c2-94338ef3e928'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Danse sacrée. Lent', part.name_en = 'Cinq danses profanes et sacrées pour quintette á vent: No. 3. Danse sacrée. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24275 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:e45f21cd-c849-4abc-b436-86d421dcee30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e45f21cd-c849-4abc-b436-86d421dcee30', 3, NULL, 'Danse sacrée. Lent', 'Cinq danses profanes et sacrées pour quintette á vent: No. 3. Danse sacrée. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24275 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e45f21cd-c849-4abc-b436-86d421dcee30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danse nuptiale. Scherzando', part.name_en = 'Cinq danses profanes et sacrées pour quintette á vent: No. 4. Danse nuptiale. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24275 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:7df87a60-9093-42ae-a42e-3251d1f71401' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df87a60-9093-42ae-a42e-3251d1f71401', 4, NULL, 'Danse nuptiale. Scherzando', 'Cinq danses profanes et sacrées pour quintette á vent: No. 4. Danse nuptiale. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24275 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df87a60-9093-42ae-a42e-3251d1f71401'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Danse guerrière. Sauvagement frénétique', part.name_en = 'Cinq danses profanes et sacrées pour quintette á vent: No. 5. Danse guerrière. Sauvagement frénétique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24275 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:d74a5d3e-f767-44a7-99a3-9ae16ad7171e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d74a5d3e-f767-44a7-99a3-9ae16ad7171e', 5, NULL, 'Danse guerrière. Sauvagement frénétique', 'Cinq danses profanes et sacrées pour quintette á vent: No. 5. Danse guerrière. Sauvagement frénétique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24275 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d74a5d3e-f767-44a7-99a3-9ae16ad7171e'
);


-- None Concert champêtre

UPDATE pieces piece
SET piece.title = 'Concert champêtre', piece.title_en = 'Concert champêtre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24730 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture (Allegro giocoso)', part.name_en = 'Concert champêtre: I. Ouverture (Allegro giocoso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24730 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:2b45df39-d199-411a-b931-4771c859b8c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b45df39-d199-411a-b931-4771c859b8c7', 1, 'I', 'Ouverture (Allegro giocoso)', 'Concert champêtre: I. Ouverture (Allegro giocoso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24730 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b45df39-d199-411a-b931-4771c859b8c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minuetto', part.name_en = 'Concert champêtre: II. Minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24730 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:b48e9f3d-0732-4f6c-adb4-88b7f262f504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b48e9f3d-0732-4f6c-adb4-88b7f262f504', 2, 'II', 'Minuetto', 'Concert champêtre: II. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24730 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b48e9f3d-0732-4f6c-adb4-88b7f262f504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bourée (Décidé)', part.name_en = 'Concert champêtre: III. Bourée (Décidé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24730 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:3ba061f1-5c22-4dc0-a748-aa76a82aef7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba061f1-5c22-4dc0-a748-aa76a82aef7a', 3, 'III', 'Bourée (Décidé)', 'Concert champêtre: III. Bourée (Décidé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24730 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba061f1-5c22-4dc0-a748-aa76a82aef7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Nocturne (Andante)', part.name_en = 'Concert champêtre: IV. Nocturne (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24730 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:558baddb-0d49-4bde-b7c1-da2d41c1dbb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:558baddb-0d49-4bde-b7c1-da2d41c1dbb9', 4, 'IV', 'Nocturne (Andante)', 'Concert champêtre: IV. Nocturne (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24730 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558baddb-0d49-4bde-b7c1-da2d41c1dbb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tambourin (Vif)', part.name_en = 'Concert champêtre: V. Tambourin (Vif)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24730 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:22db366a-57bb-4156-b4f9-78e5128ba9e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22db366a-57bb-4156-b4f9-78e5128ba9e5', 5, 'V', 'Tambourin (Vif)', 'Concert champêtre: V. Tambourin (Vif)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24730 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22db366a-57bb-4156-b4f9-78e5128ba9e5'
);


-- None Concerto for Alto Saxophone and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Alto Saxophone and Orchestra', piece.title_en = 'Concerto for Alto Saxophone and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25441 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Allegro', part.name_en = 'Concerto for Alto Saxophone and Orchestra: I. Andante - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25441 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:f293ac4a-7c40-446a-a640-bced5eeab606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f293ac4a-7c40-446a-a640-bced5eeab606', 1, 'I', 'Andante - Allegro', 'Concerto for Alto Saxophone and Orchestra: I. Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25441 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f293ac4a-7c40-446a-a640-bced5eeab606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Giration. Allegro', part.name_en = 'Concerto for Alto Saxophone and Orchestra: II. Giration. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25441 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:555e5b4d-9968-4036-ba75-0b8ef2ac1880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:555e5b4d-9968-4036-ba75-0b8ef2ac1880', 2, 'II', 'Giration. Allegro', 'Concerto for Alto Saxophone and Orchestra: II. Giration. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25441 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:555e5b4d-9968-4036-ba75-0b8ef2ac1880'
);


-- None Concerto pour basson et orchestre de chambre

UPDATE pieces piece
SET piece.title = 'Concerto pour basson et orchestre de chambre', piece.title_en = 'Concerto pour basson et orchestre de chambre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23828 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante et Allegro', part.name_en = 'Concerto pour basson et orchestre de chambre: I. Andante et Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23828 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:69c178b9-cd6d-480a-a039-9584e1e3feb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69c178b9-cd6d-480a-a039-9584e1e3feb2', 1, 'I', 'Andante et Allegro', 'Concerto pour basson et orchestre de chambre: I. Andante et Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23828 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c178b9-cd6d-480a-a039-9584e1e3feb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sérénade nocturne', part.name_en = 'Concerto pour basson et orchestre de chambre: II. Sérénade nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23828 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:86cc2625-5917-417b-88b8-aa9b361e67a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86cc2625-5917-417b-88b8-aa9b361e67a1', 2, 'II', 'Sérénade nocturne', 'Concerto pour basson et orchestre de chambre: II. Sérénade nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23828 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86cc2625-5917-417b-88b8-aa9b361e67a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final – Saltarelle', part.name_en = 'Concerto pour basson et orchestre de chambre: III. Final – Saltarelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23828 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:408b6e30-4460-45d3-8ea9-3060a4487132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:408b6e30-4460-45d3-8ea9-3060a4487132', 3, 'III', 'Final – Saltarelle', 'Concerto pour basson et orchestre de chambre: III. Final – Saltarelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23828 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:408b6e30-4460-45d3-8ea9-3060a4487132'
);


-- None Concerto pour clarinette et orchestre à cordes

UPDATE pieces piece
SET piece.title = 'Concerto pour clarinette et orchestre à cordes', piece.title_en = 'Concerto pour clarinette et orchestre à cordes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24678 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giocoso', part.name_en = 'Concerto pour clarinette et orchestre à cordes: I. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24678 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:2839ea81-988f-4984-9a03-ba0a18df63a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2839ea81-988f-4984-9a03-ba0a18df63a6', 1, 'I', 'Allegro giocoso', 'Concerto pour clarinette et orchestre à cordes: I. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24678 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2839ea81-988f-4984-9a03-ba0a18df63a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Concerto pour clarinette et orchestre à cordes: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24678 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:b9721bfe-abbe-4dab-8b3b-66c91ecfddc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9721bfe-abbe-4dab-8b3b-66c91ecfddc9', 2, 'II', 'Nocturne', 'Concerto pour clarinette et orchestre à cordes: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24678 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9721bfe-abbe-4dab-8b3b-66c91ecfddc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo final', part.name_en = 'Concerto pour clarinette et orchestre à cordes: III. Scherzo final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24678 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:e4c79d3f-8ca8-495e-8b47-54e45c0023c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c79d3f-8ca8-495e-8b47-54e45c0023c9', 3, 'III', 'Scherzo final', 'Concerto pour clarinette et orchestre à cordes: III. Scherzo final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24678 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c79d3f-8ca8-495e-8b47-54e45c0023c9'
);


-- None Concerto pour hautbois et orchestre de chambre

UPDATE pieces piece
SET piece.title = 'Concerto pour hautbois et orchestre de chambre', piece.title_en = 'Concerto pour hautbois et orchestre de chambre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24281 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto pour trombone et orchestre

UPDATE pieces piece
SET piece.title = 'Concerto pour trombone et orchestre', piece.title_en = 'Concerto pour trombone et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25085 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante et Scherzo', part.name_en = 'Concerto pour trombone et orchestre: 1. Andante et Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25085 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:ddd0693e-0b62-49cb-a0f1-43b9323457ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddd0693e-0b62-49cb-a0f1-43b9323457ba', 1, NULL, 'Andante et Scherzo', 'Concerto pour trombone et orchestre: 1. Andante et Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25085 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd0693e-0b62-49cb-a0f1-43b9323457ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tempo di valse', part.name_en = 'Concerto pour trombone et orchestre: 2. Tempo di valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25085 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:30249526-8c98-4a13-a114-06a335578c17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30249526-8c98-4a13-a114-06a335578c17', 2, NULL, 'Tempo di valse', 'Concerto pour trombone et orchestre: 2. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25085 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30249526-8c98-4a13-a114-06a335578c17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nocturne. Andante', part.name_en = 'Concerto pour trombone et orchestre: 3. Nocturne. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25085 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:bf9feabe-b388-4545-88a1-d9795673dbb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf9feabe-b388-4545-88a1-d9795673dbb5', 3, NULL, 'Nocturne. Andante', 'Concerto pour trombone et orchestre: 3. Nocturne. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25085 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf9feabe-b388-4545-88a1-d9795673dbb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tambourin. Allegro giocoso', part.name_en = 'Concerto pour trombone et orchestre: 4. Tambourin. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25085 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:617609b5-7822-4098-9719-afb757ac9b6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:617609b5-7822-4098-9719-afb757ac9b6a', 4, NULL, 'Tambourin. Allegro giocoso', 'Concerto pour trombone et orchestre: 4. Tambourin. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25085 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617609b5-7822-4098-9719-afb757ac9b6a'
);


-- None Divertimento Corsica

UPDATE pieces piece
SET piece.title = 'Divertimento Corsica', piece.title_en = 'Divertimento Corsica',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23659 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Paghiella', part.name_en = 'Divertimento Corsica: I. Paghiella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23659 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:ce89c070-e226-4054-b506-2f8250883c44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce89c070-e226-4054-b506-2f8250883c44', 1, 'I', 'Paghiella', 'Divertimento Corsica: I. Paghiella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23659 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce89c070-e226-4054-b506-2f8250883c44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cimetière marin', part.name_en = 'Divertimento Corsica: II. Cimetière marin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23659 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:50332688-34b0-4895-abcb-6c7321a874c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50332688-34b0-4895-abcb-6c7321a874c6', 2, 'II', 'Cimetière marin', 'Divertimento Corsica: II. Cimetière marin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23659 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50332688-34b0-4895-abcb-6c7321a874c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse-Sérénade', part.name_en = 'Divertimento Corsica: III. Danse-Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23659 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:c8bb199f-83e4-4079-af64-e765bfde85dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8bb199f-83e4-4079-af64-e765bfde85dd', 3, 'III', 'Danse-Sérénade', 'Divertimento Corsica: III. Danse-Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23659 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8bb199f-83e4-4079-af64-e765bfde85dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Foire du Niolo', part.name_en = 'Divertimento Corsica: IV. La Foire du Niolo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23659 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:bbdf8501-b419-4a16-97b2-359b31fc3910' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbdf8501-b419-4a16-97b2-359b31fc3910', 4, 'IV', 'La Foire du Niolo', 'Divertimento Corsica: IV. La Foire du Niolo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23659 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbdf8501-b419-4a16-97b2-359b31fc3910'
);


-- None Divertissement Pastoral

UPDATE pieces piece
SET piece.title = 'Divertissement Pastoral', piece.title_en = 'Divertissement Pastoral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25870 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Douze Noëls de Saboly

UPDATE pieces piece
SET piece.title = 'Douze Noëls de Saboly', piece.title_en = 'Douze Noëls de Saboly',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24307 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfares liturgiques

UPDATE pieces piece
SET piece.title = 'Fanfares liturgiques', piece.title_en = 'Fanfares liturgiques',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24607 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Annonciation', part.name_en = 'Fanfares liturgiques: I. Annonciation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24607 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:1ee8df26-29fe-4f65-af7f-e079b37a0eb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ee8df26-29fe-4f65-af7f-e079b37a0eb0', 1, 'I', 'Annonciation', 'Fanfares liturgiques: I. Annonciation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24607 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee8df26-29fe-4f65-af7f-e079b37a0eb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Evangile', part.name_en = 'Fanfares liturgiques: II. Evangile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24607 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:34602a19-a7f2-458c-969f-882a9c2c1409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34602a19-a7f2-458c-969f-882a9c2c1409', 2, 'II', 'Evangile', 'Fanfares liturgiques: II. Evangile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24607 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34602a19-a7f2-458c-969f-882a9c2c1409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Apocalypse', part.name_en = 'Fanfares liturgiques: III. Apocalypse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24607 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:ffce3ed8-c615-4a5f-a72c-abf88d4fb917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffce3ed8-c615-4a5f-a72c-abf88d4fb917', 3, 'III', 'Apocalypse', 'Fanfares liturgiques: III. Apocalypse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24607 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffce3ed8-c615-4a5f-a72c-abf88d4fb917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Procession du Vendredi-Saint', part.name_en = 'Fanfares liturgiques: IV. Procession du Vendredi-Saint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24607 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:01398771-6335-43c7-9e3a-84f843101360' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01398771-6335-43c7-9e3a-84f843101360', 4, 'IV', 'Procession du Vendredi-Saint', 'Fanfares liturgiques: IV. Procession du Vendredi-Saint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24607 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01398771-6335-43c7-9e3a-84f843101360'
);


-- None Le tombeau de Mireille: I. Introduction et variations

UPDATE pieces piece
SET piece.title = 'Le tombeau de Mireille: I. Introduction et variations', piece.title_en = 'Le tombeau de Mireille: I. Introduction et variations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23297 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Tombeau de Mireille', part.name_en = 'Le Tombeau de Mireille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23297 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5', 1, NULL, 'Le Tombeau de Mireille', 'Le Tombeau de Mireille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23297 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5'
);


-- None Le tombeau de Mireille: II. Romance

UPDATE pieces piece
SET piece.title = 'Le tombeau de Mireille: II. Romance', piece.title_en = 'Le tombeau de Mireille: II. Romance',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25438 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Tombeau de Mireille', part.name_en = 'Le Tombeau de Mireille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25438 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5', 1, NULL, 'Le Tombeau de Mireille', 'Le Tombeau de Mireille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25438 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5'
);


-- None Le tombeau de Mireille: III. Farandole

UPDATE pieces piece
SET piece.title = 'Le tombeau de Mireille: III. Farandole', piece.title_en = 'Le tombeau de Mireille: III. Farandole',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24432 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Tombeau de Mireille', part.name_en = 'Le Tombeau de Mireille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24432 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5', 1, NULL, 'Le Tombeau de Mireille', 'Le Tombeau de Mireille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24432 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a785b1b-6f35-4e13-b736-d3d2711c6ff5'
);


-- None 발레 <Noces de cendres>

UPDATE pieces piece
SET piece.title = '발레 <Noces de cendres>', piece.title_en = 'Noces de cendres',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25990 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paghiella, Sérénade cyrnéenne

UPDATE pieces piece
SET piece.title = 'Paghiella, Sérénade cyrnéenne', piece.title_en = 'Paghiella, Sérénade cyrnéenne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24734 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Poème for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Poème for Violin and Piano', piece.title_en = 'Poème for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24599 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Requiem pour la paix

UPDATE pieces piece
SET piece.title = 'Requiem pour la paix', piece.title_en = 'Requiem pour la paix',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23284 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Requiem', part.name_en = 'Requiem pour la paix: Requiem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:de441823-0089-4e9d-924d-86c4a86ff1fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de441823-0089-4e9d-924d-86c4a86ff1fe', 1, NULL, 'Requiem', 'Requiem pour la paix: Requiem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de441823-0089-4e9d-924d-86c4a86ff1fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Absolve', part.name_en = 'Requiem pour la paix: Absolve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:c986681f-b665-4626-a196-2398712e50e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c986681f-b665-4626-a196-2398712e50e0', 2, NULL, 'Absolve', 'Requiem pour la paix: Absolve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c986681f-b665-4626-a196-2398712e50e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dies irae', part.name_en = 'Requiem pour la paix: Dies irae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:556c80ac-1e98-4687-83dc-18356fefad38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:556c80ac-1e98-4687-83dc-18356fefad38', 3, NULL, 'Dies irae', 'Requiem pour la paix: Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:556c80ac-1e98-4687-83dc-18356fefad38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Recordare', part.name_en = 'Requiem pour la paix: Recordare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:0ee40bf4-ef6e-400c-802f-7abbf948dae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee40bf4-ef6e-400c-802f-7abbf948dae5', 4, NULL, 'Recordare', 'Requiem pour la paix: Recordare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee40bf4-ef6e-400c-802f-7abbf948dae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ingemisco', part.name_en = 'Requiem pour la paix: Ingemisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:ff9abc6b-2461-4d8b-bd69-8c605c15a74b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff9abc6b-2461-4d8b-bd69-8c605c15a74b', 5, NULL, 'Ingemisco', 'Requiem pour la paix: Ingemisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff9abc6b-2461-4d8b-bd69-8c605c15a74b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Domine', part.name_en = 'Requiem pour la paix: Domine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:98cdca6b-9f7c-4be8-86e5-2e52b72f242c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cdca6b-9f7c-4be8-86e5-2e52b72f242c', 6, NULL, 'Domine', 'Requiem pour la paix: Domine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cdca6b-9f7c-4be8-86e5-2e52b72f242c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Requiem pour la paix: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:0008eb4b-dbd3-4675-aa90-439528bfae0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0008eb4b-dbd3-4675-aa90-439528bfae0b', 7, NULL, 'Sanctus', 'Requiem pour la paix: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0008eb4b-dbd3-4675-aa90-439528bfae0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Requiem pour la paix: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:a466cc8c-5e41-45f1-bd0d-c2cba9a27935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a466cc8c-5e41-45f1-bd0d-c2cba9a27935', 8, NULL, 'Agnus Dei', 'Requiem pour la paix: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a466cc8c-5e41-45f1-bd0d-c2cba9a27935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Lux aeterna', part.name_en = 'Requiem pour la paix: Lux aeterna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:66ba8765-0160-4a6d-a949-874c046b523c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ba8765-0160-4a6d-a949-874c046b523c', 9, NULL, 'Lux aeterna', 'Requiem pour la paix: Lux aeterna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ba8765-0160-4a6d-a949-874c046b523c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Libera me', part.name_en = 'Requiem pour la paix: Libera me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23284 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:8c1829bb-ac48-4b90-97fa-6d1b4d0c4706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c1829bb-ac48-4b90-97fa-6d1b4d0c4706', 10, NULL, 'Libera me', 'Requiem pour la paix: Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23284 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1829bb-ac48-4b90-97fa-6d1b4d0c4706'
);


-- None Suite pour 3 trompettes

UPDATE pieces piece
SET piece.title = 'Suite pour 3 trompettes', piece.title_en = 'Suite pour 3 trompettes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24586 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Havanaise', part.name_en = 'Suite pour 3 trompettes: I. Havanaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24586 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:92e66ca3-ccaf-47bf-beb0-6e015d640536' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e66ca3-ccaf-47bf-beb0-6e015d640536', 1, 'I', 'Havanaise', 'Suite pour 3 trompettes: I. Havanaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24586 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e66ca3-ccaf-47bf-beb0-6e015d640536'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento égéen', part.name_en = 'Suite pour 3 trompettes: II. Lento égéen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24586 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:9389f086-8bfc-429c-be74-6a702c3f38dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9389f086-8bfc-429c-be74-6a702c3f38dc', 2, 'II', 'Lento égéen', 'Suite pour 3 trompettes: II. Lento égéen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24586 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9389f086-8bfc-429c-be74-6a702c3f38dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse bolivienne', part.name_en = 'Suite pour 3 trompettes: III. Danse bolivienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24586 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:88bc60bd-f598-47aa-9229-ecc3f2099b8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88bc60bd-f598-47aa-9229-ecc3f2099b8b', 3, 'III', 'Danse bolivienne', 'Suite pour 3 trompettes: III. Danse bolivienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24586 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88bc60bd-f598-47aa-9229-ecc3f2099b8b'
);


-- None Thème et variations

UPDATE pieces piece
SET piece.title = 'Thème et variations', piece.title_en = 'Thème et variations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25061 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio à cordes en forme de divertissement

UPDATE pieces piece
SET piece.title = 'Trio à cordes en forme de divertissement', piece.title_en = 'Trio à cordes en forme de divertissement',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23469 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Trio à cordes en forme de divertissement: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23469 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:6ca4f610-1a5b-4b13-bbe8-2d6d46a02c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ca4f610-1a5b-4b13-bbe8-2d6d46a02c4d', 1, 'I', 'Prélude', 'Trio à cordes en forme de divertissement: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23469 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ca4f610-1a5b-4b13-bbe8-2d6d46a02c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Trio à cordes en forme de divertissement: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23469 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:efd33d6e-0052-4994-b4ad-16853e009553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efd33d6e-0052-4994-b4ad-16853e009553', 2, 'II', 'Nocturne', 'Trio à cordes en forme de divertissement: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23469 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efd33d6e-0052-4994-b4ad-16853e009553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Trio à cordes en forme de divertissement: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23469 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:a443a975-2f14-4e59-a242-b73c041104ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a443a975-2f14-4e59-a242-b73c041104ba', 3, 'III', 'Scherzo', 'Trio à cordes en forme de divertissement: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23469 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a443a975-2f14-4e59-a242-b73c041104ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final', part.name_en = 'Trio à cordes en forme de divertissement: IV. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23469 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:1078c3f4-3e42-4c3c-8411-ef0157f15383' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1078c3f4-3e42-4c3c-8411-ef0157f15383', 4, 'IV', 'Final', 'Trio à cordes en forme de divertissement: IV. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23469 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1078c3f4-3e42-4c3c-8411-ef0157f15383'
);


-- None Triptyque

UPDATE pieces piece
SET piece.title = 'Triptyque', piece.title_en = 'Triptyque',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25898 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Scherzo', part.name_en = 'Triptyque: I. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25898 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:548794cc-6af9-414a-803f-c12f28d4112a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:548794cc-6af9-414a-803f-c12f28d4112a', 1, 'I', 'Scherzo', 'Triptyque: I. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25898 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:548794cc-6af9-414a-803f-c12f28d4112a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Triptyque: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25898 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:b8714c97-1944-4f71-856d-85aede0e1a28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8714c97-1944-4f71-856d-85aede0e1a28', 2, 'II', 'Largo', 'Triptyque: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25898 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8714c97-1944-4f71-856d-85aede0e1a28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Saltarelle', part.name_en = 'Triptyque: III. Saltarelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25898 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:19c8a2e9-af81-4ec1-9210-ac2a90f5b226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19c8a2e9-af81-4ec1-9210-ac2a90f5b226', 3, 'III', 'Saltarelle', 'Triptyque: III. Saltarelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25898 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19c8a2e9-af81-4ec1-9210-ac2a90f5b226'
);


-- None Tristesse d’Antar

UPDATE pieces piece
SET piece.title = 'Tristesse d’Antar', piece.title_en = 'Tristesse d’Antar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24148 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trois Divertissements

UPDATE pieces piece
SET piece.title = 'Trois Divertissements', piece.title_en = 'Trois Divertissements',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24226 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poursuites', part.name_en = 'Trois Divertissements: I. Poursuites',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24226 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:285fced5-d39d-4b0f-8e4f-50d74b99f7e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:285fced5-d39d-4b0f-8e4f-50d74b99f7e9', 1, 'I', 'Poursuites', 'Trois Divertissements: I. Poursuites', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24226 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:285fced5-d39d-4b0f-8e4f-50d74b99f7e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mascarade', part.name_en = 'Trois Divertissements: II. Mascarade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24226 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:20cde838-79b7-4963-9ec5-c1dde3f84e97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20cde838-79b7-4963-9ec5-c1dde3f84e97', 2, 'II', 'Mascarade', 'Trois Divertissements: II. Mascarade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24226 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20cde838-79b7-4963-9ec5-c1dde3f84e97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondes', part.name_en = 'Trois Divertissements: III. Rondes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24226 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:96d134a1-0516-403c-ae1e-e026850944c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d134a1-0516-403c-ae1e-e026850944c4', 3, 'III', 'Rondes', 'Trois Divertissements: III. Rondes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24226 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d134a1-0516-403c-ae1e-e026850944c4'
);


-- None 트럼펫 협주곡

UPDATE pieces piece
SET piece.title = '트럼펫 협주곡', piece.title_en = 'Trumpet Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24296 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro / Cadenza', part.name_en = 'Trumpet Concerto: I. Allegro / Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24296 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:07756094-c5d1-4b03-88a2-46915e1e6947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07756094-c5d1-4b03-88a2-46915e1e6947', 1, 'I', 'Allegro / Cadenza', 'Trumpet Concerto: I. Allegro / Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24296 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07756094-c5d1-4b03-88a2-46915e1e6947'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Trumpet Concerto: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24296 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:fe04af56-14da-3649-8680-7befadddccc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe04af56-14da-3649-8680-7befadddccc8', 2, 'II', 'Nocturne', 'Trumpet Concerto: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24296 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe04af56-14da-3649-8680-7befadddccc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale (Giocoso - Allegro)', part.name_en = 'Trumpet Concerto: III. Finale (Giocoso - Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24296 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:c223e7fe-1ff2-4e11-ab0f-f6a2ad7ec8ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c223e7fe-1ff2-4e11-ab0f-f6a2ad7ec8ff', 3, 'III', 'Finale (Giocoso - Allegro)', 'Trumpet Concerto: III. Finale (Giocoso - Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24296 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c223e7fe-1ff2-4e11-ab0f-f6a2ad7ec8ff'
);


-- None Variations grégoriennes sur un Salve Regina

UPDATE pieces piece
SET piece.title = 'Variations grégoriennes sur un Salve Regina', piece.title_en = 'Variations grégoriennes sur un Salve Regina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24794 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations sur un thème corse

UPDATE pieces piece
SET piece.title = 'Variations sur un thème corse', piece.title_en = 'Variations sur un thème corse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25795 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Violin Concerto “Périple d’Ulysse”

UPDATE pieces piece
SET piece.title = 'Violin Concerto “Périple d’Ulysse”', piece.title_en = 'Violin Concerto “Périple d’Ulysse”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25854 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pesante marcato e sostenuto – Vivo', part.name_en = 'Violin Concerto “Périple d’Ulysse”: I. Pesante marcato e sostenuto – Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25854 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:2453d5ab-f611-47e6-902f-9a242f471bae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2453d5ab-f611-47e6-902f-9a242f471bae', 1, 'I', 'Pesante marcato e sostenuto – Vivo', 'Violin Concerto “Périple d’Ulysse”: I. Pesante marcato e sostenuto – Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25854 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2453d5ab-f611-47e6-902f-9a242f471bae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Violin Concerto “Périple d’Ulysse”: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25854 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:1753c60b-ac0e-4add-adff-d1cd764630ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1753c60b-ac0e-4add-adff-d1cd764630ff', 2, 'II', 'Allegro', 'Violin Concerto “Périple d’Ulysse”: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25854 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1753c60b-ac0e-4add-adff-d1cd764630ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Violin Concerto “Périple d’Ulysse”: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25854 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:e29599f5-8073-4f6f-a5d1-f55e4c98f229' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e29599f5-8073-4f6f-a5d1-f55e4c98f229', 3, 'III', 'Andante', 'Violin Concerto “Périple d’Ulysse”: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25854 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29599f5-8073-4f6f-a5d1-f55e4c98f229'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final. Allegro', part.name_en = 'Violin Concerto “Périple d’Ulysse”: IV. Final. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25854 AND p.composer_id = 430 AND part.part_key = 'musicbrainz:f7b6aa9b-0bc2-4f27-8415-50a10fe37843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b6aa9b-0bc2-4f27-8415-50a10fe37843', 4, 'IV', 'Final. Allegro', 'Violin Concerto “Périple d’Ulysse”: IV. Final. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25854 AND p.composer_id = 430
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b6aa9b-0bc2-4f27-8415-50a10fe37843'
);


-- None Être ou ne pas être

UPDATE pieces piece
SET piece.title = 'Être ou ne pas être', piece.title_en = 'Être ou ne pas être',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24231 AND piece.composer_id = 430
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 카프리치오

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오', 'Capriccio', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 430
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c07628f-b455-4bf6-b0fd-b6a68e227b51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c07628f-b455-4bf6-b0fd-b6a68e227b51'
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c07628f-b455-4bf6-b0fd-b6a68e227b51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9582c16d-d402-4838-8f54-0a61b52fdec7', 1, 'I', 'Allegretto', 'Capriccio: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9582c16d-d402-4838-8f54-0a61b52fdec7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9bf4fc3-1ef9-42c1-a18a-aebbb64f3622', 2, 'II', 'Andante', 'Capriccio: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9bf4fc3-1ef9-42c1-a18a-aebbb64f3622'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c2b68c0-9b40-49ca-ad38-c631a36a0ab0', 3, 'III', 'Final', 'Capriccio: III. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2b68c0-9b40-49ca-ad38-c631a36a0ab0'
);


-- None Printemps

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Printemps', 'Printemps', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 430
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Printemps'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf0461fe-39d9-413b-acc7-58cd8ddb3968'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf0461fe-39d9-413b-acc7-58cd8ddb3968'
FROM pieces p
WHERE p.composer_id = 430 AND p.title = 'Printemps' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf0461fe-39d9-413b-acc7-58cd8ddb3968'
);


-- None Semaine Sainte à Cuzco

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Semaine Sainte à Cuzco', 'Semaine Sainte à Cuzco', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 430
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Semaine Sainte à Cuzco'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88324372-985a-4e8b-a6dc-5dd20713c13b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88324372-985a-4e8b-a6dc-5dd20713c13b'
FROM pieces p
WHERE p.composer_id = 430 AND p.title = 'Semaine Sainte à Cuzco' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88324372-985a-4e8b-a6dc-5dd20713c13b'
);


-- None 가곡 <Six mélodies populaires corses>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Six mélodies populaires corses>', 'Six mélodies populaires corses', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 430
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Six mélodies populaires corses>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f09e2ba-a918-45b1-bd14-d69896035e1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f09e2ba-a918-45b1-bd14-d69896035e1a'
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f09e2ba-a918-45b1-bd14-d69896035e1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92335173-ff54-4169-8e01-c597cbcfe144', 1, NULL, 'Ciuciarella', 'Ciuciarella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92335173-ff54-4169-8e01-c597cbcfe144'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb516101-2528-4027-ba30-adb6e415140b', 2, NULL, 'Vocero', 'Vocero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb516101-2528-4027-ba30-adb6e415140b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:312cd782-8dcc-4354-8a31-7c6dc92cfe0f', 3, NULL, 'Chanson de la pipe', 'Chanson de la pipe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:312cd782-8dcc-4354-8a31-7c6dc92cfe0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b89febca-d63f-4e5f-952f-8831021724bc', 4, NULL, 'Ninina', 'Ninina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b89febca-d63f-4e5f-952f-8831021724bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38ccbc54-5cff-4b71-b7c2-bc1c7a373e93', 5, NULL, 'Lamento', 'Lamento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38ccbc54-5cff-4b71-b7c2-bc1c7a373e93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b174ee34-e3cb-4d31-aeea-b6445a5f0ca3', 6, NULL, 'Zilimbrina', 'Zilimbrina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 430 AND p.title = '가곡 <Six mélodies populaires corses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b174ee34-e3cb-4d31-aeea-b6445a5f0ca3'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 430 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23620
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
