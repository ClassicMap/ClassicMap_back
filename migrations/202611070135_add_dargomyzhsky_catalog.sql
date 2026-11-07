-- 알렉산드르 다르고미시스키 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 16개(묶음 2, 다악장 0, 낱곡 14),
-- 새 작품 0개, part 10개, 그 아래 20개.
-- seed 22개 중 16개를 작품·part 에 잇고, 6개를 숨기고, 0개는 그대로 둔다.
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

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Петербургские серенады (중복 18032)'
WHERE piece.id = 18032 AND piece.composer_id = 149 AND piece.title = 'Петербургские серенады'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 가곡 <Au bal>

UPDATE pieces piece
SET piece.title = '가곡 <Au bal>', piece.title_en = 'Au bal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17604 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Baba Yaga

UPDATE pieces piece
SET piece.title = 'Baba Yaga', piece.title_en = 'Baba Yaga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18061 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 볼레로

UPDATE pieces piece
SET piece.title = '볼레로', piece.title_en = 'Bolero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18405 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dieu qui sourit>

UPDATE pieces piece
SET piece.title = '가곡 <Dieu qui sourit>', piece.title_en = 'Dieu qui sourit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18058 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 엘레지 "Она придёт"

UPDATE pieces piece
SET piece.title = '엘레지 "Она придёт"', piece.title_en = 'Elegy "Она придёт"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15800 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Am Sad>

UPDATE pieces piece
SET piece.title = '가곡 <I Am Sad>', piece.title_en = 'I Am Sad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17228 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <K druz'yam>

UPDATE pieces piece
SET piece.title = '가곡 <K druz''yam>', piece.title_en = 'K druz''yam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19825 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kazachok

UPDATE pieces piece
SET piece.title = 'Kazachok', piece.title_en = 'Kazachok',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17445 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Rusalka>

UPDATE pieces piece
SET piece.title = '오페라 <Rusalka>', piece.title_en = 'Rusalka',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15851 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Rusalka: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:dc00da31-40ba-4fcd-8098-e77904b1fc9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc00da31-40ba-4fcd-8098-e77904b1fc9c', 1, NULL, 'Overture', 'Rusalka: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc00da31-40ba-4fcd-8098-e77904b1fc9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Rusalka: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4', 2, NULL, 'Act I', 'Rusalka: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ария. «Охъ, то-то всѣ вы, дѣвки молодыя»', part.name_en = 'Русалка, Действие I: No. 1. Ария. «Охъ, то-то всѣ вы, дѣвки молодыя»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:1fae71fa-bd34-4109-9e3b-ecf86edfabb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fae71fa-bd34-4109-9e3b-ecf86edfabb9', 1, NULL, 'Ария. «Охъ, то-то всѣ вы, дѣвки молодыя»', 'Русалка, Действие I: No. 1. Ария. «Охъ, то-то всѣ вы, дѣвки молодыя»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fae71fa-bd34-4109-9e3b-ecf86edfabb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Терцет. «Чу, я слышу топотъ его коня»', part.name_en = 'Русалка, Действие I: No. 2. Терцет. «Чу, я слышу топотъ его коня»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:4d58a268-2535-429b-9605-af11530f5c06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d58a268-2535-429b-9605-af11530f5c06', 2, NULL, 'Терцет. «Чу, я слышу топотъ его коня»', 'Русалка, Действие I: No. 2. Терцет. «Чу, я слышу топотъ его коня»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d58a268-2535-429b-9605-af11530f5c06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Хоры и хороводы', part.name_en = 'Русалка, Действие I: No. 3. Хоры и хороводы',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:9a936ae4-e828-4f3e-9808-ded22cfe1205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a936ae4-e828-4f3e-9808-ded22cfe1205', 3, NULL, 'Хоры и хороводы', 'Русалка, Действие I: No. 3. Хоры и хороводы', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a936ae4-e828-4f3e-9808-ded22cfe1205'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Дуэт. «Нѣтъ, не разсѣетъ думъ тяжелыхъ»', part.name_en = 'Русалка, Действие I: No. 4. Дуэт. «Нѣтъ, не разсѣетъ думъ тяжелыхъ»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:98e9baad-2bf2-48d9-951a-4a76a15fa9b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98e9baad-2bf2-48d9-951a-4a76a15fa9b2', 4, NULL, 'Дуэт. «Нѣтъ, не разсѣетъ думъ тяжелыхъ»', 'Русалка, Действие I: No. 4. Дуэт. «Нѣтъ, не разсѣетъ думъ тяжелыхъ»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98e9baad-2bf2-48d9-951a-4a76a15fa9b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Дуэт. «Ба, ба, ба, что вижу!»', part.name_en = 'Русалка, Действие I: No. 5. Дуэт. «Ба, ба, ба, что вижу!»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:c8e80f88-69db-43f7-b359-a5977dde5a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8e80f88-69db-43f7-b359-a5977dde5a29', 5, NULL, 'Дуэт. «Ба, ба, ба, что вижу!»', 'Русалка, Действие I: No. 5. Дуэт. «Ба, ба, ба, что вижу!»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8e80f88-69db-43f7-b359-a5977dde5a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Финал. «Ахъ, ты поле мое, поле»', part.name_en = 'Русалка, Действие I: No. 6. Финал. «Ахъ, ты поле мое, поле»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:19ce8640-98f9-4abd-9f35-c1c6cca59671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19ce8640-98f9-4abd-9f35-c1c6cca59671', 6, NULL, 'Финал. «Ахъ, ты поле мое, поле»', 'Русалка, Действие I: No. 6. Финал. «Ахъ, ты поле мое, поле»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:985f4d6a-d8e8-49ab-904f-94477bb913c4'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ce8640-98f9-4abd-9f35-c1c6cca59671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Rusalka: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252', 3, NULL, 'Act II', 'Rusalka: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Свадебный хор. «Какъ во горницѣ-свѣтлицѣ»', part.name_en = 'Русалка, Действие II: No. 7. Свадебный хор. «Какъ во горницѣ-свѣтлицѣ»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:d6de453f-4274-417c-8500-f6bf7fa44f4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6de453f-4274-417c-8500-f6bf7fa44f4b', 1, NULL, 'Свадебный хор. «Какъ во горницѣ-свѣтлицѣ»', 'Русалка, Действие II: No. 7. Свадебный хор. «Какъ во горницѣ-свѣтлицѣ»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6de453f-4274-417c-8500-f6bf7fa44f4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ария Дуэт. «Подруги дѣтства, подруги юныхъ дней»', part.name_en = 'Русалка, Действие II: No. 8. Ария Дуэт. «Подруги дѣтства, подруги юныхъ дней»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:22d14431-4c5e-434a-93ce-17596629217b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22d14431-4c5e-434a-93ce-17596629217b', 2, NULL, 'Ария Дуэт. «Подруги дѣтства, подруги юныхъ дней»', 'Русалка, Действие II: No. 8. Ария Дуэт. «Подруги дѣтства, подруги юныхъ дней»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d14431-4c5e-434a-93ce-17596629217b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Речитатив. «А гдѣ дружокъ?» - Заздравный хор. «Да здравствуетъ нашъ князь младой»', part.name_en = 'Русалка, Действие II: No. 9. Речитатив. «А гдѣ дружокъ?» - Заздравный хор. «Да здравствуетъ нашъ князь младой»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:5c2756db-919a-4382-8ea6-8b9e2ed6ff83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c2756db-919a-4382-8ea6-8b9e2ed6ff83', 3, NULL, 'Речитатив. «А гдѣ дружокъ?» - Заздравный хор. «Да здравствуетъ нашъ князь младой»', 'Русалка, Действие II: No. 9. Речитатив. «А гдѣ дружокъ?» - Заздравный хор. «Да здравствуетъ нашъ князь младой»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2756db-919a-4382-8ea6-8b9e2ed6ff83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Славянский танец', part.name_en = 'Русалка, Действие II: No. 10. Славянский танец',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:152cb845-a250-4623-9bb3-e46f2d5993b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:152cb845-a250-4623-9bb3-e46f2d5993b8', 4, NULL, 'Славянский танец', 'Русалка, Действие II: No. 10. Славянский танец', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152cb845-a250-4623-9bb3-e46f2d5993b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Цыганский танецъ', part.name_en = 'Русалка, Действие II: No. 11. Цыганский танецъ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:73b4cabb-8e8c-48d6-ac23-280ed6c65b1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73b4cabb-8e8c-48d6-ac23-280ed6c65b1e', 5, NULL, 'Цыганский танецъ', 'Русалка, Действие II: No. 11. Цыганский танецъ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b4cabb-8e8c-48d6-ac23-280ed6c65b1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Финал. «Чтожъ, красныя дѣвицы, примолкли»', part.name_en = 'Русалка, Действие II: No. 12. Финал. «Чтожъ, красныя дѣвицы, примолкли»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:a30ebf54-bb4b-430a-b10f-7de3895f4c3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a30ebf54-bb4b-430a-b10f-7de3895f4c3e', 6, NULL, 'Финал. «Чтожъ, красныя дѣвицы, примолкли»', 'Русалка, Действие II: No. 12. Финал. «Чтожъ, красныя дѣвицы, примолкли»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0782652-f4ae-4f10-8cdf-046f36d18252'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a30ebf54-bb4b-430a-b10f-7de3895f4c3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Rusalka: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6', 4, NULL, 'Act III', 'Rusalka: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ария. «Чу, кажется, трубитъ»', part.name_en = 'Русалка, Действие III: No. 13. Ария. «Чу, кажется, трубитъ»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:4a1a2b69-687a-44e1-9c4b-0b984bd47b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a1a2b69-687a-44e1-9c4b-0b984bd47b0e', 1, NULL, 'Ария. «Чу, кажется, трубитъ»', 'Русалка, Действие III: No. 13. Ария. «Чу, кажется, трубитъ»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a1a2b69-687a-44e1-9c4b-0b984bd47b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Речитатив и Пѣсня. «Княгиня бѣдная»', part.name_en = 'Русалка, Действие III: No. 14. Речитатив и Пѣсня. «Княгиня бѣдная»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:7e6122c5-2564-4cb0-9547-11cc31498ac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e6122c5-2564-4cb0-9547-11cc31498ac0', 2, NULL, 'Речитатив и Пѣсня. «Княгиня бѣдная»', 'Русалка, Действие III: No. 14. Речитатив и Пѣсня. «Княгиня бѣдная»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e6122c5-2564-4cb0-9547-11cc31498ac0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Хор русалок. «Свободной толпою»', part.name_en = 'Русалка, Действие III: No. 15. Хор русалок. «Свободной толпою»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:87527b32-5d6e-4182-ae1b-6a348b7b9872' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87527b32-5d6e-4182-ae1b-6a348b7b9872', 3, NULL, 'Хор русалок. «Свободной толпою»', 'Русалка, Действие III: No. 15. Хор русалок. «Свободной толпою»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87527b32-5d6e-4182-ae1b-6a348b7b9872'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Каватина. «Невольно къ этимъ грустнымъ берегамъ меня влечётъ»', part.name_en = 'Русалка, Действие III: No. 16. Каватина. «Невольно къ этимъ грустнымъ берегамъ меня влечётъ»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:7eff1256-cd82-475c-8c42-45415650b1c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7eff1256-cd82-475c-8c42-45415650b1c5', 4, NULL, 'Каватина. «Невольно къ этимъ грустнымъ берегамъ меня влечётъ»', 'Русалка, Действие III: No. 16. Каватина. «Невольно къ этимъ грустнымъ берегамъ меня влечётъ»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eff1256-cd82-475c-8c42-45415650b1c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Дуэт съ хором. «Что это значитъ?»', part.name_en = 'Русалка, Действие III: No. 17. Дуэт съ хором. «Что это значитъ?»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:081b35a0-8510-43ee-bca6-8edbec80daa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:081b35a0-8510-43ee-bca6-8edbec80daa5', 5, NULL, 'Дуэт съ хором. «Что это значитъ?»', 'Русалка, Действие III: No. 17. Дуэт съ хором. «Что это значитъ?»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:55e6ae29-3976-4f83-9eb1-ea8546a637a6'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:081b35a0-8510-43ee-bca6-8edbec80daa5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act IV', part.name_en = 'Rusalka: Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268', 5, NULL, 'Act IV', 'Rusalka: Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Танцы русалок', part.name_en = 'Русалка, Действие IV: No. 18. Танцы русалок',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:32f546a0-ab7a-4b64-b4d9-5bf5f63a8c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32f546a0-ab7a-4b64-b4d9-5bf5f63a8c4d', 1, NULL, 'Танцы русалок', 'Русалка, Действие IV: No. 18. Танцы русалок', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f546a0-ab7a-4b64-b4d9-5bf5f63a8c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Сцена и Ария. «Оставьте пряжу, сестры»', part.name_en = 'Русалка, Действие IV: No. 19. Сцена и Ария. «Оставьте пряжу, сестры»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:a2a62da4-56a9-4f17-8d57-79b1e52761ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2a62da4-56a9-4f17-8d57-79b1e52761ec', 2, NULL, 'Сцена и Ария. «Оставьте пряжу, сестры»', 'Русалка, Действие IV: No. 19. Сцена и Ария. «Оставьте пряжу, сестры»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a62da4-56a9-4f17-8d57-79b1e52761ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Финал. «Что я вижу! откуда ты, прелестное дитя»', part.name_en = 'Русалка, Действие IV: No. 20. Финал. «Что я вижу! откуда ты, прелестное дитя»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15851 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:c3547b96-113e-44f3-a45a-a3f74efa92a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3547b96-113e-44f3-a45a-a3f74efa92a7', 3, NULL, 'Финал. «Что я вижу! откуда ты, прелестное дитя»', 'Русалка, Действие IV: No. 20. Финал. «Что я вижу! откуда ты, прелестное дитя»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60306ed-276c-414d-a8c4-e019ce115268'
WHERE p.id = 15851 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3547b96-113e-44f3-a45a-a3f74efa92a7'
);


-- None 아리아 <Rusalka: Act 3: "Chto eto znachit?">

UPDATE pieces piece
SET piece.title = '아리아 <Rusalka: Act 3: "Chto eto znachit?">', piece.title_en = 'Rusalka: Act 3: "Chto eto znachit?"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18582 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 아리아 <Rusalka: Act 3: "Nevol’no k etim grustnyim beregam">

UPDATE pieces piece
SET piece.title = '아리아 <Rusalka: Act 3: "Nevol’no k etim grustnyim beregam">', piece.title_en = 'Rusalka: Act 3: "Nevol’no k etim grustnyim beregam"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16508 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tarantella slave

UPDATE pieces piece
SET piece.title = 'Tarantella slave', piece.title_en = 'Tarantella slave',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17412 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Miller>

UPDATE pieces piece
SET piece.title = '가곡 <The Miller>', piece.title_en = 'The Miller',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19757 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Night Zephyr>

UPDATE pieces piece
SET piece.title = '가곡 <The Night Zephyr>', piece.title_en = 'The Night Zephyr',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19024 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <« Jaloux du bel objet »>

UPDATE pieces piece
SET piece.title = '가곡 <« Jaloux du bel objet »>', piece.title_en = '« Jaloux du bel objet »',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16496 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Петербургские серенады

UPDATE pieces piece
SET piece.title = 'Петербургские серенады', piece.title_en = 'Петербургские серенады',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15795 AND piece.composer_id = 149
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ворон к ворону летит', part.name_en = 'Петербургские серенады: Ворон к ворону летит',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15795 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:0d8cddc7-f9e9-4ea0-b15f-1c6bbd09bd5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d8cddc7-f9e9-4ea0-b15f-1c6bbd09bd5c', 1, NULL, 'Ворон к ворону летит', 'Петербургские серенады: Ворон к ворону летит', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15795 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d8cddc7-f9e9-4ea0-b15f-1c6bbd09bd5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Вянет, вянет лето красно', part.name_en = 'Петербургские серенады: Вянет, вянет лето красно',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15795 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:449de431-c1ec-40a2-a1b4-4af95bffaf04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:449de431-c1ec-40a2-a1b4-4af95bffaf04', 2, NULL, 'Вянет, вянет лето красно', 'Петербургские серенады: Вянет, вянет лето красно', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15795 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:449de431-c1ec-40a2-a1b4-4af95bffaf04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Пью за здравие Мери', part.name_en = 'Петербургские серенады: Пью за здравие Мери',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15795 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:5af7f5b5-2871-4bd9-b1f1-ffe04d605fc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5af7f5b5-2871-4bd9-b1f1-ffe04d605fc0', 3, NULL, 'Пью за здравие Мери', 'Петербургские серенады: Пью за здравие Мери', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15795 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5af7f5b5-2871-4bd9-b1f1-ffe04d605fc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Где наша роза?', part.name_en = 'Петербургские серенады: Где наша роза?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15795 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:6b8fcebb-5eae-44ae-ab04-87cb2408566b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b8fcebb-5eae-44ae-ab04-87cb2408566b', 4, NULL, 'Где наша роза?', 'Петербургские серенады: Где наша роза?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15795 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b8fcebb-5eae-44ae-ab04-87cb2408566b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Буря мглою небо кроет', part.name_en = 'Петербургские серенады: Буря мглою небо кроет',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15795 AND p.composer_id = 149 AND part.part_key = 'musicbrainz:ef04cf50-f0e1-4485-8a10-bb2101338c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef04cf50-f0e1-4485-8a10-bb2101338c6e', 5, NULL, 'Буря мглою небо кроет', 'Петербургские серенады: Буря мглою небо кроет', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15795 AND p.composer_id = 149
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef04cf50-f0e1-4485-8a10-bb2101338c6e'
);


-- 카탈로그에 대응이 없는 seed 작품 6개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 149 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15797, 15807, 15831, 18032, 18344, 18566
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
