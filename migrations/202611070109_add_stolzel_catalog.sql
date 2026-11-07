-- Gottfried Heinrich Stölzel 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 40개(묶음 3, 다악장 37, 낱곡 0),
-- 새 작품 1개, part 273개, 그 아래 0개.
-- seed 43개 중 39개를 작품·part 에 잇고, 4개를 숨기고, 0개는 그대로 둔다.
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

-- H. 27 칸타타 <Ach, daß die Hülfe aus Zion über Israel käme>

UPDATE pieces piece
SET piece.title = '칸타타 <Ach, daß die Hülfe aus Zion über Israel käme>', piece.title_en = 'Ach, daß die Hülfe aus Zion über Israel käme, H. 27',
    piece.type = 'album', piece.opus_number = 'H. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24304 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'O Wunder, ach, bedenkt es doch (Rec. T, B)', part.name_en = 'Ach, daß die Hülfe aus Zion über Israel käme: III. O Wunder, ach, bedenkt es doch (Rec. T, B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24304 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5582c00d-e07f-4273-88d1-5de37cfaf66e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5582c00d-e07f-4273-88d1-5de37cfaf66e', 1, 'III', 'O Wunder, ach, bedenkt es doch (Rec. T, B)', 'Ach, daß die Hülfe aus Zion über Israel käme: III. O Wunder, ach, bedenkt es doch (Rec. T, B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24304 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5582c00d-e07f-4273-88d1-5de37cfaf66e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Bewegte Weihnachtslust (Rec. B, T & Chorale)', part.name_en = 'Ach, daß die Hülfe aus Zion über Israel käme: V. Bewegte Weihnachtslust (Rec. B, T & Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24304 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7baf1e61-29d3-4654-ab16-2e24a0ccccd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7baf1e61-29d3-4654-ab16-2e24a0ccccd1', 2, 'V', 'Bewegte Weihnachtslust (Rec. B, T & Chorale)', 'Ach, daß die Hülfe aus Zion über Israel käme: V. Bewegte Weihnachtslust (Rec. B, T & Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24304 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7baf1e61-29d3-4654-ab16-2e24a0ccccd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Ach, daß die Hülfe aus Zion über Israel käme (Tutti)', part.name_en = 'Ach, daß die Hülfe aus Zion über Israel käme: I. Ach, daß die Hülfe aus Zion über Israel käme (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24304 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e04c286d-822a-487c-bf18-2a52a6d939c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e04c286d-822a-487c-bf18-2a52a6d939c4', 3, 'I', 'Ach, daß die Hülfe aus Zion über Israel käme (Tutti)', 'Ach, daß die Hülfe aus Zion über Israel käme: I. Ach, daß die Hülfe aus Zion über Israel käme (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24304 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e04c286d-822a-487c-bf18-2a52a6d939c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Die reichste Freud und größte Beute (Aria B)', part.name_en = 'Ach, daß die Hülfe aus Zion über Israel käme: IV. Die reichste Freud und größte Beute (Aria B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24304 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e4da5f4c-e1a4-4fa8-a969-f97df7b83c15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4da5f4c-e1a4-4fa8-a969-f97df7b83c15', 4, 'IV', 'Die reichste Freud und größte Beute (Aria B)', 'Ach, daß die Hülfe aus Zion über Israel käme: IV. Die reichste Freud und größte Beute (Aria B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24304 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4da5f4c-e1a4-4fa8-a969-f97df7b83c15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Seelenwollust, Freud und Wonne (Aria C)', part.name_en = 'Ach, daß die Hülfe aus Zion über Israel käme: II. Seelenwollust, Freud und Wonne (Aria C)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24304 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ee481a93-ed4f-4b45-9302-dac347bab62b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee481a93-ed4f-4b45-9302-dac347bab62b', 5, 'II', 'Seelenwollust, Freud und Wonne (Aria C)', 'Ach, daß die Hülfe aus Zion über Israel käme: II. Seelenwollust, Freud und Wonne (Aria C)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24304 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee481a93-ed4f-4b45-9302-dac347bab62b'
);


-- H. 48 칸타타 <Alles, was ihr tut mit Worten oder Werken>

UPDATE pieces piece
SET piece.title = '칸타타 <Alles, was ihr tut mit Worten oder Werken>', piece.title_en = 'Alles, was ihr tut mit Worten oder Werken, H. 48',
    piece.type = 'album', piece.opus_number = 'H. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25006 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'O Herr Christ, nimm unser wahr (Chorale und Tutti)', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: VI. O Herr Christ, nimm unser wahr (Chorale und Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0d975459-8894-4940-9674-0c2aadbe6533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d975459-8894-4940-9674-0c2aadbe6533', 1, 'VI', 'O Herr Christ, nimm unser wahr (Chorale und Tutti)', 'Alles, was ihr tut mit Worten oder Werken: VI. O Herr Christ, nimm unser wahr (Chorale und Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d975459-8894-4940-9674-0c2aadbe6533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Blutrünstigs Jesulein', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: II. Blutrünstigs Jesulein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:42e13515-d070-47c8-81ba-56a784a7e511' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42e13515-d070-47c8-81ba-56a784a7e511', 2, 'II', 'Blutrünstigs Jesulein', 'Alles, was ihr tut mit Worten oder Werken: II. Blutrünstigs Jesulein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e13515-d070-47c8-81ba-56a784a7e511'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Das beste Neuejahrsgeschenke', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: V. Das beste Neuejahrsgeschenke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:526319b6-9b34-4df2-b245-cf7f3742adc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:526319b6-9b34-4df2-b245-cf7f3742adc1', 3, 'V', 'Das beste Neuejahrsgeschenke', 'Alles, was ihr tut mit Worten oder Werken: V. Das beste Neuejahrsgeschenke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:526319b6-9b34-4df2-b245-cf7f3742adc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Wenn wir in Jesu Namen', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: IV. Wenn wir in Jesu Namen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:90a9afa3-3a23-42e5-9161-f434f14839ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90a9afa3-3a23-42e5-9161-f434f14839ea', 4, 'IV', 'Wenn wir in Jesu Namen', 'Alles, was ihr tut mit Worten oder Werken: IV. Wenn wir in Jesu Namen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a9afa3-3a23-42e5-9161-f434f14839ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = 'Laß dein Herz, dein Aug'' und Hand', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: III. Laß dein Herz, dein Aug'' und Hand',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:99adae1f-8c5b-4ad5-8c1f-5a284ead5114' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99adae1f-8c5b-4ad5-8c1f-5a284ead5114', 5, 'III', 'Laß dein Herz, dein Aug'' und Hand', 'Alles, was ihr tut mit Worten oder Werken: III. Laß dein Herz, dein Aug'' und Hand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99adae1f-8c5b-4ad5-8c1f-5a284ead5114'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Alles, was ihr tut mit Worten oder Werken (Tutti)', part.name_en = 'Alles, was ihr tut mit Worten oder Werken: I. Alles, was ihr tut mit Worten oder Werken (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25006 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:faeebf9e-64d8-405a-b7c5-5e14b268c7b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faeebf9e-64d8-405a-b7c5-5e14b268c7b8', 6, 'I', 'Alles, was ihr tut mit Worten oder Werken (Tutti)', 'Alles, was ihr tut mit Worten oder Werken: I. Alles, was ihr tut mit Worten oder Werken (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25006 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faeebf9e-64d8-405a-b7c5-5e14b268c7b8'
);


-- None 칸타타 <Aurora Weinete, H. WK A 12>

UPDATE pieces piece
SET piece.title = '칸타타 <Aurora Weinete, H. WK A 12>', piece.title_en = 'Aurora Weinete, H. WK A 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25411 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aurora Weinete (Recit. Tenor)', part.name_en = 'Aurora Weinete: I. Aurora Weinete (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25411 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7cec1126-eafa-4b3a-b5b4-251567c87153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cec1126-eafa-4b3a-b5b4-251567c87153', 1, 'I', 'Aurora Weinete (Recit. Tenor)', 'Aurora Weinete: I. Aurora Weinete (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25411 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cec1126-eafa-4b3a-b5b4-251567c87153'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Angenehmste Schafer-Chore (Aria Soprano)', part.name_en = 'Aurora Weinete: II. Angenehmste Schafer-Chore (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25411 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:22e324c5-ad9b-46d1-8cec-da8d3706d9d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e324c5-ad9b-46d1-8cec-da8d3706d9d7', 2, 'II', 'Angenehmste Schafer-Chore (Aria Soprano)', 'Aurora Weinete: II. Angenehmste Schafer-Chore (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25411 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e324c5-ad9b-46d1-8cec-da8d3706d9d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ach! fuhr sie weiter fort (Recit. Soprano, Tenor)', part.name_en = 'Aurora Weinete: III. Ach! fuhr sie weiter fort (Recit. Soprano, Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25411 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:85f566cd-215f-490a-9b15-833df17b3d94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f566cd-215f-490a-9b15-833df17b3d94', 3, 'III', 'Ach! fuhr sie weiter fort (Recit. Soprano, Tenor)', 'Aurora Weinete: III. Ach! fuhr sie weiter fort (Recit. Soprano, Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25411 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f566cd-215f-490a-9b15-833df17b3d94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Erwahl dir ein getreues Herze (Aria- Tenor)', part.name_en = 'Aurora Weinete: IV. Erwahl dir ein getreues Herze (Aria- Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25411 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:72f6f353-19b7-4ffa-90fb-53e7d701b61e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f6f353-19b7-4ffa-90fb-53e7d701b61e', 4, 'IV', 'Erwahl dir ein getreues Herze (Aria- Tenor)', 'Aurora Weinete: IV. Erwahl dir ein getreues Herze (Aria- Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25411 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f6f353-19b7-4ffa-90fb-53e7d701b61e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Hierauf floh sie vor mir (Aria Tenor)', part.name_en = 'Aurora Weinete: V. Hierauf floh sie vor mir (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25411 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0f52869f-2d95-4bd1-a4f6-44ed95182842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f52869f-2d95-4bd1-a4f6-44ed95182842', 5, 'V', 'Hierauf floh sie vor mir (Aria Tenor)', 'Aurora Weinete: V. Hierauf floh sie vor mir (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25411 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f52869f-2d95-4bd1-a4f6-44ed95182842'
);


-- None 오라토리오 <Brockes Passion>

UPDATE pieces piece
SET piece.title = '오라토리오 <Brockes Passion>', piece.title_en = 'Brockes Passion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25137 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria & Recitativo: Laß diese That nicht ungerochen', part.name_en = 'Brockes Passion: Pars III: Aria & Recitativo: Laß diese That nicht ungerochen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:03159f2b-c728-4b1f-8bc1-b3a7d9b03c3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03159f2b-c728-4b1f-8bc1-b3a7d9b03c3e', 1, NULL, 'Pars III: Aria & Recitativo: Laß diese That nicht ungerochen', 'Brockes Passion: Pars III: Aria & Recitativo: Laß diese That nicht ungerochen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03159f2b-c728-4b1f-8bc1-b3a7d9b03c3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Aria: Wisch ab der Thränen scharffe Lauge', part.name_en = 'Brockes Passion: Pars IV: Aria: Wisch ab der Thränen scharffe Lauge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0afc092a-b7e4-430e-95ee-af369abcd690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0afc092a-b7e4-430e-95ee-af369abcd690', 2, NULL, 'Pars IV: Aria: Wisch ab der Thränen scharffe Lauge', 'Brockes Passion: Pars IV: Aria: Wisch ab der Thränen scharffe Lauge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0afc092a-b7e4-430e-95ee-af369abcd690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo: Ach Gott! Mein Sohn wird fortgeschleppt', part.name_en = 'Brockes Passion: Pars IV: Recitativo: Ach Gott! Mein Sohn wird fortgeschleppt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0bc4576d-23b6-4878-b62f-bf3b889140d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bc4576d-23b6-4878-b62f-bf3b889140d3', 3, NULL, 'Pars IV: Recitativo: Ach Gott! Mein Sohn wird fortgeschleppt', 'Brockes Passion: Pars IV: Recitativo: Ach Gott! Mein Sohn wird fortgeschleppt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bc4576d-23b6-4878-b62f-bf3b889140d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pars I: Aria: Der Gott, dem alle Himmels-Kreise', part.name_en = 'Brockes Passion: Pars I: Aria: Der Gott, dem alle Himmels-Kreise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0f1f48a3-fcb0-4ef1-825b-edd15eda0328' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f1f48a3-fcb0-4ef1-825b-edd15eda0328', 4, NULL, 'Pars I: Aria: Der Gott, dem alle Himmels-Kreise', 'Brockes Passion: Pars I: Aria: Der Gott, dem alle Himmels-Kreise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f1f48a3-fcb0-4ef1-825b-edd15eda0328'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pars III: Duetto: Jesu, dich mit unsern Seelen', part.name_en = 'Brockes Passion: Pars III: Duetto: Jesu, dich mit unsern Seelen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:13a9d7ba-68af-4d65-bfa6-08b943b2f0ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13a9d7ba-68af-4d65-bfa6-08b943b2f0ac', 5, NULL, 'Pars III: Duetto: Jesu, dich mit unsern Seelen', 'Brockes Passion: Pars III: Duetto: Jesu, dich mit unsern Seelen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a9d7ba-68af-4d65-bfa6-08b943b2f0ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Duetto: Soll mein Kind, mein Leben sterben', part.name_en = 'Brockes Passion: Pars IV: Duetto: Soll mein Kind, mein Leben sterben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:13f4e3e8-0eca-40ff-bbf2-0fcdf9003643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13f4e3e8-0eca-40ff-bbf2-0fcdf9003643', 6, NULL, 'Pars IV: Duetto: Soll mein Kind, mein Leben sterben', 'Brockes Passion: Pars IV: Duetto: Soll mein Kind, mein Leben sterben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13f4e3e8-0eca-40ff-bbf2-0fcdf9003643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo: Wie nun das Blut mit Ströhmen von ihm rann', part.name_en = 'Brockes Passion: Pars III: Recitativo: Wie nun das Blut mit Ströhmen von ihm rann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:152db90a-17cb-494f-968c-a4c60bd1a475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:152db90a-17cb-494f-968c-a4c60bd1a475', 7, NULL, 'Pars III: Recitativo: Wie nun das Blut mit Ströhmen von ihm rann', 'Brockes Passion: Pars III: Recitativo: Wie nun das Blut mit Ströhmen von ihm rann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152db90a-17cb-494f-968c-a4c60bd1a475'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pars II: Chorale: Ach Gott und Herr', part.name_en = 'Brockes Passion: Pars II: Chorale: Ach Gott und Herr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:17c1cbf7-e84c-402b-84e7-3d23f4522cc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17c1cbf7-e84c-402b-84e7-3d23f4522cc5', 8, NULL, 'Pars II: Chorale: Ach Gott und Herr', 'Brockes Passion: Pars II: Chorale: Ach Gott und Herr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17c1cbf7-e84c-402b-84e7-3d23f4522cc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo, Aria & Recitativo: Worauf sie mit dem Rohr', part.name_en = 'Brockes Passion: Pars III: Recitativo, Aria & Recitativo: Worauf sie mit dem Rohr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:27db5bcd-2188-455b-ad99-30b54db9c075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27db5bcd-2188-455b-ad99-30b54db9c075', 9, NULL, 'Pars III: Recitativo, Aria & Recitativo: Worauf sie mit dem Rohr', 'Brockes Passion: Pars III: Recitativo, Aria & Recitativo: Worauf sie mit dem Rohr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27db5bcd-2188-455b-ad99-30b54db9c075'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pars I: Aria, Recitativo et Aria: Mein Vater! schau, wie ich mich quäle!', part.name_en = 'Brockes Passion: Pars I: Aria, Recitativo et Aria: Mein Vater! schau, wie ich mich quäle!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2961ccd9-9bcc-408a-a035-42e219c6e4f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2961ccd9-9bcc-408a-a035-42e219c6e4f2', 10, NULL, 'Pars I: Aria, Recitativo et Aria: Mein Vater! schau, wie ich mich quäle!', 'Brockes Passion: Pars I: Aria, Recitativo et Aria: Mein Vater! schau, wie ich mich quäle!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2961ccd9-9bcc-408a-a035-42e219c6e4f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Pars I: Aria: Gott selbst, die Brunnquell alles Guten', part.name_en = 'Brockes Passion: Pars I: Aria: Gott selbst, die Brunnquell alles Guten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2c979938-6de9-4c7d-a70c-ef4221c30241' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c979938-6de9-4c7d-a70c-ef4221c30241', 11, NULL, 'Pars I: Aria: Gott selbst, die Brunnquell alles Guten', 'Brockes Passion: Pars I: Aria: Gott selbst, die Brunnquell alles Guten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c979938-6de9-4c7d-a70c-ef4221c30241'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pars III: Arioso, Recitativo & Aria: Ich seh an einen Stein gebunden', part.name_en = 'Brockes Passion: Pars III: Arioso, Recitativo & Aria: Ich seh an einen Stein gebunden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2d390fb0-1b5f-4a0a-97f9-05cf46a13177' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d390fb0-1b5f-4a0a-97f9-05cf46a13177', 12, NULL, 'Pars III: Arioso, Recitativo & Aria: Ich seh an einen Stein gebunden', 'Brockes Passion: Pars III: Arioso, Recitativo & Aria: Ich seh an einen Stein gebunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d390fb0-1b5f-4a0a-97f9-05cf46a13177'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Pars III: Accompagnato: O was hab ich verfluchter Mensch getan', part.name_en = 'Brockes Passion: Pars III: Accompagnato: O was hab ich verfluchter Mensch getan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3150b3ee-424f-448d-b1f6-d0f428a1c2ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3150b3ee-424f-448d-b1f6-d0f428a1c2ca', 13, NULL, 'Pars III: Accompagnato: O was hab ich verfluchter Mensch getan', 'Brockes Passion: Pars III: Accompagnato: O was hab ich verfluchter Mensch getan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3150b3ee-424f-448d-b1f6-d0f428a1c2ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria con Coro & Chorale: Eilt, ihr angefochten Seelen', part.name_en = 'Brockes Passion: Pars III: Aria con Coro & Chorale: Eilt, ihr angefochten Seelen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:31c0c369-1738-4dea-819e-11e7ab330d23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31c0c369-1738-4dea-819e-11e7ab330d23', 14, NULL, 'Pars III: Aria con Coro & Chorale: Eilt, ihr angefochten Seelen', 'Brockes Passion: Pars III: Aria con Coro & Chorale: Eilt, ihr angefochten Seelen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31c0c369-1738-4dea-819e-11e7ab330d23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Pars II: Aria et Recitativo: Heul, du Schaum der Menschenkinder', part.name_en = 'Brockes Passion: Pars II: Aria et Recitativo: Heul, du Schaum der Menschenkinder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:33e66c4f-1498-4753-8cf0-32b2786fc757' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33e66c4f-1498-4753-8cf0-32b2786fc757', 15, NULL, 'Pars II: Aria et Recitativo: Heul, du Schaum der Menschenkinder', 'Brockes Passion: Pars II: Aria et Recitativo: Heul, du Schaum der Menschenkinder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33e66c4f-1498-4753-8cf0-32b2786fc757'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo & Coro: Pilatus wunderte sich sehr', part.name_en = 'Brockes Passion: Pars III: Recitativo & Coro: Pilatus wunderte sich sehr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:36c96325-bc92-43a8-8e77-8c773412bcc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36c96325-bc92-43a8-8e77-8c773412bcc4', 16, NULL, 'Pars III: Recitativo & Coro: Pilatus wunderte sich sehr', 'Brockes Passion: Pars III: Recitativo & Coro: Pilatus wunderte sich sehr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36c96325-bc92-43a8-8e77-8c773412bcc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo, Aria & Recitativo: WIe sie nun an die Städte', part.name_en = 'Brockes Passion: Pars IV: Recitativo, Aria & Recitativo: WIe sie nun an die Städte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3ba5e035-5988-40a0-8577-d2e9da724e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba5e035-5988-40a0-8577-d2e9da724e7a', 17, NULL, 'Pars IV: Recitativo, Aria & Recitativo: WIe sie nun an die Städte', 'Brockes Passion: Pars IV: Recitativo, Aria & Recitativo: WIe sie nun an die Städte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba5e035-5988-40a0-8577-d2e9da724e7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo & COro: Wie nun Pilatus Jesum fragt', part.name_en = 'Brockes Passion: Pars III: Recitativo & COro: Wie nun Pilatus Jesum fragt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3e44df32-3ea0-42e2-8dce-8ec360b421b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e44df32-3ea0-42e2-8dce-8ec360b421b6', 18, NULL, 'Pars III: Recitativo & COro: Wie nun Pilatus Jesum fragt', 'Brockes Passion: Pars III: Recitativo & COro: Wie nun Pilatus Jesum fragt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e44df32-3ea0-42e2-8dce-8ec360b421b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria & Recitativo: Laß doch diese herben Schmertzen', part.name_en = 'Brockes Passion: Pars III: Aria & Recitativo: Laß doch diese herben Schmertzen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3eec72d7-d84a-402e-82a0-95dd46fffdf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eec72d7-d84a-402e-82a0-95dd46fffdf6', 19, NULL, 'Pars III: Aria & Recitativo: Laß doch diese herben Schmertzen', 'Brockes Passion: Pars III: Aria & Recitativo: Laß doch diese herben Schmertzen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eec72d7-d84a-402e-82a0-95dd46fffdf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo & Aria: Und er trug', part.name_en = 'Brockes Passion: Pars IV: Recitativo & Aria: Und er trug',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3f7bc80a-b562-46e4-bddc-f42d12810686' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f7bc80a-b562-46e4-bddc-f42d12810686', 20, NULL, 'Pars IV: Recitativo & Aria: Und er trug', 'Brockes Passion: Pars IV: Recitativo & Aria: Und er trug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f7bc80a-b562-46e4-bddc-f42d12810686'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo et Accompagnato: Und bald hernach nahm er den Kelch', part.name_en = 'Brockes Passion: Pars I: Recitativo et Accompagnato: Und bald hernach nahm er den Kelch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4b07fbbf-eddf-4e90-a8c1-b55eb925c16e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b07fbbf-eddf-4e90-a8c1-b55eb925c16e', 21, NULL, 'Pars I: Recitativo et Accompagnato: Und bald hernach nahm er den Kelch', 'Brockes Passion: Pars I: Recitativo et Accompagnato: Und bald hernach nahm er den Kelch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b07fbbf-eddf-4e90-a8c1-b55eb925c16e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Brockes Passion: Pars III: Aria Senz''Oboi: Sprichst du denn auf diß Verklagen', part.name_en = 'Brockes Passion: Brockes Passion: Pars III: Aria Senz''Oboi: Sprichst du denn auf diß Verklagen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4d665167-7c75-44ac-a24c-4e7b4a8f70d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d665167-7c75-44ac-a24c-4e7b4a8f70d7', 22, NULL, 'Brockes Passion: Pars III: Aria Senz''Oboi: Sprichst du denn auf diß Verklagen', 'Brockes Passion: Brockes Passion: Pars III: Aria Senz''Oboi: Sprichst du denn auf diß Verklagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d665167-7c75-44ac-a24c-4e7b4a8f70d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Pars II: Chorale: Hertzliebster Jesu, was hast du verbrochen', part.name_en = 'Brockes Passion: Pars II: Chorale: Hertzliebster Jesu, was hast du verbrochen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:522103de-aff5-458f-8153-628f64aff750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522103de-aff5-458f-8153-628f64aff750', 23, NULL, 'Pars II: Chorale: Hertzliebster Jesu, was hast du verbrochen', 'Brockes Passion: Pars II: Chorale: Hertzliebster Jesu, was hast du verbrochen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522103de-aff5-458f-8153-628f64aff750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Chorale: O Menschenkind, nur deine Sünd', part.name_en = 'Brockes Passion: Pars IV: Chorale: O Menschenkind, nur deine Sünd',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:524fbb82-99b5-48eb-9b4c-8ec9ac871dc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:524fbb82-99b5-48eb-9b4c-8ec9ac871dc0', 24, NULL, 'Pars IV: Chorale: O Menschenkind, nur deine Sünd', 'Brockes Passion: Pars IV: Chorale: O Menschenkind, nur deine Sünd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524fbb82-99b5-48eb-9b4c-8ec9ac871dc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo & Coro: Drauf beugten sie aus Spott vor Ihm die Knie', part.name_en = 'Brockes Passion: Pars III: Recitativo & Coro: Drauf beugten sie aus Spott vor Ihm die Knie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5409cc2d-9828-4f7a-a46e-0d8c2771f304' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5409cc2d-9828-4f7a-a46e-0d8c2771f304', 25, NULL, 'Pars III: Recitativo & Coro: Drauf beugten sie aus Spott vor Ihm die Knie', 'Brockes Passion: Pars III: Recitativo & Coro: Drauf beugten sie aus Spott vor Ihm die Knie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5409cc2d-9828-4f7a-a46e-0d8c2771f304'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Pars I: Coro: Mich vom Stricken meiner Sünden', part.name_en = 'Brockes Passion: Pars I: Coro: Mich vom Stricken meiner Sünden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5739c61c-926a-480a-8cfa-3e3771382bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5739c61c-926a-480a-8cfa-3e3771382bde', 26, NULL, 'Pars I: Coro: Mich vom Stricken meiner Sünden', 'Brockes Passion: Pars I: Coro: Mich vom Stricken meiner Sünden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5739c61c-926a-480a-8cfa-3e3771382bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria: Die ihr Gottes Gnad versäumet', part.name_en = 'Brockes Passion: Pars III: Aria: Die ihr Gottes Gnad versäumet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:57a4e346-9bab-45f8-9686-df2688e18aeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57a4e346-9bab-45f8-9686-df2688e18aeb', 27, NULL, 'Pars III: Aria: Die ihr Gottes Gnad versäumet', 'Brockes Passion: Pars III: Aria: Die ihr Gottes Gnad versäumet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57a4e346-9bab-45f8-9686-df2688e18aeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Aria: Wie kömmt''s, daß da der Himmel weint', part.name_en = 'Brockes Passion: Pars IV: Aria: Wie kömmt''s, daß da der Himmel weint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5936837b-e79b-43bb-bb53-209e7d06a6a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5936837b-e79b-43bb-bb53-209e7d06a6a0', 28, NULL, 'Pars IV: Aria: Wie kömmt''s, daß da der Himmel weint', 'Brockes Passion: Pars IV: Aria: Wie kömmt''s, daß da der Himmel weint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5936837b-e79b-43bb-bb53-209e7d06a6a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Chorale: Ich bin ein Glied an deinem Leib', part.name_en = 'Brockes Passion: Pars IV: Chorale: Ich bin ein Glied an deinem Leib',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6880c44c-ae14-4640-b210-0cd3150e4ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6880c44c-ae14-4640-b210-0cd3150e4ea8', 29, NULL, 'Pars IV: Chorale: Ich bin ein Glied an deinem Leib', 'Brockes Passion: Pars IV: Chorale: Ich bin ein Glied an deinem Leib', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6880c44c-ae14-4640-b210-0cd3150e4ea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo & Accompagnato: Diß war zur neundten Stund', part.name_en = 'Brockes Passion: Pars IV: Recitativo & Accompagnato: Diß war zur neundten Stund',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6a136340-ee2a-40a6-a214-be001bc843fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a136340-ee2a-40a6-a214-be001bc843fe', 30, NULL, 'Pars IV: Recitativo & Accompagnato: Diß war zur neundten Stund', 'Brockes Passion: Pars IV: Recitativo & Accompagnato: Diß war zur neundten Stund', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a136340-ee2a-40a6-a214-be001bc843fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Pars II: Recitativo et Chor: Als Jesus nun, wie hart man ihn verklagte', part.name_en = 'Brockes Passion: Pars II: Recitativo et Chor: Als Jesus nun, wie hart man ihn verklagte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:75fda441-3217-4073-b6fb-787b4fe583de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75fda441-3217-4073-b6fb-787b4fe583de', 31, NULL, 'Pars II: Recitativo et Chor: Als Jesus nun, wie hart man ihn verklagte', 'Brockes Passion: Pars II: Recitativo et Chor: Als Jesus nun, wie hart man ihn verklagte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75fda441-3217-4073-b6fb-787b4fe583de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo et Aria: Die Nacht war kaum vorbay', part.name_en = 'Brockes Passion: Pars III: Recitativo et Aria: Die Nacht war kaum vorbay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7e9ba5cd-260b-4184-a4ce-47fc1ffec585' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e9ba5cd-260b-4184-a4ce-47fc1ffec585', 32, NULL, 'Pars III: Recitativo et Aria: Die Nacht war kaum vorbay', 'Brockes Passion: Pars III: Recitativo et Aria: Die Nacht war kaum vorbay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e9ba5cd-260b-4184-a4ce-47fc1ffec585'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Chorale: Mein Sünd mich werden kräncken sehr', part.name_en = 'Brockes Passion: Pars IV: Chorale: Mein Sünd mich werden kräncken sehr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:837002bb-0256-42e6-9fa5-9f5a3443d112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:837002bb-0256-42e6-9fa5-9f5a3443d112', 33, NULL, 'Pars IV: Chorale: Mein Sünd mich werden kräncken sehr', 'Brockes Passion: Pars IV: Chorale: Mein Sünd mich werden kräncken sehr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837002bb-0256-42e6-9fa5-9f5a3443d112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Pars I: Chorale: Ach, wie hungert mein Gemüthe"', part.name_en = 'Brockes Passion: Pars I: Chorale: Ach, wie hungert mein Gemüthe"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:878efd2e-9cea-4d9d-9bc6-ce8e4187d747' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:878efd2e-9cea-4d9d-9bc6-ce8e4187d747', 34, NULL, 'Pars I: Chorale: Ach, wie hungert mein Gemüthe"', 'Brockes Passion: Pars I: Chorale: Ach, wie hungert mein Gemüthe"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:878efd2e-9cea-4d9d-9bc6-ce8e4187d747'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Pars I: Aria: Gifft und Gluth, Strahl und Fluth', part.name_en = 'Brockes Passion: Pars I: Aria: Gifft und Gluth, Strahl und Fluth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:894b6601-09cd-45bf-bfeb-50d11047b893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894b6601-09cd-45bf-bfeb-50d11047b893', 35, NULL, 'Pars I: Aria: Gifft und Gluth, Strahl und Fluth', 'Brockes Passion: Pars I: Aria: Gifft und Gluth, Strahl und Fluth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894b6601-09cd-45bf-bfeb-50d11047b893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo et Accompagnato: Als Jesus nun zu Tische saße', part.name_en = 'Brockes Passion: Pars I: Recitativo et Accompagnato: Als Jesus nun zu Tische saße',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9362dd8e-34a5-47f9-8a29-4922007d6eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9362dd8e-34a5-47f9-8a29-4922007d6eeb', 36, NULL, 'Pars I: Recitativo et Accompagnato: Als Jesus nun zu Tische saße', 'Brockes Passion: Pars I: Recitativo et Accompagnato: Als Jesus nun zu Tische saße', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9362dd8e-34a5-47f9-8a29-4922007d6eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Coro & Recitativo: O DOnnerwort, O seelig, wer diß glaubt', part.name_en = 'Brockes Passion: Pars IV: Coro & Recitativo: O DOnnerwort, O seelig, wer diß glaubt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:94ff0a2c-c5f0-40f9-8899-8c9f2a806656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ff0a2c-c5f0-40f9-8899-8c9f2a806656', 37, NULL, 'Pars IV: Coro & Recitativo: O DOnnerwort, O seelig, wer diß glaubt', 'Brockes Passion: Pars IV: Coro & Recitativo: O DOnnerwort, O seelig, wer diß glaubt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ff0a2c-c5f0-40f9-8899-8c9f2a806656'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Coro à 5: Bey Jesu Todt und Leben leidet', part.name_en = 'Brockes Passion: Pars IV: Coro à 5: Bey Jesu Todt und Leben leidet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9969fc54-2f92-4d67-a032-8d9ffcd012c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9969fc54-2f92-4d67-a032-8d9ffcd012c5', 38, NULL, 'Pars IV: Coro à 5: Bey Jesu Todt und Leben leidet', 'Brockes Passion: Pars IV: Coro à 5: Bey Jesu Todt und Leben leidet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9969fc54-2f92-4d67-a032-8d9ffcd012c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Pars I: Coro: O Weh! sie binden ihn', part.name_en = 'Brockes Passion: Pars I: Coro: O Weh! sie binden ihn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:99a2216d-aa89-435d-8b0c-5aafd4c52933' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a2216d-aa89-435d-8b0c-5aafd4c52933', 39, NULL, 'Pars I: Coro: O Weh! sie binden ihn', 'Brockes Passion: Pars I: Coro: O Weh! sie binden ihn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a2216d-aa89-435d-8b0c-5aafd4c52933'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Pars II: Aria: Schau, ich fall in strenger Buße', part.name_en = 'Brockes Passion: Pars II: Aria: Schau, ich fall in strenger Buße',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9fd07a78-77d9-4aa8-a751-d3a12404dffc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fd07a78-77d9-4aa8-a751-d3a12404dffc', 40, NULL, 'Pars II: Aria: Schau, ich fall in strenger Buße', 'Brockes Passion: Pars II: Aria: Schau, ich fall in strenger Buße', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fd07a78-77d9-4aa8-a751-d3a12404dffc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria & Recitativo: Die Rosen krönen sonst', part.name_en = 'Brockes Passion: Pars III: Aria & Recitativo: Die Rosen krönen sonst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a9b90243-ab99-4061-ad64-72fbbb6175ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9b90243-ab99-4061-ad64-72fbbb6175ee', 41, NULL, 'Pars III: Aria & Recitativo: Die Rosen krönen sonst', 'Brockes Passion: Pars III: Aria & Recitativo: Die Rosen krönen sonst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b90243-ab99-4061-ad64-72fbbb6175ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Aria: Was Wunder, daß der Sonnen Pracht', part.name_en = 'Brockes Passion: Pars IV: Aria: Was Wunder, daß der Sonnen Pracht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ac81440a-1f9d-405d-8439-1e58846df3c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac81440a-1f9d-405d-8439-1e58846df3c4', 42, NULL, 'Pars IV: Aria: Was Wunder, daß der Sonnen Pracht', 'Brockes Passion: Pars IV: Aria: Was Wunder, daß der Sonnen Pracht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac81440a-1f9d-405d-8439-1e58846df3c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo: Steck nur das Schwerdt an seinen Ort', part.name_en = 'Brockes Passion: Pars I: Recitativo: Steck nur das Schwerdt an seinen Ort',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b9c6c041-4af7-43bc-a306-332d1aa84b52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9c6c041-4af7-43bc-a306-332d1aa84b52', 43, NULL, 'Pars I: Recitativo: Steck nur das Schwerdt an seinen Ort', 'Brockes Passion: Pars I: Recitativo: Steck nur das Schwerdt an seinen Ort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9c6c041-4af7-43bc-a306-332d1aa84b52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Pars III: Recitativo: Drauf zerreten die Kriegsknecht Ihn herein', part.name_en = 'Brockes Passion: Pars III: Recitativo: Drauf zerreten die Kriegsknecht Ihn herein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:bf6b8028-3dd6-40ba-9c78-6caa12a77173' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf6b8028-3dd6-40ba-9c78-6caa12a77173', 44, NULL, 'Pars III: Recitativo: Drauf zerreten die Kriegsknecht Ihn herein', 'Brockes Passion: Pars III: Recitativo: Drauf zerreten die Kriegsknecht Ihn herein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf6b8028-3dd6-40ba-9c78-6caa12a77173'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Arioso & Recitativo: Sind meiner Seele tiefe Wunden', part.name_en = 'Brockes Passion: Pars IV: Arioso & Recitativo: Sind meiner Seele tiefe Wunden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c3d22cad-36b5-409c-af6d-2f910daf67c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3d22cad-36b5-409c-af6d-2f910daf67c7', 45, NULL, 'Pars IV: Arioso & Recitativo: Sind meiner Seele tiefe Wunden', 'Brockes Passion: Pars IV: Arioso & Recitativo: Sind meiner Seele tiefe Wunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3d22cad-36b5-409c-af6d-2f910daf67c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Arioso: Mein Heyland, Herr und Fürst', part.name_en = 'Brockes Passion: Pars IV: Arioso: Mein Heyland, Herr und Fürst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:cda47586-8d39-4254-93e5-8aa53fbc884f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda47586-8d39-4254-93e5-8aa53fbc884f', 46, NULL, 'Pars IV: Arioso: Mein Heyland, Herr und Fürst', 'Brockes Passion: Pars IV: Arioso: Mein Heyland, Herr und Fürst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda47586-8d39-4254-93e5-8aa53fbc884f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Pars III: Accompagnato & Aria: Besinne dich, Pilatus', part.name_en = 'Brockes Passion: Pars III: Accompagnato & Aria: Besinne dich, Pilatus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d0b860cf-49dd-428d-a121-b3e5037e2a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0b860cf-49dd-428d-a121-b3e5037e2a0b', 47, NULL, 'Pars III: Accompagnato & Aria: Besinne dich, Pilatus', 'Brockes Passion: Pars III: Accompagnato & Aria: Besinne dich, Pilatus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0b860cf-49dd-428d-a121-b3e5037e2a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo et Accompagnato: Drauf sagten sie dem Höchsten Danck', part.name_en = 'Brockes Passion: Pars I: Recitativo et Accompagnato: Drauf sagten sie dem Höchsten Danck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d144026d-36dc-4bed-8555-6d70f93e325a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d144026d-36dc-4bed-8555-6d70f93e325a', 48, NULL, 'Pars I: Recitativo et Accompagnato: Drauf sagten sie dem Höchsten Danck', 'Brockes Passion: Pars I: Recitativo et Accompagnato: Drauf sagten sie dem Höchsten Danck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d144026d-36dc-4bed-8555-6d70f93e325a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Pars II: Aria: Erweg, ergrimmte Nattern-Bruth', part.name_en = 'Brockes Passion: Pars II: Aria: Erweg, ergrimmte Nattern-Bruth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d347d6f7-0293-4b7e-b28c-4143c0eda092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d347d6f7-0293-4b7e-b28c-4143c0eda092', 49, NULL, 'Pars II: Aria: Erweg, ergrimmte Nattern-Bruth', 'Brockes Passion: Pars II: Aria: Erweg, ergrimmte Nattern-Bruth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d347d6f7-0293-4b7e-b28c-4143c0eda092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Pars III: Aria: Schäumest du, du Schaum der Welt', part.name_en = 'Brockes Passion: Pars III: Aria: Schäumest du, du Schaum der Welt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:db28640a-0ada-409b-ac06-f1c37cfa116b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db28640a-0ada-409b-ac06-f1c37cfa116b', 50, NULL, 'Pars III: Aria: Schäumest du, du Schaum der Welt', 'Brockes Passion: Pars III: Aria: Schäumest du, du Schaum der Welt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db28640a-0ada-409b-ac06-f1c37cfa116b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Pars I: Arioso: Sünder, schaut mit Furcht und Zagen', part.name_en = 'Brockes Passion: Pars I: Arioso: Sünder, schaut mit Furcht und Zagen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:dfd80b3f-5ebe-485c-8411-a25d10997dfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfd80b3f-5ebe-485c-8411-a25d10997dfe', 51, NULL, 'Pars I: Arioso: Sünder, schaut mit Furcht und Zagen', 'Brockes Passion: Pars I: Arioso: Sünder, schaut mit Furcht und Zagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfd80b3f-5ebe-485c-8411-a25d10997dfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo, Coro & Recitativo: Sobald er nun gecreüzigt war - Pfui, seht mir doch', part.name_en = 'Brockes Passion: Pars IV: Recitativo, Coro & Recitativo: Sobald er nun gecreüzigt war - Pfui, seht mir doch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e0825dc2-fab2-4aa7-95df-8f72505a746f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0825dc2-fab2-4aa7-95df-8f72505a746f', 52, NULL, 'Pars IV: Recitativo, Coro & Recitativo: Sobald er nun gecreüzigt war - Pfui, seht mir doch', 'Brockes Passion: Pars IV: Recitativo, Coro & Recitativo: Sobald er nun gecreüzigt war - Pfui, seht mir doch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0825dc2-fab2-4aa7-95df-8f72505a746f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Recitativo: Drauf lief ein Krigsknecht', part.name_en = 'Brockes Passion: Pars IV: Recitativo: Drauf lief ein Krigsknecht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e3e29502-bfc2-47da-b642-e9b319d6cace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3e29502-bfc2-47da-b642-e9b319d6cace', 53, NULL, 'Pars IV: Recitativo: Drauf lief ein Krigsknecht', 'Brockes Passion: Pars IV: Recitativo: Drauf lief ein Krigsknecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3e29502-bfc2-47da-b642-e9b319d6cace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Pars I: Aria: Brich, mein Hertz, zerffließ in Thränen', part.name_en = 'Brockes Passion: Pars I: Aria: Brich, mein Hertz, zerffließ in Thränen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e504fb29-8ec5-420d-8527-0df0c655cd12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e504fb29-8ec5-420d-8527-0df0c655cd12', 54, NULL, 'Pars I: Aria: Brich, mein Hertz, zerffließ in Thränen', 'Brockes Passion: Pars I: Aria: Brich, mein Hertz, zerffließ in Thränen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e504fb29-8ec5-420d-8527-0df0c655cd12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Pars I: Chorale: Ich will hie bey dir stehen', part.name_en = 'Brockes Passion: Pars I: Chorale: Ich will hie bey dir stehen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:eb46de60-22bd-4ebe-b4e0-25fc140d4924' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb46de60-22bd-4ebe-b4e0-25fc140d4924', 55, NULL, 'Pars I: Chorale: Ich will hie bey dir stehen', 'Brockes Passion: Pars I: Chorale: Ich will hie bey dir stehen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb46de60-22bd-4ebe-b4e0-25fc140d4924'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo, Arioso, et Coro: Ein Engel aber kam', part.name_en = 'Brockes Passion: Pars I: Recitativo, Arioso, et Coro: Ein Engel aber kam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f47bec24-c0ef-4387-84c2-66fe3c16deb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f47bec24-c0ef-4387-84c2-66fe3c16deb9', 56, NULL, 'Pars I: Recitativo, Arioso, et Coro: Ein Engel aber kam', 'Brockes Passion: Pars I: Recitativo, Arioso, et Coro: Ein Engel aber kam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f47bec24-c0ef-4387-84c2-66fe3c16deb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Pars IV: Aria & Accompagnato: Brich, brüllender Abgrund', part.name_en = 'Brockes Passion: Pars IV: Aria & Accompagnato: Brich, brüllender Abgrund',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f6f4cf18-ffd6-4d8c-b8fc-f5f812cd5f32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f4cf18-ffd6-4d8c-b8fc-f5f812cd5f32', 57, NULL, 'Pars IV: Aria & Accompagnato: Brich, brüllender Abgrund', 'Brockes Passion: Pars IV: Aria & Accompagnato: Brich, brüllender Abgrund', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f4cf18-ffd6-4d8c-b8fc-f5f812cd5f32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Pars II: Recitativo: Dieß sahe Petrus an', part.name_en = 'Brockes Passion: Pars II: Recitativo: Dieß sahe Petrus an',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f803eb35-88e8-4fe7-bfdd-f22353d8cf43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f803eb35-88e8-4fe7-bfdd-f22353d8cf43', 58, NULL, 'Pars II: Recitativo: Dieß sahe Petrus an', 'Brockes Passion: Pars II: Recitativo: Dieß sahe Petrus an', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f803eb35-88e8-4fe7-bfdd-f22353d8cf43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 59, part.movement_number = NULL,
    part.name_ko = 'Pars II: Recitativo: Und Jesus ward zum Pallsat Caiphas', part.name_en = 'Brockes Passion: Pars II: Recitativo: Und Jesus ward zum Pallsat Caiphas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fc8b6442-bcd6-4d66-8420-173e30523ba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc8b6442-bcd6-4d66-8420-173e30523ba6', 59, NULL, 'Pars II: Recitativo: Und Jesus ward zum Pallsat Caiphas', 'Brockes Passion: Pars II: Recitativo: Und Jesus ward zum Pallsat Caiphas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc8b6442-bcd6-4d66-8420-173e30523ba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 60, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo: Die Pein vermehrte sich', part.name_en = 'Brockes Passion: Pars I: Recitativo: Die Pein vermehrte sich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fd20807d-8a29-489e-a0fd-9f126c22fd0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd20807d-8a29-489e-a0fd-9f126c22fd0f', 60, NULL, 'Pars I: Recitativo: Die Pein vermehrte sich', 'Brockes Passion: Pars I: Recitativo: Die Pein vermehrte sich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd20807d-8a29-489e-a0fd-9f126c22fd0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 61, part.movement_number = NULL,
    part.name_ko = 'Pars I: Recitativo et Aria: Wo flieht ihr ihn', part.name_en = 'Brockes Passion: Pars I: Recitativo et Aria: Wo flieht ihr ihn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fde98b37-03c6-4cf1-884d-a1a81e3fcdda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fde98b37-03c6-4cf1-884d-a1a81e3fcdda', 61, NULL, 'Pars I: Recitativo et Aria: Wo flieht ihr ihn', 'Brockes Passion: Pars I: Recitativo et Aria: Wo flieht ihr ihn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde98b37-03c6-4cf1-884d-a1a81e3fcdda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 62, part.movement_number = NULL,
    part.name_ko = 'Pars II: Aria: Was Bähren-tanzen, Löwen-klauen', part.name_en = 'Brockes Passion: Pars II: Aria: Was Bähren-tanzen, Löwen-klauen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25137 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ff449ec7-f176-4b67-a965-04c180d8c745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff449ec7-f176-4b67-a965-04c180d8c745', 62, NULL, 'Pars II: Aria: Was Bähren-tanzen, Löwen-klauen', 'Brockes Passion: Pars II: Aria: Was Bähren-tanzen, Löwen-klauen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25137 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff449ec7-f176-4b67-a965-04c180d8c745'
);


-- None Concerto grosso a quattro Chori

UPDATE pieces piece
SET piece.title = 'Concerto grosso a quattro Chori', piece.title_en = 'Concerto grosso a quattro Chori',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25189 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto grosso a quattro Chori: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25189 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:54f6fa40-51e6-4184-839d-f038e84f1d66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f6fa40-51e6-4184-839d-f038e84f1d66', 1, 'I', 'Allegro', 'Concerto grosso a quattro Chori: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25189 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f6fa40-51e6-4184-839d-f038e84f1d66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concerto grosso a quattro Chori: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25189 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8bde1ce3-d30b-49d8-ad73-e709836c8ea0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bde1ce3-d30b-49d8-ad73-e709836c8ea0', 2, 'II', 'Adagio', 'Concerto grosso a quattro Chori: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25189 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bde1ce3-d30b-49d8-ad73-e709836c8ea0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Concerto grosso a quattro Chori: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25189 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a2b61c33-2597-4e14-8d96-1b1f6b430d25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2b61c33-2597-4e14-8d96-1b1f6b430d25', 3, 'III', 'Vivace', 'Concerto grosso a quattro Chori: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25189 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2b61c33-2597-4e14-8d96-1b1f6b430d25'
);


-- None 칸타타 <Danksaget dem Vater, der uns tüchtig gemacht hat>

UPDATE pieces piece
SET piece.title = '칸타타 <Danksaget dem Vater, der uns tüchtig gemacht hat>', piece.title_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25077 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Aus Heiden Christen werden', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: II. Aus Heiden Christen werden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0e107036-5ee4-4257-bb35-17892a9c798a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e107036-5ee4-4257-bb35-17892a9c798a', 1, 'II', 'Aus Heiden Christen werden', 'Danksaget dem Vater, der uns tüchtig gemacht hat: II. Aus Heiden Christen werden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e107036-5ee4-4257-bb35-17892a9c798a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Unechtes Bild des Christentums', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: III. Unechtes Bild des Christentums',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:376faf0e-318e-480d-a4d3-a549b4e82114' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:376faf0e-318e-480d-a4d3-a549b4e82114', 2, 'III', 'Unechtes Bild des Christentums', 'Danksaget dem Vater, der uns tüchtig gemacht hat: III. Unechtes Bild des Christentums', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:376faf0e-318e-480d-a4d3-a549b4e82114'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VI',
    part.name_ko = 'Das ewige Licht geht da herein (Chorale)', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: VI. Das ewige Licht geht da herein (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a6863b51-89c4-4c2c-bcc9-70ceda8100fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6863b51-89c4-4c2c-bcc9-70ceda8100fd', 3, 'VI', 'Das ewige Licht geht da herein (Chorale)', 'Danksaget dem Vater, der uns tüchtig gemacht hat: VI. Das ewige Licht geht da herein (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6863b51-89c4-4c2c-bcc9-70ceda8100fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Gott Lob! Nun seh ich mich verkläret', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: V. Gott Lob! Nun seh ich mich verkläret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c2329305-d82e-4aa6-8a6e-11d089b96fcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2329305-d82e-4aa6-8a6e-11d089b96fcf', 4, 'V', 'Gott Lob! Nun seh ich mich verkläret', 'Danksaget dem Vater, der uns tüchtig gemacht hat: V. Gott Lob! Nun seh ich mich verkläret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2329305-d82e-4aa6-8a6e-11d089b96fcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Danksaget dem Vater, der uns tüchtig gemacht hat (Tutti)', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: I. Danksaget dem Vater, der uns tüchtig gemacht hat (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:cd32fba4-8e5b-4ab2-a775-d8ad1daa3052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd32fba4-8e5b-4ab2-a775-d8ad1daa3052', 5, 'I', 'Danksaget dem Vater, der uns tüchtig gemacht hat (Tutti)', 'Danksaget dem Vater, der uns tüchtig gemacht hat: I. Danksaget dem Vater, der uns tüchtig gemacht hat (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd32fba4-8e5b-4ab2-a775-d8ad1daa3052'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'IV',
    part.name_ko = 'Steh auf und werde Licht', part.name_en = 'Danksaget dem Vater, der uns tüchtig gemacht hat: IV. Steh auf und werde Licht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25077 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f01ac8bd-99b0-4917-ab42-54226b82bf29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f01ac8bd-99b0-4917-ab42-54226b82bf29', 6, 'IV', 'Steh auf und werde Licht', 'Danksaget dem Vater, der uns tüchtig gemacht hat: IV. Steh auf und werde Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25077 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f01ac8bd-99b0-4917-ab42-54226b82bf29'
);


-- H. 150 칸타타 <Daran ist erschienen die Liebe Gottes gegen uns>

UPDATE pieces piece
SET piece.title = '칸타타 <Daran ist erschienen die Liebe Gottes gegen uns>', piece.title_en = 'Daran ist erschienen die Liebe Gottes gegen uns, H. 150',
    piece.type = 'album', piece.opus_number = 'H. 150',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24015 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Daran ist erschienen.. (Coro à 4)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: I. Daran ist erschienen.. (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:34b09c6d-9868-4952-b521-d347cfb9ab5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34b09c6d-9868-4952-b521-d347cfb9ab5f', 1, 'I', 'Daran ist erschienen.. (Coro à 4)', 'Daran ist erschienen die Liebe Gottes gegen uns: I. Daran ist erschienen.. (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34b09c6d-9868-4952-b521-d347cfb9ab5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Also hat Gott geliebet (Recit à 4)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: II. Also hat Gott geliebet (Recit à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2814fd3d-2782-4e4c-9efb-d46b378eba1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2814fd3d-2782-4e4c-9efb-d46b378eba1c', 2, 'II', 'Also hat Gott geliebet (Recit à 4)', 'Daran ist erschienen die Liebe Gottes gegen uns: II. Also hat Gott geliebet (Recit à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2814fd3d-2782-4e4c-9efb-d46b378eba1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mein Geist verlieret sich im Denken (Aria Soprano)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: III. Mein Geist verlieret sich im Denken (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8e60abae-84df-4687-af40-94f2fdca7676' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e60abae-84df-4687-af40-94f2fdca7676', 3, 'III', 'Mein Geist verlieret sich im Denken (Aria Soprano)', 'Daran ist erschienen die Liebe Gottes gegen uns: III. Mein Geist verlieret sich im Denken (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e60abae-84df-4687-af40-94f2fdca7676'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dass keinen nun der Trost aus dieser Lieb entfalle (Recit. Alto)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: IV. Dass keinen nun der Trost aus dieser Lieb entfalle (Recit. Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a3266d38-64fd-42e0-9167-e5d713f3ee86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3266d38-64fd-42e0-9167-e5d713f3ee86', 4, 'IV', 'Dass keinen nun der Trost aus dieser Lieb entfalle (Recit. Alto)', 'Daran ist erschienen die Liebe Gottes gegen uns: IV. Dass keinen nun der Trost aus dieser Lieb entfalle (Recit. Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3266d38-64fd-42e0-9167-e5d713f3ee86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Wundervolle Liebesproben (Aria Alto)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: V. Wundervolle Liebesproben (Aria Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c975ac78-8ebb-4a68-88a9-41f63a899ae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c975ac78-8ebb-4a68-88a9-41f63a899ae9', 5, 'V', 'Wundervolle Liebesproben (Aria Alto)', 'Daran ist erschienen die Liebe Gottes gegen uns: V. Wundervolle Liebesproben (Aria Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c975ac78-8ebb-4a68-88a9-41f63a899ae9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Preis, Ehr und Lob dem höchsten Gott (Chorale)', part.name_en = 'Daran ist erschienen die Liebe Gottes gegen uns: VI. Preis, Ehr und Lob dem höchsten Gott (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24015 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2791818e-f7ee-4846-8a26-3b001f6d42a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2791818e-f7ee-4846-8a26-3b001f6d42a0', 6, 'VI', 'Preis, Ehr und Lob dem höchsten Gott (Chorale)', 'Daran ist erschienen die Liebe Gottes gegen uns: VI. Preis, Ehr und Lob dem höchsten Gott (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24015 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2791818e-f7ee-4846-8a26-3b001f6d42a0'
);


-- H. 44 칸타타 <Das Alte ist vergangen>

UPDATE pieces piece
SET piece.title = '칸타타 <Das Alte ist vergangen>', piece.title_en = 'Das Alte ist vergangen, H. 44',
    piece.type = 'album', piece.opus_number = 'H. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25759 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Die Sehnsucht Zions ist gestillt', part.name_en = 'Das Alte ist vergangen: II. Die Sehnsucht Zions ist gestillt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25759 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:26400e9f-1f9c-4b5f-9d5d-8d8f5747c739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26400e9f-1f9c-4b5f-9d5d-8d8f5747c739', 1, 'II', 'Die Sehnsucht Zions ist gestillt', 'Das Alte ist vergangen: II. Die Sehnsucht Zions ist gestillt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25759 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26400e9f-1f9c-4b5f-9d5d-8d8f5747c739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Bald wird der Sonnen Umlauf wieder', part.name_en = 'Das Alte ist vergangen: IV. Bald wird der Sonnen Umlauf wieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25759 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9083f485-832a-4f10-9b69-bb26b4d851c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9083f485-832a-4f10-9b69-bb26b4d851c1', 2, 'IV', 'Bald wird der Sonnen Umlauf wieder', 'Das Alte ist vergangen: IV. Bald wird der Sonnen Umlauf wieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25759 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9083f485-832a-4f10-9b69-bb26b4d851c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Das Alte ist vergangen (Tutti & Aria)', part.name_en = 'Das Alte ist vergangen: I. Das Alte ist vergangen (Tutti & Aria)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25759 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:bb5f23f9-5258-4564-977e-17c6f2a2bacf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb5f23f9-5258-4564-977e-17c6f2a2bacf', 3, 'I', 'Das Alte ist vergangen (Tutti & Aria)', 'Das Alte ist vergangen: I. Das Alte ist vergangen (Tutti & Aria)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25759 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb5f23f9-5258-4564-977e-17c6f2a2bacf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'So wechseln Zeit und Stunden', part.name_en = 'Das Alte ist vergangen: III. So wechseln Zeit und Stunden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25759 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f04e0524-274f-473b-99b8-4a0350604905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f04e0524-274f-473b-99b8-4a0350604905', 4, 'III', 'So wechseln Zeit und Stunden', 'Das Alte ist vergangen: III. So wechseln Zeit und Stunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25759 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f04e0524-274f-473b-99b8-4a0350604905'
);


-- H. 45 칸타타 <Das Ende eines Dinges ist besser denn sein Anfang>

UPDATE pieces piece
SET piece.title = '칸타타 <Das Ende eines Dinges ist besser denn sein Anfang>', piece.title_en = 'Das Ende eines Dinges ist besser denn sein Anfang, H. 45',
    piece.type = 'album', piece.opus_number = 'H. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23782 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Drum mach ich so den Jahresschluß', part.name_en = 'Das Ende eines Dinges ist besser denn sein Anfang: IV. Drum mach ich so den Jahresschluß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23782 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1687c12f-e797-49a5-8bdb-cd62ae6ad812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1687c12f-e797-49a5-8bdb-cd62ae6ad812', 1, 'IV', 'Drum mach ich so den Jahresschluß', 'Das Ende eines Dinges ist besser denn sein Anfang: IV. Drum mach ich so den Jahresschluß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23782 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1687c12f-e797-49a5-8bdb-cd62ae6ad812'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Verhüte, treuer Gott, in Gnaden', part.name_en = 'Das Ende eines Dinges ist besser denn sein Anfang: V. Verhüte, treuer Gott, in Gnaden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23782 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5bb59aa8-6d2d-44a2-8cde-e43be5249c6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bb59aa8-6d2d-44a2-8cde-e43be5249c6c', 2, 'V', 'Verhüte, treuer Gott, in Gnaden', 'Das Ende eines Dinges ist besser denn sein Anfang: V. Verhüte, treuer Gott, in Gnaden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23782 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb59aa8-6d2d-44a2-8cde-e43be5249c6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Das Ende eines Dinges ist besser denn sein Anfang (Tutti)', part.name_en = 'Das Ende eines Dinges ist besser denn sein Anfang: I. Das Ende eines Dinges ist besser denn sein Anfang (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23782 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c32ed3ae-b7da-4a53-9f70-c9d6e8a69c43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c32ed3ae-b7da-4a53-9f70-c9d6e8a69c43', 3, 'I', 'Das Ende eines Dinges ist besser denn sein Anfang (Tutti)', 'Das Ende eines Dinges ist besser denn sein Anfang: I. Das Ende eines Dinges ist besser denn sein Anfang (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23782 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c32ed3ae-b7da-4a53-9f70-c9d6e8a69c43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Anfang, Fortgang und das Ende', part.name_en = 'Das Ende eines Dinges ist besser denn sein Anfang: III. Anfang, Fortgang und das Ende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23782 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c3302c4e-0ac4-4ffb-b93e-a1ef1394c296' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3302c4e-0ac4-4ffb-b93e-a1ef1394c296', 4, 'III', 'Anfang, Fortgang und das Ende', 'Das Ende eines Dinges ist besser denn sein Anfang: III. Anfang, Fortgang und das Ende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23782 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3302c4e-0ac4-4ffb-b93e-a1ef1394c296'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Wenn Christi Eltern Wunders voll', part.name_en = 'Das Ende eines Dinges ist besser denn sein Anfang: II. Wenn Christi Eltern Wunders voll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23782 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d62b63c3-44e2-4048-81e7-a55937c58190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d62b63c3-44e2-4048-81e7-a55937c58190', 5, 'II', 'Wenn Christi Eltern Wunders voll', 'Das Ende eines Dinges ist besser denn sein Anfang: II. Wenn Christi Eltern Wunders voll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23782 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d62b63c3-44e2-4048-81e7-a55937c58190'
);


-- None 칸타타 <Der arme Sylvio, H. WK A 19>

UPDATE pieces piece
SET piece.title = '칸타타 <Der arme Sylvio, H. WK A 19>', piece.title_en = 'Der arme Sylvio, H. WK A 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24745 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Der arme Sylvio (Recit. Soprano)', part.name_en = 'Der arme Sylvio: I. Der arme Sylvio (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24745 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:63149cfd-dbea-4e24-94d7-633d0a3d35c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63149cfd-dbea-4e24-94d7-633d0a3d35c5', 1, 'I', 'Der arme Sylvio (Recit. Soprano)', 'Der arme Sylvio: I. Der arme Sylvio (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24745 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63149cfd-dbea-4e24-94d7-633d0a3d35c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ihr geliebten Augensonnen (Aria Tenor)', part.name_en = 'Der arme Sylvio: II. Ihr geliebten Augensonnen (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24745 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2893275a-7892-4a56-a5ef-c9817c309b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2893275a-7892-4a56-a5ef-c9817c309b12', 2, 'II', 'Ihr geliebten Augensonnen (Aria Tenor)', 'Der arme Sylvio: II. Ihr geliebten Augensonnen (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24745 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2893275a-7892-4a56-a5ef-c9817c309b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Hierauf erblickte er von ohngefahr (Recit. Soprano)', part.name_en = 'Der arme Sylvio: III. Hierauf erblickte er von ohngefahr (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24745 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c307f8a2-90bb-4cdb-a841-7fc82f4e7b1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c307f8a2-90bb-4cdb-a841-7fc82f4e7b1a', 3, 'III', 'Hierauf erblickte er von ohngefahr (Recit. Soprano)', 'Der arme Sylvio: III. Hierauf erblickte er von ohngefahr (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24745 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c307f8a2-90bb-4cdb-a841-7fc82f4e7b1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Es ist die Ursach meines Leidens (Aria Tenor)', part.name_en = 'Der arme Sylvio: IV. Es ist die Ursach meines Leidens (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24745 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c8a20819-a3b5-4e90-889c-9e94b4c8fd98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a20819-a3b5-4e90-889c-9e94b4c8fd98', 4, 'IV', 'Es ist die Ursach meines Leidens (Aria Tenor)', 'Der arme Sylvio: IV. Es ist die Ursach meines Leidens (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24745 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a20819-a3b5-4e90-889c-9e94b4c8fd98'
);


-- None 칸타타 <Die Grausame, doch schone Sylvia, H. WK A 13>

UPDATE pieces piece
SET piece.title = '칸타타 <Die Grausame, doch schone Sylvia, H. WK A 13>', piece.title_en = 'Die Grausame, doch schone Sylvia, H. WK A 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23941 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Die Grausame, doch schone Sylvia (Recit. Tenor)', part.name_en = 'Die Grausame, doch schone Sylvia: I. Die Grausame, doch schone Sylvia (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23941 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9eb53f6f-3714-4a14-aea8-c3d328d599ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eb53f6f-3714-4a14-aea8-c3d328d599ac', 1, 'I', 'Die Grausame, doch schone Sylvia (Recit. Tenor)', 'Die Grausame, doch schone Sylvia: I. Die Grausame, doch schone Sylvia (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23941 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb53f6f-3714-4a14-aea8-c3d328d599ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ich will es euch gern verzeihn (Aria Tenor)', part.name_en = 'Die Grausame, doch schone Sylvia: II. Ich will es euch gern verzeihn (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23941 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8396dbf1-1229-4159-a384-44332336b2ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8396dbf1-1229-4159-a384-44332336b2ad', 2, 'II', 'Ich will es euch gern verzeihn (Aria Tenor)', 'Die Grausame, doch schone Sylvia: II. Ich will es euch gern verzeihn (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23941 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8396dbf1-1229-4159-a384-44332336b2ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ich hab es, allerliebste (Recit. Soprano)', part.name_en = 'Die Grausame, doch schone Sylvia: III. Ich hab es, allerliebste (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23941 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:55ffacf7-2788-498a-88f8-15ba070b4889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ffacf7-2788-498a-88f8-15ba070b4889', 3, 'III', 'Ich hab es, allerliebste (Recit. Soprano)', 'Die Grausame, doch schone Sylvia: III. Ich hab es, allerliebste (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23941 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ffacf7-2788-498a-88f8-15ba070b4889'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fliehet, ihr gluckselgen Bienen (Aria Soprano)', part.name_en = 'Die Grausame, doch schone Sylvia: IV. Fliehet, ihr gluckselgen Bienen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23941 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a678dbc2-fea7-4db6-a38b-a848960055a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a678dbc2-fea7-4db6-a38b-a848960055a6', 4, 'IV', 'Fliehet, ihr gluckselgen Bienen (Aria Soprano)', 'Die Grausame, doch schone Sylvia: IV. Fliehet, ihr gluckselgen Bienen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23941 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a678dbc2-fea7-4db6-a38b-a848960055a6'
);


-- None 칸타타 <Die Rose bleibt der Blumen Konigin, H. WK A 15>

UPDATE pieces piece
SET piece.title = '칸타타 <Die Rose bleibt der Blumen Konigin, H. WK A 15>', piece.title_en = 'Die Rose bleibt der Blumen Konigin, H. WK A 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24779 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Die Rose bleibt der Blumen Konigin (Aria Soprano)', part.name_en = 'Die Rose bleibt der Blumen Konigin: I. Die Rose bleibt der Blumen Konigin (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24779 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b95cf4b8-7df5-441a-abc7-8a70b1c26e88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b95cf4b8-7df5-441a-abc7-8a70b1c26e88', 1, 'I', 'Die Rose bleibt der Blumen Konigin (Aria Soprano)', 'Die Rose bleibt der Blumen Konigin: I. Die Rose bleibt der Blumen Konigin (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24779 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b95cf4b8-7df5-441a-abc7-8a70b1c26e88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'So sung die zarte Rosimene (Recit. Tenor)', part.name_en = 'Die Rose bleibt der Blumen Konigin: II. So sung die zarte Rosimene (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24779 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c18092a5-3721-4572-8c9c-1fadf27461e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c18092a5-3721-4572-8c9c-1fadf27461e7', 2, 'II', 'So sung die zarte Rosimene (Recit. Tenor)', 'Die Rose bleibt der Blumen Konigin: II. So sung die zarte Rosimene (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24779 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18092a5-3721-4572-8c9c-1fadf27461e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Die Rosen, die so wunderschon (Aria Tenor)', part.name_en = 'Die Rose bleibt der Blumen Konigin: III. Die Rosen, die so wunderschon (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24779 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:65d9dcb6-dfce-446f-ae1d-a0553b0e9c2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d9dcb6-dfce-446f-ae1d-a0553b0e9c2c', 3, 'III', 'Die Rosen, die so wunderschon (Aria Tenor)', 'Die Rose bleibt der Blumen Konigin: III. Die Rosen, die so wunderschon (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24779 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d9dcb6-dfce-446f-ae1d-a0553b0e9c2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Auf dieses Wort (Recit. Tenor)', part.name_en = 'Die Rose bleibt der Blumen Konigin: IV. Auf dieses Wort (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24779 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:212006bb-f4ae-4fa8-9dfc-f845f1f7bd5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:212006bb-f4ae-4fa8-9dfc-f845f1f7bd5e', 4, 'IV', 'Auf dieses Wort (Recit. Tenor)', 'Die Rose bleibt der Blumen Konigin: IV. Auf dieses Wort (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24779 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:212006bb-f4ae-4fa8-9dfc-f845f1f7bd5e'
);


-- None 칸타타 <Dies ist der Tag, dies ist dir Stunde, H. WK A 17>

UPDATE pieces piece
SET piece.title = '칸타타 <Dies ist der Tag, dies ist dir Stunde, H. WK A 17>', piece.title_en = 'Dies ist der Tag, dies ist dir Stunde, H. WK A 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25058 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dies ist der Tag (Recit. Soprano)', part.name_en = 'Dies ist der Tag, dies ist dir Stunde: I. Dies ist der Tag (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25058 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e1d17ba8-24d1-4abc-894a-90fe9f8847ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1d17ba8-24d1-4abc-894a-90fe9f8847ef', 1, 'I', 'Dies ist der Tag (Recit. Soprano)', 'Dies ist der Tag, dies ist dir Stunde: I. Dies ist der Tag (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25058 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d17ba8-24d1-4abc-894a-90fe9f8847ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Armes Herz, du bist betrogen (Aria Soprano)', part.name_en = 'Dies ist der Tag, dies ist dir Stunde: II. Armes Herz, du bist betrogen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25058 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:663688d4-d059-4edb-8c61-7f7aa1c3e695' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663688d4-d059-4edb-8c61-7f7aa1c3e695', 2, 'II', 'Armes Herz, du bist betrogen (Aria Soprano)', 'Dies ist der Tag, dies ist dir Stunde: II. Armes Herz, du bist betrogen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25058 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663688d4-d059-4edb-8c61-7f7aa1c3e695'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allein, ich kuss die goldnen Bande (Recit. Soprano)', part.name_en = 'Dies ist der Tag, dies ist dir Stunde: III. Allein, ich kuss die goldnen Bande (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25058 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:19677658-5010-4157-a434-84fc4756bcde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19677658-5010-4157-a434-84fc4756bcde', 3, 'III', 'Allein, ich kuss die goldnen Bande (Recit. Soprano)', 'Dies ist der Tag, dies ist dir Stunde: III. Allein, ich kuss die goldnen Bande (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25058 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19677658-5010-4157-a434-84fc4756bcde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Jetzt will ich ein Gelubde tun (Aria Soprano)', part.name_en = 'Dies ist der Tag, dies ist dir Stunde: IV. Jetzt will ich ein Gelubde tun (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25058 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4e897798-16ef-42f8-9dbe-459e947ab06f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e897798-16ef-42f8-9dbe-459e947ab06f', 4, 'IV', 'Jetzt will ich ein Gelubde tun (Aria Soprano)', 'Dies ist der Tag, dies ist dir Stunde: IV. Jetzt will ich ein Gelubde tun (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25058 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e897798-16ef-42f8-9dbe-459e947ab06f'
);


-- H. 28 칸타타 <Ehre sei Gott in der Höhe>

UPDATE pieces piece
SET piece.title = '칸타타 <Ehre sei Gott in der Höhe>', piece.title_en = 'Ehre sei Gott in der Höhe, H. 28',
    piece.type = 'album', piece.opus_number = 'H. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24728 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'V',
    part.name_ko = 'Kommt mit mir nach Bethlehem zum Stalle (Aria T)', part.name_en = 'Ehre sei Gott in der Höhe: V. Kommt mit mir nach Bethlehem zum Stalle (Aria T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4f46f96a-6d94-4e2f-bcc7-d4d0db0ae97d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f46f96a-6d94-4e2f-bcc7-d4d0db0ae97d', 1, 'V', 'Kommt mit mir nach Bethlehem zum Stalle (Aria T)', 'Ehre sei Gott in der Höhe: V. Kommt mit mir nach Bethlehem zum Stalle (Aria T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f46f96a-6d94-4e2f-bcc7-d4d0db0ae97d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Gott schenkt sein Herz der Erden (Rec. C, A, T, B)', part.name_en = 'Ehre sei Gott in der Höhe: IV. Gott schenkt sein Herz der Erden (Rec. C, A, T, B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7f71eba3-076c-4b75-b6a5-b20fbd296171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f71eba3-076c-4b75-b6a5-b20fbd296171', 2, 'IV', 'Gott schenkt sein Herz der Erden (Rec. C, A, T, B)', 'Ehre sei Gott in der Höhe: IV. Gott schenkt sein Herz der Erden (Rec. C, A, T, B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f71eba3-076c-4b75-b6a5-b20fbd296171'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Wir hören Engel singen (Rec. A, T & Chorale)', part.name_en = 'Ehre sei Gott in der Höhe: II. Wir hören Engel singen (Rec. A, T & Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a3224027-efe4-4106-af5b-9fce9103ef33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3224027-efe4-4106-af5b-9fce9103ef33', 3, 'II', 'Wir hören Engel singen (Rec. A, T & Chorale)', 'Ehre sei Gott in der Höhe: II. Wir hören Engel singen (Rec. A, T & Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3224027-efe4-4106-af5b-9fce9103ef33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Unschätzbare Weihnachtsgaben (Aria A)', part.name_en = 'Ehre sei Gott in der Höhe: III. Unschätzbare Weihnachtsgaben (Aria A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ad3f9f76-51ea-4b19-b395-35f22793f1e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad3f9f76-51ea-4b19-b395-35f22793f1e6', 4, 'III', 'Unschätzbare Weihnachtsgaben (Aria A)', 'Ehre sei Gott in der Höhe: III. Unschätzbare Weihnachtsgaben (Aria A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3f9f76-51ea-4b19-b395-35f22793f1e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'Des laßt uns alle fröhlich sein (Chorale)', part.name_en = 'Ehre sei Gott in der Höhe: VI. Des laßt uns alle fröhlich sein (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e4b89157-a8b5-46c3-ac10-d65c9036045c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b89157-a8b5-46c3-ac10-d65c9036045c', 5, 'VI', 'Des laßt uns alle fröhlich sein (Chorale)', 'Ehre sei Gott in der Höhe: VI. Des laßt uns alle fröhlich sein (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b89157-a8b5-46c3-ac10-d65c9036045c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Ehre sei Gott in der Höhe (Tutti)', part.name_en = 'Ehre sei Gott in der Höhe: I. Ehre sei Gott in der Höhe (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24728 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f1ad5eeb-2bd8-4684-b565-1e4e204095a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ad5eeb-2bd8-4684-b565-1e4e204095a4', 6, 'I', 'Ehre sei Gott in der Höhe (Tutti)', 'Ehre sei Gott in der Höhe: I. Ehre sei Gott in der Höhe (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24728 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ad5eeb-2bd8-4684-b565-1e4e204095a4'
);


-- None 칸타타 <Ein Augenblick ist eine kurze Zeit, H. WK A 14>

UPDATE pieces piece
SET piece.title = '칸타타 <Ein Augenblick ist eine kurze Zeit, H. WK A 14>', piece.title_en = 'Ein Augenblick ist eine kurze Zeit, H. WK A 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25791 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ein Augenblick ist eine kurze Zeit (Recit. Tenor)', part.name_en = 'Ein Augenblick ist eine kurze Zeit: I. Ein Augenblick ist eine kurze Zeit (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25791 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5425ad8f-cc84-4c1b-8c5c-b9850e694baf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5425ad8f-cc84-4c1b-8c5c-b9850e694baf', 1, 'I', 'Ein Augenblick ist eine kurze Zeit (Recit. Tenor)', 'Ein Augenblick ist eine kurze Zeit: I. Ein Augenblick ist eine kurze Zeit (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25791 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5425ad8f-cc84-4c1b-8c5c-b9850e694baf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ja, mir gonnen tausend Stunden (Aria Tenor)', part.name_en = 'Ein Augenblick ist eine kurze Zeit: II. Ja, mir gonnen tausend Stunden (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25791 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:68a3dc7b-e3be-4053-8502-a5493dcb3ae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68a3dc7b-e3be-4053-8502-a5493dcb3ae5', 2, 'II', 'Ja, mir gonnen tausend Stunden (Aria Tenor)', 'Ein Augenblick ist eine kurze Zeit: II. Ja, mir gonnen tausend Stunden (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25791 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68a3dc7b-e3be-4053-8502-a5493dcb3ae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Es ist umsonst (Recit. Tenor)', part.name_en = 'Ein Augenblick ist eine kurze Zeit: III. Es ist umsonst (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25791 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:de328cf4-1191-4c01-a868-c2ae7757bb69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de328cf4-1191-4c01-a868-c2ae7757bb69', 3, 'III', 'Es ist umsonst (Recit. Tenor)', 'Ein Augenblick ist eine kurze Zeit: III. Es ist umsonst (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25791 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de328cf4-1191-4c01-a868-c2ae7757bb69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Satt''get euch, ergrimmte Sterne (Aria Tenor)', part.name_en = 'Ein Augenblick ist eine kurze Zeit: IV. Satt''get euch, ergrimmte Sterne (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25791 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:33e7217b-5635-4ac6-a29b-b259177d5ff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33e7217b-5635-4ac6-a29b-b259177d5ff1', 4, 'IV', 'Satt''get euch, ergrimmte Sterne (Aria Tenor)', 'Ein Augenblick ist eine kurze Zeit: IV. Satt''get euch, ergrimmte Sterne (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25791 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33e7217b-5635-4ac6-a29b-b259177d5ff1'
);


-- H. 103 칸타타 <Er heisset Friedefürst>

UPDATE pieces piece
SET piece.title = '칸타타 <Er heisset Friedefürst>', piece.title_en = 'Er heisset Friedefürst, H. 103',
    piece.type = 'album', piece.opus_number = 'H. 103',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23380 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Er heisset Friedefürst (Coro à 4)', part.name_en = 'Er heisset Friedefürst: I. Er heisset Friedefürst (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23380 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c6a54c2d-72b8-4f97-8ef9-1d546864cc83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6a54c2d-72b8-4f97-8ef9-1d546864cc83', 1, 'I', 'Er heisset Friedefürst (Coro à 4)', 'Er heisset Friedefürst: I. Er heisset Friedefürst (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23380 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6a54c2d-72b8-4f97-8ef9-1d546864cc83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die ganze Welt ist voller Krieg und Streiten (Recit. à 4)', part.name_en = 'Er heisset Friedefürst: II. Die ganze Welt ist voller Krieg und Streiten (Recit. à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23380 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fdf6585f-4fe0-4c9f-8b4f-0bbd545023c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdf6585f-4fe0-4c9f-8b4f-0bbd545023c8', 2, 'II', 'Die ganze Welt ist voller Krieg und Streiten (Recit. à 4)', 'Er heisset Friedefürst: II. Die ganze Welt ist voller Krieg und Streiten (Recit. à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23380 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdf6585f-4fe0-4c9f-8b4f-0bbd545023c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Du bist in Jesu lauter Frieden (Duet Soprano, Alto / Coro à 4)', part.name_en = 'Er heisset Friedefürst: III. Du bist in Jesu lauter Frieden (Duet Soprano, Alto / Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23380 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1b2d9236-2bad-4f59-9d35-64e1b057da99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b2d9236-2bad-4f59-9d35-64e1b057da99', 3, 'III', 'Du bist in Jesu lauter Frieden (Duet Soprano, Alto / Coro à 4)', 'Er heisset Friedefürst: III. Du bist in Jesu lauter Frieden (Duet Soprano, Alto / Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23380 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b2d9236-2bad-4f59-9d35-64e1b057da99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Grüss mich mit deinem Munde (Chorale)', part.name_en = 'Er heisset Friedefürst: IV. Grüss mich mit deinem Munde (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23380 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:39ea7ac0-9957-4f2f-8e04-e06a24e877f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39ea7ac0-9957-4f2f-8e04-e06a24e877f9', 4, 'IV', 'Grüss mich mit deinem Munde (Chorale)', 'Er heisset Friedefürst: IV. Grüss mich mit deinem Munde (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23380 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ea7ac0-9957-4f2f-8e04-e06a24e877f9'
);


-- None 칸타타 <Flieht, ihr Schaffe, flieht von hinnen, H. WK A 22>

UPDATE pieces piece
SET piece.title = '칸타타 <Flieht, ihr Schaffe, flieht von hinnen, H. WK A 22>', piece.title_en = 'Flieht, ihr Schaffe, flieht von hinnen, H. WK A 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23796 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Flieht, ihr Schaffe, flieht von hinnen (Aria Tenor)', part.name_en = 'Flieht, ihr Schaffe, flieht von hinnen: I. Flieht, ihr Schaffe, flieht von hinnen (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23796 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8defdb6a-9b2a-4e7c-a85c-302a2951a558' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8defdb6a-9b2a-4e7c-a85c-302a2951a558', 1, 'I', 'Flieht, ihr Schaffe, flieht von hinnen (Aria Tenor)', 'Flieht, ihr Schaffe, flieht von hinnen: I. Flieht, ihr Schaffe, flieht von hinnen (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23796 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8defdb6a-9b2a-4e7c-a85c-302a2951a558'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ihr Nymphen, flieht, und rührt nicht (Recit. Tenor)', part.name_en = 'Flieht, ihr Schaffe, flieht von hinnen: II. Ihr Nymphen, flieht, und rührt nicht (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23796 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ab741ead-9507-439c-a9e7-3a275b4385a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab741ead-9507-439c-a9e7-3a275b4385a6', 2, 'II', 'Ihr Nymphen, flieht, und rührt nicht (Recit. Tenor)', 'Flieht, ihr Schaffe, flieht von hinnen: II. Ihr Nymphen, flieht, und rührt nicht (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23796 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab741ead-9507-439c-a9e7-3a275b4385a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lang genug hat mich Gequälet (Aria Tenor)', part.name_en = 'Flieht, ihr Schaffe, flieht von hinnen: III. Lang genug hat mich Gequälet (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23796 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1852e42f-9aa4-4583-b460-b7d4cb92820c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1852e42f-9aa4-4583-b460-b7d4cb92820c', 3, 'III', 'Lang genug hat mich Gequälet (Aria Tenor)', 'Flieht, ihr Schaffe, flieht von hinnen: III. Lang genug hat mich Gequälet (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23796 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1852e42f-9aa4-4583-b460-b7d4cb92820c'
);


-- None 칸타타 <Ich bin es schon gewohnt, H. WK A 21>

UPDATE pieces piece
SET piece.title = '칸타타 <Ich bin es schon gewohnt, H. WK A 21>', piece.title_en = 'Ich bin es schon gewohnt, H. WK A 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24564 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ich bin es schon gewohnt (Recit. Tenor)', part.name_en = 'Ich bin es schon gewohnt: I. Ich bin es schon gewohnt (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24564 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1fb558e5-556c-4ed9-85c3-df8f3e991e53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb558e5-556c-4ed9-85c3-df8f3e991e53', 1, 'I', 'Ich bin es schon gewohnt (Recit. Tenor)', 'Ich bin es schon gewohnt: I. Ich bin es schon gewohnt (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24564 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb558e5-556c-4ed9-85c3-df8f3e991e53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wieviele Seufzer hast du nicht (Aria Soprano)', part.name_en = 'Ich bin es schon gewohnt: II. Wieviele Seufzer hast du nicht (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24564 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6522a16e-81e8-4291-9bf5-bb0bc7af6181' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6522a16e-81e8-4291-9bf5-bb0bc7af6181', 2, 'II', 'Wieviele Seufzer hast du nicht (Aria Soprano)', 'Ich bin es schon gewohnt: II. Wieviele Seufzer hast du nicht (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24564 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6522a16e-81e8-4291-9bf5-bb0bc7af6181'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ach! Konnt ich deinen Zorn vergnugen (Recit. Tenor)', part.name_en = 'Ich bin es schon gewohnt: III. Ach! Konnt ich deinen Zorn vergnugen (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24564 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:439dfce6-5b9f-4a26-93b0-14bb83a7e629' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:439dfce6-5b9f-4a26-93b0-14bb83a7e629', 3, 'III', 'Ach! Konnt ich deinen Zorn vergnugen (Recit. Tenor)', 'Ich bin es schon gewohnt: III. Ach! Konnt ich deinen Zorn vergnugen (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24564 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:439dfce6-5b9f-4a26-93b0-14bb83a7e629'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Es mag dein Eifer sich erhitzen (Aria Soprano)', part.name_en = 'Ich bin es schon gewohnt: IV. Es mag dein Eifer sich erhitzen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24564 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e072c599-3655-4713-8008-15789557853e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e072c599-3655-4713-8008-15789557853e', 4, 'IV', 'Es mag dein Eifer sich erhitzen (Aria Soprano)', 'Ich bin es schon gewohnt: IV. Es mag dein Eifer sich erhitzen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24564 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e072c599-3655-4713-8008-15789557853e'
);


-- H. 33 칸타타 <Ich sehe den Himmel offen>

UPDATE pieces piece
SET piece.title = '칸타타 <Ich sehe den Himmel offen>', piece.title_en = 'Ich sehe den Himmel offen, H. 33',
    piece.type = 'album', piece.opus_number = 'H. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25457 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Wird Stephanus gleich angeklagt (Rec. A, T & Accompagnato T)', part.name_en = 'Ich sehe den Himmel offen: IV. Wird Stephanus gleich angeklagt (Rec. A, T & Accompagnato T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:36e9c02a-0444-4f6f-8c7a-2c07c63f14cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36e9c02a-0444-4f6f-8c7a-2c07c63f14cb', 1, 'IV', 'Wird Stephanus gleich angeklagt (Rec. A, T & Accompagnato T)', 'Ich sehe den Himmel offen: IV. Wird Stephanus gleich angeklagt (Rec. A, T & Accompagnato T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e9c02a-0444-4f6f-8c7a-2c07c63f14cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'VI',
    part.name_ko = 'Herr Gott, nun schleuß den Himmel auf (Chorale)', part.name_en = 'Ich sehe den Himmel offen: VI. Herr Gott, nun schleuß den Himmel auf (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:38870811-03ac-461e-9ced-1dae61b1e66a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38870811-03ac-461e-9ced-1dae61b1e66a', 2, 'VI', 'Herr Gott, nun schleuß den Himmel auf (Chorale)', 'Ich sehe den Himmel offen: VI. Herr Gott, nun schleuß den Himmel auf (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38870811-03ac-461e-9ced-1dae61b1e66a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Schöner Himmel öffne dich ! (Aria T)', part.name_en = 'Ich sehe den Himmel offen: V. Schöner Himmel öffne dich ! (Aria T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5f952edb-14a2-4b40-bb07-32a039d298ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f952edb-14a2-4b40-bb07-32a039d298ad', 3, 'V', 'Schöner Himmel öffne dich ! (Aria T)', 'Ich sehe den Himmel offen: V. Schöner Himmel öffne dich ! (Aria T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f952edb-14a2-4b40-bb07-32a039d298ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Getreuer Zeuge ! Wie ? (Rec. C, A)', part.name_en = 'Ich sehe den Himmel offen: II. Getreuer Zeuge ! Wie ? (Rec. C, A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8171bdff-2739-4755-8e83-476338a86c50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8171bdff-2739-4755-8e83-476338a86c50', 4, 'II', 'Getreuer Zeuge ! Wie ? (Rec. C, A)', 'Ich sehe den Himmel offen: II. Getreuer Zeuge ! Wie ? (Rec. C, A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8171bdff-2739-4755-8e83-476338a86c50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = 'So bin ich froh im Leiden (Aria A)', part.name_en = 'Ich sehe den Himmel offen: III. So bin ich froh im Leiden (Aria A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:99a945cd-5996-4845-b994-278461e33642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a945cd-5996-4845-b994-278461e33642', 5, 'III', 'So bin ich froh im Leiden (Aria A)', 'Ich sehe den Himmel offen: III. So bin ich froh im Leiden (Aria A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a945cd-5996-4845-b994-278461e33642'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Ich sehe den Himmel offen (Tutti)', part.name_en = 'Ich sehe den Himmel offen: I. Ich sehe den Himmel offen (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25457 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f8a41863-7bae-419d-bb40-520897e83215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a41863-7bae-419d-bb40-520897e83215', 6, 'I', 'Ich sehe den Himmel offen (Tutti)', 'Ich sehe den Himmel offen: I. Ich sehe den Himmel offen (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25457 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a41863-7bae-419d-bb40-520897e83215'
);


-- None 칸타타 <Ihr Augen, laßt den Tränenbächen, H. WK A 25>

UPDATE pieces piece
SET piece.title = '칸타타 <Ihr Augen, laßt den Tränenbächen, H. WK A 25>', piece.title_en = 'Ihr Augen, laßt den Tränenbächen, H. WK A 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25991 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ihr Augen, laßt den Tränenbächen(Recit. Soprano)', part.name_en = 'Ihr Augen, laßt den Tränenbächen: I. Ihr Augen, laßt den Tränenbächen(Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25991 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:68e74dec-afcf-4e26-b551-d053ec4353fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68e74dec-afcf-4e26-b551-d053ec4353fd', 1, 'I', 'Ihr Augen, laßt den Tränenbächen(Recit. Soprano)', 'Ihr Augen, laßt den Tränenbächen: I. Ihr Augen, laßt den Tränenbächen(Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25991 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68e74dec-afcf-4e26-b551-d053ec4353fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ihr meiner Not getreue Zeugen (Aria Soprano) / Allein ich scheue mich (Recit. Soprano) /Geliebter Schmerz, du bist mein eigen (Aria Soprano)', part.name_en = 'Ihr Augen, laßt den Tränenbächen: II. Ihr meiner Not getreue Zeugen (Aria Soprano) / Allein ich scheue mich (Recit. Soprano) /Geliebter Schmerz, du bist mein eigen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25991 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fed5e263-7f00-48e9-bedb-73ab61385e6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fed5e263-7f00-48e9-bedb-73ab61385e6d', 2, 'II', 'Ihr meiner Not getreue Zeugen (Aria Soprano) / Allein ich scheue mich (Recit. Soprano) /Geliebter Schmerz, du bist mein eigen (Aria Soprano)', 'Ihr Augen, laßt den Tränenbächen: II. Ihr meiner Not getreue Zeugen (Aria Soprano) / Allein ich scheue mich (Recit. Soprano) /Geliebter Schmerz, du bist mein eigen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25991 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fed5e263-7f00-48e9-bedb-73ab61385e6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sage ihm, daß diese Seele in getreuen Banden geht (Aria Soprano)', part.name_en = 'Ihr Augen, laßt den Tränenbächen: III. Sage ihm, daß diese Seele in getreuen Banden geht (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25991 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:84393d83-f1b3-49e3-bae2-8b98c28602dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84393d83-f1b3-49e3-bae2-8b98c28602dc', 3, 'III', 'Sage ihm, daß diese Seele in getreuen Banden geht (Aria Soprano)', 'Ihr Augen, laßt den Tränenbächen: III. Sage ihm, daß diese Seele in getreuen Banden geht (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25991 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84393d83-f1b3-49e3-bae2-8b98c28602dc'
);


-- H. 34 칸타타 <Ihr sollt nicht wähnen>

UPDATE pieces piece
SET piece.title = '칸타타 <Ihr sollt nicht wähnen>', piece.title_en = 'Ihr sollt nicht wähnen, H. 34',
    piece.type = 'album', piece.opus_number = 'H. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24129 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Mein Jesus saget zwar (Rec., Arioso B)', part.name_en = 'Ihr sollt nicht wähnen: III. Mein Jesus saget zwar (Rec., Arioso B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24129 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:00b35621-c62c-4f43-8677-8465b920765e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b35621-c62c-4f43-8677-8465b920765e', 1, 'III', 'Mein Jesus saget zwar (Rec., Arioso B)', 'Ihr sollt nicht wähnen: III. Mein Jesus saget zwar (Rec., Arioso B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24129 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b35621-c62c-4f43-8677-8465b920765e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Ihr sollt nicht wähnen (Solo B; Accompagnato T, A & Rec. C)', part.name_en = 'Ihr sollt nicht wähnen: I. Ihr sollt nicht wähnen (Solo B; Accompagnato T, A & Rec. C)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24129 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:28cbd5c3-1281-4250-aa32-d4f5e20031ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28cbd5c3-1281-4250-aa32-d4f5e20031ff', 2, 'I', 'Ihr sollt nicht wähnen (Solo B; Accompagnato T, A & Rec. C)', 'Ihr sollt nicht wähnen: I. Ihr sollt nicht wähnen (Solo B; Accompagnato T, A & Rec. C)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24129 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28cbd5c3-1281-4250-aa32-d4f5e20031ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Es mag von außen donnern, blitzen (Aria C)', part.name_en = 'Ihr sollt nicht wähnen: II. Es mag von außen donnern, blitzen (Aria C)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24129 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4f11731f-b785-41ef-9330-a4a87a27bf0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f11731f-b785-41ef-9330-a4a87a27bf0b', 3, 'II', 'Es mag von außen donnern, blitzen (Aria C)', 'Ihr sollt nicht wähnen: II. Es mag von außen donnern, blitzen (Aria C)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24129 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f11731f-b785-41ef-9330-a4a87a27bf0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Will Welt und Satan mich bestreiten (Aria B)', part.name_en = 'Ihr sollt nicht wähnen: IV. Will Welt und Satan mich bestreiten (Aria B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24129 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:518c53b6-9cb6-4f5b-8719-ba49f19d36b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:518c53b6-9cb6-4f5b-8719-ba49f19d36b5', 4, 'IV', 'Will Welt und Satan mich bestreiten (Aria B)', 'Ihr sollt nicht wähnen: IV. Will Welt und Satan mich bestreiten (Aria B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24129 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:518c53b6-9cb6-4f5b-8719-ba49f19d36b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Breit aus die Flügel beide (Chorale)', part.name_en = 'Ihr sollt nicht wähnen: V. Breit aus die Flügel beide (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24129 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:71d97c36-d6c1-47db-8ea5-141bff8767c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d97c36-d6c1-47db-8ea5-141bff8767c8', 5, 'V', 'Breit aus die Flügel beide (Chorale)', 'Ihr sollt nicht wähnen: V. Breit aus die Flügel beide (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24129 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d97c36-d6c1-47db-8ea5-141bff8767c8'
);


-- None 칸타타 <Ihr stillen Seufzer, gehet, H. WK A 20>

UPDATE pieces piece
SET piece.title = '칸타타 <Ihr stillen Seufzer, gehet, H. WK A 20>', piece.title_en = 'Ihr stillen Seufzer, gehet, H. WK A 20',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23688 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ihr stillen Seufzer, gehet (Aria Tenor)', part.name_en = 'Ihr stillen Seufzer, gehet: I. Ihr stillen Seufzer, gehet (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23688 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5fa074cb-a398-446d-b847-4a230b4e8442' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa074cb-a398-446d-b847-4a230b4e8442', 1, 'I', 'Ihr stillen Seufzer, gehet (Aria Tenor)', 'Ihr stillen Seufzer, gehet: I. Ihr stillen Seufzer, gehet (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23688 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa074cb-a398-446d-b847-4a230b4e8442'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ich kenne dich noch nicht, geliebtes Augenlicht (Recit. Tenor)', part.name_en = 'Ihr stillen Seufzer, gehet: II. Ich kenne dich noch nicht, geliebtes Augenlicht (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23688 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7e351574-2475-4364-a747-e4c698c975cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e351574-2475-4364-a747-e4c698c975cc', 2, 'II', 'Ich kenne dich noch nicht, geliebtes Augenlicht (Recit. Tenor)', 'Ihr stillen Seufzer, gehet: II. Ich kenne dich noch nicht, geliebtes Augenlicht (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23688 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e351574-2475-4364-a747-e4c698c975cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Unbekannt, doch schöne Seele (Aria Tenor)', part.name_en = 'Ihr stillen Seufzer, gehet: III. Unbekannt, doch schöne Seele (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23688 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:baff80f0-3a1b-4b26-8c36-060b9381e895' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baff80f0-3a1b-4b26-8c36-060b9381e895', 3, 'III', 'Unbekannt, doch schöne Seele (Aria Tenor)', 'Ihr stillen Seufzer, gehet: III. Unbekannt, doch schöne Seele (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23688 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baff80f0-3a1b-4b26-8c36-060b9381e895'
);


-- None 칸타타 <Ja, mein Engel, dieses Herze, H. WK A 24>

UPDATE pieces piece
SET piece.title = '칸타타 <Ja, mein Engel, dieses Herze, H. WK A 24>', piece.title_en = 'Ja, mein Engel, dieses Herze, H. WK A 24',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25026 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ja, mein Engel, dieses Herze (Aria Tenor) / Doch Himmel, wie ist mir? (Recit. Tenor)', part.name_en = 'Ja, mein Engel, dieses Herze: I. Ja, mein Engel, dieses Herze (Aria Tenor) / Doch Himmel, wie ist mir? (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25026 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:85344d48-e1b3-4074-8d40-2e83b40ab64d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85344d48-e1b3-4074-8d40-2e83b40ab64d', 1, 'I', 'Ja, mein Engel, dieses Herze (Aria Tenor) / Doch Himmel, wie ist mir? (Recit. Tenor)', 'Ja, mein Engel, dieses Herze: I. Ja, mein Engel, dieses Herze (Aria Tenor) / Doch Himmel, wie ist mir? (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25026 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85344d48-e1b3-4074-8d40-2e83b40ab64d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Träumet fort, betörte Sinnen (Aria Tenor)', part.name_en = 'Ja, mein Engel, dieses Herze: II. Träumet fort, betörte Sinnen (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25026 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:beeaf22e-ebe1-438a-9f83-76fe8f46b1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beeaf22e-ebe1-438a-9f83-76fe8f46b1b6', 2, 'II', 'Träumet fort, betörte Sinnen (Aria Tenor)', 'Ja, mein Engel, dieses Herze: II. Träumet fort, betörte Sinnen (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25026 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beeaf22e-ebe1-438a-9f83-76fe8f46b1b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'So muß ich denn zu meiner Pein (Recit. Tenor)', part.name_en = 'Ja, mein Engel, dieses Herze: III. So muß ich denn zu meiner Pein (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25026 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c8747412-3b0c-4d3f-871f-1df6332558dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8747412-3b0c-4d3f-871f-1df6332558dc', 3, 'III', 'So muß ich denn zu meiner Pein (Recit. Tenor)', 'Ja, mein Engel, dieses Herze: III. So muß ich denn zu meiner Pein (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25026 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8747412-3b0c-4d3f-871f-1df6332558dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Stell es ihr im Traume für (Aria Tenor)', part.name_en = 'Ja, mein Engel, dieses Herze: IV. Stell es ihr im Traume für (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25026 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:9fe0f0f2-967f-4834-9fbc-c96b95091dba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fe0f0f2-967f-4834-9fbc-c96b95091dba', 4, 'IV', 'Stell es ihr im Traume für (Aria Tenor)', 'Ja, mein Engel, dieses Herze: IV. Stell es ihr im Traume für (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25026 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fe0f0f2-967f-4834-9fbc-c96b95091dba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Doch solt ich vor der Zeit erbleichen (Recit. Tenor)', part.name_en = 'Ja, mein Engel, dieses Herze: V. Doch solt ich vor der Zeit erbleichen (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25026 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:686a6c0b-ed22-45ac-820d-5260d89763a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:686a6c0b-ed22-45ac-820d-5260d89763a4', 5, 'V', 'Doch solt ich vor der Zeit erbleichen (Recit. Tenor)', 'Ja, mein Engel, dieses Herze: V. Doch solt ich vor der Zeit erbleichen (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25026 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:686a6c0b-ed22-45ac-820d-5260d89763a4'
);


-- None 칸타타 <Kann die Liebe auch erfreuen, H. WK A 18>

UPDATE pieces piece
SET piece.title = '칸타타 <Kann die Liebe auch erfreuen, H. WK A 18>', piece.title_en = 'Kann die Liebe auch erfreuen, H. WK A 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23450 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kann die Liebe auch erfreuen (Aria Tenor)', part.name_en = 'Kann die Liebe auch erfreuen: I. Kann die Liebe auch erfreuen (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23450 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4706ec5f-8c80-4d3f-aa7a-0d4d6dc2b509' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4706ec5f-8c80-4d3f-aa7a-0d4d6dc2b509', 1, 'I', 'Kann die Liebe auch erfreuen (Aria Tenor)', 'Kann die Liebe auch erfreuen: I. Kann die Liebe auch erfreuen (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23450 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4706ec5f-8c80-4d3f-aa7a-0d4d6dc2b509'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ein jeder sagt, Cupido schlage Wunder (Recit. Soprano)', part.name_en = 'Kann die Liebe auch erfreuen: II. Ein jeder sagt, Cupido schlage Wunder (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23450 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:761a8543-2725-4f78-8a63-1820ff61e4cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:761a8543-2725-4f78-8a63-1820ff61e4cd', 2, 'II', 'Ein jeder sagt, Cupido schlage Wunder (Recit. Soprano)', 'Kann die Liebe auch erfreuen: II. Ein jeder sagt, Cupido schlage Wunder (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23450 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761a8543-2725-4f78-8a63-1820ff61e4cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Brennet fort, ihr schonen Flammen (Aria Soprano)', part.name_en = 'Kann die Liebe auch erfreuen: III. Brennet fort, ihr schonen Flammen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23450 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5816a2a5-5b7a-4c64-bc7a-22fcecabe584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5816a2a5-5b7a-4c64-bc7a-22fcecabe584', 3, 'III', 'Brennet fort, ihr schonen Flammen (Aria Soprano)', 'Kann die Liebe auch erfreuen: III. Brennet fort, ihr schonen Flammen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23450 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5816a2a5-5b7a-4c64-bc7a-22fcecabe584'
);


-- H. 41 칸타타 <Kündlich groß ist das gottselige Geheimnis>

UPDATE pieces piece
SET piece.title = '칸타타 <Kündlich groß ist das gottselige Geheimnis>', piece.title_en = 'Kündlich groß ist das gottselige Geheimnis, H. 41',
    piece.type = 'album', piece.opus_number = 'H. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25964 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Gott im Fleische geoffenbaret (Duett A, T)', part.name_en = 'Kündlich groß ist das gottselige Geheimnis: II. Gott im Fleische geoffenbaret (Duett A, T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25964 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2bb024f9-b38c-4337-a584-b8fd96bdc5be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bb024f9-b38c-4337-a584-b8fd96bdc5be', 1, 'II', 'Gott im Fleische geoffenbaret (Duett A, T)', 'Kündlich groß ist das gottselige Geheimnis: II. Gott im Fleische geoffenbaret (Duett A, T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25964 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bb024f9-b38c-4337-a584-b8fd96bdc5be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Mein Auge hebt sich in die Höh (Aria A; Accompagnato C & Chorale)', part.name_en = 'Kündlich groß ist das gottselige Geheimnis: IV. Mein Auge hebt sich in die Höh (Aria A; Accompagnato C & Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25964 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:31a2d005-318d-400a-a53b-608c1900394c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a2d005-318d-400a-a53b-608c1900394c', 2, 'IV', 'Mein Auge hebt sich in die Höh (Aria A; Accompagnato C & Chorale)', 'Kündlich groß ist das gottselige Geheimnis: IV. Mein Auge hebt sich in die Höh (Aria A; Accompagnato C & Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25964 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a2d005-318d-400a-a53b-608c1900394c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Kündlich groß ist das gottselige Geheimnis (Tutti)', part.name_en = 'Kündlich groß ist das gottselige Geheimnis: I. Kündlich groß ist das gottselige Geheimnis (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25964 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:7d9e39c8-9fc5-4a06-949a-4984ca998fe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d9e39c8-9fc5-4a06-949a-4984ca998fe9', 3, 'I', 'Kündlich groß ist das gottselige Geheimnis (Tutti)', 'Kündlich groß ist das gottselige Geheimnis: I. Kündlich groß ist das gottselige Geheimnis (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25964 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d9e39c8-9fc5-4a06-949a-4984ca998fe9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Den wir unendlich nennen (Rec. T - Chorale A & Chorale-Rec. T, C)', part.name_en = 'Kündlich groß ist das gottselige Geheimnis: III. Den wir unendlich nennen (Rec. T - Chorale A & Chorale-Rec. T, C)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25964 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:98b2ce46-9b33-4a59-b6e5-74a5a30ebfbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b2ce46-9b33-4a59-b6e5-74a5a30ebfbf', 4, 'III', 'Den wir unendlich nennen (Rec. T - Chorale A & Chorale-Rec. T, C)', 'Kündlich groß ist das gottselige Geheimnis: III. Den wir unendlich nennen (Rec. T - Chorale A & Chorale-Rec. T, C)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25964 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b2ce46-9b33-4a59-b6e5-74a5a30ebfbf'
);


-- H. 156 칸타타 <Lehre mich tun nach deinem Wohlgefallen>

UPDATE pieces piece
SET piece.title = '칸타타 <Lehre mich tun nach deinem Wohlgefallen>', piece.title_en = 'Lehre mich tun nach deinem Wohlgefallen, H. 156',
    piece.type = 'album', piece.opus_number = 'H. 156',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25364 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lehre mich tun nach deinem Wohlgefallen (Coro à 4)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: I. Lehre mich tun nach deinem Wohlgefallen (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:63f45f1b-aaa3-4bca-98ac-89afa69a6cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63f45f1b-aaa3-4bca-98ac-89afa69a6cef', 1, 'I', 'Lehre mich tun nach deinem Wohlgefallen (Coro à 4)', 'Lehre mich tun nach deinem Wohlgefallen: I. Lehre mich tun nach deinem Wohlgefallen (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63f45f1b-aaa3-4bca-98ac-89afa69a6cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wenn Christi Gnadenreich (Recit. Alto / Tenor)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: II. Wenn Christi Gnadenreich (Recit. Alto / Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6cafc479-a429-4e0a-9d55-27e218727c1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cafc479-a429-4e0a-9d55-27e218727c1c', 2, 'II', 'Wenn Christi Gnadenreich (Recit. Alto / Tenor)', 'Lehre mich tun nach deinem Wohlgefallen: II. Wenn Christi Gnadenreich (Recit. Alto / Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cafc479-a429-4e0a-9d55-27e218727c1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ihr falschen Führer meines Lebens (Aria Tenor)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: III. Ihr falschen Führer meines Lebens (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5bd81a59-b975-4633-864b-eaa9a1927929' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bd81a59-b975-4633-864b-eaa9a1927929', 3, 'III', 'Ihr falschen Führer meines Lebens (Aria Tenor)', 'Lehre mich tun nach deinem Wohlgefallen: III. Ihr falschen Führer meines Lebens (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd81a59-b975-4633-864b-eaa9a1927929'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Komm, guter Geist (Recit. Soprano / Bass)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: IV. Komm, guter Geist (Recit. Soprano / Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4f081561-fa97-40da-a462-bb11efc04268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f081561-fa97-40da-a462-bb11efc04268', 4, 'IV', 'Komm, guter Geist (Recit. Soprano / Bass)', 'Lehre mich tun nach deinem Wohlgefallen: IV. Komm, guter Geist (Recit. Soprano / Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f081561-fa97-40da-a462-bb11efc04268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Wenn Gnüge und Leben (Aria Bass)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: V. Wenn Gnüge und Leben (Aria Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:cc978df3-c45a-4145-942f-8196e953cc35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc978df3-c45a-4145-942f-8196e953cc35', 5, 'V', 'Wenn Gnüge und Leben (Aria Bass)', 'Lehre mich tun nach deinem Wohlgefallen: V. Wenn Gnüge und Leben (Aria Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc978df3-c45a-4145-942f-8196e953cc35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Der Herr ist mein treuer Hirt (Chorale)', part.name_en = 'Lehre mich tun nach deinem Wohlgefallen: VI. Der Herr ist mein treuer Hirt (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25364 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:eb9aeaaa-bfe3-4f8d-a179-8f7ad3297d50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb9aeaaa-bfe3-4f8d-a179-8f7ad3297d50', 6, 'VI', 'Der Herr ist mein treuer Hirt (Chorale)', 'Lehre mich tun nach deinem Wohlgefallen: VI. Der Herr ist mein treuer Hirt (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25364 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb9aeaaa-bfe3-4f8d-a179-8f7ad3297d50'
);


-- None 칸타타 <Nur vor euch, ihr schonsten Augen, H. WK A 16>

UPDATE pieces piece
SET piece.title = '칸타타 <Nur vor euch, ihr schonsten Augen, H. WK A 16>', piece.title_en = 'Nur vor euch, ihr schonsten Augen, H. WK A 16',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24900 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nur vor euch, ihr schonsten Augen (Aria Tenor)', part.name_en = 'Nur vor euch, ihr schonsten Augen: I. Nur vor euch, ihr schonsten Augen (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24900 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:62f6e4e4-5bc8-4db0-b566-4afaa5ad9e3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62f6e4e4-5bc8-4db0-b566-4afaa5ad9e3e', 1, 'I', 'Nur vor euch, ihr schonsten Augen (Aria Tenor)', 'Nur vor euch, ihr schonsten Augen: I. Nur vor euch, ihr schonsten Augen (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24900 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f6e4e4-5bc8-4db0-b566-4afaa5ad9e3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Das licht, so meinen Augen (Recit. Tenor)', part.name_en = 'Nur vor euch, ihr schonsten Augen: II. Das licht, so meinen Augen (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24900 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6b4a4e16-722a-4621-b7c7-b0c4179d2bec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b4a4e16-722a-4621-b7c7-b0c4179d2bec', 2, 'II', 'Das licht, so meinen Augen (Recit. Tenor)', 'Nur vor euch, ihr schonsten Augen: II. Das licht, so meinen Augen (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24900 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4a4e16-722a-4621-b7c7-b0c4179d2bec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ist es nun so ihr schonen sterne (Aria Tenor)', part.name_en = 'Nur vor euch, ihr schonsten Augen: III. Ist es nun so ihr schonen sterne (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24900 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8056a471-b304-43f3-ac1c-6000f0197b7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8056a471-b304-43f3-ac1c-6000f0197b7d', 3, 'III', 'Ist es nun so ihr schonen sterne (Aria Tenor)', 'Nur vor euch, ihr schonsten Augen: III. Ist es nun so ihr schonen sterne (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24900 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8056a471-b304-43f3-ac1c-6000f0197b7d'
);


-- None Partita di Signore Steltzeln

UPDATE pieces piece
SET piece.title = 'Partita di Signore Steltzeln', piece.title_en = 'Partita di Signore Steltzeln',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23992 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture', part.name_en = 'Partita di Signore Steltzeln: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23992 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a3dfae32-53f4-4886-a2ec-822e4d2185e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3dfae32-53f4-4886-a2ec-822e4d2185e7', 1, 'I', 'Ouverture', 'Partita di Signore Steltzeln: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23992 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3dfae32-53f4-4886-a2ec-822e4d2185e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air Italien', part.name_en = 'Partita di Signore Steltzeln: II. Air Italien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23992 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:09be9707-3169-4ef4-85cb-5a80e2731b5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09be9707-3169-4ef4-85cb-5a80e2731b5c', 2, 'II', 'Air Italien', 'Partita di Signore Steltzeln: II. Air Italien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23992 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09be9707-3169-4ef4-85cb-5a80e2731b5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bourree', part.name_en = 'Partita di Signore Steltzeln: III. Bourree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23992 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:cdb2e898-f0cf-434a-b5a6-50faeece3d7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb2e898-f0cf-434a-b5a6-50faeece3d7f', 3, 'III', 'Bourree', 'Partita di Signore Steltzeln: III. Bourree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23992 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb2e898-f0cf-434a-b5a6-50faeece3d7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Menuet', part.name_en = 'Partita di Signore Steltzeln: IV. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23992 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f512a6b7-de02-45d7-a1e2-de26f1aed81d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f512a6b7-de02-45d7-a1e2-de26f1aed81d', 4, 'IV', 'Menuet', 'Partita di Signore Steltzeln: IV. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23992 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f512a6b7-de02-45d7-a1e2-de26f1aed81d'
);


-- None 세레나데 "Alles, was sonst lieblich heißet"

UPDATE pieces piece
SET piece.title = '세레나데 "Alles, was sonst lieblich heißet"', piece.title_en = 'Serenata "Alles, was sonst lieblich heißet"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24463 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aria, Wie die Sonne Licht und Wonne (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Wie die Sonne Licht und Wonne (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:00e4b42c-715e-4267-ae14-73bb3f4fad33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00e4b42c-715e-4267-ae14-73bb3f4fad33', 1, NULL, 'Aria, Wie die Sonne Licht und Wonne (A)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Wie die Sonne Licht und Wonne (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e4b42c-715e-4267-ae14-73bb3f4fad33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aria, Wie schöne klingt das süße Lobgetöne (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Wie schöne klingt das süße Lobgetöne (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1112ddbb-a86e-4b6d-aac5-986916731e5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1112ddbb-a86e-4b6d-aac5-986916731e5e', 2, NULL, 'Aria, Wie schöne klingt das süße Lobgetöne (S)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Wie schöne klingt das süße Lobgetöne (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1112ddbb-a86e-4b6d-aac5-986916731e5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duetto, Bloß nach dir will ich mich richten (A,B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Duetto, Bloß nach dir will ich mich richten (A,B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:130c3072-68c5-49e7-9470-525692300b0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:130c3072-68c5-49e7-9470-525692300b0f', 3, NULL, 'Duetto, Bloß nach dir will ich mich richten (A,B)', 'Serenata "Alles, was sonst lieblich heißet": Duetto, Bloß nach dir will ich mich richten (A,B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:130c3072-68c5-49e7-9470-525692300b0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Und wie vollkommner Fürst (B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Und wie vollkommner Fürst (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1ac794bf-a15d-4be4-b943-b133a1ba723f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac794bf-a15d-4be4-b943-b133a1ba723f', 4, NULL, 'Recitativo, Und wie vollkommner Fürst (B)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Und wie vollkommner Fürst (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac794bf-a15d-4be4-b943-b133a1ba723f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Aria, Ein Schiff das seinen Leitstern siehet (S', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Ein Schiff das seinen Leitstern siehet (S',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:3d0a3fd8-e9ab-4462-ab50-66ecba694de8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d0a3fd8-e9ab-4462-ab50-66ecba694de8', 5, NULL, 'Aria, Ein Schiff das seinen Leitstern siehet (S', 'Serenata "Alles, was sonst lieblich heißet": Aria, Ein Schiff das seinen Leitstern siehet (S', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d0a3fd8-e9ab-4462-ab50-66ecba694de8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Man nennt die Nachtigall der Wälder Königin (S,A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Man nennt die Nachtigall der Wälder Königin (S,A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:520269ff-b089-4761-ae1e-d0a83436e021' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:520269ff-b089-4761-ae1e-d0a83436e021', 6, NULL, 'Recitativo, Man nennt die Nachtigall der Wälder Königin (S,A)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Man nennt die Nachtigall der Wälder Königin (S,A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:520269ff-b089-4761-ae1e-d0a83436e021'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Aria, Die Biene zieht aus vielen Blumen (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Die Biene zieht aus vielen Blumen (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5211421e-a580-4a0b-b300-b681d1417281' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5211421e-a580-4a0b-b300-b681d1417281', 7, NULL, 'Aria, Die Biene zieht aus vielen Blumen (S)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Die Biene zieht aus vielen Blumen (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5211421e-a580-4a0b-b300-b681d1417281'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Und nennt man mich das Band (T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Und nennt man mich das Band (T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:65f71e91-acf3-4eb6-a07e-1279c5ede320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f71e91-acf3-4eb6-a07e-1279c5ede320', 8, NULL, 'Recitativo, Und nennt man mich das Band (T)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Und nennt man mich das Band (T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f71e91-acf3-4eb6-a07e-1279c5ede320'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Coro À 4, Was sie an dir bewundert haben', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Coro À 4, Was sie an dir bewundert haben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6973971c-5f73-48b6-98b5-490ae5070a15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6973971c-5f73-48b6-98b5-490ae5070a15', 9, NULL, 'Coro À 4, Was sie an dir bewundert haben', 'Serenata "Alles, was sonst lieblich heißet": Coro À 4, Was sie an dir bewundert haben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6973971c-5f73-48b6-98b5-490ae5070a15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Recitativo, O höchst vollkommne Harmonie (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, O höchst vollkommne Harmonie (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:71f2064c-a436-46f8-a59e-323601ba5ea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71f2064c-a436-46f8-a59e-323601ba5ea3', 10, NULL, 'Recitativo, O höchst vollkommne Harmonie (S)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, O höchst vollkommne Harmonie (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71f2064c-a436-46f8-a59e-323601ba5ea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Aria, Was meiner Leitung folgen soll (T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Was meiner Leitung folgen soll (T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:89394e57-102b-491e-b35d-8606a0ee7af1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89394e57-102b-491e-b35d-8606a0ee7af1', 11, NULL, 'Aria, Was meiner Leitung folgen soll (T)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Was meiner Leitung folgen soll (T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89394e57-102b-491e-b35d-8606a0ee7af1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Aria, Die süßesten Züge der lieblichsten Weisen (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Die süßesten Züge der lieblichsten Weisen (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a6201894-e655-477e-bc76-f662b1d80833' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6201894-e655-477e-bc76-f662b1d80833', 12, NULL, 'Aria, Die süßesten Züge der lieblichsten Weisen (A)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Die süßesten Züge der lieblichsten Weisen (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6201894-e655-477e-bc76-f662b1d80833'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Wer ich der Flamme gleich geachtet (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Wer ich der Flamme gleich geachtet (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ace21445-3304-49ad-8525-cd91c79a4905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace21445-3304-49ad-8525-cd91c79a4905', 13, NULL, 'Recitativo, Wer ich der Flamme gleich geachtet (S)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Wer ich der Flamme gleich geachtet (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace21445-3304-49ad-8525-cd91c79a4905'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Der Himmel, der die Tugend liebt (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Der Himmel, der die Tugend liebt (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ad639b2b-de86-4c38-a11a-100ed6a1d79e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad639b2b-de86-4c38-a11a-100ed6a1d79e', 14, NULL, 'Recitativo, Der Himmel, der die Tugend liebt (A)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Der Himmel, der die Tugend liebt (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad639b2b-de86-4c38-a11a-100ed6a1d79e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Ja, ja, vergnüge dich (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ja, ja, vergnüge dich (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ad64d43f-a75c-4198-ae72-691f2eb90249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad64d43f-a75c-4198-ae72-691f2eb90249', 15, NULL, 'Recitativo, Ja, ja, vergnüge dich (A)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ja, ja, vergnüge dich (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad64d43f-a75c-4198-ae72-691f2eb90249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Aria, Die Sonnenblume nicht allein (T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Die Sonnenblume nicht allein (T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:af6e0bd4-05f4-4f5b-b65c-c45b85fe9a32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af6e0bd4-05f4-4f5b-b65c-c45b85fe9a32', 16, NULL, 'Aria, Die Sonnenblume nicht allein (T)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Die Sonnenblume nicht allein (T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af6e0bd4-05f4-4f5b-b65c-c45b85fe9a32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Aria, Philomele, Philomele (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Philomele, Philomele (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:afedb648-8cac-4cf7-9079-de8165f90d5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afedb648-8cac-4cf7-9079-de8165f90d5d', 17, NULL, 'Aria, Philomele, Philomele (S)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Philomele, Philomele (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afedb648-8cac-4cf7-9079-de8165f90d5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Ich habe zwar vernommen (T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ich habe zwar vernommen (T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b1ec131c-f2b0-4bad-b6dc-d0ff7d0f4a44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ec131c-f2b0-4bad-b6dc-d0ff7d0f4a44', 18, NULL, 'Recitativo, Ich habe zwar vernommen (T)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ich habe zwar vernommen (T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ec131c-f2b0-4bad-b6dc-d0ff7d0f4a44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Serenata - Aria, Alles, was sonst lieblich heißet (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Serenata - Aria, Alles, was sonst lieblich heißet (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:bb9dfdbe-adf8-4018-b859-7f1dd79e4a25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb9dfdbe-adf8-4018-b859-7f1dd79e4a25', 19, NULL, 'Serenata - Aria, Alles, was sonst lieblich heißet (S)', 'Serenata "Alles, was sonst lieblich heißet": Serenata - Aria, Alles, was sonst lieblich heißet (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb9dfdbe-adf8-4018-b859-7f1dd79e4a25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Wohlan, weil keine Konsonanz entstehen kann (S,T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Wohlan, weil keine Konsonanz entstehen kann (S,T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:bf0db87f-8968-4171-8ff9-1d3c8efb1b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0db87f-8968-4171-8ff9-1d3c8efb1b41', 20, NULL, 'Recitativo, Wohlan, weil keine Konsonanz entstehen kann (S,T)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Wohlan, weil keine Konsonanz entstehen kann (S,T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0db87f-8968-4171-8ff9-1d3c8efb1b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Aria, Der Himmel läuft Gefahr zu sinken (B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Der Himmel läuft Gefahr zu sinken (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c0408b42-2fcb-4a67-a0f6-2cf3a3293464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0408b42-2fcb-4a67-a0f6-2cf3a3293464', 21, NULL, 'Aria, Der Himmel läuft Gefahr zu sinken (B)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Der Himmel läuft Gefahr zu sinken (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0408b42-2fcb-4a67-a0f6-2cf3a3293464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Ich habe genug gehört (S)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ich habe genug gehört (S)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c51b8102-8ca8-43e0-ac9d-ebd7639041f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c51b8102-8ca8-43e0-ac9d-ebd7639041f7', 22, NULL, 'Recitativo, Ich habe genug gehört (S)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Ich habe genug gehört (S)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c51b8102-8ca8-43e0-ac9d-ebd7639041f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Soll einer fremden Stimme Klang (A,B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Soll einer fremden Stimme Klang (A,B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ca6322b5-9542-430d-9bad-248fcd097495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca6322b5-9542-430d-9bad-248fcd097495', 23, NULL, 'Recitativo, Soll einer fremden Stimme Klang (A,B)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Soll einer fremden Stimme Klang (A,B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6322b5-9542-430d-9bad-248fcd097495'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Vergleicht man der ausgeklärten Luft (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Vergleicht man der ausgeklärten Luft (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d6046d41-557e-4cc1-99f0-66f32f53125e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6046d41-557e-4cc1-99f0-66f32f53125e', 24, NULL, 'Recitativo, Vergleicht man der ausgeklärten Luft (A)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Vergleicht man der ausgeklärten Luft (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6046d41-557e-4cc1-99f0-66f32f53125e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Was einem Baum die frische Wurzel ist (B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Was einem Baum die frische Wurzel ist (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d950cc70-3276-4ef6-862c-c8c99e14596d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d950cc70-3276-4ef6-862c-c8c99e14596d', 25, NULL, 'Recitativo, Was einem Baum die frische Wurzel ist (B)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Was einem Baum die frische Wurzel ist (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d950cc70-3276-4ef6-862c-c8c99e14596d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Recitativo, Euch aber, Werteste (S,A,T,B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Euch aber, Werteste (S,A,T,B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e966d3a3-6337-43c0-b7a1-599e8281493a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e966d3a3-6337-43c0-b7a1-599e8281493a', 26, NULL, 'Recitativo, Euch aber, Werteste (S,A,T,B)', 'Serenata "Alles, was sonst lieblich heißet": Recitativo, Euch aber, Werteste (S,A,T,B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e966d3a3-6337-43c0-b7a1-599e8281493a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Sinfonia', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Sinfonia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ea1f0ea1-4e96-42a4-9324-24d58f220f32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea1f0ea1-4e96-42a4-9324-24d58f220f32', 27, NULL, 'Sinfonia', 'Serenata "Alles, was sonst lieblich heißet": Sinfonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1f0ea1-4e96-42a4-9324-24d58f220f32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Duetto, So scherzen unsere Stimmen (S,T)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Duetto, So scherzen unsere Stimmen (S,T)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:eea17232-a67f-487d-8716-7a7bb026d07f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eea17232-a67f-487d-8716-7a7bb026d07f', 28, NULL, 'Duetto, So scherzen unsere Stimmen (S,T)', 'Serenata "Alles, was sonst lieblich heißet": Duetto, So scherzen unsere Stimmen (S,T)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eea17232-a67f-487d-8716-7a7bb026d07f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Aria, Wenn alles wanket, bricht und sinket (B)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Wenn alles wanket, bricht und sinket (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f46256f4-9c6b-43ef-9834-b83c676cedfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f46256f4-9c6b-43ef-9834-b83c676cedfa', 29, NULL, 'Aria, Wenn alles wanket, bricht und sinket (B)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Wenn alles wanket, bricht und sinket (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f46256f4-9c6b-43ef-9834-b83c676cedfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Aria, Mit tausend Schmeicheleien (A)', part.name_en = 'Serenata "Alles, was sonst lieblich heißet": Aria, Mit tausend Schmeicheleien (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24463 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f7d7805e-323f-4f6d-940b-30815a5f3c69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7d7805e-323f-4f6d-940b-30815a5f3c69', 30, NULL, 'Aria, Mit tausend Schmeicheleien (A)', 'Serenata "Alles, was sonst lieblich heißet": Aria, Mit tausend Schmeicheleien (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24463 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d7805e-323f-4f6d-940b-30815a5f3c69'
);


-- None 세레나데 "Seid willkommen, schöne Stunden"

UPDATE pieces piece
SET piece.title = '세레나데 "Seid willkommen, schöne Stunden"', piece.title_en = 'Serenata, "Seid willkommen, schöne Stunden"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24657 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Recitativo; Wohlan, weil es dem Himmel so gefällt', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recitativo; Wohlan, weil es dem Himmel so gefällt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0eda7f49-fcd9-4c46-bd88-d2e771c5a9c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0eda7f49-fcd9-4c46-bd88-d2e771c5a9c0', 1, NULL, 'Recitativo; Wohlan, weil es dem Himmel so gefällt', 'Serenata, "Seid willkommen, schöne Stunden": Recitativo; Wohlan, weil es dem Himmel so gefällt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0eda7f49-fcd9-4c46-bd88-d2e771c5a9c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Recirativo: Heut muß der Tag vor andern schöne sein', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recirativo: Heut muß der Tag vor andern schöne sein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1825812b-ed30-487e-bf96-62b1f436c198' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1825812b-ed30-487e-bf96-62b1f436c198', 2, NULL, 'Recirativo: Heut muß der Tag vor andern schöne sein', 'Serenata, "Seid willkommen, schöne Stunden": Recirativo: Heut muß der Tag vor andern schöne sein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1825812b-ed30-487e-bf96-62b1f436c198'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Recitativo accompagnato; Ich aber muß bei dieser Zeit', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recitativo accompagnato; Ich aber muß bei dieser Zeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1e8f752c-b435-4033-8eb5-dba0f51f6076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e8f752c-b435-4033-8eb5-dba0f51f6076', 3, NULL, 'Recitativo accompagnato; Ich aber muß bei dieser Zeit', 'Serenata, "Seid willkommen, schöne Stunden": Recitativo accompagnato; Ich aber muß bei dieser Zeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e8f752c-b435-4033-8eb5-dba0f51f6076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Aria: Meine Treu soll dem verbleiben', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Aria: Meine Treu soll dem verbleiben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:21b8d368-a6c0-4b04-9941-72d6c4984bc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21b8d368-a6c0-4b04-9941-72d6c4984bc6', 4, NULL, 'Aria: Meine Treu soll dem verbleiben', 'Serenata, "Seid willkommen, schöne Stunden": Aria: Meine Treu soll dem verbleiben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21b8d368-a6c0-4b04-9941-72d6c4984bc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Aria: Erheiter dein Gesichte', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Aria: Erheiter dein Gesichte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:30a455cb-f850-4163-a472-da43b5969624' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30a455cb-f850-4163-a472-da43b5969624', 5, NULL, 'Aria: Erheiter dein Gesichte', 'Serenata, "Seid willkommen, schöne Stunden": Aria: Erheiter dein Gesichte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30a455cb-f850-4163-a472-da43b5969624'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gigue', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:48efec19-f603-403c-a2f1-fa1de04a9737' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48efec19-f603-403c-a2f1-fa1de04a9737', 6, NULL, 'Gigue', 'Serenata, "Seid willkommen, schöne Stunden": Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48efec19-f603-403c-a2f1-fa1de04a9737'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Recitativo: Soll man Amoenens Licht', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: Soll man Amoenens Licht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:4b9aa963-5936-4587-b45a-97a477884f0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b9aa963-5936-4587-b45a-97a477884f0f', 7, NULL, 'Recitativo: Soll man Amoenens Licht', 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: Soll man Amoenens Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b9aa963-5936-4587-b45a-97a477884f0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Recitativo: Will mir Amoene gleich', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: Will mir Amoene gleich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a21774e3-e0cb-41e5-9498-efea1f82586d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21774e3-e0cb-41e5-9498-efea1f82586d', 8, NULL, 'Recitativo: Will mir Amoene gleich', 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: Will mir Amoene gleich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21774e3-e0cb-41e5-9498-efea1f82586d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Aria: Es kommen die Wolken der Trübsal geschwinde', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Aria: Es kommen die Wolken der Trübsal geschwinde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c1beafe6-2687-4936-af73-ec765700b5a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1beafe6-2687-4936-af73-ec765700b5a2', 9, NULL, 'Aria: Es kommen die Wolken der Trübsal geschwinde', 'Serenata, "Seid willkommen, schöne Stunden": Aria: Es kommen die Wolken der Trübsal geschwinde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1beafe6-2687-4936-af73-ec765700b5a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Duetto: Ich liebe dich wie meine Seele', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Duetto: Ich liebe dich wie meine Seele',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c80ef17f-2a6f-42e9-88ad-15e1902c8fdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c80ef17f-2a6f-42e9-88ad-15e1902c8fdb', 10, NULL, 'Duetto: Ich liebe dich wie meine Seele', 'Serenata, "Seid willkommen, schöne Stunden": Duetto: Ich liebe dich wie meine Seele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c80ef17f-2a6f-42e9-88ad-15e1902c8fdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Aria: Was uns im Anfang bitter scheint', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Aria: Was uns im Anfang bitter scheint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:edf3f3b5-e6e9-411a-9ea2-d49219ea6e26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf3f3b5-e6e9-411a-9ea2-d49219ea6e26', 11, NULL, 'Aria: Was uns im Anfang bitter scheint', 'Serenata, "Seid willkommen, schöne Stunden": Aria: Was uns im Anfang bitter scheint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf3f3b5-e6e9-411a-9ea2-d49219ea6e26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Coro a 4: Seid willkommen, schöne Stunden', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Coro a 4: Seid willkommen, schöne Stunden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f19aeac4-0ac7-4a53-9196-3cbad01558ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f19aeac4-0ac7-4a53-9196-3cbad01558ea', 12, NULL, 'Coro a 4: Seid willkommen, schöne Stunden', 'Serenata, "Seid willkommen, schöne Stunden": Coro a 4: Seid willkommen, schöne Stunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f19aeac4-0ac7-4a53-9196-3cbad01558ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Recitativo: So will Amoene sich bei solchen schönen Tagen', part.name_en = 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: So will Amoene sich bei solchen schönen Tagen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24657 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fa7f7228-cba7-4e94-b037-50376e88d8f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa7f7228-cba7-4e94-b037-50376e88d8f0', 13, NULL, 'Recitativo: So will Amoene sich bei solchen schönen Tagen', 'Serenata, "Seid willkommen, schöne Stunden": Recitativo: So will Amoene sich bei solchen schönen Tagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24657 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa7f7228-cba7-4e94-b037-50376e88d8f0'
);


-- H. 144 칸타타 <Siehe da, eine Hütte Gottes>

UPDATE pieces piece
SET piece.title = '칸타타 <Siehe da, eine Hütte Gottes>', piece.title_en = 'Siehe da, eine Hütte Gottes, H. 144',
    piece.type = 'album', piece.opus_number = 'H. 144',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24954 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Siehe da eine Hütte Gottes bei den Menschen (Coro à 4)', part.name_en = 'Siehe da, eine Hütte Gottes: I. Siehe da eine Hütte Gottes bei den Menschen (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ad073c91-b8e0-47cb-b8ea-0a50920d122e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad073c91-b8e0-47cb-b8ea-0a50920d122e', 1, 'I', 'Siehe da eine Hütte Gottes bei den Menschen (Coro à 4)', 'Siehe da, eine Hütte Gottes: I. Siehe da eine Hütte Gottes bei den Menschen (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad073c91-b8e0-47cb-b8ea-0a50920d122e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Stünd'' jetzt das Paradies (Recit. Soprano / Alto)', part.name_en = 'Siehe da, eine Hütte Gottes: II. Stünd'' jetzt das Paradies (Recit. Soprano / Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c5e5f6f1-d157-4a95-8d81-dc4dfa591324' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e5f6f1-d157-4a95-8d81-dc4dfa591324', 2, 'II', 'Stünd'' jetzt das Paradies (Recit. Soprano / Alto)', 'Siehe da, eine Hütte Gottes: II. Stünd'' jetzt das Paradies (Recit. Soprano / Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e5f6f1-d157-4a95-8d81-dc4dfa591324'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Komm heiliger Geist (Aria Soprano)', part.name_en = 'Siehe da, eine Hütte Gottes: III. Komm heiliger Geist (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d0fe3831-8588-4f82-9e44-7ce66c0c5214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0fe3831-8588-4f82-9e44-7ce66c0c5214', 3, 'III', 'Komm heiliger Geist (Aria Soprano)', 'Siehe da, eine Hütte Gottes: III. Komm heiliger Geist (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0fe3831-8588-4f82-9e44-7ce66c0c5214'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mein Herz! Erwäg es nur, was Gott und Jesus, und wer du? (Recit. Tenor / Bass)', part.name_en = 'Siehe da, eine Hütte Gottes: IV. Mein Herz! Erwäg es nur, was Gott und Jesus, und wer du? (Recit. Tenor / Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:89db80d8-869b-4cde-a46b-a03212cc0ca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89db80d8-869b-4cde-a46b-a03212cc0ca0', 4, 'IV', 'Mein Herz! Erwäg es nur, was Gott und Jesus, und wer du? (Recit. Tenor / Bass)', 'Siehe da, eine Hütte Gottes: IV. Mein Herz! Erwäg es nur, was Gott und Jesus, und wer du? (Recit. Tenor / Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89db80d8-869b-4cde-a46b-a03212cc0ca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Flieht, ihr traurigen Gedanken (Aria Bass)', part.name_en = 'Siehe da, eine Hütte Gottes: V. Flieht, ihr traurigen Gedanken (Aria Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:dd51d4a0-d785-4a98-8aab-206c5b66d67e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd51d4a0-d785-4a98-8aab-206c5b66d67e', 5, 'V', 'Flieht, ihr traurigen Gedanken (Aria Bass)', 'Siehe da, eine Hütte Gottes: V. Flieht, ihr traurigen Gedanken (Aria Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd51d4a0-d785-4a98-8aab-206c5b66d67e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O heiliger Geist, o höchstes Gut (Chorale)', part.name_en = 'Siehe da, eine Hütte Gottes: VI. O heiliger Geist, o höchstes Gut (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24954 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:63711ab4-fcb1-4bf3-abac-96bbfc5a9cc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63711ab4-fcb1-4bf3-abac-96bbfc5a9cc4', 6, 'VI', 'O heiliger Geist, o höchstes Gut (Chorale)', 'Siehe da, eine Hütte Gottes: VI. O heiliger Geist, o höchstes Gut (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24954 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63711ab4-fcb1-4bf3-abac-96bbfc5a9cc4'
);


-- H. 157 칸타타 <So denn ihr, die ihr arg seid>

UPDATE pieces piece
SET piece.title = '칸타타 <So denn ihr, die ihr arg seid>', piece.title_en = 'So denn ihr, die ihr arg seid, H. 157',
    piece.type = 'album', piece.opus_number = 'H. 157',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23921 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'So denn ihr, die ihr arg seid (Coro à 4)', part.name_en = 'So denn ihr, die ihr arg seid: I. So denn ihr, die ihr arg seid (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:59090acd-d4ec-41d3-9719-1dbb21f489d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59090acd-d4ec-41d3-9719-1dbb21f489d4', 1, 'I', 'So denn ihr, die ihr arg seid (Coro à 4)', 'So denn ihr, die ihr arg seid: I. So denn ihr, die ihr arg seid (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59090acd-d4ec-41d3-9719-1dbb21f489d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ist nicht der Eltern Liebe gross? (Recit. Soprano)', part.name_en = 'So denn ihr, die ihr arg seid: II. Ist nicht der Eltern Liebe gross? (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:412a62df-133a-42dd-a5d2-6571624ae74e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:412a62df-133a-42dd-a5d2-6571624ae74e', 2, 'II', 'Ist nicht der Eltern Liebe gross? (Recit. Soprano)', 'So denn ihr, die ihr arg seid: II. Ist nicht der Eltern Liebe gross? (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:412a62df-133a-42dd-a5d2-6571624ae74e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ich werfe mich zu deinen Füssen (Aria Soprano)', part.name_en = 'So denn ihr, die ihr arg seid: III. Ich werfe mich zu deinen Füssen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:743441e1-1fd5-4873-a644-b7ddf06f01d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:743441e1-1fd5-4873-a644-b7ddf06f01d4', 3, 'III', 'Ich werfe mich zu deinen Füssen (Aria Soprano)', 'So denn ihr, die ihr arg seid: III. Ich werfe mich zu deinen Füssen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:743441e1-1fd5-4873-a644-b7ddf06f01d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Wenn die Apostel dort mit Beten (Recit. Alto)', part.name_en = 'So denn ihr, die ihr arg seid: IV. Wenn die Apostel dort mit Beten (Recit. Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:41fe3f18-9b3a-4b4d-9267-22b4749aa015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41fe3f18-9b3a-4b4d-9267-22b4749aa015', 4, 'IV', 'Wenn die Apostel dort mit Beten (Recit. Alto)', 'So denn ihr, die ihr arg seid: IV. Wenn die Apostel dort mit Beten (Recit. Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41fe3f18-9b3a-4b4d-9267-22b4749aa015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Komm, du Himmelstaube (Aria Alto)', part.name_en = 'So denn ihr, die ihr arg seid: V. Komm, du Himmelstaube (Aria Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:0cc3c564-b042-4ada-ae35-3a99820e561c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cc3c564-b042-4ada-ae35-3a99820e561c', 5, 'V', 'Komm, du Himmelstaube (Aria Alto)', 'So denn ihr, die ihr arg seid: V. Komm, du Himmelstaube (Aria Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cc3c564-b042-4ada-ae35-3a99820e561c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Nun bitten wir den heiligen Geist (Chorale)', part.name_en = 'So denn ihr, die ihr arg seid: VI. Nun bitten wir den heiligen Geist (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6f0c06d8-0bf4-48a6-9a52-7d1311292f34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f0c06d8-0bf4-48a6-9a52-7d1311292f34', 6, 'VI', 'Nun bitten wir den heiligen Geist (Chorale)', 'So denn ihr, die ihr arg seid: VI. Nun bitten wir den heiligen Geist (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0c06d8-0bf4-48a6-9a52-7d1311292f34'
);


-- None 트럼펫 협주곡 D장조

UPDATE pieces piece
SET piece.title = '트럼펫 협주곡 D장조', piece.title_en = 'Trumpet Concerto in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25680 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Trumpet Concerto in D major: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25680 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b26b1850-2b4a-438b-8bdd-867a29de136e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b26b1850-2b4a-438b-8bdd-867a29de136e', 1, 'I', 'Allegro', 'Trumpet Concerto in D major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25680 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b26b1850-2b4a-438b-8bdd-867a29de136e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Trumpet Concerto in D major: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25680 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f80881bf-b33b-42ac-b99a-137fa530d4b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f80881bf-b33b-42ac-b99a-137fa530d4b9', 2, 'II', 'Andante', 'Trumpet Concerto in D major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25680 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f80881bf-b33b-42ac-b99a-137fa530d4b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Trumpet Concerto in D major: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25680 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:13c685f2-881e-4966-87ee-af28a55f27da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c685f2-881e-4966-87ee-af28a55f27da', 3, 'III', 'Allegro', 'Trumpet Concerto in D major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25680 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c685f2-881e-4966-87ee-af28a55f27da'
);


-- None 칸타타 <Von dem Einfluß zweier Sternen, H. WK A 27>

UPDATE pieces piece
SET piece.title = '칸타타 <Von dem Einfluß zweier Sternen, H. WK A 27>', piece.title_en = 'Von dem Einfluß zweier Sternen, H. WK A 27',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25101 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Von dem Einfluß zweier Sternen (Aria Soprano)', part.name_en = 'Von dem Einfluß zweier Sternen: I. Von dem Einfluß zweier Sternen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25101 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:228a5c51-881f-4c26-91ee-1018f9e62b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:228a5c51-881f-4c26-91ee-1018f9e62b35', 1, 'I', 'Von dem Einfluß zweier Sternen (Aria Soprano)', 'Von dem Einfluß zweier Sternen: I. Von dem Einfluß zweier Sternen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25101 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:228a5c51-881f-4c26-91ee-1018f9e62b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kein Eisen folgt so sehnend nach (Recit. Tenor)', part.name_en = 'Von dem Einfluß zweier Sternen: II. Kein Eisen folgt so sehnend nach (Recit. Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25101 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a3c86b7b-624a-4407-a926-a69096678534' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3c86b7b-624a-4407-a926-a69096678534', 2, 'II', 'Kein Eisen folgt so sehnend nach (Recit. Tenor)', 'Von dem Einfluß zweier Sternen: II. Kein Eisen folgt so sehnend nach (Recit. Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25101 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3c86b7b-624a-4407-a926-a69096678534'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ich küsse die Hoffnung (Aria Tenor)', part.name_en = 'Von dem Einfluß zweier Sternen: III. Ich küsse die Hoffnung (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25101 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:ad77f5f5-0ca4-4390-b193-04551141763b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad77f5f5-0ca4-4390-b193-04551141763b', 3, 'III', 'Ich küsse die Hoffnung (Aria Tenor)', 'Von dem Einfluß zweier Sternen: III. Ich küsse die Hoffnung (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25101 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad77f5f5-0ca4-4390-b193-04551141763b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Doch armes Herz (Recit. Soprano)', part.name_en = 'Von dem Einfluß zweier Sternen: IV. Doch armes Herz (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25101 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:eff1f1cb-e340-45d6-9713-aedb89e474b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eff1f1cb-e340-45d6-9713-aedb89e474b5', 4, 'IV', 'Doch armes Herz (Recit. Soprano)', 'Von dem Einfluß zweier Sternen: IV. Doch armes Herz (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25101 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eff1f1cb-e340-45d6-9713-aedb89e474b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'So fahret wohl, geliebte Augen (Aria Soprano)', part.name_en = 'Von dem Einfluß zweier Sternen: V. So fahret wohl, geliebte Augen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25101 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:39c01697-cf2d-4d89-94db-38428578d47b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39c01697-cf2d-4d89-94db-38428578d47b', 5, 'V', 'So fahret wohl, geliebte Augen (Aria Soprano)', 'Von dem Einfluß zweier Sternen: V. So fahret wohl, geliebte Augen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25101 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39c01697-cf2d-4d89-94db-38428578d47b'
);


-- H. 147 칸타타 <Werdet voll Geistes>

UPDATE pieces piece
SET piece.title = '칸타타 <Werdet voll Geistes>', piece.title_en = 'Werdet voll Geistes, H. 147',
    piece.type = 'album', piece.opus_number = 'H. 147',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25921 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Werdet voll Geistes (Coro à 4)', part.name_en = 'Werdet voll Geistes: I. Werdet voll Geistes (Coro à 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:31bc6a27-4909-41d9-9011-90158affd1ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31bc6a27-4909-41d9-9011-90158affd1ec', 1, 'I', 'Werdet voll Geistes (Coro à 4)', 'Werdet voll Geistes: I. Werdet voll Geistes (Coro à 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31bc6a27-4909-41d9-9011-90158affd1ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Was saust so sanft und so gelinde! (Aria Tenor)', part.name_en = 'Werdet voll Geistes: II. Was saust so sanft und so gelinde! (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8c17528b-5ea8-4ab0-9636-2a698d12fe77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c17528b-5ea8-4ab0-9636-2a698d12fe77', 2, 'II', 'Was saust so sanft und so gelinde! (Aria Tenor)', 'Werdet voll Geistes: II. Was saust so sanft und so gelinde! (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c17528b-5ea8-4ab0-9636-2a698d12fe77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ah ja! Ich fühl es schon (Recit. Alto, Tenor)', part.name_en = 'Werdet voll Geistes: III. Ah ja! Ich fühl es schon (Recit. Alto, Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:be71c0f9-94be-4ecc-abb1-ee1cfac2872b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be71c0f9-94be-4ecc-abb1-ee1cfac2872b', 3, 'III', 'Ah ja! Ich fühl es schon (Recit. Alto, Tenor)', 'Werdet voll Geistes: III. Ah ja! Ich fühl es schon (Recit. Alto, Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be71c0f9-94be-4ecc-abb1-ee1cfac2872b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Soll ich voll Geistes werden? (Aria, Alto)', part.name_en = 'Werdet voll Geistes: IV. Soll ich voll Geistes werden? (Aria, Alto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1c30ae3b-d14b-41ca-a33e-6460c661af29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c30ae3b-d14b-41ca-a33e-6460c661af29', 4, 'IV', 'Soll ich voll Geistes werden? (Aria, Alto)', 'Werdet voll Geistes: IV. Soll ich voll Geistes werden? (Aria, Alto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c30ae3b-d14b-41ca-a33e-6460c661af29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Wenn die Apostel nicht vom Wein (Recit. Tenor) / Komm, heiliger Geist, Herr Gott (Chorale)', part.name_en = 'Werdet voll Geistes: V. Wenn die Apostel nicht vom Wein (Recit. Tenor) / Komm, heiliger Geist, Herr Gott (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25921 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:04459efc-efad-4994-8961-ee87f46e3f03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04459efc-efad-4994-8961-ee87f46e3f03', 5, 'V', 'Wenn die Apostel nicht vom Wein (Recit. Tenor) / Komm, heiliger Geist, Herr Gott (Chorale)', 'Werdet voll Geistes: V. Wenn die Apostel nicht vom Wein (Recit. Tenor) / Komm, heiliger Geist, Herr Gott (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25921 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04459efc-efad-4994-8961-ee87f46e3f03'
);


-- None 칸타타 <Wir haben ein festes prophetisches Wort>

UPDATE pieces piece
SET piece.title = '칸타타 <Wir haben ein festes prophetisches Wort>', piece.title_en = 'Wir haben ein festes prophetisches Wort',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23716 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Wir haben ein festes prophetisches Wort (Tutti)', part.name_en = 'Wir haben ein festes prophetisches Wort: I. Wir haben ein festes prophetisches Wort (Tutti)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1ca6b480-a57c-4501-93f6-b79548fb5446' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ca6b480-a57c-4501-93f6-b79548fb5446', 1, 'I', 'Wir haben ein festes prophetisches Wort (Tutti)', 'Wir haben ein festes prophetisches Wort: I. Wir haben ein festes prophetisches Wort (Tutti)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca6b480-a57c-4501-93f6-b79548fb5446'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Das Auge mag denn immerhin', part.name_en = 'Wir haben ein festes prophetisches Wort: III. Das Auge mag denn immerhin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:26ba7ac7-bbeb-48c0-8280-a73a855f8ba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26ba7ac7-bbeb-48c0-8280-a73a855f8ba6', 2, 'III', 'Das Auge mag denn immerhin', 'Wir haben ein festes prophetisches Wort: III. Das Auge mag denn immerhin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26ba7ac7-bbeb-48c0-8280-a73a855f8ba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Die Schar der Weisen', part.name_en = 'Wir haben ein festes prophetisches Wort: V. Die Schar der Weisen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b1de7388-4fac-4cf0-890d-c07f4353662a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1de7388-4fac-4cf0-890d-c07f4353662a', 3, 'V', 'Die Schar der Weisen', 'Wir haben ein festes prophetisches Wort: V. Die Schar der Weisen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1de7388-4fac-4cf0-890d-c07f4353662a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VI',
    part.name_ko = 'Drum, Herr Christ, du Morgensterne (Chorale)', part.name_en = 'Wir haben ein festes prophetisches Wort: VI. Drum, Herr Christ, du Morgensterne (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c1952bfa-0e2b-4b00-8017-a0840e84306f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1952bfa-0e2b-4b00-8017-a0840e84306f', 4, 'VI', 'Drum, Herr Christ, du Morgensterne (Chorale)', 'Wir haben ein festes prophetisches Wort: VI. Drum, Herr Christ, du Morgensterne (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1952bfa-0e2b-4b00-8017-a0840e84306f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'Was kann ein Auge mehr erfreuen', part.name_en = 'Wir haben ein festes prophetisches Wort: II. Was kann ein Auge mehr erfreuen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:d0aebed6-ccab-48d7-b4bc-42be99f2a244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0aebed6-ccab-48d7-b4bc-42be99f2a244', 5, 'II', 'Was kann ein Auge mehr erfreuen', 'Wir haben ein festes prophetisches Wort: II. Was kann ein Auge mehr erfreuen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0aebed6-ccab-48d7-b4bc-42be99f2a244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'IV',
    part.name_ko = 'Wo Sterne, muß der Himmel sein', part.name_en = 'Wir haben ein festes prophetisches Wort: IV. Wo Sterne, muß der Himmel sein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23716 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:fa8ee2a1-7752-4868-92b0-08a5d1ba8dbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8ee2a1-7752-4868-92b0-08a5d1ba8dbb', 6, 'IV', 'Wo Sterne, muß der Himmel sein', 'Wir haben ein festes prophetisches Wort: IV. Wo Sterne, muß der Himmel sein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23716 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8ee2a1-7752-4868-92b0-08a5d1ba8dbb'
);


-- H. 151 칸타타 <Wollte Gott, dass alle das Volk>

UPDATE pieces piece
SET piece.title = '칸타타 <Wollte Gott, dass alle das Volk>', piece.title_en = 'Wollte Gott, dass alle das Volk, H. 151',
    piece.type = 'album', piece.opus_number = 'H. 151',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24840 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Wollte Gott, dass alle das Volk..(Aria Bass)', part.name_en = 'Wollte Gott, dass alle das Volk: I. Wollte Gott, dass alle das Volk..(Aria Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:cf61bac9-f637-48d2-ab30-8c1e5a05a701' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf61bac9-f637-48d2-ab30-8c1e5a05a701', 1, 'I', 'Wollte Gott, dass alle das Volk..(Aria Bass)', 'Wollte Gott, dass alle das Volk: I. Wollte Gott, dass alle das Volk..(Aria Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf61bac9-f637-48d2-ab30-8c1e5a05a701'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Unerschaffne Gottheitssonne (Aria Tenor)', part.name_en = 'Wollte Gott, dass alle das Volk: II. Unerschaffne Gottheitssonne (Aria Tenor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1f1a0e15-0c35-4213-9148-dce842eb0c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1a0e15-0c35-4213-9148-dce842eb0c4d', 2, 'II', 'Unerschaffne Gottheitssonne (Aria Tenor)', 'Wollte Gott, dass alle das Volk: II. Unerschaffne Gottheitssonne (Aria Tenor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1a0e15-0c35-4213-9148-dce842eb0c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Wirkt das grosse sichtbare grosse Licht (Recit. Tenor / Bass)', part.name_en = 'Wollte Gott, dass alle das Volk: III. Wirkt das grosse sichtbare grosse Licht (Recit. Tenor / Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:bb3d1946-3b27-4eb8-b6b7-cbfddfa53c7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb3d1946-3b27-4eb8-b6b7-cbfddfa53c7a', 3, 'III', 'Wirkt das grosse sichtbare grosse Licht (Recit. Tenor / Bass)', 'Wollte Gott, dass alle das Volk: III. Wirkt das grosse sichtbare grosse Licht (Recit. Tenor / Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb3d1946-3b27-4eb8-b6b7-cbfddfa53c7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fällt der Geist auf alle (Aria Bass)', part.name_en = 'Wollte Gott, dass alle das Volk: IV. Fällt der Geist auf alle (Aria Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:f72ed3d8-30e9-4317-acb4-092094ef774d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f72ed3d8-30e9-4317-acb4-092094ef774d', 4, 'IV', 'Fällt der Geist auf alle (Aria Bass)', 'Wollte Gott, dass alle das Volk: IV. Fällt der Geist auf alle (Aria Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f72ed3d8-30e9-4317-acb4-092094ef774d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dort gabst du, heilig guter Geist! (Recit. Bass)', part.name_en = 'Wollte Gott, dass alle das Volk: V. Dort gabst du, heilig guter Geist! (Recit. Bass)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:1c3e59fd-303b-4f47-a46d-4f3c1cf418e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c3e59fd-303b-4f47-a46d-4f3c1cf418e4', 5, 'V', 'Dort gabst du, heilig guter Geist! (Recit. Bass)', 'Wollte Gott, dass alle das Volk: V. Dort gabst du, heilig guter Geist! (Recit. Bass)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c3e59fd-303b-4f47-a46d-4f3c1cf418e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O heiliger Geist, o heiliger Gott (Chorale)', part.name_en = 'Wollte Gott, dass alle das Volk: VI. O heiliger Geist, o heiliger Gott (Chorale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24840 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:8e60443c-1465-4273-8698-7fe4429987ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e60443c-1465-4273-8698-7fe4429987ee', 6, 'VI', 'O heiliger Geist, o heiliger Gott (Chorale)', 'Wollte Gott, dass alle das Volk: VI. O heiliger Geist, o heiliger Gott (Chorale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24840 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e60443c-1465-4273-8698-7fe4429987ee'
);


-- H. 26 칸타타 <Zorn'ge Sterne, laßt mich sterben>

UPDATE pieces piece
SET piece.title = '칸타타 <Zorn''ge Sterne, laßt mich sterben>', piece.title_en = 'Zorn''ge Sterne, laßt mich sterben, H. 26',
    piece.type = 'album', piece.opus_number = 'H. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25003 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Zorn''ge Sterne, laßt mich sterben (Aria (Accompagnato?) , Soprano)', part.name_en = 'Zorn''ge Sterne, laßt mich sterben: I. Zorn''ge Sterne, laßt mich sterben (Aria (Accompagnato?) , Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25003 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:6e89ead1-8d2f-48f8-ba97-6f6658a9f5fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e89ead1-8d2f-48f8-ba97-6f6658a9f5fe', 1, 'I', 'Zorn''ge Sterne, laßt mich sterben (Aria (Accompagnato?) , Soprano)', 'Zorn''ge Sterne, laßt mich sterben: I. Zorn''ge Sterne, laßt mich sterben (Aria (Accompagnato?) , Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25003 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e89ead1-8d2f-48f8-ba97-6f6658a9f5fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Grausamer Schluß (Recit. Soprano)', part.name_en = 'Zorn''ge Sterne, laßt mich sterben: II. Grausamer Schluß (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25003 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c9d617fb-8a57-4768-9b04-8a44741d7c2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9d617fb-8a57-4768-9b04-8a44741d7c2b', 2, 'II', 'Grausamer Schluß (Recit. Soprano)', 'Zorn''ge Sterne, laßt mich sterben: II. Grausamer Schluß (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25003 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d617fb-8a57-4768-9b04-8a44741d7c2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mein Herze Schwimmt In Blut und Tränen (Aria Soprano)', part.name_en = 'Zorn''ge Sterne, laßt mich sterben: III. Mein Herze Schwimmt In Blut und Tränen (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25003 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:5599eba7-854b-4db9-952c-6ae3e450e0ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5599eba7-854b-4db9-952c-6ae3e450e0ba', 3, 'III', 'Mein Herze Schwimmt In Blut und Tränen (Aria Soprano)', 'Zorn''ge Sterne, laßt mich sterben: III. Mein Herze Schwimmt In Blut und Tränen (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25003 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5599eba7-854b-4db9-952c-6ae3e450e0ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O bittrer Kuß, der gall und wermut bei sich fuhrt (Recitativo Soprano)', part.name_en = 'Zorn''ge Sterne, laßt mich sterben: IV. O bittrer Kuß, der gall und wermut bei sich fuhrt (Recitativo Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25003 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:a210c1ff-4e4e-48db-9275-bd5488495e70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a210c1ff-4e4e-48db-9275-bd5488495e70', 4, 'IV', 'O bittrer Kuß, der gall und wermut bei sich fuhrt (Recitativo Soprano)', 'Zorn''ge Sterne, laßt mich sterben: IV. O bittrer Kuß, der gall und wermut bei sich fuhrt (Recitativo Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25003 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a210c1ff-4e4e-48db-9275-bd5488495e70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Zorn''ge Sterne (Aria dacapo Soprano)', part.name_en = 'Zorn''ge Sterne, laßt mich sterben: V. Zorn''ge Sterne (Aria dacapo Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25003 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:c22a08f5-81ba-4775-aa65-8221dbb6574b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c22a08f5-81ba-4775-aa65-8221dbb6574b', 5, 'V', 'Zorn''ge Sterne (Aria dacapo Soprano)', 'Zorn''ge Sterne, laßt mich sterben: V. Zorn''ge Sterne (Aria dacapo Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25003 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c22a08f5-81ba-4775-aa65-8221dbb6574b'
);


-- None 칸타타 <Zu guter Nacht, ihr stolzen Türme und Paläste, H. WK A 23>

UPDATE pieces piece
SET piece.title = '칸타타 <Zu guter Nacht, ihr stolzen Türme und Paläste, H. WK A 23>', piece.title_en = 'Zu guter Nacht, ihr stolzen Türme und Paläste, H. WK A 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25780 AND piece.composer_id = 373
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Zu guter Nacht, ihr stolzen Türme und Paläste (Recit. Soprano)', part.name_en = 'Zu guter Nacht, ihr stolzen Türme und Paläste: I. Zu guter Nacht, ihr stolzen Türme und Paläste (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25780 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:e1ae7bce-be7f-42f5-b6e8-7df023c1d253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1ae7bce-be7f-42f5-b6e8-7df023c1d253', 1, 'I', 'Zu guter Nacht, ihr stolzen Türme und Paläste (Recit. Soprano)', 'Zu guter Nacht, ihr stolzen Türme und Paläste: I. Zu guter Nacht, ihr stolzen Türme und Paläste (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25780 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1ae7bce-be7f-42f5-b6e8-7df023c1d253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Geh und eile geschwind (Aria Soprano)', part.name_en = 'Zu guter Nacht, ihr stolzen Türme und Paläste: II. Geh und eile geschwind (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25780 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:2cd9e78e-e983-4304-a142-6e0fbeeadab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cd9e78e-e983-4304-a142-6e0fbeeadab5', 2, 'II', 'Geh und eile geschwind (Aria Soprano)', 'Zu guter Nacht, ihr stolzen Türme und Paläste: II. Geh und eile geschwind (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25780 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cd9e78e-e983-4304-a142-6e0fbeeadab5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'So lange mich die Stadt in festen Mauern (Recit. Soprano)', part.name_en = 'Zu guter Nacht, ihr stolzen Türme und Paläste: III. So lange mich die Stadt in festen Mauern (Recit. Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25780 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:b8cc345c-f0f9-47ec-bf06-dff7fc9489f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8cc345c-f0f9-47ec-bf06-dff7fc9489f9', 3, 'III', 'So lange mich die Stadt in festen Mauern (Recit. Soprano)', 'Zu guter Nacht, ihr stolzen Türme und Paläste: III. So lange mich die Stadt in festen Mauern (Recit. Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25780 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8cc345c-f0f9-47ec-bf06-dff7fc9489f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ruhe und Zufriedenheit (Aria Soprano)', part.name_en = 'Zu guter Nacht, ihr stolzen Türme und Paläste: IV. Ruhe und Zufriedenheit (Aria Soprano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25780 AND p.composer_id = 373 AND part.part_key = 'musicbrainz:baaea255-c862-4e4c-8cf4-502e43c21176' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baaea255-c862-4e4c-8cf4-502e43c21176', 4, 'IV', 'Ruhe und Zufriedenheit (Aria Soprano)', 'Zu guter Nacht, ihr stolzen Türme und Paläste: IV. Ruhe und Zufriedenheit (Aria Soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25780 AND p.composer_id = 373
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baaea255-c862-4e4c-8cf4-502e43c21176'
);


-- None 소나타 1번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 1번 F장조', 'Sonata no. 1 in F major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 373
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 1번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e917fa8-52a2-4dfc-8d22-baf5e081710f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e917fa8-52a2-4dfc-8d22-baf5e081710f'
FROM pieces p
WHERE p.composer_id = 373 AND p.title = '소나타 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e917fa8-52a2-4dfc-8d22-baf5e081710f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d51bd61-6900-4307-9b96-49bf65728c90', 1, 'I', 'Allegro', 'Sonata no. 1 in F major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 373 AND p.title = '소나타 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d51bd61-6900-4307-9b96-49bf65728c90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11816606-60ce-4705-81f3-417329e0fec9', 2, 'II', 'Adagio', 'Sonata no. 1 in F major: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 373 AND p.title = '소나타 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11816606-60ce-4705-81f3-417329e0fec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d846ce09-9c34-4cff-8f70-4ef1f3d16fd6', 3, 'III', 'Allegro', 'Sonata no. 1 in F major: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 373 AND p.title = '소나타 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d846ce09-9c34-4cff-8f70-4ef1f3d16fd6'
);


-- 카탈로그에 대응이 없는 seed 작품 4개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 373 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15791, 23094, 24641, 25301
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
