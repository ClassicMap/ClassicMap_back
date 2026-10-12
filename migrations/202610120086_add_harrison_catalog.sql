-- 루 해리슨 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 91개(묶음 14, 다악장 36, 낱곡 41),
-- 새 작품 8개, part 238개, 그 아래 4개.
-- seed 83개 중 83개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None A 12-Tone Morning After to Amuse Henry

UPDATE pieces piece
SET piece.title = 'A 12-Tone Morning After to Amuse Henry', piece.title_en = 'A 12-Tone Morning After to Amuse Henry',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24084 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Soedjatmoko Set

UPDATE pieces piece
SET piece.title = 'A Soedjatmoko Set', piece.title_en = 'A Soedjatmoko Set',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24493 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Movement 1', part.name_en = 'A Soedjatmoko Set: I. Movement 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24493 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:776c178f-caf1-4fdc-836f-1741f2d7051d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:776c178f-caf1-4fdc-836f-1741f2d7051d', 1, 'I', 'Movement 1', 'A Soedjatmoko Set: I. Movement 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24493 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:776c178f-caf1-4fdc-836f-1741f2d7051d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Isna’s Song', part.name_en = 'A Soedjatmoko Set: II. Isna’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24493 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:31d28c21-a786-4e6a-8897-1b07ad3f5eb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31d28c21-a786-4e6a-8897-1b07ad3f5eb6', 2, 'II', 'Isna’s Song', 'A Soedjatmoko Set: II. Isna’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24493 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31d28c21-a786-4e6a-8897-1b07ad3f5eb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Movement 3', part.name_en = 'A Soedjatmoko Set: III. Movement 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24493 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d98df9f1-67f3-4a23-aa54-1cb03f9261d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d98df9f1-67f3-4a23-aa54-1cb03f9261d4', 3, 'III', 'Movement 3', 'A Soedjatmoko Set: III. Movement 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24493 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d98df9f1-67f3-4a23-aa54-1cb03f9261d4'
);


-- None A Summerfield Set

UPDATE pieces piece
SET piece.title = 'A Summerfield Set', piece.title_en = 'A Summerfield Set',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24547 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sonata: Allegro, Vigoroso - Air: Slow, Amoroso - Sonata da Capo', part.name_en = 'A Summerfield Set: I. Sonata: Allegro, Vigoroso - Air: Slow, Amoroso - Sonata da Capo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24547 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:7d0d8f86-3f22-4cd8-acec-c050c40f68c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d0d8f86-3f22-4cd8-acec-c050c40f68c7', 1, 'I', 'Sonata: Allegro, Vigoroso - Air: Slow, Amoroso - Sonata da Capo', 'A Summerfield Set: I. Sonata: Allegro, Vigoroso - Air: Slow, Amoroso - Sonata da Capo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24547 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0d8f86-3f22-4cd8-acec-c050c40f68c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ground: Moderato', part.name_en = 'A Summerfield Set: II. Ground: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24547 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f7513565-4500-4f7b-ad00-ea4e0be529bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7513565-4500-4f7b-ad00-ea4e0be529bb', 2, 'II', 'Ground: Moderato', 'A Summerfield Set: II. Ground: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24547 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7513565-4500-4f7b-ad00-ea4e0be529bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Round for the Triumph of Alexander: Fastish, Vigorous', part.name_en = 'A Summerfield Set: III. Round for the Triumph of Alexander: Fastish, Vigorous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24547 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3efa4d1d-c47d-4524-80b7-46755cac25f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3efa4d1d-c47d-4524-80b7-46755cac25f0', 3, 'III', 'Round for the Triumph of Alexander: Fastish, Vigorous', 'A Summerfield Set: III. Round for the Triumph of Alexander: Fastish, Vigorous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24547 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3efa4d1d-c47d-4524-80b7-46755cac25f0'
);


-- None Air

UPDATE pieces piece
SET piece.title = 'Air', piece.title_en = 'Air',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24333 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ariadne

UPDATE pieces piece
SET piece.title = 'Ariadne', piece.title_en = 'Ariadne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25369 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ariadne Abandoned', part.name_en = 'Ariadne: Ariadne Abandoned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25369 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2d014c30-50bb-4680-af7b-ebac7b0342a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d014c30-50bb-4680-af7b-ebac7b0342a8', 1, NULL, 'Ariadne Abandoned', 'Ariadne: Ariadne Abandoned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25369 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d014c30-50bb-4680-af7b-ebac7b0342a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Triumph of Ariadne and Dionysius', part.name_en = 'Ariadne: The Triumph of Ariadne and Dionysius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25369 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a128b73a-9afd-454b-9a91-ee2420a7b6f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a128b73a-9afd-454b-9a91-ee2420a7b6f3', 2, NULL, 'The Triumph of Ariadne and Dionysius', 'Ariadne: The Triumph of Ariadne and Dionysius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25369 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a128b73a-9afd-454b-9a91-ee2420a7b6f3'
);


-- None At the Tomb of Charles Ives

UPDATE pieces piece
SET piece.title = 'At the Tomb of Charles Ives', piece.title_en = 'At the Tomb of Charles Ives',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24942 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Avalokiteshvara

UPDATE pieces piece
SET piece.title = 'Avalokiteshvara', piece.title_en = 'Avalokiteshvara',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24011 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bomba

UPDATE pieces piece
SET piece.title = 'Bomba', piece.title_en = 'Bomba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25194 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bubaran Robert

UPDATE pieces piece
SET piece.title = 'Bubaran Robert', piece.title_en = 'Bubaran Robert',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25243 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle Nº 3

UPDATE pieces piece
SET piece.title = 'Canticle Nº 3', piece.title_en = 'Canticle Nº 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23587 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle no. 1

UPDATE pieces piece
SET piece.title = 'Canticle no. 1', piece.title_en = 'Canticle no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24168 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Organ with Percussion Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Organ with Percussion Orchestra', piece.title_en = 'Concerto for Organ with Percussion Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25386 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Organ with Percussion Orchestra: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25386 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cf907f7f-c500-44c1-b871-26cec337fd0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf907f7f-c500-44c1-b871-26cec337fd0f', 1, 'I', 'Allegro', 'Concerto for Organ with Percussion Orchestra: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25386 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf907f7f-c500-44c1-b871-26cec337fd0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante (Siciliana in the form of a Double Canon)', part.name_en = 'Concerto for Organ with Percussion Orchestra: II. Andante (Siciliana in the form of a Double Canon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25386 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6605c38a-191a-4dbc-ad59-2993f97e3a30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6605c38a-191a-4dbc-ad59-2993f97e3a30', 2, 'II', 'Andante (Siciliana in the form of a Double Canon)', 'Concerto for Organ with Percussion Orchestra: II. Andante (Siciliana in the form of a Double Canon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25386 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6605c38a-191a-4dbc-ad59-2993f97e3a30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'Concerto for Organ with Percussion Orchestra: III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25386 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8a85518b-5571-4d3f-b391-f5e4637b3078' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a85518b-5571-4d3f-b391-f5e4637b3078', 3, 'III', 'Largo', 'Concerto for Organ with Percussion Orchestra: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25386 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a85518b-5571-4d3f-b391-f5e4637b3078'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Canons and Choruses (Moderato)', part.name_en = 'Concerto for Organ with Percussion Orchestra: IV. Canons and Choruses (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25386 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1b6f1d62-95f8-4d2c-b848-0272856c70b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b6f1d62-95f8-4d2c-b848-0272856c70b8', 4, 'IV', 'Canons and Choruses (Moderato)', 'Concerto for Organ with Percussion Orchestra: IV. Canons and Choruses (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25386 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b6f1d62-95f8-4d2c-b848-0272856c70b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale (Allegro)', part.name_en = 'Concerto for Organ with Percussion Orchestra: V. Finale (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25386 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e8c51a68-00a6-4616-86c3-b4841271f976' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8c51a68-00a6-4616-86c3-b4841271f976', 5, 'V', 'Finale (Allegro)', 'Concerto for Organ with Percussion Orchestra: V. Finale (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25386 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8c51a68-00a6-4616-86c3-b4841271f976'
);


-- None Concerto for Piano with Javanese Gamelan

UPDATE pieces piece
SET piece.title = 'Concerto for Piano with Javanese Gamelan', piece.title_en = 'Concerto for Piano with Javanese Gamelan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23290 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Bull’s Belle', part.name_en = 'Concerto for Piano with Javanese Gamelan: I. Bull’s Belle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23290 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6c243fb3-e468-43f0-b80b-5efb2cd504c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c243fb3-e468-43f0-b80b-5efb2cd504c7', 1, 'I', 'Bull’s Belle', 'Concerto for Piano with Javanese Gamelan: I. Bull’s Belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23290 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c243fb3-e468-43f0-b80b-5efb2cd504c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Untitled', part.name_en = 'Concerto for Piano with Javanese Gamelan: II. Untitled',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23290 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:684174e4-1194-4bf1-8544-f38d6045944d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684174e4-1194-4bf1-8544-f38d6045944d', 2, 'II', 'Untitled', 'Concerto for Piano with Javanese Gamelan: II. Untitled', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23290 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684174e4-1194-4bf1-8544-f38d6045944d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Belle’s Bull', part.name_en = 'Concerto for Piano with Javanese Gamelan: III. Belle’s Bull',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23290 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:866e69d6-7d69-4d09-88db-8cf705fdac68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866e69d6-7d69-4d09-88db-8cf705fdac68', 3, 'III', 'Belle’s Bull', 'Concerto for Piano with Javanese Gamelan: III. Belle’s Bull', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23290 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866e69d6-7d69-4d09-88db-8cf705fdac68'
);


-- None Concerto for Violin and Percussion Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Violin and Percussion Orchestra', piece.title_en = 'Concerto for Violin and Percussion Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23057 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Concerto for Violin and Percussion Orchestra: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23057 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f4bedd8c-5082-438e-a3b1-ec2ffbadbde3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4bedd8c-5082-438e-a3b1-ec2ffbadbde3', 1, 'I', 'Allegro maestoso', 'Concerto for Violin and Percussion Orchestra: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23057 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4bedd8c-5082-438e-a3b1-ec2ffbadbde3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo, cantabile', part.name_en = 'Concerto for Violin and Percussion Orchestra: II. Largo, cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23057 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4329a106-5d5d-4057-94bd-d3d53fb6d935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4329a106-5d5d-4057-94bd-d3d53fb6d935', 2, 'II', 'Largo, cantabile', 'Concerto for Violin and Percussion Orchestra: II. Largo, cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23057 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4329a106-5d5d-4057-94bd-d3d53fb6d935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, vigoroso, poco presto', part.name_en = 'Concerto for Violin and Percussion Orchestra: III. Allegro, vigoroso, poco presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23057 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ddf80556-80f5-4fa3-8d7c-a467c3d7ff45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf80556-80f5-4fa3-8d7c-a467c3d7ff45', 3, 'III', 'Allegro, vigoroso, poco presto', 'Concerto for Violin and Percussion Orchestra: III. Allegro, vigoroso, poco presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23057 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf80556-80f5-4fa3-8d7c-a467c3d7ff45'
);


-- None Concerto in Slendro

UPDATE pieces piece
SET piece.title = 'Concerto in Slendro', piece.title_en = 'Concerto in Slendro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24544 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto in Slendro: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24544 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:08c12c27-7608-4f78-9de0-7cc71c91e3a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08c12c27-7608-4f78-9de0-7cc71c91e3a1', 1, 'I', 'Allegro', 'Concerto in Slendro: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24544 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08c12c27-7608-4f78-9de0-7cc71c91e3a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto adagio', part.name_en = 'Concerto in Slendro: II. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24544 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:866dd05c-569d-464d-9b15-fcf8957d9298' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866dd05c-569d-464d-9b15-fcf8957d9298', 2, 'II', 'Molto adagio', 'Concerto in Slendro: II. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24544 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866dd05c-569d-464d-9b15-fcf8957d9298'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, molto vigoroso', part.name_en = 'Concerto in Slendro: III. Allegro, molto vigoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24544 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a96691bc-1926-4ae2-a1e2-4c63389914b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a96691bc-1926-4ae2-a1e2-4c63389914b4', 3, 'III', 'Allegro, molto vigoroso', 'Concerto in Slendro: III. Allegro, molto vigoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24544 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a96691bc-1926-4ae2-a1e2-4c63389914b4'
);


-- None 협주곡 1번

UPDATE pieces piece
SET piece.title = '협주곡 1번', piece.title_en = 'Concerto no. 1 for Flute and Percussion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17671 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Earnest, fresh, and fastish', part.name_en = 'Concerto no. 1 for Flute and Percussion: I. Earnest, fresh, and fastish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17671 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:70a0884b-685a-4b5f-aea1-18f0be508647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70a0884b-685a-4b5f-aea1-18f0be508647', 1, 'I', 'Earnest, fresh, and fastish', 'Concerto no. 1 for Flute and Percussion: I. Earnest, fresh, and fastish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17671 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a0884b-685a-4b5f-aea1-18f0be508647'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow and poignant', part.name_en = 'Concerto no. 1 for Flute and Percussion: II. Slow and poignant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17671 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:589845a3-93a6-465a-a55c-71881e402a0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:589845a3-93a6-465a-a55c-71881e402a0c', 2, 'II', 'Slow and poignant', 'Concerto no. 1 for Flute and Percussion: II. Slow and poignant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17671 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:589845a3-93a6-465a-a55c-71881e402a0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Strong, swinging, and fastish', part.name_en = 'Concerto no. 1 for Flute and Percussion: III. Strong, swinging, and fastish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17671 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:5fa7fa72-ee32-4bc1-b9b7-9bf92db232f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa7fa72-ee32-4bc1-b9b7-9bf92db232f9', 3, 'III', 'Strong, swinging, and fastish', 'Concerto no. 1 for Flute and Percussion: III. Strong, swinging, and fastish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17671 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa7fa72-ee32-4bc1-b9b7-9bf92db232f9'
);


-- None Cornish Lancaran

UPDATE pieces piece
SET piece.title = 'Cornish Lancaran', piece.title_en = 'Cornish Lancaran',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24441 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ditone Set

UPDATE pieces piece
SET piece.title = 'Ditone Set', piece.title_en = 'Ditone Set',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24976 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'for guitar: Plaint', part.name_en = 'Ditone Set, for guitar: Plaint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24976 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:032b2325-f6da-44da-a40d-a6bee10de221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:032b2325-f6da-44da-a40d-a6bee10de221', 1, NULL, 'for guitar: Plaint', 'Ditone Set, for guitar: Plaint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24976 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:032b2325-f6da-44da-a40d-a6bee10de221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'for guitar: Variations on Walter von der Vogelweide''s ''Song of Palestine''', part.name_en = 'Ditone Set, for guitar: Variations on Walter von der Vogelweide''s ''Song of Palestine''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24976 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:82b9bf4d-20d1-414e-9bfa-c139c875d226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b9bf4d-20d1-414e-9bfa-c139c875d226', 2, NULL, 'for guitar: Variations on Walter von der Vogelweide''s ''Song of Palestine''', 'Ditone Set, for guitar: Variations on Walter von der Vogelweide''s ''Song of Palestine''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24976 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b9bf4d-20d1-414e-9bfa-c139c875d226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'for guitar: Estampie', part.name_en = 'Ditone Set, for guitar: Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24976 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e1e2e8f5-4c94-444a-9d90-71fa75e03056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1e2e8f5-4c94-444a-9d90-71fa75e03056', 3, NULL, 'for guitar: Estampie', 'Ditone Set, for guitar: Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24976 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1e2e8f5-4c94-444a-9d90-71fa75e03056'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'for guitar: Usul', part.name_en = 'Ditone Set, for guitar: Usul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24976 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ffec4e46-9c33-43cd-8583-daea6a65e749' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffec4e46-9c33-43cd-8583-daea6a65e749', 4, NULL, 'for guitar: Usul', 'Ditone Set, for guitar: Usul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24976 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffec4e46-9c33-43cd-8583-daea6a65e749'
);


-- None Double Concerto for Violin and Cello with Javanese Gamelan

UPDATE pieces piece
SET piece.title = 'Double Concerto for Violin and Cello with Javanese Gamelan', piece.title_en = 'Double Concerto for Violin and Cello with Javanese Gamelan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23289 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Grandly but moderate', part.name_en = 'Double Concerto for Violin and Cello with Javanese Gamelan: I. Grandly but moderate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23289 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:15b3923b-fc4a-4d04-845d-6f916f5d72ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b3923b-fc4a-4d04-845d-6f916f5d72ac', 1, 'I', 'Grandly but moderate', 'Double Concerto for Violin and Cello with Javanese Gamelan: I. Grandly but moderate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23289 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b3923b-fc4a-4d04-845d-6f916f5d72ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Stampede', part.name_en = 'Double Concerto for Violin and Cello with Javanese Gamelan: II. Stampede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23289 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:defd6e59-6cb7-4ed8-83b7-45695fd11f1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:defd6e59-6cb7-4ed8-83b7-45695fd11f1a', 2, 'II', 'Stampede', 'Double Concerto for Violin and Cello with Javanese Gamelan: II. Stampede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23289 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:defd6e59-6cb7-4ed8-83b7-45695fd11f1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Double Concerto for Violin and Cello with Javanese Gamelan: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23289 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c6396cb3-c32e-48f2-bee7-38ab708cc774' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6396cb3-c32e-48f2-bee7-38ab708cc774', 3, 'III', 'Allegro moderato', 'Double Concerto for Violin and Cello with Javanese Gamelan: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23289 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6396cb3-c32e-48f2-bee7-38ab708cc774'
);


-- None Fifth Simfony

UPDATE pieces piece
SET piece.title = 'Fifth Simfony', piece.title_en = 'Fifth Simfony',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24066 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vigorous', part.name_en = 'Fifth Simfony: I. Vigorous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24066 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1b9d33f6-fb91-4437-81d5-07f656edf7b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b9d33f6-fb91-4437-81d5-07f656edf7b2', 1, 'I', 'Vigorous', 'Fifth Simfony: I. Vigorous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24066 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b9d33f6-fb91-4437-81d5-07f656edf7b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow and dramatic', part.name_en = 'Fifth Simfony: II. Slow and dramatic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24066 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:5c164ddf-ad5f-4ae1-81eb-83df76f2b579' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c164ddf-ad5f-4ae1-81eb-83df76f2b579', 2, 'II', 'Slow and dramatic', 'Fifth Simfony: II. Slow and dramatic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24066 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c164ddf-ad5f-4ae1-81eb-83df76f2b579'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Brisk', part.name_en = 'Fifth Simfony: III. Brisk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24066 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8396eb4b-f334-4f6d-a97a-9930760ed5ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8396eb4b-f334-4f6d-a97a-9930760ed5ee', 3, 'III', 'Brisk', 'Fifth Simfony: III. Brisk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24066 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8396eb4b-f334-4f6d-a97a-9930760ed5ee'
);


-- None Fugue for Percussion

UPDATE pieces piece
SET piece.title = 'Fugue for Percussion', piece.title_en = 'Fugue for Percussion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23080 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gending Alexander

UPDATE pieces piece
SET piece.title = 'Gending Alexander', piece.title_en = 'Gending Alexander',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25818 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gending Pak Chokro

UPDATE pieces piece
SET piece.title = 'Gending Pak Chokro', piece.title_en = 'Gending Pak Chokro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25175 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gending in Honor of Aphrodite

UPDATE pieces piece
SET piece.title = 'Gending in Honor of Aphrodite', piece.title_en = 'Gending in Honor of Aphrodite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25989 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gigue & Musette

UPDATE pieces piece
SET piece.title = 'Gigue & Musette', piece.title_en = 'Gigue & Musette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24298 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Grand Duo

UPDATE pieces piece
SET piece.title = 'Grand Duo', piece.title_en = 'Grand Duo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25160 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Grand Duo: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25160 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8462cd7b-4bfa-45a9-b5fb-f3951256421e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8462cd7b-4bfa-45a9-b5fb-f3951256421e', 1, 'I', 'Prelude', 'Grand Duo: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25160 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8462cd7b-4bfa-45a9-b5fb-f3951256421e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Stampede', part.name_en = 'Grand Duo: II. Stampede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25160 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8d177348-75c7-4c26-9967-94689be39f0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d177348-75c7-4c26-9967-94689be39f0a', 2, 'II', 'Stampede', 'Grand Duo: II. Stampede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25160 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d177348-75c7-4c26-9967-94689be39f0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A Round (Annable & April''s)', part.name_en = 'Grand Duo: III. A Round (Annable & April''s)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25160 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:11fc0b68-c260-453f-8916-a51440273108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11fc0b68-c260-453f-8916-a51440273108', 3, 'III', 'A Round (Annable & April''s)', 'Grand Duo: III. A Round (Annable & April''s)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25160 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11fc0b68-c260-453f-8916-a51440273108'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air', part.name_en = 'Grand Duo: IV. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25160 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8e2f37bc-532c-461d-bd57-3a9b7a95ede4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e2f37bc-532c-461d-bd57-3a9b7a95ede4', 4, 'IV', 'Air', 'Grand Duo: IV. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25160 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e2f37bc-532c-461d-bd57-3a9b7a95ede4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Polka', part.name_en = 'Grand Duo: V. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25160 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:577b4b87-01d7-4dac-9973-5b92d0154e94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:577b4b87-01d7-4dac-9973-5b92d0154e94', 5, 'V', 'Polka', 'Grand Duo: V. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25160 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:577b4b87-01d7-4dac-9973-5b92d0154e94'
);


-- None 하프시코드 소나타

UPDATE pieces piece
SET piece.title = '하프시코드 소나타', piece.title_en = 'Harpsichord Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23266 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Harpsichord Sonata: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23266 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c4915243-c428-49e2-8c20-1be1c36924e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4915243-c428-49e2-8c20-1be1c36924e5', 1, 'I', 'Allegro moderato', 'Harpsichord Sonata: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23266 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4915243-c428-49e2-8c20-1be1c36924e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio, Arioso', part.name_en = 'Harpsichord Sonata: II. Adagio, Arioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23266 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:150a3577-1949-4e88-afc0-ae886aa508c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:150a3577-1949-4e88-afc0-ae886aa508c3', 2, 'II', 'Adagio, Arioso', 'Harpsichord Sonata: II. Adagio, Arioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23266 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:150a3577-1949-4e88-afc0-ae886aa508c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Estampie', part.name_en = 'Harpsichord Sonata: III. Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23266 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:da2fcf6b-d1df-4140-9d55-f61c5ee29a1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da2fcf6b-d1df-4140-9d55-f61c5ee29a1e', 3, 'III', 'Estampie', 'Harpsichord Sonata: III. Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23266 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da2fcf6b-d1df-4140-9d55-f61c5ee29a1e'
);


-- None Homage to Pacifica

UPDATE pieces piece
SET piece.title = 'Homage to Pacifica', piece.title_en = 'Homage to Pacifica',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25300 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Homage to Pacifica: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f5fdd327-1da0-4581-99cd-a15e11c8a7b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5fdd327-1da0-4581-99cd-a15e11c8a7b4', 1, 'I', 'Prelude', 'Homage to Pacifica: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5fdd327-1da0-4581-99cd-a15e11c8a7b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In Honor of the Divine Mr. Handel', part.name_en = 'Homage to Pacifica: II. In Honor of the Divine Mr. Handel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4733d2a2-aaf1-4a5d-8da6-588ac93cdcec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4733d2a2-aaf1-4a5d-8da6-588ac93cdcec', 2, 'II', 'In Honor of the Divine Mr. Handel', 'Homage to Pacifica: II. In Honor of the Divine Mr. Handel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4733d2a2-aaf1-4a5d-8da6-588ac93cdcec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In Honor of Mr. Mark Twain', part.name_en = 'Homage to Pacifica: III. In Honor of Mr. Mark Twain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:b6fba914-0f6a-4866-a764-35420038e35d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6fba914-0f6a-4866-a764-35420038e35d', 3, 'III', 'In Honor of Mr. Mark Twain', 'Homage to Pacifica: III. In Honor of Mr. Mark Twain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6fba914-0f6a-4866-a764-35420038e35d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Interlude', part.name_en = 'Homage to Pacifica: IV. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ca8ff3c4-9a13-48c4-8723-f73fdbf30ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca8ff3c4-9a13-48c4-8723-f73fdbf30ce5', 4, 'IV', 'Interlude', 'Homage to Pacifica: IV. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca8ff3c4-9a13-48c4-8723-f73fdbf30ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ode', part.name_en = 'Homage to Pacifica: V. Ode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ce15e9b3-b561-451b-82e8-6eb122336195' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce15e9b3-b561-451b-82e8-6eb122336195', 5, 'V', 'Ode', 'Homage to Pacifica: V. Ode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce15e9b3-b561-451b-82e8-6eb122336195'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Interlude', part.name_en = 'Homage to Pacifica: VI. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4fef545c-08b2-4e91-89f3-8eec76cb8b01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fef545c-08b2-4e91-89f3-8eec76cb8b01', 6, 'VI', 'Interlude', 'Homage to Pacifica: VI. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fef545c-08b2-4e91-89f3-8eec76cb8b01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Litany', part.name_en = 'Homage to Pacifica: VII. Litany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:539a0058-a58f-4a52-8100-401effa2057a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:539a0058-a58f-4a52-8100-401effa2057a', 7, 'VII', 'Litany', 'Homage to Pacifica: VII. Litany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:539a0058-a58f-4a52-8100-401effa2057a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'In Honor of Chief Seattle', part.name_en = 'Homage to Pacifica: VIII. In Honor of Chief Seattle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25300 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c9ab7a84-665c-4435-890b-0ed58a48419f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9ab7a84-665c-4435-890b-0ed58a48419f', 8, 'VIII', 'In Honor of Chief Seattle', 'Homage to Pacifica: VIII. In Honor of Chief Seattle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25300 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9ab7a84-665c-4435-890b-0ed58a48419f'
);


-- None In Honor of Munakata Shiko

UPDATE pieces piece
SET piece.title = 'In Honor of Munakata Shiko', piece.title_en = 'In Honor of Munakata Shiko',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25773 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Honor of the Divine Mr. Handel

UPDATE pieces piece
SET piece.title = 'In Honor of the Divine Mr. Handel', piece.title_en = 'In Honor of the Divine Mr. Handel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23824 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Incidental Music for Corneille's "Cinna"

UPDATE pieces piece
SET piece.title = 'Incidental Music for Corneille''s "Cinna"', piece.title_en = 'Incidental Music for Corneille''s "Cinna"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25154 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Medium Fast', part.name_en = 'Incidental Music for Corneille''s "Cinna": I. Medium Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25154 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:89414bf8-825a-479c-8b7f-2f613180d6a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89414bf8-825a-479c-8b7f-2f613180d6a9', 1, 'I', 'Medium Fast', 'Incidental Music for Corneille''s "Cinna": I. Medium Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25154 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89414bf8-825a-479c-8b7f-2f613180d6a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow', part.name_en = 'Incidental Music for Corneille''s "Cinna": II. Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25154 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:af77bc78-db52-4c42-b019-47731dfb2a27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af77bc78-db52-4c42-b019-47731dfb2a27', 2, 'II', 'Slow', 'Incidental Music for Corneille''s "Cinna": II. Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25154 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af77bc78-db52-4c42-b019-47731dfb2a27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fast', part.name_en = 'Incidental Music for Corneille''s "Cinna": III. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25154 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0ad61339-3417-4d1e-8063-934bb36d9bca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad61339-3417-4d1e-8063-934bb36d9bca', 3, 'III', 'Fast', 'Incidental Music for Corneille''s "Cinna": III. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25154 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad61339-3417-4d1e-8063-934bb36d9bca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Medium Fast', part.name_en = 'Incidental Music for Corneille''s "Cinna": IV. Medium Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25154 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e5ef512f-6c54-4b34-943f-666fb1d69621' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5ef512f-6c54-4b34-943f-666fb1d69621', 4, 'IV', 'Medium Fast', 'Incidental Music for Corneille''s "Cinna": IV. Medium Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25154 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5ef512f-6c54-4b34-943f-666fb1d69621'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Grand', part.name_en = 'Incidental Music for Corneille''s "Cinna": V. Grand',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25154 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:804529a7-0fe8-48d8-95de-19f648b8a293' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:804529a7-0fe8-48d8-95de-19f648b8a293', 5, 'V', 'Grand', 'Incidental Music for Corneille''s "Cinna": V. Grand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25154 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:804529a7-0fe8-48d8-95de-19f648b8a293'
);


-- None Jarabe

UPDATE pieces piece
SET piece.title = 'Jarabe', piece.title_en = 'Jarabe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23567 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <King David's Lament for Jonathan>

UPDATE pieces piece
SET piece.title = '가곡 <King David''s Lament for Jonathan>', piece.title_en = 'King David''s Lament for Jonathan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23374 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Koro Sutro

UPDATE pieces piece
SET piece.title = 'La Koro Sutro', piece.title_en = 'La Koro Sutro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25909 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kunsonoro kaj Gloro', part.name_en = 'La Koro Sutro: Kunsonoro kaj Gloro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6ed6aa58-f497-4f2a-91b6-a2325d24ad72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ed6aa58-f497-4f2a-91b6-a2325d24ad72', 1, NULL, 'Kunsonoro kaj Gloro', 'La Koro Sutro: Kunsonoro kaj Gloro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ed6aa58-f497-4f2a-91b6-a2325d24ad72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Strofo 1', part.name_en = 'La Koro Sutro: Strofo 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f36ee2c1-4dbf-4167-86a3-6e09fd3a5175' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f36ee2c1-4dbf-4167-86a3-6e09fd3a5175', 2, NULL, 'Strofo 1', 'La Koro Sutro: Strofo 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36ee2c1-4dbf-4167-86a3-6e09fd3a5175'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Strofo 2', part.name_en = 'La Koro Sutro: Strofo 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d5bc7103-5036-46e9-bc65-25efd0727e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5bc7103-5036-46e9-bc65-25efd0727e42', 3, NULL, 'Strofo 2', 'La Koro Sutro: Strofo 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5bc7103-5036-46e9-bc65-25efd0727e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Strofo 3', part.name_en = 'La Koro Sutro: Strofo 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fc320a7b-475b-40d8-b7e4-c05948086f61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc320a7b-475b-40d8-b7e4-c05948086f61', 4, NULL, 'Strofo 3', 'La Koro Sutro: Strofo 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc320a7b-475b-40d8-b7e4-c05948086f61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Strofo 4', part.name_en = 'La Koro Sutro: Strofo 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6bf433d8-381e-4019-80c1-a2df05398564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bf433d8-381e-4019-80c1-a2df05398564', 5, NULL, 'Strofo 4', 'La Koro Sutro: Strofo 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bf433d8-381e-4019-80c1-a2df05398564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Strofo 5', part.name_en = 'La Koro Sutro: Strofo 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1fe5c835-7490-41df-99d9-d8775fb81492' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fe5c835-7490-41df-99d9-d8775fb81492', 6, NULL, 'Strofo 5', 'La Koro Sutro: Strofo 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fe5c835-7490-41df-99d9-d8775fb81492'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Strofo 6', part.name_en = 'La Koro Sutro: Strofo 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:94bc535a-2d9a-439c-881e-ff3fcd5415ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94bc535a-2d9a-439c-881e-ff3fcd5415ee', 7, NULL, 'Strofo 6', 'La Koro Sutro: Strofo 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94bc535a-2d9a-439c-881e-ff3fcd5415ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Strofo 7', part.name_en = 'La Koro Sutro: Strofo 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25909 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:53376669-65a0-4ae8-bb0e-126584144716' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53376669-65a0-4ae8-bb0e-126584144716', 8, NULL, 'Strofo 7', 'La Koro Sutro: Strofo 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25909 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53376669-65a0-4ae8-bb0e-126584144716'
);


-- None Labrynth no. 3

UPDATE pieces piece
SET piece.title = 'Labrynth no. 3', piece.title_en = 'Labrynth no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25646 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ode', part.name_en = 'Labrynth no. 3: I. Ode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25646 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e19c1f67-a2ca-4d12-a8d1-89c949be993f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e19c1f67-a2ca-4d12-a8d1-89c949be993f', 1, 'I', 'Ode', 'Labrynth no. 3: I. Ode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25646 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e19c1f67-a2ca-4d12-a8d1-89c949be993f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Passage Thru Dreams', part.name_en = 'Labrynth no. 3: II. Passage Thru Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25646 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2501abb7-998c-451c-a4b3-f15ba210cda0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2501abb7-998c-451c-a4b3-f15ba210cda0', 2, 'II', 'Passage Thru Dreams', 'Labrynth no. 3: II. Passage Thru Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25646 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2501abb7-998c-451c-a4b3-f15ba210cda0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Seed', part.name_en = 'Labrynth no. 3: III. Seed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25646 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:703f72ca-7b74-4ac7-b2d1-378f69f9550e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:703f72ca-7b74-4ac7-b2d1-378f69f9550e', 3, 'III', 'Seed', 'Labrynth no. 3: III. Seed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25646 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703f72ca-7b74-4ac7-b2d1-378f69f9550e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Image in the Soil', part.name_en = 'Labrynth no. 3: IV. Image in the Soil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25646 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a2766adc-3ac0-4bcc-b66b-ed68b39d999f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2766adc-3ac0-4bcc-b66b-ed68b39d999f', 4, 'IV', 'Image in the Soil', 'Labrynth no. 3: IV. Image in the Soil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25646 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2766adc-3ac0-4bcc-b66b-ed68b39d999f'
);


-- None Labyrinth no. 3

UPDATE pieces piece
SET piece.title = 'Labyrinth no. 3', piece.title_en = 'Labyrinth no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25757 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Labyrinth no. 3: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25757 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:85a2d5b9-2b65-4bed-af9c-a3892c83df7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85a2d5b9-2b65-4bed-af9c-a3892c83df7f', 1, 'I', 'Allegro moderato', 'Labyrinth no. 3: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25757 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a2d5b9-2b65-4bed-af9c-a3892c83df7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Labyrinth no. 3: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25757 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a01c192b-8042-42c3-a0df-3ecda2f388a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a01c192b-8042-42c3-a0df-3ecda2f388a5', 2, 'II', 'Adagio', 'Labyrinth no. 3: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25757 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a01c192b-8042-42c3-a0df-3ecda2f388a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Labyrinth no. 3: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25757 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:46081a2a-4328-4daf-8316-7682f4d8b0ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46081a2a-4328-4daf-8316-7682f4d8b0ca', 3, 'III', 'Adagio', 'Labyrinth no. 3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25757 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46081a2a-4328-4daf-8316-7682f4d8b0ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato maestoso', part.name_en = 'Labyrinth no. 3: IV. Allegro moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25757 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ba4f376d-8287-433e-abc7-899b38c4964e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba4f376d-8287-433e-abc7-899b38c4964e', 4, 'IV', 'Allegro moderato maestoso', 'Labyrinth no. 3: IV. Allegro moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25757 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4f376d-8287-433e-abc7-899b38c4964e'
);


-- None Largo ostinato

UPDATE pieces piece
SET piece.title = 'Largo ostinato', piece.title_en = 'Largo ostinato',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24119 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Main Bersama-Sama

UPDATE pieces piece
SET piece.title = 'Main Bersama-Sama', piece.title_en = 'Main Bersama-Sama',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23718 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mass for St. Cecilia's Day

UPDATE pieces piece
SET piece.title = 'Mass for St. Cecilia''s Day', piece.title_en = 'Mass for St. Cecilia''s Day',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23199 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introitus', part.name_en = 'Mass for St. Cecilia''s Day: Introitus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9aac777e-7533-444d-aaf5-7623113ebb8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aac777e-7533-444d-aaf5-7623113ebb8f', 1, NULL, 'Introitus', 'Mass for St. Cecilia''s Day: Introitus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aac777e-7533-444d-aaf5-7623113ebb8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Mass for St. Cecilia''s Day: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3cebb20a-ca18-4aa5-95b6-44f910497445' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cebb20a-ca18-4aa5-95b6-44f910497445', 2, NULL, 'Kyrie', 'Mass for St. Cecilia''s Day: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cebb20a-ca18-4aa5-95b6-44f910497445'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Mass for St. Cecilia''s Day: Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4ef12361-c859-4166-a098-78a2c281565f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ef12361-c859-4166-a098-78a2c281565f', 3, NULL, 'Gloria', 'Mass for St. Cecilia''s Day: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ef12361-c859-4166-a098-78a2c281565f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Graduale', part.name_en = 'Mass for St. Cecilia''s Day: Graduale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9bd9c8e7-8bf5-4cb3-8064-211c6d01f371' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bd9c8e7-8bf5-4cb3-8064-211c6d01f371', 4, NULL, 'Graduale', 'Mass for St. Cecilia''s Day: Graduale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bd9c8e7-8bf5-4cb3-8064-211c6d01f371'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Alleluia', part.name_en = 'Mass for St. Cecilia''s Day: Alleluia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3e82c57c-1f38-46ad-9751-72adce2b6a22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e82c57c-1f38-46ad-9751-72adce2b6a22', 5, NULL, 'Alleluia', 'Mass for St. Cecilia''s Day: Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e82c57c-1f38-46ad-9751-72adce2b6a22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Offertory', part.name_en = 'Mass for St. Cecilia''s Day: Offertory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:dbe123d5-5470-4f9c-8782-6eba0d23cb6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbe123d5-5470-4f9c-8782-6eba0d23cb6c', 6, NULL, 'Offertory', 'Mass for St. Cecilia''s Day: Offertory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbe123d5-5470-4f9c-8782-6eba0d23cb6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Mass for St. Cecilia''s Day: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:74dc4cf9-b9f1-432c-9056-258563f4bea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74dc4cf9-b9f1-432c-9056-258563f4bea7', 7, NULL, 'Sanctus', 'Mass for St. Cecilia''s Day: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74dc4cf9-b9f1-432c-9056-258563f4bea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Mass for St. Cecilia''s Day: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:aa15bd93-d5d8-4684-b158-248b029ae1cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa15bd93-d5d8-4684-b158-248b029ae1cc', 8, NULL, 'Agnus Dei', 'Mass for St. Cecilia''s Day: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa15bd93-d5d8-4684-b158-248b029ae1cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Communion', part.name_en = 'Mass for St. Cecilia''s Day: Communion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:dad46ef7-8145-4702-9931-b5e1481fb22e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dad46ef7-8145-4702-9931-b5e1481fb22e', 9, NULL, 'Communion', 'Mass for St. Cecilia''s Day: Communion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dad46ef7-8145-4702-9931-b5e1481fb22e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Hymn', part.name_en = 'Mass for St. Cecilia''s Day: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6e4d6ea1-6203-493d-b49e-7cdf57a4b8b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e4d6ea1-6203-493d-b49e-7cdf57a4b8b3', 10, NULL, 'Hymn', 'Mass for St. Cecilia''s Day: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e4d6ea1-6203-493d-b49e-7cdf57a4b8b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ite', part.name_en = 'Mass for St. Cecilia''s Day: Ite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23199 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:726c6f31-c783-47c9-bd96-e3168c6d9a80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:726c6f31-c783-47c9-bd96-e3168c6d9a80', 11, NULL, 'Ite', 'Mass for St. Cecilia''s Day: Ite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23199 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:726c6f31-c783-47c9-bd96-e3168c6d9a80'
);


-- None May Rain

UPDATE pieces piece
SET piece.title = 'May Rain', piece.title_en = 'May Rain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24455 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Violin with Various Instruments – European, Asian & African

UPDATE pieces piece
SET piece.title = 'Music for Violin with Various Instruments – European, Asian & African', piece.title_en = 'Music for Violin with Various Instruments – European, Asian & African',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25184 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, Vigoroso', part.name_en = 'Music for Violin with Various Instruments – European, Asian & African: I. Allegro, Vigoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25184 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:26ac1cfe-4b2c-45db-bcc7-bb0e94b588c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26ac1cfe-4b2c-45db-bcc7-bb0e94b588c5', 1, 'I', 'Allegro, Vigoroso', 'Music for Violin with Various Instruments – European, Asian & African: I. Allegro, Vigoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25184 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26ac1cfe-4b2c-45db-bcc7-bb0e94b588c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Music for Violin with Various Instruments – European, Asian & African: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25184 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8c97d648-0ba6-4dd4-abf8-1806f1e4cf36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c97d648-0ba6-4dd4-abf8-1806f1e4cf36', 2, 'II', 'Largo', 'Music for Violin with Various Instruments – European, Asian & African: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25184 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c97d648-0ba6-4dd4-abf8-1806f1e4cf36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Music for Violin with Various Instruments – European, Asian & African: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25184 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:caf22805-eb41-4e13-b809-3ce50002f57b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf22805-eb41-4e13-b809-3ce50002f57b', 3, 'III', 'Allegro moderato', 'Music for Violin with Various Instruments – European, Asian & African: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25184 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf22805-eb41-4e13-b809-3ce50002f57b'
);


-- None New First Suite for Strings

UPDATE pieces piece
SET piece.title = 'New First Suite for Strings', piece.title_en = 'New First Suite for Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24482 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None New York Waltzes

UPDATE pieces piece
SET piece.title = 'New York Waltzes', piece.title_en = 'New York Waltzes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23505 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'New York Waltzes: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23505 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9741e332-918a-4c4b-a4c5-6d0654749591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9741e332-918a-4c4b-a4c5-6d0654749591', 1, NULL, 'I', 'New York Waltzes: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23505 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9741e332-918a-4c4b-a4c5-6d0654749591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'New York Waltzes: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23505 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4e82c53e-99d4-4c3a-b229-f134d28deb9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e82c53e-99d4-4c3a-b229-f134d28deb9d', 2, NULL, 'II', 'New York Waltzes: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23505 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e82c53e-99d4-4c3a-b229-f134d28deb9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'New York Waltzes: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23505 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:11bdfa7b-5924-4167-8ffa-53b808a4d6a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11bdfa7b-5924-4167-8ffa-53b808a4d6a5', 3, NULL, 'III', 'New York Waltzes: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23505 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11bdfa7b-5924-4167-8ffa-53b808a4d6a5'
);


-- None 가곡 <Oh You Whom I Often & Silently Come>

UPDATE pieces piece
SET piece.title = '가곡 <Oh You Whom I Often & Silently Come>', piece.title_en = 'Oh You Whom I Often & Silently Come',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24186 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Philemon and Baukis

UPDATE pieces piece
SET piece.title = 'Philemon and Baukis', piece.title_en = 'Philemon and Baukis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25293 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pipa Concerto

UPDATE pieces piece
SET piece.title = 'Pipa Concerto', piece.title_en = 'Pipa Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24972 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Pipa Concerto: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a41bf1ec-c840-4370-aef2-8dd59809f937' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a41bf1ec-c840-4370-aef2-8dd59809f937', 1, 'I', 'Allegro', 'Pipa Concerto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41bf1ec-c840-4370-aef2-8dd59809f937'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bits and Pieces', part.name_en = 'Pipa Concerto: II. Bits and Pieces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773', 2, 'II', 'Bits and Pieces', 'Pipa Concerto: II. Bits and Pieces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Three Sharing', part.name_en = 'Pipa Concerto: II. Bits and Pieces: Three Sharing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2af3869f-3bcb-44c8-8161-b7d174552bcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2af3869f-3bcb-44c8-8161-b7d174552bcf', 1, NULL, 'Three Sharing', 'Pipa Concerto: II. Bits and Pieces: Three Sharing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af3869f-3bcb-44c8-8161-b7d174552bcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Troika', part.name_en = 'Pipa Concerto: II. Bits and Pieces: Troika',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:332920cf-75a1-4953-aee6-c0441a36eff8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:332920cf-75a1-4953-aee6-c0441a36eff8', 2, NULL, 'Troika', 'Pipa Concerto: II. Bits and Pieces: Troika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:332920cf-75a1-4953-aee6-c0441a36eff8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Neapolitan', part.name_en = 'Pipa Concerto: II. Bits and Pieces: Neapolitan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6e2f6619-d3a6-445a-9a92-ee4be154fa19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e2f6619-d3a6-445a-9a92-ee4be154fa19', 3, NULL, 'Neapolitan', 'Pipa Concerto: II. Bits and Pieces: Neapolitan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e2f6619-d3a6-445a-9a92-ee4be154fa19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '"Wind and Plum"', part.name_en = 'Pipa Concerto: II. Bits and Pieces: "Wind and Plum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:dd892cdd-c5f4-4309-b379-2151edd79840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd892cdd-c5f4-4309-b379-2151edd79840', 4, NULL, '"Wind and Plum"', 'Pipa Concerto: II. Bits and Pieces: "Wind and Plum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bed58ead-c651-4085-8917-ccb807445773'
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd892cdd-c5f4-4309-b379-2151edd79840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Threnody for Richard Locke', part.name_en = 'Pipa Concerto: III. Threnody for Richard Locke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9356f833-17ed-419d-9fef-f929b53d15e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9356f833-17ed-419d-9fef-f929b53d15e8', 3, 'III', 'Threnody for Richard Locke', 'Pipa Concerto: III. Threnody for Richard Locke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9356f833-17ed-419d-9fef-f929b53d15e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Estampie', part.name_en = 'Pipa Concerto: IV. Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24972 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:bdadd1fa-a22e-4f15-b8c2-a7c6c4d9ef05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdadd1fa-a22e-4f15-b8c2-a7c6c4d9ef05', 4, 'IV', 'Estampie', 'Pipa Concerto: IV. Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24972 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdadd1fa-a22e-4f15-b8c2-a7c6c4d9ef05'
);


-- None Rhymes With Silver

UPDATE pieces piece
SET piece.title = 'Rhymes With Silver', piece.title_en = 'Rhymes With Silver',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23667 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Rhymes With Silver: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:31da6414-2347-47c3-aa7d-ffb4a64ea1a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31da6414-2347-47c3-aa7d-ffb4a64ea1a6', 1, NULL, 'Prelude', 'Rhymes With Silver: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31da6414-2347-47c3-aa7d-ffb4a64ea1a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Rhymes With Silver: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cef92083-f3d2-4e35-8ab6-e811c8f2c654' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cef92083-f3d2-4e35-8ab6-e811c8f2c654', 2, NULL, 'Allegro', 'Rhymes With Silver: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cef92083-f3d2-4e35-8ab6-e811c8f2c654'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scherzo', part.name_en = 'Rhymes With Silver: Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:259a231f-93cd-4c50-80a6-6dd40775b677' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:259a231f-93cd-4c50-80a6-6dd40775b677', 3, NULL, 'Scherzo', 'Rhymes With Silver: Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259a231f-93cd-4c50-80a6-6dd40775b677'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ductia', part.name_en = 'Rhymes With Silver: Ductia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3652bbf6-a469-4e52-8e59-3691d66a789f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3652bbf6-a469-4e52-8e59-3691d66a789f', 4, NULL, 'Ductia', 'Rhymes With Silver: Ductia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3652bbf6-a469-4e52-8e59-3691d66a789f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gigue & Musette', part.name_en = 'Rhymes With Silver: Gigue & Musette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0b8dc979-88af-48fc-891b-b2f0f9d7be8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b8dc979-88af-48fc-891b-b2f0f9d7be8f', 5, NULL, 'Gigue & Musette', 'Rhymes With Silver: Gigue & Musette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b8dc979-88af-48fc-891b-b2f0f9d7be8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Chromatic Rhapsody', part.name_en = 'Rhymes With Silver: Chromatic Rhapsody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ac9a150e-53f1-4b94-8e21-fe9c0cc953e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac9a150e-53f1-4b94-8e21-fe9c0cc953e1', 6, NULL, 'Chromatic Rhapsody', 'Rhymes With Silver: Chromatic Rhapsody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac9a150e-53f1-4b94-8e21-fe9c0cc953e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Romantic Waltz', part.name_en = 'Rhymes With Silver: Romantic Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3e37d58e-188d-4bdb-a3cf-86151c80d09a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e37d58e-188d-4bdb-a3cf-86151c80d09a', 7, NULL, 'Romantic Waltz', 'Rhymes With Silver: Romantic Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e37d58e-188d-4bdb-a3cf-86151c80d09a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fox Trot', part.name_en = 'Rhymes With Silver: Fox Trot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4fc9bc37-f776-4c79-a422-706a16fd8411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fc9bc37-f776-4c79-a422-706a16fd8411', 8, NULL, 'Fox Trot', 'Rhymes With Silver: Fox Trot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fc9bc37-f776-4c79-a422-706a16fd8411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Threnody', part.name_en = 'Rhymes With Silver: Threnody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a75d19df-b7b0-4abc-903f-893987e508e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a75d19df-b7b0-4abc-903f-893987e508e3', 9, NULL, 'Threnody', 'Rhymes With Silver: Threnody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a75d19df-b7b0-4abc-903f-893987e508e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'In Honor of Prince Kantemir', part.name_en = 'Rhymes With Silver: In Honor of Prince Kantemir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:eaf02f85-901c-426b-9100-d8c370523799' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaf02f85-901c-426b-9100-d8c370523799', 10, NULL, 'In Honor of Prince Kantemir', 'Rhymes With Silver: In Honor of Prince Kantemir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaf02f85-901c-426b-9100-d8c370523799'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Five-Tone Kit', part.name_en = 'Rhymes With Silver: Five-Tone Kit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:5f672fb5-3487-4a1a-8b40-d432fee63bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f672fb5-3487-4a1a-8b40-d432fee63bdc', 11, NULL, 'Five-Tone Kit', 'Rhymes With Silver: Five-Tone Kit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f672fb5-3487-4a1a-8b40-d432fee63bdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Round Dance', part.name_en = 'Rhymes With Silver: Round Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23667 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0dc5335f-cf0b-49fa-8919-ec72f71a8ebd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dc5335f-cf0b-49fa-8919-ec72f71a8ebd', 12, NULL, 'Round Dance', 'Rhymes With Silver: Round Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23667 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dc5335f-cf0b-49fa-8919-ec72f71a8ebd'
);


-- None Round

UPDATE pieces piece
SET piece.title = 'Round', piece.title_en = 'Round',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24165 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sailors' Chorus>

UPDATE pieces piece
SET piece.title = '가곡 <Sailors'' Chorus>', piece.title_en = 'Sailors'' Chorus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23740 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saraband

UPDATE pieces piece
SET piece.title = 'Saraband', piece.title_en = 'Saraband',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25053 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scenes From Nek Chand

UPDATE pieces piece
SET piece.title = 'Scenes From Nek Chand', piece.title_en = 'Scenes From Nek Chand',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23885 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Rock Garden', part.name_en = 'Scenes From Nek Chand: The Rock Garden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23885 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0a0ef725-64d7-4644-8bc7-c08fabb0dbe0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a0ef725-64d7-4644-8bc7-c08fabb0dbe0', 1, NULL, 'The Rock Garden', 'Scenes From Nek Chand: The Rock Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23885 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a0ef725-64d7-4644-8bc7-c08fabb0dbe0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Leaning Lady', part.name_en = 'Scenes From Nek Chand: The Leaning Lady',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23885 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:11d14025-67eb-4bce-9b72-9c5313acb571' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11d14025-67eb-4bce-9b72-9c5313acb571', 2, NULL, 'The Leaning Lady', 'Scenes From Nek Chand: The Leaning Lady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23885 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11d14025-67eb-4bce-9b72-9c5313acb571'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Sinuous Arcade With Swings in the Arches', part.name_en = 'Scenes From Nek Chand: The Sinuous Arcade With Swings in the Arches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23885 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fd60bf70-c4ac-4605-a1e7-d0b8cbcc2989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd60bf70-c4ac-4605-a1e7-d0b8cbcc2989', 3, NULL, 'The Sinuous Arcade With Swings in the Arches', 'Scenes From Nek Chand: The Sinuous Arcade With Swings in the Arches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23885 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd60bf70-c4ac-4605-a1e7-d0b8cbcc2989'
);


-- None 연가곡집 <Scenes from Cavafy>

UPDATE pieces piece
SET piece.title = '연가곡집 <Scenes from Cavafy>', piece.title_en = 'Scenes from Cavafy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25623 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gending Cavafy', part.name_en = 'Scenes from Cavafy: I. Gending Cavafy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25623 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a3b64449-e3d7-4e27-b85f-b3bcfab7aec6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3b64449-e3d7-4e27-b85f-b3bcfab7aec6', 1, 'I', 'Gending Cavafy', 'Scenes from Cavafy: I. Gending Cavafy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25623 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b64449-e3d7-4e27-b85f-b3bcfab7aec6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gending Bill / Lancaran Jody', part.name_en = 'Scenes from Cavafy: II. Gending Bill / Lancaran Jody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25623 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f833581e-138c-4117-8f55-71cb113081be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f833581e-138c-4117-8f55-71cb113081be', 2, 'II', 'Gending Bill / Lancaran Jody', 'Scenes from Cavafy: II. Gending Bill / Lancaran Jody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25623 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f833581e-138c-4117-8f55-71cb113081be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gending Ptolemy', part.name_en = 'Scenes from Cavafy: III. Gending Ptolemy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25623 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:04501b67-3355-4efd-b663-fdab76d32e9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04501b67-3355-4efd-b663-fdab76d32e9a', 3, 'III', 'Gending Ptolemy', 'Scenes from Cavafy: III. Gending Ptolemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25623 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04501b67-3355-4efd-b663-fdab76d32e9a'
);


-- None Serenade for Betty Freeman and Franco Assetto

UPDATE pieces piece
SET piece.title = 'Serenade for Betty Freeman and Franco Assetto', piece.title_en = 'Serenade for Betty Freeman and Franco Assetto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24631 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenade for Frank Wigglesworth

UPDATE pieces piece
SET piece.title = 'Serenade for Frank Wigglesworth', piece.title_en = 'Serenade for Frank Wigglesworth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23813 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenade for Guitar and Percussion

UPDATE pieces piece
SET piece.title = 'Serenade for Guitar and Percussion', piece.title_en = 'Serenade for Guitar and Percussion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25672 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Round', part.name_en = 'Serenade for Guitar and Percussion: I. Round',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25672 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:77dd445d-e7e6-47f3-be7a-0f824cdc5c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77dd445d-e7e6-47f3-be7a-0f824cdc5c3a', 1, 'I', 'Round', 'Serenade for Guitar and Percussion: I. Round', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25672 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77dd445d-e7e6-47f3-be7a-0f824cdc5c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air', part.name_en = 'Serenade for Guitar and Percussion: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25672 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f2776e7e-b903-4a03-baf1-218d2e3bf4dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2776e7e-b903-4a03-baf1-218d2e3bf4dd', 2, 'II', 'Air', 'Serenade for Guitar and Percussion: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25672 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2776e7e-b903-4a03-baf1-218d2e3bf4dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Infinite Canon', part.name_en = 'Serenade for Guitar and Percussion: III. Infinite Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25672 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a0fce33c-5683-4a19-aa5e-b2959a18ba8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0fce33c-5683-4a19-aa5e-b2959a18ba8b', 3, 'III', 'Infinite Canon', 'Serenade for Guitar and Percussion: III. Infinite Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25672 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0fce33c-5683-4a19-aa5e-b2959a18ba8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Usul', part.name_en = 'Serenade for Guitar and Percussion: IV. Usul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25672 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1e80786d-6f37-4306-aca4-99cd0c167ce1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e80786d-6f37-4306-aca4-99cd0c167ce1', 4, 'IV', 'Usul', 'Serenade for Guitar and Percussion: IV. Usul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25672 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e80786d-6f37-4306-aca4-99cd0c167ce1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sonata', part.name_en = 'Serenade for Guitar and Percussion: V. Sonata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25672 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1c0feb72-3f6a-4d2d-81f9-6cd7e540942c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c0feb72-3f6a-4d2d-81f9-6cd7e540942c', 5, 'V', 'Sonata', 'Serenade for Guitar and Percussion: V. Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25672 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0feb72-3f6a-4d2d-81f9-6cd7e540942c'
);


-- None 7개의 파스토랄

UPDATE pieces piece
SET piece.title = '7개의 파스토랄', piece.title_en = 'Seven Pastorales',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23563 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'For Remy Charlip', part.name_en = 'Seven Pastorales: I. For Remy Charlip',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:556d5181-f67e-450b-87d9-b42347e84528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:556d5181-f67e-450b-87d9-b42347e84528', 1, 'I', 'For Remy Charlip', 'Seven Pastorales: I. For Remy Charlip', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:556d5181-f67e-450b-87d9-b42347e84528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'For Ellie and David Decker on Their Marriage', part.name_en = 'Seven Pastorales: II. For Ellie and David Decker on Their Marriage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:7051a086-74a7-4c44-ad08-b4da99fcb181' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7051a086-74a7-4c44-ad08-b4da99fcb181', 2, 'II', 'For Ellie and David Decker on Their Marriage', 'Seven Pastorales: II. For Ellie and David Decker on Their Marriage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7051a086-74a7-4c44-ad08-b4da99fcb181'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'To Remy Charlip', part.name_en = 'Seven Pastorales: III. To Remy Charlip',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ce80a897-08eb-4780-89a7-afbd786c0f0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce80a897-08eb-4780-89a7-afbd786c0f0b', 3, 'III', 'To Remy Charlip', 'Seven Pastorales: III. To Remy Charlip', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce80a897-08eb-4780-89a7-afbd786c0f0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'To Fritz Rikko', part.name_en = 'Seven Pastorales: IV. To Fritz Rikko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:5f9f6de4-42e5-4ead-b58b-0a3114ffea3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f9f6de4-42e5-4ead-b58b-0a3114ffea3e', 4, 'IV', 'To Fritz Rikko', 'Seven Pastorales: IV. To Fritz Rikko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9f6de4-42e5-4ead-b58b-0a3114ffea3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'To John Cage', part.name_en = 'Seven Pastorales: V. To John Cage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4dc73e81-309c-46e4-8519-7190b92e1fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dc73e81-309c-46e4-8519-7190b92e1fed', 5, 'V', 'To John Cage', 'Seven Pastorales: V. To John Cage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dc73e81-309c-46e4-8519-7190b92e1fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'To My Mother', part.name_en = 'Seven Pastorales: VI. To My Mother',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:26532dad-447d-4916-8b2c-62d379b438b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26532dad-447d-4916-8b2c-62d379b438b3', 6, 'VI', 'To My Mother', 'Seven Pastorales: VI. To My Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26532dad-447d-4916-8b2c-62d379b438b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'For My Brother', part.name_en = 'Seven Pastorales: VII. For My Brother',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23563 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:31efbf0c-8ed6-4eb2-8504-a28634d2c0a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31efbf0c-8ed6-4eb2-8504-a28634d2c0a7', 7, 'VII', 'For My Brother', 'Seven Pastorales: VII. For My Brother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23563 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31efbf0c-8ed6-4eb2-8504-a28634d2c0a7'
);


-- None Simfony #13

UPDATE pieces piece
SET piece.title = 'Simfony #13', piece.title_en = 'Simfony #13',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23725 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 6개의 소나타

UPDATE pieces piece
SET piece.title = '6개의 소나타', piece.title_en = 'Six Sonatas for Cembalo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24581 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Six Sonatas for Cembalo: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:74d86aa0-1a53-45af-98c7-4b8a2819639c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74d86aa0-1a53-45af-98c7-4b8a2819639c', 1, NULL, 'No. 1', 'Six Sonatas for Cembalo: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74d86aa0-1a53-45af-98c7-4b8a2819639c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Six Sonatas for Cembalo: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d8cbaabc-4ebe-4fa1-a3f6-a98ae4fa82ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8cbaabc-4ebe-4fa1-a3f6-a98ae4fa82ee', 2, NULL, 'No. 2', 'Six Sonatas for Cembalo: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8cbaabc-4ebe-4fa1-a3f6-a98ae4fa82ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Six Sonatas for Cembalo: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d088fd15-be38-4c51-b09a-7786d5f38021' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d088fd15-be38-4c51-b09a-7786d5f38021', 3, NULL, 'No. 3', 'Six Sonatas for Cembalo: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d088fd15-be38-4c51-b09a-7786d5f38021'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Six Sonatas for Cembalo: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:b80581b9-563b-4ccb-b3ea-6116edd6b169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b80581b9-563b-4ccb-b3ea-6116edd6b169', 4, NULL, 'No. 4', 'Six Sonatas for Cembalo: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b80581b9-563b-4ccb-b3ea-6116edd6b169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Six Sonatas for Cembalo: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ca32c084-48fb-4b98-8d59-bb257a1c546d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca32c084-48fb-4b98-8d59-bb257a1c546d', 5, NULL, 'No. 5', 'Six Sonatas for Cembalo: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca32c084-48fb-4b98-8d59-bb257a1c546d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Six Sonatas for Cembalo: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24581 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a67fdb9f-ccf8-47d7-a9fc-476d60f51da9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a67fdb9f-ccf8-47d7-a9fc-476d60f51da9', 6, NULL, 'No. 6', 'Six Sonatas for Cembalo: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24581 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a67fdb9f-ccf8-47d7-a9fc-476d60f51da9'
);


-- None Solo to Anthony Cirone

UPDATE pieces piece
SET piece.title = 'Solo to Anthony Cirone', piece.title_en = 'Solo to Anthony Cirone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23895 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Solstice>

UPDATE pieces piece
SET piece.title = '발레 <Solstice>', piece.title_en = 'Solstice',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23711 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I: Garden of the Sun', part.name_en = 'Solstice, Part I: Garden of the Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cbd4c007-c71e-4491-a9be-82069844c671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbd4c007-c71e-4491-a9be-82069844c671', 1, NULL, 'Part I: Garden of the Sun', 'Solstice, Part I: Garden of the Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd4c007-c71e-4491-a9be-82069844c671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I: Entrance of the Moon Bull', part.name_en = 'Solstice, Part I: Entrance of the Moon Bull',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:38378c81-17c5-4d49-93e5-c7493bdf82d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38378c81-17c5-4d49-93e5-c7493bdf82d1', 2, NULL, 'Part I: Entrance of the Moon Bull', 'Solstice, Part I: Entrance of the Moon Bull', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38378c81-17c5-4d49-93e5-c7493bdf82d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I: Battle', part.name_en = 'Solstice, Part I: Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fee89854-8566-400e-892f-a92c600c3804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fee89854-8566-400e-892f-a92c600c3804', 3, NULL, 'Part I: Battle', 'Solstice, Part I: Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fee89854-8566-400e-892f-a92c600c3804'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part I: Earth''s Invitation', part.name_en = 'Solstice, Part I: Earth''s Invitation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fd6a7f0d-aa32-4dca-bc83-7d67cf6939e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd6a7f0d-aa32-4dca-bc83-7d67cf6939e4', 4, NULL, 'Part I: Earth''s Invitation', 'Solstice, Part I: Earth''s Invitation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6a7f0d-aa32-4dca-bc83-7d67cf6939e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part I: Vernal Dance', part.name_en = 'Solstice, Part I: Vernal Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:016a0c27-614f-4a6c-b212-236f593d8d5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:016a0c27-614f-4a6c-b212-236f593d8d5f', 5, NULL, 'Part I: Vernal Dance', 'Solstice, Part I: Vernal Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:016a0c27-614f-4a6c-b212-236f593d8d5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part II: Saturnalia', part.name_en = 'Solstice, Part II: Saturnalia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:b49bc5c9-31c3-42d6-bf09-fc3fa502564d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b49bc5c9-31c3-42d6-bf09-fc3fa502564d', 6, NULL, 'Part II: Saturnalia', 'Solstice, Part II: Saturnalia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b49bc5c9-31c3-42d6-bf09-fc3fa502564d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part II: Rekindling of the Fire', part.name_en = 'Solstice, Part II: Rekindling of the Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e2172513-a0b6-476e-a913-66258a2ef054' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2172513-a0b6-476e-a913-66258a2ef054', 7, NULL, 'Part II: Rekindling of the Fire', 'Solstice, Part II: Rekindling of the Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2172513-a0b6-476e-a913-66258a2ef054'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part II: Turning of the Wheel', part.name_en = 'Solstice, Part II: Turning of the Wheel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3bdd5ce3-b99b-496d-9666-2acf55517bf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bdd5ce3-b99b-496d-9666-2acf55517bf1', 8, NULL, 'Part II: Turning of the Wheel', 'Solstice, Part II: Turning of the Wheel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bdd5ce3-b99b-496d-9666-2acf55517bf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part II: Blaze of Day', part.name_en = 'Solstice, Part II: Blaze of Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23711 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2cf1cdb5-7c32-4f8c-a06f-b6aa4e1eccee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cf1cdb5-7c32-4f8c-a06f-b6aa4e1eccee', 9, NULL, 'Part II: Blaze of Day', 'Solstice, Part II: Blaze of Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23711 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cf1cdb5-7c32-4f8c-a06f-b6aa4e1eccee'
);


-- None Song of Quetzalcoatl

UPDATE pieces piece
SET piece.title = 'Song of Quetzalcoatl', piece.title_en = 'Song of Quetzalcoatl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24245 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Strict Songs

UPDATE pieces piece
SET piece.title = 'Strict Songs', piece.title_en = 'Strict Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24616 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Here Is Holiness', part.name_en = 'Strict Songs: No. 1. Here Is Holiness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24616 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:60ed6de1-d382-4a8d-9756-a98e9bc6ddf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60ed6de1-d382-4a8d-9756-a98e9bc6ddf0', 1, NULL, 'Here Is Holiness', 'Strict Songs: No. 1. Here Is Holiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24616 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60ed6de1-d382-4a8d-9756-a98e9bc6ddf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Here Is Nourishment', part.name_en = 'Strict Songs: No. 2. Here Is Nourishment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24616 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:25f889a0-7fdf-488a-ad77-2e9471815110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f889a0-7fdf-488a-ad77-2e9471815110', 2, NULL, 'Here Is Nourishment', 'Strict Songs: No. 2. Here Is Nourishment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24616 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f889a0-7fdf-488a-ad77-2e9471815110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Here Is Tenderness', part.name_en = 'Strict Songs: No. 3. Here Is Tenderness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24616 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9e3d3d8f-209a-4dc7-a4ce-230dd2cfc59a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e3d3d8f-209a-4dc7-a4ce-230dd2cfc59a', 3, NULL, 'Here Is Tenderness', 'Strict Songs: No. 3. Here Is Tenderness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24616 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e3d3d8f-209a-4dc7-a4ce-230dd2cfc59a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Here Is Splendor', part.name_en = 'Strict Songs: No. 4. Here Is Splendor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24616 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9c678b08-f5e2-4918-9890-abdeef235b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c678b08-f5e2-4918-9890-abdeef235b5d', 4, NULL, 'Here Is Splendor', 'Strict Songs: No. 4. Here Is Splendor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24616 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c678b08-f5e2-4918-9890-abdeef235b5d'
);


-- None String Quartet Set

UPDATE pieces piece
SET piece.title = 'String Quartet Set', piece.title_en = 'String Quartet Set',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23621 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Variations on Walter Von der Vogelweide''s "Song of Palestine"', part.name_en = 'String Quartet Set: I. Variations on Walter Von der Vogelweide''s "Song of Palestine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23621 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:b30d295e-8fc6-40e6-87e5-1a7b76eb32b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b30d295e-8fc6-40e6-87e5-1a7b76eb32b7', 1, 'I', 'Variations on Walter Von der Vogelweide''s "Song of Palestine"', 'String Quartet Set: I. Variations on Walter Von der Vogelweide''s "Song of Palestine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23621 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b30d295e-8fc6-40e6-87e5-1a7b76eb32b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Plaint', part.name_en = 'String Quartet Set: II. Plaint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23621 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:39ec2281-4827-4e23-aa24-cce8d5ddb62a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39ec2281-4827-4e23-aa24-cce8d5ddb62a', 2, 'II', 'Plaint', 'String Quartet Set: II. Plaint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23621 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ec2281-4827-4e23-aa24-cce8d5ddb62a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Estampie', part.name_en = 'String Quartet Set: III. Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23621 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c217d9af-12fb-473d-9099-751753989d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c217d9af-12fb-473d-9099-751753989d2d', 3, 'III', 'Estampie', 'String Quartet Set: III. Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23621 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c217d9af-12fb-473d-9099-751753989d2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondeaux', part.name_en = 'String Quartet Set: IV. Rondeaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23621 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:673a1890-2d55-4f32-a75a-e62fc2896159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673a1890-2d55-4f32-a75a-e62fc2896159', 4, 'IV', 'Rondeaux', 'String Quartet Set: IV. Rondeaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23621 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673a1890-2d55-4f32-a75a-e62fc2896159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Usul', part.name_en = 'String Quartet Set: V. Usul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23621 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cca11db9-322b-42ef-a844-19b988bf3d97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cca11db9-322b-42ef-a844-19b988bf3d97', 5, 'V', 'Usul', 'String Quartet Set: V. Usul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23621 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca11db9-322b-42ef-a844-19b988bf3d97'
);


-- None 현악 3중주

UPDATE pieces piece
SET piece.title = '현악 3중주', piece.title_en = 'String Trio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23741 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로와 하프를 위한 모음곡

UPDATE pieces piece
SET piece.title = '첼로와 하프를 위한 모음곡', piece.title_en = 'Suite for Cello and Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25141 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chorale', part.name_en = 'Suite for Cello and Harp: I. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25141 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d7c7f05b-22f8-4428-918e-afc67a15a4da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7c7f05b-22f8-4428-918e-afc67a15a4da', 1, 'I', 'Chorale', 'Suite for Cello and Harp: I. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25141 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c7f05b-22f8-4428-918e-afc67a15a4da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastorale and Rondeau', part.name_en = 'Suite for Cello and Harp: II. Pastorale and Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25141 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4db1f160-4ade-4bc8-9bb4-3cf562af9d30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db1f160-4ade-4bc8-9bb4-3cf562af9d30', 2, 'II', 'Pastorale and Rondeau', 'Suite for Cello and Harp: II. Pastorale and Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25141 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db1f160-4ade-4bc8-9bb4-3cf562af9d30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Interlude', part.name_en = 'Suite for Cello and Harp: III. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25141 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3e57b1fd-5b65-45ee-b2db-f9b0c13230ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e57b1fd-5b65-45ee-b2db-f9b0c13230ed', 3, 'III', 'Interlude', 'Suite for Cello and Harp: III. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25141 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e57b1fd-5b65-45ee-b2db-f9b0c13230ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Aria', part.name_en = 'Suite for Cello and Harp: IV. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25141 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6012ff8d-cade-4d33-afac-bceb2a0e32ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6012ff8d-cade-4d33-afac-bceb2a0e32ee', 4, 'IV', 'Aria', 'Suite for Cello and Harp: IV. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25141 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6012ff8d-cade-4d33-afac-bceb2a0e32ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Chorale (reprise)', part.name_en = 'Suite for Cello and Harp: V. Chorale (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25141 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:833b1160-be36-476c-b2e7-65baea53074b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:833b1160-be36-476c-b2e7-65baea53074b', 5, 'V', 'Chorale (reprise)', 'Suite for Cello and Harp: V. Chorale (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25141 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833b1160-be36-476c-b2e7-65baea53074b'
);


-- None 첼로와 피아노를 위한 모음곡

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 모음곡', piece.title_en = 'Suite for Cello and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24500 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Suite for Cello and Piano: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24500 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:08e13647-1cc2-4548-a6e8-bdc2d75d9f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e13647-1cc2-4548-a6e8-bdc2d75d9f5d', 1, 'I', 'Moderato', 'Suite for Cello and Piano: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24500 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e13647-1cc2-4548-a6e8-bdc2d75d9f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Elegy', part.name_en = 'Suite for Cello and Piano: II. Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24500 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:69cfdf68-428d-45df-bc7b-b313030473f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69cfdf68-428d-45df-bc7b-b313030473f3', 2, 'II', 'Elegy', 'Suite for Cello and Piano: II. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24500 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69cfdf68-428d-45df-bc7b-b313030473f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Suite for Cello and Piano: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24500 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:82fb7d9c-4a6d-4a9a-9847-a97889476c58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82fb7d9c-4a6d-4a9a-9847-a97889476c58', 3, 'III', 'Allegro', 'Suite for Cello and Piano: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24500 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82fb7d9c-4a6d-4a9a-9847-a97889476c58'
);


-- None 기타 모음곡 1번

UPDATE pieces piece
SET piece.title = '기타 모음곡 1번', piece.title_en = 'Suite for Guitar no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23736 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonata in Am', part.name_en = 'Suite, for guitar No. 1: Sonata in Am',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23736 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:18a2718f-843a-479a-9f23-1c752819f969' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18a2718f-843a-479a-9f23-1c752819f969', 1, NULL, 'Sonata in Am', 'Suite, for guitar No. 1: Sonata in Am', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23736 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18a2718f-843a-479a-9f23-1c752819f969'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonata in Ishartum', part.name_en = 'Sonata in Ishartum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23736 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:63008a7d-dbd7-4fc9-94b7-0cfe4ec69bdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63008a7d-dbd7-4fc9-94b7-0cfe4ec69bdf', 2, NULL, 'Sonata in Ishartum', 'Sonata in Ishartum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23736 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63008a7d-dbd7-4fc9-94b7-0cfe4ec69bdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Avalokiteshvara', part.name_en = 'Suite, for guitar No. 1: Avalokiteshvara',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23736 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8423fa1a-8434-4f12-bc1f-2d3fa8dd94a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8423fa1a-8434-4f12-bc1f-2d3fa8dd94a4', 3, NULL, 'Avalokiteshvara', 'Suite, for guitar No. 1: Avalokiteshvara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23736 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8423fa1a-8434-4f12-bc1f-2d3fa8dd94a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tandy''s Tango', part.name_en = 'Suite, for guitar No. 1: Tandy''s Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23736 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:eb5b554c-08fd-4a0d-8981-7f2293dd218e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb5b554c-08fd-4a0d-8981-7f2293dd218e', 4, NULL, 'Tandy''s Tango', 'Suite, for guitar No. 1: Tandy''s Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23736 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb5b554c-08fd-4a0d-8981-7f2293dd218e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Bill and Me', part.name_en = 'Music for Bill and Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23736 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fd842423-cacb-4a29-8daf-98c55401db4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd842423-cacb-4a29-8daf-98c55401db4c', 5, NULL, 'Music for Bill and Me', 'Music for Bill and Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23736 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd842423-cacb-4a29-8daf-98c55401db4c'
);


-- None 기타 모음곡 2번

UPDATE pieces piece
SET piece.title = '기타 모음곡 2번', piece.title_en = 'Suite for Guitar no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24809 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Beverly''s Troubadour Piece', part.name_en = 'Beverly''s Troubadour Piece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24809 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:34741ee2-4ef6-42d7-9b9d-a0361935fe74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34741ee2-4ef6-42d7-9b9d-a0361935fe74', 1, NULL, 'Beverly''s Troubadour Piece', 'Beverly''s Troubadour Piece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24809 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34741ee2-4ef6-42d7-9b9d-a0361935fe74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Waltz for Evelyn Hinrichsen', part.name_en = 'A Waltz for Evelyn Hinrichsen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24809 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:523c888f-9dac-40aa-ab01-ea00b16a6ff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:523c888f-9dac-40aa-ab01-ea00b16a6ff6', 2, NULL, 'A Waltz for Evelyn Hinrichsen', 'A Waltz for Evelyn Hinrichsen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24809 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:523c888f-9dac-40aa-ab01-ea00b16a6ff6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jahla in the form of a Ductia', part.name_en = 'Suite No. 2 for guitar: Jahla in the form of a Ductia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24809 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:5efbc1bf-43c3-42ad-9772-56d532936b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5efbc1bf-43c3-42ad-9772-56d532936b35', 3, NULL, 'Jahla in the form of a Ductia', 'Suite No. 2 for guitar: Jahla in the form of a Ductia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24809 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5efbc1bf-43c3-42ad-9772-56d532936b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Adagio, arioso', part.name_en = 'Suite No. 2 for guitar: Adagio, arioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24809 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:706b92a0-c01c-47d0-a4b2-7db24fb2963f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:706b92a0-c01c-47d0-a4b2-7db24fb2963f', 4, NULL, 'Adagio, arioso', 'Suite No. 2 for guitar: Adagio, arioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24809 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:706b92a0-c01c-47d0-a4b2-7db24fb2963f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sonata in Cm', part.name_en = 'Suite No. 2 for guitar: Sonata in Cm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24809 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f656c9ce-acdf-48f5-a6e6-32db5fa9f025' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f656c9ce-acdf-48f5-a6e6-32db5fa9f025', 5, NULL, 'Sonata in Cm', 'Suite No. 2 for guitar: Sonata in Cm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24809 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f656c9ce-acdf-48f5-a6e6-32db5fa9f025'
);


-- None Suite for National Steel Guitar

UPDATE pieces piece
SET piece.title = 'Suite for National Steel Guitar', piece.title_en = 'Suite for National Steel Guitar',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23334 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Threnody to the memory of Oliver Daniel', part.name_en = 'Suite for National Steel Guitar: Threnody to the memory of Oliver Daniel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23334 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1ad84c82-7d69-479a-b5e6-cbfc1c6efa4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ad84c82-7d69-479a-b5e6-cbfc1c6efa4c', 1, NULL, 'Threnody to the memory of Oliver Daniel', 'Suite for National Steel Guitar: Threnody to the memory of Oliver Daniel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23334 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad84c82-7d69-479a-b5e6-cbfc1c6efa4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Palace Music', part.name_en = 'Suite for National Steel Guitar: Palace Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23334 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2ada189b-d330-4df4-9047-2d15047aa92b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ada189b-d330-4df4-9047-2d15047aa92b', 2, NULL, 'Palace Music', 'Suite for National Steel Guitar: Palace Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23334 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ada189b-d330-4df4-9047-2d15047aa92b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Serenado por Gitaro', part.name_en = 'Suite for National Steel Guitar: Serenado por Gitaro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23334 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2fc8b5cc-d7c4-4df4-b95a-7ad016bffd4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fc8b5cc-d7c4-4df4-b95a-7ad016bffd4c', 3, NULL, 'Serenado por Gitaro', 'Suite for National Steel Guitar: Serenado por Gitaro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23334 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fc8b5cc-d7c4-4df4-b95a-7ad016bffd4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jahla', part.name_en = 'Suite for National Steel Guitar: Jahla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23334 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3e60d4b2-a263-461e-baa0-8ff89701e174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e60d4b2-a263-461e-baa0-8ff89701e174', 4, NULL, 'Jahla', 'Suite for National Steel Guitar: Jahla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23334 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e60d4b2-a263-461e-baa0-8ff89701e174'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Solo', part.name_en = 'Suite for National Steel Guitar: Solo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23334 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ed4289ed-3c94-491b-a349-8f04bdd4e028' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed4289ed-3c94-491b-a349-8f04bdd4e028', 5, NULL, 'Solo', 'Suite for National Steel Guitar: Solo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23334 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed4289ed-3c94-491b-a349-8f04bdd4e028'
);


-- None Suite for Percussion

UPDATE pieces piece
SET piece.title = 'Suite for Percussion', piece.title_en = 'Suite for Percussion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23372 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Suite for Percussion: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23372 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c642c2de-fb63-4670-a2ef-884f00451c23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c642c2de-fb63-4670-a2ef-884f00451c23', 1, 'I', 'Moderato', 'Suite for Percussion: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23372 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c642c2de-fb63-4670-a2ef-884f00451c23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow', part.name_en = 'Suite for Percussion: II. Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23372 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:fe276b11-2509-4884-9ad0-e678a37cbb1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe276b11-2509-4884-9ad0-e678a37cbb1c', 2, 'II', 'Slow', 'Suite for Percussion: II. Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23372 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe276b11-2509-4884-9ad0-e678a37cbb1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Recitative', part.name_en = 'Suite for Percussion: III. Recitative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23372 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:f05afd03-080b-4f58-8697-a83efa131e39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05afd03-080b-4f58-8697-a83efa131e39', 3, 'III', 'Recitative', 'Suite for Percussion: III. Recitative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23372 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05afd03-080b-4f58-8697-a83efa131e39'
);


-- None Suite for Sangen

UPDATE pieces piece
SET piece.title = 'Suite for Sangen', piece.title_en = 'Suite for Sangen',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25729 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Suite for Sangen: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25729 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6efa65fe-b1d1-4ac9-88ef-a876f330dd63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6efa65fe-b1d1-4ac9-88ef-a876f330dd63', 1, NULL, 'I', 'Suite for Sangen: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25729 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6efa65fe-b1d1-4ac9-88ef-a876f330dd63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Suite for Sangen: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25729 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1c1d0613-e413-4d26-95a2-26ea5c297694' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c1d0613-e413-4d26-95a2-26ea5c297694', 2, NULL, 'II', 'Suite for Sangen: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25729 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c1d0613-e413-4d26-95a2-26ea5c297694'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Suite for Sangen: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25729 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:45cc4929-9d07-4f35-ad89-44b8f70b3b4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45cc4929-9d07-4f35-ad89-44b8f70b3b4b', 3, NULL, 'III', 'Suite for Sangen: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25729 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cc4929-9d07-4f35-ad89-44b8f70b3b4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Suite for Sangen: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25729 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0b058b3e-2c32-4232-b75b-d8429a38104a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b058b3e-2c32-4232-b75b-d8429a38104a', 4, NULL, 'IV', 'Suite for Sangen: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25729 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b058b3e-2c32-4232-b75b-d8429a38104a'
);


-- None Suite for Symphonic Strings

UPDATE pieces piece
SET piece.title = 'Suite for Symphonic Strings', piece.title_en = 'Suite for Symphonic Strings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23720 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Estampie', part.name_en = 'Suite for Symphonic Strings: I. Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:395578f2-5ca4-4995-b8b4-fbd51f916ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:395578f2-5ca4-4995-b8b4-fbd51f916ea8', 1, 'I', 'Estampie', 'Suite for Symphonic Strings: I. Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:395578f2-5ca4-4995-b8b4-fbd51f916ea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chorale: Et in Arcadia ego', part.name_en = 'Suite for Symphonic Strings: II. Chorale: Et in Arcadia ego',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6512862c-078a-4d76-9daa-84853360439b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6512862c-078a-4d76-9daa-84853360439b', 2, 'II', 'Chorale: Et in Arcadia ego', 'Suite for Symphonic Strings: II. Chorale: Et in Arcadia ego', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6512862c-078a-4d76-9daa-84853360439b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ductia: In honor of Eros', part.name_en = 'Suite for Symphonic Strings: III. Ductia: In honor of Eros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0f2af389-3d69-426d-881b-415f6fc44788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f2af389-3d69-426d-881b-415f6fc44788', 3, 'III', 'Ductia: In honor of Eros', 'Suite for Symphonic Strings: III. Ductia: In honor of Eros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f2af389-3d69-426d-881b-415f6fc44788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lament', part.name_en = 'Suite for Symphonic Strings: IV. Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1cfe9952-f22f-46c9-8339-c6ba72689042' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfe9952-f22f-46c9-8339-c6ba72689042', 4, 'IV', 'Lament', 'Suite for Symphonic Strings: IV. Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfe9952-f22f-46c9-8339-c6ba72689042'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Round: In honor of Hermes', part.name_en = 'Suite for Symphonic Strings: V. Round: In honor of Hermes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8f24ba92-fcd1-4ca3-ae07-34064916d08c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f24ba92-fcd1-4ca3-ae07-34064916d08c', 5, 'V', 'Round: In honor of Hermes', 'Suite for Symphonic Strings: V. Round: In honor of Hermes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f24ba92-fcd1-4ca3-ae07-34064916d08c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Little fugue: Viola''s reward', part.name_en = 'Suite for Symphonic Strings: VI. Little fugue: Viola''s reward',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8836d23e-853b-407f-82bc-0221b1adece5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8836d23e-853b-407f-82bc-0221b1adece5', 6, 'VI', 'Little fugue: Viola''s reward', 'Suite for Symphonic Strings: VI. Little fugue: Viola''s reward', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8836d23e-853b-407f-82bc-0221b1adece5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Nocturne', part.name_en = 'Suite for Symphonic Strings: VII. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23720 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:2d67dafb-1151-44a5-a988-69642561225d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d67dafb-1151-44a5-a988-69642561225d', 7, 'VII', 'Nocturne', 'Suite for Symphonic Strings: VII. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23720 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d67dafb-1151-44a5-a988-69642561225d'
);


-- None Suite for Violin and American Gamelan

UPDATE pieces piece
SET piece.title = 'Suite for Violin and American Gamelan', piece.title_en = 'Suite for Violin and American Gamelan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24270 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'First Movement', part.name_en = 'Suite for Violin and American Gamelan: First Movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:15be00a3-7e5e-4d7e-91ae-2f81d8319134' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15be00a3-7e5e-4d7e-91ae-2f81d8319134', 1, NULL, 'First Movement', 'Suite for Violin and American Gamelan: First Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15be00a3-7e5e-4d7e-91ae-2f81d8319134'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Estampie', part.name_en = 'Suite for Violin and American Gamelan: Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cc9fa4ce-2833-4754-88cc-8cbd0f05fc48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc9fa4ce-2833-4754-88cc-8cbd0f05fc48', 2, NULL, 'Estampie', 'Suite for Violin and American Gamelan: Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9fa4ce-2833-4754-88cc-8cbd0f05fc48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air', part.name_en = 'Suite for Violin and American Gamelan: Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9d176fb7-eba7-4463-9c71-49bb4db27ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d176fb7-eba7-4463-9c71-49bb4db27ccf', 3, NULL, 'Air', 'Suite for Violin and American Gamelan: Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d176fb7-eba7-4463-9c71-49bb4db27ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jhala I', part.name_en = 'Suite for Violin and American Gamelan: Jhala I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a5853a00-d4a5-4b46-8c4f-ee129927f843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5853a00-d4a5-4b46-8c4f-ee129927f843', 4, NULL, 'Jhala I', 'Suite for Violin and American Gamelan: Jhala I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5853a00-d4a5-4b46-8c4f-ee129927f843'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jhala II', part.name_en = 'Suite for Violin and American Gamelan: Jhala II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:98cf1ee1-71a1-44ac-9eb4-df6abc3ac25b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cf1ee1-71a1-44ac-9eb4-df6abc3ac25b', 5, NULL, 'Jhala II', 'Suite for Violin and American Gamelan: Jhala II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cf1ee1-71a1-44ac-9eb4-df6abc3ac25b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jhala III', part.name_en = 'Suite for Violin and American Gamelan: Jhala III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:d16825a9-2148-436f-a036-397ddb25351b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d16825a9-2148-436f-a036-397ddb25351b', 6, NULL, 'Jhala III', 'Suite for Violin and American Gamelan: Jhala III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d16825a9-2148-436f-a036-397ddb25351b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Chaconne', part.name_en = 'Suite for Violin and American Gamelan: Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24270 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:65be6f5b-0974-4bac-97d0-7c532fc10edc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65be6f5b-0974-4bac-97d0-7c532fc10edc', 7, NULL, 'Chaconne', 'Suite for Violin and American Gamelan: Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24270 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65be6f5b-0974-4bac-97d0-7c532fc10edc'
);


-- None Suite for Violin with String Orchestra

UPDATE pieces piece
SET piece.title = 'Suite for Violin with String Orchestra', piece.title_en = 'Suite for Violin with String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25790 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Threnody', part.name_en = 'Suite for Violin with String Orchestra: I. Threnody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25790 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:20e4d640-d516-483e-9a6f-43616b3f891e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20e4d640-d516-483e-9a6f-43616b3f891e', 1, 'I', 'Threnody', 'Suite for Violin with String Orchestra: I. Threnody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25790 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20e4d640-d516-483e-9a6f-43616b3f891e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Estampie', part.name_en = 'Suite for Violin with String Orchestra: II. Estampie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25790 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:74479c38-ce6b-4586-8102-a879e6ccca9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74479c38-ce6b-4586-8102-a879e6ccca9e', 2, 'II', 'Estampie', 'Suite for Violin with String Orchestra: II. Estampie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25790 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74479c38-ce6b-4586-8102-a879e6ccca9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Jahla', part.name_en = 'Suite for Violin with String Orchestra: III. Jahla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25790 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:9ce8403b-91de-4b54-b6c9-ff3477e865ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ce8403b-91de-4b54-b6c9-ff3477e865ce', 3, 'III', 'Jahla', 'Suite for Violin with String Orchestra: III. Jahla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25790 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ce8403b-91de-4b54-b6c9-ff3477e865ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Chaconne', part.name_en = 'Suite for Violin with String Orchestra: IV. Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25790 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:3620490a-5047-4d91-b9b1-34a70bb33a66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3620490a-5047-4d91-b9b1-34a70bb33a66', 4, 'IV', 'Chaconne', 'Suite for Violin with String Orchestra: IV. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25790 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3620490a-5047-4d91-b9b1-34a70bb33a66'
);


-- None 바이올린 모음곡

UPDATE pieces piece
SET piece.title = '바이올린 모음곡', piece.title_en = 'Suite for Violin, Piano and Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23436 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Suite for Violin, Piano and Small Orchestra: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:6899b43f-0810-42df-8b2a-754c2f0d44f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6899b43f-0810-42df-8b2a-754c2f0d44f2', 1, 'I', 'Overture', 'Suite for Violin, Piano and Small Orchestra: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6899b43f-0810-42df-8b2a-754c2f0d44f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Elegy', part.name_en = 'Suite for Violin, Piano and Small Orchestra: II. Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:19c7f660-ba1c-4f0c-b448-4027529c9a93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19c7f660-ba1c-4f0c-b448-4027529c9a93', 2, 'II', 'Elegy', 'Suite for Violin, Piano and Small Orchestra: II. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19c7f660-ba1c-4f0c-b448-4027529c9a93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'First Gamelan', part.name_en = 'Suite for Violin, Piano and Small Orchestra: III. First Gamelan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:0b419cdd-4dcf-482a-8154-47fe1eb6b79e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b419cdd-4dcf-482a-8154-47fe1eb6b79e', 3, 'III', 'First Gamelan', 'Suite for Violin, Piano and Small Orchestra: III. First Gamelan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b419cdd-4dcf-482a-8154-47fe1eb6b79e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Aria', part.name_en = 'Suite for Violin, Piano and Small Orchestra: IV. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:67723cc0-d717-43e5-9f83-a2572c7d5183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67723cc0-d717-43e5-9f83-a2572c7d5183', 4, 'IV', 'Aria', 'Suite for Violin, Piano and Small Orchestra: IV. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67723cc0-d717-43e5-9f83-a2572c7d5183'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Second Gamelan', part.name_en = 'Suite for Violin, Piano and Small Orchestra: V. Second Gamelan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8a36a2e0-b1d4-49d7-9afd-bae867038f16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a36a2e0-b1d4-49d7-9afd-bae867038f16', 5, 'V', 'Second Gamelan', 'Suite for Violin, Piano and Small Orchestra: V. Second Gamelan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a36a2e0-b1d4-49d7-9afd-bae867038f16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Chorale', part.name_en = 'Suite for Violin, Piano and Small Orchestra: VI. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23436 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:01739f33-6247-48de-b980-240e0affc140' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01739f33-6247-48de-b980-240e0affc140', 6, 'VI', 'Chorale', 'Suite for Violin, Piano and Small Orchestra: VI. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23436 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01739f33-6247-48de-b980-240e0affc140'
);


-- None 교향곡 2번 "Elegiac"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "Elegiac"', piece.title_en = 'Symphony no. 2 "Elegiac"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24461 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tears of the Angel Israfel', part.name_en = 'Symphony no. 2 "Elegiac": I. Tears of the Angel Israfel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24461 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:1606a52d-db1b-49c4-a85a-68263f5fc304' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1606a52d-db1b-49c4-a85a-68263f5fc304', 1, 'I', 'Tears of the Angel Israfel', 'Symphony no. 2 "Elegiac": I. Tears of the Angel Israfel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24461 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1606a52d-db1b-49c4-a85a-68263f5fc304'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro, poco presto', part.name_en = 'Symphony no. 2 "Elegiac": II. Allegro, poco presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24461 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:a8519b99-4eb0-44d1-9c1e-39e5994d32fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8519b99-4eb0-44d1-9c1e-39e5994d32fa', 2, 'II', 'Allegro, poco presto', 'Symphony no. 2 "Elegiac": II. Allegro, poco presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24461 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8519b99-4eb0-44d1-9c1e-39e5994d32fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tears of the Angel Israfel (II)', part.name_en = 'Symphony no. 2 "Elegiac": III. Tears of the Angel Israfel (II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24461 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:c8f859ae-a3f6-4879-9426-086ed1b6743a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8f859ae-a3f6-4879-9426-086ed1b6743a', 3, 'III', 'Tears of the Angel Israfel (II)', 'Symphony no. 2 "Elegiac": III. Tears of the Angel Israfel (II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24461 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8f859ae-a3f6-4879-9426-086ed1b6743a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Praises for Michael the Archangel', part.name_en = 'Symphony no. 2 "Elegiac": IV. Praises for Michael the Archangel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24461 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:28703655-f246-47ae-9337-1263e85064e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28703655-f246-47ae-9337-1263e85064e9', 4, 'IV', 'Praises for Michael the Archangel', 'Symphony no. 2 "Elegiac": IV. Praises for Michael the Archangel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24461 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28703655-f246-47ae-9337-1263e85064e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Sweetness of Epicurus', part.name_en = 'Symphony no. 2 "Elegiac": V. The Sweetness of Epicurus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24461 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:bbc0e742-a2b1-47c0-a774-93ec97ab9500' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbc0e742-a2b1-47c0-a774-93ec97ab9500', 5, 'V', 'The Sweetness of Epicurus', 'Symphony no. 2 "Elegiac": V. The Sweetness of Epicurus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24461 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc0e742-a2b1-47c0-a774-93ec97ab9500'
);


-- None 발레 <The Open Road>

UPDATE pieces piece
SET piece.title = '발레 <The Open Road>', piece.title_en = 'The Open Road',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25083 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Perilous Chapel

UPDATE pieces piece
SET piece.title = 'The Perilous Chapel', piece.title_en = 'The Perilous Chapel',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23298 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude. Andante - Poco maestoso', part.name_en = 'The Perilous Chapel: I. Prelude. Andante - Poco maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23298 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:4ddf7a75-a498-4c51-9375-e5f017f300a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ddf7a75-a498-4c51-9375-e5f017f300a6', 1, 'I', 'Prelude. Andante - Poco maestoso', 'The Perilous Chapel: I. Prelude. Andante - Poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23298 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ddf7a75-a498-4c51-9375-e5f017f300a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Barbaro - Brilliante - Energico', part.name_en = 'The Perilous Chapel: II. Barbaro - Brilliante - Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23298 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:ebbeac26-c84a-4b55-8063-38d307d1bb61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebbeac26-c84a-4b55-8063-38d307d1bb61', 2, 'II', 'Barbaro - Brilliante - Energico', 'The Perilous Chapel: II. Barbaro - Brilliante - Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23298 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebbeac26-c84a-4b55-8063-38d307d1bb61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alleluia. Poco adagio', part.name_en = 'The Perilous Chapel: III. Alleluia. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23298 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e42187bb-6e5f-4073-b3d0-2d01badae820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e42187bb-6e5f-4073-b3d0-2d01badae820', 3, 'III', 'Alleluia. Poco adagio', 'The Perilous Chapel: III. Alleluia. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23298 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e42187bb-6e5f-4073-b3d0-2d01badae820'
);


-- None Threnody for Carlos Chavez

UPDATE pieces piece
SET piece.title = 'Threnody for Carlos Chavez', piece.title_en = 'Threnody for Carlos Chavez',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25164 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Triphony

UPDATE pieces piece
SET piece.title = 'Triphony', piece.title_en = 'Triphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23612 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Village Music

UPDATE pieces piece
SET piece.title = 'Village Music', piece.title_en = 'Village Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25443 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pastorale', part.name_en = 'Village Music: I. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:71b77f3c-29a8-4352-8a2d-4c6229838650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71b77f3c-29a8-4352-8a2d-4c6229838650', 1, 'I', 'Pastorale', 'Village Music: I. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71b77f3c-29a8-4352-8a2d-4c6229838650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quadrille', part.name_en = 'Village Music: II. Quadrille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:e7218130-8b11-4ebd-b3af-c62584d8e109' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7218130-8b11-4ebd-b3af-c62584d8e109', 2, 'II', 'Quadrille', 'Village Music: II. Quadrille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7218130-8b11-4ebd-b3af-c62584d8e109'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chorale', part.name_en = 'Village Music: III. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:8ee4a50b-d8b0-4181-a587-0435e862aa93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee4a50b-d8b0-4181-a587-0435e862aa93', 3, 'III', 'Chorale', 'Village Music: III. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee4a50b-d8b0-4181-a587-0435e862aa93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Hommage to Milhaud', part.name_en = 'Village Music: IV. Hommage to Milhaud',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:41bfd72a-b418-40bf-9cfd-e78693487a50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41bfd72a-b418-40bf-9cfd-e78693487a50', 4, 'IV', 'Hommage to Milhaud', 'Village Music: IV. Hommage to Milhaud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41bfd72a-b418-40bf-9cfd-e78693487a50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Jahla', part.name_en = 'Village Music: V. Jahla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:cdf54186-c562-4588-8982-28787a11dbd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf54186-c562-4588-8982-28787a11dbd8', 5, 'V', 'Jahla', 'Village Music: V. Jahla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf54186-c562-4588-8982-28787a11dbd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gigue & Musette', part.name_en = 'Village Music: VI. Gigue & Musette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25443 AND p.composer_id = 362 AND part.part_key = 'musicbrainz:236d7b0f-754d-4972-8d39-d88c6ef57911' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:236d7b0f-754d-4972-8d39-d88c6ef57911', 6, 'VI', 'Gigue & Musette', 'Village Music: VI. Gigue & Musette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25443 AND p.composer_id = 362
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236d7b0f-754d-4972-8d39-d88c6ef57911'
);


-- None Western Dance

UPDATE pieces piece
SET piece.title = 'Western Dance', piece.title_en = 'Western Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25855 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <When I Heard at the Close of Day>

UPDATE pieces piece
SET piece.title = '가곡 <When I Heard at the Close of Day>', piece.title_en = 'When I Heard at the Close of Day',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23644 AND piece.composer_id = 362
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jahla

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Jahla', 'Jahla', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Jahla'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8510005d-1b5f-41b9-ac24-5041d978a273'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8510005d-1b5f-41b9-ac24-5041d978a273'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Jahla' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8510005d-1b5f-41b9-ac24-5041d978a273'
);


-- None Mass to Saint Anthony

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mass to Saint Anthony', 'Mass to Saint Anthony', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mass to Saint Anthony'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc700d7c-3b4d-492c-a67c-5e1f3a18000c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc700d7c-3b4d-492c-a67c-5e1f3a18000c'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc700d7c-3b4d-492c-a67c-5e1f3a18000c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8585b14-28a2-4f7c-ac05-7aa978fdf607', 1, NULL, 'Kyrie', 'Mass to Saint Anthony: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8585b14-28a2-4f7c-ac05-7aa978fdf607'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e2303c0-c35b-49a2-a4bf-0fa21863ec3b', 2, NULL, 'Gloria', 'Mass to Saint Anthony: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e2303c0-c35b-49a2-a4bf-0fa21863ec3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b93c3ff4-7a80-45a5-829e-81ed1ddce81d', 3, NULL, 'Credo', 'Mass to Saint Anthony: Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b93c3ff4-7a80-45a5-829e-81ed1ddce81d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ffe4292-02f3-4890-a35f-dad3929cfd2a', 4, NULL, 'Sanctus', 'Mass to Saint Anthony: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ffe4292-02f3-4890-a35f-dad3929cfd2a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9500b9c2-38f9-49cc-8d32-3194deb766d5', 5, NULL, 'Agnus Dei', 'Mass to Saint Anthony: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Mass to Saint Anthony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9500b9c2-38f9-49cc-8d32-3194deb766d5'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4994b533-8543-444e-9a59-fc94a0ed4b72'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4994b533-8543-444e-9a59-fc94a0ed4b72'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4994b533-8543-444e-9a59-fc94a0ed4b72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:357902a7-78ed-4d63-8bd4-efc4b9e6dc7e', 1, 'I', 'Allegro', 'Piano Concerto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:357902a7-78ed-4d63-8bd4-efc4b9e6dc7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba73ba0-dd0b-4836-8347-d0df45301a54', 2, 'II', 'Stampede. Allegro', 'Piano Concerto: II. Stampede. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba73ba0-dd0b-4836-8347-d0df45301a54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba5a290-f94e-43f9-9e49-4250aad203dd', 3, 'III', 'Largo', 'Piano Concerto: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba5a290-f94e-43f9-9e49-4250aad203dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da06e1c6-02d8-424c-9a25-80edec6c89fe', 4, 'IV', 'Allegro moderato', 'Piano Concerto: IV. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da06e1c6-02d8-424c-9a25-80edec6c89fe'
);


-- None 피아노 소나타 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 3번', 'Piano Sonata no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa78e97b-de4d-4abc-9929-61285615d081'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa78e97b-de4d-4abc-9929-61285615d081'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa78e97b-de4d-4abc-9929-61285615d081'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:920f1616-ad4a-4a40-bad0-9e6eedd3e6b9', 1, NULL, 'Slowish and Singing', 'Piano Sonata no. 3: 1. Slowish and Singing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:920f1616-ad4a-4a40-bad0-9e6eedd3e6b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a849f73a-c419-4164-a8aa-bad9d479c9a9', 2, NULL, 'Fast and Rugged', 'Piano Sonata no. 3: 2. Fast and Rugged', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a849f73a-c419-4164-a8aa-bad9d479c9a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f930d4f4-4e2d-4c1e-b0f1-70f44784220b', 3, NULL, 'Very Slow, Very Singing and Solemn', 'Piano Sonata no. 3: 3. Very Slow, Very Singing and Solemn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '피아노 소나타 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f930d4f4-4e2d-4c1e-b0f1-70f44784220b'
);


-- None 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카', 'Polka', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f92ac4d-6d0f-4017-8546-cc2255eeb140'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f92ac4d-6d0f-4017-8546-cc2255eeb140'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f92ac4d-6d0f-4017-8546-cc2255eeb140'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ef97211-ca86-402f-ae3a-48953f722ab2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ef97211-ca86-402f-ae3a-48953f722ab2'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ef97211-ca86-402f-ae3a-48953f722ab2'
);


-- None 교향곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번', 'Symphony no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '109f7249-bca8-4990-a580-fed1647e813c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '109f7249-bca8-4990-a580-fed1647e813c'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '109f7249-bca8-4990-a580-fed1647e813c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd783831-49a1-4472-a76c-600c6139f079', 1, 'I', 'Allegro moderato', 'Symphony no. 3: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd783831-49a1-4472-a76c-600c6139f079'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ef389c-4bbd-4a0c-9d59-5f2cd5c1b6d6', 2, 'II', 'A Reel in Honor of Henry Cowell', 'Symphony no. 3: II. A Reel in Honor of Henry Cowell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ef389c-4bbd-4a0c-9d59-5f2cd5c1b6d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24068bb9-9d48-44b5-b612-02e9557d7837', 3, 'III', 'A Waltz for Evelyn Hinrichsen', 'Symphony no. 3: III. A Waltz for Evelyn Hinrichsen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24068bb9-9d48-44b5-b612-02e9557d7837'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39da3bd2-c419-491a-89ef-a133775a028d', 4, 'IV', 'An Estampie for Susan Summerfield', 'Symphony no. 3: IV. An Estampie for Susan Summerfield', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39da3bd2-c419-491a-89ef-a133775a028d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25e3dc5b-85ba-48a3-a42f-d892d8d0c076', 5, 'V', 'Largo ostinato', 'Symphony no. 3: V. Largo ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e3dc5b-85ba-48a3-a42f-d892d8d0c076'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:552187e5-0cc9-4c4c-b669-23af25fdc8df', 6, 'VI', 'Allegro', 'Symphony no. 3: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552187e5-0cc9-4c4c-b669-23af25fdc8df'
);


-- None Varied Trio

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Varied Trio', 'Varied Trio', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 362
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Varied Trio'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25733871-04c4-4fee-885f-e94355fea2a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25733871-04c4-4fee-885f-e94355fea2a8'
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25733871-04c4-4fee-885f-e94355fea2a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d7dd180-418c-436f-8ac8-cadcc3c3c71a', 1, 'I', 'Gending', 'Varied Trio: I. Gending', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d7dd180-418c-436f-8ac8-cadcc3c3c71a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4168535a-3830-4c9d-b772-4399017b0ea3', 2, 'III', 'Elegy', 'Varied Trio: III. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4168535a-3830-4c9d-b772-4399017b0ea3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab85256d-388a-4eab-9116-bb272c42175a', 3, 'II', 'Bowl Bells', 'Varied Trio: II. Bowl Bells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab85256d-388a-4eab-9116-bb272c42175a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4c76b58-2771-47e6-856c-947b6fa84a0a', 4, 'V', 'Dance', 'Varied Trio: V. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c76b58-2771-47e6-856c-947b6fa84a0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8621b0c-7628-49d9-9f7b-63f6c7ee6d19', 5, 'IV', 'Rondeau in Honor of Fragonard', 'Varied Trio: IV. Rondeau in Honor of Fragonard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 362 AND p.title = 'Varied Trio' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8621b0c-7628-49d9-9f7b-63f6c7ee6d19'
);


-- 숨길 seed 작품 없음
