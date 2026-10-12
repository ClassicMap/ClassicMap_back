-- 잔 프란체스코 말리피에로 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 90개(묶음 21, 다악장 39, 낱곡 30),
-- 새 작품 6개, part 241개, 그 아래 0개.
-- seed 102개 중 84개를 작품·part 에 잇고, 1개를 숨기고, 17개는 그대로 둔다.
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

-- None A Claudio Debussy

UPDATE pieces piece
SET piece.title = 'A Claudio Debussy', piece.title_en = 'A Claudio Debussy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16247 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Guido M. Gatti

UPDATE pieces piece
SET piece.title = 'A Guido M. Gatti', piece.title_en = 'A Guido M. Gatti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17087 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante mesto

UPDATE pieces piece
SET piece.title = 'Andante mesto', piece.title_en = 'Andante mesto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20069 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andantino

UPDATE pieces piece
SET piece.title = 'Andantino', piece.title_en = 'Andantino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17799 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Armenia. Canti armeni tradotti sinfonicamente

UPDATE pieces piece
SET piece.title = 'Armenia. Canti armeni tradotti sinfonicamente', piece.title_en = 'Armenia. Canti armeni tradotti sinfonicamente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18565 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barlumi

UPDATE pieces piece
SET piece.title = 'Barlumi', piece.title_en = 'Barlumi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18771 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Non lento troppo. scorrevole', part.name_en = 'Barlumi: I. Non lento troppo. scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18771 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7c7625e1-befd-42c8-a946-93ba5e08acab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c7625e1-befd-42c8-a946-93ba5e08acab', 1, 'I', 'Non lento troppo. scorrevole', 'Barlumi: I. Non lento troppo. scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18771 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c7625e1-befd-42c8-a946-93ba5e08acab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Barlumi: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18771 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:79355c9b-ef9d-440c-a474-3116f5549ce7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79355c9b-ef9d-440c-a474-3116f5549ce7', 2, 'II', 'Lento', 'Barlumi: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18771 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79355c9b-ef9d-440c-a474-3116f5549ce7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace. atquanto mosso', part.name_en = 'Barlumi: III. Vivace. atquanto mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18771 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:9b74507a-3be8-42b8-b197-a18148488a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b74507a-3be8-42b8-b197-a18148488a67', 3, 'III', 'Vivace. atquanto mosso', 'Barlumi: III. Vivace. atquanto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18771 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b74507a-3be8-42b8-b197-a18148488a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento. Misterioso', part.name_en = 'Barlumi: IV. Lento. Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18771 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b80a173e-6152-4ed3-9ad5-ab3f35ba0f9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b80a173e-6152-4ed3-9ad5-ab3f35ba0f9f', 4, 'IV', 'Lento. Misterioso', 'Barlumi: IV. Lento. Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18771 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b80a173e-6152-4ed3-9ad5-ab3f35ba0f9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Molto vivace', part.name_en = 'Barlumi: V. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18771 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:c6b447cd-6f9b-4d24-af15-d2001e348f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6b447cd-6f9b-4d24-af15-d2001e348f53', 5, 'V', 'Molto vivace', 'Barlumi: V. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18771 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b447cd-6f9b-4d24-af15-d2001e348f53'
);


-- None Bianchi e neri

UPDATE pieces piece
SET piece.title = 'Bianchi e neri', piece.title_en = 'Bianchi e neri',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17045 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lento, non troppo – Un poco agitato – Tranquillo – Mosso – Meno mosso – Tempo I – Agitato – Piuttosto calmo – Tempo I – Calmo', part.name_en = 'Bianchi e neri: Lento, non troppo – Un poco agitato – Tranquillo – Mosso – Meno mosso – Tempo I – Agitato – Piuttosto calmo – Tempo I – Calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17045 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7b0bf9ac-99cf-473d-afe3-6cba295bf956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0bf9ac-99cf-473d-afe3-6cba295bf956', 1, NULL, 'Lento, non troppo – Un poco agitato – Tranquillo – Mosso – Meno mosso – Tempo I – Agitato – Piuttosto calmo – Tempo I – Calmo', 'Bianchi e neri: Lento, non troppo – Un poco agitato – Tranquillo – Mosso – Meno mosso – Tempo I – Agitato – Piuttosto calmo – Tempo I – Calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17045 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0bf9ac-99cf-473d-afe3-6cba295bf956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Non troppo lento – Lento e rallentando – Allegro – Molto lento – Molto tranquillo – Tranquillo', part.name_en = 'Bianchi e neri: Non troppo lento – Lento e rallentando – Allegro – Molto lento – Molto tranquillo – Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17045 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:93d357f7-1a1c-47f7-8ee1-bbf89efd61d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93d357f7-1a1c-47f7-8ee1-bbf89efd61d0', 2, NULL, 'Non troppo lento – Lento e rallentando – Allegro – Molto lento – Molto tranquillo – Tranquillo', 'Bianchi e neri: Non troppo lento – Lento e rallentando – Allegro – Molto lento – Molto tranquillo – Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17045 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93d357f7-1a1c-47f7-8ee1-bbf89efd61d0'
);


-- None Cavalcate

UPDATE pieces piece
SET piece.title = 'Cavalcate', piece.title_en = 'Cavalcate',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17701 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Recalcitrante (Somaro). Non ritenuto', part.name_en = 'Cavalcate: I. Recalcitrante (Somaro). Non ritenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17701 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:11d2eeaa-b189-4263-a6eb-10d255ebebc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11d2eeaa-b189-4263-a6eb-10d255ebebc9', 1, 'I', 'Recalcitrante (Somaro). Non ritenuto', 'Cavalcate: I. Recalcitrante (Somaro). Non ritenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17701 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11d2eeaa-b189-4263-a6eb-10d255ebebc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dondolante (Camello). Lento', part.name_en = 'Cavalcate: II. Dondolante (Camello). Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17701 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:772b4c8c-f896-4728-ac60-47848e9a2207' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:772b4c8c-f896-4728-ac60-47848e9a2207', 2, 'II', 'Dondolante (Camello). Lento', 'Cavalcate: II. Dondolante (Camello). Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17701 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:772b4c8c-f896-4728-ac60-47848e9a2207'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Focoso (Destriero). Mosso, ma ben ritmato', part.name_en = 'Cavalcate: III. Focoso (Destriero). Mosso, ma ben ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17701 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4389dd96-6abf-47c8-a13d-4d55ae104f4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4389dd96-6abf-47c8-a13d-4d55ae104f4a', 3, 'III', 'Focoso (Destriero). Mosso, ma ben ritmato', 'Cavalcate: III. Focoso (Destriero). Mosso, ma ben ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17701 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4389dd96-6abf-47c8-a13d-4d55ae104f4a'
);


-- None Cinq melodies

UPDATE pieces piece
SET piece.title = 'Cinq melodies', piece.title_en = 'Cinq melodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16070 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L’Archet', part.name_en = 'Cinq melodies: L’Archet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16070 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:240d8ffd-11aa-436b-a0fe-37fa49396434' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240d8ffd-11aa-436b-a0fe-37fa49396434', 1, NULL, 'L’Archet', 'Cinq melodies: L’Archet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16070 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240d8ffd-11aa-436b-a0fe-37fa49396434'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pégase', part.name_en = 'Cinq melodies: Pégase',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16070 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:290ec9f1-e13f-4e49-b5d7-1a0f7d4fc153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:290ec9f1-e13f-4e49-b5d7-1a0f7d4fc153', 2, NULL, 'Pégase', 'Cinq melodies: Pégase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16070 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:290ec9f1-e13f-4e49-b5d7-1a0f7d4fc153'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chanson morave', part.name_en = 'Cinq melodies: Chanson morave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16070 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:83eb5fc4-d826-4d22-a8a6-ea61c4dc9750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83eb5fc4-d826-4d22-a8a6-ea61c4dc9750', 3, NULL, 'Chanson morave', 'Cinq melodies: Chanson morave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16070 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83eb5fc4-d826-4d22-a8a6-ea61c4dc9750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ariette', part.name_en = 'Cinq melodies: Ariette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16070 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8db54e63-25ec-4a0b-8f45-3fab7f752ed2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db54e63-25ec-4a0b-8f45-3fab7f752ed2', 4, NULL, 'Ariette', 'Cinq melodies: Ariette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16070 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db54e63-25ec-4a0b-8f45-3fab7f752ed2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Les yeux couleur du temps', part.name_en = 'Cinq melodies: Les yeux couleur du temps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16070 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a12f327b-544b-4c3d-9c54-7827f69a8337' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a12f327b-544b-4c3d-9c54-7827f69a8337', 5, NULL, 'Les yeux couleur du temps', 'Cinq melodies: Les yeux couleur du temps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16070 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12f327b-544b-4c3d-9c54-7827f69a8337'
);


-- None Cinque studi per domani

UPDATE pieces piece
SET piece.title = 'Cinque studi per domani', piece.title_en = 'Cinque studi per domani',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16145 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mosso moderatamente, ma gagliardo', part.name_en = 'Cinque studi per domani: I. Mosso moderatamente, ma gagliardo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16145 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0e7fac80-f0cf-4951-b45b-c940dd9e1177' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e7fac80-f0cf-4951-b45b-c940dd9e1177', 1, 'I', 'Mosso moderatamente, ma gagliardo', 'Cinque studi per domani: I. Mosso moderatamente, ma gagliardo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16145 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e7fac80-f0cf-4951-b45b-c940dd9e1177'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Non troppo mosso', part.name_en = 'Cinque studi per domani: V. Non troppo mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16145 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:28acd70d-f454-45ee-8c97-42bc527ad062' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28acd70d-f454-45ee-8c97-42bc527ad062', 2, 'V', 'Non troppo mosso', 'Cinque studi per domani: V. Non troppo mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16145 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28acd70d-f454-45ee-8c97-42bc527ad062'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Cinque studi per domani: IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16145 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2e50d593-8677-4bc1-8c39-36e31495847a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e50d593-8677-4bc1-8c39-36e31495847a', 3, 'IV', 'Lento', 'Cinque studi per domani: IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16145 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e50d593-8677-4bc1-8c39-36e31495847a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Non troppo mosso, ma fluido', part.name_en = 'Cinque studi per domani: III. Non troppo mosso, ma fluido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16145 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:316bae31-6f8b-462a-add6-a603905c8058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:316bae31-6f8b-462a-add6-a603905c8058', 4, 'III', 'Non troppo mosso, ma fluido', 'Cinque studi per domani: III. Non troppo mosso, ma fluido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16145 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:316bae31-6f8b-462a-add6-a603905c8058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Un poco allegro', part.name_en = 'Cinque studi per domani: II. Un poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16145 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7975779c-97b4-4a7f-bf47-d80de07ad627' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7975779c-97b4-4a7f-bf47-d80de07ad627', 5, 'II', 'Un poco allegro', 'Cinque studi per domani: II. Un poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16145 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7975779c-97b4-4a7f-bf47-d80de07ad627'
);


-- None 협주곡

UPDATE pieces piece
SET piece.title = '협주곡', piece.title_en = 'Concerti',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16660 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Concerto di tamburi', part.name_en = 'Concerti: Concerto di tamburi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0cd634e8-acd5-49aa-a70d-e5c774b0f6f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cd634e8-acd5-49aa-a70d-e5c774b0f6f4', 1, NULL, 'Concerto di tamburi', 'Concerti: Concerto di tamburi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cd634e8-acd5-49aa-a70d-e5c774b0f6f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Concerto di clarinetti', part.name_en = 'Concerti: Concerto di clarinetti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:3823c423-605c-4e0a-bba6-b402282b27c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3823c423-605c-4e0a-bba6-b402282b27c2', 2, NULL, 'Concerto di clarinetti', 'Concerti: Concerto di clarinetti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3823c423-605c-4e0a-bba6-b402282b27c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Concerto di oboi', part.name_en = 'Concerti: Concerto di oboi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:49c1459b-a522-470f-9072-0780cd7075d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c1459b-a522-470f-9072-0780cd7075d0', 3, NULL, 'Concerto di oboi', 'Concerti: Concerto di oboi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c1459b-a522-470f-9072-0780cd7075d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Concerto di flauti', part.name_en = 'Concerti: Concerto di flauti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:54fd4968-8c33-41fa-9d7a-7f2a89732d04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54fd4968-8c33-41fa-9d7a-7f2a89732d04', 4, NULL, 'Concerto di flauti', 'Concerti: Concerto di flauti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54fd4968-8c33-41fa-9d7a-7f2a89732d04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Commiato', part.name_en = 'Concerti: Commiato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:673f5372-0dff-41ca-9d00-1ab0870c1573' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673f5372-0dff-41ca-9d00-1ab0870c1573', 5, NULL, 'Commiato', 'Concerti: Commiato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673f5372-0dff-41ca-9d00-1ab0870c1573'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Concerto di trombe', part.name_en = 'Concerti: Concerto di trombe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:9e2ce2c5-a5fa-422e-ae86-73ca4aff9bf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e2ce2c5-a5fa-422e-ae86-73ca4aff9bf5', 6, NULL, 'Concerto di trombe', 'Concerti: Concerto di trombe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e2ce2c5-a5fa-422e-ae86-73ca4aff9bf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Concerto di contrabbassi', part.name_en = 'Concerti: Concerto di contrabbassi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:ab44d3d5-b3e6-4739-a4b9-20f789161c9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab44d3d5-b3e6-4739-a4b9-20f789161c9c', 7, NULL, 'Concerto di contrabbassi', 'Concerti: Concerto di contrabbassi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab44d3d5-b3e6-4739-a4b9-20f789161c9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Esordio', part.name_en = 'Concerti: Esordio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:de6d6098-0c80-4422-b0ea-1c13ad44be34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de6d6098-0c80-4422-b0ea-1c13ad44be34', 8, NULL, 'Esordio', 'Concerti: Esordio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de6d6098-0c80-4422-b0ea-1c13ad44be34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Concerto di fagotti', part.name_en = 'Concerti: Concerto di fagotti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16660 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:eb713b37-4166-4536-89b2-5ed42903d014' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb713b37-4166-4536-89b2-5ed42903d014', 9, NULL, 'Concerto di fagotti', 'Concerti: Concerto di fagotti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16660 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb713b37-4166-4536-89b2-5ed42903d014'
);


-- None Concerto for Two Pianos and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Two Pianos and Orchestra', piece.title_en = 'Concerto for Two Pianos and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17908 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Two Pianos and Orchestra: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17908 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:c72fb099-4252-4357-b2b7-d4fd75228925' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c72fb099-4252-4357-b2b7-d4fd75228925', 1, NULL, 'I', 'Concerto for Two Pianos and Orchestra: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17908 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72fb099-4252-4357-b2b7-d4fd75228925'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Two Pianos and Orchestra: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17908 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b416fe91-3753-489c-bec7-9ca76617aafa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b416fe91-3753-489c-bec7-9ca76617aafa', 2, NULL, 'II', 'Concerto for Two Pianos and Orchestra: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17908 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b416fe91-3753-489c-bec7-9ca76617aafa'
);


-- None 가곡 <De Profundis>

UPDATE pieces piece
SET piece.title = '가곡 <De Profundis>', piece.title_en = 'De Profundis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18166 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux fragments de Filomela e l’Infatuato

UPDATE pieces piece
SET piece.title = 'Deux fragments de Filomela e l’Infatuato', piece.title_en = 'Deux fragments de Filomela e l’Infatuato',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18597 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Danza e morte dell’orso', part.name_en = 'Deux fragments de Filomela e l’Infatuato: Danza e morte dell’orso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18597 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:bbb435eb-828b-4bce-a814-a63165e66060' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb435eb-828b-4bce-a814-a63165e66060', 1, NULL, 'Danza e morte dell’orso', 'Deux fragments de Filomela e l’Infatuato: Danza e morte dell’orso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18597 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb435eb-828b-4bce-a814-a63165e66060'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Filomela in Arcadia', part.name_en = 'Deux fragments de Filomela e l’Infatuato: Filomela in Arcadia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18597 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:445506ab-2ae2-49f0-af61-f25c59f5864b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445506ab-2ae2-49f0-af61-f25c59f5864b', 2, NULL, 'Filomela in Arcadia', 'Deux fragments de Filomela e l’Infatuato: Filomela in Arcadia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18597 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445506ab-2ae2-49f0-af61-f25c59f5864b'
);


-- None Dialogo no. 4 "per 5 strumenti a perdifiato"

UPDATE pieces piece
SET piece.title = 'Dialogo no. 4 "per 5 strumenti a perdifiato"', piece.title_en = 'Dialogo no. 4 "per 5 strumenti a perdifiato"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20047 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Due romanze di Domenico Gnoli

UPDATE pieces piece
SET piece.title = 'Due romanze di Domenico Gnoli', piece.title_en = 'Due romanze di Domenico Gnoli',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17715 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fuga d’ale', part.name_en = 'Due romanze di domenico gnoli: Fuga d’ale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17715 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0475f0fd-a62f-4783-89f5-859bd71b1b0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0475f0fd-a62f-4783-89f5-859bd71b1b0c', 1, NULL, 'Fuga d’ale', 'Due romanze di domenico gnoli: Fuga d’ale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17715 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0475f0fd-a62f-4783-89f5-859bd71b1b0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Onomasticon', part.name_en = 'Due romanze di domenico gnoli: Onomasticon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17715 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5900544c-1fda-499a-815e-0a0fda4fa0bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5900544c-1fda-499a-815e-0a0fda4fa0bc', 2, NULL, 'Onomasticon', 'Due romanze di domenico gnoli: Onomasticon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17715 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5900544c-1fda-499a-815e-0a0fda4fa0bc'
);


-- None Due sonetti del Berni

UPDATE pieces piece
SET piece.title = 'Due sonetti del Berni', piece.title_en = 'Due sonetti del Berni',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18001 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cancheri e beccafichi', part.name_en = 'Due sonetti del berni: Cancheri e beccafichi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18001 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:6bcb3630-c1cd-453f-8ce0-bfec322ba949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bcb3630-c1cd-453f-8ce0-bfec322ba949', 1, NULL, 'Cancheri e beccafichi', 'Due sonetti del berni: Cancheri e beccafichi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18001 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bcb3630-c1cd-453f-8ce0-bfec322ba949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chiome d’argento fine', part.name_en = 'Due sonetti del berni: Chiome d’argento fine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18001 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b3768a0f-ea61-457a-96de-318e04778556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3768a0f-ea61-457a-96de-318e04778556', 2, NULL, 'Chiome d’argento fine', 'Due sonetti del berni: Chiome d’argento fine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18001 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3768a0f-ea61-457a-96de-318e04778556'
);


-- None Epitaffio

UPDATE pieces piece
SET piece.title = 'Epitaffio', piece.title_en = 'Epitaffio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17551 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Concertante I

UPDATE pieces piece
SET piece.title = 'Fantasia Concertante I', piece.title_en = 'Fantasia Concertante I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19463 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasie di ogni giorno

UPDATE pieces piece
SET piece.title = 'Fantasie di ogni giorno', piece.title_en = 'Fantasie di ogni giorno',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19202 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hortus conclusus

UPDATE pieces piece
SET piece.title = 'Hortus conclusus', piece.title_en = 'Hortus conclusus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17302 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mosso', part.name_en = 'Hortus conclusus: I. Mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d3516cf1-3dde-48c1-bd8e-e54f7b868939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3516cf1-3dde-48c1-bd8e-e54f7b868939', 1, 'I', 'Mosso', 'Hortus conclusus: I. Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3516cf1-3dde-48c1-bd8e-e54f7b868939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento, non troppo', part.name_en = 'Hortus conclusus: II. Lento, non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b68b52fd-0d19-4a67-b4d5-70c74e772230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b68b52fd-0d19-4a67-b4d5-70c74e772230', 2, 'II', 'Lento, non troppo', 'Hortus conclusus: II. Lento, non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68b52fd-0d19-4a67-b4d5-70c74e772230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Hortus conclusus: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a132670d-c243-4fe9-bcc8-2e1c57719cd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a132670d-c243-4fe9-bcc8-2e1c57719cd7', 3, 'III', 'Allegro', 'Hortus conclusus: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a132670d-c243-4fe9-bcc8-2e1c57719cd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante', part.name_en = 'Hortus conclusus: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8462f94b-a460-4266-8c32-475009e1b21f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8462f94b-a460-4266-8c32-475009e1b21f', 4, 'IV', 'Andante', 'Hortus conclusus: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8462f94b-a460-4266-8c32-475009e1b21f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tranquillo', part.name_en = 'Hortus conclusus: V. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5fae6679-fc98-46f4-82dd-eee88c11f7f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fae6679-fc98-46f4-82dd-eee88c11f7f5', 5, 'V', 'Tranquillo', 'Hortus conclusus: V. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fae6679-fc98-46f4-82dd-eee88c11f7f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lentamente, ma fluido', part.name_en = 'Hortus conclusus: VI. Lentamente, ma fluido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0c650725-959e-4445-b655-85f6487f4831' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c650725-959e-4445-b655-85f6487f4831', 6, 'VI', 'Lentamente, ma fluido', 'Hortus conclusus: VI. Lentamente, ma fluido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c650725-959e-4445-b655-85f6487f4831'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegro moderato', part.name_en = 'Hortus conclusus: VII. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17302 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:59c13093-a694-405e-805c-ece06d681f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c13093-a694-405e-805c-ece06d681f65', 7, 'VII', 'Allegro moderato', 'Hortus conclusus: VII. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17302 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c13093-a694-405e-805c-ece06d681f65'
);


-- None Hortus conclusus: VIII. (Quasi variazioni) Tranquillo ma scorrevole – Mosso – Piuttosto mosso

UPDATE pieces piece
SET piece.title = 'Hortus conclusus: VIII. (Quasi variazioni) Tranquillo ma scorrevole – Mosso – Piuttosto mosso', piece.title_en = 'Hortus conclusus: VIII. (Quasi variazioni) Tranquillo ma scorrevole – Mosso – Piuttosto mosso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18251 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I minuetti di Ca’ Tiepolo

UPDATE pieces piece
SET piece.title = 'I minuetti di Ca’ Tiepolo', piece.title_en = 'I minuetti di Ca’ Tiepolo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16952 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'I minuetti di Ca’ Tiepolo: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:051c70a9-aa76-4924-9f78-d2610f247591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:051c70a9-aa76-4924-9f78-d2610f247591', 1, NULL, 'I', 'I minuetti di Ca’ Tiepolo: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:051c70a9-aa76-4924-9f78-d2610f247591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'I minuetti di Ca’ Tiepolo: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a227f673-d680-4ff3-9f26-b680247e8da4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a227f673-d680-4ff3-9f26-b680247e8da4', 2, NULL, 'II', 'I minuetti di Ca’ Tiepolo: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a227f673-d680-4ff3-9f26-b680247e8da4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Triste', part.name_en = 'I minuetti di Ca’ Tiepolo: III. Triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:222cc555-cb88-4ef2-9b25-327094fab7e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:222cc555-cb88-4ef2-9b25-327094fab7e0', 3, NULL, 'Triste', 'I minuetti di Ca’ Tiepolo: III. Triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:222cc555-cb88-4ef2-9b25-327094fab7e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Con espressione', part.name_en = 'I minuetti di Ca’ Tiepolo: IV. Con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8fbaafdc-43ec-4a81-b324-8d49ccc290ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fbaafdc-43ec-4a81-b324-8d49ccc290ff', 4, NULL, 'Con espressione', 'I minuetti di Ca’ Tiepolo: IV. Con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fbaafdc-43ec-4a81-b324-8d49ccc290ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'I minuetti di Ca’ Tiepolo: V. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a9a89896-ec4e-402a-a199-063e0f99e257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a89896-ec4e-402a-a199-063e0f99e257', 5, NULL, 'Andante', 'I minuetti di Ca’ Tiepolo: V. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a89896-ec4e-402a-a199-063e0f99e257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Minuetto, quasi sarabanda', part.name_en = 'I minuetti di Ca’ Tiepolo: VI. Minuetto, quasi sarabanda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16952 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4a8f915f-b9f1-49d4-bd4a-c17cad58bf50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a8f915f-b9f1-49d4-bd4a-c17cad58bf50', 6, NULL, 'Minuetto, quasi sarabanda', 'I minuetti di Ca’ Tiepolo: VI. Minuetto, quasi sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16952 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a8f915f-b9f1-49d4-bd4a-c17cad58bf50'
);


-- None I sonetti delle fate

UPDATE pieces piece
SET piece.title = 'I sonetti delle fate', piece.title_en = 'I sonetti delle fate',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19195 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mirinda', part.name_en = 'I sonetti delle fate: Mirinda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:27577693-85bc-49fb-9bfa-8cab026c4267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27577693-85bc-49fb-9bfa-8cab026c4267', 1, NULL, 'Mirinda', 'I sonetti delle fate: Mirinda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27577693-85bc-49fb-9bfa-8cab026c4267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melusina', part.name_en = 'I sonetti delle fate: Melusina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:74c46a5e-ada7-45f6-a7ec-c722ac1470d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74c46a5e-ada7-45f6-a7ec-c722ac1470d2', 2, NULL, 'Melusina', 'I sonetti delle fate: Melusina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74c46a5e-ada7-45f6-a7ec-c722ac1470d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Oriana – Oriana infedele', part.name_en = 'I sonetti delle fate: Oriana – Oriana infedele',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:874a4317-1b89-4c9e-9fae-3c3c65b84a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874a4317-1b89-4c9e-9fae-3c3c65b84a45', 3, NULL, 'Oriana – Oriana infedele', 'I sonetti delle fate: Oriana – Oriana infedele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874a4317-1b89-4c9e-9fae-3c3c65b84a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Eliana', part.name_en = 'I sonetti delle fate: Eliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a8a7047e-fc54-4e3c-aef2-ae44841b9104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8a7047e-fc54-4e3c-aef2-ae44841b9104', 4, NULL, 'Eliana', 'I sonetti delle fate: Eliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8a7047e-fc54-4e3c-aef2-ae44841b9104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Grasinda', part.name_en = 'I sonetti delle fate: Grasinda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:aa157cbe-fc58-416c-998a-3b53099a1ddc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa157cbe-fc58-416c-998a-3b53099a1ddc', 5, NULL, 'Grasinda', 'I sonetti delle fate: Grasinda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa157cbe-fc58-416c-998a-3b53099a1ddc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Morgana', part.name_en = 'I sonetti delle fate: Morgana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19195 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:eaff089a-34d4-4781-8c45-dca8b9425c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaff089a-34d4-4781-8c45-dca8b9425c6d', 6, NULL, 'Morgana', 'I sonetti delle fate: Morgana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19195 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaff089a-34d4-4781-8c45-dca8b9425c6d'
);


-- None Il canto della lontananza

UPDATE pieces piece
SET piece.title = 'Il canto della lontananza', piece.title_en = 'Il canto della lontananza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19692 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impressioni

UPDATE pieces piece
SET piece.title = 'Impressioni', piece.title_en = 'Impressioni',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19116 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Una processione a mezzanotte (da un’acquaforte di John Wright)', part.name_en = 'Impressioni: I. Una processione a mezzanotte (da un’acquaforte di John Wright)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19116 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0ee13a1e-34d3-4c97-add0-3ab9f4f7f2b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee13a1e-34d3-4c97-add0-3ab9f4f7f2b6', 1, 'I', 'Una processione a mezzanotte (da un’acquaforte di John Wright)', 'Impressioni: I. Una processione a mezzanotte (da un’acquaforte di John Wright)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19116 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee13a1e-34d3-4c97-add0-3ab9f4f7f2b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Madrigale', part.name_en = 'Impressioni: II. Madrigale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19116 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:915fc86b-9518-41de-94a4-86093fa0296a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:915fc86b-9518-41de-94a4-86093fa0296a', 2, 'II', 'Madrigale', 'Impressioni: II. Madrigale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19116 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:915fc86b-9518-41de-94a4-86093fa0296a'
);


-- None Impressioni dal vero I

UPDATE pieces piece
SET piece.title = 'Impressioni dal vero I', piece.title_en = 'Impressioni dal vero I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19029 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Il chiù', part.name_en = 'Impressioni dal vero I: Il chiù',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19029 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:01cd488c-f629-487c-b463-204a0564d399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01cd488c-f629-487c-b463-204a0564d399', 1, NULL, 'Il chiù', 'Impressioni dal vero I: Il chiù', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19029 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01cd488c-f629-487c-b463-204a0564d399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Il picchio', part.name_en = 'Impressioni dal vero I: Il picchio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19029 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b3fc4883-faac-4afd-b3e7-e80ae0400d33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3fc4883-faac-4afd-b3e7-e80ae0400d33', 2, NULL, 'Il picchio', 'Impressioni dal vero I: Il picchio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19029 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3fc4883-faac-4afd-b3e7-e80ae0400d33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Il capinero', part.name_en = 'Impressioni dal vero I: Il capinero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19029 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e5a4ad76-8e8a-4971-ba87-02f9bdec42de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a4ad76-8e8a-4971-ba87-02f9bdec42de', 3, NULL, 'Il capinero', 'Impressioni dal vero I: Il capinero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19029 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a4ad76-8e8a-4971-ba87-02f9bdec42de'
);


-- None Impressioni dal vero II

UPDATE pieces piece
SET piece.title = 'Impressioni dal vero II', piece.title_en = 'Impressioni dal vero II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19220 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Baldoria campestre', part.name_en = 'Impressioni dal vero II: Baldoria campestre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19220 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:15b8ac9e-3129-4a28-91cf-4bdaa5b8a91f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b8ac9e-3129-4a28-91cf-4bdaa5b8a91f', 1, NULL, 'Baldoria campestre', 'Impressioni dal vero II: Baldoria campestre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19220 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b8ac9e-3129-4a28-91cf-4bdaa5b8a91f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I cipressi e il vento', part.name_en = 'Impressioni dal vero II: I cipressi e il vento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19220 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:403f3ed8-0c50-447e-bed4-606ace9abd98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:403f3ed8-0c50-447e-bed4-606ace9abd98', 2, NULL, 'I cipressi e il vento', 'Impressioni dal vero II: I cipressi e il vento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19220 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403f3ed8-0c50-447e-bed4-606ace9abd98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Colloquio di campane', part.name_en = 'Impressioni dal vero II: Colloquio di campane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19220 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:fe951478-38af-41db-8d4b-98d2277bec51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe951478-38af-41db-8d4b-98d2277bec51', 3, NULL, 'Colloquio di campane', 'Impressioni dal vero II: Colloquio di campane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19220 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe951478-38af-41db-8d4b-98d2277bec51'
);


-- None Impressioni dal vero III

UPDATE pieces piece
SET piece.title = 'Impressioni dal vero III', piece.title_en = 'Impressioni dal vero III',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19794 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Festival in val d''inferno', part.name_en = 'Impressioni dal vero III: Festival in val d''inferno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19794 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:3068f039-cea2-42f9-95fb-51b424ed9e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3068f039-cea2-42f9-95fb-51b424ed9e6c', 1, NULL, 'Festival in val d''inferno', 'Impressioni dal vero III: Festival in val d''inferno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19794 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3068f039-cea2-42f9-95fb-51b424ed9e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I galli', part.name_en = 'Impressioni dal vero III: I galli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19794 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:83687595-d006-4688-b089-d951bd1c6f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83687595-d006-4688-b089-d951bd1c6f4f', 2, NULL, 'I galli', 'Impressioni dal vero III: I galli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19794 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83687595-d006-4688-b089-d951bd1c6f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La tarantella a Capri', part.name_en = 'Impressioni dal vero III: La tarantella a Capri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19794 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b707c4fe-7c97-4c29-8d8a-457db0a44a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b707c4fe-7c97-4c29-8d8a-457db0a44a69', 3, NULL, 'La tarantella a Capri', 'Impressioni dal vero III: La tarantella a Capri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19794 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b707c4fe-7c97-4c29-8d8a-457db0a44a69'
);


-- None Keepsake

UPDATE pieces piece
SET piece.title = 'Keepsake', piece.title_en = 'Keepsake',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16670 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Light', part.name_en = 'Keepsake: Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16670 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:6052517b-62b5-45cc-bad7-e74b8b2a45bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6052517b-62b5-45cc-bad7-e74b8b2a45bd', 1, NULL, 'Light', 'Keepsake: Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16670 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6052517b-62b5-45cc-bad7-e74b8b2a45bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Stream', part.name_en = 'Keepsake: Stream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16670 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:c21896a7-2c28-4e33-bf6a-c78117a0b002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c21896a7-2c28-4e33-bf6a-c78117a0b002', 2, NULL, 'Stream', 'Keepsake: Stream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16670 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21896a7-2c28-4e33-bf6a-c78117a0b002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song', part.name_en = 'Keepsake: Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16670 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:db8dce9c-e037-4cd6-a3a3-fae25f7bcab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db8dce9c-e037-4cd6-a3a3-fae25f7bcab5', 3, NULL, 'Song', 'Keepsake: Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16670 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db8dce9c-e037-4cd6-a3a3-fae25f7bcab5'
);


-- None 가곡 <La cavalcata della morte>

UPDATE pieces piece
SET piece.title = '가곡 <La cavalcata della morte>', piece.title_en = 'La cavalcata della morte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17289 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Le sette allegrezze d’amore>

UPDATE pieces piece
SET piece.title = '가곡 <Le sette allegrezze d’amore>', piece.title_en = 'Le sette allegrezze d’amore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17628 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le stagioni italiche

UPDATE pieces piece
SET piece.title = 'Le stagioni italiche', piece.title_en = 'Le stagioni italiche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19262 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ditirambo III', part.name_en = 'Le stagioni italiche: Ditirambo III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19262 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0e11cbd1-3926-446d-93f0-699c13af4335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e11cbd1-3926-446d-93f0-699c13af4335', 1, NULL, 'Ditirambo III', 'Le stagioni italiche: Ditirambo III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19262 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e11cbd1-3926-446d-93f0-699c13af4335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Capriccio', part.name_en = 'Le stagioni italiche: Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19262 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7afbbf66-84f9-4a73-9b13-4c0c3094bc28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7afbbf66-84f9-4a73-9b13-4c0c3094bc28', 2, NULL, 'Capriccio', 'Le stagioni italiche: Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19262 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7afbbf66-84f9-4a73-9b13-4c0c3094bc28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Canto della neve', part.name_en = 'Le stagioni italiche: Canto della neve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19262 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a351b1f9-a450-4207-9a50-73ff8959ed32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a351b1f9-a450-4207-9a50-73ff8959ed32', 3, NULL, 'Canto della neve', 'Le stagioni italiche: Canto della neve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19262 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a351b1f9-a450-4207-9a50-73ff8959ed32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lauda per un morto', part.name_en = 'Le stagioni italiche: Lauda per un morto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19262 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:cbb582af-34c9-44d6-a764-1660172aa4a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbb582af-34c9-44d6-a764-1660172aa4a9', 4, NULL, 'Lauda per un morto', 'Le stagioni italiche: Lauda per un morto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19262 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbb582af-34c9-44d6-a764-1660172aa4a9'
);


-- None Maschere che passano

UPDATE pieces piece
SET piece.title = 'Maschere che passano', piece.title_en = 'Maschere che passano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18140 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace. Molto capriccioso', part.name_en = 'Maschere che passano: I. Allegro vivace. Molto capriccioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18140 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5dcf1c55-da86-48fc-8122-ab764a472b6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dcf1c55-da86-48fc-8122-ab764a472b6b', 1, 'I', 'Allegro vivace. Molto capriccioso', 'Maschere che passano: I. Allegro vivace. Molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18140 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dcf1c55-da86-48fc-8122-ab764a472b6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento ma non troppo. Con una certa goffaggine', part.name_en = 'Maschere che passano: II. Lento ma non troppo. Con una certa goffaggine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18140 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:280ffdb0-a75f-4c1a-a53c-a063fdd2aba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:280ffdb0-a75f-4c1a-a53c-a063fdd2aba0', 2, 'II', 'Lento ma non troppo. Con una certa goffaggine', 'Maschere che passano: II. Lento ma non troppo. Con una certa goffaggine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18140 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:280ffdb0-a75f-4c1a-a53c-a063fdd2aba0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mosso. Spiritato', part.name_en = 'Maschere che passano: III. Mosso. Spiritato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18140 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4db8bca3-7cfc-4ddf-93a3-638c810eae77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db8bca3-7cfc-4ddf-93a3-638c810eae77', 3, 'III', 'Mosso. Spiritato', 'Maschere che passano: III. Mosso. Spiritato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18140 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db8bca3-7cfc-4ddf-93a3-638c810eae77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Un poco ritenuto. Con enfasi grottesca', part.name_en = 'Maschere che passano: IV. Un poco ritenuto. Con enfasi grottesca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18140 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:044489a3-c754-4103-aacd-c18e4371465b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:044489a3-c754-4103-aacd-c18e4371465b', 4, 'IV', 'Un poco ritenuto. Con enfasi grottesca', 'Maschere che passano: IV. Un poco ritenuto. Con enfasi grottesca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18140 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:044489a3-c754-4103-aacd-c18e4371465b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vivacissimo. Furiosamente', part.name_en = 'Maschere che passano: V. Vivacissimo. Furiosamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18140 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:bb830123-6ef4-4e83-83fd-8c589eadd0fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb830123-6ef4-4e83-83fd-8c589eadd0fb', 5, 'V', 'Vivacissimo. Furiosamente', 'Maschere che passano: V. Vivacissimo. Furiosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18140 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb830123-6ef4-4e83-83fd-8c589eadd0fb'
);


-- None 가곡 <Mondi celesti>

UPDATE pieces piece
SET piece.title = '가곡 <Mondi celesti>', piece.title_en = 'Mondi celesti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18612 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Omaggi

UPDATE pieces piece
SET piece.title = 'Omaggi', piece.title_en = 'Omaggi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18399 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A un pappagallo', part.name_en = 'Omaggi: I. A un pappagallo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18399 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:126b00f6-8e05-40c2-bd28-7ca637f69dc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:126b00f6-8e05-40c2-bd28-7ca637f69dc2', 1, 'I', 'A un pappagallo', 'Omaggi: I. A un pappagallo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18399 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126b00f6-8e05-40c2-bd28-7ca637f69dc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A un elefante', part.name_en = 'Omaggi: II. A un elefante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18399 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:02c71ddf-601f-4fb2-a321-64185c61e807' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02c71ddf-601f-4fb2-a321-64185c61e807', 2, 'II', 'A un elefante', 'Omaggi: II. A un elefante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18399 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c71ddf-601f-4fb2-a321-64185c61e807'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A un idiota', part.name_en = 'Omaggi: III. A un idiota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18399 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8d46f95c-cefb-493e-8463-1f211b96ab36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d46f95c-cefb-493e-8463-1f211b96ab36', 3, 'III', 'A un idiota', 'Omaggi: III. A un idiota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18399 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d46f95c-cefb-493e-8463-1f211b96ab36'
);


-- None Oriente immaginario

UPDATE pieces piece
SET piece.title = 'Oriente immaginario', piece.title_en = 'Oriente immaginario',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16217 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Leggermente mosso', part.name_en = 'Oriente immaginario: I. Leggermente mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16217 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d68a4331-30fc-441f-bf06-67e5aaefb903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d68a4331-30fc-441f-bf06-67e5aaefb903', 1, 'I', 'Leggermente mosso', 'Oriente immaginario: I. Leggermente mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16217 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d68a4331-30fc-441f-bf06-67e5aaefb903'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Alquanto lento', part.name_en = 'Oriente immaginario: II. Alquanto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16217 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e0fe8441-9ecd-47ec-ab93-e37165a13694' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0fe8441-9ecd-47ec-ab93-e37165a13694', 2, 'II', 'Alquanto lento', 'Oriente immaginario: II. Alquanto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16217 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0fe8441-9ecd-47ec-ab93-e37165a13694'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Non troppo mosso', part.name_en = 'Oriente immaginario: III. Non troppo mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16217 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:fa0a7f75-f7e0-4582-b67e-5d27ad9f7a65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0a7f75-f7e0-4582-b67e-5d27ad9f7a65', 3, 'III', 'Non troppo mosso', 'Oriente immaginario: III. Non troppo mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16217 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0a7f75-f7e0-4582-b67e-5d27ad9f7a65'
);


-- None Passacaglie

UPDATE pieces piece
SET piece.title = 'Passacaglie', piece.title_en = 'Passacaglie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19615 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Piuttosto lento [♩ = 60]', part.name_en = 'Passacaglie: No. 1. Piuttosto lento [♩ = 60]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19615 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4b93f6d8-570f-4375-9cb8-b1462b7f79f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b93f6d8-570f-4375-9cb8-b1462b7f79f6', 1, NULL, 'Piuttosto lento [♩ = 60]', 'Passacaglie: No. 1. Piuttosto lento [♩ = 60]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19615 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b93f6d8-570f-4375-9cb8-b1462b7f79f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro [♩ = 120]', part.name_en = 'Passacaglie: No. 2. Allegro [♩ = 120]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19615 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4230a3a5-1eee-4816-ad65-7f66ef9187e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4230a3a5-1eee-4816-ad65-7f66ef9187e0', 2, NULL, 'Allegro [♩ = 120]', 'Passacaglie: No. 2. Allegro [♩ = 120]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19615 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4230a3a5-1eee-4816-ad65-7f66ef9187e0'
);


-- None Pause del silenzio I

UPDATE pieces piece
SET piece.title = 'Pause del silenzio I', piece.title_en = 'Pause del silenzio I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19963 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Pause del silenzio I: I. Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:3a601d86-653b-4efc-8846-8bad4588af46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a601d86-653b-4efc-8846-8bad4588af46', 1, 'I', 'Lento, ma non troppo', 'Pause del silenzio I: I. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a601d86-653b-4efc-8846-8bad4588af46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Agitato assai', part.name_en = 'Pause del silenzio I: II. Agitato assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:394ae756-c239-4b98-a0b8-df6189aeeca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:394ae756-c239-4b98-a0b8-df6189aeeca0', 2, 'II', 'Agitato assai', 'Pause del silenzio I: II. Agitato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:394ae756-c239-4b98-a0b8-df6189aeeca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Non troppo lento', part.name_en = 'Pause del silenzio I: III. Non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b80565d7-c8cc-4570-acef-ce5e74ff1e3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b80565d7-c8cc-4570-acef-ce5e74ff1e3e', 3, 'III', 'Non troppo lento', 'Pause del silenzio I: III. Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b80565d7-c8cc-4570-acef-ce5e74ff1e3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace assai', part.name_en = 'Pause del silenzio I: IV. Vivace assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f519e88c-e6ea-4760-979b-8877843c4482' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f519e88c-e6ea-4760-979b-8877843c4482', 4, 'IV', 'Vivace assai', 'Pause del silenzio I: IV. Vivace assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f519e88c-e6ea-4760-979b-8877843c4482'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lento, funebre', part.name_en = 'Pause del silenzio I: V. Lento, funebre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5b66ea0e-4ee6-4b6c-9396-afec373417a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b66ea0e-4ee6-4b6c-9396-afec373417a6', 5, 'V', 'Lento, funebre', 'Pause del silenzio I: V. Lento, funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b66ea0e-4ee6-4b6c-9396-afec373417a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro assai', part.name_en = 'Pause del silenzio I: VI. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b27ce255-4b88-49c6-8682-7882733ac91f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b27ce255-4b88-49c6-8682-7882733ac91f', 6, 'VI', 'Allegro assai', 'Pause del silenzio I: VI. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b27ce255-4b88-49c6-8682-7882733ac91f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegro vivace e marcato', part.name_en = 'Pause del silenzio I: VII. Allegro vivace e marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19963 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:77c198e6-1d7a-444f-9147-fa6db4ce5b59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77c198e6-1d7a-444f-9147-fa6db4ce5b59', 7, 'VII', 'Allegro vivace e marcato', 'Pause del silenzio I: VII. Allegro vivace e marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19963 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77c198e6-1d7a-444f-9147-fa6db4ce5b59'
);


-- None Pause del silenzio II

UPDATE pieces piece
SET piece.title = 'Pause del silenzio II', piece.title_en = 'Pause del silenzio II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16301 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Pause del silenzio II: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16301 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d867d13a-98e5-403b-92f1-e395ba345bc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d867d13a-98e5-403b-92f1-e395ba345bc4', 1, 'I', 'Andante', 'Pause del silenzio II: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16301 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d867d13a-98e5-403b-92f1-e395ba345bc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro, ma non troppo mosso', part.name_en = 'Pause del silenzio II: II. Allegro, ma non troppo mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16301 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a395254e-9825-48dd-8d62-d998a22fbb2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a395254e-9825-48dd-8d62-d998a22fbb2f', 2, 'II', 'Allegro, ma non troppo mosso', 'Pause del silenzio II: II. Allegro, ma non troppo mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16301 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a395254e-9825-48dd-8d62-d998a22fbb2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Pause del silenzio II: III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16301 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7f3b51cf-ea7b-4d9e-85df-77714d57deb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f3b51cf-ea7b-4d9e-85df-77714d57deb8', 3, 'III', 'Lento', 'Pause del silenzio II: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16301 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f3b51cf-ea7b-4d9e-85df-77714d57deb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro, ben ritmato', part.name_en = 'Pause del silenzio II: IV. Allegro, ben ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16301 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:875ac162-16f4-4665-8ce6-aa8c31b72786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:875ac162-16f4-4665-8ce6-aa8c31b72786', 4, 'IV', 'Allegro, ben ritmato', 'Pause del silenzio II: IV. Allegro, ben ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16301 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875ac162-16f4-4665-8ce6-aa8c31b72786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Maestoso, non troppo lento', part.name_en = 'Pause del silenzio II: V. Maestoso, non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16301 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:9c606569-a62e-4202-a62d-1e4d60cd7549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c606569-a62e-4202-a62d-1e4d60cd7549', 5, 'V', 'Maestoso, non troppo lento', 'Pause del silenzio II: V. Maestoso, non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16301 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c606569-a62e-4202-a62d-1e4d60cd7549'
);


-- None Per una favola cavalleresca

UPDATE pieces piece
SET piece.title = 'Per una favola cavalleresca', piece.title_en = 'Per una favola cavalleresca',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19432 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Per una favola cavalleresca: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19432 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:fe9e6f2b-65a4-4322-9e24-9f92ceda2a17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe9e6f2b-65a4-4322-9e24-9f92ceda2a17', 1, NULL, 'I', 'Per una favola cavalleresca: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19432 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9e6f2b-65a4-4322-9e24-9f92ceda2a17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Per una favola cavalleresca: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19432 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:df10e64d-a3b0-45a6-bf95-ff84fd536d23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df10e64d-a3b0-45a6-bf95-ff84fd536d23', 2, NULL, 'II', 'Per una favola cavalleresca: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19432 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df10e64d-a3b0-45a6-bf95-ff84fd536d23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Per una favola cavalleresca: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19432 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:99d2d18a-4abc-4922-b78e-b80d83f8067c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99d2d18a-4abc-4922-b78e-b80d83f8067c', 3, NULL, 'III', 'Per una favola cavalleresca: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19432 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d2d18a-4abc-4922-b78e-b80d83f8067c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Per una favola cavalleresca: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19432 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:60351a24-d422-4e65-9334-57e76be8d937' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60351a24-d422-4e65-9334-57e76be8d937', 4, NULL, 'IV', 'Per una favola cavalleresca: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19432 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60351a24-d422-4e65-9334-57e76be8d937'
);


-- None 피아노 협주곡 2번

UPDATE pieces piece
SET piece.title = '피아노 협주곡 2번', piece.title_en = 'Piano Concerto no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17465 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, molto marcato', part.name_en = 'Piano Concerto no. 2: I. Allegro, molto marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17465 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:13411d22-099f-48ec-bad9-ba420c6176aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13411d22-099f-48ec-bad9-ba420c6176aa', 1, 'I', 'Allegro, molto marcato', 'Piano Concerto no. 2: I. Allegro, molto marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17465 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13411d22-099f-48ec-bad9-ba420c6176aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Piano Concerto no. 2: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17465 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:c9399d16-04c8-458d-935a-b404d43e0697' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9399d16-04c8-458d-935a-b404d43e0697', 2, 'II', 'Lento', 'Piano Concerto no. 2: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17465 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9399d16-04c8-458d-935a-b404d43e0697'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 2: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17465 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:63b5f384-e1a6-472c-8283-4b4c4bbde9d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63b5f384-e1a6-472c-8283-4b4c4bbde9d0', 3, 'III', 'Allegro', 'Piano Concerto no. 2: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17465 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63b5f384-e1a6-472c-8283-4b4c4bbde9d0'
);


-- None 피아노 협주곡 5번

UPDATE pieces piece
SET piece.title = '피아노 협주곡 5번', piece.title_en = 'Piano Concerto no. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18845 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 5: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18845 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e66d1132-fe26-45be-b18e-75784b52e4d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e66d1132-fe26-45be-b18e-75784b52e4d2', 1, 'I', 'Allegro', 'Piano Concerto no. 5: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18845 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e66d1132-fe26-45be-b18e-75784b52e4d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Non troppo lento', part.name_en = 'Piano Concerto no. 5: II. Non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18845 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4c8396ff-99ae-4b5b-b54f-e14dce98bd98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8396ff-99ae-4b5b-b54f-e14dce98bd98', 2, 'II', 'Non troppo lento', 'Piano Concerto no. 5: II. Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18845 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8396ff-99ae-4b5b-b54f-e14dce98bd98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 5: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18845 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2dcb611c-9e3e-446d-89a9-20b774c84f49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dcb611c-9e3e-446d-89a9-20b774c84f49', 3, 'III', 'Allegro', 'Piano Concerto no. 5: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18845 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dcb611c-9e3e-446d-89a9-20b774c84f49'
);


-- None 피아노 협주곡 6번 "delle macchine"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 6번 "delle macchine"', piece.title_en = 'Piano Concerto no. 6 "delle macchine"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16356 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 6 "delle macchine": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16356 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5853d90a-2991-4898-b5c6-013810817d94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5853d90a-2991-4898-b5c6-013810817d94', 1, 'I', 'Allegro', 'Piano Concerto no. 6 "delle macchine": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16356 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5853d90a-2991-4898-b5c6-013810817d94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Piano Concerto no. 6 "delle macchine": II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16356 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b3d91cd9-87a8-40ea-9694-aa2301356c57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3d91cd9-87a8-40ea-9694-aa2301356c57', 2, 'II', 'Lento', 'Piano Concerto no. 6 "delle macchine": II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16356 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3d91cd9-87a8-40ea-9694-aa2301356c57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto no. 6 "delle macchine": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16356 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:51c67b43-e447-480e-b399-86dd7d0313e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c67b43-e447-480e-b399-86dd7d0313e9', 3, 'III', 'Allegro', 'Piano Concerto no. 6 "delle macchine": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16356 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c67b43-e447-480e-b399-86dd7d0313e9'
);


-- None Piccola danza

UPDATE pieces piece
SET piece.title = 'Piccola danza', piece.title_en = 'Piccola danza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16556 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Poemetti lunari

UPDATE pieces piece
SET piece.title = 'Poemetti lunari', piece.title_en = 'Poemetti lunari',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17508 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Salmodiando, gravemente', part.name_en = 'Poemetti lunari: I. Salmodiando, gravemente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:abb208e2-df49-4e76-a650-0ade938731d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abb208e2-df49-4e76-a650-0ade938731d8', 1, 'I', 'Salmodiando, gravemente', 'Poemetti lunari: I. Salmodiando, gravemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abb208e2-df49-4e76-a650-0ade938731d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mestamente, ma non lento', part.name_en = 'Poemetti lunari: II. Mestamente, ma non lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:08d7e87d-770c-454d-a66d-93cb3dad5d47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08d7e87d-770c-454d-a66d-93cb3dad5d47', 2, 'II', 'Mestamente, ma non lento', 'Poemetti lunari: II. Mestamente, ma non lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08d7e87d-770c-454d-a66d-93cb3dad5d47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lugubre', part.name_en = 'Poemetti lunari: III. Lugubre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a2fa07ef-d070-474b-8452-c250a7ab8bf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2fa07ef-d070-474b-8452-c250a7ab8bf3', 3, 'III', 'Lugubre', 'Poemetti lunari: III. Lugubre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2fa07ef-d070-474b-8452-c250a7ab8bf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto', part.name_en = 'Poemetti lunari: IV. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:259bf747-bc41-4a22-9905-cfc3fd755efb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:259bf747-bc41-4a22-9905-cfc3fd755efb', 4, 'IV', 'Presto', 'Poemetti lunari: IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259bf747-bc41-4a22-9905-cfc3fd755efb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Mestamente (quasi senza ritmo)', part.name_en = 'Poemetti lunari: V. Mestamente (quasi senza ritmo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8e632809-b732-4d26-9d78-193bdd60e394' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e632809-b732-4d26-9d78-193bdd60e394', 5, 'V', 'Mestamente (quasi senza ritmo)', 'Poemetti lunari: V. Mestamente (quasi senza ritmo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e632809-b732-4d26-9d78-193bdd60e394'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Molto lento – Molto più mosso e marcato – Agitato – Lento assai', part.name_en = 'Poemetti lunari: VI. Molto lento – Molto più mosso e marcato – Agitato – Lento assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:335ab8df-754a-48da-b517-441ba5629e08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:335ab8df-754a-48da-b517-441ba5629e08', 6, 'VI', 'Molto lento – Molto più mosso e marcato – Agitato – Lento assai', 'Poemetti lunari: VI. Molto lento – Molto più mosso e marcato – Agitato – Lento assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:335ab8df-754a-48da-b517-441ba5629e08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Agitatissimo', part.name_en = 'Poemetti lunari: VII. Agitatissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17508 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:9a42cde3-631b-4145-b6e2-709c80f717ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a42cde3-631b-4145-b6e2-709c80f717ac', 7, 'VII', 'Agitatissimo', 'Poemetti lunari: VII. Agitatissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17508 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a42cde3-631b-4145-b6e2-709c80f717ac'
);


-- None Poemi asolani

UPDATE pieces piece
SET piece.title = 'Poemi asolani', piece.title_en = 'Poemi asolani',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18648 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La notte dei morti', part.name_en = 'Poemi asolani: I. La notte dei morti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18648 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:cb5e89f6-bd43-4bb7-9620-080aa62d95a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb5e89f6-bd43-4bb7-9620-080aa62d95a1', 1, 'I', 'La notte dei morti', 'Poemi asolani: I. La notte dei morti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18648 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb5e89f6-bd43-4bb7-9620-080aa62d95a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dittico', part.name_en = 'Poemi asolani: II. Dittico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18648 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:cc6eaafa-31b9-492f-8d8f-dd6459ae30ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc6eaafa-31b9-492f-8d8f-dd6459ae30ec', 2, 'II', 'Dittico', 'Poemi asolani: II. Dittico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18648 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc6eaafa-31b9-492f-8d8f-dd6459ae30ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'I partenti', part.name_en = 'Poemi asolani: III. I partenti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18648 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5150b0f9-6659-4482-8c1b-6b86a18dc0fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5150b0f9-6659-4482-8c1b-6b86a18dc0fc', 3, 'III', 'I partenti', 'Poemi asolani: III. I partenti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18648 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5150b0f9-6659-4482-8c1b-6b86a18dc0fc'
);


-- None Preludi autunnali

UPDATE pieces piece
SET piece.title = 'Preludi autunnali', piece.title_en = 'Preludi autunnali',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16406 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento ma carezzevole', part.name_en = 'Preludi autunnali: I. Lento ma carezzevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16406 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:127e086f-8a04-42bc-b177-7493a3b9fde2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:127e086f-8a04-42bc-b177-7493a3b9fde2', 1, 'I', 'Lento ma carezzevole', 'Preludi autunnali: I. Lento ma carezzevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16406 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:127e086f-8a04-42bc-b177-7493a3b9fde2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ritenuto, ma spigliato', part.name_en = 'Preludi autunnali: II. Ritenuto, ma spigliato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16406 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d210c37d-6320-442d-a489-4706b71756ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d210c37d-6320-442d-a489-4706b71756ad', 2, 'II', 'Ritenuto, ma spigliato', 'Preludi autunnali: II. Ritenuto, ma spigliato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16406 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d210c37d-6320-442d-a489-4706b71756ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento, triste', part.name_en = 'Preludi autunnali: III. Lento, triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16406 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:47ca4559-4cd3-4343-b73a-bdfdd5ee215f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47ca4559-4cd3-4343-b73a-bdfdd5ee215f', 3, 'III', 'Lento, triste', 'Preludi autunnali: III. Lento, triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16406 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ca4559-4cd3-4343-b73a-bdfdd5ee215f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Veloce', part.name_en = 'Preludi autunnali: IV. Veloce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16406 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:ceadd2f6-776a-4190-9113-a89305dfd839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceadd2f6-776a-4190-9113-a89305dfd839', 4, 'IV', 'Veloce', 'Preludi autunnali: IV. Veloce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16406 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceadd2f6-776a-4190-9113-a89305dfd839'
);


-- None Preludio e fuga

UPDATE pieces piece
SET piece.title = 'Preludio e fuga', piece.title_en = 'Preludio e fuga',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19959 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio', part.name_en = 'Preludio e fuga: Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19959 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2bb559ed-5491-48f3-83e4-116917d5df67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bb559ed-5491-48f3-83e4-116917d5df67', 1, NULL, 'Preludio', 'Preludio e fuga: Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19959 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bb559ed-5491-48f3-83e4-116917d5df67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuga a 3', part.name_en = 'Preludio e fuga: Fuga a 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19959 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d9ec85df-f366-4079-b33a-aecf81057c7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9ec85df-f366-4079-b33a-aecf81057c7d', 2, NULL, 'Fuga a 3', 'Preludio e fuga: Fuga a 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19959 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9ec85df-f366-4079-b33a-aecf81057c7d'
);


-- None Preludio per chitarra

UPDATE pieces piece
SET piece.title = 'Preludio per chitarra', piece.title_en = 'Preludio per chitarra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17050 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludio, ritmi e canti gregoriani

UPDATE pieces piece
SET piece.title = 'Preludio, ritmi e canti gregoriani', piece.title_en = 'Preludio, ritmi e canti gregoriani',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19656 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio', part.name_en = 'Preludio, ritmi e canti gregoriani: Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d9a8d92d-8f5c-4d56-8990-48748519cd71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9a8d92d-8f5c-4d56-8990-48748519cd71', 1, NULL, 'Preludio', 'Preludio, ritmi e canti gregoriani: Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a8d92d-8f5c-4d56-8990-48748519cd71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ritmi: I. Allegro molto moderato', part.name_en = 'Preludio, ritmi e canti gregoriani: Ritmi: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:aeb97284-aa16-4d9e-b9fd-5f082abdd2a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeb97284-aa16-4d9e-b9fd-5f082abdd2a4', 2, NULL, 'Ritmi: I. Allegro molto moderato', 'Preludio, ritmi e canti gregoriani: Ritmi: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeb97284-aa16-4d9e-b9fd-5f082abdd2a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ritmi: II. Allegretto', part.name_en = 'Preludio, ritmi e canti gregoriani: Ritmi: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2e4d4f67-479e-479c-a5eb-7a3de40eadec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e4d4f67-479e-479c-a5eb-7a3de40eadec', 3, NULL, 'Ritmi: II. Allegretto', 'Preludio, ritmi e canti gregoriani: Ritmi: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e4d4f67-479e-479c-a5eb-7a3de40eadec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Canti gregoriani: I. Lento', part.name_en = 'Preludio, ritmi e canti gregoriani: Canti gregoriani: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:131f6409-2973-4a0f-a395-638547fd2e62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:131f6409-2973-4a0f-a395-638547fd2e62', 4, NULL, 'Canti gregoriani: I. Lento', 'Preludio, ritmi e canti gregoriani: Canti gregoriani: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131f6409-2973-4a0f-a395-638547fd2e62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Canti gregoriani: II. Allegro moderato', part.name_en = 'Preludio, ritmi e canti gregoriani: Canti gregoriani: II. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:57b07905-e16e-45e3-8552-4db4cb271a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57b07905-e16e-45e3-8552-4db4cb271a61', 5, NULL, 'Canti gregoriani: II. Allegro moderato', 'Preludio, ritmi e canti gregoriani: Canti gregoriani: II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57b07905-e16e-45e3-8552-4db4cb271a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Canti gregoriani: III. Andante', part.name_en = 'Preludio, ritmi e canti gregoriani: Canti gregoriani: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e1d534b0-5a95-451a-9f07-bbc32b582aa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1d534b0-5a95-451a-9f07-bbc32b582aa7', 6, NULL, 'Canti gregoriani: III. Andante', 'Preludio, ritmi e canti gregoriani: Canti gregoriani: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d534b0-5a95-451a-9f07-bbc32b582aa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Canti gregoriani: IV. Eroico', part.name_en = 'Preludio, ritmi e canti gregoriani: Canti gregoriani: IV. Eroico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19656 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:68bb7b75-c3b1-4905-aeae-3a0b3ca2dd37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68bb7b75-c3b1-4905-aeae-3a0b3ca2dd37', 7, NULL, 'Canti gregoriani: IV. Eroico', 'Preludio, ritmi e canti gregoriani: Canti gregoriani: IV. Eroico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19656 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68bb7b75-c3b1-4905-aeae-3a0b3ca2dd37'
);


-- None Quattro invenzioni

UPDATE pieces piece
SET piece.title = 'Quattro invenzioni', piece.title_en = 'Quattro invenzioni',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16894 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Invenzione 1. Allegro grazioso - Leggero', part.name_en = 'Quattro invenzioni: Invenzione 1. Allegro grazioso - Leggero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16894 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e540e71b-7984-4587-ac67-2a1b72a68b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e540e71b-7984-4587-ac67-2a1b72a68b7f', 1, NULL, 'Invenzione 1. Allegro grazioso - Leggero', 'Quattro invenzioni: Invenzione 1. Allegro grazioso - Leggero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16894 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e540e71b-7984-4587-ac67-2a1b72a68b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Invenzione 2. Allegro - Grazioso', part.name_en = 'Quattro invenzioni: Invenzione 2. Allegro - Grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16894 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:241e4756-3b89-4d0a-a0fa-8e1d53c25677' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:241e4756-3b89-4d0a-a0fa-8e1d53c25677', 2, NULL, 'Invenzione 2. Allegro - Grazioso', 'Quattro invenzioni: Invenzione 2. Allegro - Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16894 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:241e4756-3b89-4d0a-a0fa-8e1d53c25677'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Invenzione 3. Andante - In due', part.name_en = 'Quattro invenzioni: Invenzione 3. Andante - In due',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16894 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a800b7cb-54a3-4e1c-8eb1-adb0387fdc96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a800b7cb-54a3-4e1c-8eb1-adb0387fdc96', 3, NULL, 'Invenzione 3. Andante - In due', 'Quattro invenzioni: Invenzione 3. Andante - In due', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16894 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a800b7cb-54a3-4e1c-8eb1-adb0387fdc96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Invenzione 4. Allegro - Festoso', part.name_en = 'Quattro invenzioni: Invenzione 4. Allegro - Festoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16894 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e8b79d0f-6fd6-42a4-b21c-69278cc3232b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8b79d0f-6fd6-42a4-b21c-69278cc3232b', 4, NULL, 'Invenzione 4. Allegro - Festoso', 'Quattro invenzioni: Invenzione 4. Allegro - Festoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16894 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b79d0f-6fd6-42a4-b21c-69278cc3232b'
);


-- None Quattro sonetti del Burchiello

UPDATE pieces piece
SET piece.title = 'Quattro sonetti del Burchiello', piece.title_en = 'Quattro sonetti del Burchiello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18634 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cacio stillato', part.name_en = 'Quattro sonetti del Burchiello: Cacio stillato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18634 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:09d7b49f-e577-44b6-8d53-25ddc01ece24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09d7b49f-e577-44b6-8d53-25ddc01ece24', 1, NULL, 'Cacio stillato', 'Quattro sonetti del Burchiello: Cacio stillato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18634 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09d7b49f-e577-44b6-8d53-25ddc01ece24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rose spinose', part.name_en = 'Quattro sonetti del Burchiello: Rose spinose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18634 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:3d4c9af5-9a89-42be-8f16-8e9ec5fdb3c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d4c9af5-9a89-42be-8f16-8e9ec5fdb3c6', 2, NULL, 'Rose spinose', 'Quattro sonetti del Burchiello: Rose spinose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18634 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d4c9af5-9a89-42be-8f16-8e9ec5fdb3c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andando a uccellare', part.name_en = 'Quattro sonetti del Burchiello: Andando a uccellare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18634 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a7df3795-d296-41c3-a136-26bbce3b6592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7df3795-d296-41c3-a136-26bbce3b6592', 3, NULL, 'Andando a uccellare', 'Quattro sonetti del Burchiello: Andando a uccellare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18634 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7df3795-d296-41c3-a136-26bbce3b6592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Va’ in mercato, Giorgin', part.name_en = 'Quattro sonetti del Burchiello: Va’ in mercato, Giorgin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18634 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f49822bd-4c9e-4a82-884c-c271df61ed97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49822bd-4c9e-4a82-884c-c271df61ed97', 4, NULL, 'Va’ in mercato, Giorgin', 'Quattro sonetti del Burchiello: Va’ in mercato, Giorgin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18634 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49822bd-4c9e-4a82-884c-c271df61ed97'
);


-- None Risonanze

UPDATE pieces piece
SET piece.title = 'Risonanze', piece.title_en = 'Risonanze',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19057 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Calmo', part.name_en = 'Risonanze: I. Calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19057 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:bdb194c3-a19b-472c-84fe-1f8ac2c23a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdb194c3-a19b-472c-84fe-1f8ac2c23a29', 1, 'I', 'Calmo', 'Risonanze: I. Calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19057 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdb194c3-a19b-472c-84fe-1f8ac2c23a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fluido', part.name_en = 'Risonanze: II. Fluido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19057 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:02eae3b8-4ca9-444b-9c6b-cf37fff2714b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02eae3b8-4ca9-444b-9c6b-cf37fff2714b', 2, 'II', 'Fluido', 'Risonanze: II. Fluido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19057 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02eae3b8-4ca9-444b-9c6b-cf37fff2714b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Non troppo mosso', part.name_en = 'Risonanze: III. Non troppo mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19057 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b24421a8-39cc-4480-a960-0df86cb29db7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b24421a8-39cc-4480-a960-0df86cb29db7', 3, 'III', 'Non troppo mosso', 'Risonanze: III. Non troppo mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19057 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24421a8-39cc-4480-a960-0df86cb29db7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Agitato, non troppo', part.name_en = 'Risonanze: IV. Agitato, non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19057 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e32f418e-cd49-4757-9878-15ef4c7cc744' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e32f418e-cd49-4757-9878-15ef4c7cc744', 4, 'IV', 'Agitato, non troppo', 'Risonanze: IV. Agitato, non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19057 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e32f418e-cd49-4757-9878-15ef4c7cc744'
);


-- None Sette canzonette veneziane

UPDATE pieces piece
SET piece.title = 'Sette canzonette veneziane', piece.title_en = 'Sette canzonette veneziane',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19278 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Soto quel sotoportego, Marieta', part.name_en = 'Sette canzonette veneziane: Soto quel sotoportego, Marieta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2b9e40f6-6753-4d38-a1a4-03b97335e655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b9e40f6-6753-4d38-a1a4-03b97335e655', 1, NULL, 'Soto quel sotoportego, Marieta', 'Sette canzonette veneziane: Soto quel sotoportego, Marieta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b9e40f6-6753-4d38-a1a4-03b97335e655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Roma xe granda, e xe Venezia bela', part.name_en = 'Sette canzonette veneziane: Roma xe granda, e xe Venezia bela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:3399c2ec-67b4-4f4e-87a1-34ee09603692' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3399c2ec-67b4-4f4e-87a1-34ee09603692', 2, NULL, 'Roma xe granda, e xe Venezia bela', 'Sette canzonette veneziane: Roma xe granda, e xe Venezia bela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3399c2ec-67b4-4f4e-87a1-34ee09603692'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Voi sul ponte dei pugni darghe un pugno', part.name_en = 'Sette canzonette veneziane: Voi sul ponte dei pugni darghe un pugno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:62e885dc-0943-4182-a7ba-b51e5adbcab6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e885dc-0943-4182-a7ba-b51e5adbcab6', 3, NULL, 'Voi sul ponte dei pugni darghe un pugno', 'Sette canzonette veneziane: Voi sul ponte dei pugni darghe un pugno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e885dc-0943-4182-a7ba-b51e5adbcab6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fa nana fantolin de la Madona', part.name_en = 'Sette canzonette veneziane: Fa nana fantolin de la Madona',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:958a8182-7f04-4178-b629-3ee0d7cbe632' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:958a8182-7f04-4178-b629-3ee0d7cbe632', 4, NULL, 'Fa nana fantolin de la Madona', 'Sette canzonette veneziane: Fa nana fantolin de la Madona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:958a8182-7f04-4178-b629-3ee0d7cbe632'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Come I Zingari son tre dì per liogo', part.name_en = 'Sette canzonette veneziane: Come I Zingari son tre dì per liogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:bf0b4236-307b-4b35-be8e-0b7a128ee723' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0b4236-307b-4b35-be8e-0b7a128ee723', 5, NULL, 'Come I Zingari son tre dì per liogo', 'Sette canzonette veneziane: Come I Zingari son tre dì per liogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0b4236-307b-4b35-be8e-0b7a128ee723'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Povero Bernardon tuto impiagao', part.name_en = 'Sette canzonette veneziane: Povero Bernardon tuto impiagao',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:dcacc126-166f-4583-965c-c8ddd65590cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcacc126-166f-4583-965c-c8ddd65590cf', 6, NULL, 'Povero Bernardon tuto impiagao', 'Sette canzonette veneziane: Povero Bernardon tuto impiagao', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcacc126-166f-4583-965c-c8ddd65590cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Cara, ti ti xe proprio una bissona', part.name_en = 'Sette canzonette veneziane: Cara, ti ti xe proprio una bissona',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19278 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:def73196-f705-4b2f-8447-2c81372b58d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:def73196-f705-4b2f-8447-2c81372b58d1', 7, NULL, 'Cara, ti ti xe proprio una bissona', 'Sette canzonette veneziane: Cara, ti ti xe proprio una bissona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19278 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:def73196-f705-4b2f-8447-2c81372b58d1'
);


-- None Sette invenzioni

UPDATE pieces piece
SET piece.title = 'Sette invenzioni', piece.title_en = 'Sette invenzioni',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16352 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Invenzione 1. Non troppo mosso', part.name_en = 'Sette invenzioni: Invenzione 1. Non troppo mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:1a5bb6aa-d918-48f0-a5f2-dceebff46753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a5bb6aa-d918-48f0-a5f2-dceebff46753', 1, NULL, 'Invenzione 1. Non troppo mosso', 'Sette invenzioni: Invenzione 1. Non troppo mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a5bb6aa-d918-48f0-a5f2-dceebff46753'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Invenzione 2. Mosso', part.name_en = 'Sette invenzioni: Invenzione 2. Mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:0bbf3e57-80db-4e86-9766-9f07a8b5d01a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bbf3e57-80db-4e86-9766-9f07a8b5d01a', 2, NULL, 'Invenzione 2. Mosso', 'Sette invenzioni: Invenzione 2. Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bbf3e57-80db-4e86-9766-9f07a8b5d01a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Invenzione 3. Non mosso ma allegro', part.name_en = 'Sette invenzioni: Invenzione 3. Non mosso ma allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:de519d20-257b-4169-88a9-35e80f13aba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de519d20-257b-4169-88a9-35e80f13aba0', 3, NULL, 'Invenzione 3. Non mosso ma allegro', 'Sette invenzioni: Invenzione 3. Non mosso ma allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de519d20-257b-4169-88a9-35e80f13aba0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Invenzione 4. Lento ma non troppo', part.name_en = 'Sette invenzioni: Invenzione 4. Lento ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:22b9c033-eca3-4fdf-9d6f-631e730eccec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22b9c033-eca3-4fdf-9d6f-631e730eccec', 4, NULL, 'Invenzione 4. Lento ma non troppo', 'Sette invenzioni: Invenzione 4. Lento ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b9c033-eca3-4fdf-9d6f-631e730eccec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Invenzione 5. Allegro agitato', part.name_en = 'Sette invenzioni: Invenzione 5. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8e3202a0-f1e6-47ce-bc26-500579241153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e3202a0-f1e6-47ce-bc26-500579241153', 5, NULL, 'Invenzione 5. Allegro agitato', 'Sette invenzioni: Invenzione 5. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e3202a0-f1e6-47ce-bc26-500579241153'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Invenzione 6. Lento non troppo', part.name_en = 'Sette invenzioni: Invenzione 6. Lento non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:912ef856-9672-4bc6-9848-9c4f0478d8c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912ef856-9672-4bc6-9848-9c4f0478d8c0', 6, NULL, 'Invenzione 6. Lento non troppo', 'Sette invenzioni: Invenzione 6. Lento non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912ef856-9672-4bc6-9848-9c4f0478d8c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Invenzione 7. Allegro', part.name_en = 'Sette invenzioni: Invenzione 7. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16352 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f479edcc-1895-4832-8ea0-fe7ed32d49fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f479edcc-1895-4832-8ea0-fe7ed32d49fb', 7, NULL, 'Invenzione 7. Allegro', 'Sette invenzioni: Invenzione 7. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16352 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f479edcc-1895-4832-8ea0-fe7ed32d49fb'
);


-- None Sinfonia dello Zodiaco

UPDATE pieces piece
SET piece.title = 'Sinfonia dello Zodiaco', piece.title_en = 'Sinfonia dello Zodiaco',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17069 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Partita I "Spring": Andante', part.name_en = 'Sinfonia dello Zodiaco: Partita I "Spring": Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4142e0c1-4767-432d-a404-ea4a9e3cfcd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4142e0c1-4767-432d-a404-ea4a9e3cfcd3', 1, NULL, 'Partita I "Spring": Andante', 'Sinfonia dello Zodiaco: Partita I "Spring": Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4142e0c1-4767-432d-a404-ea4a9e3cfcd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Partita I "Spring": Mosso', part.name_en = 'Sinfonia dello Zodiaco: Partita I "Spring": Mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d705a22d-8068-437c-a1d7-b481a1a163f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d705a22d-8068-437c-a1d7-b481a1a163f0', 2, NULL, 'Partita I "Spring": Mosso', 'Sinfonia dello Zodiaco: Partita I "Spring": Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d705a22d-8068-437c-a1d7-b481a1a163f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Partita I "Spring": Allegro - Molto tranquillo', part.name_en = 'Sinfonia dello Zodiaco: Partita I "Spring": Allegro - Molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4b52a9bf-d293-4514-8bfe-b140cfe9c472' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b52a9bf-d293-4514-8bfe-b140cfe9c472', 3, NULL, 'Partita I "Spring": Allegro - Molto tranquillo', 'Sinfonia dello Zodiaco: Partita I "Spring": Allegro - Molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b52a9bf-d293-4514-8bfe-b140cfe9c472'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Partita II "Summer": Allegro', part.name_en = 'Sinfonia dello Zodiaco, Partita II "Summer": Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:dccc2da3-3e38-4bbb-9284-79eea74cdf28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dccc2da3-3e38-4bbb-9284-79eea74cdf28', 4, NULL, 'Partita II "Summer": Allegro', 'Sinfonia dello Zodiaco, Partita II "Summer": Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dccc2da3-3e38-4bbb-9284-79eea74cdf28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Partita II "Summer": Piuttosto lento', part.name_en = 'Sinfonia dello Zodiaco, Partita II "Summer": Piuttosto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e15bd00a-8d47-40e0-8eb5-cbcc3dd7166d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e15bd00a-8d47-40e0-8eb5-cbcc3dd7166d', 5, NULL, 'Partita II "Summer": Piuttosto lento', 'Sinfonia dello Zodiaco, Partita II "Summer": Piuttosto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e15bd00a-8d47-40e0-8eb5-cbcc3dd7166d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Partita II "Summer": Allegro, molto marcato', part.name_en = 'Sinfonia dello Zodiaco, Partita II "Summer": Allegro, molto marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:30942c52-1817-4b52-b49d-98b483b29fde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30942c52-1817-4b52-b49d-98b483b29fde', 6, NULL, 'Partita II "Summer": Allegro, molto marcato', 'Sinfonia dello Zodiaco, Partita II "Summer": Allegro, molto marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30942c52-1817-4b52-b49d-98b483b29fde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Partita III "Autumn": Piuttosto lento', part.name_en = 'Sinfonia dello Zodiaco, Partita III "Autumn": Piuttosto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e75a57e7-e3f7-4c4a-a742-e413de904f5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75a57e7-e3f7-4c4a-a742-e413de904f5b', 7, NULL, 'Partita III "Autumn": Piuttosto lento', 'Sinfonia dello Zodiaco, Partita III "Autumn": Piuttosto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75a57e7-e3f7-4c4a-a742-e413de904f5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Partita III "Autumn": Allegro grazioso', part.name_en = 'Sinfonia dello Zodiaco, Partita III "Autumn": Allegro grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a6d525f5-9fcf-4d07-a3cf-635b7b5240dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6d525f5-9fcf-4d07-a3cf-635b7b5240dd', 8, NULL, 'Partita III "Autumn": Allegro grazioso', 'Sinfonia dello Zodiaco, Partita III "Autumn": Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6d525f5-9fcf-4d07-a3cf-635b7b5240dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Partita III "Autumn": Lento', part.name_en = 'Sinfonia dello Zodiaco, Partita III "Autumn": Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d9bd3c24-77ad-4823-bd92-138c3da9d157' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9bd3c24-77ad-4823-bd92-138c3da9d157', 9, NULL, 'Partita III "Autumn": Lento', 'Sinfonia dello Zodiaco, Partita III "Autumn": Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9bd3c24-77ad-4823-bd92-138c3da9d157'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Partita IV "Winter": Leggermente mosso - Più lento un poco - Allegro molto moderato', part.name_en = 'Sinfonia dello Zodiaco, Partita IV "Winter": Leggermente mosso - Più lento un poco - Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:745eb9c0-7465-49e9-8ab2-6abe132cbafc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745eb9c0-7465-49e9-8ab2-6abe132cbafc', 10, NULL, 'Partita IV "Winter": Leggermente mosso - Più lento un poco - Allegro molto moderato', 'Sinfonia dello Zodiaco, Partita IV "Winter": Leggermente mosso - Più lento un poco - Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745eb9c0-7465-49e9-8ab2-6abe132cbafc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Partita IV "Winter": Andante (pastorale)', part.name_en = 'Sinfonia dello Zodiaco, Partita IV "Winter": Andante (pastorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:cbed9f17-ce7e-4787-8039-a319e84f75fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbed9f17-ce7e-4787-8039-a319e84f75fa', 11, NULL, 'Partita IV "Winter": Andante (pastorale)', 'Sinfonia dello Zodiaco, Partita IV "Winter": Andante (pastorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbed9f17-ce7e-4787-8039-a319e84f75fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Partita IV "Winter": Ritenuto - Tranquillo - Allegro', part.name_en = 'Sinfonia dello Zodiaco, Partita IV "Winter": Ritenuto - Tranquillo - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17069 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:954215bb-3972-4eda-9089-a45120cd632f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:954215bb-3972-4eda-9089-a45120cd632f', 12, NULL, 'Partita IV "Winter": Ritenuto - Tranquillo - Allegro', 'Sinfonia dello Zodiaco, Partita IV "Winter": Ritenuto - Tranquillo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17069 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:954215bb-3972-4eda-9089-a45120cd632f'
);


-- None Sinfonia in un tempo

UPDATE pieces piece
SET piece.title = 'Sinfonia in un tempo', piece.title_en = 'Sinfonia in un tempo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19133 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonia per Antigenida

UPDATE pieces piece
SET piece.title = 'Sinfonia per Antigenida', piece.title_en = 'Sinfonia per Antigenida',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16327 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ritenuto', part.name_en = 'Sinfonia per Antigenida: I. Ritenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16327 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:6f24b38e-04f6-4a5d-8860-0b47a28fb945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f24b38e-04f6-4a5d-8860-0b47a28fb945', 1, 'I', 'Ritenuto', 'Sinfonia per Antigenida: I. Ritenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16327 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f24b38e-04f6-4a5d-8860-0b47a28fb945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Sinfonia per Antigenida: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16327 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4983d020-2666-4ef1-8a43-51da9aea8ab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4983d020-2666-4ef1-8a43-51da9aea8ab4', 2, 'II', 'Lento', 'Sinfonia per Antigenida: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16327 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4983d020-2666-4ef1-8a43-51da9aea8ab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonia per Antigenida: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16327 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f7ae1107-be71-46d0-827c-70b5aabbf6f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7ae1107-be71-46d0-827c-70b5aabbf6f3', 3, 'III', 'Allegro', 'Sinfonia per Antigenida: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16327 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7ae1107-be71-46d0-827c-70b5aabbf6f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Sinfonia per Antigenida: IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16327 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d84b5103-5e55-48cc-a428-4bfe4eb1bc1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d84b5103-5e55-48cc-a428-4bfe4eb1bc1a', 4, 'IV', 'Lento', 'Sinfonia per Antigenida: IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16327 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d84b5103-5e55-48cc-a428-4bfe4eb1bc1a'
);


-- None Sinfonie del silenzio e de la morte

UPDATE pieces piece
SET piece.title = 'Sinfonie del silenzio e de la morte', piece.title_en = 'Sinfonie del silenzio e de la morte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16957 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Danza tragica', part.name_en = 'Sinfonie del silenzio e de la morte: I. Danza tragica',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16957 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:877c0659-0b81-4560-b53c-32741c0af6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:877c0659-0b81-4560-b53c-32741c0af6a2', 1, 'I', 'Danza tragica', 'Sinfonie del silenzio e de la morte: I. Danza tragica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16957 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:877c0659-0b81-4560-b53c-32741c0af6a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sinfonia del silenzio', part.name_en = 'Sinfonie del silenzio e de la morte: II. Sinfonia del silenzio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16957 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:521759ed-f1b7-490c-94ab-5891bfbb0a5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:521759ed-f1b7-490c-94ab-5891bfbb0a5e', 2, 'II', 'Sinfonia del silenzio', 'Sinfonie del silenzio e de la morte: II. Sinfonia del silenzio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16957 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521759ed-f1b7-490c-94ab-5891bfbb0a5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Il molino della morte', part.name_en = 'Sinfonie del silenzio e de la morte: III. Il molino della morte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16957 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2100a024-bf48-45ea-8fdc-12f71a46d353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2100a024-bf48-45ea-8fdc-12f71a46d353', 3, 'III', 'Il molino della morte', 'Sinfonie del silenzio e de la morte: III. Il molino della morte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16957 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2100a024-bf48-45ea-8fdc-12f71a46d353'
);


-- None 현악 4중주 1번 "Rispetti e strambotti"

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 "Rispetti e strambotti"', piece.title_en = 'String Quartet no. 1 "Rispetti e strambotti"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16086 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 2번 "Stornelli e ballate"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 "Stornelli e ballate"', piece.title_en = 'String Quartet no. 2 "Stornelli e ballate"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16056 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 3번 "Cantari alla madrigalesca"

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 "Cantari alla madrigalesca"', piece.title_en = 'String Quartet no. 3 "Cantari alla madrigalesca"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17283 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 5번 "dei Capricci"

UPDATE pieces piece
SET piece.title = '현악 4중주 5번 "dei Capricci"', piece.title_en = 'String Quartet no. 5 "dei Capricci"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17409 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 6번 "arca di Noè"

UPDATE pieces piece
SET piece.title = '현악 4중주 6번 "arca di Noè"', piece.title_en = 'String Quartet no. 6 "l''arca di Noè"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19891 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 7번

UPDATE pieces piece
SET piece.title = '현악 4중주 7번', piece.title_en = 'String Quartet no. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19719 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 8번 "per Elizabetta"

UPDATE pieces piece
SET piece.title = '현악 4중주 8번 "per Elizabetta"', piece.title_en = 'String Quartet no. 8 "per Elizabetta"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17130 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphonic Fragments from the Opera "Il finto Arlecchino"

UPDATE pieces piece
SET piece.title = 'Symphonic Fragments from the Opera "Il finto Arlecchino"', piece.title_en = 'Symphonic Fragments from the Opera "Il finto Arlecchino"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19975 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphonic Fragments from the Opera "Il finto Arlecchino": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19975 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:fe4977f1-0a72-47b7-aa0e-b441ae5b0218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4977f1-0a72-47b7-aa0e-b441ae5b0218', 1, 'I', 'Allegro', 'Symphonic Fragments from the Opera "Il finto Arlecchino": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19975 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4977f1-0a72-47b7-aa0e-b441ae5b0218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Symphonic Fragments from the Opera "Il finto Arlecchino": II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19975 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8e78adf7-cf08-4233-93ff-99fd38e124b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e78adf7-cf08-4233-93ff-99fd38e124b7', 2, 'II', 'Largo', 'Symphonic Fragments from the Opera "Il finto Arlecchino": II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19975 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e78adf7-cf08-4233-93ff-99fd38e124b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro gaio assai', part.name_en = 'Symphonic Fragments from the Opera "Il finto Arlecchino": III. Allegro gaio assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19975 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:28d4a9fa-a430-4285-b327-7e86374a103c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28d4a9fa-a430-4285-b327-7e86374a103c', 3, 'III', 'Allegro gaio assai', 'Symphonic Fragments from the Opera "Il finto Arlecchino": III. Allegro gaio assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19975 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28d4a9fa-a430-4285-b327-7e86374a103c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante non ritenuto', part.name_en = 'Symphonic Fragments from the Opera "Il finto Arlecchino": IV. Andante non ritenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19975 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5be28ffa-27ee-474d-9f7d-ee8732075841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5be28ffa-27ee-474d-9f7d-ee8732075841', 4, 'IV', 'Andante non ritenuto', 'Symphonic Fragments from the Opera "Il finto Arlecchino": IV. Andante non ritenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19975 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5be28ffa-27ee-474d-9f7d-ee8732075841'
);


-- None 교향곡 1번 "In quattro tempi, come le quattro stagioni"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "In quattro tempi, come le quattro stagioni"', piece.title_en = 'Symphony no. 1 "In quattro tempi, come le quattro stagioni"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16946 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Quasi andante. Sereno', part.name_en = 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": I. Quasi andante. Sereno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16946 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e17f9429-3690-4538-9687-4343bad662e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e17f9429-3690-4538-9687-4343bad662e4', 1, 'I', 'Quasi andante. Sereno', 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": I. Quasi andante. Sereno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16946 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e17f9429-3690-4538-9687-4343bad662e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16946 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5f64c046-eb19-4542-a413-866e5ac943b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f64c046-eb19-4542-a413-866e5ac943b6', 2, 'II', 'Allegro', 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16946 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f64c046-eb19-4542-a413-866e5ac943b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": III. Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16946 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:8143f5f3-331b-4b3d-b0da-d9c0f086d66f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8143f5f3-331b-4b3d-b0da-d9c0f086d66f', 3, 'III', 'Lento, ma non troppo', 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": III. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16946 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8143f5f3-331b-4b3d-b0da-d9c0f086d66f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro, quasi allegretto', part.name_en = 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": IV. Allegro, quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16946 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f91fed31-7bba-484a-8966-f5f0548010b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f91fed31-7bba-484a-8966-f5f0548010b0', 4, 'IV', 'Allegro, quasi allegretto', 'Symphony no. 1 "In quattro tempi, come le quattro stagioni": IV. Allegro, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16946 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f91fed31-7bba-484a-8966-f5f0548010b0'
);


-- None 교향곡 10번 "Atropo"

UPDATE pieces piece
SET piece.title = '교향곡 10번 "Atropo"', piece.title_en = 'Symphony no. 10 "Atropo"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18107 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lento - Andante', part.name_en = 'Symphony no. 10 "Atropo": Lento - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18107 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:37bd37e2-7edf-40de-81a2-79c31a2a97c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37bd37e2-7edf-40de-81a2-79c31a2a97c0', 1, NULL, 'Lento - Andante', 'Symphony no. 10 "Atropo": Lento - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18107 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37bd37e2-7edf-40de-81a2-79c31a2a97c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Symphony no. 10 "Atropo": Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18107 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:fc0b10dd-5cb7-4a19-9550-6a16e535a150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc0b10dd-5cb7-4a19-9550-6a16e535a150', 2, NULL, 'Tranquillo', 'Symphony no. 10 "Atropo": Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18107 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc0b10dd-5cb7-4a19-9550-6a16e535a150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mosso', part.name_en = 'Symphony no. 10 "Atropo": Mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18107 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e2cd1cba-1611-4f2f-857f-d91b4bc42e48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2cd1cba-1611-4f2f-857f-d91b4bc42e48', 3, NULL, 'Mosso', 'Symphony no. 10 "Atropo": Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18107 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2cd1cba-1611-4f2f-857f-d91b4bc42e48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mosso, molto vivace - Un poco piu lento', part.name_en = 'Symphony no. 10 "Atropo": Mosso, molto vivace - Un poco piu lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18107 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d70fb8d6-f118-452e-a925-ad52ba647f04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d70fb8d6-f118-452e-a925-ad52ba647f04', 4, NULL, 'Mosso, molto vivace - Un poco piu lento', 'Symphony no. 10 "Atropo": Mosso, molto vivace - Un poco piu lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18107 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d70fb8d6-f118-452e-a925-ad52ba647f04'
);


-- None 교향곡 2번 "Elegiaca"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "Elegiaca"', piece.title_en = 'Symphony no. 2 "Elegiaca"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15998 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Symphony no. 2 "Elegiaca": I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15998 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7233de6e-816f-4e4c-91d1-6645e147da6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7233de6e-816f-4e4c-91d1-6645e147da6d', 1, 'I', 'Allegro non troppo', 'Symphony no. 2 "Elegiaca": I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15998 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7233de6e-816f-4e4c-91d1-6645e147da6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento non troppo', part.name_en = 'Symphony no. 2 "Elegiaca": II. Lento non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15998 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:62748b5f-13bf-42bf-ab65-1657967dd5e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62748b5f-13bf-42bf-ab65-1657967dd5e8', 2, 'II', 'Lento non troppo', 'Symphony no. 2 "Elegiaca": II. Lento non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15998 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62748b5f-13bf-42bf-ab65-1657967dd5e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mosso', part.name_en = 'Symphony no. 2 "Elegiaca": III. Mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15998 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4cab736c-76f5-4181-84be-3bbb22cad5f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cab736c-76f5-4181-84be-3bbb22cad5f5', 3, 'III', 'Mosso', 'Symphony no. 2 "Elegiaca": III. Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15998 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cab736c-76f5-4181-84be-3bbb22cad5f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 2 "Elegiaca": IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15998 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:70947215-982c-4888-951b-ad9cc38b3ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70947215-982c-4888-951b-ad9cc38b3ba5', 4, 'IV', 'Lento', 'Symphony no. 2 "Elegiaca": IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15998 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70947215-982c-4888-951b-ad9cc38b3ba5'
);


-- None 교향곡 3번 "delle campane"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "delle campane"', piece.title_en = 'Symphony no. 3 "delle campane"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17556 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Symphony no. 3 "delle campane": I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17556 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:634b2a94-1ea1-4da3-9038-df4596f10f12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:634b2a94-1ea1-4da3-9038-df4596f10f12', 1, 'I', 'Allegro moderato', 'Symphony no. 3 "delle campane": I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17556 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:634b2a94-1ea1-4da3-9038-df4596f10f12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto moderato', part.name_en = 'Symphony no. 3 "delle campane": II. Andante molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17556 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:52c6ebcd-a66e-4557-980e-49eeae6f15df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c6ebcd-a66e-4557-980e-49eeae6f15df', 2, 'II', 'Andante molto moderato', 'Symphony no. 3 "delle campane": II. Andante molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17556 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c6ebcd-a66e-4557-980e-49eeae6f15df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Symphony no. 3 "delle campane": III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17556 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:90118b68-2b90-4da9-a4ea-91271c350739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90118b68-2b90-4da9-a4ea-91271c350739', 3, 'III', 'Vivace', 'Symphony no. 3 "delle campane": III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17556 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90118b68-2b90-4da9-a4ea-91271c350739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 3 "delle campane": IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17556 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:46fe64a3-b177-49b3-b869-3d1543e87e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46fe64a3-b177-49b3-b869-3d1543e87e59', 4, 'IV', 'Lento', 'Symphony no. 3 "delle campane": IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17556 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46fe64a3-b177-49b3-b869-3d1543e87e59'
);


-- None 교향곡 4번 "in memoriam"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "in memoriam"', piece.title_en = 'Symphony no. 4 "in memoriam"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20077 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Symphony no. 4 "in memoriam": I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20077 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:864c9df6-88f0-46df-8fb6-f20b8e4592ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:864c9df6-88f0-46df-8fb6-f20b8e4592ed', 1, 'I', 'Allegro moderato', 'Symphony no. 4 "in memoriam": I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20077 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:864c9df6-88f0-46df-8fb6-f20b8e4592ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento funebre', part.name_en = 'Symphony no. 4 "in memoriam": II. Lento funebre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20077 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2242a963-b441-472b-ab45-49fd4eb0f269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2242a963-b441-472b-ab45-49fd4eb0f269', 2, 'II', 'Lento funebre', 'Symphony no. 4 "in memoriam": II. Lento funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20077 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2242a963-b441-472b-ab45-49fd4eb0f269'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 4 "in memoriam": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20077 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:cf39bd8b-cb76-4e44-87ed-a412f7e59eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf39bd8b-cb76-4e44-87ed-a412f7e59eeb', 3, 'III', 'Allegro', 'Symphony no. 4 "in memoriam": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20077 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf39bd8b-cb76-4e44-87ed-a412f7e59eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 4 "in memoriam": IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20077 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:6864bf90-bdcd-4d31-aad3-bd8ce6cf10a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6864bf90-bdcd-4d31-aad3-bd8ce6cf10a5', 4, 'IV', 'Lento', 'Symphony no. 4 "in memoriam": IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20077 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6864bf90-bdcd-4d31-aad3-bd8ce6cf10a5'
);


-- None 교향곡 7번 "delle canzoni"

UPDATE pieces piece
SET piece.title = '교향곡 7번 "delle canzoni"', piece.title_en = 'Symphony no. 7 "delle canzoni"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16582 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 7 "delle canzoni": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16582 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2fdf621a-e4e0-4be9-89d6-afa619ff8820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fdf621a-e4e0-4be9-89d6-afa619ff8820', 1, 'I', 'Allegro', 'Symphony no. 7 "delle canzoni": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16582 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fdf621a-e4e0-4be9-89d6-afa619ff8820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento quasi andante', part.name_en = 'Symphony no. 7 "delle canzoni": II. Lento quasi andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16582 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:60455f1c-b3ed-47bd-9825-f460e9ec05a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60455f1c-b3ed-47bd-9825-f460e9ec05a1', 2, 'II', 'Lento quasi andante', 'Symphony no. 7 "delle canzoni": II. Lento quasi andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16582 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60455f1c-b3ed-47bd-9825-f460e9ec05a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro impetuoso', part.name_en = 'Symphony no. 7 "delle canzoni": III. Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16582 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a122ad1b-7ad0-4436-ada1-ee1c21734aa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a122ad1b-7ad0-4436-ada1-ee1c21734aa6', 3, 'III', 'Allegro impetuoso', 'Symphony no. 7 "delle canzoni": III. Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16582 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a122ad1b-7ad0-4436-ada1-ee1c21734aa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento', part.name_en = 'Symphony no. 7 "delle canzoni": IV. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16582 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:4f5ce9f3-f44e-4dd8-af33-5040c15f51dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f5ce9f3-f44e-4dd8-af33-5040c15f51dd', 4, 'IV', 'Lento', 'Symphony no. 7 "delle canzoni": IV. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16582 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f5ce9f3-f44e-4dd8-af33-5040c15f51dd'
);


-- None 교향곡 9번 "Dell"

UPDATE pieces piece
SET piece.title = '교향곡 9번 "Dell"', piece.title_en = 'Symphony no. 9 "Dell''Ahimè"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19991 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 9 "Dell''Ahimè": I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19991 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:5c0f73d1-dcf3-44c8-9c19-e46244b5cd13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c0f73d1-dcf3-44c8-9c19-e46244b5cd13', 1, 'I', 'Allegro', 'Symphony no. 9 "Dell''Ahimè": I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19991 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c0f73d1-dcf3-44c8-9c19-e46244b5cd13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Symphony no. 9 "Dell''Ahimè": II. Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19991 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:078938fc-33f2-4e58-a411-9fe2ba0f3aa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:078938fc-33f2-4e58-a411-9fe2ba0f3aa5', 2, 'II', 'Lento, ma non troppo', 'Symphony no. 9 "Dell''Ahimè": II. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19991 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:078938fc-33f2-4e58-a411-9fe2ba0f3aa5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 9 "Dell''Ahimè": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19991 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:f64febd4-fbe6-4912-ba71-2627de8a227e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f64febd4-fbe6-4912-ba71-2627de8a227e', 3, 'III', 'Allegro', 'Symphony no. 9 "Dell''Ahimè": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19991 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f64febd4-fbe6-4912-ba71-2627de8a227e'
);


-- None Tre canti di Filomela

UPDATE pieces piece
SET piece.title = 'Tre canti di Filomela', piece.title_en = 'Tre canti di Filomela',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19431 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'II canto. Se tu m’ami, se sospiri', part.name_en = 'Tre canti di filomela: II canto. Se tu m’ami, se sospiri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19431 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:1b897bae-0180-42d2-870d-e16393567e49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b897bae-0180-42d2-870d-e16393567e49', 1, NULL, 'II canto. Se tu m’ami, se sospiri', 'Tre canti di filomela: II canto. Se tu m’ami, se sospiri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19431 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b897bae-0180-42d2-870d-e16393567e49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'III canto. Amore, amore, che sì m’hai ferita', part.name_en = 'Tre canti di filomela: III canto. Amore, amore, che sì m’hai ferita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19431 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:321b28a0-6359-4276-bb6f-13f668c6ee9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:321b28a0-6359-4276-bb6f-13f668c6ee9a', 2, NULL, 'III canto. Amore, amore, che sì m’hai ferita', 'Tre canti di filomela: III canto. Amore, amore, che sì m’hai ferita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19431 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:321b28a0-6359-4276-bb6f-13f668c6ee9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'I canto. Fortuna tutto può che dà il potere', part.name_en = 'Tre canti di filomela: I canto. Fortuna tutto può che dà il potere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19431 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7714e560-dcce-4f1a-9b29-e1b9692da433' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7714e560-dcce-4f1a-9b29-e1b9692da433', 3, NULL, 'I canto. Fortuna tutto può che dà il potere', 'Tre canti di filomela: I canto. Fortuna tutto può che dà il potere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19431 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7714e560-dcce-4f1a-9b29-e1b9692da433'
);


-- None Tre danze antiche

UPDATE pieces piece
SET piece.title = 'Tre danze antiche', piece.title_en = 'Tre danze antiche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19977 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gavotta. Allegretto', part.name_en = 'Tre danze antiche: I. Gavotta. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19977 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:d8a79fb1-fad5-4856-b3f3-a29e1400ffce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8a79fb1-fad5-4856-b3f3-a29e1400ffce', 1, 'I', 'Gavotta. Allegretto', 'Tre danze antiche: I. Gavotta. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19977 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a79fb1-fad5-4856-b3f3-a29e1400ffce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minuetto. Carezzevole', part.name_en = 'Tre danze antiche: II. Minuetto. Carezzevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19977 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:09dff98c-b286-49d7-911c-1991007826fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09dff98c-b286-49d7-911c-1991007826fc', 2, 'II', 'Minuetto. Carezzevole', 'Tre danze antiche: II. Minuetto. Carezzevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19977 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09dff98c-b286-49d7-911c-1991007826fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Giga. Presto', part.name_en = 'Tre danze antiche: III. Giga. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19977 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:a0394375-2389-42de-b134-b20f612e6191' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0394375-2389-42de-b134-b20f612e6191', 3, 'III', 'Giga. Presto', 'Tre danze antiche: III. Giga. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19977 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0394375-2389-42de-b134-b20f612e6191'
);


-- None Tre poesie del Poliziano

UPDATE pieces piece
SET piece.title = 'Tre poesie del Poliziano', piece.title_en = 'Tre poesie del Poliziano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16678 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L’eco', part.name_en = 'Tre poesie del Poliziano: L’eco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16678 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b69297ac-da46-4858-a605-03049115797e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b69297ac-da46-4858-a605-03049115797e', 1, NULL, 'L’eco', 'Tre poesie del Poliziano: L’eco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16678 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b69297ac-da46-4858-a605-03049115797e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Inno a Maria nostra donna', part.name_en = 'Tre poesie del Poliziano: Inno a Maria nostra donna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16678 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:bff1896d-43ef-4812-adfa-d8e7f3bfba7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff1896d-43ef-4812-adfa-d8e7f3bfba7f', 2, NULL, 'Inno a Maria nostra donna', 'Tre poesie del Poliziano: Inno a Maria nostra donna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16678 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff1896d-43ef-4812-adfa-d8e7f3bfba7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ballata', part.name_en = 'Tre poesie del Poliziano: Ballata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16678 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e0bffee8-13db-4f2a-88d5-c45756013fc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0bffee8-13db-4f2a-88d5-c45756013fc3', 3, NULL, 'Ballata', 'Tre poesie del Poliziano: Ballata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16678 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0bffee8-13db-4f2a-88d5-c45756013fc3'
);


-- None Variazione sulla “Pantomima” dell’ “Amor brujo” di Manuel de Falla

UPDATE pieces piece
SET piece.title = 'Variazione sulla “Pantomima” dell’ “Amor brujo” di Manuel de Falla', piece.title_en = 'Variazione sulla “Pantomima” dell’ “Amor brujo” di Manuel de Falla',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17686 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variazioni senza tema

UPDATE pieces piece
SET piece.title = 'Variazioni senza tema', piece.title_en = 'Variazioni senza tema',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16415 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 협주곡 1번

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번', piece.title_en = 'Violin Concerto no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20060 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro (con spirito)', part.name_en = 'Violin Concerto no. 1: I. Allegro (con spirito)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20060 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:6f588fa0-6988-4d4d-beca-91a3ba4d80a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f588fa0-6988-4d4d-beca-91a3ba4d80a8', 1, 'I', 'Allegro (con spirito)', 'Violin Concerto no. 1: I. Allegro (con spirito)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20060 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f588fa0-6988-4d4d-beca-91a3ba4d80a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Violin Concerto no. 1: II. Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20060 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:686c365e-a3e6-45cd-b49b-081198133f2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:686c365e-a3e6-45cd-b49b-081198133f2f', 2, 'II', 'Lento, ma non troppo', 'Violin Concerto no. 1: II. Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20060 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:686c365e-a3e6-45cd-b49b-081198133f2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Violin Concerto no. 1: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20060 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:9e804d37-8165-4741-9688-66733dd38610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e804d37-8165-4741-9688-66733dd38610', 3, 'III', 'Allegro', 'Violin Concerto no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20060 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e804d37-8165-4741-9688-66733dd38610'
);


-- None 바이올린 협주곡 2번

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번', piece.title_en = 'Violin Concerto no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17387 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Violin Concerto no. 2: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17387 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:7f959000-c232-4053-8c10-bffa5cbf74b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f959000-c232-4053-8c10-bffa5cbf74b6', 1, 'I', 'Allegro', 'Violin Concerto no. 2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17387 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f959000-c232-4053-8c10-bffa5cbf74b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Non troppo lento', part.name_en = 'Violin Concerto no. 2: II. Non troppo lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17387 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:b4b934f0-76df-4ffb-ac17-487575771b83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4b934f0-76df-4ffb-ac17-487575771b83', 2, 'II', 'Non troppo lento', 'Violin Concerto no. 2: II. Non troppo lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17387 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b934f0-76df-4ffb-ac17-487575771b83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alquanto mosso', part.name_en = 'Violin Concerto no. 2: III. Alquanto mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17387 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:e2c37f4d-b3d0-4b4a-9988-58b59a91db99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c37f4d-b3d0-4b4a-9988-58b59a91db99', 3, 'III', 'Alquanto mosso', 'Violin Concerto no. 2: III. Alquanto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17387 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c37f4d-b3d0-4b4a-9988-58b59a91db99'
);


-- None Vivaldiana

UPDATE pieces piece
SET piece.title = 'Vivaldiana', piece.title_en = 'Vivaldiana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17803 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Allegro', part.name_en = 'Vivaldiana: I. Adagio - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17803 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:2ea4ab24-db02-4af5-b296-250148c388ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ea4ab24-db02-4af5-b296-250148c388ea', 1, 'I', 'Adagio - Allegro', 'Vivaldiana: I. Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17803 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ea4ab24-db02-4af5-b296-250148c388ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante più lento un poco', part.name_en = 'Vivaldiana: II. Andante più lento un poco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17803 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:067fc921-da31-4a88-b3f2-aa435748835f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067fc921-da31-4a88-b3f2-aa435748835f', 2, 'II', 'Andante più lento un poco', 'Vivaldiana: II. Andante più lento un poco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17803 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067fc921-da31-4a88-b3f2-aa435748835f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro - Allegro molto', part.name_en = 'Vivaldiana: III. Allegro - Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17803 AND p.composer_id = 260 AND part.part_key = 'musicbrainz:49f2d43a-5b0e-4b9b-a6f3-27da1d2c9d5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f2d43a-5b0e-4b9b-a6f3-27da1d2c9d5e', 3, 'III', 'Allegro - Allegro molto', 'Vivaldiana: III. Allegro - Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17803 AND p.composer_id = 260
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f2d43a-5b0e-4b9b-a6f3-27da1d2c9d5e'
);


-- None 가곡 <Vocalizzo per voce acuta>

UPDATE pieces piece
SET piece.title = '가곡 <Vocalizzo per voce acuta>', piece.title_en = 'Vocalizzo per voce acuta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16507 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b91b134d-da61-4fef-9ba9-cef7118fcd1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b91b134d-da61-4fef-9ba9-cef7118fcd1c'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b91b134d-da61-4fef-9ba9-cef7118fcd1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b75174b-7dd4-42e9-84f9-80a5841f5f8c', 1, 'I', 'Allegro moderato', 'Cello Concerto: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b75174b-7dd4-42e9-84f9-80a5841f5f8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b95bd978-520b-478c-b910-86fef2e942ce', 2, 'II', 'Lento', 'Cello Concerto: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b95bd978-520b-478c-b910-86fef2e942ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7981e093-e98c-436b-ba73-db0b1786f70d', 3, 'III', 'Allegro', 'Cello Concerto: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7981e093-e98c-436b-ba73-db0b1786f70d'
);


-- None Concerto per violino e orchestra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concerto per violino e orchestra', 'Concerto per violino e orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concerto per violino e orchestra'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee9c46b5-5984-4b7e-acdc-319f71a92ee1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee9c46b5-5984-4b7e-acdc-319f71a92ee1'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = 'Concerto per violino e orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee9c46b5-5984-4b7e-acdc-319f71a92ee1'
);


-- None 피아노 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번', 'Piano Concerto no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e022bca4-2cd0-43aa-a3ac-cb5d7dfdd0b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e022bca4-2cd0-43aa-a3ac-cb5d7dfdd0b3'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e022bca4-2cd0-43aa-a3ac-cb5d7dfdd0b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c542c3-d273-4eb8-87ac-b2328362efc8', 1, 'I', 'Allegro moderato', 'Piano Concerto no. 1: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c542c3-d273-4eb8-87ac-b2328362efc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21050449-2d6b-4ccb-9c5f-7a18129f0c2f', 2, 'II', 'Andante', 'Piano Concerto no. 1: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21050449-2d6b-4ccb-9c5f-7a18129f0c2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29a421a1-288e-468c-9bce-6686cd83027e', 3, 'III', 'Allegro', 'Piano Concerto no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29a421a1-288e-468c-9bce-6686cd83027e'
);


-- None 피아노 협주곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 3번', 'Piano Concerto no. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3121f1b4-ac93-46aa-aa0f-92f9a2438e73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3121f1b4-ac93-46aa-aa0f-92f9a2438e73'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3121f1b4-ac93-46aa-aa0f-92f9a2438e73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a2e78e7-4ad1-4abd-9b38-98ef29227e37', 1, 'I', 'Allegro', 'Piano Concerto no. 3: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a2e78e7-4ad1-4abd-9b38-98ef29227e37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66358e42-a21d-490d-88df-d035e3eaa8d9', 2, 'II', 'Lento', 'Piano Concerto no. 3: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66358e42-a21d-490d-88df-d035e3eaa8d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd2ddc61-121e-4a8d-921d-48f3e5325417', 3, 'III', 'Allegro agitato', 'Piano Concerto no. 3: III. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd2ddc61-121e-4a8d-921d-48f3e5325417'
);


-- None 피아노 협주곡 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 4번', 'Piano Concerto no. 4', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5969fd5e-6ae7-4ffb-86dd-2297f3934077'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5969fd5e-6ae7-4ffb-86dd-2297f3934077'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5969fd5e-6ae7-4ffb-86dd-2297f3934077'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f42bbfd-95f7-42ec-b112-8054cac60db5', 1, 'I', 'Allegro', 'Piano Concerto no. 4: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f42bbfd-95f7-42ec-b112-8054cac60db5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78cd07c2-327d-425c-b6b3-734911017f9a', 2, 'II', 'Lento', 'Piano Concerto no. 4: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78cd07c2-327d-425c-b6b3-734911017f9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca6846fa-a7e1-4427-8dca-af1f35e3deec', 3, 'III', 'Allegro vivace', 'Piano Concerto no. 4: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '피아노 협주곡 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6846fa-a7e1-4427-8dca-af1f35e3deec'
);


-- None 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet no. 4', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd1255eb-d81d-4352-b2a1-4eacd62b7918'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd1255eb-d81d-4352-b2a1-4eacd62b7918'
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd1255eb-d81d-4352-b2a1-4eacd62b7918'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 260 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17897
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
