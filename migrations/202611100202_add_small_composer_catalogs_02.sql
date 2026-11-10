-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 2/9).
-- 작품 100개(새 11개), seed 100개 중 잇기 89·숨김 3·그대로 8.
--
-- 6차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- ===== Yannis Papaioannou (composer_id 167) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 24개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 24개의 전주곡

UPDATE pieces piece
SET piece.title = '24개의 전주곡', piece.title_en = '24 Préludes, AKI 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19440 AND piece.composer_id = 167
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Nuit à la campagne (Lento)', part.name_en = '24 Préludes, AKI 51: No. 1. La Nuit à la campagne (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:6aa94d92-443a-4e48-8065-b50001c7d692' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aa94d92-443a-4e48-8065-b50001c7d692', 1, NULL, 'La Nuit à la campagne (Lento)', '24 Préludes, AKI 51: No. 1. La Nuit à la campagne (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aa94d92-443a-4e48-8065-b50001c7d692'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Matin près de la mer (Andante)', part.name_en = '24 Préludes, AKI 51: No. 2. Le Matin près de la mer (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:70f2a180-f387-49fd-bb1e-cfe044bff1b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70f2a180-f387-49fd-bb1e-cfe044bff1b3', 2, NULL, 'Le Matin près de la mer (Andante)', '24 Préludes, AKI 51: No. 2. Le Matin près de la mer (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f2a180-f387-49fd-bb1e-cfe044bff1b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aquarelle (Poco lento)', part.name_en = '24 Préludes, AKI 51: No. 3. Aquarelle (Poco lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:f32727b5-98c7-467d-b416-2ee306968ac8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f32727b5-98c7-467d-b416-2ee306968ac8', 3, NULL, 'Aquarelle (Poco lento)', '24 Préludes, AKI 51: No. 3. Aquarelle (Poco lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f32727b5-98c7-467d-b416-2ee306968ac8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danse (Allegretto)', part.name_en = '24 Préludes, AKI 51: No. 4. Danse (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:c99482eb-12a8-4a49-b9b1-8235fe6dc0aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c99482eb-12a8-4a49-b9b1-8235fe6dc0aa', 4, NULL, 'Danse (Allegretto)', '24 Préludes, AKI 51: No. 4. Danse (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c99482eb-12a8-4a49-b9b1-8235fe6dc0aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Clair de lune (Molto moderato)', part.name_en = '24 Préludes, AKI 51: No. 5. Clair de lune (Molto moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:8ddd1d16-0fb8-4f17-b6e7-c4e14384516a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ddd1d16-0fb8-4f17-b6e7-c4e14384516a', 5, NULL, 'Clair de lune (Molto moderato)', '24 Préludes, AKI 51: No. 5. Clair de lune (Molto moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ddd1d16-0fb8-4f17-b6e7-c4e14384516a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'In memoriam, "Hommage à Ravel" (Poco lento)', part.name_en = '24 Préludes, AKI 51: No. 6. In memoriam, "Hommage à Ravel" (Poco lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:51af2049-6a7b-47d2-b833-4436054d52ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51af2049-6a7b-47d2-b833-4436054d52ee', 6, NULL, 'In memoriam, "Hommage à Ravel" (Poco lento)', '24 Préludes, AKI 51: No. 6. In memoriam, "Hommage à Ravel" (Poco lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51af2049-6a7b-47d2-b833-4436054d52ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La Brise (Moderato)', part.name_en = '24 Préludes, AKI 51: No. 7. La Brise (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:81001b51-c644-45b0-9f1c-2359aaa24f68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81001b51-c644-45b0-9f1c-2359aaa24f68', 7, NULL, 'La Brise (Moderato)', '24 Préludes, AKI 51: No. 7. La Brise (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81001b51-c644-45b0-9f1c-2359aaa24f68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Souvenir (Andante)', part.name_en = '24 Préludes, AKI 51: No. 8. Souvenir (Andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:80b63020-3c34-4df9-9363-8d475067d239' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b63020-3c34-4df9-9363-8d475067d239', 8, NULL, 'Souvenir (Andante)', '24 Préludes, AKI 51: No. 8. Souvenir (Andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b63020-3c34-4df9-9363-8d475067d239'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Miss A. J. Eccentric (Andante con moto)', part.name_en = '24 Préludes, AKI 51: No. 9. Miss A. J. Eccentric (Andante con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:d02d9637-e49b-4f5f-863e-426dde1ff564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02d9637-e49b-4f5f-863e-426dde1ff564', 9, NULL, 'Miss A. J. Eccentric (Andante con moto)', '24 Préludes, AKI 51: No. 9. Miss A. J. Eccentric (Andante con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02d9637-e49b-4f5f-863e-426dde1ff564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Le Lac (Poco lento)', part.name_en = '24 Préludes, AKI 51: No. 10. Le Lac (Poco lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:e4c47ec4-70ae-42b6-b627-0322dc1466ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c47ec4-70ae-42b6-b627-0322dc1466ff', 10, NULL, 'Le Lac (Poco lento)', '24 Préludes, AKI 51: No. 10. Le Lac (Poco lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c47ec4-70ae-42b6-b627-0322dc1466ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tziganiana (Andante molto)', part.name_en = '24 Préludes, AKI 51: No. 11. Tziganiana (Andante molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:06c66a56-2821-4046-8c34-bbb9c3909e04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06c66a56-2821-4046-8c34-bbb9c3909e04', 11, NULL, 'Tziganiana (Andante molto)', '24 Préludes, AKI 51: No. 11. Tziganiana (Andante molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c66a56-2821-4046-8c34-bbb9c3909e04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Les Oiseaux aquatiques (Allegretto)', part.name_en = '24 Préludes, AKI 51: No. 12. Les Oiseaux aquatiques (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:4eb0fd7d-e430-4259-84b3-5744fd0bdefa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eb0fd7d-e430-4259-84b3-5744fd0bdefa', 12, NULL, 'Les Oiseaux aquatiques (Allegretto)', '24 Préludes, AKI 51: No. 12. Les Oiseaux aquatiques (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eb0fd7d-e430-4259-84b3-5744fd0bdefa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'La Bayadère (Andante con moto)', part.name_en = '24 Préludes, AKI 51: No. 13. La Bayadère (Andante con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:9ec1a0d1-85a0-40c1-b416-598f81ea73a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ec1a0d1-85a0-40c1-b416-598f81ea73a7', 13, NULL, 'La Bayadère (Andante con moto)', '24 Préludes, AKI 51: No. 13. La Bayadère (Andante con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ec1a0d1-85a0-40c1-b416-598f81ea73a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Sérénité (Andantino)', part.name_en = '24 Préludes, AKI 51: No. 14. Sérénité (Andantino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:da0c7443-82da-481d-81ee-f583c5ad385c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da0c7443-82da-481d-81ee-f583c5ad385c', 14, NULL, 'Sérénité (Andantino)', '24 Préludes, AKI 51: No. 14. Sérénité (Andantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da0c7443-82da-481d-81ee-f583c5ad385c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Le Christ est ressuscité (Lento non troppo)', part.name_en = '24 Préludes, AKI 51: No. 15. Le Christ est ressuscité (Lento non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:cfd9bfae-d953-459f-80a7-deae502a7e69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfd9bfae-d953-459f-80a7-deae502a7e69', 15, NULL, 'Le Christ est ressuscité (Lento non troppo)', '24 Préludes, AKI 51: No. 15. Le Christ est ressuscité (Lento non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd9bfae-d953-459f-80a7-deae502a7e69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'La vallée des peupliers (Lento assai)', part.name_en = '24 Préludes, AKI 51: No. 16. La vallée des peupliers (Lento assai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:c6195261-7f8a-47a3-98f2-028b7d366fef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6195261-7f8a-47a3-98f2-028b7d366fef', 16, NULL, 'La vallée des peupliers (Lento assai)', '24 Préludes, AKI 51: No. 16. La vallée des peupliers (Lento assai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6195261-7f8a-47a3-98f2-028b7d366fef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Nuit translucide (Lento)', part.name_en = '24 Préludes, AKI 51: No. 17. Nuit translucide (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:b6f4cdab-690f-493e-9770-331d7f7e5c8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f4cdab-690f-493e-9770-331d7f7e5c8a', 17, NULL, 'Nuit translucide (Lento)', '24 Préludes, AKI 51: No. 17. Nuit translucide (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f4cdab-690f-493e-9770-331d7f7e5c8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'L''Amazone (Allegro vivo ma leggiero)', part.name_en = '24 Préludes, AKI 51: No. 18. L''Amazone (Allegro vivo ma leggiero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:f1f22b2b-58ab-4785-ad70-3991f6a962c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f22b2b-58ab-4785-ad70-3991f6a962c1', 18, NULL, 'L''Amazone (Allegro vivo ma leggiero)', '24 Préludes, AKI 51: No. 18. L''Amazone (Allegro vivo ma leggiero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f22b2b-58ab-4785-ad70-3991f6a962c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'La Fée (Lento non troppo)', part.name_en = '24 Préludes, AKI 51: No. 19. La Fée (Lento non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:55346606-2618-4b66-b739-cf05abee1180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55346606-2618-4b66-b739-cf05abee1180', 19, NULL, 'La Fée (Lento non troppo)', '24 Préludes, AKI 51: No. 19. La Fée (Lento non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55346606-2618-4b66-b739-cf05abee1180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Crépuscule dans la forêt (Moderato)', part.name_en = '24 Préludes, AKI 51: No. 20. Crépuscule dans la forêt (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:f4b27886-ca3d-4bff-b6c6-2b29f4bc243b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4b27886-ca3d-4bff-b6c6-2b29f4bc243b', 20, NULL, 'Crépuscule dans la forêt (Moderato)', '24 Préludes, AKI 51: No. 20. Crépuscule dans la forêt (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4b27886-ca3d-4bff-b6c6-2b29f4bc243b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'La Neige (Moderato)', part.name_en = '24 Préludes, AKI 51: No. 21. La Neige (Moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:3faa9801-ea1e-4569-9083-8c876945b1ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3faa9801-ea1e-4569-9083-8c876945b1ea', 21, NULL, 'La Neige (Moderato)', '24 Préludes, AKI 51: No. 21. La Neige (Moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3faa9801-ea1e-4569-9083-8c876945b1ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Poisson d''or (Allegro ma tranquillo)', part.name_en = '24 Préludes, AKI 51: No. 22. Poisson d''or (Allegro ma tranquillo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:937a050f-f840-4833-b119-81f9f5092de7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:937a050f-f840-4833-b119-81f9f5092de7', 22, NULL, 'Poisson d''or (Allegro ma tranquillo)', '24 Préludes, AKI 51: No. 22. Poisson d''or (Allegro ma tranquillo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:937a050f-f840-4833-b119-81f9f5092de7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Le Ruisseau (Poco allegro leggiero)', part.name_en = '24 Préludes, AKI 51: No. 23. Le Ruisseau (Poco allegro leggiero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:4112eb11-9414-4646-a178-63236f33aa0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4112eb11-9414-4646-a178-63236f33aa0f', 23, NULL, 'Le Ruisseau (Poco allegro leggiero)', '24 Préludes, AKI 51: No. 23. Le Ruisseau (Poco allegro leggiero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4112eb11-9414-4646-a178-63236f33aa0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'La Nageuse (Poco allegro)', part.name_en = '24 Préludes, AKI 51: No. 24. La Nageuse (Poco allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19440 AND p.composer_id = 167 AND part.part_key = 'musicbrainz:065b8c6b-2bb1-497b-8a41-8eca23367a77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:065b8c6b-2bb1-497b-8a41-8eca23367a77', 24, NULL, 'La Nageuse (Poco allegro)', '24 Préludes, AKI 51: No. 24. La Nageuse (Poco allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19440 AND p.composer_id = 167
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:065b8c6b-2bb1-497b-8a41-8eca23367a77'
);

-- 숨길 seed 작품 없음

-- ===== Hans von Koessler (composer_id 169) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Symphonische Variationen

UPDATE pieces piece
SET piece.title = 'Symphonische Variationen', piece.title_en = 'Symphonische Variationen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15725 AND piece.composer_id = 169
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Charlemagne Palestine (composer_id 170) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 1, 다악장 0, 낱곡 6),
-- 새 작품 0개, part 4개, 그 아래 0개.
-- seed 7개 중 7개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None DINGGGDONGGGDINGGGzzzzzzz ferrrr SSSOFTTT DIVINI TIESSSSS!!!!!!!!!

UPDATE pieces piece
SET piece.title = 'DINGGGDONGGGDINGGGzzzzzzz ferrrr SSSOFTTT DIVINI TIESSSSS!!!!!!!!!', piece.title_en = 'DINGGGDONGGGDINGGGzzzzzzz ferrrr SSSOFTTT DIVINI TIESSSSS!!!!!!!!!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15957 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jamaica Heinekens in Brooklyn

UPDATE pieces piece
SET piece.title = 'Jamaica Heinekens in Brooklyn', piece.title_en = 'Jamaica Heinekens in Brooklyn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15975 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Big Ears

UPDATE pieces piece
SET piece.title = 'Music for Big Ears', piece.title_en = 'Music for Big Ears',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19832 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '#1', part.name_en = 'Music for Big Ears: #1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19832 AND p.composer_id = 170 AND part.part_key = 'musicbrainz:14b8b858-4531-4805-9dbe-658521cc7ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14b8b858-4531-4805-9dbe-658521cc7ccf', 1, NULL, '#1', 'Music for Big Ears: #1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19832 AND p.composer_id = 170
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14b8b858-4531-4805-9dbe-658521cc7ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '#2', part.name_en = 'Music for Big Ears: #2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19832 AND p.composer_id = 170 AND part.part_key = 'musicbrainz:118c1275-4b76-41e6-897e-1a7d1ab7a093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:118c1275-4b76-41e6-897e-1a7d1ab7a093', 2, NULL, '#2', 'Music for Big Ears: #2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19832 AND p.composer_id = 170
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:118c1275-4b76-41e6-897e-1a7d1ab7a093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '#3', part.name_en = 'Music for Big Ears: #3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19832 AND p.composer_id = 170 AND part.part_key = 'musicbrainz:4b849548-a53a-4b9f-b502-61871a05243d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b849548-a53a-4b9f-b502-61871a05243d', 3, NULL, '#3', 'Music for Big Ears: #3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19832 AND p.composer_id = 170
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b849548-a53a-4b9f-b502-61871a05243d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '#4', part.name_en = 'Music for Big Ears: #4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19832 AND p.composer_id = 170 AND part.part_key = 'musicbrainz:e627725a-8589-49e2-a862-61b27c88dc8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e627725a-8589-49e2-a862-61b27c88dc8d', 4, NULL, '#4', 'Music for Big Ears: #4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19832 AND p.composer_id = 170
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e627725a-8589-49e2-a862-61b27c88dc8d'
);


-- None STTT THOMASSS ‘’’’”‘”DINGG GDONGGGDINGGGzzz zzzz ferrrr TONYYY’’’’’’’’

UPDATE pieces piece
SET piece.title = 'STTT THOMASSS ‘’’’”‘”DINGG GDONGGGDINGGGzzz zzzz ferrrr TONYYY’’’’’’’’', piece.title_en = 'STTT THOMASSS ‘’’’”‘”DINGG GDONGGGDINGGGzzz zzzz ferrrr TONYYY’’’’’’’’',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16719 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ssingggg Sschlllingg Sshpppingg

UPDATE pieces piece
SET piece.title = 'Ssingggg Sschlllingg Sshpppingg', piece.title_en = 'Ssingggg Sschlllingg Sshpppingg',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16461 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Untitled for Solo Voice

UPDATE pieces piece
SET piece.title = 'Untitled for Solo Voice', piece.title_en = 'Untitled for Solo Voice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19159 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vvvoooodddoooo Ddddooooodddddooooo

UPDATE pieces piece
SET piece.title = 'Vvvoooodddoooo Ddddooooodddddooooo', piece.title_en = 'Vvvoooodddoooo Ddddooooodddddooooo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19136 AND piece.composer_id = 170
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== W. Franke Harling (composer_id 171) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Sing, You Sinners>

UPDATE pieces piece
SET piece.title = '가곡 <Sing, You Sinners>', piece.title_en = 'Sing, You Sinners',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18086 AND piece.composer_id = 171
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Corps

UPDATE pieces piece
SET piece.title = 'The Corps', piece.title_en = 'The Corps',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18342 AND piece.composer_id = 171
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Where was I?>

UPDATE pieces piece
SET piece.title = '가곡 <Where was I?>', piece.title_en = 'Where was I?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15917 AND piece.composer_id = 171
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 블라디미르 코베킨 (composer_id 172) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ariadne’s Lament (Variations on a Theme by Claudio Monteverdi)

UPDATE pieces piece
SET piece.title = 'Ariadne’s Lament (Variations on a Theme by Claudio Monteverdi)', piece.title_en = 'Ariadne’s Lament (Variations on a Theme by Claudio Monteverdi)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17155 AND piece.composer_id = 172
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bacchants for Cello & Orchestra

UPDATE pieces piece
SET piece.title = 'Bacchants for Cello & Orchestra', piece.title_en = 'Bacchants for Cello & Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19043 AND piece.composer_id = 172
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Double Variations for Violin and Suspended Cymbals

UPDATE pieces piece
SET piece.title = 'Double Variations for Violin and Suspended Cymbals', piece.title_en = 'Double Variations for Violin and Suspended Cymbals',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19098 AND piece.composer_id = 172
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gallardo

UPDATE pieces piece
SET piece.title = 'Gallardo', piece.title_en = 'Gallardo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19413 AND piece.composer_id = 172
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 파블로 카살스 (composer_id 174) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 17개(묶음 0, 다악장 2, 낱곡 15),
-- 새 작품 4개, part 12개, 그 아래 0개.
-- seed 14개 중 13개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Cançó a la Verge

UPDATE pieces piece
SET piece.title = 'Cançó a la Verge', piece.title_en = 'Cançó a la Verge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16079 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <El pesebre>

UPDATE pieces piece
SET piece.title = '오페라 <El pesebre>', piece.title_en = 'El pesebre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17786 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eucarística

UPDATE pieces piece
SET piece.title = 'Eucarística', piece.title_en = 'Eucarística',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17055 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Festivola

UPDATE pieces piece
SET piece.title = 'Festivola', piece.title_en = 'Festivola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19256 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nigra sum>

UPDATE pieces piece
SET piece.title = '가곡 <Nigra sum>', piece.title_en = 'Nigra sum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26022 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oració a la Verge de Montserrat

UPDATE pieces piece
SET piece.title = 'Oració a la Verge de Montserrat', piece.title_en = 'Oració a la Verge de Montserrat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18187 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Recordare, Virgo Mater

UPDATE pieces piece
SET piece.title = 'Recordare, Virgo Mater', piece.title_en = 'Recordare, Virgo Mater',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20073 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rosarium Beatae Virginis Mariae

UPDATE pieces piece
SET piece.title = 'Rosarium Beatae Virginis Mariae', piece.title_en = 'Rosarium Beatae Virginis Mariae',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19217 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pater noster', part.name_en = 'Rosarium Beatae Virginis Mariae: I. Pater noster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:a83b2ca6-a53c-49c4-9ac6-a552ca957ad0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a83b2ca6-a53c-49c4-9ac6-a552ca957ad0', 1, 'I', 'Pater noster', 'Rosarium Beatae Virginis Mariae: I. Pater noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a83b2ca6-a53c-49c4-9ac6-a552ca957ad0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ave Maria I', part.name_en = 'Rosarium Beatae Virginis Mariae: II. Ave Maria I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:5abae24a-ad64-42c9-b13f-3ca1eebb3468' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5abae24a-ad64-42c9-b13f-3ca1eebb3468', 2, 'II', 'Ave Maria I', 'Rosarium Beatae Virginis Mariae: II. Ave Maria I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5abae24a-ad64-42c9-b13f-3ca1eebb3468'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ave Maria II', part.name_en = 'Rosarium Beatae Virginis Mariae: III. Ave Maria II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:80958b42-5a76-4fcc-8ce6-944efa510ff7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80958b42-5a76-4fcc-8ce6-944efa510ff7', 3, 'III', 'Ave Maria II', 'Rosarium Beatae Virginis Mariae: III. Ave Maria II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80958b42-5a76-4fcc-8ce6-944efa510ff7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ave Maria III', part.name_en = 'Rosarium Beatae Virginis Mariae: IV. Ave Maria III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:bc5b0a06-8929-40e8-b276-29676fb4b74b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5b0a06-8929-40e8-b276-29676fb4b74b', 4, 'IV', 'Ave Maria III', 'Rosarium Beatae Virginis Mariae: IV. Ave Maria III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5b0a06-8929-40e8-b276-29676fb4b74b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Gloria Patri', part.name_en = 'Rosarium Beatae Virginis Mariae: V. Gloria Patri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:98ea0104-c230-4359-a3bb-ff7996632320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98ea0104-c230-4359-a3bb-ff7996632320', 5, 'V', 'Gloria Patri', 'Rosarium Beatae Virginis Mariae: V. Gloria Patri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98ea0104-c230-4359-a3bb-ff7996632320'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Panem nostrum', part.name_en = 'Rosarium Beatae Virginis Mariae: VI. Panem nostrum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:b7ad30fe-bd9b-4186-bf9b-26ac6046ceb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ad30fe-bd9b-4186-bf9b-26ac6046ceb1', 6, 'VI', 'Panem nostrum', 'Rosarium Beatae Virginis Mariae: VI. Panem nostrum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ad30fe-bd9b-4186-bf9b-26ac6046ceb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Sancta Maria I', part.name_en = 'Rosarium Beatae Virginis Mariae: VII. Sancta Maria I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:9ab88c3b-c9da-430c-bf75-20a0b3e78d77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ab88c3b-c9da-430c-bf75-20a0b3e78d77', 7, 'VII', 'Sancta Maria I', 'Rosarium Beatae Virginis Mariae: VII. Sancta Maria I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab88c3b-c9da-430c-bf75-20a0b3e78d77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Sancta Maria II', part.name_en = 'Rosarium Beatae Virginis Mariae: VIII. Sancta Maria II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:332565be-afb8-452c-b83f-3f94d5b341c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:332565be-afb8-452c-b83f-3f94d5b341c6', 8, 'VIII', 'Sancta Maria II', 'Rosarium Beatae Virginis Mariae: VIII. Sancta Maria II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:332565be-afb8-452c-b83f-3f94d5b341c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Sicut erat', part.name_en = 'Rosarium Beatae Virginis Mariae: IX. Sicut erat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19217 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:33ad84a9-b08f-4242-aac4-99ba688b9325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ad84a9-b08f-4242-aac4-99ba688b9325', 9, 'IX', 'Sicut erat', 'Rosarium Beatae Virginis Mariae: IX. Sicut erat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19217 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ad84a9-b08f-4242-aac4-99ba688b9325'
);


-- None Salve Montserratina

UPDATE pieces piece
SET piece.title = 'Salve Montserratina', piece.title_en = 'Salve Montserratina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19918 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sant Martí del Canigó

UPDATE pieces piece
SET piece.title = 'Sant Martí del Canigó', piece.title_en = 'Sant Martí del Canigó',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17232 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sardana

UPDATE pieces piece
SET piece.title = 'Sardana', piece.title_en = 'Sardana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17413 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린과 피아노를 위한 소나타 D장조

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 D장조', piece.title_en = 'Sonata for Violin and Piano in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16659 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano in D major: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16659 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:5ed6aec5-91f8-4294-8252-11fe7da84a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ed6aec5-91f8-4294-8252-11fe7da84a67', 1, 'I', 'Allegro', 'Sonata for Violin and Piano in D major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16659 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed6aec5-91f8-4294-8252-11fe7da84a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Presto)', part.name_en = 'Sonata for Violin and Piano in D major: II. Scherzo (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16659 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:dfd04bbc-d078-43a6-b1d0-24ab6fc0448e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfd04bbc-d078-43a6-b1d0-24ab6fc0448e', 2, 'II', 'Scherzo (Presto)', 'Sonata for Violin and Piano in D major: II. Scherzo (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16659 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfd04bbc-d078-43a6-b1d0-24ab6fc0448e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Sonata for Violin and Piano in D major: III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16659 AND p.composer_id = 174 AND part.part_key = 'musicbrainz:45133f91-0f62-42aa-80d2-816e6a26ecb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45133f91-0f62-42aa-80d2-816e6a26ecb4', 3, 'III', 'Lento', 'Sonata for Violin and Piano in D major: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16659 AND p.composer_id = 174
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45133f91-0f62-42aa-80d2-816e6a26ecb4'
);


-- None Tota Pulchra

UPDATE pieces piece
SET piece.title = 'Tota Pulchra', piece.title_en = 'Tota Pulchra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20080 AND piece.composer_id = 174
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <El ángel travieso>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <El ángel travieso>', 'El ángel travieso', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 174
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <El ángel travieso>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a6de684-afbe-431f-95f4-0717e51aa537'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a6de684-afbe-431f-95f4-0717e51aa537'
FROM pieces p
WHERE p.composer_id = 174 AND p.title = '가곡 <El ángel travieso>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a6de684-afbe-431f-95f4-0717e51aa537'
);


-- None 가곡 <En sourdine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <En sourdine>', 'En sourdine', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 174
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <En sourdine>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bc1c52e-0e8a-4f95-ac36-d0b9b78e6228'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bc1c52e-0e8a-4f95-ac36-d0b9b78e6228'
FROM pieces p
WHERE p.composer_id = 174 AND p.title = '가곡 <En sourdine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bc1c52e-0e8a-4f95-ac36-d0b9b78e6228'
);


-- None O vos omnes

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O vos omnes', 'O vos omnes', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 174
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O vos omnes'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d58645f-52f6-4a5a-9c47-4ee680b4d3ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d58645f-52f6-4a5a-9c47-4ee680b4d3ef'
FROM pieces p
WHERE p.composer_id = 174 AND p.title = 'O vos omnes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d58645f-52f6-4a5a-9c47-4ee680b4d3ef'
);


-- None 가곡 <Tres estrofas de amor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tres estrofas de amor>', 'Tres estrofas de amor', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 174
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tres estrofas de amor>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3528804-facb-421b-9ecc-d622c438481e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3528804-facb-421b-9ecc-d622c438481e'
FROM pieces p
WHERE p.composer_id = 174 AND p.title = '가곡 <Tres estrofas de amor>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3528804-facb-421b-9ecc-d622c438481e'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 174 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    19306
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Heinrich Kaspar Schmid (composer_id 175) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 34 5개의 교향시 Op. 34

UPDATE pieces piece
SET piece.title = '5개의 교향시 Op. 34', piece.title_en = '5 Tone Poems, op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16804 AND piece.composer_id = 175
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Im Tiefsten Walde, op. 34 no. 4', part.name_en = 'Im Tiefsten Walde, op. 34 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16804 AND p.composer_id = 175 AND part.part_key = 'musicbrainz:49cec0da-f73f-4aa2-8094-998ac26c4244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49cec0da-f73f-4aa2-8094-998ac26c4244', 1, NULL, 'Im Tiefsten Walde, op. 34 no. 4', 'Im Tiefsten Walde, op. 34 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16804 AND p.composer_id = 175
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49cec0da-f73f-4aa2-8094-998ac26c4244'
);

-- 숨길 seed 작품 없음

-- ===== Frank Van der Stucken (composer_id 176) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 21 No. 2 가곡 <O Come With Me in the Summer Night>

UPDATE pieces piece
SET piece.title = '가곡 <O Come With Me in the Summer Night>', piece.title_en = 'O Come With Me in the Summer Night, op. 21 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 21 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19125 AND piece.composer_id = 176
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== William Sweeney (composer_id 177) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None An Òg-Mhadainn

UPDATE pieces piece
SET piece.title = 'An Òg-Mhadainn', piece.title_en = 'An Òg-Mhadainn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16296 AND piece.composer_id = 177
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eòlas nan Ribheid

UPDATE pieces piece
SET piece.title = 'Eòlas nan Ribheid', piece.title_en = 'Eòlas nan Ribheid',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15803 AND piece.composer_id = 177
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hallaig

UPDATE pieces piece
SET piece.title = 'Hallaig', piece.title_en = 'Hallaig',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17279 AND piece.composer_id = 177
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Violet Archer (composer_id 178) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Episodes

UPDATE pieces piece
SET piece.title = 'Episodes', piece.title_en = 'Episodes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19659 AND piece.composer_id = 178
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Cradle Song>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Cradle Song>', 'Cradle Song', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 178
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Cradle Song>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc3c424c-52ea-4b68-bff2-8a9e7f11974f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc3c424c-52ea-4b68-bff2-8a9e7f11974f'
FROM pieces p
WHERE p.composer_id = 178 AND p.title = '가곡 <Cradle Song>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc3c424c-52ea-4b68-bff2-8a9e7f11974f'
);

-- 숨길 seed 작품 없음

-- ===== 도야마유조 (composer_id 179) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 1, 낱곡 3),
-- 새 작품 1개, part 8개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Matsura

UPDATE pieces piece
SET piece.title = 'Matsura', piece.title_en = 'Matsura',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19156 AND piece.composer_id = 179
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rhapsody for Orchestra

UPDATE pieces piece
SET piece.title = 'Rhapsody for Orchestra', piece.title_en = 'Rhapsody for Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15787 AND piece.composer_id = 179
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite from Yugen

UPDATE pieces piece
SET piece.title = 'Suite from Yugen', piece.title_en = 'Suite from Yugen',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18862 AND piece.composer_id = 179
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dance of Celestials', part.name_en = 'Suite from Yugen: Dance of Celestials',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18862 AND p.composer_id = 179 AND part.part_key = 'musicbrainz:61f6d0a1-fd9c-423e-bf61-c50f88647cd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f6d0a1-fd9c-423e-bf61-c50f88647cd5', 1, NULL, 'Dance of Celestials', 'Suite from Yugen: Dance of Celestials', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18862 AND p.composer_id = 179
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f6d0a1-fd9c-423e-bf61-c50f88647cd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance of Men', part.name_en = 'Suite from Yugen: Dance of Men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18862 AND p.composer_id = 179 AND part.part_key = 'musicbrainz:688ec0fa-6e31-48a8-be44-091977f51aae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:688ec0fa-6e31-48a8-be44-091977f51aae', 2, NULL, 'Dance of Men', 'Suite from Yugen: Dance of Men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18862 AND p.composer_id = 179
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:688ec0fa-6e31-48a8-be44-091977f51aae'
);


-- None 子守唄

UPDATE pieces piece
SET piece.title = '子守唄', piece.title_en = '子守唄',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19265 AND piece.composer_id = 179
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 179
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19ef8bdd-441f-4723-97f7-5ac766126384'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19ef8bdd-441f-4723-97f7-5ac766126384'
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19ef8bdd-441f-4723-97f7-5ac766126384'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9b42d2-6a25-497b-ac84-c75782a24da1', 1, 'I', 'Andante', 'Cello Concerto: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9b42d2-6a25-497b-ac84-c75782a24da1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40ac7e66-f7bd-4bba-a3ff-b235c4711f1b', 2, 'II', 'Allegro', 'Cello Concerto: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ac7e66-f7bd-4bba-a3ff-b235c4711f1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ef5f68e-0839-4726-b7a0-b887b965a259', 3, 'III', 'Andante', 'Cello Concerto: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ef5f68e-0839-4726-b7a0-b887b965a259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12c588d1-dd95-420b-9b36-9c6e63209011', 4, 'IV', 'Allegretto poco improviasto', 'Cello Concerto: IV. Allegretto poco improviasto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12c588d1-dd95-420b-9b36-9c6e63209011'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88ab42a-60a2-41a0-9405-97729feb6bf3', 5, 'V', 'Lento', 'Cello Concerto: V. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88ab42a-60a2-41a0-9405-97729feb6bf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3925bd3-d703-4c15-9e95-dea2307733a3', 6, 'VI', 'Allegro', 'Cello Concerto: VI. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 179 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3925bd3-d703-4c15-9e95-dea2307733a3'
);

-- 숨길 seed 작품 없음

-- ===== 마르크앙드레 달바비 (composer_id 187) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 17개(묶음 2, 다악장 1, 낱곡 14),
-- 새 작품 5개, part 13개, 그 아래 0개.
-- seed 13개 중 12개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Axiom

UPDATE pieces piece
SET piece.title = 'Axiom', piece.title_en = 'Axiom',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18623 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Color

UPDATE pieces piece
SET piece.title = 'Color', piece.title_en = 'Color',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19649 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 플루트 협주곡

UPDATE pieces piece
SET piece.title = '플루트 협주곡', piece.title_en = 'Concerto pour flute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19225 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto pour violon et orchestre

UPDATE pieces piece
SET piece.title = 'Concerto pour violon et orchestre', piece.title_en = 'Concerto pour violon et orchestre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16593 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Diadèmes

UPDATE pieces piece
SET piece.title = 'Diadèmes', piece.title_en = 'Diadèmes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16701 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Diadèmes: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16701 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:8a2027c6-cbd5-4a72-9e16-66293b1e3f64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a2027c6-cbd5-4a72-9e16-66293b1e3f64', 1, NULL, 'I', 'Diadèmes: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16701 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a2027c6-cbd5-4a72-9e16-66293b1e3f64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Diadèmes: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16701 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:461fc4ad-05c1-4215-bc60-5e7559d4a8da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461fc4ad-05c1-4215-bc60-5e7559d4a8da', 2, NULL, 'II', 'Diadèmes: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16701 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461fc4ad-05c1-4215-bc60-5e7559d4a8da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Diadèmes: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16701 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:6442975d-0ed5-4815-aa95-820927e11a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6442975d-0ed5-4815-aa95-820927e11a47', 3, NULL, 'III', 'Diadèmes: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16701 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6442975d-0ed5-4815-aa95-820927e11a47'
);


-- None In Advance of the Broken Time

UPDATE pieces piece
SET piece.title = 'In Advance of the Broken Time', piece.title_en = 'In Advance of the Broken Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16057 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ligne de fuite

UPDATE pieces piece
SET piece.title = 'Ligne de fuite', piece.title_en = 'Ligne de fuite',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19035 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Palimpeste

UPDATE pieces piece
SET piece.title = 'Palimpeste', piece.title_en = 'Palimpeste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18823 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seuils

UPDATE pieces piece
SET piece.title = 'Seuils', piece.title_en = 'Seuils',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17830 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seuil I', part.name_en = 'Seuils: Seuil I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:b5fc85c5-8bba-40bf-beae-dbdb993bef8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5fc85c5-8bba-40bf-beae-dbdb993bef8f', 1, NULL, 'Seuil I', 'Seuils: Seuil I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5fc85c5-8bba-40bf-beae-dbdb993bef8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seuil II', part.name_en = 'Seuils: Seuil II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:ff8dea2f-6e77-400b-9953-7fd60f13e51a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff8dea2f-6e77-400b-9953-7fd60f13e51a', 2, NULL, 'Seuil II', 'Seuils: Seuil II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff8dea2f-6e77-400b-9953-7fd60f13e51a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Seuil III', part.name_en = 'Seuils: Seuil III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:b164cc5e-4c9b-40d0-a85e-1a5d6b40ab36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b164cc5e-4c9b-40d0-a85e-1a5d6b40ab36', 3, NULL, 'Seuil III', 'Seuils: Seuil III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b164cc5e-4c9b-40d0-a85e-1a5d6b40ab36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Seuil IV', part.name_en = 'Seuils: Seuil IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:f6758905-0444-4830-a83e-d1fe8cf4bed9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6758905-0444-4830-a83e-d1fe8cf4bed9', 4, NULL, 'Seuil IV', 'Seuils: Seuil IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6758905-0444-4830-a83e-d1fe8cf4bed9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Seuil V', part.name_en = 'Seuils: Seuil V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:7ba6ef04-d6a1-4fa6-a04e-aeff01236239' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba6ef04-d6a1-4fa6-a04e-aeff01236239', 5, NULL, 'Seuil V', 'Seuils: Seuil V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba6ef04-d6a1-4fa6-a04e-aeff01236239'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Seuil VI', part.name_en = 'Seuils: Seuil VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:35a60fdc-ac86-479a-9f1b-b3ac1782f56c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35a60fdc-ac86-479a-9f1b-b3ac1782f56c', 6, NULL, 'Seuil VI', 'Seuils: Seuil VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35a60fdc-ac86-479a-9f1b-b3ac1782f56c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Seuil VII', part.name_en = 'Seuils: Seuil VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17830 AND p.composer_id = 187 AND part.part_key = 'musicbrainz:b2e39334-b046-4cb4-9949-65e495058bf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e39334-b046-4cb4-9949-65e495058bf0', 7, NULL, 'Seuil VII', 'Seuils: Seuil VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17830 AND p.composer_id = 187
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e39334-b046-4cb4-9949-65e495058bf0'
);


-- None Tactus

UPDATE pieces piece
SET piece.title = 'Tactus', piece.title_en = 'Tactus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18798 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio

UPDATE pieces piece
SET piece.title = 'Trio', piece.title_en = 'Trio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19527 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio for Violin, Horn and Piano

UPDATE pieces piece
SET piece.title = 'Trio for Violin, Horn and Piano', piece.title_en = 'Trio for Violin, Horn and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16731 AND piece.composer_id = 187
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 187
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87e9de50-131e-47ff-a3a1-d974b01a637a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87e9de50-131e-47ff-a3a1-d974b01a637a'
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87e9de50-131e-47ff-a3a1-d974b01a637a'
);


-- None 샤콘

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤콘', 'Ciaccona', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 187
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤콘'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b538286f-315e-4807-ab65-210aaf5472fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b538286f-315e-4807-ab65-210aaf5472fa'
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '샤콘' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b538286f-315e-4807-ab65-210aaf5472fa'
);


-- None 오보에 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡', 'Oboe Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 187
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '292996d1-81bf-4ea5-a55b-66c228be10b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '292996d1-81bf-4ea5-a55b-66c228be10b1'
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '오보에 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '292996d1-81bf-4ea5-a55b-66c228be10b1'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 187
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c7b522-0b79-4230-83cf-08a930d8ae68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9c7b522-0b79-4230-83cf-08a930d8ae68'
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c7b522-0b79-4230-83cf-08a930d8ae68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c15d24b5-faa9-4d0a-a9a1-e4a6fb5de395', 1, NULL, 'I', 'Piano Concerto: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c15d24b5-faa9-4d0a-a9a1-e4a6fb5de395'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20ececce-98d2-4b12-8539-d1b31bd53bdd', 2, NULL, 'II', 'Piano Concerto: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20ececce-98d2-4b12-8539-d1b31bd53bdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95c43b6c-2328-4b27-9b4b-d37a00e7fc44', 3, NULL, 'III', 'Piano Concerto: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 187 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95c43b6c-2328-4b27-9b4b-d37a00e7fc44'
);


-- None Quatuor à cordes

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Quatuor à cordes', 'Quatuor à cordes', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 187
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Quatuor à cordes'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e84e296a-09f4-40fa-9859-c097f2f151b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e84e296a-09f4-40fa-9859-c097f2f151b2'
FROM pieces p
WHERE p.composer_id = 187 AND p.title = 'Quatuor à cordes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e84e296a-09f4-40fa-9859-c097f2f151b2'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 187 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    18341
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== James Wilson (composer_id 188) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 132 For Cliodhna

UPDATE pieces piece
SET piece.title = 'For Cliodhna', piece.title_en = 'For Cliodhna, op. 132',
    piece.type = 'song', piece.opus_number = 'Op. 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17983 AND piece.composer_id = 188
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Paul Ladmirault (composer_id 192) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 0, 다악장 4, 낱곡 3),
-- 새 작품 0개, part 19개, 그 아래 0개.
-- seed 8개 중 7개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Brocéliande au matin

UPDATE pieces piece
SET piece.title = 'Brocéliande au matin', piece.title_en = 'Brocéliande au matin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19377 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En Forêt

UPDATE pieces piece
SET piece.title = 'En Forêt', piece.title_en = 'En Forêt',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19844 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Les Amants (à Emile Vuillermoz)', part.name_en = 'En Forêt: II. Les Amants (à Emile Vuillermoz)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19844 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:3cb720b0-4963-4f48-bf7b-2db8ef672730' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cb720b0-4963-4f48-bf7b-2db8ef672730', 1, 'II', 'Les Amants (à Emile Vuillermoz)', 'En Forêt: II. Les Amants (à Emile Vuillermoz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19844 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cb720b0-4963-4f48-bf7b-2db8ef672730'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'L''Aurore', part.name_en = 'En Forêt: I. L''Aurore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19844 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:86df42ab-6b67-4cce-b74b-876f482f1f8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86df42ab-6b67-4cce-b74b-876f482f1f8e', 2, 'I', 'L''Aurore', 'En Forêt: I. L''Aurore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19844 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86df42ab-6b67-4cce-b74b-876f482f1f8e'
);


-- None Hommage à Gabriel Fauré

UPDATE pieces piece
SET piece.title = 'Hommage à Gabriel Fauré', piece.title_en = 'Hommage à Gabriel Fauré',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19703 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Brière

UPDATE pieces piece
SET piece.title = 'La Brière', piece.title_en = 'La Brière',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18411 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'La Foire d''Herbignac', part.name_en = 'La Brière: II. La Foire d''Herbignac',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18411 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:32b9853e-4d8c-462f-bdee-eac6918f2d20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b9853e-4d8c-462f-bdee-eac6918f2d20', 1, 'II', 'La Foire d''Herbignac', 'La Brière: II. La Foire d''Herbignac', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18411 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b9853e-4d8c-462f-bdee-eac6918f2d20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Idylle dans le soir', part.name_en = 'La Brière: IV. Idylle dans le soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18411 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:4d4b3b47-2ca9-4bc2-bffc-c0dd3980171d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d4b3b47-2ca9-4bc2-bffc-c0dd3980171d', 2, 'IV', 'Idylle dans le soir', 'La Brière: IV. Idylle dans le soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18411 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4b3b47-2ca9-4bc2-bffc-c0dd3980171d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Légende (et la forge de Trigniac)', part.name_en = 'La Brière: V. Légende (et la forge de Trigniac)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18411 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:69d0caaf-8e9d-4b0d-a8df-87435c1fb8df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69d0caaf-8e9d-4b0d-a8df-87435c1fb8df', 3, 'V', 'Légende (et la forge de Trigniac)', 'La Brière: V. Légende (et la forge de Trigniac)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18411 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69d0caaf-8e9d-4b0d-a8df-87435c1fb8df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Paysage triste', part.name_en = 'La Brière: I. Paysage triste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18411 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:94da688f-8ab2-4f5d-a520-0a67e4aee5d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94da688f-8ab2-4f5d-a520-0a67e4aee5d9', 4, 'I', 'Paysage triste', 'La Brière: I. Paysage triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18411 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94da688f-8ab2-4f5d-a520-0a67e4aee5d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = 'Printemps', part.name_en = 'La Brière: III. Printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18411 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:f5123408-e20d-4c00-aa0a-e697d9c7240f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5123408-e20d-4c00-aa0a-e697d9c7240f', 5, 'III', 'Printemps', 'La Brière: III. Printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18411 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5123408-e20d-4c00-aa0a-e697d9c7240f'
);


-- None Les Mémoires d'un âne

UPDATE pieces piece
SET piece.title = 'Les Mémoires d''un âne', piece.title_en = 'Les Mémoires d''un âne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18426 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Présentation de Cadichon', part.name_en = 'Les Mémoires d''un âne: I. Présentation de Cadichon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:3fddddd5-4af9-438d-a8ef-2455658f9530' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fddddd5-4af9-438d-a8ef-2455658f9530', 1, 'I', 'Présentation de Cadichon', 'Les Mémoires d''un âne: I. Présentation de Cadichon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fddddd5-4af9-438d-a8ef-2455658f9530'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cadichon s''endort dans la forêt', part.name_en = 'Les Mémoires d''un âne: II. Cadichon s''endort dans la forêt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:dcc98b54-2414-4357-913d-47ba53407922' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcc98b54-2414-4357-913d-47ba53407922', 2, 'II', 'Cadichon s''endort dans la forêt', 'Les Mémoires d''un âne: II. Cadichon s''endort dans la forêt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcc98b54-2414-4357-913d-47ba53407922'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cadichon réveillé et poursuivi par les chiens', part.name_en = 'Les Mémoires d''un âne: III. Cadichon réveillé et poursuivi par les chiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:500dba71-fc92-4fed-a08e-4825da5e32ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:500dba71-fc92-4fed-a08e-4825da5e32ee', 3, 'III', 'Cadichon réveillé et poursuivi par les chiens', 'Les Mémoires d''un âne: III. Cadichon réveillé et poursuivi par les chiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500dba71-fc92-4fed-a08e-4825da5e32ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Course des ânes', part.name_en = 'Les Mémoires d''un âne: IV. Course des ânes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:8bddcbaa-c580-40d8-a0e5-54474f6d2e76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bddcbaa-c580-40d8-a0e5-54474f6d2e76', 4, 'IV', 'Course des ânes', 'Les Mémoires d''un âne: IV. Course des ânes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bddcbaa-c580-40d8-a0e5-54474f6d2e76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Pauline et Cadichon', part.name_en = 'Les Mémoires d''un âne: V. Pauline et Cadichon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:3782b7da-cf54-493e-8de9-d753f657d057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3782b7da-cf54-493e-8de9-d753f657d057', 5, 'V', 'Pauline et Cadichon', 'Les Mémoires d''un âne: V. Pauline et Cadichon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3782b7da-cf54-493e-8de9-d753f657d057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Le Convoi funèbre de Médor', part.name_en = 'Les Mémoires d''un âne: VI. Le Convoi funèbre de Médor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:d3cf0a6f-2f45-4b2a-b1c4-3fb090378ee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3cf0a6f-2f45-4b2a-b1c4-3fb090378ee6', 6, 'VI', 'Le Convoi funèbre de Médor', 'Les Mémoires d''un âne: VI. Le Convoi funèbre de Médor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3cf0a6f-2f45-4b2a-b1c4-3fb090378ee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Le Baptême de Marie-Camille', part.name_en = 'Les Mémoires d''un âne: VII. Le Baptême de Marie-Camille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18426 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:ce3aa9fc-a793-460b-819d-8a75da965b7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce3aa9fc-a793-460b-819d-8a75da965b7c', 7, 'VII', 'Le Baptême de Marie-Camille', 'Les Mémoires d''un âne: VII. Le Baptême de Marie-Camille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18426 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce3aa9fc-a793-460b-819d-8a75da965b7c'
);


-- None Valse triste

UPDATE pieces piece
SET piece.title = 'Valse triste', piece.title_en = 'Valse triste',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16643 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations sur des airs de biniou trégorois

UPDATE pieces piece
SET piece.title = 'Variations sur des airs de biniou trégorois', piece.title_en = 'Variations sur des airs de biniou trégorois',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16119 AND piece.composer_id = 192
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ronde. Allegro giocoso', part.name_en = 'Variations sur des airs de biniou trégorois: I. Ronde. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16119 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:e2d1bded-93ad-4096-b1b4-e5dc7ae5756e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2d1bded-93ad-4096-b1b4-e5dc7ae5756e', 1, 'I', 'Ronde. Allegro giocoso', 'Variations sur des airs de biniou trégorois: I. Ronde. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16119 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2d1bded-93ad-4096-b1b4-e5dc7ae5756e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bal. Allegro', part.name_en = 'Variations sur des airs de biniou trégorois: II. Bal. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16119 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:9ef8556b-4eba-4d82-878f-489e3b1a05bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ef8556b-4eba-4d82-878f-489e3b1a05bc', 2, 'II', 'Bal. Allegro', 'Variations sur des airs de biniou trégorois: II. Bal. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16119 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ef8556b-4eba-4d82-878f-489e3b1a05bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Passepied. Allegro molto', part.name_en = 'Variations sur des airs de biniou trégorois: III. Passepied. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16119 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:a9009366-3da4-42ef-8491-2208df2f4a49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9009366-3da4-42ef-8491-2208df2f4a49', 3, 'III', 'Passepied. Allegro molto', 'Variations sur des airs de biniou trégorois: III. Passepied. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16119 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9009366-3da4-42ef-8491-2208df2f4a49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bal. Allegretto grazioso', part.name_en = 'Variations sur des airs de biniou trégorois: IV. Bal. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16119 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:19f00b8e-d347-46c9-8c1a-e67ea9658655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f00b8e-d347-46c9-8c1a-e67ea9658655', 4, 'IV', 'Bal. Allegretto grazioso', 'Variations sur des airs de biniou trégorois: IV. Bal. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16119 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f00b8e-d347-46c9-8c1a-e67ea9658655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Bal. Molto vivace', part.name_en = 'Variations sur des airs de biniou trégorois: V. Bal. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16119 AND p.composer_id = 192 AND part.part_key = 'musicbrainz:2fb6b408-9e63-42f9-911f-2bfe2bd82963' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fb6b408-9e63-42f9-911f-2bfe2bd82963', 5, 'V', 'Bal. Molto vivace', 'Variations sur des airs de biniou trégorois: V. Bal. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16119 AND p.composer_id = 192
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fb6b408-9e63-42f9-911f-2bfe2bd82963'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 192 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17085
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Gardner Read (composer_id 193) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 1, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 71 De profundis

UPDATE pieces piece
SET piece.title = 'De profundis', piece.title_en = 'De profundis, op. 71',
    piece.type = 'song', piece.opus_number = 'Op. 71',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18722 AND piece.composer_id = 193
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 135 Invocation

UPDATE pieces piece
SET piece.title = 'Invocation', piece.title_en = 'Invocation, op. 135',
    piece.type = 'song', piece.opus_number = 'Op. 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17427 AND piece.composer_id = 193
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 112 Preludes on Old Southern Hymns Op. 112

UPDATE pieces piece
SET piece.title = 'Preludes on Old Southern Hymns Op. 112', piece.title_en = 'Preludes on Old Southern Hymns, op. 112',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '112',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17181 AND piece.composer_id = 193
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'By Babel''s Streams We Sat and Wept', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 1. By Babel''s Streams We Sat and Wept',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:0e20898f-d028-4146-b6ca-d1421e205abb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e20898f-d028-4146-b6ca-d1421e205abb', 1, NULL, 'By Babel''s Streams We Sat and Wept', 'Preludes on Old Southern Hymns, op. 112: No. 1. By Babel''s Streams We Sat and Wept', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e20898f-d028-4146-b6ca-d1421e205abb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'How Happy Are the Souls Above', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 2. How Happy Are the Souls Above',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:1680611d-354c-4b71-b8dd-41fce872cc5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1680611d-354c-4b71-b8dd-41fce872cc5c', 2, NULL, 'How Happy Are the Souls Above', 'Preludes on Old Southern Hymns, op. 112: No. 2. How Happy Are the Souls Above', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1680611d-354c-4b71-b8dd-41fce872cc5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Though the Morn May Be Serene', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 3. Though the Morn May Be Serene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:32d2f10b-3d91-472a-b30a-e255d19b2ece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32d2f10b-3d91-472a-b30a-e255d19b2ece', 3, NULL, 'Though the Morn May Be Serene', 'Preludes on Old Southern Hymns, op. 112: No. 3. Though the Morn May Be Serene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d2f10b-3d91-472a-b30a-e255d19b2ece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hail! Ye Sighing Sons of Sorrow', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 4. Hail! Ye Sighing Sons of Sorrow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:a6c2efb0-91a4-4f38-9d8c-6ae831dac35f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6c2efb0-91a4-4f38-9d8c-6ae831dac35f', 4, NULL, 'Hail! Ye Sighing Sons of Sorrow', 'Preludes on Old Southern Hymns, op. 112: No. 4. Hail! Ye Sighing Sons of Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6c2efb0-91a4-4f38-9d8c-6ae831dac35f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mercy, O Thou Son of David', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 5. Mercy, O Thou Son of David',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:0a443085-dd62-4049-a9f8-8365a16d08ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a443085-dd62-4049-a9f8-8365a16d08ad', 5, NULL, 'Mercy, O Thou Son of David', 'Preludes on Old Southern Hymns, op. 112: No. 5. Mercy, O Thou Son of David', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a443085-dd62-4049-a9f8-8365a16d08ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Hark, the Jubilee Is Sounding', part.name_en = 'Preludes on Old Southern Hymns, op. 112: No. 6. Hark, the Jubilee Is Sounding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17181 AND p.composer_id = 193 AND part.part_key = 'musicbrainz:dc75a3c8-aaa5-4c34-a3c3-ae7cb14c6bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc75a3c8-aaa5-4c34-a3c3-ae7cb14c6bd3', 6, NULL, 'Hark, the Jubilee Is Sounding', 'Preludes on Old Southern Hymns, op. 112: No. 6. Hark, the Jubilee Is Sounding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17181 AND p.composer_id = 193
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc75a3c8-aaa5-4c34-a3c3-ae7cb14c6bd3'
);


-- Op. 92 교향곡 4번

UPDATE pieces piece
SET piece.title = '교향곡 4번', piece.title_en = 'Symphony no. 4, op. 92',
    piece.type = 'song', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17984 AND piece.composer_id = 193
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 알랭 방카르 (composer_id 196) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 0, 낱곡 5),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None D'une fougère bleue les veines

UPDATE pieces piece
SET piece.title = 'D''une fougère bleue les veines', piece.title_en = 'D''une fougère bleue les veines',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17240 AND piece.composer_id = 196
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duo

UPDATE pieces piece
SET piece.title = 'Duo', piece.title_en = 'Duo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17081 AND piece.composer_id = 196
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La mort viendra et elle aura tes yeux

UPDATE pieces piece
SET piece.title = 'La mort viendra et elle aura tes yeux', piece.title_en = 'La mort viendra et elle aura tes yeux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17482 AND piece.composer_id = 196
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphonie n°I

UPDATE pieces piece
SET piece.title = 'Symphonie n°I', piece.title_en = 'Symphonie n°I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19506 AND piece.composer_id = 196
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Violente Vie

UPDATE pieces piece
SET piece.title = 'Violente Vie', piece.title_en = 'Violente Vie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16695 AND piece.composer_id = 196
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Gerard Victory (composer_id 197) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Gaelic Galop

UPDATE pieces piece
SET piece.title = 'Gaelic Galop', piece.title_en = 'Gaelic Galop',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17146 AND piece.composer_id = 197
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sliabh Geal gCua

UPDATE pieces piece
SET piece.title = 'Sliabh Geal gCua', piece.title_en = 'Sliabh Geal gCua',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16491 AND piece.composer_id = 197
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 프랑수아 프랑쾨르 (composer_id 199) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 10개(묶음 1, 다악장 8, 낱곡 1),
-- 새 작품 0개, part 49개, 그 아래 7개.
-- seed 18개 중 10개를 작품·part 에 잇고, 0개를 숨기고, 8개는 그대로 둔다.

-- None 첼로 소나타 E장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 E장조', piece.title_en = 'Cello Sonata in E major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18950 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Cello Sonata in E major: I. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18950 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:df4857f0-cc1b-3dae-b890-7ecf228d60ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df4857f0-cc1b-3dae-b890-7ecf228d60ed', 1, 'I', 'Adagio cantabile', 'Cello Sonata in E major: I. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18950 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df4857f0-cc1b-3dae-b890-7ecf228d60ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro vivo', part.name_en = 'Cello Sonata in E major: II. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18950 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:78e9de38-842d-3907-8236-13a7566d9d56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e9de38-842d-3907-8236-13a7566d9d56', 2, 'II', 'Allegro vivo', 'Cello Sonata in E major: II. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18950 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e9de38-842d-3907-8236-13a7566d9d56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo di gavotta', part.name_en = 'Cello Sonata in E major: III. Tempo di gavotta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18950 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:0695a293-6bb8-3abf-83ea-bf5643833441' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0695a293-6bb8-3abf-83ea-bf5643833441', 3, 'III', 'Tempo di gavotta', 'Cello Sonata in E major: III. Tempo di gavotta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18950 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0695a293-6bb8-3abf-83ea-bf5643833441'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo cantabile', part.name_en = 'Cello Sonata in E major: IV. Largo cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18950 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:0481c4d9-55f8-362d-bd13-cfdfbea7ea94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0481c4d9-55f8-362d-bd13-cfdfbea7ea94', 4, 'IV', 'Largo cantabile', 'Cello Sonata in E major: IV. Largo cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18950 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0481c4d9-55f8-362d-bd13-cfdfbea7ea94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Gigue: Allegro vivace', part.name_en = 'Cello Sonata in E major: V. Gigue: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18950 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:4ccce698-64de-36b3-9016-e966598c223a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ccce698-64de-36b3-9016-e966598c223a', 5, 'V', 'Gigue: Allegro vivace', 'Cello Sonata in E major: V. Gigue: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18950 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ccce698-64de-36b3-9016-e966598c223a'
);


-- None Ouverture. Air Grave et gai

UPDATE pieces piece
SET piece.title = 'Ouverture. Air Grave et gai', piece.title_en = 'Ouverture. Air Grave et gai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16865 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 소나타 10번 D장조

UPDATE pieces piece
SET piece.title = '소나타 10번 D장조', piece.title_en = 'Sonata no. 10 in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19439 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata no. 10 in D major: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19439 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:0789970e-ff9e-4f59-8c55-4e58eeb842d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0789970e-ff9e-4f59-8c55-4e58eeb842d1', 1, 'I', 'Adagio', 'Sonata no. 10 in D major: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19439 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0789970e-ff9e-4f59-8c55-4e58eeb842d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allemande', part.name_en = 'Sonata no. 10 in D major: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19439 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:168f52ee-6284-47e5-8bae-75967f61a347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:168f52ee-6284-47e5-8bae-75967f61a347', 2, 'II', 'Allemande', 'Sonata no. 10 in D major: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19439 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:168f52ee-6284-47e5-8bae-75967f61a347'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Sonata no. 10 in D major: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19439 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:715411b0-268a-49a2-9165-f9fafa2f2419' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:715411b0-268a-49a2-9165-f9fafa2f2419', 3, 'III', 'Adagio', 'Sonata no. 10 in D major: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19439 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:715411b0-268a-49a2-9165-f9fafa2f2419'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gavotte', part.name_en = 'Sonata no. 10 in D major: IV. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19439 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:a8478237-e0eb-4be8-a92f-2da153625ef3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8478237-e0eb-4be8-a92f-2da153625ef3', 4, 'IV', 'Gavotte', 'Sonata no. 10 in D major: IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19439 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8478237-e0eb-4be8-a92f-2da153625ef3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rondeau', part.name_en = 'Sonata no. 10 in D major: V. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19439 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:43f14b2c-32ff-48ce-b58d-ba6523c8ea6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f14b2c-32ff-48ce-b58d-ba6523c8ea6a', 5, 'V', 'Rondeau', 'Sonata no. 10 in D major: V. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19439 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f14b2c-32ff-48ce-b58d-ba6523c8ea6a'
);


-- None 소나타 12번 E장조

UPDATE pieces piece
SET piece.title = '소나타 12번 E장조', piece.title_en = 'Sonata no. 12 in E major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16062 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata no. 12 in E major: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16062 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:d762a2d0-c719-4f89-abb7-03cf7561bd5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d762a2d0-c719-4f89-abb7-03cf7561bd5f', 1, 'I', 'Adagio', 'Sonata no. 12 in E major: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16062 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d762a2d0-c719-4f89-abb7-03cf7561bd5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Courante', part.name_en = 'Sonata no. 12 in E major: II. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16062 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:917df605-8861-4458-afc0-af0e9572ee5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:917df605-8861-4458-afc0-af0e9572ee5f', 2, 'II', 'Courante', 'Sonata no. 12 in E major: II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16062 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917df605-8861-4458-afc0-af0e9572ee5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sicilienne', part.name_en = 'Sonata no. 12 in E major: III. Sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16062 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:79cf3346-ac7f-4e33-9abd-ff860ee12233' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79cf3346-ac7f-4e33-9abd-ff860ee12233', 3, 'III', 'Sicilienne', 'Sonata no. 12 in E major: III. Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16062 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79cf3346-ac7f-4e33-9abd-ff860ee12233'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondeau', part.name_en = 'Sonata no. 12 in E major: IV. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16062 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:31cd1a34-e4eb-4f67-b53b-a59d6430b453' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31cd1a34-e4eb-4f67-b53b-a59d6430b453', 4, 'IV', 'Rondeau', 'Sonata no. 12 in E major: IV. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16062 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31cd1a34-e4eb-4f67-b53b-a59d6430b453'
);


-- None 소나타 6번 G단조

UPDATE pieces piece
SET piece.title = '소나타 6번 G단조', piece.title_en = 'Sonata no. 6 in G minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16980 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata no. 6 in G minor: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16980 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:5cedc3d3-0664-4c4b-909d-4ec75ab1a611' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cedc3d3-0664-4c4b-909d-4ec75ab1a611', 1, 'I', 'Adagio', 'Sonata no. 6 in G minor: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16980 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cedc3d3-0664-4c4b-909d-4ec75ab1a611'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allemande', part.name_en = 'Sonata no. 6 in G minor: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16980 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:12d83b65-69c3-4129-a802-d0c73a849ac4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12d83b65-69c3-4129-a802-d0c73a849ac4', 2, 'II', 'Allemande', 'Sonata no. 6 in G minor: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16980 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12d83b65-69c3-4129-a802-d0c73a849ac4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Courante', part.name_en = 'Sonata no. 6 in G minor: III. Courante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16980 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:55ad786a-1a5a-496d-92a4-e1a8ba036a12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ad786a-1a5a-496d-92a4-e1a8ba036a12', 3, 'III', 'Courante', 'Sonata no. 6 in G minor: III. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16980 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ad786a-1a5a-496d-92a4-e1a8ba036a12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sarabande', part.name_en = 'Sonata no. 6 in G minor: IV. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16980 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:ddeafa80-0c8c-44b4-b454-a2743aefb4b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddeafa80-0c8c-44b4-b454-a2743aefb4b5', 4, 'IV', 'Sarabande', 'Sonata no. 6 in G minor: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16980 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddeafa80-0c8c-44b4-b454-a2743aefb4b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rondeau', part.name_en = 'Sonata no. 6 in G minor: V. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16980 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:69ce3050-0307-4e36-b508-8d2bd8ecafe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ce3050-0307-4e36-b508-8d2bd8ecafe9', 5, 'V', 'Rondeau', 'Sonata no. 6 in G minor: V. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16980 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ce3050-0307-4e36-b508-8d2bd8ecafe9'
);


-- None 소나타 7번 D단조

UPDATE pieces piece
SET piece.title = '소나타 7번 D단조', piece.title_en = 'Sonata no. 7 in D minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17031 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata no. 7 in D minor: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17031 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:193da4da-c51e-4676-bda0-9b02c076bc2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:193da4da-c51e-4676-bda0-9b02c076bc2c', 1, 'I', 'Adagio', 'Sonata no. 7 in D minor: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17031 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193da4da-c51e-4676-bda0-9b02c076bc2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allemande', part.name_en = 'Sonata no. 7 in D minor: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17031 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:297fc8cc-c65a-4b34-9428-3403e8ca810e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:297fc8cc-c65a-4b34-9428-3403e8ca810e', 2, 'II', 'Allemande', 'Sonata no. 7 in D minor: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17031 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:297fc8cc-c65a-4b34-9428-3403e8ca810e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondeau', part.name_en = 'Sonata no. 7 in D minor: III. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17031 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:bb0bd34b-66be-41b6-8369-405dbe79147e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb0bd34b-66be-41b6-8369-405dbe79147e', 3, 'III', 'Rondeau', 'Sonata no. 7 in D minor: III. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17031 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb0bd34b-66be-41b6-8369-405dbe79147e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sarabande', part.name_en = 'Sonata no. 7 in D minor: IV. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17031 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:9ef1bb3b-2230-4ba2-bb92-2070fc76f27e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ef1bb3b-2230-4ba2-bb92-2070fc76f27e', 4, 'IV', 'Sarabande', 'Sonata no. 7 in D minor: IV. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17031 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ef1bb3b-2230-4ba2-bb92-2070fc76f27e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rondeau', part.name_en = 'Sonata no. 7 in D minor: V. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17031 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:4709ef1f-b9d7-4fa8-975e-9724f5ff4020' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4709ef1f-b9d7-4fa8-975e-9724f5ff4020', 5, 'V', 'Rondeau', 'Sonata no. 7 in D minor: V. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17031 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4709ef1f-b9d7-4fa8-975e-9724f5ff4020'
);


-- None Sonate en la majeur

UPDATE pieces piece
SET piece.title = 'Sonate en la majeur', piece.title_en = 'Sonate en la majeur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18183 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonate en La majeur: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:db47fa76-a178-4a2f-90f6-1b1230ad6939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db47fa76-a178-4a2f-90f6-1b1230ad6939', 1, 'I', 'Adagio', 'Sonate en La majeur: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db47fa76-a178-4a2f-90f6-1b1230ad6939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Sonate en La majeur: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:a8bc435f-1a89-4660-b6d8-0ea2becbad20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8bc435f-1a89-4660-b6d8-0ea2becbad20', 2, 'II', 'Allegro', 'Sonate en La majeur: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8bc435f-1a89-4660-b6d8-0ea2becbad20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pastourelle', part.name_en = 'Sonate en La majeur: III. Pastourelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:8fa3343b-14e5-4fb1-938b-df1be75bf7e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa3343b-14e5-4fb1-938b-df1be75bf7e8', 3, 'III', 'Pastourelle', 'Sonate en La majeur: III. Pastourelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa3343b-14e5-4fb1-938b-df1be75bf7e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'L''Amour fait naître nos désirs', part.name_en = 'Sonate en La majeur: IV. L''Amour fait naître nos désirs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:7bcfc35d-b0e7-4caa-be61-9bd0d01031e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bcfc35d-b0e7-4caa-be61-9bd0d01031e1', 4, 'IV', 'L''Amour fait naître nos désirs', 'Sonate en La majeur: IV. L''Amour fait naître nos désirs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bcfc35d-b0e7-4caa-be61-9bd0d01031e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Gay', part.name_en = 'Sonate en La majeur: V. Gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:4c5c7c4e-bcd9-4ae0-b347-a1f1f790b056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c5c7c4e-bcd9-4ae0-b347-a1f1f790b056', 5, 'V', 'Gay', 'Sonate en La majeur: V. Gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c5c7c4e-bcd9-4ae0-b347-a1f1f790b056'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Loin de nos cœurs les tristes plaintes', part.name_en = 'Sonate en La majeur: VI. Loin de nos cœurs les tristes plaintes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:d5ed3a5e-d65f-484f-9c42-42793679d4e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5ed3a5e-d65f-484f-9c42-42793679d4e9', 6, 'VI', 'Loin de nos cœurs les tristes plaintes', 'Sonate en La majeur: VI. Loin de nos cœurs les tristes plaintes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5ed3a5e-d65f-484f-9c42-42793679d4e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Vole de victoire en victoire', part.name_en = 'Sonate en La majeur: VII. Vole de victoire en victoire...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:bf66fa32-5ae0-4953-8dbd-244c0ef1aed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf66fa32-5ae0-4953-8dbd-244c0ef1aed8', 7, 'VII', 'Vole de victoire en victoire', 'Sonate en La majeur: VII. Vole de victoire en victoire...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf66fa32-5ae0-4953-8dbd-244c0ef1aed8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Splendete, luci belle', part.name_en = 'Sonate en La majeur: VIII. Splendete, luci belle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18183 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:9941d6a5-8018-46cb-9875-f03d1824d019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9941d6a5-8018-46cb-9875-f03d1824d019', 8, 'VIII', 'Splendete, luci belle', 'Sonate en La majeur: VIII. Splendete, luci belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18183 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9941d6a5-8018-46cb-9875-f03d1824d019'
);


-- None Sonate en mi mineur

UPDATE pieces piece
SET piece.title = 'Sonate en mi mineur', piece.title_en = 'Sonate en mi mineur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16928 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonate en mi mineur: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16928 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:22ce5ecf-cdca-42d9-a6b9-687a4fa0f6aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22ce5ecf-cdca-42d9-a6b9-687a4fa0f6aa', 1, 'I', 'Adagio', 'Sonate en mi mineur: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16928 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22ce5ecf-cdca-42d9-a6b9-687a4fa0f6aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Courente', part.name_en = 'Sonate en mi mineur: II. Courente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16928 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:f791a3fc-13f4-41e3-a3f1-e5697cfb1609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f791a3fc-13f4-41e3-a3f1-e5697cfb1609', 2, 'II', 'Courente', 'Sonate en mi mineur: II. Courente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16928 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f791a3fc-13f4-41e3-a3f1-e5697cfb1609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sarabande', part.name_en = 'Sonate en mi mineur: III. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16928 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:1dd20f1a-1785-4e99-9f06-112ad3fd17e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dd20f1a-1785-4e99-9f06-112ad3fd17e8', 3, 'III', 'Sarabande', 'Sonate en mi mineur: III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16928 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dd20f1a-1785-4e99-9f06-112ad3fd17e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondeau', part.name_en = 'Sonate en mi mineur: IV. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16928 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:c9d16eaa-5043-4585-b3c7-a92fe3edbb5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9d16eaa-5043-4585-b3c7-a92fe3edbb5d', 4, 'IV', 'Rondeau', 'Sonate en mi mineur: IV. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16928 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d16eaa-5043-4585-b3c7-a92fe3edbb5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fureur, Amour, secondés mon impatience', part.name_en = 'Sonate en mi mineur: V. Fureur, Amour, secondés mon impatience',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16928 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:4435e9a3-7fc5-443c-92e0-81d17086ec8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4435e9a3-7fc5-443c-92e0-81d17086ec8e', 5, 'V', 'Fureur, Amour, secondés mon impatience', 'Sonate en mi mineur: V. Fureur, Amour, secondés mon impatience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16928 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4435e9a3-7fc5-443c-92e0-81d17086ec8e'
);


-- None Sonate en re mineur

UPDATE pieces piece
SET piece.title = 'Sonate en re mineur', piece.title_en = 'Sonate en re mineur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16662 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonate en re mineur: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:c4b1bf28-6313-44d8-abd1-7186657deeb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4b1bf28-6313-44d8-abd1-7186657deeb9', 1, 'I', 'Adagio', 'Sonate en re mineur: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4b1bf28-6313-44d8-abd1-7186657deeb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allemande', part.name_en = 'Sonate en re mineur: II. Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:a7612b03-d4dc-4819-a638-e36644a04d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7612b03-d4dc-4819-a638-e36644a04d2d', 2, 'II', 'Allemande', 'Sonate en re mineur: II. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7612b03-d4dc-4819-a638-e36644a04d2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Que dans ce séjour, nos transports paroissent', part.name_en = 'Sonate en re mineur: III. Que dans ce séjour, nos transports paroissent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:7626e185-c52e-4067-b63e-b05e344c06c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7626e185-c52e-4067-b63e-b05e344c06c2', 3, 'III', 'Que dans ce séjour, nos transports paroissent', 'Sonate en re mineur: III. Que dans ce séjour, nos transports paroissent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7626e185-c52e-4067-b63e-b05e344c06c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sicilienne', part.name_en = 'Sonate en re mineur: IV. Sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:3a977a59-1cdb-49d7-9903-6ee9d2dd18ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a977a59-1cdb-49d7-9903-6ee9d2dd18ec', 4, 'IV', 'Sicilienne', 'Sonate en re mineur: IV. Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a977a59-1cdb-49d7-9903-6ee9d2dd18ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lance tes traits, Amour', part.name_en = 'Sonate en re mineur: V. Lance tes traits, Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:23408271-1f52-4853-9755-6c9fc17cc616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23408271-1f52-4853-9755-6c9fc17cc616', 5, 'V', 'Lance tes traits, Amour', 'Sonate en re mineur: V. Lance tes traits, Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23408271-1f52-4853-9755-6c9fc17cc616'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Rondeau', part.name_en = 'Sonate en re mineur: VI. Rondeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:2e4d0290-8e58-40d3-8756-ed4cc40879da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e4d0290-8e58-40d3-8756-ed4cc40879da', 6, 'VI', 'Rondeau', 'Sonate en re mineur: VI. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e4d0290-8e58-40d3-8756-ed4cc40879da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Adagio', part.name_en = 'Sonate en re mineur: VII. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:3deaf99e-f9b3-47c2-b6b3-ad914e537ad0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3deaf99e-f9b3-47c2-b6b3-ad914e537ad0', 7, 'VII', 'Adagio', 'Sonate en re mineur: VII. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3deaf99e-f9b3-47c2-b6b3-ad914e537ad0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'D''un tendre Amour, ne craignez rien', part.name_en = 'Sonate en re mineur: VIII. D''un tendre Amour, ne craignez rien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:c58ec1a7-7a8f-4021-b9d4-4aa09203a0ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c58ec1a7-7a8f-4021-b9d4-4aa09203a0ec', 8, 'VIII', 'D''un tendre Amour, ne craignez rien', 'Sonate en re mineur: VIII. D''un tendre Amour, ne craignez rien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c58ec1a7-7a8f-4021-b9d4-4aa09203a0ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Amans, voulez-vous être heureux?', part.name_en = 'Sonate en re mineur: IX. Amans, voulez-vous être heureux?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:23f5ad5d-d58d-4248-b0e6-41dbe2ecfbd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f5ad5d-d58d-4248-b0e6-41dbe2ecfbd3', 9, 'IX', 'Amans, voulez-vous être heureux?', 'Sonate en re mineur: IX. Amans, voulez-vous être heureux?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f5ad5d-d58d-4248-b0e6-41dbe2ecfbd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Gay', part.name_en = 'Sonate en re mineur: X. Gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16662 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:64b4e59e-4ed6-4a93-a7a7-e17af6ff8b8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64b4e59e-4ed6-4a93-a7a7-e17af6ff8b8e', 10, 'X', 'Gay', 'Sonate en re mineur: X. Gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16662 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b4e59e-4ed6-4a93-a7a7-e17af6ff8b8e'
);


-- None Symphonies pour le Festin Royal du Comte d'Artois

UPDATE pieces piece
SET piece.title = 'Symphonies pour le Festin Royal du Comte d''Artois', piece.title_en = 'Symphonies pour le Festin Royal du Comte d''Artois',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19375 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:4a379460-25da-4cc8-b689-129e804ed3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a379460-25da-4cc8-b689-129e804ed3c8', 1, NULL, 'D장조', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a379460-25da-4cc8-b689-129e804ed3c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a', 2, NULL, 'G단조', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:e4eb9f7e-5a78-43fa-b940-34e5065116ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4eb9f7e-5a78-43fa-b940-34e5065116ae', 1, NULL, 'Ouverture', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4eb9f7e-5a78-43fa-b940-34e5065116ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Air gracieux', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: II. Air gracieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:bc979e0f-1f93-4b99-8dc3-1e8c727424c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc979e0f-1f93-4b99-8dc3-1e8c727424c1', 2, NULL, 'Air gracieux', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: II. Air gracieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc979e0f-1f93-4b99-8dc3-1e8c727424c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air vif', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: III. Air vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:34ec2dc2-03c2-44be-83d8-efd3c270ba03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34ec2dc2-03c2-44be-83d8-efd3c270ba03', 3, NULL, 'Air vif', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: III. Air vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ec2dc2-03c2-44be-83d8-efd3c270ba03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gavottes 1 & 2', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: IV. Gavottes 1 & 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:ef340c10-74f8-4342-b347-f61f94e2fa9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef340c10-74f8-4342-b347-f61f94e2fa9b', 4, NULL, 'Gavottes 1 & 2', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: IV. Gavottes 1 & 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef340c10-74f8-4342-b347-f61f94e2fa9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Air marqué', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: V. Air marqué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:f4e8c13b-d2ed-45b0-a305-4fa2f63f6182' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4e8c13b-d2ed-45b0-a305-4fa2f63f6182', 5, NULL, 'Air marqué', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: V. Air marqué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4e8c13b-d2ed-45b0-a305-4fa2f63f6182'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Air vif', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: VI. Air vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:b5689f11-9341-48f3-bbfd-fece0e44a97a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5689f11-9341-48f3-bbfd-fece0e44a97a', 6, NULL, 'Air vif', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: VI. Air vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5689f11-9341-48f3-bbfd-fece0e44a97a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Contredanse', part.name_en = 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: VII. Contredanse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19375 AND p.composer_id = 199 AND part.part_key = 'musicbrainz:7e1c6e38-e38d-4ea8-8636-7dc9988e7132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e1c6e38-e38d-4ea8-8636-7dc9988e7132', 7, NULL, 'Contredanse', 'Symphonies pour le Festin Royal du Comte d''Artois: Suite in G minor: VII. Contredanse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:be5ff395-9ea6-4da7-9eab-9cc60fd90f1a'
WHERE p.id = 19375 AND p.composer_id = 199
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e1c6e38-e38d-4ea8-8636-7dc9988e7132'
);

-- 숨길 seed 작품 없음

-- ===== Édouard Batiste (composer_id 201) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 8개(묶음 0, 다악장 0, 낱곡 8),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 8개 중 8개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 29 Communion en mi majeur

UPDATE pieces piece
SET piece.title = 'Communion en mi majeur', piece.title_en = 'Communion en mi majeur, op. 29',
    piece.type = 'song', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19658 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 Elévation en la bémol majeur

UPDATE pieces piece
SET piece.title = 'Elévation en la bémol majeur', piece.title_en = 'Elévation en la bémol majeur, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18723 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Grand Offertoire in D

UPDATE pieces piece
SET piece.title = 'Grand Offertoire in D', piece.title_en = 'Grand Offertoire in D',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18294 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 행진곡 E♭장조

UPDATE pieces piece
SET piece.title = '행진곡 E♭장조', piece.title_en = 'March in E-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19665 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 Offertoire - Fantaisie - Orage

UPDATE pieces piece
SET piece.title = 'Offertoire - Fantaisie - Orage', piece.title_en = 'Offertoire - Fantaisie - Orage, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17352 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Offertoire in D minor

UPDATE pieces piece
SET piece.title = 'Offertoire in D minor', piece.title_en = 'Offertoire in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19167 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Offertoire in G major

UPDATE pieces piece
SET piece.title = 'Offertoire in G major', piece.title_en = 'Offertoire in G major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16872 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Élévation

UPDATE pieces piece
SET piece.title = 'Élévation', piece.title_en = 'Élévation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16305 AND piece.composer_id = 201
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Thomas Pasatieri (composer_id 202) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Alleluia>

UPDATE pieces piece
SET piece.title = '가곡 <Alleluia>', piece.title_en = 'Alleluia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19356 AND piece.composer_id = 202
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
