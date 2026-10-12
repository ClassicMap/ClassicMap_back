-- 페르난도 소르 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 100개(묶음 29, 다악장 23, 낱곡 48),
-- 새 작품 1개, part 356개, 그 아래 12개.
-- seed 105개 중 99개를 작품·part 에 잇고, 6개를 숨기고, 0개는 그대로 둔다.
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

-- Op. 53 "Le premier pas vers moi"

UPDATE pieces piece
SET piece.title = '"Le premier pas vers moi"', piece.title_en = '"Le premier pas vers moi", op. 53',
    piece.type = 'album', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17299 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = '"Le premier pas vers moi", op. 53: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17299 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cd863df0-9906-4627-8814-2cc41fa896bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd863df0-9906-4627-8814-2cc41fa896bb', 1, 'I', 'Andantino', '"Le premier pas vers moi", op. 53: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17299 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd863df0-9906-4627-8814-2cc41fa896bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = '"Le premier pas vers moi", op. 53: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17299 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8712a3d1-55fa-4f8b-882d-0ebfe78a77bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8712a3d1-55fa-4f8b-882d-0ebfe78a77bb', 2, 'II', 'Allegretto', '"Le premier pas vers moi", op. 53: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17299 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8712a3d1-55fa-4f8b-882d-0ebfe78a77bb'
);


-- Op. 21 "Les Adieux"

UPDATE pieces piece
SET piece.title = '"Les Adieux"', piece.title_en = '"Les Adieux", op. 21',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16196 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 12 Seguidillas

UPDATE pieces piece
SET piece.title = '12 Seguidillas', piece.title_en = '12 Seguidillas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17725 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cesa de atormentarme', part.name_en = '12 Seguidillas: No. 1. Cesa de atormentarme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:702527d8-e5df-4fd3-9c77-31cc565c8a6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:702527d8-e5df-4fd3-9c77-31cc565c8a6b', 1, NULL, 'Cesa de atormentarme', '12 Seguidillas: No. 1. Cesa de atormentarme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:702527d8-e5df-4fd3-9c77-31cc565c8a6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'De amor en las prisiones', part.name_en = '12 Seguidillas: No. 2. De amor en las prisiones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:29901f0d-8f10-4c56-96e6-583132c38917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29901f0d-8f10-4c56-96e6-583132c38917', 2, NULL, 'De amor en las prisiones', '12 Seguidillas: No. 2. De amor en las prisiones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29901f0d-8f10-4c56-96e6-583132c38917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acuérdate, bien mío', part.name_en = '12 Seguidillas: No. 3. Acuérdate, bien mío',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7646bc02-d001-4406-a5e3-f6c9bc15f69b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7646bc02-d001-4406-a5e3-f6c9bc15f69b', 3, NULL, 'Acuérdate, bien mío', '12 Seguidillas: No. 3. Acuérdate, bien mío', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7646bc02-d001-4406-a5e3-f6c9bc15f69b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prepárame la tumba', part.name_en = '12 Seguidillas: No. 4. Prepárame la tumba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:26cfdb65-c4d4-4190-83ed-4c7064628b10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26cfdb65-c4d4-4190-83ed-4c7064628b10', 4, NULL, 'Prepárame la tumba', '12 Seguidillas: No. 4. Prepárame la tumba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26cfdb65-c4d4-4190-83ed-4c7064628b10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cómo ha de resolverse', part.name_en = '12 Seguidillas: No. 5. Cómo ha de resolverse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0ad1883b-354e-4c74-aaad-ef43128d29d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad1883b-354e-4c74-aaad-ef43128d29d2', 5, NULL, 'Cómo ha de resolverse', '12 Seguidillas: No. 5. Cómo ha de resolverse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad1883b-354e-4c74-aaad-ef43128d29d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Muchacha, y la vergüenza', part.name_en = '12 Seguidillas: No. 6. Muchacha, y la vergüenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1902c77e-76c9-4ae5-bfd6-9a7b5d063ba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1902c77e-76c9-4ae5-bfd6-9a7b5d063ba1', 6, NULL, 'Muchacha, y la vergüenza', '12 Seguidillas: No. 6. Muchacha, y la vergüenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1902c77e-76c9-4ae5-bfd6-9a7b5d063ba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Si dices que mis ojos', part.name_en = '12 Seguidillas: No. 7. Si dices que mis ojos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c87de315-fc60-4dbc-82b2-f3c7949e029f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c87de315-fc60-4dbc-82b2-f3c7949e029f', 7, NULL, 'Si dices que mis ojos', '12 Seguidillas: No. 7. Si dices que mis ojos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c87de315-fc60-4dbc-82b2-f3c7949e029f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Los Canónigos, madre', part.name_en = '12 Seguidillas: No. 8. Los Canónigos, madre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b1c73c42-17fc-471b-b2d9-2fef7ee89cb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1c73c42-17fc-471b-b2d9-2fef7ee89cb6', 8, NULL, 'Los Canónigos, madre', '12 Seguidillas: No. 8. Los Canónigos, madre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1c73c42-17fc-471b-b2d9-2fef7ee89cb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'El que quisiera amando', part.name_en = '12 Seguidillas: No. 9. El que quisiera amando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e5195133-77e4-4160-91d1-60af39657a7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5195133-77e4-4160-91d1-60af39657a7a', 9, NULL, 'El que quisiera amando', '12 Seguidillas: No. 9. El que quisiera amando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5195133-77e4-4160-91d1-60af39657a7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Si a otro cuando me quieres', part.name_en = '12 Seguidillas: No. 10. Si a otro cuando me quieres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6382901d-db54-4ea3-82ee-2ed4123f6861' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6382901d-db54-4ea3-82ee-2ed4123f6861', 10, NULL, 'Si a otro cuando me quieres', '12 Seguidillas: No. 10. Si a otro cuando me quieres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6382901d-db54-4ea3-82ee-2ed4123f6861'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Las mujeres y cuerdas', part.name_en = '12 Seguidillas: No. 11. Las mujeres y cuerdas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c56eb129-b623-4e74-ad17-a4483c086f68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c56eb129-b623-4e74-ad17-a4483c086f68', 11, NULL, 'Las mujeres y cuerdas', '12 Seguidillas: No. 11. Las mujeres y cuerdas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c56eb129-b623-4e74-ad17-a4483c086f68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Mis descuidados ojos (Boléro de société)', part.name_en = '12 Seguidillas: No. 12. Mis descuidados ojos (Boléro de société)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17725 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d7107cfa-2f31-4bec-8eca-750762183489' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7107cfa-2f31-4bec-8eca-750762183489', 12, NULL, 'Mis descuidados ojos (Boléro de société)', '12 Seguidillas: No. 12. Mis descuidados ojos (Boléro de société)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17725 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7107cfa-2f31-4bec-8eca-750762183489'
);


-- Op. 29 12 estudios Op. 29

UPDATE pieces piece
SET piece.title = '12 estudios Op. 29', piece.title_en = '12 estudios, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16338 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 5 en si menor', part.name_en = '12 estudios, op. 29: N.º 5 en si menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a28f0bf1-e2d5-4d38-b7da-fb2f3c9d8748' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a28f0bf1-e2d5-4d38-b7da-fb2f3c9d8748', 1, NULL, 'N.º 5 en si menor', '12 estudios, op. 29: N.º 5 en si menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a28f0bf1-e2d5-4d38-b7da-fb2f3c9d8748'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 13 en si mayor', part.name_en = '12 estudios, op. 29: N.º 13 en si mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a', 2, NULL, 'N.º 13 en si mayor', '12 estudios, op. 29: N.º 13 en si mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'N.º 14 en fa mayor', part.name_en = '12 estudios, op. 29: N.º 14 en fa mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1cc893dd-74ac-49db-9c2c-41c22a6dad67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc893dd-74ac-49db-9c2c-41c22a6dad67', 3, NULL, 'N.º 14 en fa mayor', '12 estudios, op. 29: N.º 14 en fa mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc893dd-74ac-49db-9c2c-41c22a6dad67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'N.º 15 en sol mayor', part.name_en = '12 estudios, op. 29: N.º 15 en sol mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:896bb7f5-9dae-4faf-82f2-810e0d3ce837' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:896bb7f5-9dae-4faf-82f2-810e0d3ce837', 4, NULL, 'N.º 15 en sol mayor', '12 estudios, op. 29: N.º 15 en sol mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:896bb7f5-9dae-4faf-82f2-810e0d3ce837'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'N.º 16 en la menor', part.name_en = '12 estudios, op. 29: N.º 16 en la menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:affb08d3-9dd9-43c3-8f1e-c3c81c0e0aad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:affb08d3-9dd9-43c3-8f1e-c3c81c0e0aad', 5, NULL, 'N.º 16 en la menor', '12 estudios, op. 29: N.º 16 en la menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:affb08d3-9dd9-43c3-8f1e-c3c81c0e0aad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'N.º 17 en do mayor', part.name_en = '12 estudios, op. 29: N.º 17 en do mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca', 6, NULL, 'N.º 17 en do mayor', '12 estudios, op. 29: N.º 17 en do mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'N.º 18 en mi menor', part.name_en = '12 estudios, op. 29: N.º 18 en mi menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fb9c5f78-e9e1-4c2a-bde9-65cbf1c26a94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb9c5f78-e9e1-4c2a-bde9-65cbf1c26a94', 7, NULL, 'N.º 18 en mi menor', '12 estudios, op. 29: N.º 18 en mi menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb9c5f78-e9e1-4c2a-bde9-65cbf1c26a94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'N.º 19 en si menor', part.name_en = '12 estudios, op. 29: N.º 19 en si menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b2b1f99a-3042-44b5-baff-bd9308939f28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2b1f99a-3042-44b5-baff-bd9308939f28', 8, NULL, 'N.º 19 en si menor', '12 estudios, op. 29: N.º 19 en si menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2b1f99a-3042-44b5-baff-bd9308939f28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'N.º 20 en re mayor', part.name_en = '12 estudios, op. 29: N.º 20 en re mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dcc44ad8-3742-4a46-9068-7a8b2111ac09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcc44ad8-3742-4a46-9068-7a8b2111ac09', 9, NULL, 'N.º 20 en re mayor', '12 estudios, op. 29: N.º 20 en re mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcc44ad8-3742-4a46-9068-7a8b2111ac09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'N.º 21 en re mayor', part.name_en = '12 estudios, op. 29: N.º 21 en re mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:faa45e91-017a-4907-b17f-d8d6e05ae163' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faa45e91-017a-4907-b17f-d8d6e05ae163', 10, NULL, 'N.º 21 en re mayor', '12 estudios, op. 29: N.º 21 en re mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faa45e91-017a-4907-b17f-d8d6e05ae163'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'N.º 22 en mi bemol mayor', part.name_en = '12 estudios, op. 29: N.º 22 en mi bemol mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7', 11, NULL, 'N.º 22 en mi bemol mayor', '12 estudios, op. 29: N.º 22 en mi bemol mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'N.º 23 en sol mayor', part.name_en = '12 estudios, op. 29: N.º 23 en sol mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42', 12, NULL, 'N.º 23 en sol mayor', '12 estudios, op. 29: N.º 23 en sol mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'N.º 24 en fa mayor', part.name_en = '12 estudios, op. 29: N.º 24 en fa mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16338 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a7a7134d-184e-4eea-b646-1cb99384c12a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7a7134d-184e-4eea-b646-1cb99384c12a', 13, NULL, 'N.º 24 en fa mayor', '12 estudios, op. 29: N.º 24 en fa mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16338 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a7134d-184e-4eea-b646-1cb99384c12a'
);


-- Op. 6 12 estudios Op. 6

UPDATE pieces piece
SET piece.title = '12 estudios Op. 6', piece.title_en = '12 estudios, op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19354 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = '12 estudios, op. 6: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631', 1, NULL, 'No. 1', '12 estudios, op. 6: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 2 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679', 2, NULL, 'en la mayor', '12 estudios, op. 6: No. 2 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = '12 estudios, op. 6: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb', 3, NULL, 'No. 3', '12 estudios, op. 6: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = '12 estudios, op. 6: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:28b48db3-21d4-42f8-b6d0-c5a4506bcad7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28b48db3-21d4-42f8-b6d0-c5a4506bcad7', 4, NULL, 'No. 4', '12 estudios, op. 6: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28b48db3-21d4-42f8-b6d0-c5a4506bcad7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = '12 estudios, op. 6: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a5f69298-f320-4555-bfe8-66a04d7eb043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5f69298-f320-4555-bfe8-66a04d7eb043', 5, NULL, 'No. 5', '12 estudios, op. 6: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f69298-f320-4555-bfe8-66a04d7eb043'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 6 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca', 6, NULL, 'en la mayor', '12 estudios, op. 6: No. 6 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = '12 estudios, op. 6: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5ba1fb15-2173-48c5-b3ec-6e6655d0519b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba1fb15-2173-48c5-b3ec-6e6655d0519b', 7, NULL, 'No. 7', '12 estudios, op. 6: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba1fb15-2173-48c5-b3ec-6e6655d0519b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'en do mayor', part.name_en = '12 estudios, op. 6: No. 8 en do mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d', 8, NULL, 'en do mayor', '12 estudios, op. 6: No. 8 en do mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'en re menor', part.name_en = '12 estudios, op. 6: No. 9 en re menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a', 9, NULL, 'en re menor', '12 estudios, op. 6: No. 9 en re menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 10 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:4f6f6487-230d-4e83-a691-25eee023d01b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f6f6487-230d-4e83-a691-25eee023d01b', 10, NULL, 'en la mayor', '12 estudios, op. 6: No. 10 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f6f6487-230d-4e83-a691-25eee023d01b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'en mi menor', part.name_en = '12 estudios, op. 6: No. 11 en mi menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1', 11, NULL, 'en mi menor', '12 estudios, op. 6: No. 11 en mi menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 12 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19354 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b', 12, NULL, 'en la mayor', '12 estudios, op. 6: No. 12 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19354 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b'
);


-- Op. 11 2 Varied Themes and 12 Minuets Op. 11

UPDATE pieces piece
SET piece.title = '2 Varied Themes and 12 Minuets Op. 11', piece.title_en = '2 Varied Themes and 12 Minuets, op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19917 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Varied Theme no. 2', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Varied Theme no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0b755cca-d6dd-42ce-a9e5-11d57ba104bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b755cca-d6dd-42ce-a9e5-11d57ba104bf', 1, NULL, 'Varied Theme no. 2', '2 Varied Themes and 12 Minuets, op. 11: Varied Theme no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b755cca-d6dd-42ce-a9e5-11d57ba104bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 11', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2d24147f-1801-4e56-924c-9b66dedab967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d24147f-1801-4e56-924c-9b66dedab967', 2, NULL, 'Minuet no. 11', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d24147f-1801-4e56-924c-9b66dedab967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 6 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:305c8cd8-8d76-4a28-b9a6-c385e85d1e46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:305c8cd8-8d76-4a28-b9a6-c385e85d1e46', 3, NULL, 'A장조', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 6 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305c8cd8-8d76-4a28-b9a6-c385e85d1e46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Varied Theme no. 1', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Varied Theme no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7b71b975-d597-4d5c-8198-3308f6ea8409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b71b975-d597-4d5c-8198-3308f6ea8409', 4, NULL, 'Varied Theme no. 1', '2 Varied Themes and 12 Minuets, op. 11: Varied Theme no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b71b975-d597-4d5c-8198-3308f6ea8409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 1', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:87de1806-16e0-41d3-bcd5-576ab0e81ca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87de1806-16e0-41d3-bcd5-576ab0e81ca8', 5, NULL, 'Minuet no. 1', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87de1806-16e0-41d3-bcd5-576ab0e81ca8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 8', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b9e4c061-2cb1-45de-b0f2-020221d5ccb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9e4c061-2cb1-45de-b0f2-020221d5ccb8', 6, NULL, 'Minuet no. 8', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9e4c061-2cb1-45de-b0f2-020221d5ccb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 9', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bf951a18-3990-4eec-a983-0fda67e9e406' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf951a18-3990-4eec-a983-0fda67e9e406', 7, NULL, 'Minuet no. 9', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf951a18-3990-4eec-a983-0fda67e9e406'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 5', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c3610c2d-87e5-4e7d-891c-bf1c8f64bedd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3610c2d-87e5-4e7d-891c-bf1c8f64bedd', 8, NULL, 'Minuet no. 5', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3610c2d-87e5-4e7d-891c-bf1c8f64bedd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 12', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d0d1c747-44a3-41d1-a97f-955a58acb9cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0d1c747-44a3-41d1-a97f-955a58acb9cd', 9, NULL, 'Minuet no. 12', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d1c747-44a3-41d1-a97f-955a58acb9cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 4', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d946ab0d-1329-4bc2-82e3-940441620ac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d946ab0d-1329-4bc2-82e3-940441620ac7', 10, NULL, 'Minuet no. 4', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d946ab0d-1329-4bc2-82e3-940441620ac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 7 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e9263665-644a-4ed3-8be0-284a3f68c38e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9263665-644a-4ed3-8be0-284a3f68c38e', 11, NULL, 'A단조', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 7 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9263665-644a-4ed3-8be0-284a3f68c38e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 3', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:edb54db9-8c8c-4493-a9d0-9b2a6670230e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb54db9-8c8c-4493-a9d0-9b2a6670230e', 12, NULL, 'Minuet no. 3', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb54db9-8c8c-4493-a9d0-9b2a6670230e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 10 in E', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 10 in E',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f3328595-dafa-4af3-8b04-8b7ec796ad23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3328595-dafa-4af3-8b04-8b7ec796ad23', 13, NULL, 'Minuet no. 10 in E', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 10 in E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3328595-dafa-4af3-8b04-8b7ec796ad23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Minuet no. 2', part.name_en = '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19917 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f3e7c4a3-7718-4941-91a7-b631202fdf46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3e7c4a3-7718-4941-91a7-b631202fdf46', 14, NULL, 'Minuet no. 2', '2 Varied Themes and 12 Minuets, op. 11: Minuet no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19917 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3e7c4a3-7718-4941-91a7-b631202fdf46'
);


-- Op. 35 24 Exercises Op. 35

UPDATE pieces piece
SET piece.title = '24 Exercises Op. 35', piece.title_en = '24 Exercises, op. 35',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19814 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = '24 Exercises, op. 35: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:353ab7e0-ded9-47ee-9535-4a56e4e53a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:353ab7e0-ded9-47ee-9535-4a56e4e53a47', 1, NULL, 'No. 1', '24 Exercises, op. 35: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:353ab7e0-ded9-47ee-9535-4a56e4e53a47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = '24 Exercises, op. 35: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fad4df9f-0909-4793-826a-34371f070bad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad4df9f-0909-4793-826a-34371f070bad', 2, NULL, 'No. 2', '24 Exercises, op. 35: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad4df9f-0909-4793-826a-34371f070bad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Exercises, op. 35: No. 3 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:40c8253d-5dd3-4c9c-a8a9-5d64940d5d8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40c8253d-5dd3-4c9c-a8a9-5d64940d5d8d', 3, NULL, 'A단조', '24 Exercises, op. 35: No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c8253d-5dd3-4c9c-a8a9-5d64940d5d8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = '24 Exercises, op. 35: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:22fb6b72-118a-4d27-9fe0-7c025af1918a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22fb6b72-118a-4d27-9fe0-7c025af1918a', 4, NULL, 'No. 4', '24 Exercises, op. 35: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22fb6b72-118a-4d27-9fe0-7c025af1918a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = '24 Exercises, op. 35: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3acf6766-81a2-40a6-8b2a-c724b78aa467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3acf6766-81a2-40a6-8b2a-c724b78aa467', 5, NULL, 'No. 5', '24 Exercises, op. 35: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3acf6766-81a2-40a6-8b2a-c724b78aa467'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = '24 Exercises, op. 35: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:42ee686d-9929-41af-be73-96651a4d4e9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42ee686d-9929-41af-be73-96651a4d4e9e', 6, NULL, 'No. 6', '24 Exercises, op. 35: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ee686d-9929-41af-be73-96651a4d4e9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = '24 Exercises, op. 35: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:df10d614-f86c-41d0-8dfd-00c5575c1bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df10d614-f86c-41d0-8dfd-00c5575c1bbc', 7, NULL, 'No. 7', '24 Exercises, op. 35: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df10d614-f86c-41d0-8dfd-00c5575c1bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = '24 Exercises, op. 35: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:559aa0ac-a350-4cdb-b45c-3beeeabb4bfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:559aa0ac-a350-4cdb-b45c-3beeeabb4bfd', 8, NULL, 'No. 8', '24 Exercises, op. 35: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:559aa0ac-a350-4cdb-b45c-3beeeabb4bfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'in A', part.name_en = '24 Exercises, op. 35: No. 9 in A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1aa247d5-d269-45a0-9962-0970fb0cf05f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aa247d5-d269-45a0-9962-0970fb0cf05f', 9, NULL, 'in A', '24 Exercises, op. 35: No. 9 in A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa247d5-d269-45a0-9962-0970fb0cf05f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = '24 Exercises, op. 35: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b72623ea-e7c8-4c9c-8dab-3ee22721344f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b72623ea-e7c8-4c9c-8dab-3ee22721344f', 10, NULL, 'No. 10', '24 Exercises, op. 35: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b72623ea-e7c8-4c9c-8dab-3ee22721344f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = '24 Exercises, op. 35: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b16448e0-6b0e-4dfb-8a3a-a286808eb46a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16448e0-6b0e-4dfb-8a3a-a286808eb46a', 11, NULL, 'No. 11', '24 Exercises, op. 35: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16448e0-6b0e-4dfb-8a3a-a286808eb46a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '24 Exercises, op. 35: No. 12 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a206ea0d-41c3-4b9f-8bce-f1969c0f9197' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a206ea0d-41c3-4b9f-8bce-f1969c0f9197', 12, NULL, 'F장조', '24 Exercises, op. 35: No. 12 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a206ea0d-41c3-4b9f-8bce-f1969c0f9197'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Exercises, op. 35: No. 13 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3', 13, NULL, 'C장조', '24 Exercises, op. 35: No. 13 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = '24 Exercises, op. 35: No. 14 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c6178b23-86d6-3f0e-832c-e26cc7098086' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6178b23-86d6-3f0e-832c-e26cc7098086', 14, NULL, 'C단조', '24 Exercises, op. 35: No. 14 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6178b23-86d6-3f0e-832c-e26cc7098086'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'No. 15', part.name_en = '24 Exercises, op. 35: No. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9ddd7dc4-e741-4ab0-bc3a-703b7af88dec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ddd7dc4-e741-4ab0-bc3a-703b7af88dec', 15, NULL, 'No. 15', '24 Exercises, op. 35: No. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ddd7dc4-e741-4ab0-bc3a-703b7af88dec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Exercises, op. 35: No. 16 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad', 16, NULL, 'D단조', '24 Exercises, op. 35: No. 16 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Exercises, op. 35: No. 17 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914', 17, NULL, 'D장조', '24 Exercises, op. 35: No. 17 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'No. 18', part.name_en = '24 Exercises, op. 35: No. 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:45c9b1a3-3b12-4cc1-8f63-72c477b01d06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c9b1a3-3b12-4cc1-8f63-72c477b01d06', 18, NULL, 'No. 18', '24 Exercises, op. 35: No. 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c9b1a3-3b12-4cc1-8f63-72c477b01d06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'C♯장조', part.name_en = '24 Exercises, op. 35: No. 19 in C-sharp major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f3efe94e-7df6-4f0c-b2b3-7862138b01af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3efe94e-7df6-4f0c-b2b3-7862138b01af', 19, NULL, 'C♯장조', '24 Exercises, op. 35: No. 19 in C-sharp major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3efe94e-7df6-4f0c-b2b3-7862138b01af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'No. 20', part.name_en = '24 Exercises, op. 35: No. 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2566794a-a121-42a1-acb7-4fb3b41cb13c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2566794a-a121-42a1-acb7-4fb3b41cb13c', 20, NULL, 'No. 20', '24 Exercises, op. 35: No. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2566794a-a121-42a1-acb7-4fb3b41cb13c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = '24 Exercises, op. 35: No. 21 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:44207e0f-7af1-3f2d-bb4d-a2185c325fd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44207e0f-7af1-3f2d-bb4d-a2185c325fd9', 21, NULL, 'B장조', '24 Exercises, op. 35: No. 21 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44207e0f-7af1-3f2d-bb4d-a2185c325fd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Exercises, op. 35: No. 22 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94', 22, NULL, 'B단조', '24 Exercises, op. 35: No. 22 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'No. 23', part.name_en = '24 Exercises, op. 35: No. 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dbf7b49f-c432-4740-acbe-0e57b44bffa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbf7b49f-c432-4740-acbe-0e57b44bffa8', 23, NULL, 'No. 23', '24 Exercises, op. 35: No. 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbf7b49f-c432-4740-acbe-0e57b44bffa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'No. 24', part.name_en = '24 Exercises, op. 35: No. 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19814 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f2cc69f6-ad54-498b-b8e6-f2b325a9ab13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2cc69f6-ad54-498b-b8e6-f2b325a9ab13', 24, NULL, 'No. 24', '24 Exercises, op. 35: No. 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19814 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2cc69f6-ad54-498b-b8e6-f2b325a9ab13'
);


-- Op. 44 24 Pièces progressives

UPDATE pieces piece
SET piece.title = '24 Pièces progressives', piece.title_en = '24 Pièces progressives, op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17548 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Pièces progressives, op. 44: No. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b6a514d8-cbae-4e0e-9af0-230296920ba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6a514d8-cbae-4e0e-9af0-230296920ba6', 1, NULL, 'C장조', '24 Pièces progressives, op. 44: No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a514d8-cbae-4e0e-9af0-230296920ba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Pièces progressives, op. 44: No. 2 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8f142db7-16b9-44f1-9231-f8e3ea45c813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f142db7-16b9-44f1-9231-f8e3ea45c813', 2, NULL, 'C장조', '24 Pièces progressives, op. 44: No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f142db7-16b9-44f1-9231-f8e3ea45c813'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Pièces progressives, op. 44: No. 3 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:70b3101a-9631-4c0a-9e1b-d2b8f6948fb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70b3101a-9631-4c0a-9e1b-d2b8f6948fb2', 3, NULL, 'C장조', '24 Pièces progressives, op. 44: No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70b3101a-9631-4c0a-9e1b-d2b8f6948fb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Pièces progressives, op. 44: No. 4 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c4eefade-15ee-42d0-aeab-fdc505d7d823' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4eefade-15ee-42d0-aeab-fdc505d7d823', 4, NULL, 'C장조', '24 Pièces progressives, op. 44: No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4eefade-15ee-42d0-aeab-fdc505d7d823'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Pièces progressives, op. 44: No. 5 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:aed4ce57-bf1d-4e29-ae0c-0137ac3cd022' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aed4ce57-bf1d-4e29-ae0c-0137ac3cd022', 5, NULL, 'C장조', '24 Pièces progressives, op. 44: No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed4ce57-bf1d-4e29-ae0c-0137ac3cd022'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 6 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5c4a9415-8756-4e06-9c40-5dab020b713f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c4a9415-8756-4e06-9c40-5dab020b713f', 6, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c4a9415-8756-4e06-9c40-5dab020b713f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 7 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:50590f05-2dbd-4642-a218-467b0b96b1a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50590f05-2dbd-4642-a218-467b0b96b1a8', 7, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 7 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50590f05-2dbd-4642-a218-467b0b96b1a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 8 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a180209c-093c-4b4f-995a-e1e34cab1520' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a180209c-093c-4b4f-995a-e1e34cab1520', 8, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a180209c-093c-4b4f-995a-e1e34cab1520'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 9 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:940f0dc1-e720-4419-82b9-80e52e6ecfb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:940f0dc1-e720-4419-82b9-80e52e6ecfb2', 9, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 9 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:940f0dc1-e720-4419-82b9-80e52e6ecfb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 10 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3d893830-40d9-4dbd-8722-0fa4c1f554ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d893830-40d9-4dbd-8722-0fa4c1f554ae', 10, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d893830-40d9-4dbd-8722-0fa4c1f554ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '24 Pièces progressives, op. 44: No. 11 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1ea14931-38f3-4de7-87fb-aefea8d6865b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea14931-38f3-4de7-87fb-aefea8d6865b', 11, NULL, 'E단조', '24 Pièces progressives, op. 44: No. 11 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea14931-38f3-4de7-87fb-aefea8d6865b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '24 Pièces progressives, op. 44: No. 12 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d247eb13-7404-451e-b8d2-ac350b2a4060' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d247eb13-7404-451e-b8d2-ac350b2a4060', 12, NULL, 'E단조', '24 Pièces progressives, op. 44: No. 12 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d247eb13-7404-451e-b8d2-ac350b2a4060'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Pièces progressives, op. 44: No. 13 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7789c3d7-b6d7-48e3-8984-f1cf6ca3c79e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7789c3d7-b6d7-48e3-8984-f1cf6ca3c79e', 13, NULL, 'G장조', '24 Pièces progressives, op. 44: No. 13 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7789c3d7-b6d7-48e3-8984-f1cf6ca3c79e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Pièces progressives, op. 44: No. 14 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cda94b9b-da85-4cbf-b1d8-ee59ba13994e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda94b9b-da85-4cbf-b1d8-ee59ba13994e', 14, NULL, 'D장조', '24 Pièces progressives, op. 44: No. 14 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda94b9b-da85-4cbf-b1d8-ee59ba13994e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Pièces progressives, op. 44: No. 15 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7b6c09a2-6996-448f-8196-c685b50fe5c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b6c09a2-6996-448f-8196-c685b50fe5c7', 15, NULL, 'D장조', '24 Pièces progressives, op. 44: No. 15 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b6c09a2-6996-448f-8196-c685b50fe5c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Pièces progressives, op. 44: No. 16 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f0099d8b-c9ca-45b7-a494-e9f10a00a7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0099d8b-c9ca-45b7-a494-e9f10a00a7b0', 16, NULL, 'D장조', '24 Pièces progressives, op. 44: No. 16 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0099d8b-c9ca-45b7-a494-e9f10a00a7b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Pièces progressives, op. 44: No. 17 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:87462a86-cfc2-4867-b548-d0eaf85987c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87462a86-cfc2-4867-b548-d0eaf85987c3', 17, NULL, 'D단조', '24 Pièces progressives, op. 44: No. 17 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87462a86-cfc2-4867-b548-d0eaf85987c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Pièces progressives, op. 44: No. 18 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:239b1752-2d8b-459c-aff7-c304c890a323' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:239b1752-2d8b-459c-aff7-c304c890a323', 18, NULL, 'D장조', '24 Pièces progressives, op. 44: No. 18 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:239b1752-2d8b-459c-aff7-c304c890a323'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Pièces progressives, op. 44: No. 19 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1d529ac7-4740-440e-8de9-e6a70e318b9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d529ac7-4740-440e-8de9-e6a70e318b9c', 19, NULL, 'D장조', '24 Pièces progressives, op. 44: No. 19 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d529ac7-4740-440e-8de9-e6a70e318b9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Pièces progressives, op. 44: No. 20 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8adcd4fd-d658-47ad-ab9a-2df845d02d17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8adcd4fd-d658-47ad-ab9a-2df845d02d17', 20, NULL, 'A장조', '24 Pièces progressives, op. 44: No. 20 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8adcd4fd-d658-47ad-ab9a-2df845d02d17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Pièces progressives, op. 44: No. 21 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:aea66c19-86ae-42e7-8e91-4970f350dfa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea66c19-86ae-42e7-8e91-4970f350dfa1', 21, NULL, 'A장조', '24 Pièces progressives, op. 44: No. 21 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea66c19-86ae-42e7-8e91-4970f350dfa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Pièces progressives, op. 44: No. 22 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bb175e12-517e-4563-be20-c847b212afaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb175e12-517e-4563-be20-c847b212afaa', 22, NULL, 'A단조', '24 Pièces progressives, op. 44: No. 22 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb175e12-517e-4563-be20-c847b212afaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Pièces progressives, op. 44: No. 23 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d4666a2b-5156-4930-bb80-0ea7775d3c34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4666a2b-5156-4930-bb80-0ea7775d3c34', 23, NULL, 'A단조', '24 Pièces progressives, op. 44: No. 23 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4666a2b-5156-4930-bb80-0ea7775d3c34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Pièces progressives, op. 44: No. 24 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17548 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:49b60da7-6b54-4be4-806c-d3526fcac30a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49b60da7-6b54-4be4-806c-d3526fcac30a', 24, NULL, 'A장조', '24 Pièces progressives, op. 44: No. 24 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17548 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b60da7-6b54-4be4-806c-d3526fcac30a'
);


-- Op. 31 24 Progressive Lessons for Beginners Op. 31

UPDATE pieces piece
SET piece.title = '24 Progressive Lessons for Beginners Op. 31', piece.title_en = '24 Progressive Lessons for Beginners, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15764 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'in C', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 1 in C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:20eaf848-5faa-4d93-b6e9-530d3ccf1862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20eaf848-5faa-4d93-b6e9-530d3ccf1862', 1, NULL, 'in C', '24 Progressive Lessons for Beginners, op. 31: No. 1 in C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20eaf848-5faa-4d93-b6e9-530d3ccf1862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2d8773fa-d6c9-40ef-8dc9-7cf71c36217c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d8773fa-d6c9-40ef-8dc9-7cf71c36217c', 2, NULL, 'No. 2', '24 Progressive Lessons for Beginners, op. 31: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d8773fa-d6c9-40ef-8dc9-7cf71c36217c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:738d6d23-0bb1-4940-9a72-350de99f22da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:738d6d23-0bb1-4940-9a72-350de99f22da', 3, NULL, 'No. 3', '24 Progressive Lessons for Beginners, op. 31: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:738d6d23-0bb1-4940-9a72-350de99f22da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 4 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b2d9e873-ca22-3fcb-bd80-80b84b3cf600' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2d9e873-ca22-3fcb-bd80-80b84b3cf600', 4, NULL, 'B단조', '24 Progressive Lessons for Beginners, op. 31: No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2d9e873-ca22-3fcb-bd80-80b84b3cf600'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:4e69d599-7e29-409d-b288-f34e8c8e5af5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e69d599-7e29-409d-b288-f34e8c8e5af5', 5, NULL, 'No. 5', '24 Progressive Lessons for Beginners, op. 31: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e69d599-7e29-409d-b288-f34e8c8e5af5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1a8dc6a3-0843-4487-87be-b3baab50b0d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a8dc6a3-0843-4487-87be-b3baab50b0d6', 6, NULL, 'No. 6', '24 Progressive Lessons for Beginners, op. 31: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a8dc6a3-0843-4487-87be-b3baab50b0d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:071ce54c-8b1d-4ec9-90a9-5e4ba96291cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:071ce54c-8b1d-4ec9-90a9-5e4ba96291cc', 7, NULL, 'No. 7', '24 Progressive Lessons for Beginners, op. 31: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:071ce54c-8b1d-4ec9-90a9-5e4ba96291cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f839f2fd-19b1-4ef4-b0ee-c686e0e0a72e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f839f2fd-19b1-4ef4-b0ee-c686e0e0a72e', 8, NULL, 'No. 8', '24 Progressive Lessons for Beginners, op. 31: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f839f2fd-19b1-4ef4-b0ee-c686e0e0a72e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 9 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c6d1e59e-7244-4feb-9967-6b022d523034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6d1e59e-7244-4feb-9967-6b022d523034', 9, NULL, 'B단조', '24 Progressive Lessons for Beginners, op. 31: No. 9 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d1e59e-7244-4feb-9967-6b022d523034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:870437e6-8ba1-4081-bc78-f612220d7c3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870437e6-8ba1-4081-bc78-f612220d7c3b', 10, NULL, 'No. 10', '24 Progressive Lessons for Beginners, op. 31: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870437e6-8ba1-4081-bc78-f612220d7c3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f37ef6ad-0c11-42d1-8067-0170786adfef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f37ef6ad-0c11-42d1-8067-0170786adfef', 11, NULL, 'No. 11', '24 Progressive Lessons for Beginners, op. 31: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f37ef6ad-0c11-42d1-8067-0170786adfef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'No. 12', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:90b7ef1f-ab28-450c-8b61-b9796ed9984c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b7ef1f-ab28-450c-8b61-b9796ed9984c', 12, NULL, 'No. 12', '24 Progressive Lessons for Beginners, op. 31: No. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b7ef1f-ab28-450c-8b61-b9796ed9984c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'No. 13', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1399b135-af41-4beb-85a0-90d8dd46baeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1399b135-af41-4beb-85a0-90d8dd46baeb', 13, NULL, 'No. 13', '24 Progressive Lessons for Beginners, op. 31: No. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1399b135-af41-4beb-85a0-90d8dd46baeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'No. 14', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5f9122c6-cf05-4472-9795-b9f0f8ac2a63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f9122c6-cf05-4472-9795-b9f0f8ac2a63', 14, NULL, 'No. 14', '24 Progressive Lessons for Beginners, op. 31: No. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9122c6-cf05-4472-9795-b9f0f8ac2a63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'No. 15', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:96cdedf4-f9ba-49fd-a91b-46282c55ac07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96cdedf4-f9ba-49fd-a91b-46282c55ac07', 15, NULL, 'No. 15', '24 Progressive Lessons for Beginners, op. 31: No. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96cdedf4-f9ba-49fd-a91b-46282c55ac07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 16 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb', 16, NULL, 'D단조', '24 Progressive Lessons for Beginners, op. 31: No. 16 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'No. 17', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:524ff3fe-d852-440a-ae66-076f98efc3bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:524ff3fe-d852-440a-ae66-076f98efc3bb', 17, NULL, 'No. 17', '24 Progressive Lessons for Beginners, op. 31: No. 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524ff3fe-d852-440a-ae66-076f98efc3bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 18 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0a103ec2-1c63-4eb5-97e6-0e67099567a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a103ec2-1c63-4eb5-97e6-0e67099567a1', 18, NULL, 'B단조', '24 Progressive Lessons for Beginners, op. 31: No. 18 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a103ec2-1c63-4eb5-97e6-0e67099567a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 19 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76', 19, NULL, 'A장조', '24 Progressive Lessons for Beginners, op. 31: No. 19 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 20 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f', 20, NULL, 'A단조', '24 Progressive Lessons for Beginners, op. 31: No. 20 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'No. 21', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915', 21, NULL, 'No. 21', '24 Progressive Lessons for Beginners, op. 31: No. 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 22 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:546a4b32-0afd-457e-a26f-7cd4290baf66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:546a4b32-0afd-457e-a26f-7cd4290baf66', 22, NULL, 'B장조', '24 Progressive Lessons for Beginners, op. 31: No. 22 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:546a4b32-0afd-457e-a26f-7cd4290baf66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'in E major "Mouvement de prière religieuse"', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 23 in E major "Mouvement de prière religieuse"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:067e6c72-cfcf-447d-b7c0-cbc373822564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067e6c72-cfcf-447d-b7c0-cbc373822564', 23, NULL, 'in E major "Mouvement de prière religieuse"', '24 Progressive Lessons for Beginners, op. 31: No. 23 in E major "Mouvement de prière religieuse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067e6c72-cfcf-447d-b7c0-cbc373822564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'No. 24', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15764 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5efe2f4b-716c-4ce5-8757-217e0192bce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5efe2f4b-716c-4ce5-8757-217e0192bce9', 24, NULL, 'No. 24', '24 Progressive Lessons for Beginners, op. 31: No. 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15764 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5efe2f4b-716c-4ce5-8757-217e0192bce9'
);


-- Op. 60 25 Progressive Studies Op. 60

UPDATE pieces piece
SET piece.title = '25 Progressive Studies Op. 60', piece.title_en = '25 Progressive Studies, op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20071 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:874f6ac9-d69c-48aa-979f-42a1c18908a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874f6ac9-d69c-48aa-979f-42a1c18908a3', 1, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874f6ac9-d69c-48aa-979f-42a1c18908a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 2 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3de460a6-456c-4f30-b907-61815e3a13b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3de460a6-456c-4f30-b907-61815e3a13b8', 2, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3de460a6-456c-4f30-b907-61815e3a13b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 3 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a554c4ec-de8d-4080-853e-79bbd7f178b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a554c4ec-de8d-4080-853e-79bbd7f178b7', 3, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a554c4ec-de8d-4080-853e-79bbd7f178b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = '25 Progressive Studies, op. 60: No. 4 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:224373be-0c32-44c8-babd-e532c8ba201c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:224373be-0c32-44c8-babd-e532c8ba201c', 4, NULL, 'C단조', '25 Progressive Studies, op. 60: No. 4 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224373be-0c32-44c8-babd-e532c8ba201c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '25 Progressive Studies, op. 60: No. 5 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:96f48815-346a-4380-93fb-6e45e2eae063' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96f48815-346a-4380-93fb-6e45e2eae063', 5, NULL, 'A단조', '25 Progressive Studies, op. 60: No. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96f48815-346a-4380-93fb-6e45e2eae063'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 6 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c514959b-386a-4228-ac20-7e3cd47739e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c514959b-386a-4228-ac20-7e3cd47739e8', 6, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c514959b-386a-4228-ac20-7e3cd47739e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 7 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:df55c1e5-ebf3-49fa-ac23-5292886416d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df55c1e5-ebf3-49fa-ac23-5292886416d6', 7, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df55c1e5-ebf3-49fa-ac23-5292886416d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 8 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:50d0d376-c98a-48b5-a027-f976bb1bb502' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50d0d376-c98a-48b5-a027-f976bb1bb502', 8, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 8 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50d0d376-c98a-48b5-a027-f976bb1bb502'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 9 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5598135d-f756-4495-a641-649cd893975e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5598135d-f756-4495-a641-649cd893975e', 9, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 9 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5598135d-f756-4495-a641-649cd893975e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 10 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9b64f47a-40b2-4821-88ac-166072f302e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b64f47a-40b2-4821-88ac-166072f302e4', 10, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b64f47a-40b2-4821-88ac-166072f302e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '25 Progressive Studies, op. 60: No. 11 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3d3a0938-6143-4371-b710-d889f7c42a7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d3a0938-6143-4371-b710-d889f7c42a7f', 11, NULL, 'G장조', '25 Progressive Studies, op. 60: No. 11 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d3a0938-6143-4371-b710-d889f7c42a7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '25 Progressive Studies, op. 60: No. 12 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:56cdffef-61a2-4a56-96ae-25084d5ee892' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56cdffef-61a2-4a56-96ae-25084d5ee892', 12, NULL, 'G장조', '25 Progressive Studies, op. 60: No. 12 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56cdffef-61a2-4a56-96ae-25084d5ee892'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 13 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:06b3e70b-eab9-4235-904d-f6cdd10d7d34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b3e70b-eab9-4235-904d-f6cdd10d7d34', 13, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 13 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b3e70b-eab9-4235-904d-f6cdd10d7d34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '25 Progressive Studies, op. 60: No. 14 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c85f4f1e-9ecf-46ee-8b6f-194903f4a21a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c85f4f1e-9ecf-46ee-8b6f-194903f4a21a', 14, NULL, 'E단조', '25 Progressive Studies, op. 60: No. 14 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85f4f1e-9ecf-46ee-8b6f-194903f4a21a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = '25 Progressive Studies, op. 60: No. 15 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6c58d8c3-0563-4f6f-a4ee-c9413f1bbdff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c58d8c3-0563-4f6f-a4ee-c9413f1bbdff', 15, NULL, 'E장조', '25 Progressive Studies, op. 60: No. 15 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c58d8c3-0563-4f6f-a4ee-c9413f1bbdff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '25 Progressive Studies, op. 60: No. 16 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b4b1a624-268e-4723-9bf4-359777353447' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4b1a624-268e-4723-9bf4-359777353447', 16, NULL, 'G장조', '25 Progressive Studies, op. 60: No. 16 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b1a624-268e-4723-9bf4-359777353447'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 17 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1b39dffb-54a7-43b8-a2ff-0ab0de7054a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b39dffb-54a7-43b8-a2ff-0ab0de7054a1', 17, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 17 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b39dffb-54a7-43b8-a2ff-0ab0de7054a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '25 Progressive Studies, op. 60: No. 18 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:264fa507-1861-4e12-aa92-1e444385e07c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:264fa507-1861-4e12-aa92-1e444385e07c', 18, NULL, 'A단조', '25 Progressive Studies, op. 60: No. 18 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264fa507-1861-4e12-aa92-1e444385e07c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '25 Progressive Studies, op. 60: No. 19 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cf916699-9fa2-4ec4-a67b-16dc1b88e4bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf916699-9fa2-4ec4-a67b-16dc1b88e4bd', 19, NULL, 'G장조', '25 Progressive Studies, op. 60: No. 19 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf916699-9fa2-4ec4-a67b-16dc1b88e4bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '25 Progressive Studies, op. 60: No. 20 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:4c12cccd-b0fa-4d40-b5bc-4c74dd0e1f84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c12cccd-b0fa-4d40-b5bc-4c74dd0e1f84', 20, NULL, 'E단조', '25 Progressive Studies, op. 60: No. 20 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c12cccd-b0fa-4d40-b5bc-4c74dd0e1f84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '25 Progressive Studies, op. 60: No. 21 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:627302ee-5a2f-4d3b-8f66-8c26c51302c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:627302ee-5a2f-4d3b-8f66-8c26c51302c9', 21, NULL, 'C장조', '25 Progressive Studies, op. 60: No. 21 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:627302ee-5a2f-4d3b-8f66-8c26c51302c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '25 Progressive Studies, op. 60: No. 22 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:58385803-4da0-44a3-b84e-4b80176e903d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58385803-4da0-44a3-b84e-4b80176e903d', 22, NULL, 'E단조', '25 Progressive Studies, op. 60: No. 22 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58385803-4da0-44a3-b84e-4b80176e903d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '25 Progressive Studies, op. 60: No. 23 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d2cd19f8-77f9-478d-b4b4-4487fbfa729b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2cd19f8-77f9-478d-b4b4-4487fbfa729b', 23, NULL, 'A장조', '25 Progressive Studies, op. 60: No. 23 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2cd19f8-77f9-478d-b4b4-4487fbfa729b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '25 Progressive Studies, op. 60: No. 24 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f7f68cd3-6df4-41ee-bb7a-96ced0a95c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f68cd3-6df4-41ee-bb7a-96ced0a95c93', 24, NULL, 'D단조', '25 Progressive Studies, op. 60: No. 24 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f68cd3-6df4-41ee-bb7a-96ced0a95c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '25 Progressive Studies, op. 60: No. 25 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20071 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:70aba713-7a66-410a-9ea1-150f547f58bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70aba713-7a66-410a-9ea1-150f547f58bd', 25, NULL, 'D장조', '25 Progressive Studies, op. 60: No. 25 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20071 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70aba713-7a66-410a-9ea1-150f547f58bd'
);


-- Op. 36 3 Pièces de société Op. 36

UPDATE pieces piece
SET piece.title = '3 Pièces de société Op. 36', piece.title_en = '3 Pièces de société, op. 36',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '36',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16597 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tempo di minuetto', part.name_en = '3 Pièces de société, op. 36 no. 1a: Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3d5010dd-8867-48ea-970c-90f5dd080cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d5010dd-8867-48ea-970c-90f5dd080cbb', 1, NULL, 'Tempo di minuetto', '3 Pièces de société, op. 36 no. 1a: Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5010dd-8867-48ea-970c-90f5dd080cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allemande', part.name_en = '3 Pièces de société, op. 36 no. 1b: Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:053610e2-6074-4ad7-8e17-9eaee66e8884' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:053610e2-6074-4ad7-8e17-9eaee66e8884', 2, NULL, 'Allemande', '3 Pièces de société, op. 36 no. 1b: Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:053610e2-6074-4ad7-8e17-9eaee66e8884'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lento cantabile', part.name_en = '3 Pièces de société, op. 36 no. 2a: Lento cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e28841f6-1db3-499a-b724-1f372e7ee3b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e28841f6-1db3-499a-b724-1f372e7ee3b3', 3, NULL, 'Lento cantabile', '3 Pièces de société, op. 36 no. 2a: Lento cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28841f6-1db3-499a-b724-1f372e7ee3b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Minueto', part.name_en = '3 Pièces de société, op. 36 no. 2b: Minueto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dcf0bbcc-53e4-373e-bb2b-d86e481cb7ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf0bbcc-53e4-373e-bb2b-d86e481cb7ba', 4, NULL, 'Minueto', '3 Pièces de société, op. 36 no. 2b: Minueto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf0bbcc-53e4-373e-bb2b-d86e481cb7ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = '3 Pièces de société, op. 36 no. 3a: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fcc5dd4f-9cab-455c-a729-adac7cec6bca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc5dd4f-9cab-455c-a729-adac7cec6bca', 5, NULL, 'Andantino', '3 Pièces de société, op. 36 no. 3a: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc5dd4f-9cab-455c-a729-adac7cec6bca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegretto (Chasse)', part.name_en = '3 Pièces de société, op. 36 no. 3b: Allegretto (Chasse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16597 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c6343a89-bb13-4657-8f7f-5df03382c020' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6343a89-bb13-4657-8f7f-5df03382c020', 6, NULL, 'Allegretto (Chasse)', '3 Pièces de société, op. 36 no. 3b: Allegretto (Chasse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16597 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6343a89-bb13-4657-8f7f-5df03382c020'
);


-- Op. 45 6개의 소품 Op. 45

UPDATE pieces piece
SET piece.title = '6개의 소품 Op. 45', piece.title_en = '6 Pieces, op. 45',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '45',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18019 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = '6 Pieces, op. 45: No. 1. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a1564bb0-2160-4b12-b30b-743bf0006a35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1564bb0-2160-4b12-b30b-743bf0006a35', 1, NULL, 'Andantino', '6 Pieces, op. 45: No. 1. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1564bb0-2160-4b12-b30b-743bf0006a35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = '6 Pieces, op. 45: No. 2. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e72c2411-d86b-448f-bcea-1168819434ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e72c2411-d86b-448f-bcea-1168819434ae', 2, NULL, 'Allegretto', '6 Pieces, op. 45: No. 2. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e72c2411-d86b-448f-bcea-1168819434ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Theme and Variations', part.name_en = '6 Pieces, op. 45: No. 3. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1eff4cb2-06eb-4184-8c69-63f4a0845553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1eff4cb2-06eb-4184-8c69-63f4a0845553', 3, NULL, 'Theme and Variations', '6 Pieces, op. 45: No. 3. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eff4cb2-06eb-4184-8c69-63f4a0845553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = '6 Pieces, op. 45: No. 4. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fdd8495f-0e32-441f-b401-74ff77cd3e2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdd8495f-0e32-441f-b401-74ff77cd3e2c', 4, NULL, 'Valse', '6 Pieces, op. 45: No. 4. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdd8495f-0e32-441f-b401-74ff77cd3e2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = '6 Pieces, op. 45: No. 5. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:49f7d8ad-1769-44da-85ef-ce557bfb922f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f7d8ad-1769-44da-85ef-ce557bfb922f', 5, NULL, 'Andante', '6 Pieces, op. 45: No. 5. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f7d8ad-1769-44da-85ef-ce557bfb922f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = '6 Pieces, op. 45: No. 6. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18019 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f74b095a-afea-4912-9a65-9e83d179c6df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f74b095a-afea-4912-9a65-9e83d179c6df', 6, NULL, 'Valse', '6 Pieces, op. 45: No. 6. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18019 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f74b095a-afea-4912-9a65-9e83d179c6df'
);


-- Op. 32 6 Short Pieces Op. 32

UPDATE pieces piece
SET piece.title = '6 Short Pieces Op. 32', piece.title_en = '6 Short Pieces, op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19108 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino in E major', part.name_en = '6 Short Pieces, op. 32, no. 1: Andantino in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1143b1fc-756d-4178-a565-5dc6f50a6adf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1143b1fc-756d-4178-a565-5dc6f50a6adf', 1, NULL, 'Andantino in E major', '6 Short Pieces, op. 32, no. 1: Andantino in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1143b1fc-756d-4178-a565-5dc6f50a6adf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Waltz in E', part.name_en = '6 Short Pieces, op. 32, no. 2: Waltz in E',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ab364550-688f-45c0-884e-e512cf4adec9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab364550-688f-45c0-884e-e512cf4adec9', 2, NULL, 'Waltz in E', '6 Short Pieces, op. 32, no. 2: Waltz in E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab364550-688f-45c0-884e-e512cf4adec9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante pastorale in D', part.name_en = '6 Short Pieces, op. 32, no. 3: Andante pastorale in D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9b80d168-d4b0-493b-8446-324e8d33913a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b80d168-d4b0-493b-8446-324e8d33913a', 3, NULL, 'Andante pastorale in D', '6 Short Pieces, op. 32, no. 3: Andante pastorale in D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b80d168-d4b0-493b-8446-324e8d33913a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mazurka in D', part.name_en = '6 Short Pieces, op. 32, no. 4: Mazurka in D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e40f588a-49e8-4b71-8f0d-e54d9298cb40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e40f588a-49e8-4b71-8f0d-e54d9298cb40', 4, NULL, 'Mazurka in D', '6 Short Pieces, op. 32, no. 4: Mazurka in D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e40f588a-49e8-4b71-8f0d-e54d9298cb40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = '6 Short Pieces, op. 32, no. 5: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5ccc7c49-8553-4734-b65c-2252087bd355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ccc7c49-8553-4734-b65c-2252087bd355', 5, NULL, 'Andante', '6 Short Pieces, op. 32, no. 5: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ccc7c49-8553-4734-b65c-2252087bd355'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Galop in G', part.name_en = '6 Short Pieces, op. 32, no. 6: Galop in G',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19108 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8b4f02d5-1dc6-48b3-810b-923f883d60c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b4f02d5-1dc6-48b3-810b-923f883d60c4', 6, NULL, 'Galop in G', '6 Short Pieces, op. 32, no. 6: Galop in G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19108 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b4f02d5-1dc6-48b3-810b-923f883d60c4'
);


-- Op. 5 6 Short Pieces Op. 5

UPDATE pieces piece
SET piece.title = '6 Short Pieces Op. 5', piece.title_en = '6 Short Pieces, op. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '5',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18449 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Minuet', part.name_en = '6 Short Pieces, op. 5, no. 1: Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a5344fa4-8356-49cd-9aab-95750db8cfa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5344fa4-8356-49cd-9aab-95750db8cfa4', 1, NULL, 'Minuet', '6 Short Pieces, op. 5, no. 1: Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5344fa4-8356-49cd-9aab-95750db8cfa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = '6 Short Pieces, op. 5, no. 2: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:93a60a72-a651-4fc0-8a04-53cbd96a3140' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93a60a72-a651-4fc0-8a04-53cbd96a3140', 2, NULL, 'Waltz', '6 Short Pieces, op. 5, no. 2: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93a60a72-a651-4fc0-8a04-53cbd96a3140'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '6 Short Pieces, op. 5, no. 3: Minuet in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0e316c2a-b092-40ca-9e8e-8f03b564423b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e316c2a-b092-40ca-9e8e-8f03b564423b', 3, NULL, 'C장조', '6 Short Pieces, op. 5, no. 3: Minuet in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e316c2a-b092-40ca-9e8e-8f03b564423b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = '6 Short Pieces, op. 5, no. 4: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:18629219-fc9c-4795-84d5-beb05024a002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18629219-fc9c-4795-84d5-beb05024a002', 4, NULL, 'Allegro', '6 Short Pieces, op. 5, no. 4: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18629219-fc9c-4795-84d5-beb05024a002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante largo in D major', part.name_en = '6 Short Pieces, op. 5, no. 5: Andante largo in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:69bfccd8-08a2-4a6b-81fe-d2e0a0ea2e83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69bfccd8-08a2-4a6b-81fe-d2e0a0ea2e83', 5, NULL, 'Andante largo in D major', '6 Short Pieces, op. 5, no. 5: Andante largo in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69bfccd8-08a2-4a6b-81fe-d2e0a0ea2e83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'no. 6', part.name_en = '6 Short Pieces, op. 5, no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18449 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5d81c3af-a994-41b5-b17e-68000ea9e50e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d81c3af-a994-41b5-b17e-68000ea9e50e', 6, NULL, 'no. 6', '6 Short Pieces, op. 5, no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18449 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d81c3af-a994-41b5-b17e-68000ea9e50e'
);


-- None 6개의 바가텔 "Mes Ennuis"

UPDATE pieces piece
SET piece.title = '6개의 바가텔 "Mes Ennuis"', piece.title_en = '6 bagatelles, op. 43 "Mes Ennuis"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16983 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3e5f8b67-86d9-4270-9b30-8a2fe5beee4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e5f8b67-86d9-4270-9b30-8a2fe5beee4c', 1, 'I', 'Andante', '6 bagatelles, op. 43 "Mes Ennuis": I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5f8b67-86d9-4270-9b30-8a2fe5beee4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e82959ce-112b-4f86-807a-400d8c87e35e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e82959ce-112b-4f86-807a-400d8c87e35e', 2, 'II', 'Allegretto', '6 bagatelles, op. 43 "Mes Ennuis": II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e82959ce-112b-4f86-807a-400d8c87e35e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cantabile', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": III. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3a32ff28-fa75-4f41-90f9-8b0c862f809d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a32ff28-fa75-4f41-90f9-8b0c862f809d', 3, 'III', 'Cantabile', '6 bagatelles, op. 43 "Mes Ennuis": III. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a32ff28-fa75-4f41-90f9-8b0c862f809d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mazurka', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": IV. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:450e71c2-53c4-4a8e-894b-6e6972561f22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450e71c2-53c4-4a8e-894b-6e6972561f22', 4, 'IV', 'Mazurka', '6 bagatelles, op. 43 "Mes Ennuis": IV. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450e71c2-53c4-4a8e-894b-6e6972561f22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": V. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a3b768af-8fc8-43b1-89d7-d23cdef7257a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3b768af-8fc8-43b1-89d7-d23cdef7257a', 5, 'V', 'Andante', '6 bagatelles, op. 43 "Mes Ennuis": V. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b768af-8fc8-43b1-89d7-d23cdef7257a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Valse', part.name_en = '6 bagatelles, op. 43 "Mes Ennuis": VI. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16983 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cf4279eb-db78-4a3a-b62d-3e2088c46bc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf4279eb-db78-4a3a-b62d-3e2088c46bc3', 6, 'VI', 'Valse', '6 bagatelles, op. 43 "Mes Ennuis": VI. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16983 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf4279eb-db78-4a3a-b62d-3e2088c46bc3'
);


-- Op. 8 6 divertissements

UPDATE pieces piece
SET piece.title = '6 divertissements', piece.title_en = '6 divertissements, op. 8',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18689 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A conquistar tu plaza

UPDATE pieces piece
SET piece.title = 'A conquistar tu plaza', piece.title_en = 'A conquistar tu plaza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19698 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air varié, WoO

UPDATE pieces piece
SET piece.title = 'Air varié, WoO', piece.title_en = 'Air varié, WoO',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19077 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Al mediator jugando

UPDATE pieces piece
SET piece.title = 'Al mediator jugando', piece.title_en = 'Al mediator jugando',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17243 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante expressivo for guitar

UPDATE pieces piece
SET piece.title = 'Andante expressivo for guitar', piece.title_en = 'Andante expressivo for guitar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18510 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante maestoso for guitar

UPDATE pieces piece
SET piece.title = 'Andante maestoso for guitar', piece.title_en = 'Andante maestoso for guitar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19632 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Appel des nègres aux Français>

UPDATE pieces piece
SET piece.title = '가곡 <Appel des nègres aux Français>', piece.title_en = 'Appel des nègres aux Français',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17789 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ausente de mi dueño

UPDATE pieces piece
SET piece.title = 'Ausente de mi dueño', piece.title_en = 'Ausente de mi dueño',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18531 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Boleras del Caramba

UPDATE pieces piece
SET piece.title = 'Boleras del Caramba', piece.title_en = 'Boleras del Caramba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16368 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Cendrillon>

UPDATE pieces piece
SET piece.title = '발레 <Cendrillon>', piece.title_en = 'Cendrillon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19501 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 Divertissement militaire

UPDATE pieces piece
SET piece.title = 'Divertissement militaire', piece.title_en = 'Divertissement militaire, op. 49',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20041 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Divertissement militaire, op. 49: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20041 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3e5eaff8-6273-43a2-9d09-ef1e84f43dd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e5eaff8-6273-43a2-9d09-ef1e84f43dd3', 1, 'I', 'Andante', 'Divertissement militaire, op. 49: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20041 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5eaff8-6273-43a2-9d09-ef1e84f43dd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marche, trio, marche', part.name_en = 'Divertissement militaire, op. 49: II. Marche, trio, marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20041 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:74a9717d-5ebb-4c05-85e7-ef0f4bc2f939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74a9717d-5ebb-4c05-85e7-ef0f4bc2f939', 2, 'II', 'Marche, trio, marche', 'Divertissement militaire, op. 49: II. Marche, trio, marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20041 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74a9717d-5ebb-4c05-85e7-ef0f4bc2f939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto (Trompette)', part.name_en = 'Divertissement militaire, op. 49: III. Allegretto (Trompette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20041 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:621bad6f-15e2-438f-a437-64aac78c6d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:621bad6f-15e2-438f-a437-64aac78c6d2d', 3, 'III', 'Allegretto (Trompette)', 'Divertissement militaire, op. 49: III. Allegretto (Trompette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20041 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621bad6f-15e2-438f-a437-64aac78c6d2d'
);


-- Op. 23 Divertissement

UPDATE pieces piece
SET piece.title = 'Divertissement', piece.title_en = 'Divertissement, op. 23',
    piece.type = 'album', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19316 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Valse', part.name_en = 'Divertissement, op. 23: I. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2696cfce-fa76-4b08-b096-f353d9b4d90e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2696cfce-fa76-4b08-b096-f353d9b4d90e', 1, 'I', 'Valse', 'Divertissement, op. 23: I. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2696cfce-fa76-4b08-b096-f353d9b4d90e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Divertissement, op. 23: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b7f78509-95ac-45b4-baf2-98425a1efe04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7f78509-95ac-45b4-baf2-98425a1efe04', 2, 'II', 'Allegretto', 'Divertissement, op. 23: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7f78509-95ac-45b4-baf2-98425a1efe04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Valse', part.name_en = 'Divertissement, op. 23: III. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e262e7a5-c2c6-495e-9df1-db809779fe52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e262e7a5-c2c6-495e-9df1-db809779fe52', 3, 'III', 'Valse', 'Divertissement, op. 23: III. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e262e7a5-c2c6-495e-9df1-db809779fe52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'Divertissement, op. 23: IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:02fa5968-d7a3-4e16-8d17-10a3a83600d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02fa5968-d7a3-4e16-8d17-10a3a83600d1', 4, 'IV', 'Allegretto', 'Divertissement, op. 23: IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02fa5968-d7a3-4e16-8d17-10a3a83600d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante', part.name_en = 'Divertissement, op. 23: V. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cc97c410-c832-447d-ac55-200474273570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc97c410-c832-447d-ac55-200474273570', 5, 'V', 'Andante', 'Divertissement, op. 23: V. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc97c410-c832-447d-ac55-200474273570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Andante', part.name_en = 'Divertissement, op. 23: VI. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b624c2a3-5cd6-498f-904a-4793baf50cc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b624c2a3-5cd6-498f-904a-4793baf50cc3', 6, 'VI', 'Andante', 'Divertissement, op. 23: VI. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b624c2a3-5cd6-498f-904a-4793baf50cc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Valse', part.name_en = 'Divertissement, op. 23: VII. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:43a18c32-101a-478e-af8b-63c5e0870e0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43a18c32-101a-478e-af8b-63c5e0870e0f', 7, 'VII', 'Valse', 'Divertissement, op. 23: VII. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43a18c32-101a-478e-af8b-63c5e0870e0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Allemande', part.name_en = 'Divertissement, op. 23: VIII. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bf5c6b27-34ad-4db0-8f5f-e5ea2023efe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf5c6b27-34ad-4db0-8f5f-e5ea2023efe5', 8, 'VIII', 'Allemande', 'Divertissement, op. 23: VIII. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf5c6b27-34ad-4db0-8f5f-e5ea2023efe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Minuetto', part.name_en = 'Divertissement, op. 23: IX. Minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:09cd83ee-8551-4bd3-a945-d9ceac0edef1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09cd83ee-8551-4bd3-a945-d9ceac0edef1', 9, 'IX', 'Minuetto', 'Divertissement, op. 23: IX. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09cd83ee-8551-4bd3-a945-d9ceac0edef1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Valse', part.name_en = 'Divertissement, op. 23: X. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19316 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dd51b6ff-9511-4802-a389-6c9538a232c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd51b6ff-9511-4802-a389-6c9538a232c3', 10, 'X', 'Valse', 'Divertissement, op. 23: X. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19316 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd51b6ff-9511-4802-a389-6c9538a232c3'
);


-- Op. 38 Divertissement Op. 38

UPDATE pieces piece
SET piece.title = 'Divertissement Op. 38', piece.title_en = 'Divertissement, op. 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '38',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17347 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato, andantino', part.name_en = 'Divertissement, op. 38: I. Andante moderato, andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17347 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dbc29ba5-5816-415b-a464-54e00baae142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc29ba5-5816-415b-a464-54e00baae142', 1, 'I', 'Andante moderato, andantino', 'Divertissement, op. 38: I. Andante moderato, andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17347 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc29ba5-5816-415b-a464-54e00baae142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Valse', part.name_en = 'Divertissement, op. 38: II. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17347 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:dcba0a8d-e39f-4953-bbac-0d9179e84317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcba0a8d-e39f-4953-bbac-0d9179e84317', 2, 'II', 'Valse', 'Divertissement, op. 38: II. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17347 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcba0a8d-e39f-4953-bbac-0d9179e84317'
);


-- Op. 62 Divertissement Op. 62

UPDATE pieces piece
SET piece.title = 'Divertissement Op. 62', piece.title_en = 'Divertissement, op. 62',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '62',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17510 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino cantabile', part.name_en = 'Divertissement, op. 62: I. Andantino cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17510 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0c50141d-0421-40b0-a44c-2d7237357dc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c50141d-0421-40b0-a44c-2d7237357dc4', 1, 'I', 'Andantino cantabile', 'Divertissement, op. 62: I. Andantino cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17510 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c50141d-0421-40b0-a44c-2d7237357dc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mouvement de polonaise', part.name_en = 'Divertissement, op. 62: II. Mouvement de polonaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17510 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9873feda-25d8-4293-acc9-c4098063ed95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9873feda-25d8-4293-acc9-c4098063ed95', 2, 'II', 'Mouvement de polonaise', 'Divertissement, op. 62: II. Mouvement de polonaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17510 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9873feda-25d8-4293-acc9-c4098063ed95'
);


-- Op. 34 2중창 "encouragement"

UPDATE pieces piece
SET piece.title = '2중창 "encouragement"', piece.title_en = 'Duet for guitars "L''encouragement", op. 34',
    piece.type = 'album', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19253 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cantabile', part.name_en = 'Duet for guitars "L''encouragement", op. 34: I. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19253 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:72d854d6-51bb-4c57-ab90-579349f22b52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d854d6-51bb-4c57-ab90-579349f22b52', 1, 'I', 'Cantabile', 'Duet for guitars "L''encouragement", op. 34: I. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19253 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d854d6-51bb-4c57-ab90-579349f22b52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Theme and Variations: Andantino', part.name_en = 'Duet for guitars "L''encouragement", op. 34: II. Theme and Variations: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19253 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:98cd3522-39a4-4994-9af0-43e7c1e18bcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cd3522-39a4-4994-9af0-43e7c1e18bcb', 2, 'II', 'Theme and Variations: Andantino', 'Duet for guitars "L''encouragement", op. 34: II. Theme and Variations: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19253 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cd3522-39a4-4994-9af0-43e7c1e18bcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Valse', part.name_en = 'Duet for guitars "L''encouragement", op. 34: III. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19253 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7e471da3-8e6b-4d19-b04e-7125f9d81889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e471da3-8e6b-4d19-b04e-7125f9d81889', 3, 'III', 'Valse', 'Duet for guitars "L''encouragement", op. 34: III. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19253 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e471da3-8e6b-4d19-b04e-7125f9d81889'
);


-- Op. 24 Eight Small Pieces

UPDATE pieces piece
SET piece.title = 'Eight Small Pieces', piece.title_en = 'Eight Small Pieces, op. 24',
    piece.type = 'album', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15835 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Menuet. Andantino lento', part.name_en = 'Eight Small Pieces, op. 24: I. Menuet. Andantino lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a075bf97-bffc-40ba-a85c-24b5505e49b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a075bf97-bffc-40ba-a85c-24b5505e49b0', 1, 'I', 'Menuet. Andantino lento', 'Eight Small Pieces, op. 24: I. Menuet. Andantino lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a075bf97-bffc-40ba-a85c-24b5505e49b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Menuet', part.name_en = 'Eight Small Pieces, op. 24: II. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:aaf0cb6c-1b1a-4ed3-93af-52774b9bf633' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaf0cb6c-1b1a-4ed3-93af-52774b9bf633', 2, 'II', 'Menuet', 'Eight Small Pieces, op. 24: II. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaf0cb6c-1b1a-4ed3-93af-52774b9bf633'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Eight Small Pieces, op. 24: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b1af7ee1-96b2-4ada-9924-f52ce6537c62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1af7ee1-96b2-4ada-9924-f52ce6537c62', 3, 'III', 'Allegretto', 'Eight Small Pieces, op. 24: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1af7ee1-96b2-4ada-9924-f52ce6537c62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Menuet. Andante', part.name_en = 'Eight Small Pieces, op. 24: IV. Menuet. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b0efa2fb-6043-4c67-bc8c-364d94a6ecab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0efa2fb-6043-4c67-bc8c-364d94a6ecab', 4, 'IV', 'Menuet. Andante', 'Eight Small Pieces, op. 24: IV. Menuet. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0efa2fb-6043-4c67-bc8c-364d94a6ecab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Menuet. Andante', part.name_en = 'Eight Small Pieces, op. 24: V. Menuet. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8dd46608-7f70-4e7d-8524-b9c15798c3d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dd46608-7f70-4e7d-8524-b9c15798c3d7', 5, 'V', 'Menuet. Andante', 'Eight Small Pieces, op. 24: V. Menuet. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd46608-7f70-4e7d-8524-b9c15798c3d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Menuet. Andante', part.name_en = 'Eight Small Pieces, op. 24: VI. Menuet. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5f755b00-7d76-4be2-ac49-57671c50dc0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f755b00-7d76-4be2-ac49-57671c50dc0f', 6, 'VI', 'Menuet. Andante', 'Eight Small Pieces, op. 24: VI. Menuet. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f755b00-7d76-4be2-ac49-57671c50dc0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegretto', part.name_en = 'Eight Small Pieces, op. 24: VII. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fc1aaabb-47b5-44aa-8ac3-8d9b3394aa44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1aaabb-47b5-44aa-8ac3-8d9b3394aa44', 7, 'VII', 'Allegretto', 'Eight Small Pieces, op. 24: VII. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1aaabb-47b5-44aa-8ac3-8d9b3394aa44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Menuet. Andante', part.name_en = 'Eight Small Pieces, op. 24: VIII. Menuet. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15835 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:de8dc270-dca8-4bea-bc97-5a236a0f512b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de8dc270-dca8-4bea-bc97-5a236a0f512b', 8, 'VIII', 'Menuet. Andante', 'Eight Small Pieces, op. 24: VIII. Menuet. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15835 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de8dc270-dca8-4bea-bc97-5a236a0f512b'
);


-- Op. 48 Est ce bien ça? Op. 48

UPDATE pieces piece
SET piece.title = 'Est ce bien ça? Op. 48', piece.title_en = 'Est ce bien ça?, op. 48',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '48',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18609 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Marche', part.name_en = 'Est ce bien ça?, op. 48 no. 1: Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:cb80e5ca-bbdc-44ea-a809-531e3b29fc9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb80e5ca-bbdc-44ea-a809-531e3b29fc9b', 1, NULL, 'Marche', 'Est ce bien ça?, op. 48 no. 1: Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb80e5ca-bbdc-44ea-a809-531e3b29fc9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = 'Est ce bien ça?, op. 48 no. 2: Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1a30fc87-eb05-4861-8411-91f243ffb584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a30fc87-eb05-4861-8411-91f243ffb584', 2, NULL, 'Valse', 'Est ce bien ça?, op. 48 no. 2: Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a30fc87-eb05-4861-8411-91f243ffb584'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Menuet avec variations', part.name_en = 'Est ce bien ça?, op. 48 no. 3: Menuet avec variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c008c206-02fb-4893-911d-b6aba6e88da6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c008c206-02fb-4893-911d-b6aba6e88da6', 3, NULL, 'Menuet avec variations', 'Est ce bien ça?, op. 48 no. 3: Menuet avec variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c008c206-02fb-4893-911d-b6aba6e88da6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = 'Est ce bien ça?, op. 48 no. 4: Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8ef2b217-ac9d-4566-9c36-b7f27d442a12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ef2b217-ac9d-4566-9c36-b7f27d442a12', 4, NULL, 'Valse', 'Est ce bien ça?, op. 48 no. 4: Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ef2b217-ac9d-4566-9c36-b7f27d442a12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Est ce bien ça?, op. 48 no. 5', part.name_en = 'Est ce bien ça?, op. 48 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:76248cb7-2fce-4e99-82ac-ef1a801740f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76248cb7-2fce-4e99-82ac-ef1a801740f6', 5, NULL, 'Est ce bien ça?, op. 48 no. 5', 'Est ce bien ça?, op. 48 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76248cb7-2fce-4e99-82ac-ef1a801740f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rondeau', part.name_en = 'Est ce bien ça?, op. 48 no. 6: Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18609 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:48afe87d-8492-40c2-bc59-32b3eebde5e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48afe87d-8492-40c2-bc59-32b3eebde5e8', 6, NULL, 'Rondeau', 'Est ce bien ça?, op. 48 no. 6: Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18609 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48afe87d-8492-40c2-bc59-32b3eebde5e8'
);


-- None Estudio 19 en Si Menor

UPDATE pieces piece
SET piece.title = 'Estudio 19 en Si Menor', piece.title_en = 'Estudio 19 en Si Menor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17924 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Estudio V

UPDATE pieces piece
SET piece.title = 'Estudio V', piece.title_en = 'Estudio V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16405 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Estudio XII

UPDATE pieces piece
SET piece.title = 'Estudio XII', piece.title_en = 'Estudio XII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18576 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 Fantaisie et variations sur un air écossais

UPDATE pieces piece
SET piece.title = 'Fantaisie et variations sur un air écossais', piece.title_en = 'Fantaisie et variations sur un air écossais, op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18035 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantaisie pour guitare seule

UPDATE pieces piece
SET piece.title = 'Fantaisie pour guitare seule', piece.title_en = 'Fantaisie pour guitare seule',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18738 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante largo', part.name_en = 'Fantaisie pour guitare seule: I. Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18738 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2f12f2fe-cbbc-43aa-a6ba-df0d99ebed36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f12f2fe-cbbc-43aa-a6ba-df0d99ebed36', 1, 'I', 'Andante largo', 'Fantaisie pour guitare seule: I. Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18738 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f12f2fe-cbbc-43aa-a6ba-df0d99ebed36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Fantaisie pour guitare seule: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18738 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:25c5ef69-7175-4de2-ae05-4b6c69cf217a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c5ef69-7175-4de2-ae05-4b6c69cf217a', 2, 'II', 'Andantino', 'Fantaisie pour guitare seule: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18738 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c5ef69-7175-4de2-ae05-4b6c69cf217a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto vivace', part.name_en = 'Fantaisie pour guitare seule: III. Allegretto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18738 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:943b21d0-b373-4eaf-8bd1-caf3da9ccd1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943b21d0-b373-4eaf-8bd1-caf3da9ccd1a', 3, 'III', 'Allegretto vivace', 'Fantaisie pour guitare seule: III. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18738 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943b21d0-b373-4eaf-8bd1-caf3da9ccd1a'
);


-- Op. 58 Fantaisie pour guitare seule Op. 58

UPDATE pieces piece
SET piece.title = 'Fantaisie pour guitare seule Op. 58', piece.title_en = 'Fantaisie pour guitare seule, op. 58',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '58',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18535 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction: Andante largo', part.name_en = 'Fantaisie pour guitare seule, op. 58: I. Introduction: Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18535 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:955e8ddc-43ae-40a1-abf6-6f75da3fe1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:955e8ddc-43ae-40a1-abf6-6f75da3fe1a2', 1, 'I', 'Introduction: Andante largo', 'Fantaisie pour guitare seule, op. 58: I. Introduction: Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18535 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955e8ddc-43ae-40a1-abf6-6f75da3fe1a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Fantaisie pour guitare seule, op. 58: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18535 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b6a1cf9f-4386-4948-9b39-9f7489545005' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6a1cf9f-4386-4948-9b39-9f7489545005', 2, 'II', 'Andante', 'Fantaisie pour guitare seule, op. 58: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18535 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a1cf9f-4386-4948-9b39-9f7489545005'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mouvement de valse', part.name_en = 'Fantaisie pour guitare seule, op. 58: III. Mouvement de valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18535 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:394de74f-3a1b-4681-aa6e-6025973cc0fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:394de74f-3a1b-4681-aa6e-6025973cc0fb', 3, 'III', 'Mouvement de valse', 'Fantaisie pour guitare seule, op. 58: III. Mouvement de valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18535 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:394de74f-3a1b-4681-aa6e-6025973cc0fb'
);


-- Op. 52 Fantaisie villageoise

UPDATE pieces piece
SET piece.title = 'Fantaisie villageoise', piece.title_en = 'Fantaisie villageoise, op. 52',
    piece.type = 'album', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19243 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'Fantaisie villageoise, op. 52: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19243 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:da68184f-81d8-403c-ad4b-2aa62570ea9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da68184f-81d8-403c-ad4b-2aa62570ea9b', 1, 'I', 'Andantino', 'Fantaisie villageoise, op. 52: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19243 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da68184f-81d8-403c-ad4b-2aa62570ea9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Appel', part.name_en = 'Fantaisie villageoise, op. 52: II. Appel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19243 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:06dec3e2-06f7-4c65-a40c-87f6df7c8a5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06dec3e2-06f7-4c65-a40c-87f6df7c8a5a', 2, 'II', 'Appel', 'Fantaisie villageoise, op. 52: II. Appel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19243 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06dec3e2-06f7-4c65-a40c-87f6df7c8a5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse. Allegro', part.name_en = 'Fantaisie villageoise, op. 52: III. Danse. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19243 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c0fe8ae6-0e9b-4c1b-8c63-7db254d54bd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0fe8ae6-0e9b-4c1b-8c63-7db254d54bd2', 3, 'III', 'Danse. Allegro', 'Fantaisie villageoise, op. 52: III. Danse. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19243 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0fe8ae6-0e9b-4c1b-8c63-7db254d54bd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prière', part.name_en = 'Fantaisie villageoise, op. 52: IV. Prière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19243 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:22a8d400-eb6d-4269-add3-27dd91673158' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22a8d400-eb6d-4269-add3-27dd91673158', 4, 'IV', 'Prière', 'Fantaisie villageoise, op. 52: IV. Prière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19243 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22a8d400-eb6d-4269-add3-27dd91673158'
);


-- Op. 59 Fantaisie élégiaque

UPDATE pieces piece
SET piece.title = 'Fantaisie élégiaque', piece.title_en = 'Fantaisie élégiaque, op. 59',
    piece.type = 'album', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17873 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction: Andante largo', part.name_en = 'Fantaisie élégiaque, op. 59: I. Introduction: Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17873 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bd53c5b7-9d2f-4eee-890a-96592cb8b4e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd53c5b7-9d2f-4eee-890a-96592cb8b4e6', 1, 'I', 'Introduction: Andante largo', 'Fantaisie élégiaque, op. 59: I. Introduction: Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17873 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd53c5b7-9d2f-4eee-890a-96592cb8b4e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marche funebre: Andante moderato', part.name_en = 'Fantaisie élégiaque, op. 59: II. Marche funebre: Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17873 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:de8fb312-f019-4d27-affa-0815060bb541' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de8fb312-f019-4d27-affa-0815060bb541', 2, 'II', 'Marche funebre: Andante moderato', 'Fantaisie élégiaque, op. 59: II. Marche funebre: Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17873 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de8fb312-f019-4d27-affa-0815060bb541'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cantabile', part.name_en = 'Fantaisie élégiaque, op. 59: III. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17873 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a867b8cd-e1c9-4b58-88e6-96c5dbff2b44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a867b8cd-e1c9-4b58-88e6-96c5dbff2b44', 3, 'III', 'Cantabile', 'Fantaisie élégiaque, op. 59: III. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17873 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a867b8cd-e1c9-4b58-88e6-96c5dbff2b44'
);


-- Op. 30 환상곡

UPDATE pieces piece
SET piece.title = '환상곡', piece.title_en = 'Fantaisie, op. 30',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16563 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 환상곡 "Les Deux amis"

UPDATE pieces piece
SET piece.title = '환상곡 "Les Deux amis"', piece.title_en = 'Fantaisie, op. 41 "Les Deux amis"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16856 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Largo', part.name_en = 'Fantaisie, op. 41 "Les Deux amis": I. Andante - Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16856 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:91a52374-9449-4e93-9acc-29fb4365df07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91a52374-9449-4e93-9acc-29fb4365df07', 1, 'I', 'Andante - Largo', 'Fantaisie, op. 41 "Les Deux amis": I. Andante - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16856 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91a52374-9449-4e93-9acc-29fb4365df07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tema e variazioni', part.name_en = 'Fantaisie, op. 41 "Les Deux amis": II. Tema e variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16856 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:48fe1d4d-b611-495f-9f2e-6e43d7e66977' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48fe1d4d-b611-495f-9f2e-6e43d7e66977', 2, 'II', 'Tema e variazioni', 'Fantaisie, op. 41 "Les Deux amis": II. Tema e variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16856 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48fe1d4d-b611-495f-9f2e-6e43d7e66977'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mazurka', part.name_en = 'Fantaisie, op. 41 "Les Deux amis": III. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16856 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b6115396-3a3a-4165-83cf-01195d86ea65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6115396-3a3a-4165-83cf-01195d86ea65', 3, 'III', 'Mazurka', 'Fantaisie, op. 41 "Les Deux amis": III. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16856 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6115396-3a3a-4165-83cf-01195d86ea65'
);


-- None 환상곡 "Souvenir d"

UPDATE pieces piece
SET piece.title = '환상곡 "Souvenir d"', piece.title_en = 'Fantaisie, op. 46 "Souvenir d''amitié"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18818 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54b 환상곡 Op. 54b

UPDATE pieces piece
SET piece.title = '환상곡 Op. 54b', piece.title_en = 'Fantaisie, op. 54b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '54b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16702 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante allegro, andantino', part.name_en = 'Fantaisie, op. 54b: I. Andante allegro, andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16702 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:600887f5-f36b-42e9-8964-3751fbe118e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600887f5-f36b-42e9-8964-3751fbe118e0', 1, 'I', 'Andante allegro, andantino', 'Fantaisie, op. 54b: I. Andante allegro, andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16702 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600887f5-f36b-42e9-8964-3751fbe118e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro dans le genre espagnol', part.name_en = 'Fantaisie, op. 54b: II. Allegro dans le genre espagnol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16702 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5781aecd-fa11-44b4-958e-8f159ce76890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5781aecd-fa11-44b4-958e-8f159ce76890', 2, 'II', 'Allegro dans le genre espagnol', 'Fantaisie, op. 54b: II. Allegro dans le genre espagnol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16702 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5781aecd-fa11-44b4-958e-8f159ce76890'
);


-- None 환상곡 "Souvenirs d"

UPDATE pieces piece
SET piece.title = '환상곡 "Souvenirs d"', piece.title_en = 'Fantaisie, op. 56 "Souvenirs d''une soirée à Berlin"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18415 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 환상곡 "Souvenir de Russie"

UPDATE pieces piece
SET piece.title = '환상곡 "Souvenir de Russie"', piece.title_en = 'Fantaisie, op. 63 "Souvenir de Russie"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17906 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction: Andante moderato', part.name_en = 'Fantaisie, op. 63 "Souvenir de Russie": I. Introduction: Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17906 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fbe7d265-abb5-43c9-a09a-17a4e581d548' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbe7d265-abb5-43c9-a09a-17a4e581d548', 1, 'I', 'Introduction: Andante moderato', 'Fantaisie, op. 63 "Souvenir de Russie": I. Introduction: Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17906 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbe7d265-abb5-43c9-a09a-17a4e581d548'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Theme and Variations', part.name_en = 'Fantaisie, op. 63 "Souvenir de Russie": II. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17906 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:59be4042-e840-4774-b49b-1b19d7c6e52f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59be4042-e840-4774-b49b-1b19d7c6e52f', 2, 'II', 'Theme and Variations', 'Fantaisie, op. 63 "Souvenir de Russie": II. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17906 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59be4042-e840-4774-b49b-1b19d7c6e52f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Fantaisie, op. 63 "Souvenir de Russie": III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17906 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:38d7bf06-21ad-4500-b964-7c0e47018d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38d7bf06-21ad-4500-b964-7c0e47018d2d', 3, 'III', 'Allegretto', 'Fantaisie, op. 63 "Souvenir de Russie": III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17906 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38d7bf06-21ad-4500-b964-7c0e47018d2d'
);


-- Op. 7 환상곡 C단조

UPDATE pieces piece
SET piece.title = '환상곡 C단조', piece.title_en = 'Fantasia in C minor, op. 7',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17605 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Fantasia in C minor, op. 7: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17605 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2bd0ecdc-d14f-4793-b1ec-5ff32387de31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bd0ecdc-d14f-4793-b1ec-5ff32387de31', 1, 'I', 'Largo', 'Fantasia in C minor, op. 7: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17605 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bd0ecdc-d14f-4793-b1ec-5ff32387de31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Theme and Variations', part.name_en = 'Fantasia in C minor, op. 7: II. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17605 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ceda2891-6df4-455b-ba2f-225fa037aa9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceda2891-6df4-455b-ba2f-225fa037aa9d', 2, 'II', 'Theme and Variations', 'Fantasia in C minor, op. 7: II. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17605 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceda2891-6df4-455b-ba2f-225fa037aa9d'
);


-- Op. 4 환상곡 2번

UPDATE pieces piece
SET piece.title = '환상곡 2번', piece.title_en = 'Fantasie no. 2, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16519 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduzione: Andante largo', part.name_en = 'Fantasie no. 2, op. 4: I. Introduzione: Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16519 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7295a2ca-94e4-4358-88c2-4cdcec55f2cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7295a2ca-94e4-4358-88c2-4cdcec55f2cb', 1, 'I', 'Introduzione: Andante largo', 'Fantasie no. 2, op. 4: I. Introduzione: Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16519 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7295a2ca-94e4-4358-88c2-4cdcec55f2cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rondo: Allegretto', part.name_en = 'Fantasie no. 2, op. 4: II. Rondo: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16519 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ca2b7744-aef1-4ada-883f-b48ebcbba860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca2b7744-aef1-4ada-883f-b48ebcbba860', 2, 'II', 'Rondo: Allegretto', 'Fantasie no. 2, op. 4: II. Rondo: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16519 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca2b7744-aef1-4ada-883f-b48ebcbba860'
);


-- Op. 10 환상곡 3번

UPDATE pieces piece
SET piece.title = '환상곡 3번', piece.title_en = 'Fantasie no. 3, op. 10',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15779 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante largo', part.name_en = 'Fantasie no. 3, op. 10: I. Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15779 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d96f4d55-bef3-462f-9ccd-d1fa0ccf8b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d96f4d55-bef3-462f-9ccd-d1fa0ccf8b4e', 1, 'I', 'Andante largo', 'Fantasie no. 3, op. 10: I. Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15779 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d96f4d55-bef3-462f-9ccd-d1fa0ccf8b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Thème avec variations', part.name_en = 'Fantasie no. 3, op. 10: II. Thème avec variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15779 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:80290499-9359-4aa9-af00-3ddec71b12ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80290499-9359-4aa9-af00-3ddec71b12ad', 2, 'II', 'Thème avec variations', 'Fantasie no. 3, op. 10: II. Thème avec variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15779 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80290499-9359-4aa9-af00-3ddec71b12ad'
);


-- Op. 12 환상곡 4번

UPDATE pieces piece
SET piece.title = '환상곡 4번', piece.title_en = 'Fantasie no. 4, op. 12',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18778 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction. Larghetto cantabile', part.name_en = 'Fantasie no. 4, op. 12: I. Introduction. Larghetto cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18778 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1ff1c761-f412-46f3-8f10-650df70d5d28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ff1c761-f412-46f3-8f10-650df70d5d28', 1, 'I', 'Introduction. Larghetto cantabile', 'Fantasie no. 4, op. 12: I. Introduction. Larghetto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18778 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ff1c761-f412-46f3-8f10-650df70d5d28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Thème avec variations', part.name_en = 'Fantasie no. 4, op. 12: II. Thème avec variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18778 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:fe48d3d9-6de2-42ca-822d-c1f737f648ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe48d3d9-6de2-42ca-822d-c1f737f648ba', 2, 'II', 'Thème avec variations', 'Fantasie no. 4, op. 12: II. Thème avec variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18778 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe48d3d9-6de2-42ca-822d-c1f737f648ba'
);


-- None Favores ni desprecios

UPDATE pieces piece
SET piece.title = 'Favores ni desprecios', piece.title_en = 'Favores ni desprecios',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17386 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Grand Solo

UPDATE pieces piece
SET piece.title = 'Grand Solo', piece.title_en = 'Grand Solo, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20079 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Grand Solo, op. 14: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20079 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3abce200-10cd-47ee-9caf-1b34aaf263c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3abce200-10cd-47ee-9caf-1b34aaf263c7', 1, 'I', 'Introduction', 'Grand Solo, op. 14: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20079 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3abce200-10cd-47ee-9caf-1b34aaf263c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Grand Solo, op. 14: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20079 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:701dafde-7c14-47b0-b6c4-3db704e1e9b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:701dafde-7c14-47b0-b6c4-3db704e1e9b6', 2, 'II', 'Allegro', 'Grand Solo, op. 14: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20079 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:701dafde-7c14-47b0-b6c4-3db704e1e9b6'
);


-- Op. 22 Grande Sonate in C major

UPDATE pieces piece
SET piece.title = 'Grande Sonate in C major', piece.title_en = 'Grande Sonate in C major, op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16863 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Grande Sonate in C major, op. 22: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16863 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:02ae5859-6d3c-4f02-9ba1-7cd0c2604c85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02ae5859-6d3c-4f02-9ba1-7cd0c2604c85', 1, 'I', 'Allegro', 'Grande Sonate in C major, op. 22: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16863 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02ae5859-6d3c-4f02-9ba1-7cd0c2604c85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Grande Sonate in C major, op. 22: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16863 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0473bba8-0542-44d4-84f7-ec037b045fc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0473bba8-0542-44d4-84f7-ec037b045fc0', 2, 'II', 'Adagio', 'Grande Sonate in C major, op. 22: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16863 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0473bba8-0542-44d4-84f7-ec037b045fc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuetto. Allegro', part.name_en = 'Grande Sonate in C major, op. 22: III. Minuetto. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16863 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c566bd96-54d7-48c5-866c-af19c1deef6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c566bd96-54d7-48c5-866c-af19c1deef6f', 3, 'III', 'Minuetto. Allegro', 'Grande Sonate in C major, op. 22: III. Minuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16863 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c566bd96-54d7-48c5-866c-af19c1deef6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo. Allegretto', part.name_en = 'Grande Sonate in C major, op. 22: IV. Rondo. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16863 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:88997152-3a4f-4535-a322-7ad86ce6b3f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88997152-3a4f-4535-a322-7ad86ce6b3f0', 4, 'IV', 'Rondo. Allegretto', 'Grande Sonate in C major, op. 22: IV. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16863 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88997152-3a4f-4535-a322-7ad86ce6b3f0'
);


-- Op. 25 Grande Sonate in C major Op. 25

UPDATE pieces piece
SET piece.title = 'Grande Sonate in C major Op. 25', piece.title_en = 'Grande Sonate in C major, op. 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '25',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17469 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante largo', part.name_en = 'Grande Sonate in C major, op. 25: I. Andante largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17469 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7797c74f-7fcc-4741-b815-6ab010fa103a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7797c74f-7fcc-4741-b815-6ab010fa103a', 1, 'I', 'Andante largo', 'Grande Sonate in C major, op. 25: I. Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17469 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7797c74f-7fcc-4741-b815-6ab010fa103a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Grande Sonate in C major, op. 25: II. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17469 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:64c9a8db-4669-47a7-816d-c487d3923058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64c9a8db-4669-47a7-816d-c487d3923058', 2, 'II', 'Allegro non troppo', 'Grande Sonate in C major, op. 25: II. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17469 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c9a8db-4669-47a7-816d-c487d3923058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Theme and Variations. Andantino grazioso', part.name_en = 'Grande Sonate in C major, op. 25: III. Theme and Variations. Andantino grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17469 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:32471aa7-9b77-4a54-a271-2f175760ccc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32471aa7-9b77-4a54-a271-2f175760ccc0', 3, 'III', 'Theme and Variations. Andantino grazioso', 'Grande Sonate in C major, op. 25: III. Theme and Variations. Andantino grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17469 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32471aa7-9b77-4a54-a271-2f175760ccc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Minuetto. Allegro', part.name_en = 'Grande Sonate in C major, op. 25: IV. Minuetto. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17469 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e07938c9-4e1e-467c-b615-436a4867f490' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e07938c9-4e1e-467c-b615-436a4867f490', 4, 'IV', 'Minuetto. Allegro', 'Grande Sonate in C major, op. 25: IV. Minuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17469 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e07938c9-4e1e-467c-b615-436a4867f490'
);


-- Op. 27 Introduction and Variations on "Gentil Houssard"

UPDATE pieces piece
SET piece.title = 'Introduction and Variations on "Gentil Houssard"', piece.title_en = 'Introduction and Variations on "Gentil Houssard", op. 27',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19580 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 Introduction et Thême varié Op. 20

UPDATE pieces piece
SET piece.title = 'Introduction et Thême varié Op. 20', piece.title_en = 'Introduction et Thême varié, op. 20',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '20',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16515 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Larghetto', part.name_en = 'Introduction et Thême varié, op. 20: Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:00132e77-c4cd-414b-a215-3dcb61a42ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00132e77-c4cd-414b-a215-3dcb61a42ce5', 1, NULL, 'Larghetto', 'Introduction et Thême varié, op. 20: Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00132e77-c4cd-414b-a215-3dcb61a42ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Thème: Andante', part.name_en = 'Introduction et Thême varié, op. 20: Thème: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ab4bd0da-a229-4828-af84-fbf329578903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab4bd0da-a229-4828-af84-fbf329578903', 2, NULL, 'Thème: Andante', 'Introduction et Thême varié, op. 20: Thème: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab4bd0da-a229-4828-af84-fbf329578903'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation 1', part.name_en = 'Introduction et Thême varié, op. 20: Variation 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ba7abf53-b231-41e2-9032-31b2a4f7f9a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba7abf53-b231-41e2-9032-31b2a4f7f9a3', 3, NULL, 'Variation 1', 'Introduction et Thême varié, op. 20: Variation 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba7abf53-b231-41e2-9032-31b2a4f7f9a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation 2: Minore', part.name_en = 'Introduction et Thême varié, op. 20: Variation 2: Minore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:36589248-b891-469a-a2c2-961e11890c36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36589248-b891-469a-a2c2-961e11890c36', 4, NULL, 'Variation 2: Minore', 'Introduction et Thême varié, op. 20: Variation 2: Minore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36589248-b891-469a-a2c2-961e11890c36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation 3', part.name_en = 'Introduction et Thême varié, op. 20: Variation 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5d836f7d-f662-436b-85c3-3caaaa8c7b82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d836f7d-f662-436b-85c3-3caaaa8c7b82', 5, NULL, 'Variation 3', 'Introduction et Thême varié, op. 20: Variation 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d836f7d-f662-436b-85c3-3caaaa8c7b82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation 4', part.name_en = 'Introduction et Thême varié, op. 20: Variation 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:321454a0-d2dc-40a6-b6b3-80fc6d51e1c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:321454a0-d2dc-40a6-b6b3-80fc6d51e1c7', 6, NULL, 'Variation 4', 'Introduction et Thême varié, op. 20: Variation 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:321454a0-d2dc-40a6-b6b3-80fc6d51e1c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation 5 and Coda', part.name_en = 'Introduction et Thême varié, op. 20: Variation 5 and Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16515 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8cafa790-35c7-4bb5-866f-86fc77c5d990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cafa790-35c7-4bb5-866f-86fc77c5d990', 7, NULL, 'Variation 5 and Coda', 'Introduction et Thême varié, op. 20: Variation 5 and Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16515 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cafa790-35c7-4bb5-866f-86fc77c5d990'
);


-- None Io mentitor!

UPDATE pieces piece
SET piece.title = 'Io mentitor!', piece.title_en = 'Io mentitor!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16589 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lagrime mie d'affanno>

UPDATE pieces piece
SET piece.title = '가곡 <Lagrime mie d''affanno>', piece.title_en = 'Lagrime mie d''affanno',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16800 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Las quejas de Maruja

UPDATE pieces piece
SET piece.title = 'Las quejas de Maruja', piece.title_en = 'Las quejas de Maruja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18418 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Laurette>

UPDATE pieces piece
SET piece.title = '가곡 <Laurette>', piece.title_en = 'Laurette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19353 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 Le Calme, caprice

UPDATE pieces piece
SET piece.title = 'Le Calme, caprice', piece.title_en = 'Le Calme, caprice, op. 50',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17502 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Candeur, petite rêverie

UPDATE pieces piece
SET piece.title = 'Le Candeur, petite rêverie', piece.title_en = 'Le Candeur, petite rêverie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19209 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Les Folies d'Espagne

UPDATE pieces piece
SET piece.title = 'Les Folies d''Espagne', piece.title_en = 'Les Folies d''Espagne, op. 15',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15749 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les favorites des salons

UPDATE pieces piece
SET piece.title = 'Les favorites des salons', piece.title_en = 'Les favorites des salons',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19732 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La nonchalante', part.name_en = 'Les favorites des salons: La nonchalante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19732 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:862be467-684d-450e-9bff-45eecf3d7f87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:862be467-684d-450e-9bff-45eecf3d7f87', 1, NULL, 'La nonchalante', 'Les favorites des salons: La nonchalante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19732 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:862be467-684d-450e-9bff-45eecf3d7f87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La dédaigneuse', part.name_en = 'Les favorites des salons: La dédaigneuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19732 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:99126363-01c2-4adf-84e2-1ed9a22c0954' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99126363-01c2-4adf-84e2-1ed9a22c0954', 2, NULL, 'La dédaigneuse', 'Les favorites des salons: La dédaigneuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19732 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99126363-01c2-4adf-84e2-1ed9a22c0954'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La joyeuse', part.name_en = 'Les favorites des salons: La joyeuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19732 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b450c697-e034-4097-b2b9-49bb03ba141e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b450c697-e034-4097-b2b9-49bb03ba141e', 3, NULL, 'La joyeuse', 'Les favorites des salons: La joyeuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19732 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b450c697-e034-4097-b2b9-49bb03ba141e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La champêtre', part.name_en = 'Les favorites des salons: La champêtre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19732 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b842ede1-9ee0-4927-b360-8dc53d057e5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b842ede1-9ee0-4927-b360-8dc53d057e5d', 4, NULL, 'La champêtre', 'Les favorites des salons: La champêtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19732 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b842ede1-9ee0-4927-b360-8dc53d057e5d'
);


-- None 가곡 <Los defensores de la pátria>

UPDATE pieces piece
SET piece.title = '가곡 <Los defensores de la pátria>', piece.title_en = 'Los defensores de la pátria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18495 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15c Marche du ballet de "Cendrillon"

UPDATE pieces piece
SET piece.title = 'Marche du ballet de "Cendrillon"', piece.title_en = 'Marche du ballet de "Cendrillon", op. 15c',
    piece.type = 'song', piece.opus_number = 'Op. 15c',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17644 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marche funèbre pour harpolyre

UPDATE pieces piece
SET piece.title = 'Marche funèbre pour harpolyre', piece.title_en = 'Marche funèbre pour harpolyre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16779 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 미뉴에트 C

UPDATE pieces piece
SET piece.title = '미뉴에트 C', piece.title_en = 'Minuet in C',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19500 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moderato

UPDATE pieces piece
SET piece.title = 'Moderato', piece.title_en = 'Moderato',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16315 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mon dernier mot>

UPDATE pieces piece
SET piece.title = '가곡 <Mon dernier mot>', piece.title_en = 'Mon dernier mot',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19197 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54 Morceau de concert

UPDATE pieces piece
SET piece.title = 'Morceau de concert', piece.title_en = 'Morceau de concert, op. 54',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17630 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None No doblarán campanas (No bells will toll)

UPDATE pieces piece
SET piece.title = 'No doblarán campanas (No bells will toll)', piece.title_en = 'No doblarán campanas (No bells will toll)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17336 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <O crux ave>

UPDATE pieces piece
SET piece.title = '모테트 <O crux ave>', piece.title_en = 'O crux ave',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16914 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <O vous, que Mars rend invincible>

UPDATE pieces piece
SET piece.title = '가곡 <O vous, que Mars rend invincible>', piece.title_en = 'O vous, que Mars rend invincible',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18928 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perduta l'anima

UPDATE pieces piece
SET piece.title = 'Perduta l''anima', piece.title_en = 'Perduta l''anima',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17723 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Povero cor t'inganni

UPDATE pieces piece
SET piece.title = 'Povero cor t''inganni', piece.title_en = 'Povero cor t''inganni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17388 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Seguidillas del Requiem eternam>

UPDATE pieces piece
SET piece.title = '가곡 <Seguidillas del Requiem eternam>', piece.title_en = 'Seguidillas del Requiem eternam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20065 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Si mis ojos te dicen (If my eyes are telling you)

UPDATE pieces piece
SET piece.title = 'Si mis ojos te dicen (If my eyes are telling you)', piece.title_en = 'Si mis ojos te dicen (If my eyes are telling you)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18639 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 Six Divertimenti Op. 1

UPDATE pieces piece
SET piece.title = 'Six Divertimenti Op. 1', piece.title_en = 'Six Divertimenti, op. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '1',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18995 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Six Divertimenti, op. 1: No. 1. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:90fceb4e-dafc-4e9b-8cf8-e53c5259d3fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90fceb4e-dafc-4e9b-8cf8-e53c5259d3fa', 1, NULL, 'Andante', 'Six Divertimenti, op. 1: No. 1. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90fceb4e-dafc-4e9b-8cf8-e53c5259d3fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Six Divertimenti, op. 1: No. 2. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b0efec64-39f7-4747-94ae-7dfcfcbafcd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0efec64-39f7-4747-94ae-7dfcfcbafcd9', 2, NULL, 'Allegretto', 'Six Divertimenti, op. 1: No. 2. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0efec64-39f7-4747-94ae-7dfcfcbafcd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Larghetto', part.name_en = 'Six Divertimenti, op. 1: No. 3. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:53ad749e-49d9-477c-bab9-f2aabebe014f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53ad749e-49d9-477c-bab9-f2aabebe014f', 3, NULL, 'Larghetto', 'Six Divertimenti, op. 1: No. 3. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53ad749e-49d9-477c-bab9-f2aabebe014f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Six Divertimenti, op. 1: No. 4. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:732585ec-1b10-49ca-8745-98c903641515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:732585ec-1b10-49ca-8745-98c903641515', 4, NULL, 'Andante', 'Six Divertimenti, op. 1: No. 4. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:732585ec-1b10-49ca-8745-98c903641515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Theme and Variations', part.name_en = 'Six Divertimenti, op. 1: No. 5. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e340b65f-9bab-453b-9d50-129c9ce33194' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e340b65f-9bab-453b-9d50-129c9ce33194', 5, NULL, 'Theme and Variations', 'Six Divertimenti, op. 1: No. 5. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e340b65f-9bab-453b-9d50-129c9ce33194'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Marcia', part.name_en = 'Six Divertimenti, op. 1: No. 6. Marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18995 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8396c92b-3957-41f5-88d6-f1171c70f194' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8396c92b-3957-41f5-88d6-f1171c70f194', 6, NULL, 'Marcia', 'Six Divertimenti, op. 1: No. 6. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18995 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8396c92b-3957-41f5-88d6-f1171c70f194'
);


-- Op. 13 Six Divertimenti Op. 13

UPDATE pieces piece
SET piece.title = 'Six Divertimenti Op. 13', piece.title_en = 'Six Divertimenti, op. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15720 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tempo di Minuetto', part.name_en = 'Six Divertimenti, op. 13, no. 1: Tempo di Minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a1a2ed81-ce39-4e63-a791-3eb11b5fb553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a2ed81-ce39-4e63-a791-3eb11b5fb553', 1, NULL, 'Tempo di Minuetto', 'Six Divertimenti, op. 13, no. 1: Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a2ed81-ce39-4e63-a791-3eb11b5fb553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Six Divertimenti, op. 13, no. 2: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f97dca2c-86de-472a-ae4e-607815ee2fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f97dca2c-86de-472a-ae4e-607815ee2fe4', 2, NULL, 'Waltz', 'Six Divertimenti, op. 13, no. 2: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f97dca2c-86de-472a-ae4e-607815ee2fe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Six Divertimenti, op. 13, no. 3: Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b6417e33-194e-4074-9ea2-c16c24c007d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6417e33-194e-4074-9ea2-c16c24c007d2', 3, NULL, 'Andantino', 'Six Divertimenti, op. 13, no. 3: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6417e33-194e-4074-9ea2-c16c24c007d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cantabile', part.name_en = 'Six Divertimenti, op. 13, no. 4: Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:096e6ebe-5e22-4fe1-bba2-9e2d80b2f9a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096e6ebe-5e22-4fe1-bba2-9e2d80b2f9a7', 4, NULL, 'Cantabile', 'Six Divertimenti, op. 13, no. 4: Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096e6ebe-5e22-4fe1-bba2-9e2d80b2f9a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante pastorale', part.name_en = 'Six Divertimenti, op. 13, no. 5: Andante pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2f4d5eb8-86c4-455d-90a9-58ed786c673b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4d5eb8-86c4-455d-90a9-58ed786c673b', 5, NULL, 'Andante pastorale', 'Six Divertimenti, op. 13, no. 5: Andante pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4d5eb8-86c4-455d-90a9-58ed786c673b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'March', part.name_en = 'Six Divertimenti, op. 13, no. 6: March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15720 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:118508bf-5000-451c-917c-0336ffe96d5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:118508bf-5000-451c-917c-0336ffe96d5e', 6, NULL, 'March', 'Six Divertimenti, op. 13, no. 6: March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15720 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:118508bf-5000-451c-917c-0336ffe96d5e'
);


-- Op. 2 Six Divertimenti Op. 2

UPDATE pieces piece
SET piece.title = 'Six Divertimenti Op. 2', piece.title_en = 'Six Divertimenti, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18922 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tempo di minuetto', part.name_en = 'Six Divertimenti, op. 2: No. 1. Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0db4c6ab-b276-4d15-b2d2-89d1e1c7ae6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db4c6ab-b276-4d15-b2d2-89d1e1c7ae6b', 1, NULL, 'Tempo di minuetto', 'Six Divertimenti, op. 2: No. 1. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db4c6ab-b276-4d15-b2d2-89d1e1c7ae6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Six Divertimenti, op. 2: No. 2. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:230689b0-28dd-4f93-8df1-d50f9c9984ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:230689b0-28dd-4f93-8df1-d50f9c9984ad', 2, NULL, 'Waltz', 'Six Divertimenti, op. 2: No. 2. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:230689b0-28dd-4f93-8df1-d50f9c9984ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Six Divertimenti, op. 2: No. 3. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c079d2a5-4429-47f9-afd8-36e5b2b9d9b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c079d2a5-4429-47f9-afd8-36e5b2b9d9b4', 3, NULL, 'Andantino', 'Six Divertimenti, op. 2: No. 3. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c079d2a5-4429-47f9-afd8-36e5b2b9d9b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tempo di minuetto', part.name_en = 'Six Divertimenti, op. 2: No. 4. Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:4669c34f-930c-4f2f-bc6f-07ca02fd1ac5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4669c34f-930c-4f2f-bc6f-07ca02fd1ac5', 4, NULL, 'Tempo di minuetto', 'Six Divertimenti, op. 2: No. 4. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4669c34f-930c-4f2f-bc6f-07ca02fd1ac5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Six Divertimenti, op. 2: No. 5. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5fd5ef74-5374-47ed-ae48-253fe6534d7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fd5ef74-5374-47ed-ae48-253fe6534d7a', 5, NULL, 'Waltz', 'Six Divertimenti, op. 2: No. 5. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fd5ef74-5374-47ed-ae48-253fe6534d7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Siciliana', part.name_en = 'Six Divertimenti, op. 2: No. 6. Siciliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18922 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8b7ed8e6-aa74-4915-9844-50d6743a50ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b7ed8e6-aa74-4915-9844-50d6743a50ba', 6, NULL, 'Siciliana', 'Six Divertimenti, op. 2: No. 6. Siciliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18922 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b7ed8e6-aa74-4915-9844-50d6743a50ba'
);


-- Op. 17 Six Waltzes Op. 17

UPDATE pieces piece
SET piece.title = 'Six Waltzes Op. 17', piece.title_en = 'Six Waltzes, op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18500 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Six Waltzes, op. 17: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c0580fac-b3b5-4a16-b7b9-927857183325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0580fac-b3b5-4a16-b7b9-927857183325', 1, NULL, 'No. 1', 'Six Waltzes, op. 17: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0580fac-b3b5-4a16-b7b9-927857183325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Six Waltzes, op. 17: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:856fa46c-cd3a-4bee-b732-af1df809fa08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:856fa46c-cd3a-4bee-b732-af1df809fa08', 2, NULL, 'No. 2', 'Six Waltzes, op. 17: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856fa46c-cd3a-4bee-b732-af1df809fa08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Six Waltzes, op. 17: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:76fc2d3a-5f7d-4037-a13d-ea5faf4cc6ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76fc2d3a-5f7d-4037-a13d-ea5faf4cc6ca', 3, NULL, 'No. 3', 'Six Waltzes, op. 17: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76fc2d3a-5f7d-4037-a13d-ea5faf4cc6ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Six Waltzes, op. 17: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5bd2e55f-6f90-4a0a-8ae4-9c92792b883c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bd2e55f-6f90-4a0a-8ae4-9c92792b883c', 4, NULL, 'No. 4', 'Six Waltzes, op. 17: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd2e55f-6f90-4a0a-8ae4-9c92792b883c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Six Waltzes, op. 17: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:52c70e2d-f2bb-4f1a-b246-0cbde4610b98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c70e2d-f2bb-4f1a-b246-0cbde4610b98', 5, NULL, 'No. 5', 'Six Waltzes, op. 17: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c70e2d-f2bb-4f1a-b246-0cbde4610b98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Six Waltzes, op. 17: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18500 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:16fe5d64-767d-4dcb-b887-144024c6fc94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16fe5d64-767d-4dcb-b887-144024c6fc94', 6, NULL, 'No. 6', 'Six Waltzes, op. 17: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18500 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16fe5d64-767d-4dcb-b887-144024c6fc94'
);


-- Op. 18 Six Waltzes Op. 18

UPDATE pieces piece
SET piece.title = 'Six Waltzes Op. 18', piece.title_en = 'Six Waltzes, op. 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18277 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Six Waltzes, op. 18: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c105fc31-0154-4512-b9fe-2588058b3c90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c105fc31-0154-4512-b9fe-2588058b3c90', 1, NULL, 'No. 1', 'Six Waltzes, op. 18: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c105fc31-0154-4512-b9fe-2588058b3c90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Six Waltzes, op. 18: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:54bc6300-e347-4932-b315-c7834c1d7c36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54bc6300-e347-4932-b315-c7834c1d7c36', 2, NULL, 'No. 2', 'Six Waltzes, op. 18: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bc6300-e347-4932-b315-c7834c1d7c36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Six Waltzes, op. 18: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c5bb88bf-9466-43df-a0b9-e0694a45e6fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5bb88bf-9466-43df-a0b9-e0694a45e6fb', 3, NULL, 'No. 3', 'Six Waltzes, op. 18: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5bb88bf-9466-43df-a0b9-e0694a45e6fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Six Waltzes, op. 18: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:18b16d91-55e9-468d-b1fa-be71b021d7c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18b16d91-55e9-468d-b1fa-be71b021d7c7', 4, NULL, 'No. 4', 'Six Waltzes, op. 18: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b16d91-55e9-468d-b1fa-be71b021d7c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Six Waltzes, op. 18: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:32ef7c09-1029-49ba-b574-7b9daf3ebc2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ef7c09-1029-49ba-b574-7b9daf3ebc2a', 5, NULL, 'No. 5', 'Six Waltzes, op. 18: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ef7c09-1029-49ba-b574-7b9daf3ebc2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Six Waltzes, op. 18: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18277 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:91a7eb30-6e12-4e5c-a57f-b30dd654f35b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91a7eb30-6e12-4e5c-a57f-b30dd654f35b', 6, NULL, 'No. 6', 'Six Waltzes, op. 18: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18277 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91a7eb30-6e12-4e5c-a57f-b30dd654f35b'
);


-- Op. 47 Six petites pièces Op. 47

UPDATE pieces piece
SET piece.title = 'Six petites pièces Op. 47', piece.title_en = 'Six petites pièces, op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18123 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Six petites pièces, op. 47: No. 1. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:30a316d9-9484-4c33-b8fd-7918cbbd7004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30a316d9-9484-4c33-b8fd-7918cbbd7004', 1, NULL, 'Andante', 'Six petites pièces, op. 47: No. 1. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30a316d9-9484-4c33-b8fd-7918cbbd7004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Six petites pièces, op. 47: No. 2. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d4359e5f-9990-4839-8ebf-da7c934d6584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4359e5f-9990-4839-8ebf-da7c934d6584', 2, NULL, 'Allegretto', 'Six petites pièces, op. 47: No. 2. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4359e5f-9990-4839-8ebf-da7c934d6584'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Six petites pièces, op. 47: No. 3. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bfd75fd4-7aef-418e-92b1-4ca34e9a6af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd75fd4-7aef-418e-92b1-4ca34e9a6af9', 3, NULL, 'Andante', 'Six petites pièces, op. 47: No. 3. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd75fd4-7aef-418e-92b1-4ca34e9a6af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Six petites pièces, op. 47: No. 4. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bd9e61b0-dfc4-4825-90c8-dafed6fe6f08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd9e61b0-dfc4-4825-90c8-dafed6fe6f08', 4, NULL, 'Allegretto', 'Six petites pièces, op. 47: No. 4. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd9e61b0-dfc4-4825-90c8-dafed6fe6f08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cantabile', part.name_en = 'Six petites pièces, op. 47: No. 5. Cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a9cf47e8-2390-47b0-a325-eca4e496553b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9cf47e8-2390-47b0-a325-eca4e496553b', 5, NULL, 'Cantabile', 'Six petites pièces, op. 47: No. 5. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cf47e8-2390-47b0-a325-eca4e496553b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse', part.name_en = 'Six petites pièces, op. 47: No. 6. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18123 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0eda919a-3d74-4899-b4aa-b0b91deccbbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0eda919a-3d74-4899-b4aa-b0b91deccbbb', 6, NULL, 'Valse', 'Six petites pièces, op. 47: No. 6. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18123 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0eda919a-3d74-4899-b4aa-b0b91deccbbb'
);


-- Op. 39 Six valses composées pour l'orchestre par différents auteurs Op. 39

UPDATE pieces piece
SET piece.title = 'Six valses composées pour l''orchestre par différents auteurs Op. 39', piece.title_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18257 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'by Mohor', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 1 by Mohor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:71f6926f-60d5-4e05-88c9-8c83ce2d698b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71f6926f-60d5-4e05-88c9-8c83ce2d698b', 1, NULL, 'by Mohor', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 1 by Mohor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71f6926f-60d5-4e05-88c9-8c83ce2d698b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'by Sor', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 2 by Sor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:522fcfd3-0d5f-4810-ad1e-216e542a2b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522fcfd3-0d5f-4810-ad1e-216e542a2b4e', 2, NULL, 'by Sor', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 2 by Sor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522fcfd3-0d5f-4810-ad1e-216e542a2b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'by Mohor', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 3 by Mohor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:23c8f8d2-a44e-45dc-ba5e-762508089bfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23c8f8d2-a44e-45dc-ba5e-762508089bfd', 3, NULL, 'by Mohor', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 3 by Mohor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23c8f8d2-a44e-45dc-ba5e-762508089bfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'by Steibelt', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 4 by Steibelt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3e713c28-ccfb-4a11-a40b-97ebc981279d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e713c28-ccfb-4a11-a40b-97ebc981279d', 4, NULL, 'by Steibelt', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 4 by Steibelt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e713c28-ccfb-4a11-a40b-97ebc981279d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'by Mozart', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 5 by Mozart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:01da3497-4865-4b01-bc27-0c34b984dba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01da3497-4865-4b01-bc27-0c34b984dba5', 5, NULL, 'by Mozart', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 5 by Mozart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01da3497-4865-4b01-bc27-0c34b984dba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'by Mohor', part.name_en = 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 6 by Mohor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18257 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:806a21d7-85f0-414b-9dd6-94f33017fb8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:806a21d7-85f0-414b-9dd6-94f33017fb8b', 6, NULL, 'by Mohor', 'Six valses composées pour l''orchestre par différents auteurs, op. 39: No. 6 by Mohor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18257 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:806a21d7-85f0-414b-9dd6-94f33017fb8b'
);


-- Op. 57 Six valses et un galop Op. 57

UPDATE pieces piece
SET piece.title = 'Six valses et un galop Op. 57', piece.title_en = 'Six valses et un galop, op. 57',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '57',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17970 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Valse no. 1', part.name_en = 'Six valses et un galop, op. 57: Valse no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:563023d9-3ca5-4dcd-a64a-21296bbb1aa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563023d9-3ca5-4dcd-a64a-21296bbb1aa2', 1, NULL, 'Valse no. 1', 'Six valses et un galop, op. 57: Valse no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563023d9-3ca5-4dcd-a64a-21296bbb1aa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Valse no. 2', part.name_en = 'Six valses et un galop, op. 57: Valse no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:33a707bb-4258-4209-9dce-7047dd45375b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33a707bb-4258-4209-9dce-7047dd45375b', 2, NULL, 'Valse no. 2', 'Six valses et un galop, op. 57: Valse no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33a707bb-4258-4209-9dce-7047dd45375b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Valse no. 3', part.name_en = 'Six valses et un galop, op. 57: Valse no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ccc53187-faa1-4f4d-9eb7-acbf709a134b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccc53187-faa1-4f4d-9eb7-acbf709a134b', 3, NULL, 'Valse no. 3', 'Six valses et un galop, op. 57: Valse no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc53187-faa1-4f4d-9eb7-acbf709a134b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse no. 4', part.name_en = 'Six valses et un galop, op. 57: Valse no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ff2743b8-a7d9-4042-8214-110bb095025a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2743b8-a7d9-4042-8214-110bb095025a', 4, NULL, 'Valse no. 4', 'Six valses et un galop, op. 57: Valse no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2743b8-a7d9-4042-8214-110bb095025a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Valse no. 5', part.name_en = 'Six valses et un galop, op. 57: Valse no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e51c999c-0b45-4f49-b601-c16383a4ac67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51c999c-0b45-4f49-b601-c16383a4ac67', 5, NULL, 'Valse no. 5', 'Six valses et un galop, op. 57: Valse no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51c999c-0b45-4f49-b601-c16383a4ac67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse no. 6', part.name_en = 'Six valses et un galop, op. 57: Valse no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:75d78109-158e-4b18-9761-e0b68ca3e221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75d78109-158e-4b18-9761-e0b68ca3e221', 6, NULL, 'Valse no. 6', 'Six valses et un galop, op. 57: Valse no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75d78109-158e-4b18-9761-e0b68ca3e221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Galop', part.name_en = 'Six valses et un galop, op. 57: Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17970 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c9a8ba8d-599b-4afe-af7f-24369bf6c002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9a8ba8d-599b-4afe-af7f-24369bf6c002', 7, NULL, 'Galop', 'Six valses et un galop, op. 57: Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17970 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a8ba8d-599b-4afe-af7f-24369bf6c002'
);


-- Op. 44b 6개의 왈츠 Op. 44b

UPDATE pieces piece
SET piece.title = '6개의 왈츠 Op. 44b', piece.title_en = 'Six valses, op. 44b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16767 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Six valses, op. 44b: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:bec435cb-0549-4c89-857b-8dcbe1bd679a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec435cb-0549-4c89-857b-8dcbe1bd679a', 1, NULL, 'No. 1', 'Six valses, op. 44b: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec435cb-0549-4c89-857b-8dcbe1bd679a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Six valses, op. 44b: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c65d95c4-0720-4b5d-92f4-abacfb83be95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c65d95c4-0720-4b5d-92f4-abacfb83be95', 2, NULL, 'No. 2', 'Six valses, op. 44b: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c65d95c4-0720-4b5d-92f4-abacfb83be95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Six valses, op. 44b: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e0844f13-999e-415b-8401-cbdebb280e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0844f13-999e-415b-8401-cbdebb280e00', 3, NULL, 'No. 3', 'Six valses, op. 44b: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0844f13-999e-415b-8401-cbdebb280e00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Six valses, op. 44b: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1376205f-d671-4521-9b09-1e46b9620b64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1376205f-d671-4521-9b09-1e46b9620b64', 4, NULL, 'No. 4', 'Six valses, op. 44b: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1376205f-d671-4521-9b09-1e46b9620b64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Six valses, op. 44b: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a56f5ace-d219-4b1e-b1eb-931d37df43b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56f5ace-d219-4b1e-b1eb-931d37df43b9', 5, NULL, 'No. 5', 'Six valses, op. 44b: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56f5ace-d219-4b1e-b1eb-931d37df43b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Six valses, op. 44b: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16767 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9e60b8f4-0557-4127-83a3-bff1b2d0c690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e60b8f4-0557-4127-83a3-bff1b2d0c690', 6, NULL, 'No. 6', 'Six valses, op. 44b: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16767 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e60b8f4-0557-4127-83a3-bff1b2d0c690'
);


-- Op. 15b 소나타 C장조

UPDATE pieces piece
SET piece.title = '소나타 C장조', piece.title_en = 'Sonata in C major, op. 15b',
    piece.type = 'song', piece.opus_number = 'Op. 15b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18993 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 3번 F장조

UPDATE pieces piece
SET piece.title = '교향곡 3번 F장조', piece.title_en = 'Symphony no. 3 in F major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17303 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15c Thème varié in C major

UPDATE pieces piece
SET piece.title = 'Thème varié in C major', piece.title_en = 'Thème varié in C major, op. 15c',
    piece.type = 'song', piece.opus_number = 'Op. 15c',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19006 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 Thème varié suivi d'un menuet Op. 3

UPDATE pieces piece
SET piece.title = 'Thème varié suivi d''un menuet Op. 3', piece.title_en = 'Thème varié suivi d''un menuet, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17053 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Thème varié', part.name_en = 'Thème varié suivi d''un menuet, op. 3: Thème varié',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17053 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9d531998-5fae-44f2-bd39-edcff8a1cd3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d531998-5fae-44f2-bd39-edcff8a1cd3a', 1, NULL, 'Thème varié', 'Thème varié suivi d''un menuet, op. 3: Thème varié', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17053 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d531998-5fae-44f2-bd39-edcff8a1cd3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Menuet', part.name_en = 'Thème varié suivi d''un menuet, op. 3: Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17053 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:100733cb-d41d-47d0-a507-7a0feafdfbd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:100733cb-d41d-47d0-a507-7a0feafdfbd8', 2, NULL, 'Menuet', 'Thème varié suivi d''un menuet, op. 3: Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17053 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:100733cb-d41d-47d0-a507-7a0feafdfbd8'
);


-- None Ti ricordi che giurasti

UPDATE pieces piece
SET piece.title = 'Ti ricordi che giurasti', piece.title_en = 'Ti ricordi che giurasti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16747 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 Trois Pièces de société Op. 33

UPDATE pieces piece
SET piece.title = 'Trois Pièces de société Op. 33', piece.title_en = 'Trois Pièces de société, op. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '33',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18151 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction & Allegretto', part.name_en = 'Trois Pièces de société, op. 33: No. 1. Introduction & Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18151 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8fda5f76-77ac-479d-810a-375cb3ab04e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fda5f76-77ac-479d-810a-375cb3ab04e2', 1, NULL, 'Introduction & Allegretto', 'Trois Pièces de société, op. 33: No. 1. Introduction & Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18151 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fda5f76-77ac-479d-810a-375cb3ab04e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante & Valse', part.name_en = 'Trois Pièces de société, op. 33: No. 2. Andante & Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18151 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9c3f6788-b6a2-4ee8-ad86-7390519141b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c3f6788-b6a2-4ee8-ad86-7390519141b2', 2, NULL, 'Andante & Valse', 'Trois Pièces de société, op. 33: No. 2. Andante & Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18151 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c3f6788-b6a2-4ee8-ad86-7390519141b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sicilienne - March', part.name_en = 'Trois Pièces de société, op. 33: No. 3. Sicilienne - March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18151 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:495b8370-b05c-447a-b85f-d85fb6a43659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:495b8370-b05c-447a-b85f-d85fb6a43659', 3, NULL, 'Sicilienne - March', 'Trois Pièces de société, op. 33: No. 3. Sicilienne - March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18151 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:495b8370-b05c-447a-b85f-d85fb6a43659'
);


-- Op. 55 Trois duos Op. 55

UPDATE pieces piece
SET piece.title = 'Trois duos Op. 55', piece.title_en = 'Trois duos, op. 55',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '55',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18339 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'no. 1', part.name_en = 'Trois duos, op. 55, no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832', 1, NULL, 'no. 1', 'Trois duos, op. 55, no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Trois duos, op. 55, no. 1: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:4a8191d7-d78a-4eca-9258-345cfd806f18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a8191d7-d78a-4eca-9258-345cfd806f18', 1, NULL, 'Andante', 'Trois duos, op. 55, no. 1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a8191d7-d78a-4eca-9258-345cfd806f18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Trois duos, op. 55, no. 1: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:62becd1f-657c-46ec-b598-3154fc6d1ed1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62becd1f-657c-46ec-b598-3154fc6d1ed1', 2, NULL, 'Allegretto', 'Trois duos, op. 55, no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ef759e0-9452-4b7e-9feb-15a6683b1832'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62becd1f-657c-46ec-b598-3154fc6d1ed1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'no. 2', part.name_en = 'Trois duos, op. 55, no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf', 2, NULL, 'no. 2', 'Trois duos, op. 55, no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Trois duos, op. 55, no. 2: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5a0c0edf-cc2c-43ce-806e-3aa6b4a4954f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a0c0edf-cc2c-43ce-806e-3aa6b4a4954f', 1, NULL, 'Andante', 'Trois duos, op. 55, no. 2: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a0c0edf-cc2c-43ce-806e-3aa6b4a4954f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Trois duos, op. 55, no. 2: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:74475aaf-81fe-4eaf-9419-9aa3f98d92ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74475aaf-81fe-4eaf-9419-9aa3f98d92ff', 2, NULL, 'Allegretto', 'Trois duos, op. 55, no. 2: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a346fa89-5941-42eb-99fd-60a41ed7fcdf'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74475aaf-81fe-4eaf-9419-9aa3f98d92ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'no. 3', part.name_en = 'Trois duos, op. 55, no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888', 3, NULL, 'no. 3', 'Trois duos, op. 55, no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante, Tema e variazioni', part.name_en = 'Trois duos, op. 55, no. 3: I. Andante, Tema e variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:95b0b421-a020-401f-88cd-ac6cac975290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95b0b421-a020-401f-88cd-ac6cac975290', 1, NULL, 'Andante, Tema e variazioni', 'Trois duos, op. 55, no. 3: I. Andante, Tema e variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b0b421-a020-401f-88cd-ac6cac975290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mouvement de valse', part.name_en = 'Trois duos, op. 55, no. 3: II. Mouvement de valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18339 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:15109933-b45e-4b83-8559-1aad64b4a6b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15109933-b45e-4b83-8559-1aad64b4a6b1', 2, NULL, 'Mouvement de valse', 'Trois duos, op. 55, no. 3: II. Mouvement de valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e61edab-be6e-468d-9d4e-7cf81c82b888'
WHERE p.id = 18339 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15109933-b45e-4b83-8559-1aad64b4a6b1'
);


-- Op. 61 Trois petits divertissements Op. 61

UPDATE pieces piece
SET piece.title = 'Trois petits divertissements Op. 61', piece.title_en = 'Trois petits divertissements, op. 61',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '61',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17059 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'no. 1', part.name_en = 'Trois petits divertissements, op. 61, no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e', 1, NULL, 'no. 1', 'Trois petits divertissements, op. 61, no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Trois petits divertissements, op. 61, no. 1: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:68708186-ecff-4a72-903e-4539b4ce20e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68708186-ecff-4a72-903e-4539b4ce20e8', 1, NULL, 'Andante', 'Trois petits divertissements, op. 61, no. 1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68708186-ecff-4a72-903e-4539b4ce20e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Trois petits divertissements, op. 61, no. 1: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:d0930796-d4d8-4874-a46e-46b5e9e542be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0930796-d4d8-4874-a46e-46b5e9e542be', 2, NULL, 'Allegretto', 'Trois petits divertissements, op. 61, no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2eff8263-9062-435f-8622-469365530b2e'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0930796-d4d8-4874-a46e-46b5e9e542be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'no. 2', part.name_en = 'Trois petits divertissements, op. 61, no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c', 2, NULL, 'no. 2', 'Trois petits divertissements, op. 61, no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante moderato', part.name_en = 'Trois petits divertissements, op. 61, no. 2: I. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:da3afd14-9ab1-446f-910d-0e53f71da88d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da3afd14-9ab1-446f-910d-0e53f71da88d', 1, NULL, 'Andante moderato', 'Trois petits divertissements, op. 61, no. 2: I. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da3afd14-9ab1-446f-910d-0e53f71da88d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Trois petits divertissements, op. 61, no. 2: II. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:854d65c8-8cff-4d0f-b4fd-7da281fda970' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:854d65c8-8cff-4d0f-b4fd-7da281fda970', 2, NULL, 'Allegro moderato', 'Trois petits divertissements, op. 61, no. 2: II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1acb91ee-8dcb-4940-ad17-d8096b87139c'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:854d65c8-8cff-4d0f-b4fd-7da281fda970'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'no. 3', part.name_en = 'Trois petits divertissements, op. 61, no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650', 3, NULL, 'no. 3', 'Trois petits divertissements, op. 61, no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Trois petits divertissements, op. 61, no. 3: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:b2fe30da-645a-470d-930d-1b4012f1a5f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2fe30da-645a-470d-930d-1b4012f1a5f0', 1, NULL, 'Andante', 'Trois petits divertissements, op. 61, no. 3: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2fe30da-645a-470d-930d-1b4012f1a5f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Trois petits divertissements, op. 61, no. 3: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17059 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f7bb461c-cff8-4252-b8b2-7c55861a968d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7bb461c-cff8-4252-b8b2-7c55861a968d', 2, NULL, 'Allegretto', 'Trois petits divertissements, op. 61, no. 3: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b90edd4-823a-4243-991d-33db3bea5650'
WHERE p.id = 17059 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7bb461c-cff8-4252-b8b2-7c55861a968d'
);


-- None Twenty Studies for the Guitar by Fernando Sor

UPDATE pieces piece
SET piece.title = 'Twenty Studies for the Guitar by Fernando Sor', piece.title_en = 'Twenty Studies for the Guitar by Fernando Sor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18283 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'en do mayor', part.name_en = '12 estudios, op. 6: No. 8 en do mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d', 1, NULL, 'en do mayor', '12 estudios, op. 6: No. 8 en do mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f98a4a-3bdb-4807-ae9c-2548a2ee459d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Exercises, op. 35: No. 13 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3', 2, NULL, 'C장조', '24 Exercises, op. 35: No. 13 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6950ba-5776-4f9b-aed3-7bcaa11cfac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 2 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679', 3, NULL, 'en la mayor', '12 estudios, op. 6: No. 2 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa0614ca-99d3-4af9-8596-e86ce9785679'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = '12 estudios, op. 6: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631', 4, NULL, 'No. 1', '12 estudios, op. 6: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01b21dcc-7332-4aa4-a830-89e172c04631'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Exercises, op. 35: No. 22 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94', 5, NULL, 'B단조', '24 Exercises, op. 35: No. 22 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e68cb1c-c8ad-4b3b-89a9-80c4532e6b94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Exercises, op. 35: No. 17 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914', 6, NULL, 'D장조', '24 Exercises, op. 35: No. 17 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7666a8f7-7dad-44c5-9819-9b5126caf914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 21', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915', 7, NULL, 'No. 21', '24 Progressive Lessons for Beginners, op. 31: No. 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca69c3b1-3f06-467e-af2e-f3849f23d915'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 16 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb', 8, NULL, 'D단조', '24 Progressive Lessons for Beginners, op. 31: No. 16 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0eceec-c0aa-496c-9879-3701e4d660fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 20 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f', 9, NULL, 'A단조', '24 Progressive Lessons for Beginners, op. 31: No. 20 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8edc3dc-e694-4b58-bf11-014b01016b3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Progressive Lessons for Beginners, op. 31: No. 19 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76', 10, NULL, 'A장조', '24 Progressive Lessons for Beginners, op. 31: No. 19 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8133387d-9438-467a-8bd6-264f1d5c7c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = '12 estudios, op. 6: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb', 11, NULL, 'No. 3', '12 estudios, op. 6: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600713a8-3d26-4944-9ea8-4ea055118cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 6 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca', 12, NULL, 'en la mayor', '12 estudios, op. 6: No. 6 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a6d96d5-8dcd-4a94-90f5-ff35672db4ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'en re menor', part.name_en = '12 estudios, op. 6: No. 9 en re menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a', 13, NULL, 'en re menor', '12 estudios, op. 6: No. 9 en re menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06cf2b5-3f7c-4023-85ab-e3276376550a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'en la mayor', part.name_en = '12 estudios, op. 6: No. 12 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b', 14, NULL, 'en la mayor', '12 estudios, op. 6: No. 12 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1d8588-d3df-4b70-a41d-51ce87f4200b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Exercises, op. 35: No. 16 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad', 15, NULL, 'D단조', '24 Exercises, op. 35: No. 16 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368d8725-5439-4b62-bbd6-16347d9c17ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'N.º 23 en sol mayor', part.name_en = '12 estudios, op. 29: N.º 23 en sol mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42', 16, NULL, 'N.º 23 en sol mayor', '12 estudios, op. 29: N.º 23 en sol mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08768b60-841b-4536-a23f-f2c030391e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'en mi menor', part.name_en = '12 estudios, op. 6: No. 11 en mi menor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1', 17, NULL, 'en mi menor', '12 estudios, op. 6: No. 11 en mi menor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e698063-0624-3e2e-b4d6-13887e6434a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'N.º 22 en mi bemol mayor', part.name_en = '12 estudios, op. 29: N.º 22 en mi bemol mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7', 18, NULL, 'N.º 22 en mi bemol mayor', '12 estudios, op. 29: N.º 22 en mi bemol mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baacdc6b-e876-4320-971d-ea6b5e4871b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'N.º 13 en si mayor', part.name_en = '12 estudios, op. 29: N.º 13 en si mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a', 19, NULL, 'N.º 13 en si mayor', '12 estudios, op. 29: N.º 13 en si mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6037df01-3c85-4164-8d09-a83dfbb96a4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'N.º 17 en do mayor', part.name_en = '12 estudios, op. 29: N.º 17 en do mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18283 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca', 20, NULL, 'N.º 17 en do mayor', '12 estudios, op. 29: N.º 17 en do mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18283 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e250fa7e-1f7f-435d-a2ee-2db38275e1ca'
);


-- None 가곡 <Valse du ballet de Cendrillon>

UPDATE pieces piece
SET piece.title = '가곡 <Valse du ballet de Cendrillon>', piece.title_en = 'Valse du ballet de Cendrillon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18275 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <¿Adónde vas, Fernando incauto?>

UPDATE pieces piece
SET piece.title = '가곡 <¿Adónde vas, Fernando incauto?>', piece.title_en = '¿Adónde vas, Fernando incauto?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19631 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 51 À la bonne heure Op. 51

UPDATE pieces piece
SET piece.title = 'À la bonne heure Op. 51', piece.title_en = 'À la bonne heure, op. 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '51',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19865 AND piece.composer_id = 239
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'À la bonne heure, op. 51: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:2db8334d-d5d3-4428-b0ca-e88d41fdbb81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db8334d-d5d3-4428-b0ca-e88d41fdbb81', 1, NULL, 'No. 1', 'À la bonne heure, op. 51: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db8334d-d5d3-4428-b0ca-e88d41fdbb81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'À la bonne heure, op. 51: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:872c3b43-c39d-4c64-8e31-4bd3907141b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:872c3b43-c39d-4c64-8e31-4bd3907141b6', 2, NULL, 'No. 2', 'À la bonne heure, op. 51: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872c3b43-c39d-4c64-8e31-4bd3907141b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'À la bonne heure, op. 51: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:0c2ea143-d321-4f90-b088-eec74e7a229b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c2ea143-d321-4f90-b088-eec74e7a229b', 3, NULL, 'No. 3', 'À la bonne heure, op. 51: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c2ea143-d321-4f90-b088-eec74e7a229b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'À la bonne heure, op. 51: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:f6aa5c36-a5a4-4304-b373-b02644e3ab6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6aa5c36-a5a4-4304-b373-b02644e3ab6c', 4, NULL, 'No. 4', 'À la bonne heure, op. 51: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6aa5c36-a5a4-4304-b373-b02644e3ab6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'À la bonne heure, op. 51: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:a55be3de-417a-46c8-b339-3a4535effaff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a55be3de-417a-46c8-b339-3a4535effaff', 5, NULL, 'No. 5', 'À la bonne heure, op. 51: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a55be3de-417a-46c8-b339-3a4535effaff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'À la bonne heure, op. 51: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19865 AND p.composer_id = 239 AND part.part_key = 'musicbrainz:c6b2e85c-fcef-4f1d-b193-a68e47ed0f3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6b2e85c-fcef-4f1d-b193-a68e47ed0f3d', 6, NULL, 'No. 6', 'À la bonne heure, op. 51: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19865 AND p.composer_id = 239
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b2e85c-fcef-4f1d-b193-a68e47ed0f3d'
);


-- None 모테트 <O Salutaris hostia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <O Salutaris hostia>', 'O Salutaris hostia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 239
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <O Salutaris hostia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54c4b55-2373-4080-a846-50ae9a76a469'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f54c4b55-2373-4080-a846-50ae9a76a469'
FROM pieces p
WHERE p.composer_id = 239 AND p.title = '모테트 <O Salutaris hostia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f54c4b55-2373-4080-a846-50ae9a76a469'
);


-- 카탈로그에 대응이 없는 seed 작품 6개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 239 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15804, 17142, 18710, 18834, 18909, 19223
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
