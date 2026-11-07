-- Salvatore Sciarrino 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 58개(묶음 5, 다악장 5, 낱곡 48),
-- 새 작품 3개, part 31개, 그 아래 0개.
-- seed 55개 중 55개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Allegoria della notte

UPDATE pieces piece
SET piece.title = 'Allegoria della notte', piece.title_en = 'Allegoria della notte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17736 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Anamorfosi

UPDATE pieces piece
SET piece.title = 'Anamorfosi', piece.title_en = 'Anamorfosi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18390 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Appendice alla perfezione

UPDATE pieces piece
SET piece.title = 'Appendice alla perfezione', piece.title_en = 'Appendice alla perfezione',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19942 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arioso a 5

UPDATE pieces piece
SET piece.title = 'Arioso a 5', piece.title_en = 'Arioso a 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18748 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Autoritratto nella notte

UPDATE pieces piece
SET piece.title = 'Autoritratto nella notte', piece.title_en = 'Autoritratto nella notte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16013 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canti senza pietre

UPDATE pieces piece
SET piece.title = 'Canti senza pietre', piece.title_en = 'Canti senza pietre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19793 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mormorando omaggio a Michel Serres', part.name_en = 'Canti senza pietre: No. 1. Mormorando omaggio a Michel Serres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19793 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:e02e89de-1c8f-4f69-bbe3-4962dcddf343' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e02e89de-1c8f-4f69-bbe3-4962dcddf343', 1, NULL, 'Mormorando omaggio a Michel Serres', 'Canti senza pietre: No. 1. Mormorando omaggio a Michel Serres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19793 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e02e89de-1c8f-4f69-bbe3-4962dcddf343'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Liberamente accompagnando con le pause', part.name_en = 'Canti senza pietre: No. 2. Liberamente accompagnando con le pause',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19793 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:5130cc24-80e1-402a-a3d6-60f2393d7b6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5130cc24-80e1-402a-a3d6-60f2393d7b6e', 2, NULL, 'Liberamente accompagnando con le pause', 'Canti senza pietre: No. 2. Liberamente accompagnando con le pause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19793 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5130cc24-80e1-402a-a3d6-60f2393d7b6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Il silenzio è un morto con fessure', part.name_en = 'Canti senza pietre: No. 3. Il silenzio è un morto con fessure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19793 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:c4093a9b-d773-4b13-9716-ac7dfbd52e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4093a9b-d773-4b13-9716-ac7dfbd52e9d', 3, NULL, 'Il silenzio è un morto con fessure', 'Canti senza pietre: No. 3. Il silenzio è un morto con fessure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19793 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4093a9b-d773-4b13-9716-ac7dfbd52e9d'
);


-- None Centauro marino

UPDATE pieces piece
SET piece.title = 'Centauro marino', piece.title_en = 'Centauro marino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18473 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Codex purpureus

UPDATE pieces piece
SET piece.title = 'Codex purpureus', piece.title_en = 'Codex purpureus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19274 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come vengono prodotti gli incantesimi?

UPDATE pieces piece
SET piece.title = 'Come vengono prodotti gli incantesimi?', piece.title_en = 'Come vengono prodotti gli incantesimi?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18156 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None De la nuit

UPDATE pieces piece
SET piece.title = 'De la nuit', piece.title_en = 'De la nuit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18343 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None De o de do

UPDATE pieces piece
SET piece.title = 'De o de do', piece.title_en = 'De o de do',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19425 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Due notturni crudeli

UPDATE pieces piece
SET piece.title = 'Due notturni crudeli', piece.title_en = 'Due notturni crudeli',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18883 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Senza tempo e scandito', part.name_en = 'Due notturni crudeli: I. Senza tempo e scandito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18883 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:5565c101-0320-47ea-835b-dd65fe3d4223' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5565c101-0320-47ea-835b-dd65fe3d4223', 1, 'I', 'Senza tempo e scandito', 'Due notturni crudeli: I. Senza tempo e scandito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18883 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5565c101-0320-47ea-835b-dd65fe3d4223'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Furia, metallo', part.name_en = 'Due notturni crudeli: II. Furia, metallo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18883 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:792c02eb-a884-4b44-9354-bfced90e33f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792c02eb-a884-4b44-9354-bfced90e33f4', 2, 'II', 'Furia, metallo', 'Due notturni crudeli: II. Furia, metallo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18883 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792c02eb-a884-4b44-9354-bfced90e33f4'
);


-- None Esercizio

UPDATE pieces piece
SET piece.title = 'Esercizio', piece.title_en = 'Esercizio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19083 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Etude de concert

UPDATE pieces piece
SET piece.title = 'Etude de concert', piece.title_en = 'Etude de concert',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18059 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Frammento e Adagio

UPDATE pieces piece
SET piece.title = 'Frammento e Adagio', piece.title_en = 'Frammento e Adagio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19395 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Frammento', part.name_en = 'Frammento e Adagio: Frammento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19395 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:791dbf4a-72bd-4055-89ab-2410ac3b98c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:791dbf4a-72bd-4055-89ab-2410ac3b98c6', 1, NULL, 'Frammento', 'Frammento e Adagio: Frammento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19395 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:791dbf4a-72bd-4055-89ab-2410ac3b98c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Frammento e Adagio: Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19395 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:30d9a287-8543-4976-af35-58192d3dc298' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30d9a287-8543-4976-af35-58192d3dc298', 2, NULL, 'Adagio', 'Frammento e Adagio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19395 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30d9a287-8543-4976-af35-58192d3dc298'
);


-- None I fuochi oltre la ragione

UPDATE pieces piece
SET piece.title = 'I fuochi oltre la ragione', piece.title_en = 'I fuochi oltre la ragione',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16715 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None III Sonata

UPDATE pieces piece
SET piece.title = 'III Sonata', piece.title_en = 'III Sonata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19169 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None IV Sonata

UPDATE pieces piece
SET piece.title = 'IV Sonata', piece.title_en = 'IV Sonata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18224 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il silenzio degli oracoli

UPDATE pieces piece
SET piece.title = 'Il silenzio degli oracoli', piece.title_en = 'Il silenzio degli oracoli',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18627 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il suono e il tacere

UPDATE pieces piece
SET piece.title = 'Il suono e il tacere', piece.title_en = 'Il suono e il tacere',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20084 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il tempo con l'obelisco

UPDATE pieces piece
SET piece.title = 'Il tempo con l''obelisco', piece.title_en = 'Il tempo con l''obelisco',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18105 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Immagine fenicia

UPDATE pieces piece
SET piece.title = 'Immagine fenicia', piece.title_en = 'Immagine fenicia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18606 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In nomine nominis

UPDATE pieces piece
SET piece.title = 'In nomine nominis', piece.title_en = 'In nomine nominis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19522 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Infinito nero

UPDATE pieces piece
SET piece.title = 'Infinito nero', piece.title_en = 'Infinito nero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18729 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introduzione all'oscuro

UPDATE pieces piece
SET piece.title = 'Introduzione all''oscuro', piece.title_en = 'Introduzione all''oscuro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16705 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'alibi della parola

UPDATE pieces piece
SET piece.title = 'L''alibi della parola', piece.title_en = 'L''alibi della parola',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17843 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pulsar', part.name_en = 'L''alibi della parola: I. Pulsar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17843 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:c5b7879d-5755-4a17-b14a-2598d3ce7a6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5b7879d-5755-4a17-b14a-2598d3ce7a6d', 1, 'I', 'Pulsar', 'L''alibi della parola: I. Pulsar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17843 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b7879d-5755-4a17-b14a-2598d3ce7a6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quasar', part.name_en = 'L''alibi della parola: II. Quasar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17843 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:ed700b31-efdb-4f61-8e82-3abffd8601db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed700b31-efdb-4f61-8e82-3abffd8601db', 2, 'II', 'Quasar', 'L''alibi della parola: II. Quasar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17843 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed700b31-efdb-4f61-8e82-3abffd8601db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Futuro remoto', part.name_en = 'L''alibi della parola: III. Futuro remoto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17843 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:fa31736d-7ba4-489b-b484-61cb3fe06010' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa31736d-7ba4-489b-b484-61cb3fe06010', 3, 'III', 'Futuro remoto', 'L''alibi della parola: III. Futuro remoto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17843 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa31736d-7ba4-489b-b484-61cb3fe06010'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vasi parlanti', part.name_en = 'L''alibi della parola: IV. Vasi parlanti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17843 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:46d9d021-b4a7-4488-87c1-f305dc2f8e30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46d9d021-b4a7-4488-87c1-f305dc2f8e30', 4, 'IV', 'Vasi parlanti', 'L''alibi della parola: IV. Vasi parlanti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17843 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46d9d021-b4a7-4488-87c1-f305dc2f8e30'
);


-- None La malinconia

UPDATE pieces piece
SET piece.title = 'La malinconia', piece.title_en = 'La malinconia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18953 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La voce dell'inferno>

UPDATE pieces piece
SET piece.title = '오페라 <La voce dell''inferno>', piece.title_en = 'La voce dell''inferno',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17520 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le ragioni delle conchiglie

UPDATE pieces piece
SET piece.title = 'Le ragioni delle conchiglie', piece.title_en = 'Le ragioni delle conchiglie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18219 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le voci sottovetro

UPDATE pieces piece
SET piece.title = 'Le voci sottovetro', piece.title_en = 'Le voci sottovetro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18453 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Let me die before I wake

UPDATE pieces piece
SET piece.title = 'Let me die before I wake', piece.title_en = 'Let me die before I wake',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20043 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Libro notturno delle voci

UPDATE pieces piece
SET piece.title = 'Libro notturno delle voci', piece.title_en = 'Libro notturno delle voci',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20055 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'In val d’abisso', part.name_en = 'Libro notturno delle voci: I. In val d’abisso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20055 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:1a6938c4-f298-4987-8f6c-684aade61a7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a6938c4-f298-4987-8f6c-684aade61a7d', 1, 'I', 'In val d’abisso', 'Libro notturno delle voci: I. In val d’abisso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20055 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a6938c4-f298-4987-8f6c-684aade61a7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fauci dell’emozione', part.name_en = 'Libro notturno delle voci: II. Fauci dell’emozione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20055 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:65f14aa2-5b7d-4b0b-b38e-9c012cf6b3b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f14aa2-5b7d-4b0b-b38e-9c012cf6b3b4', 2, 'II', 'Fauci dell’emozione', 'Libro notturno delle voci: II. Fauci dell’emozione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20055 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f14aa2-5b7d-4b0b-b38e-9c012cf6b3b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mario Caroli e l’iridescenza di un re', part.name_en = 'Libro notturno delle voci: III. Mario Caroli e l’iridescenza di un re',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20055 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:07cdcbbc-6d4a-4da5-bbeb-8fe763ced5d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07cdcbbc-6d4a-4da5-bbeb-8fe763ced5d4', 3, 'III', 'Mario Caroli e l’iridescenza di un re', 'Libro notturno delle voci: III. Mario Caroli e l’iridescenza di un re', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20055 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07cdcbbc-6d4a-4da5-bbeb-8fe763ced5d4'
);


-- None Lo spazio inverso

UPDATE pieces piece
SET piece.title = 'Lo spazio inverso', piece.title_en = 'Lo spazio inverso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19361 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Morte di Borromini

UPDATE pieces piece
SET piece.title = 'Morte di Borromini', piece.title_en = 'Morte di Borromini',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17988 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Muro d'orizzonte

UPDATE pieces piece
SET piece.title = 'Muro d''orizzonte', piece.title_en = 'Muro d''orizzonte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18889 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Omaggio a Burri

UPDATE pieces piece
SET piece.title = 'Omaggio a Burri', piece.title_en = 'Omaggio a Burri',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16727 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pagine

UPDATE pieces piece
SET piece.title = 'Pagine', piece.title_en = 'Pagine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19715 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pagine - 10. Tres dous complains (Anonimo, XIV sec.)', part.name_en = 'Pagine - 10. Tres dous complains (Anonimo, XIV sec.)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19715 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:88f718d1-492a-4f84-8aa9-f63b8a1958bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f718d1-492a-4f84-8aa9-f63b8a1958bf', 1, NULL, 'Pagine - 10. Tres dous complains (Anonimo, XIV sec.)', 'Pagine - 10. Tres dous complains (Anonimo, XIV sec.)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19715 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f718d1-492a-4f84-8aa9-f63b8a1958bf'
);


-- None Perduto in una città d'acque

UPDATE pieces piece
SET piece.title = 'Perduto in una città d''acque', piece.title_en = 'Perduto in una città d''acque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17876 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polveri laterali

UPDATE pieces piece
SET piece.title = 'Polveri laterali', piece.title_en = 'Polveri laterali',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17515 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prima Sonata

UPDATE pieces piece
SET piece.title = 'Prima Sonata', piece.title_en = 'Prima Sonata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17261 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartetto no. 7

UPDATE pieces piece
SET piece.title = 'Quartetto no. 7', piece.title_en = 'Quartetto no. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19835 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartetto no. 8

UPDATE pieces piece
SET piece.title = 'Quartetto no. 8', piece.title_en = 'Quartetto no. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17196 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintetto n°1

UPDATE pieces piece
SET piece.title = 'Quintetto n°1', piece.title_en = 'Quintetto n°1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20090 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintetto n°2

UPDATE pieces piece
SET piece.title = 'Quintetto n°2', piece.title_en = 'Quintetto n°2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17567 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Recitativo oscuro

UPDATE pieces piece
SET piece.title = 'Recitativo oscuro', piece.title_en = 'Recitativo oscuro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16821 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Responsorio delle tenebre

UPDATE pieces piece
SET piece.title = 'Responsorio delle tenebre', piece.title_en = 'Responsorio delle tenebre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17878 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sei capricci per violino solo

UPDATE pieces piece
SET piece.title = 'Sei capricci per violino solo', piece.title_en = 'Sei capricci per violino solo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18199 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Sei capricci per violino solo: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:a147fd33-adc4-4d50-bc49-1fd33d7786a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a147fd33-adc4-4d50-bc49-1fd33d7786a5', 1, NULL, 'No. 1', 'Sei capricci per violino solo: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a147fd33-adc4-4d50-bc49-1fd33d7786a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Sei capricci per violino solo: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:4244f161-17a1-4410-843a-7861b13bb8e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4244f161-17a1-4410-843a-7861b13bb8e1', 2, NULL, 'No. 2', 'Sei capricci per violino solo: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4244f161-17a1-4410-843a-7861b13bb8e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Sei capricci per violino solo: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:e3e33439-3ebd-4b66-b62a-9f46b137850d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e33439-3ebd-4b66-b62a-9f46b137850d', 3, NULL, 'No. 3', 'Sei capricci per violino solo: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e33439-3ebd-4b66-b62a-9f46b137850d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Sei capricci per violino solo: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:a2a61819-e428-4fd9-9dbf-6eae7e99bf57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a61819-e428-4fd9-9dbf-6eae7e99bf57', 4, NULL, 'No. 4', 'Sei capricci per violino solo: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a61819-e428-4fd9-9dbf-6eae7e99bf57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Sei capricci per violino solo: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:c5a38202-76b5-48af-b76e-7f450df00ad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5a38202-76b5-48af-b76e-7f450df00ad6', 5, NULL, 'No. 5', 'Sei capricci per violino solo: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5a38202-76b5-48af-b76e-7f450df00ad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Sei capricci per violino solo: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18199 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:b36fc540-2418-4b86-bd1c-15703b53aa33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b36fc540-2418-4b86-bd1c-15703b53aa33', 6, NULL, 'No. 6', 'Sei capricci per violino solo: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18199 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b36fc540-2418-4b86-bd1c-15703b53aa33'
);


-- None Sei quartetti brevi

UPDATE pieces piece
SET piece.title = 'Sei quartetti brevi', piece.title_en = 'Sei quartetti brevi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16625 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Sei quartetti brevi: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:0ecc2b85-9b92-4e95-904e-c4cde8a0e119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ecc2b85-9b92-4e95-904e-c4cde8a0e119', 1, NULL, 'I', 'Sei quartetti brevi: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ecc2b85-9b92-4e95-904e-c4cde8a0e119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Sei quartetti brevi: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:bc17f039-82e4-4241-85c1-6489eb415ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc17f039-82e4-4241-85c1-6489eb415ef6', 2, NULL, 'II', 'Sei quartetti brevi: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc17f039-82e4-4241-85c1-6489eb415ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Sei quartetti brevi: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:05eccab2-ba84-4c60-a051-c03b8ff30c79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05eccab2-ba84-4c60-a051-c03b8ff30c79', 3, NULL, 'III', 'Sei quartetti brevi: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05eccab2-ba84-4c60-a051-c03b8ff30c79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Sei quartetti brevi: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:69accf25-3931-4cb0-8dcd-5239c1122ad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69accf25-3931-4cb0-8dcd-5239c1122ad5', 4, NULL, 'IV', 'Sei quartetti brevi: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69accf25-3931-4cb0-8dcd-5239c1122ad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Sei quartetti brevi: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:e211bb9e-8e2a-4263-9995-20ea08aec0fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e211bb9e-8e2a-4263-9995-20ea08aec0fd', 5, NULL, 'V', 'Sei quartetti brevi: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e211bb9e-8e2a-4263-9995-20ea08aec0fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Sei quartetti brevi: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16625 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:1de98d5a-a653-42b6-817f-bda6a81250e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1de98d5a-a653-42b6-817f-bda6a81250e9', 6, NULL, 'VI', 'Sei quartetti brevi: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16625 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1de98d5a-a653-42b6-817f-bda6a81250e9'
);


-- None Shadow of Sound

UPDATE pieces piece
SET piece.title = 'Shadow of Sound', piece.title_en = 'Shadow of Sound',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19524 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata II

UPDATE pieces piece
SET piece.title = 'Sonata II', piece.title_en = 'Sonata II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18664 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Storie di altre storie

UPDATE pieces piece
SET piece.title = 'Storie di altre storie', piece.title_en = 'Storie di altre storie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16043 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Come senza tempo', part.name_en = 'Storie di altre storie: I. Come senza tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16043 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:91635cfd-c77c-4d97-8510-726103bf6618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91635cfd-c77c-4d97-8510-726103bf6618', 1, 'I', 'Come senza tempo', 'Storie di altre storie: I. Come senza tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16043 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91635cfd-c77c-4d97-8510-726103bf6618'
);


-- None Tre notturni brillanti

UPDATE pieces piece
SET piece.title = 'Tre notturni brillanti', piece.title_en = 'Tre notturni brillanti',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18437 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Di volo', part.name_en = 'Tre notturni brillanti: No. 1. Di volo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18437 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:8fa022fa-51f2-4cb7-a119-d41002c4350a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa022fa-51f2-4cb7-a119-d41002c4350a', 1, NULL, 'Di volo', 'Tre notturni brillanti: No. 1. Di volo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18437 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa022fa-51f2-4cb7-a119-d41002c4350a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scorrevole e animato', part.name_en = 'Tre notturni brillanti: No. 2. Scorrevole e animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18437 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:79d39706-d257-4e9f-be22-32b1f4e67965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79d39706-d257-4e9f-be22-32b1f4e67965', 2, NULL, 'Scorrevole e animato', 'Tre notturni brillanti: No. 2. Scorrevole e animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18437 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d39706-d257-4e9f-be22-32b1f4e67965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prestissimo precipitando', part.name_en = 'Tre notturni brillanti: No. 3. Prestissimo precipitando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18437 AND p.composer_id = 225 AND part.part_key = 'musicbrainz:aa723107-fec4-4e3f-b7c2-3cf508e80260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa723107-fec4-4e3f-b7c2-3cf508e80260', 3, NULL, 'Prestissimo precipitando', 'Tre notturni brillanti: No. 3. Prestissimo precipitando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18437 AND p.composer_id = 225
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa723107-fec4-4e3f-b7c2-3cf508e80260'
);


-- None Vagabonde blu

UPDATE pieces piece
SET piece.title = 'Vagabonde blu', piece.title_en = 'Vagabonde blu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17483 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variazione su uno spazio ricurvo

UPDATE pieces piece
SET piece.title = 'Variazione su uno spazio ricurvo', piece.title_en = 'Variazione su uno spazio ricurvo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17667 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Venere che le grazie la fioriscono

UPDATE pieces piece
SET piece.title = 'Venere che le grazie la fioriscono', piece.title_en = 'Venere che le grazie la fioriscono',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19565 AND piece.composer_id = 225
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ai limiti della notte

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ai limiti della notte', 'Ai limiti della notte', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 225
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ai limiti della notte'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '601d6928-3afc-4acb-99c3-675d9ecb03ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '601d6928-3afc-4acb-99c3-675d9ecb03ab'
FROM pieces p
WHERE p.composer_id = 225 AND p.title = 'Ai limiti della notte' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '601d6928-3afc-4acb-99c3-675d9ecb03ab'
);


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Prelude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 225
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f83fd7b3-c08a-4be6-8e05-25e41f6cb87e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f83fd7b3-c08a-4be6-8e05-25e41f6cb87e'
FROM pieces p
WHERE p.composer_id = 225 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f83fd7b3-c08a-4be6-8e05-25e41f6cb87e'
);


-- None Variazioni

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Variazioni', 'Variazioni', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 225
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Variazioni'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51e0dcae-fca8-4b08-a1c3-d0124adaca26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51e0dcae-fca8-4b08-a1c3-d0124adaca26'
FROM pieces p
WHERE p.composer_id = 225 AND p.title = 'Variazioni' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51e0dcae-fca8-4b08-a1c3-d0124adaca26'
);


-- 숨길 seed 작품 없음
