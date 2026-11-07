-- 존 애덤스 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 53개(묶음 16, 다악장 16, 낱곡 21),
-- 새 작품 3개, part 112개, 그 아래 171개.
-- seed 51개 중 50개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.
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

-- None A Flowering Tree

UPDATE pieces piece
SET piece.title = 'A Flowering Tree', piece.title_en = 'A Flowering Tree',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25939 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bride and Groom', part.name_en = 'A Flowering Tree: Bride and Groom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:114f380f-5f3d-4a91-812f-9573a54c9a23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:114f380f-5f3d-4a91-812f-9573a54c9a23', 1, NULL, 'Bride and Groom', 'A Flowering Tree: Bride and Groom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:114f380f-5f3d-4a91-812f-9573a54c9a23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mamá Mamá, ¿Por Qué Nos Pegas?', part.name_en = 'A Flowering Tree: Mamá Mamá, ¿Por Qué Nos Pegas?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1ee1d7c0-4f98-4c75-ad9b-a365d549392a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ee1d7c0-4f98-4c75-ad9b-a365d549392a', 2, NULL, 'Mamá Mamá, ¿Por Qué Nos Pegas?', 'A Flowering Tree: Mamá Mamá, ¿Por Qué Nos Pegas?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee1d7c0-4f98-4c75-ad9b-a365d549392a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 4: The Wedding', part.name_en = 'A Flowering Tree: Scene 4: The Wedding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4880011b-2cf5-46ba-bd62-2a81ae77475c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4880011b-2cf5-46ba-bd62-2a81ae77475c', 3, NULL, 'Scene 4: The Wedding', 'A Flowering Tree: Scene 4: The Wedding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4880011b-2cf5-46ba-bd62-2a81ae77475c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'They Brought Her to Me', part.name_en = 'A Flowering Tree: They Brought Her to Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:514ca002-751b-4b64-8db3-c86b03a8d161' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514ca002-751b-4b64-8db3-c86b03a8d161', 4, NULL, 'They Brought Her to Me', 'A Flowering Tree: They Brought Her to Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514ca002-751b-4b64-8db3-c86b03a8d161'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Prince Recognizes Kumudha', part.name_en = 'A Flowering Tree: The Prince Recognizes Kumudha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:64c81a27-e710-4707-acfa-096a6fbc9531' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64c81a27-e710-4707-acfa-096a6fbc9531', 5, NULL, 'The Prince Recognizes Kumudha', 'A Flowering Tree: The Prince Recognizes Kumudha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c81a27-e710-4707-acfa-096a6fbc9531'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'One Morning…', part.name_en = 'A Flowering Tree: One Morning…',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6ade66f1-ebc2-48e6-bcc0-e21f5f44c548' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ade66f1-ebc2-48e6-bcc0-e21f5f44c548', 6, NULL, 'One Morning…', 'A Flowering Tree: One Morning…', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ade66f1-ebc2-48e6-bcc0-e21f5f44c548'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Flores Chorus', part.name_en = 'A Flowering Tree: Scene 2: Flores Chorus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6b87ed0d-7a51-43a7-96b9-11f8315a7c1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b87ed0d-7a51-43a7-96b9-11f8315a7c1e', 7, NULL, 'Scene 2: Flores Chorus', 'A Flowering Tree: Scene 2: Flores Chorus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b87ed0d-7a51-43a7-96b9-11f8315a7c1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 5: We Had All but Forgotten You, Prince', part.name_en = 'A Flowering Tree: Scene 5: We Had All but Forgotten You, Prince',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7156e97a-929b-4fca-9189-c023ab59a367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7156e97a-929b-4fca-9189-c023ab59a367', 8, NULL, 'Scene 5: We Had All but Forgotten You, Prince', 'A Flowering Tree: Scene 5: We Had All but Forgotten You, Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7156e97a-929b-4fca-9189-c023ab59a367'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 3: Before I Laughed With Him Nightly', part.name_en = 'A Flowering Tree: Scene 3: Before I Laughed With Him Nightly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:90417599-f26b-4567-956b-c1a1f2c6e6bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90417599-f26b-4567-956b-c1a1f2c6e6bc', 9, NULL, 'Scene 3: Before I Laughed With Him Nightly', 'A Flowering Tree: Scene 3: Before I Laughed With Him Nightly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90417599-f26b-4567-956b-c1a1f2c6e6bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Kumudha’s Prayer', part.name_en = 'A Flowering Tree: Kumudha’s Prayer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9322b743-c9ad-435a-b6df-cc2fc0a0cbcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9322b743-c9ad-435a-b6df-cc2fc0a0cbcb', 10, NULL, 'Kumudha’s Prayer', 'A Flowering Tree: Kumudha’s Prayer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9322b743-c9ad-435a-b6df-cc2fc0a0cbcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '“You Are Cruel.”', part.name_en = 'A Flowering Tree: “You Are Cruel.”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b66f5f62-cf95-48ee-9bbf-2e85255e7a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b66f5f62-cf95-48ee-9bbf-2e85255e7a5c', 11, NULL, '“You Are Cruel.”', 'A Flowering Tree: “You Are Cruel.”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66f5f62-cf95-48ee-9bbf-2e85255e7a5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Kumudha and Her Sister…', part.name_en = 'A Flowering Tree: Kumudha and Her Sister…',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c570bc1f-91c1-4021-b18c-3747ae47c57e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c570bc1f-91c1-4021-b18c-3747ae47c57e', 12, NULL, 'Kumudha and Her Sister…', 'A Flowering Tree: Kumudha and Her Sister…', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c570bc1f-91c1-4021-b18c-3747ae47c57e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene 3: Audience With the King', part.name_en = 'A Flowering Tree: Scene 3: Audience With the King',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cfa851e7-3342-4e29-8070-02b016868ece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfa851e7-3342-4e29-8070-02b016868ece', 13, NULL, 'Scene 3: Audience With the King', 'A Flowering Tree: Scene 3: Audience With the King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa851e7-3342-4e29-8070-02b016868ece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '“Days Passed…”', part.name_en = 'A Flowering Tree: “Days Passed…”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:dbc2eb0e-09b7-4750-9708-6587f3b06017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc2eb0e-09b7-4750-9708-6587f3b06017', 14, NULL, '“Days Passed…”', 'A Flowering Tree: “Days Passed…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc2eb0e-09b7-4750-9708-6587f3b06017'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act Il Scene 1: Orchestral Prelude', part.name_en = 'A Flowering Tree: Act Il Scene 1: Orchestral Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e0430ac3-e8fd-40c2-86f8-91a8059c4d35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0430ac3-e8fd-40c2-86f8-91a8059c4d35', 15, NULL, 'Act Il Scene 1: Orchestral Prelude', 'A Flowering Tree: Act Il Scene 1: Orchestral Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0430ac3-e8fd-40c2-86f8-91a8059c4d35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '“Kumudha Once More…”', part.name_en = 'A Flowering Tree: “Kumudha Once More…”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e3ef1e79-f2a6-4ef1-b491-c5d1783bb16e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3ef1e79-f2a6-4ef1-b491-c5d1783bb16e', 16, NULL, '“Kumudha Once More…”', 'A Flowering Tree: “Kumudha Once More…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3ef1e79-f2a6-4ef1-b491-c5d1783bb16e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act I Scene 1', part.name_en = 'A Flowering Tree: Act I Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e947e0f5-e953-4ae0-8d0e-6e6f52c7eae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e947e0f5-e953-4ae0-8d0e-6e6f52c7eae5', 17, NULL, 'Act I Scene 1', 'A Flowering Tree: Act I Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e947e0f5-e953-4ae0-8d0e-6e6f52c7eae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Scene 4: Kumudha and the Beggar Minstrels', part.name_en = 'A Flowering Tree: Scene 4: Kumudha and the Beggar Minstrels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ec0991b9-6260-4c9a-81c3-d0a65a1fa1cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec0991b9-6260-4c9a-81c3-d0a65a1fa1cf', 18, NULL, 'Scene 4: Kumudha and the Beggar Minstrels', 'A Flowering Tree: Scene 4: Kumudha and the Beggar Minstrels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec0991b9-6260-4c9a-81c3-d0a65a1fa1cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Kumudha’s Final Transformation', part.name_en = 'A Flowering Tree: Kumudha’s Final Transformation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:edf84ae7-ae9a-4f4e-ab9d-14dfb53b2d98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf84ae7-ae9a-4f4e-ab9d-14dfb53b2d98', 19, NULL, 'Kumudha’s Final Transformation', 'A Flowering Tree: Kumudha’s Final Transformation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf84ae7-ae9a-4f4e-ab9d-14dfb53b2d98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Bride Sunk Her Face…', part.name_en = 'A Flowering Tree: The Bride Sunk Her Face…',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25939 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:efa7ae51-9e98-4560-81fc-b689184d34ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa7ae51-9e98-4560-81fc-b689184d34ab', 20, NULL, 'The Bride Sunk Her Face…', 'A Flowering Tree: The Bride Sunk Her Face…', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25939 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa7ae51-9e98-4560-81fc-b689184d34ab'
);


-- None Absolute Jest

UPDATE pieces piece
SET piece.title = 'Absolute Jest', piece.title_en = 'Absolute Jest',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24332 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None American Berserk

UPDATE pieces piece
SET piece.title = 'American Berserk', piece.title_en = 'American Berserk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24497 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None American Standard

UPDATE pieces piece
SET piece.title = 'American Standard', piece.title_en = 'American Standard',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24088 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Christian Zeal and Activity', part.name_en = 'American Standard: Christian Zeal and Activity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24088 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2577c8aa-d439-485e-9e2e-df0aeee16fe1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2577c8aa-d439-485e-9e2e-df0aeee16fe1', 1, NULL, 'Christian Zeal and Activity', 'American Standard: Christian Zeal and Activity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24088 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2577c8aa-d439-485e-9e2e-df0aeee16fe1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'John Philip Sousa', part.name_en = 'American Standard: John Philip Sousa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24088 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:108167a4-89e7-44d2-8711-7803a1c66f10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:108167a4-89e7-44d2-8711-7803a1c66f10', 2, NULL, 'John Philip Sousa', 'American Standard: John Philip Sousa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24088 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:108167a4-89e7-44d2-8711-7803a1c66f10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sentimentals', part.name_en = 'American Standard: Sentimentals',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24088 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8e490956-93a6-457a-9f7b-290995764d32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e490956-93a6-457a-9f7b-290995764d32', 3, NULL, 'Sentimentals', 'American Standard: Sentimentals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24088 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e490956-93a6-457a-9f7b-290995764d32'
);


-- None Century Rolls

UPDATE pieces piece
SET piece.title = 'Century Rolls', piece.title_en = 'Century Rolls',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25372 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'First Movement', part.name_en = 'Century Rolls: I. First Movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25372 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6e9ded10-39ec-421b-84cf-67ad99a9a295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9ded10-39ec-421b-84cf-67ad99a9a295', 1, 'I', 'First Movement', 'Century Rolls: I. First Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25372 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9ded10-39ec-421b-84cf-67ad99a9a295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Manny''s Gym', part.name_en = 'Century Rolls: II. Manny''s Gym',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25372 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b8b0482e-20fe-4237-8908-c48a885337b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8b0482e-20fe-4237-8908-c48a885337b7', 2, 'II', 'Manny''s Gym', 'Century Rolls: II. Manny''s Gym', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25372 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8b0482e-20fe-4237-8908-c48a885337b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Hail Bop', part.name_en = 'Century Rolls: III. Hail Bop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25372 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:fb0f2a88-1bbb-4459-a8f9-e912800409b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb0f2a88-1bbb-4459-a8f9-e912800409b1', 3, 'III', 'Hail Bop', 'Century Rolls: III. Hail Bop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25372 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb0f2a88-1bbb-4459-a8f9-e912800409b1'
);


-- None Chamber Symphony

UPDATE pieces piece
SET piece.title = 'Chamber Symphony', piece.title_en = 'Chamber Symphony',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24683 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mongrel Airs', part.name_en = 'Chamber Symphony: I. Mongrel Airs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24683 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:fba34aac-3ef2-3597-839c-e8ff7f1c796e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fba34aac-3ef2-3597-839c-e8ff7f1c796e', 1, 'I', 'Mongrel Airs', 'Chamber Symphony: I. Mongrel Airs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24683 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba34aac-3ef2-3597-839c-e8ff7f1c796e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aria with Walking Bass', part.name_en = 'Chamber Symphony: II. Aria with Walking Bass',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24683 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ff5f438c-832d-3ba6-b582-f7d5b6e212d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff5f438c-832d-3ba6-b582-f7d5b6e212d6', 2, 'II', 'Aria with Walking Bass', 'Chamber Symphony: II. Aria with Walking Bass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24683 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff5f438c-832d-3ba6-b582-f7d5b6e212d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Roadrunner', part.name_en = 'Chamber Symphony: III. Roadrunner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24683 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4738bec5-ae99-3f5d-83a7-69e06c9b6bcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4738bec5-ae99-3f5d-83a7-69e06c9b6bcd', 3, 'III', 'Roadrunner', 'Chamber Symphony: III. Roadrunner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24683 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4738bec5-ae99-3f5d-83a7-69e06c9b6bcd'
);


-- None City Noir

UPDATE pieces piece
SET piece.title = 'City Noir', piece.title_en = 'City Noir',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25766 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The City and its Double –', part.name_en = 'City Noir: I. The City and its Double –',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25766 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6f169047-939e-4ecb-837d-28a8862789d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f169047-939e-4ecb-837d-28a8862789d2', 1, 'I', 'The City and its Double –', 'City Noir: I. The City and its Double –', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25766 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f169047-939e-4ecb-837d-28a8862789d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Song is for You', part.name_en = 'City Noir: II. The Song is for You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25766 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:85a1027e-d055-4ad4-97ee-827a287130d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85a1027e-d055-4ad4-97ee-827a287130d6', 2, 'II', 'The Song is for You', 'City Noir: II. The Song is for You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25766 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a1027e-d055-4ad4-97ee-827a287130d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Boulevard Night', part.name_en = 'City Noir: III. Boulevard Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25766 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a903125c-9786-4951-856d-6c12a606ca42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a903125c-9786-4951-856d-6c12a606ca42', 3, 'III', 'Boulevard Night', 'City Noir: III. Boulevard Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25766 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a903125c-9786-4951-856d-6c12a606ca42'
);


-- None City Noir: Boulevard Night

UPDATE pieces piece
SET piece.title = 'City Noir: Boulevard Night', piece.title_en = 'City Noir: Boulevard Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23853 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None City Noir: The City and Its Double

UPDATE pieces piece
SET piece.title = 'City Noir: The City and Its Double', piece.title_en = 'City Noir: The City and Its Double',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25769 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None City Noir: The Song Is for You

UPDATE pieces piece
SET piece.title = 'City Noir: The Song Is for You', piece.title_en = 'City Noir: The Song Is for You',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25830 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Common Tones in Simple Time

UPDATE pieces piece
SET piece.title = 'Common Tones in Simple Time', piece.title_en = 'Common Tones in Simple Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23520 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Doctor Atomic>

UPDATE pieces piece
SET piece.title = '오페라 <Doctor Atomic>', piece.title_en = 'Doctor Atomic',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25732 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Doctor Atomic: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a3cf82fb-4c47-4bbf-a3f4-28edf2448b23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3cf82fb-4c47-4bbf-a3f4-28edf2448b23', 1, NULL, 'Overture', 'Doctor Atomic: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3cf82fb-4c47-4bbf-a3f4-28edf2448b23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act 1', part.name_en = 'Doctor Atomic: Act 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf', 2, NULL, 'Act 1', 'Doctor Atomic: Act 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Five hundred US Superfortresses are raining incendiary bombs', part.name_en = 'Doctor Atomic: Act 1: Five hundred US Superfortresses are raining incendiary bombs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:08b8527b-f696-497f-8dff-9a400aac47ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08b8527b-f696-497f-8dff-9a400aac47ad', 1, NULL, 'Five hundred US Superfortresses are raining incendiary bombs', 'Doctor Atomic: Act 1: Five hundred US Superfortresses are raining incendiary bombs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b8527b-f696-497f-8dff-9a400aac47ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The test must go on as scheduled', part.name_en = 'Doctor Atomic: Act 1: The test must go on as scheduled',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:18c154a9-f5ac-49cc-9f6b-6cc18fbdedf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18c154a9-f5ac-49cc-9f6b-6cc18fbdedf1', 2, NULL, 'The test must go on as scheduled', 'Doctor Atomic: Act 1: The test must go on as scheduled', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18c154a9-f5ac-49cc-9f6b-6cc18fbdedf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Am I in your light?', part.name_en = 'Doctor Atomic: Act 1: Am I in your light?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:291fcc33-7f5d-4397-90c8-9106ec7daf33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:291fcc33-7f5d-4397-90c8-9106ec7daf33', 3, NULL, 'Am I in your light?', 'Doctor Atomic: Act 1: Am I in your light?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:291fcc33-7f5d-4397-90c8-9106ec7daf33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'We surround the plutonium core', part.name_en = 'Doctor Atomic: Act 1: We surround the plutonium core',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3bbcf736-057d-426b-b8fe-c6ea44a59f0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bbcf736-057d-426b-b8fe-c6ea44a59f0f', 4, NULL, 'We surround the plutonium core', 'Doctor Atomic: Act 1: We surround the plutonium core', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bbcf736-057d-426b-b8fe-c6ea44a59f0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'I have been preoccupied with many matters', part.name_en = 'Doctor Atomic: Act 1: I have been preoccupied with many matters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:49babefc-085e-4ec5-bcb0-a2bf796a5a10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49babefc-085e-4ec5-bcb0-a2bf796a5a10', 5, NULL, 'I have been preoccupied with many matters', 'Doctor Atomic: Act 1: I have been preoccupied with many matters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49babefc-085e-4ec5-bcb0-a2bf796a5a10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Electrical storm', part.name_en = 'Doctor Atomic: Act 1: Electrical storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:54512ecc-898c-4af0-8011-e032523d3579' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54512ecc-898c-4af0-8011-e032523d3579', 6, NULL, 'Electrical storm', 'Doctor Atomic: Act 1: Electrical storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54512ecc-898c-4af0-8011-e032523d3579'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'First of all, let me say', part.name_en = 'Doctor Atomic: Act 1: First of all, let me say',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5df525ea-8826-49d0-b4c8-de1cfe0acf16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5df525ea-8826-49d0-b4c8-de1cfe0acf16', 7, NULL, 'First of all, let me say', 'Doctor Atomic: Act 1: First of all, let me say', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df525ea-8826-49d0-b4c8-de1cfe0acf16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The motive of it all was loneliness', part.name_en = 'Doctor Atomic: Act 1: The motive of it all was loneliness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5f422bc8-3453-4979-b0db-a1c38dde275f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f422bc8-3453-4979-b0db-a1c38dde275f', 8, NULL, 'The motive of it all was loneliness', 'Doctor Atomic: Act 1: The motive of it all was loneliness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f422bc8-3453-4979-b0db-a1c38dde275f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Many of us are inclined to say', part.name_en = 'Doctor Atomic: Act 1: Many of us are inclined to say',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:97ae8d8e-af4a-48a7-a001-60bb54509c88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97ae8d8e-af4a-48a7-a001-60bb54509c88', 9, NULL, 'Many of us are inclined to say', 'Doctor Atomic: Act 1: Many of us are inclined to say', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ae8d8e-af4a-48a7-a001-60bb54509c88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'What the hell is wrong with the weather?', part.name_en = 'Doctor Atomic: Act 1: What the hell is wrong with the weather?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9e4a42e3-fb13-472d-8280-2c89fb4968e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e4a42e3-fb13-472d-8280-2c89fb4968e3', 10, NULL, 'What the hell is wrong with the weather?', 'Doctor Atomic: Act 1: What the hell is wrong with the weather?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e4a42e3-fb13-472d-8280-2c89fb4968e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'This is a petition', part.name_en = 'Doctor Atomic: Act 1: This is a petition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a89783d7-3ba3-4f11-bf10-ce3fea9fb640' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a89783d7-3ba3-4f11-bf10-ce3fea9fb640', 11, NULL, 'This is a petition', 'Doctor Atomic: Act 1: This is a petition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a89783d7-3ba3-4f11-bf10-ce3fea9fb640'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'With respect, sir, anyone with good eyes', part.name_en = 'Doctor Atomic: Act 1: With respect, sir, anyone with good eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b84fd478-bb63-4701-b134-dab3e966a786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b84fd478-bb63-4701-b134-dab3e966a786', 12, NULL, 'With respect, sir, anyone with good eyes', 'Doctor Atomic: Act 1: With respect, sir, anyone with good eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b84fd478-bb63-4701-b134-dab3e966a786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Long let me inhale, deeply', part.name_en = 'Doctor Atomic: Act 1: Long let me inhale, deeply',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bab54ee6-e3bf-4623-a981-b89b572a0fec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bab54ee6-e3bf-4623-a981-b89b572a0fec', 13, NULL, 'Long let me inhale, deeply', 'Doctor Atomic: Act 1: Long let me inhale, deeply', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bab54ee6-e3bf-4623-a981-b89b572a0fec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The nation''s fate', part.name_en = 'Doctor Atomic: Act 1: The nation''s fate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c181862b-01be-44d7-89ec-cba755e7695c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c181862b-01be-44d7-89ec-cba755e7695c', 14, NULL, 'The nation''s fate', 'Doctor Atomic: Act 1: The nation''s fate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c181862b-01be-44d7-89ec-cba755e7695c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Get them out of here. From now on I''m making my own weather predictions', part.name_en = 'Doctor Atomic: Act 1: Get them out of here. From now on I''m making my own weather predictions',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c366e56d-a903-4f39-b9aa-103980fab0a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c366e56d-a903-4f39-b9aa-103980fab0a7', 15, NULL, 'Get them out of here. From now on I''m making my own weather predictions', 'Doctor Atomic: Act 1: Get them out of here. From now on I''m making my own weather predictions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c366e56d-a903-4f39-b9aa-103980fab0a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The end of June 1945', part.name_en = 'Doctor Atomic: Act 1: The end of June 1945',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cbafdf3b-42ca-496c-b05e-a6099357cff9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbafdf3b-42ca-496c-b05e-a6099357cff9', 16, NULL, 'The end of June 1945', 'Doctor Atomic: Act 1: The end of June 1945', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbafdf3b-42ca-496c-b05e-a6099357cff9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'I''ll sign the report, sir', part.name_en = 'Doctor Atomic: Act 1: I''ll sign the report, sir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cddb3e12-24eb-4689-ab0c-b489c4feb4fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cddb3e12-24eb-4689-ab0c-b489c4feb4fb', 17, NULL, 'I''ll sign the report, sir', 'Doctor Atomic: Act 1: I''ll sign the report, sir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cddb3e12-24eb-4689-ab0c-b489c4feb4fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Batter my heart', part.name_en = 'Doctor Atomic: Act 1: Batter my heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cf1c3b15-e0ee-46cf-95b5-0cedeb06fa8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf1c3b15-e0ee-46cf-95b5-0cedeb06fa8b', 18, NULL, 'Batter my heart', 'Doctor Atomic: Act 1: Batter my heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf1c3b15-e0ee-46cf-95b5-0cedeb06fa8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'No. Before the bomb is used', part.name_en = 'Doctor Atomic: Act 1: No. Before the bomb is used',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e274a14c-edc9-48d7-afee-2632e0d06802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e274a14c-edc9-48d7-afee-2632e0d06802', 19, NULL, 'No. Before the bomb is used', 'Doctor Atomic: Act 1: No. Before the bomb is used', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e274a14c-edc9-48d7-afee-2632e0d06802'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'General, you are bearing up with remarkable fortitude', part.name_en = 'Doctor Atomic: Act 1: General, you are bearing up with remarkable fortitude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e396af64-9196-4585-aa15-e5b027ff0a62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e396af64-9196-4585-aa15-e5b027ff0a62', 20, NULL, 'General, you are bearing up with remarkable fortitude', 'Doctor Atomic: Act 1: General, you are bearing up with remarkable fortitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e396af64-9196-4585-aa15-e5b027ff0a62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'What if it''s a dud?', part.name_en = 'Doctor Atomic: Act 1: What if it''s a dud?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f5a5cf8d-fac8-4b70-bee3-17a5a76ed526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5a5cf8d-fac8-4b70-bee3-17a5a76ed526', 21, NULL, 'What if it''s a dud?', 'Doctor Atomic: Act 1: What if it''s a dud?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5a5cf8d-fac8-4b70-bee3-17a5a76ed526'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'We are bedeviled by faulty detonators', part.name_en = 'Doctor Atomic: Act 1: We are bedeviled by faulty detonators',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:fcf1211b-ce2f-4fb0-a42e-706ea240312b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcf1211b-ce2f-4fb0-a42e-706ea240312b', 22, NULL, 'We are bedeviled by faulty detonators', 'Doctor Atomic: Act 1: We are bedeviled by faulty detonators', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0bcb5162-4b63-4b05-b132-4cdab8d46fdf'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf1211b-ce2f-4fb0-a42e-706ea240312b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act 2', part.name_en = 'Doctor Atomic: Act 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79', 3, NULL, 'Act 2', 'Doctor Atomic: Act 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zero minus two minutes', part.name_en = 'Doctor Atomic: Act 2: Zero minus two minutes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:08af28bd-53da-400d-b082-d820794f4844' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08af28bd-53da-400d-b082-d820794f4844', 1, NULL, 'Zero minus two minutes', 'Doctor Atomic: Act 2: Zero minus two minutes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08af28bd-53da-400d-b082-d820794f4844'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'In the midnight, in the flame-brilliant midnight', part.name_en = 'Doctor Atomic: Act 2: In the midnight, in the flame-brilliant midnight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:12c98551-043d-46cd-a19a-a863b70aae59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12c98551-043d-46cd-a19a-a863b70aae59', 2, NULL, 'In the midnight, in the flame-brilliant midnight', 'Doctor Atomic: Act 2: In the midnight, in the flame-brilliant midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12c98551-043d-46cd-a19a-a863b70aae59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Edward, the test will be delayed an hour', part.name_en = 'Doctor Atomic: Act 2: Edward, the test will be delayed an hour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:148e9894-adda-4917-8c42-c3f9d3d4f468' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:148e9894-adda-4917-8c42-c3f9d3d4f468', 3, NULL, 'Edward, the test will be delayed an hour', 'Doctor Atomic: Act 2: Edward, the test will be delayed an hour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:148e9894-adda-4917-8c42-c3f9d3d4f468'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A delay in issuing the Potsdam ultimatum', part.name_en = 'Doctor Atomic: Act 2: A delay in issuing the Potsdam ultimatum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:222b7249-505b-429a-b040-06befe4bfcbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:222b7249-505b-429a-b040-06befe4bfcbc', 4, NULL, 'A delay in issuing the Potsdam ultimatum', 'Doctor Atomic: Act 2: A delay in issuing the Potsdam ultimatum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:222b7249-505b-429a-b040-06befe4bfcbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'To what benevolent demon do I owe the joy of being thus surrounded', part.name_en = 'Doctor Atomic: Act 2: To what benevolent demon do I owe the joy of being thus surrounded',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:27fbab98-62ba-48bc-9dc6-fc1c533e5847' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27fbab98-62ba-48bc-9dc6-fc1c533e5847', 5, NULL, 'To what benevolent demon do I owe the joy of being thus surrounded', 'Doctor Atomic: Act 2: To what benevolent demon do I owe the joy of being thus surrounded', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27fbab98-62ba-48bc-9dc6-fc1c533e5847'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Easter Eve 1945', part.name_en = 'Doctor Atomic: Act 2: Easter Eve 1945',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2cce53e2-bbd7-45ff-b9df-1298eb6c7d63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cce53e2-bbd7-45ff-b9df-1298eb6c7d63', 6, NULL, 'Easter Eve 1945', 'Doctor Atomic: Act 2: Easter Eve 1945', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cce53e2-bbd7-45ff-b9df-1298eb6c7d63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Chorus: At the sight of this', part.name_en = 'Doctor Atomic: Act 2: Chorus: At the sight of this',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4c969cf5-14aa-4b0e-87aa-1639004d394c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c969cf5-14aa-4b0e-87aa-1639004d394c', 7, NULL, 'Chorus: At the sight of this', 'Doctor Atomic: Act 2: Chorus: At the sight of this', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c969cf5-14aa-4b0e-87aa-1639004d394c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'I just finished reading The Magic Mountain', part.name_en = 'Doctor Atomic: Act 2: I just finished reading The Magic Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:583e6d05-e27b-4ef5-965b-be69fbe32a15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:583e6d05-e27b-4ef5-965b-be69fbe32a15', 8, NULL, 'I just finished reading The Magic Mountain', 'Doctor Atomic: Act 2: I just finished reading The Magic Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:583e6d05-e27b-4ef5-965b-be69fbe32a15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Interlude: Rain over the Sangre de Cristo', part.name_en = 'Doctor Atomic: Act 2: Interlude: Rain over the Sangre de Cristo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5983272d-4b43-4ed6-b916-fcc3c23b4cf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5983272d-4b43-4ed6-b916-fcc3c23b4cf7', 9, NULL, 'Interlude: Rain over the Sangre de Cristo', 'Doctor Atomic: Act 2: Interlude: Rain over the Sangre de Cristo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5983272d-4b43-4ed6-b916-fcc3c23b4cf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'It''s midnight, Jack', part.name_en = 'Doctor Atomic: Act 2: It''s midnight, Jack',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:655829d0-d132-4c08-8f05-f991707f6956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:655829d0-d132-4c08-8f05-f991707f6956', 10, NULL, 'It''s midnight, Jack', 'Doctor Atomic: Act 2: It''s midnight, Jack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655829d0-d132-4c08-8f05-f991707f6956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Panic', part.name_en = 'Doctor Atomic: Act 2: Panic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:690ee850-5e8b-4881-afde-0d88fad456d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:690ee850-5e8b-4881-afde-0d88fad456d5', 11, NULL, 'Panic', 'Doctor Atomic: Act 2: Panic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:690ee850-5e8b-4881-afde-0d88fad456d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'In the north the cloud-flower blossoms', part.name_en = 'Doctor Atomic: Act 2: In the north the cloud-flower blossoms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6ab17892-ae79-4967-a131-5ed1a31a105a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ab17892-ae79-4967-a131-5ed1a31a105a', 12, NULL, 'In the north the cloud-flower blossoms', 'Doctor Atomic: Act 2: In the north the cloud-flower blossoms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ab17892-ae79-4967-a131-5ed1a31a105a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'I''ve spent a great deal of time indulging in controlled fantasies', part.name_en = 'Doctor Atomic: Act 2: I''ve spent a great deal of time indulging in controlled fantasies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:714a1b78-b170-473e-b6b3-24b1ff9a3bc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:714a1b78-b170-473e-b6b3-24b1ff9a3bc7', 13, NULL, 'I''ve spent a great deal of time indulging in controlled fantasies', 'Doctor Atomic: Act 2: I''ve spent a great deal of time indulging in controlled fantasies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:714a1b78-b170-473e-b6b3-24b1ff9a3bc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'I''ve dreamed the same dream', part.name_en = 'Doctor Atomic: Act 2: I''ve dreamed the same dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:74cca38f-bf74-4f8b-985d-36d291f0dca4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74cca38f-bf74-4f8b-985d-36d291f0dca4', 14, NULL, 'I''ve dreamed the same dream', 'Doctor Atomic: Act 2: I''ve dreamed the same dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74cca38f-bf74-4f8b-985d-36d291f0dca4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'To the farthest west, the sea and the striped country', part.name_en = 'Doctor Atomic: Act 2: To the farthest west, the sea and the striped country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:77abc4b4-e424-41f3-862b-1726eeb8e407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77abc4b4-e424-41f3-862b-1726eeb8e407', 15, NULL, 'To the farthest west, the sea and the striped country', 'Doctor Atomic: Act 2: To the farthest west, the sea and the striped country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77abc4b4-e424-41f3-862b-1726eeb8e407'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Fermi is taking wagers', part.name_en = 'Doctor Atomic: Act 2: Fermi is taking wagers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:842964ee-20e1-42fb-95e8-1c969037572c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:842964ee-20e1-42fb-95e8-1c969037572c', 16, NULL, 'Fermi is taking wagers', 'Doctor Atomic: Act 2: Fermi is taking wagers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:842964ee-20e1-42fb-95e8-1c969037572c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'That''s their signal', part.name_en = 'Doctor Atomic: Act 2: That''s their signal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8e297cd9-4505-4925-9e49-95055d3dea4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e297cd9-4505-4925-9e49-95055d3dea4a', 17, NULL, 'That''s their signal', 'Doctor Atomic: Act 2: That''s their signal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e297cd9-4505-4925-9e49-95055d3dea4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Program has been plagued from the start', part.name_en = 'Doctor Atomic: Act 2: The Program has been plagued from the start',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a01244ed-52f2-4dba-a404-57c00d758e80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a01244ed-52f2-4dba-a404-57c00d758e80', 18, NULL, 'The Program has been plagued from the start', 'Doctor Atomic: Act 2: The Program has been plagued from the start', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a01244ed-52f2-4dba-a404-57c00d758e80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The sky is clear to the east', part.name_en = 'Doctor Atomic: Act 2: The sky is clear to the east',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b12e418f-9cbc-4898-b111-b69416babfcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b12e418f-9cbc-4898-b111-b69416babfcc', 19, NULL, 'The sky is clear to the east', 'Doctor Atomic: Act 2: The sky is clear to the east', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b12e418f-9cbc-4898-b111-b69416babfcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Countdown', part.name_en = 'Doctor Atomic: Act 2: Countdown',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bbf78317-64ef-40c3-8f4a-9fa5607664d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbf78317-64ef-40c3-8f4a-9fa5607664d2', 20, NULL, 'Countdown', 'Doctor Atomic: Act 2: Countdown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf78317-64ef-40c3-8f4a-9fa5607664d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The only saviors are the ham sandwiches', part.name_en = 'Doctor Atomic: Act 2: The only saviors are the ham sandwiches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bcd3333a-aaf6-415d-8565-d1b8add4cb7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcd3333a-aaf6-415d-8565-d1b8add4cb7e', 21, NULL, 'The only saviors are the ham sandwiches', 'Doctor Atomic: Act 2: The only saviors are the ham sandwiches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcd3333a-aaf6-415d-8565-d1b8add4cb7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'To keep the weakness secret', part.name_en = 'Doctor Atomic: Act 2: To keep the weakness secret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d1cd13fd-5f8d-4481-9bdb-fbae683d05df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1cd13fd-5f8d-4481-9bdb-fbae683d05df', 22, NULL, 'To keep the weakness secret', 'Doctor Atomic: Act 2: To keep the weakness secret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1cd13fd-5f8d-4481-9bdb-fbae683d05df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'The winter dawned, but the dead did not come back', part.name_en = 'Doctor Atomic: Act 2: The winter dawned, but the dead did not come back',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:dfab63e6-f61a-4567-88c1-78b20c15ff59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dfab63e6-f61a-4567-88c1-78b20c15ff59', 23, NULL, 'The winter dawned, but the dead did not come back', 'Doctor Atomic: Act 2: The winter dawned, but the dead did not come back', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfab63e6-f61a-4567-88c1-78b20c15ff59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'And love which contains all human spirit', part.name_en = 'Doctor Atomic: Act 2: And love which contains all human spirit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f3ab76b2-9d8b-427e-81c4-8bbb547b2042' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3ab76b2-9d8b-427e-81c4-8bbb547b2042', 24, NULL, 'And love which contains all human spirit', 'Doctor Atomic: Act 2: And love which contains all human spirit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ab76b2-9d8b-427e-81c4-8bbb547b2042'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Lieutenant Bush. Keep a weather eye on Oppenheimer', part.name_en = 'Doctor Atomic: Act 2: Lieutenant Bush. Keep a weather eye on Oppenheimer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25732 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:fef13408-7f1a-4f4d-a9b1-40e105beecc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fef13408-7f1a-4f4d-a9b1-40e105beecc2', 25, NULL, 'Lieutenant Bush. Keep a weather eye on Oppenheimer', 'Doctor Atomic: Act 2: Lieutenant Bush. Keep a weather eye on Oppenheimer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d2710f50-3bda-431c-ade4-b399c6469c79'
WHERE p.id = 25732 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fef13408-7f1a-4f4d-a9b1-40e105beecc2'
);


-- None Doctor Atomic Symphony

UPDATE pieces piece
SET piece.title = 'Doctor Atomic Symphony', piece.title_en = 'Doctor Atomic Symphony',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23778 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Laboratory', part.name_en = 'Doctor Atomic Symphony: I. The Laboratory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23778 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ffd22166-6bf5-40b8-a978-d9c03baf28d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd22166-6bf5-40b8-a978-d9c03baf28d6', 1, 'I', 'The Laboratory', 'Doctor Atomic Symphony: I. The Laboratory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23778 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd22166-6bf5-40b8-a978-d9c03baf28d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Panic. Agitato - Same tempo - New tempo -', part.name_en = 'Doctor Atomic Symphony: II. Panic. Agitato - Same tempo - New tempo -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23778 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a163e1c8-7d13-4aa5-b9f3-ea742f2a464b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a163e1c8-7d13-4aa5-b9f3-ea742f2a464b', 2, 'II', 'Panic. Agitato - Same tempo - New tempo -', 'Doctor Atomic Symphony: II. Panic. Agitato - Same tempo - New tempo -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23778 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a163e1c8-7d13-4aa5-b9f3-ea742f2a464b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Trinity. Animato - Solennemente - Animato -', part.name_en = 'Doctor Atomic Symphony: III. Trinity. Animato - Solennemente - Animato -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23778 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:dc2509d5-f90c-446a-868c-0db6d7ad9dc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc2509d5-f90c-446a-868c-0db6d7ad9dc1', 3, 'III', 'Trinity. Animato - Solennemente - Animato -', 'Doctor Atomic Symphony: III. Trinity. Animato - Solennemente - Animato -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23778 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc2509d5-f90c-446a-868c-0db6d7ad9dc1'
);


-- None El Dorado

UPDATE pieces piece
SET piece.title = 'El Dorado', piece.title_en = 'El Dorado',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25607 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I: A Dream of Gold', part.name_en = 'El Dorado, Part I: A Dream of Gold',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25607 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2271a4fd-198e-4016-8e6d-b4a50880a777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2271a4fd-198e-4016-8e6d-b4a50880a777', 1, NULL, 'Part I: A Dream of Gold', 'El Dorado, Part I: A Dream of Gold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25607 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2271a4fd-198e-4016-8e6d-b4a50880a777'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part II: Soledades', part.name_en = 'El Dorado, Part II: Soledades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25607 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:86b5f9d3-c00c-489b-ac8e-5f73580e3b7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86b5f9d3-c00c-489b-ac8e-5f73580e3b7d', 2, NULL, 'Part II: Soledades', 'El Dorado, Part II: Soledades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25607 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86b5f9d3-c00c-489b-ac8e-5f73580e3b7d'
);


-- None El Niño

UPDATE pieces piece
SET piece.title = 'El Niño', piece.title_en = 'El Niño',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24533 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part One. Magnificat', part.name_en = 'El Niño: Part One. Magnificat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24533 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:36ad999c-fc74-498e-9157-48dc2bdf8bb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36ad999c-fc74-498e-9157-48dc2bdf8bb7', 1, NULL, 'Part One. Magnificat', 'El Niño: Part One. Magnificat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24533 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36ad999c-fc74-498e-9157-48dc2bdf8bb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part One. The Babe Leaped in Her Womb', part.name_en = 'El Niño: Part One. The Babe Leaped in Her Womb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24533 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:578dcacf-eacd-46c4-a07a-090b72a29eab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:578dcacf-eacd-46c4-a07a-090b72a29eab', 2, NULL, 'Part One. The Babe Leaped in Her Womb', 'El Niño: Part One. The Babe Leaped in Her Womb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24533 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:578dcacf-eacd-46c4-a07a-090b72a29eab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Memorial de Tlatelolco, from El Niño', part.name_en = 'Memorial de Tlatelolco, from El Niño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24533 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5d2ab951-a965-4cf8-81be-480d32893469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d2ab951-a965-4cf8-81be-480d32893469', 3, NULL, 'Memorial de Tlatelolco, from El Niño', 'Memorial de Tlatelolco, from El Niño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24533 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d2ab951-a965-4cf8-81be-480d32893469'
);


-- None Eros Piano

UPDATE pieces piece
SET piece.title = 'Eros Piano', piece.title_en = 'Eros Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25926 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fearful Symmetries

UPDATE pieces piece
SET piece.title = 'Fearful Symmetries', piece.title_en = 'Fearful Symmetries',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25699 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fellow Traveller

UPDATE pieces piece
SET piece.title = 'Fellow Traveller', piece.title_en = 'Fellow Traveller',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24118 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Girls of the Golden West>

UPDATE pieces piece
SET piece.title = '오페라 <Girls of the Golden West>', piece.title_en = 'Girls of the Golden West',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24958 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Girls of the Golden West: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab', 1, NULL, 'Act I', 'Girls of the Golden West: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Now he consoles himself', part.name_en = 'Girls of the Golden West, Act I Scene 2: Now he consoles himself',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:031ff34c-0c63-491f-b0db-2916e2c72ba8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:031ff34c-0c63-491f-b0db-2916e2c72ba8', 1, NULL, 'Now he consoles himself', 'Girls of the Golden West, Act I Scene 2: Now he consoles himself', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031ff34c-0c63-491f-b0db-2916e2c72ba8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Josefa, you remember', part.name_en = 'Girls of the Golden West, Act I Scene 3: Josefa, you remember',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:24ad7be6-e22c-46b7-b039-1c2dac142873' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24ad7be6-e22c-46b7-b039-1c2dac142873', 2, NULL, 'Josefa, you remember', 'Girls of the Golden West, Act I Scene 3: Josefa, you remember', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24ad7be6-e22c-46b7-b039-1c2dac142873'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Comin’ up from Red Dog', part.name_en = 'Girls of the Golden West, Act I Scene 4: Comin’ up from Red Dog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:464a3f95-d1b8-4cf4-8184-66060af6f0af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:464a3f95-d1b8-4cf4-8184-66060af6f0af', 3, NULL, 'Comin’ up from Red Dog', 'Girls of the Golden West, Act I Scene 4: Comin’ up from Red Dog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:464a3f95-d1b8-4cf4-8184-66060af6f0af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'My name is Joe', part.name_en = 'Girls of the Golden West, Act I Scene 2: My name is Joe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:62640bea-f294-4b27-a9bc-45acc5a7a538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62640bea-f294-4b27-a9bc-45acc5a7a538', 4, NULL, 'My name is Joe', 'Girls of the Golden West, Act I Scene 2: My name is Joe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62640bea-f294-4b27-a9bc-45acc5a7a538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'It was a driving, vigorous, restless population', part.name_en = 'Girls of the Golden West, Act I Scene 1: It was a driving, vigorous, restless population',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6da34dc0-7e8f-4ef7-b097-52d98868569c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6da34dc0-7e8f-4ef7-b097-52d98868569c', 5, NULL, 'It was a driving, vigorous, restless population', 'Girls of the Golden West, Act I Scene 1: It was a driving, vigorous, restless population', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6da34dc0-7e8f-4ef7-b097-52d98868569c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Wagon Ride - Ned Peters was a hustler', part.name_en = 'Girls of the Golden West, Act I Scene 1: Wagon Ride - Ned Peters was a hustler',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:78de0951-9d5a-47d1-bdf3-f0326ba4f673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78de0951-9d5a-47d1-bdf3-f0326ba4f673', 6, NULL, 'Wagon Ride - Ned Peters was a hustler', 'Girls of the Golden West, Act I Scene 1: Wagon Ride - Ned Peters was a hustler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78de0951-9d5a-47d1-bdf3-f0326ba4f673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'It’s bone, it’s backbone', part.name_en = 'Girls of the Golden West, Act I Scene 4: It’s bone, it’s backbone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7dd1d516-231e-4589-94e5-6647c928f593' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dd1d516-231e-4589-94e5-6647c928f593', 7, NULL, 'It’s bone, it’s backbone', 'Girls of the Golden West, Act I Scene 4: It’s bone, it’s backbone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd1d516-231e-4589-94e5-6647c928f593'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A gambler’s life I do admire', part.name_en = 'Girls of the Golden West, Act I Scene 3: A gambler’s life I do admire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cebf672a-7684-46e6-bce6-939d31932368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cebf672a-7684-46e6-bce6-939d31932368', 8, NULL, 'A gambler’s life I do admire', 'Girls of the Golden West, Act I Scene 3: A gambler’s life I do admire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cff7d224-1ad6-4389-8782-f7b2ebd921ab'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cebf672a-7684-46e6-bce6-939d31932368'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Girls of the Golden West: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7', 2, NULL, 'Act II', 'Girls of the Golden West: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tú me quieres alba', part.name_en = 'Girls of the Golden West, Act II Scene 5: Tú me quieres alba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0d855ea5-1218-4e43-9a38-4ca800da83ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d855ea5-1218-4e43-9a38-4ca800da83ab', 1, NULL, 'Tú me quieres alba', 'Girls of the Golden West, Act II Scene 5: Tú me quieres alba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d855ea5-1218-4e43-9a38-4ca800da83ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sometimes I lounge forlornly to the window', part.name_en = 'Girls of the Golden West, Act II Epilogue: Sometimes I lounge forlornly to the window',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:10e229f6-03f0-4ea4-96e6-0c17cd252775' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10e229f6-03f0-4ea4-96e6-0c17cd252775', 2, NULL, 'Sometimes I lounge forlornly to the window', 'Girls of the Golden West, Act II Epilogue: Sometimes I lounge forlornly to the window', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10e229f6-03f0-4ea4-96e6-0c17cd252775'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Raven', part.name_en = 'Girls of the Golden West, Act II Scene 1: The Raven',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2b88b94a-c53d-4d6e-98a1-5ba20761c514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b88b94a-c53d-4d6e-98a1-5ba20761c514', 3, NULL, 'The Raven', 'Girls of the Golden West, Act II Scene 1: The Raven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b88b94a-c53d-4d6e-98a1-5ba20761c514'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'It’s four long years (Lousy Miner)', part.name_en = 'Girls of the Golden West, Act II Scene 5: It’s four long years (Lousy Miner)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4c3844e9-a4b3-4f69-980b-57dcd4c69916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c3844e9-a4b3-4f69-980b-57dcd4c69916', 4, NULL, 'It’s four long years (Lousy Miner)', 'Girls of the Golden West, Act II Scene 5: It’s four long years (Lousy Miner)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c3844e9-a4b3-4f69-980b-57dcd4c69916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The attack on the Mexicans', part.name_en = 'Girls of the Golden West, Act II Scene 2: The attack on the Mexicans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:72c727ec-e89e-4493-9d0c-cdf0ca5c0f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72c727ec-e89e-4493-9d0c-cdf0ca5c0f48', 5, NULL, 'The attack on the Mexicans', 'Girls of the Golden West, Act II Scene 2: The attack on the Mexicans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72c727ec-e89e-4493-9d0c-cdf0ca5c0f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'It seems like midnight', part.name_en = 'Girls of the Golden West, Act II Scene 3: It seems like midnight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:90bd6c3c-b07b-46c3-8a48-d1d0ca7b77ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90bd6c3c-b07b-46c3-8a48-d1d0ca7b77ec', 6, NULL, 'It seems like midnight', 'Girls of the Golden West, Act II Scene 3: It seems like midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90bd6c3c-b07b-46c3-8a48-d1d0ca7b77ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ven esta noche', part.name_en = 'Girls of the Golden West, Act II Scene 4: Ven esta noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9745d80f-315e-4ef3-9ea4-0adcd9373585' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9745d80f-315e-4ef3-9ea4-0adcd9373585', 7, NULL, 'Ven esta noche', 'Girls of the Golden West, Act II Scene 4: Ven esta noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9745d80f-315e-4ef3-9ea4-0adcd9373585'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'I’m going far away from my creditors', part.name_en = 'Girls of the Golden West, Act II Scene 4: I’m going far away from my creditors',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b88a20a0-c158-4a5f-a3fd-5fc1f83182cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b88a20a0-c158-4a5f-a3fd-5fc1f83182cc', 8, NULL, 'I’m going far away from my creditors', 'Girls of the Golden West, Act II Scene 4: I’m going far away from my creditors', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88a20a0-c158-4a5f-a3fd-5fc1f83182cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Downieville mob', part.name_en = 'Girls of the Golden West, Act II Scene 5: The Downieville mob',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c18c962c-6f38-424e-be74-4f6333bb5e7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c18c962c-6f38-424e-be74-4f6333bb5e7b', 9, NULL, 'The Downieville mob', 'Girls of the Golden West, Act II Scene 5: The Downieville mob', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18c962c-6f38-424e-be74-4f6333bb5e7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Blessed and praised', part.name_en = 'Girls of the Golden West, Act II Scene 4: Blessed and praised',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c78a9ea6-6054-477c-930e-ee061b5a6523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c78a9ea6-6054-477c-930e-ee061b5a6523', 10, NULL, 'Blessed and praised', 'Girls of the Golden West, Act II Scene 4: Blessed and praised', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78a9ea6-6054-477c-930e-ee061b5a6523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'This very nearly was the cause', part.name_en = 'Girls of the Golden West, Act II Scene 4: This very nearly was the cause',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:dc0b274e-6291-40b7-abbe-d4d2a970f78f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc0b274e-6291-40b7-abbe-d4d2a970f78f', 11, NULL, 'This very nearly was the cause', 'Girls of the Golden West, Act II Scene 4: This very nearly was the cause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc0b274e-6291-40b7-abbe-d4d2a970f78f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'What is this celebration to me?', part.name_en = 'Girls of the Golden West, Act II Scene 3: What is this celebration to me?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24958 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e87fa3dd-076f-4eb3-b896-767ff0d6ade7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e87fa3dd-076f-4eb3-b896-767ff0d6ade7', 12, NULL, 'What is this celebration to me?', 'Girls of the Golden West, Act II Scene 3: What is this celebration to me?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e7a62089-3ab9-4788-959c-65e9a583f1e7'
WHERE p.id = 24958 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e87fa3dd-076f-4eb3-b896-767ff0d6ade7'
);


-- None Gnarly Buttons

UPDATE pieces piece
SET piece.title = 'Gnarly Buttons', piece.title_en = 'Gnarly Buttons',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24953 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Perilous Shore', part.name_en = 'Gnarly Buttons: I. The Perilous Shore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24953 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:12ffb8fe-b6f0-35b5-a15a-20f90f5a934d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ffb8fe-b6f0-35b5-a15a-20f90f5a934d', 1, 'I', 'The Perilous Shore', 'Gnarly Buttons: I. The Perilous Shore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24953 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ffb8fe-b6f0-35b5-a15a-20f90f5a934d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hoe-down (Mad Cow)', part.name_en = 'Gnarly Buttons: II. Hoe-down (Mad Cow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24953 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b3d76e1f-f61e-325d-a322-af61342f0975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3d76e1f-f61e-325d-a322-af61342f0975', 2, 'II', 'Hoe-down (Mad Cow)', 'Gnarly Buttons: II. Hoe-down (Mad Cow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24953 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3d76e1f-f61e-325d-a322-af61342f0975'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Put Your Loving Arms Around Me', part.name_en = 'Gnarly Buttons: III. Put Your Loving Arms Around Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24953 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2672e1fc-a23d-3d6a-abfa-a73efd8848cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2672e1fc-a23d-3d6a-abfa-a73efd8848cd', 3, 'III', 'Put Your Loving Arms Around Me', 'Gnarly Buttons: III. Put Your Loving Arms Around Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24953 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2672e1fc-a23d-3d6a-abfa-a73efd8848cd'
);


-- None Grand Pianola Music

UPDATE pieces piece
SET piece.title = 'Grand Pianola Music', piece.title_en = 'Grand Pianola Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23121 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '/ II', part.name_en = 'Grand Pianola Music: I. / II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23121 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9c76624d-254a-35d0-9b46-efc623440493' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c76624d-254a-35d0-9b46-efc623440493', 1, 'I', '/ II', 'Grand Pianola Music: I. / II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23121 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c76624d-254a-35d0-9b46-efc623440493'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = '“On the Dominant Divide”', part.name_en = 'Grand Pianola Music: III. “On the Dominant Divide”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23121 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6d02f3ad-0704-3c47-a629-cae0852ed183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d02f3ad-0704-3c47-a629-cae0852ed183', 2, 'III', '“On the Dominant Divide”', 'Grand Pianola Music: III. “On the Dominant Divide”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23121 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d02f3ad-0704-3c47-a629-cae0852ed183'
);


-- None Guide to Strange Places

UPDATE pieces piece
SET piece.title = 'Guide to Strange Places', piece.title_en = 'Guide to Strange Places',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24663 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hallelujah Junction

UPDATE pieces piece
SET piece.title = 'Hallelujah Junction', piece.title_en = 'Hallelujah Junction',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23123 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Hallelujah Junction: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23123 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:855224d8-d08c-4b49-9702-ffa0b3ffb2f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:855224d8-d08c-4b49-9702-ffa0b3ffb2f8', 1, NULL, 'I', 'Hallelujah Junction: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23123 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:855224d8-d08c-4b49-9702-ffa0b3ffb2f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Hallelujah Junction: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23123 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b2bf7716-cce3-4dcd-8d0b-6d8e65c8d8fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2bf7716-cce3-4dcd-8d0b-6d8e65c8d8fa', 2, NULL, 'II', 'Hallelujah Junction: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23123 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2bf7716-cce3-4dcd-8d0b-6d8e65c8d8fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Hallelujah Junction: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23123 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7432f1e7-b43f-450e-89a5-46c125209ff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7432f1e7-b43f-450e-89a5-46c125209ff1', 3, NULL, 'III', 'Hallelujah Junction: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23123 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7432f1e7-b43f-450e-89a5-46c125209ff1'
);


-- None Harmonielehre

UPDATE pieces piece
SET piece.title = 'Harmonielehre', piece.title_en = 'Harmonielehre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23287 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I', part.name_en = 'Harmonielehre: Part I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23287 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b069f498-c24e-3369-8fbd-c07dd9a9c52b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b069f498-c24e-3369-8fbd-c07dd9a9c52b', 1, NULL, 'Part I', 'Harmonielehre: Part I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23287 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b069f498-c24e-3369-8fbd-c07dd9a9c52b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part II. The Anfortas Wound', part.name_en = 'Harmonielehre: Part II. The Anfortas Wound',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23287 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:51e33134-5b67-3b6f-a397-680c7f114dec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51e33134-5b67-3b6f-a397-680c7f114dec', 2, NULL, 'Part II. The Anfortas Wound', 'Harmonielehre: Part II. The Anfortas Wound', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23287 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51e33134-5b67-3b6f-a397-680c7f114dec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part III. Meister Eckhardt and Quackie', part.name_en = 'Harmonielehre: Part III. Meister Eckhardt and Quackie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23287 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2d59115e-64d5-359b-84ba-bf1b62c25c19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d59115e-64d5-359b-84ba-bf1b62c25c19', 3, NULL, 'Part III. Meister Eckhardt and Quackie', 'Harmonielehre: Part III. Meister Eckhardt and Quackie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23287 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d59115e-64d5-359b-84ba-bf1b62c25c19'
);


-- None Harmonium

UPDATE pieces piece
SET piece.title = 'Harmonium', piece.title_en = 'Harmonium',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24875 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Negative Love', part.name_en = 'Harmonium: I. Negative Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24875 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ba939a96-01f0-41cc-962f-fd4358281769' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba939a96-01f0-41cc-962f-fd4358281769', 1, 'I', 'Negative Love', 'Harmonium: I. Negative Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24875 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba939a96-01f0-41cc-962f-fd4358281769'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Wild Nights', part.name_en = 'Harmonium: III. Wild Nights',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24875 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e00c38e0-e80d-4fd2-bc4c-cbaff3175e45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e00c38e0-e80d-4fd2-bc4c-cbaff3175e45', 2, 'III', 'Wild Nights', 'Harmonium: III. Wild Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24875 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e00c38e0-e80d-4fd2-bc4c-cbaff3175e45'
);


-- None Hoodoo Zephyr

UPDATE pieces piece
SET piece.title = 'Hoodoo Zephyr', piece.title_en = 'Hoodoo Zephyr',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23385 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Still Play

UPDATE pieces piece
SET piece.title = 'I Still Play', piece.title_en = 'I Still Play',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23417 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <I Was Looking at the Ceiling and Then I Saw the Sky>

UPDATE pieces piece
SET piece.title = '오페라 <I Was Looking at the Ceiling and Then I Saw the Sky>', piece.title_en = 'I Was Looking at the Ceiling and Then I Saw the Sky',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24537 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873', 1, NULL, 'Act I', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act 1. No. 1 Ensemble “I was looking at the ceiling and then I saw the sky"', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act 1. No. 1 Ensemble “I was looking at the ceiling and then I saw the sky"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:888a1fa0-e9e0-4ba0-9409-5ece12b843fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:888a1fa0-e9e0-4ba0-9409-5ece12b843fd', 1, NULL, 'Act 1. No. 1 Ensemble “I was looking at the ceiling and then I saw the sky"', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act 1. No. 1 Ensemble “I was looking at the ceiling and then I saw the sky"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:888a1fa0-e9e0-4ba0-9409-5ece12b843fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 2 A Sermon on Romance', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 2 A Sermon on Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:57cd4064-2e3b-4987-96a7-d58ec7303e73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57cd4064-2e3b-4987-96a7-d58ec7303e73', 2, NULL, 'Act I. No. 2 A Sermon on Romance', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 2 A Sermon on Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57cd4064-2e3b-4987-96a7-d58ec7303e73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 3 Leila’s Song of the Wise Young Women', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 3 Leila’s Song of the Wise Young Women',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:833af4f9-3c65-4a48-99bd-5223382ef04e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:833af4f9-3c65-4a48-99bd-5223382ef04e', 3, NULL, 'Act I. No. 3 Leila’s Song of the Wise Young Women', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 3 Leila’s Song of the Wise Young Women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833af4f9-3c65-4a48-99bd-5223382ef04e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 4 Solo in Sunlight', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 4 Solo in Sunlight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3577bd62-a72b-4cd1-8005-3e5cd1716ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3577bd62-a72b-4cd1-8005-3e5cd1716ea8', 4, NULL, 'Act I. No. 4 Solo in Sunlight', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 4 Solo in Sunlight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3577bd62-a72b-4cd1-8005-3e5cd1716ea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 5 ¿Donde Estàs?', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 5 ¿Donde Estàs?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:60caab9e-01de-43a6-a934-c30c638e816d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60caab9e-01de-43a6-a934-c30c638e816d', 5, NULL, 'Act I. No. 5 ¿Donde Estàs?', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 5 ¿Donde Estàs?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60caab9e-01de-43a6-a934-c30c638e816d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 5 Mike’s Song About Arresting a Particular Individual', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 5 Mike’s Song About Arresting a Particular Individual',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f8a64c01-85a8-4c26-bcb1-a2baf1660a05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8a64c01-85a8-4c26-bcb1-a2baf1660a05', 6, NULL, 'Act I. No. 5 Mike’s Song About Arresting a Particular Individual', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 5 Mike’s Song About Arresting a Particular Individual', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a64c01-85a8-4c26-bcb1-a2baf1660a05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 7 Tiffany’s Solo', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 7 Tiffany’s Solo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1efae469-5a2b-49a0-b999-212a8d8ead58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1efae469-5a2b-49a0-b999-212a8d8ead58', 7, NULL, 'Act I. No. 7 Tiffany’s Solo', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 7 Tiffany’s Solo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1efae469-5a2b-49a0-b999-212a8d8ead58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 8 Song About the on Site Altercation', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 8 Song About the on Site Altercation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8dd9431f-ab37-4c78-832a-482a53fa92fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8dd9431f-ab37-4c78-832a-482a53fa92fe', 8, NULL, 'Act I. No. 8 Song About the on Site Altercation', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 8 Song About the on Site Altercation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd9431f-ab37-4c78-832a-482a53fa92fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 9 Song About the Bad Boys and the News', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 9 Song About the Bad Boys and the News',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:218170c7-3ee1-4b3c-8f90-6cc043ad133b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:218170c7-3ee1-4b3c-8f90-6cc043ad133b', 9, NULL, 'Act I. No. 9 Song About the Bad Boys and the News', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 9 Song About the Bad Boys and the News', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:218170c7-3ee1-4b3c-8f90-6cc043ad133b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 10 Your Honor My Client, He’s a Young Black Man', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 10 Your Honor My Client, He’s a Young Black Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b72d838c-210b-4f8c-af2d-b17f92375d38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b72d838c-210b-4f8c-af2d-b17f92375d38', 10, NULL, 'Act I. No. 10 Your Honor My Client, He’s a Young Black Man', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 10 Your Honor My Client, He’s a Young Black Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b72d838c-210b-4f8c-af2d-b17f92375d38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 11 Consuelo’s Dream', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 11 Consuelo’s Dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e96e2631-100e-44f5-8eac-f96a5d1acff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e96e2631-100e-44f5-8eac-f96a5d1acff5', 11, NULL, 'Act I. No. 11 Consuelo’s Dream', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 11 Consuelo’s Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e96e2631-100e-44f5-8eac-f96a5d1acff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 12 Rick’s Cross‐Examination of Tiffany and Mike', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 12 Rick’s Cross‐Examination of Tiffany and Mike',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3c14a968-8d69-49d2-86a2-36323934ae49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c14a968-8d69-49d2-86a2-36323934ae49', 12, NULL, 'Act I. No. 12 Rick’s Cross‐Examination of Tiffany and Mike', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 12 Rick’s Cross‐Examination of Tiffany and Mike', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c14a968-8d69-49d2-86a2-36323934ae49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 13 Song About Law School as the Natural Follow‐Up to Jail', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 13 Song About Law School as the Natural Follow‐Up to Jail',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7ee9a10e-0c09-4ab7-89fe-8457b83e19f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ee9a10e-0c09-4ab7-89fe-8457b83e19f2', 13, NULL, 'Act I. No. 13 Song About Law School as the Natural Follow‐Up to Jail', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 13 Song About Law School as the Natural Follow‐Up to Jail', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ee9a10e-0c09-4ab7-89fe-8457b83e19f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 14 Leila’s Solo: Alone (Again or at Last)', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 14 Leila’s Solo: Alone (Again or at Last)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5886e2fd-ff8c-4132-8799-92cef210b3fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5886e2fd-ff8c-4132-8799-92cef210b3fa', 14, NULL, 'Act I. No. 14 Leila’s Solo: Alone (Again or at Last)', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 14 Leila’s Solo: Alone (Again or at Last)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5886e2fd-ff8c-4132-8799-92cef210b3fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I. No. 15 Song About the Sweet Majority Population of the World', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 15 Song About the Sweet Majority Population of the World',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ac8c9060-9b5d-4836-9b11-d8a1f56dbd7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac8c9060-9b5d-4836-9b11-d8a1f56dbd7f', 15, NULL, 'Act I. No. 15 Song About the Sweet Majority Population of the World', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act I. No. 15 Song About the Sweet Majority Population of the World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e84aed6d-71c5-4eb1-b571-ac372ab0a873'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac8c9060-9b5d-4836-9b11-d8a1f56dbd7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e', 2, NULL, 'Act II', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duet: Three Weeks and Still I''m Outta My Mind', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Duet: Three Weeks and Still I''m Outta My Mind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:43593044-e654-4b88-a2f8-de30e7899f5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43593044-e654-4b88-a2f8-de30e7899f5b', 1, NULL, 'Duet: Three Weeks and Still I''m Outta My Mind', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Duet: Three Weeks and Still I''m Outta My Mind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43593044-e654-4b88-a2f8-de30e7899f5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Earthquake Sounds', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Earthquake Sounds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e91af28d-f937-4693-9569-86ef7095d2a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e91af28d-f937-4693-9569-86ef7095d2a3', 2, NULL, 'Earthquake Sounds', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Earthquake Sounds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e91af28d-f937-4693-9569-86ef7095d2a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Earthquake Music', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Earthquake Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bf51565c-66e3-4aa8-9f5f-bd8413461ed5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf51565c-66e3-4aa8-9f5f-bd8413461ed5', 3, NULL, 'Earthquake Music', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Earthquake Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf51565c-66e3-4aa8-9f5f-bd8413461ed5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Crushed by the Rock I Been Standing On', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Crushed by the Rock I Been Standing On',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1ccc8409-d70f-4ea0-ae66-2a622a1b279b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ccc8409-d70f-4ea0-ae66-2a622a1b279b', 4, NULL, 'Crushed by the Rock I Been Standing On', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Crushed by the Rock I Been Standing On', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ccc8409-d70f-4ea0-ae66-2a622a1b279b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Duet in the Middle of Terrible Duress', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Duet in the Middle of Terrible Duress',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f22f7991-323d-4f39-ab66-4a5ecbd64753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f22f7991-323d-4f39-ab66-4a5ecbd64753', 5, NULL, 'Duet in the Middle of Terrible Duress', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Duet in the Middle of Terrible Duress', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f22f7991-323d-4f39-ab66-4a5ecbd64753'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dewain''s Song of Liberation and Surprise', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Dewain''s Song of Liberation and Surprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9eb10f40-74d6-483b-8e82-e3cb04eed32d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9eb10f40-74d6-483b-8e82-e3cb04eed32d', 6, NULL, 'Dewain''s Song of Liberation and Surprise', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Dewain''s Song of Liberation and Surprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eb10f40-74d6-483b-8e82-e3cb04eed32d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Este país / This Country', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Este país / This Country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:042dd229-ecb5-4696-a21f-eacbb52d3c7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:042dd229-ecb5-4696-a21f-eacbb52d3c7c', 7, NULL, 'Este país / This Country', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Este país / This Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:042dd229-ecb5-4696-a21f-eacbb52d3c7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'One Last Look at the Angel in Your Eyes', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: One Last Look at the Angel in Your Eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7a3bce28-e8a8-40c6-8fb8-a318fdb47e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a3bce28-e8a8-40c6-8fb8-a318fdb47e05', 8, NULL, 'One Last Look at the Angel in Your Eyes', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: One Last Look at the Angel in Your Eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a3bce28-e8a8-40c6-8fb8-a318fdb47e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:44c4124a-975f-4fdd-b2a7-e827072cad28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44c4124a-975f-4fdd-b2a7-e827072cad28', 9, NULL, 'Finale', 'I Was Looking at the Ceiling and Then I Saw the Sky: Act II: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98dbfe7a-40d8-4eef-8ce5-f5cca8e0180e'
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44c4124a-975f-4fdd-b2a7-e827072cad28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Earthquake', part.name_en = 'I Was Looking at the Ceiling and Then I Saw the Sky: Earthquake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24537 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:22fbf63d-2760-40f7-bbf8-8600c82d8425' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22fbf63d-2760-40f7-bbf8-8600c82d8425', 3, NULL, 'Earthquake', 'I Was Looking at the Ceiling and Then I Saw the Sky: Earthquake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24537 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22fbf63d-2760-40f7-bbf8-8600c82d8425'
);


-- None John’s Book of Alleged Dances

UPDATE pieces piece
SET piece.title = 'John’s Book of Alleged Dances', piece.title_en = 'John’s Book of Alleged Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24346 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Stubble Crochet', part.name_en = 'John’s Book of Alleged Dances: Stubble Crochet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1d1dff8f-e560-48e1-b345-542284753c9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d1dff8f-e560-48e1-b345-542284753c9a', 1, NULL, 'Stubble Crochet', 'John’s Book of Alleged Dances: Stubble Crochet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d1dff8f-e560-48e1-b345-542284753c9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Judah to Ocean', part.name_en = 'John’s Book of Alleged Dances: Judah to Ocean',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:45b4a59f-fd0d-4f00-88ed-67703e3d1c9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45b4a59f-fd0d-4f00-88ed-67703e3d1c9e', 2, NULL, 'Judah to Ocean', 'John’s Book of Alleged Dances: Judah to Ocean', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b4a59f-fd0d-4f00-88ed-67703e3d1c9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Judah to Ocean (reprise)', part.name_en = 'John’s Book of Alleged Dances: Judah to Ocean (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4767a47e-13ca-4377-94b6-653ed1794a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4767a47e-13ca-4377-94b6-653ed1794a29', 3, NULL, 'Judah to Ocean (reprise)', 'John’s Book of Alleged Dances: Judah to Ocean (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4767a47e-13ca-4377-94b6-653ed1794a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Standchen: The Little Serenade', part.name_en = 'John’s Book of Alleged Dances: Standchen: The Little Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8c99fc83-c020-490a-8c9c-4733793ab638' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c99fc83-c020-490a-8c9c-4733793ab638', 4, NULL, 'Standchen: The Little Serenade', 'John’s Book of Alleged Dances: Standchen: The Little Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c99fc83-c020-490a-8c9c-4733793ab638'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Toot Nipple', part.name_en = 'John’s Book of Alleged Dances: Toot Nipple',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8f4539d9-f7a3-4f44-b34a-4bf0cbcfa471' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f4539d9-f7a3-4f44-b34a-4bf0cbcfa471', 5, NULL, 'Toot Nipple', 'John’s Book of Alleged Dances: Toot Nipple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4539d9-f7a3-4f44-b34a-4bf0cbcfa471'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rag the Bone', part.name_en = 'John’s Book of Alleged Dances: Rag the Bone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ab459cf2-ec06-4d1f-94d3-82978a41612d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab459cf2-ec06-4d1f-94d3-82978a41612d', 6, NULL, 'Rag the Bone', 'John’s Book of Alleged Dances: Rag the Bone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab459cf2-ec06-4d1f-94d3-82978a41612d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dogjam', part.name_en = 'John’s Book of Alleged Dances: Dogjam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b32aab9e-7abe-494d-ab0c-d59ab161fcc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b32aab9e-7abe-494d-ab0c-d59ab161fcc9', 7, NULL, 'Dogjam', 'John’s Book of Alleged Dances: Dogjam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b32aab9e-7abe-494d-ab0c-d59ab161fcc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Hammer & Chisel', part.name_en = 'John’s Book of Alleged Dances: Hammer & Chisel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b953d440-b471-48ea-bf59-6986d8c765bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b953d440-b471-48ea-bf59-6986d8c765bc', 8, NULL, 'Hammer & Chisel', 'John’s Book of Alleged Dances: Hammer & Chisel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b953d440-b471-48ea-bf59-6986d8c765bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pavane: She’s So Fine', part.name_en = 'John’s Book of Alleged Dances: Pavane: She’s So Fine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f200f63c-777d-4a4b-8d8c-11f905903f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f200f63c-777d-4a4b-8d8c-11f905903f6c', 9, NULL, 'Pavane: She’s So Fine', 'John’s Book of Alleged Dances: Pavane: She’s So Fine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f200f63c-777d-4a4b-8d8c-11f905903f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Alligator Escalator', part.name_en = 'John’s Book of Alleged Dances: Alligator Escalator',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f6411c43-4f07-4b04-b2d4-dc3571fdebbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6411c43-4f07-4b04-b2d4-dc3571fdebbd', 10, NULL, 'Alligator Escalator', 'John’s Book of Alleged Dances: Alligator Escalator', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6411c43-4f07-4b04-b2d4-dc3571fdebbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Habanera', part.name_en = 'John’s Book of Alleged Dances: Habanera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24346 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f8a30d9a-6a55-4233-91ab-a2dcdb141206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a30d9a-6a55-4233-91ab-a2dcdb141206', 11, NULL, 'Habanera', 'John’s Book of Alleged Dances: Habanera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24346 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a30d9a-6a55-4233-91ab-a2dcdb141206'
);


-- None Light Over Water: The Genesis of a Music

UPDATE pieces piece
SET piece.title = 'Light Over Water: The Genesis of a Music', piece.title_en = 'Light Over Water: The Genesis of a Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23433 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I', part.name_en = 'Light Over Water: Part I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23433 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d2e3235b-612d-4cf8-987b-5ecb28ad5de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e3235b-612d-4cf8-987b-5ecb28ad5de3', 1, NULL, 'Part I', 'Light Over Water: Part I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23433 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e3235b-612d-4cf8-987b-5ecb28ad5de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part II', part.name_en = 'Light Over Water: Part II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23433 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7c1be791-5bba-49af-ba72-8b9bfe9237f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1be791-5bba-49af-ba72-8b9bfe9237f0', 2, NULL, 'Part II', 'Light Over Water: Part II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23433 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1be791-5bba-49af-ba72-8b9bfe9237f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part III', part.name_en = 'Light Over Water: Part III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23433 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1459aef9-b99f-4cb1-ad1b-686e0792138c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1459aef9-b99f-4cb1-ad1b-686e0792138c', 3, NULL, 'Part III', 'Light Over Water: Part III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23433 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1459aef9-b99f-4cb1-ad1b-686e0792138c'
);


-- None Lola Montez Does the Spider Dance

UPDATE pieces piece
SET piece.title = 'Lola Montez Does the Spider Dance', piece.title_en = 'Lola Montez Does the Spider Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23276 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lollapalooza

UPDATE pieces piece
SET piece.title = 'Lollapalooza', piece.title_en = 'Lollapalooza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24712 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Must the Devil Have All the Good Tunes?

UPDATE pieces piece
SET piece.title = 'Must the Devil Have All the Good Tunes?', piece.title_en = 'Must the Devil Have All the Good Tunes?',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25091 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gritty, funky, but in Strict Tempo; Twitchy, Bot-like', part.name_en = 'Must the Devil Have All the Good Tunes?: I. Gritty, funky, but in Strict Tempo; Twitchy, Bot-like',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25091 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:94d9ac02-43d4-4786-b836-ca55cb8495d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94d9ac02-43d4-4786-b836-ca55cb8495d6', 1, 'I', 'Gritty, funky, but in Strict Tempo; Twitchy, Bot-like', 'Must the Devil Have All the Good Tunes?: I. Gritty, funky, but in Strict Tempo; Twitchy, Bot-like', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25091 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d9ac02-43d4-4786-b836-ca55cb8495d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Much Slower; Gently, Relaxed', part.name_en = 'Must the Devil Have All the Good Tunes?: II. Much Slower; Gently, Relaxed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25091 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:17563fe4-f727-4c57-b39b-1f02899dc458' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17563fe4-f727-4c57-b39b-1f02899dc458', 2, 'II', 'Much Slower; Gently, Relaxed', 'Must the Devil Have All the Good Tunes?: II. Much Slower; Gently, Relaxed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25091 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17563fe4-f727-4c57-b39b-1f02899dc458'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Più Mosso: Obsession / Swing', part.name_en = 'Must the Devil Have All the Good Tunes?: III. Più Mosso: Obsession / Swing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25091 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0ffe9b5c-89fd-4a8e-aaa4-305e8c88e50a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ffe9b5c-89fd-4a8e-aaa4-305e8c88e50a', 3, 'III', 'Più Mosso: Obsession / Swing', 'Must the Devil Have All the Good Tunes?: III. Più Mosso: Obsession / Swing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25091 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ffe9b5c-89fd-4a8e-aaa4-305e8c88e50a'
);


-- None My Father Knew Charles Ives

UPDATE pieces piece
SET piece.title = 'My Father Knew Charles Ives', piece.title_en = 'My Father Knew Charles Ives',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23702 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Concord', part.name_en = 'My Father Knew Charles Ives: I. Concord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23702 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2c43faec-5fc7-4bfc-8c61-40b5976ff9fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c43faec-5fc7-4bfc-8c61-40b5976ff9fc', 1, 'I', 'Concord', 'My Father Knew Charles Ives: I. Concord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23702 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c43faec-5fc7-4bfc-8c61-40b5976ff9fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Lake', part.name_en = 'My Father Knew Charles Ives: II. The Lake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23702 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bfea5f9d-ba05-47d0-abf4-ce3be64b3b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfea5f9d-ba05-47d0-abf4-ce3be64b3b85', 2, 'II', 'The Lake', 'My Father Knew Charles Ives: II. The Lake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23702 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfea5f9d-ba05-47d0-abf4-ce3be64b3b85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Mountain', part.name_en = 'My Father Knew Charles Ives: III. The Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23702 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:533e5ad5-722c-4a0b-9ef5-59b82e0d6806' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:533e5ad5-722c-4a0b-9ef5-59b82e0d6806', 3, 'III', 'The Mountain', 'My Father Knew Charles Ives: III. The Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23702 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:533e5ad5-722c-4a0b-9ef5-59b82e0d6806'
);


-- None Naive and Sentimental Music

UPDATE pieces piece
SET piece.title = 'Naive and Sentimental Music', piece.title_en = 'Naive and Sentimental Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25269 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Naive and Sentimental Music', part.name_en = 'Naive and Sentimental Music: I. Naive and Sentimental Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25269 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b5acd10b-89cd-4236-8daf-44a4dc5bd297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5acd10b-89cd-4236-8daf-44a4dc5bd297', 1, 'I', 'Naive and Sentimental Music', 'Naive and Sentimental Music: I. Naive and Sentimental Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25269 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5acd10b-89cd-4236-8daf-44a4dc5bd297'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mother of the Man', part.name_en = 'Naive and Sentimental Music: II. Mother of the Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25269 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:107ad11e-98bc-42fc-bfaa-690430c8035a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:107ad11e-98bc-42fc-bfaa-690430c8035a', 2, 'II', 'Mother of the Man', 'Naive and Sentimental Music: II. Mother of the Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25269 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:107ad11e-98bc-42fc-bfaa-690430c8035a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chain to the Rhythm', part.name_en = 'Naive and Sentimental Music: III. Chain to the Rhythm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25269 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4b81db96-c486-4170-a4fd-c1c6a78d0bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b81db96-c486-4170-a4fd-c1c6a78d0bdc', 3, 'III', 'Chain to the Rhythm', 'Naive and Sentimental Music: III. Chain to the Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25269 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b81db96-c486-4170-a4fd-c1c6a78d0bdc'
);


-- None 오페라 <Nixon in China>

UPDATE pieces piece
SET piece.title = '오페라 <Nixon in China>', piece.title_en = 'Nixon in China',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24602 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Nixon in China: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8', 1, NULL, 'Act I', 'Nixon in China: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene II. "The people are the heroes now" (Chorus)', part.name_en = 'Nixon in China: Act I, Scene II. "The people are the heroes now" (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2c23c021-2de9-4fb7-9038-466feebc1627' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c23c021-2de9-4fb7-9038-466feebc1627', 1, NULL, 'Scene II. "The people are the heroes now" (Chorus)', 'Nixon in China: Act I, Scene II. "The people are the heroes now" (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c23c021-2de9-4fb7-9038-466feebc1627'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene III: Beginning - The Night Is Young (Nixon, Pat, Chou, Kissinger, Chorus)', part.name_en = 'Nixon in China: Act I, Scene III: Beginning - The Night Is Young (Nixon, Pat, Chou, Kissinger, Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:31774949-ef5c-4ba7-9c1a-231f2f20cc9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31774949-ef5c-4ba7-9c1a-231f2f20cc9b', 2, NULL, 'Scene III: Beginning - The Night Is Young (Nixon, Pat, Chou, Kissinger, Chorus)', 'Nixon in China: Act I, Scene III: Beginning - The Night Is Young (Nixon, Pat, Chou, Kissinger, Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31774949-ef5c-4ba7-9c1a-231f2f20cc9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene II: You Know We''ll Meet With Your Confrere, the Democratic Candidate (Mao, Nixon, Kissinger)', part.name_en = 'Nixon in China: Act I, Scene II: You Know We''ll Meet With Your Confrere, the Democratic Candidate (Mao, Nixon, Kissinger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:345b994b-ee2e-4d02-8af2-5eea7a0c86e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:345b994b-ee2e-4d02-8af2-5eea7a0c86e8', 3, NULL, 'Scene II: You Know We''ll Meet With Your Confrere, the Democratic Candidate (Mao, Nixon, Kissinger)', 'Nixon in China: Act I, Scene II: You Know We''ll Meet With Your Confrere, the Democratic Candidate (Mao, Nixon, Kissinger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:345b994b-ee2e-4d02-8af2-5eea7a0c86e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene II: You''ve Said That There''s a Certain Well-Known Tree (Chou, Nixon, Mao, Kissinger, 3 Secretaries)', part.name_en = 'Nixon in China: Act I, Scene II: You''ve Said That There''s a Certain Well-Known Tree (Chou, Nixon, Mao, Kissinger, 3 Secretaries)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:59124acf-5b86-48e0-a685-61380fc5a8d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59124acf-5b86-48e0-a685-61380fc5a8d3', 4, NULL, 'Scene II: You''ve Said That There''s a Certain Well-Known Tree (Chou, Nixon, Mao, Kissinger, 3 Secretaries)', 'Nixon in China: Act I, Scene II: You''ve Said That There''s a Certain Well-Known Tree (Chou, Nixon, Mao, Kissinger, 3 Secretaries)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59124acf-5b86-48e0-a685-61380fc5a8d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene II: We No Longer Need Confucius (Mao, 3 Secretaries)', part.name_en = 'Nixon in China: Act I, Scene II: We No Longer Need Confucius (Mao, 3 Secretaries)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:59160f4e-ccc5-4b4d-a9ec-fae550b8af41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59160f4e-ccc5-4b4d-a9ec-fae550b8af41', 5, NULL, 'Scene II: We No Longer Need Confucius (Mao, 3 Secretaries)', 'Nixon in China: Act I, Scene II: We No Longer Need Confucius (Mao, 3 Secretaries)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59160f4e-ccc5-4b4d-a9ec-fae550b8af41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene II: Beginning - I Can''t Talk Very Well. My Throat… (Mao, Nixon, Chou, Kissinger, 3 Secretaries)', part.name_en = 'Nixon in China: Act I, Scene II: Beginning - I Can''t Talk Very Well. My Throat… (Mao, Nixon, Chou, Kissinger, 3 Secretaries)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7a8616e9-4a48-41e0-93ac-869330007d87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a8616e9-4a48-41e0-93ac-869330007d87', 6, NULL, 'Scene II: Beginning - I Can''t Talk Very Well. My Throat… (Mao, Nixon, Chou, Kissinger, 3 Secretaries)', 'Nixon in China: Act I, Scene II: Beginning - I Can''t Talk Very Well. My Throat… (Mao, Nixon, Chou, Kissinger, 3 Secretaries)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a8616e9-4a48-41e0-93ac-869330007d87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene II. "News has a kind of mystery:" (Nixon, Chou En-lai, Kissinger)', part.name_en = 'Nixon in China: Act I, Scene II. "News has a kind of mystery:" (Nixon, Chou En-lai, Kissinger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:88526bfe-fb0e-40b6-90b8-f7ee0bcf193c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88526bfe-fb0e-40b6-90b8-f7ee0bcf193c', 7, NULL, 'Scene II. "News has a kind of mystery:" (Nixon, Chou En-lai, Kissinger)', 'Nixon in China: Act I, Scene II. "News has a kind of mystery:" (Nixon, Chou En-lai, Kissinger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88526bfe-fb0e-40b6-90b8-f7ee0bcf193c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene I. Beginning', part.name_en = 'Nixon in China: Act I, Scene I. Beginning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8d88a6c4-c3d1-4be4-ad3a-5c12ae0bba5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d88a6c4-c3d1-4be4-ad3a-5c12ae0bba5c', 8, NULL, 'Scene I. Beginning', 'Nixon in China: Act I, Scene I. Beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d88a6c4-c3d1-4be4-ad3a-5c12ae0bba5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene III: Cheers! (Chorus, Nixon, Chou, Pat, Kissinger)', part.name_en = 'Nixon in China: Act I, Scene III: Cheers! (Chorus, Nixon, Chou, Pat, Kissinger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a0c1c7b2-2412-4105-b78b-bc79d90f4029' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0c1c7b2-2412-4105-b78b-bc79d90f4029', 9, NULL, 'Scene III: Cheers! (Chorus, Nixon, Chou, Pat, Kissinger)', 'Nixon in China: Act I, Scene III: Cheers! (Chorus, Nixon, Chou, Pat, Kissinger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0c1c7b2-2412-4105-b78b-bc79d90f4029'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Ladies and Gentlemen, Comrades and Friends," (Chou En-lai)', part.name_en = 'Nixon in China: Act I, Scene III. "Ladies and Gentlemen, Comrades and Friends," (Chou En-lai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a50471de-d83e-4220-b89a-ff5007e513d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a50471de-d83e-4220-b89a-ff5007e513d0', 10, NULL, 'Scene III. "Ladies and Gentlemen, Comrades and Friends," (Chou En-lai)', 'Nixon in China: Act I, Scene III. "Ladies and Gentlemen, Comrades and Friends," (Chou En-lai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a50471de-d83e-4220-b89a-ff5007e513d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Mr. Premier, distinguished guests," (Nixon)', part.name_en = 'Nixon in China: Act I, Scene III. "Mr. Premier, distinguished guests," (Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bc0a09a6-1ed4-49c6-8f18-672299bc6a3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc0a09a6-1ed4-49c6-8f18-672299bc6a3f', 11, NULL, 'Scene III. "Mr. Premier, distinguished guests," (Nixon)', 'Nixon in China: Act I, Scene III. "Mr. Premier, distinguished guests," (Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc0a09a6-1ed4-49c6-8f18-672299bc6a3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene II. Landing of the Spirit of ''76', part.name_en = 'Nixon in China: Act I, Scene II. Landing of the Spirit of ''76',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c7e2053f-c5b8-4331-af6c-fc143498d194' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7e2053f-c5b8-4331-af6c-fc143498d194', 12, NULL, 'Scene II. Landing of the Spirit of ''76', 'Nixon in China: Act I, Scene II. Landing of the Spirit of ''76', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e2053f-c5b8-4331-af6c-fc143498d194'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene II: Founders Come First, Then Profiteers (Mao, 3 Secretaries, Nixon, Chou, Kissinger)', part.name_en = 'Nixon in China: Act I, Scene II: Founders Come First, Then Profiteers (Mao, 3 Secretaries, Nixon, Chou, Kissinger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:cdfdff16-421b-412d-897a-48cb58844c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cdfdff16-421b-412d-897a-48cb58844c76', 13, NULL, 'Scene II: Founders Come First, Then Profiteers (Mao, 3 Secretaries, Nixon, Chou, Kissinger)', 'Nixon in China: Act I, Scene II: Founders Come First, Then Profiteers (Mao, 3 Secretaries, Nixon, Chou, Kissinger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdfdff16-421b-412d-897a-48cb58844c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Soldiers of heaven hold the sky" (Chorus)', part.name_en = 'Nixon in China: Act I, Scene I. "Soldiers of heaven hold the sky" (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e2dac77f-89e1-42d9-8ace-2e35ff9af731' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2dac77f-89e1-42d9-8ace-2e35ff9af731', 14, NULL, 'Scene I. "Soldiers of heaven hold the sky" (Chorus)', 'Nixon in China: Act I, Scene I. "Soldiers of heaven hold the sky" (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2dac77f-89e1-42d9-8ace-2e35ff9af731'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scene II: Like the Ming Tombs (Nixon, 3 Secretaries, Mao, Chou)', part.name_en = 'Nixon in China: Act I, Scene II: Like the Ming Tombs (Nixon, 3 Secretaries, Mao, Chou)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:efe817c3-ea01-4e6b-82f7-b411c75e2b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efe817c3-ea01-4e6b-82f7-b411c75e2b4e', 15, NULL, 'Scene II: Like the Ming Tombs (Nixon, 3 Secretaries, Mao, Chou)', 'Nixon in China: Act I, Scene II: Like the Ming Tombs (Nixon, 3 Secretaries, Mao, Chou)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efe817c3-ea01-4e6b-82f7-b411c75e2b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Your flight was smooth, I hope?" (Chou En-lai, Nixon)', part.name_en = 'Nixon in China: Act I, Scene II. "Your flight was smooth, I hope?" (Chou En-lai, Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f5c4f9c6-b160-4acb-8748-fe89eec73922' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5c4f9c6-b160-4acb-8748-fe89eec73922', 16, NULL, 'Scene II. "Your flight was smooth, I hope?" (Chou En-lai, Nixon)', 'Nixon in China: Act I, Scene II. "Your flight was smooth, I hope?" (Chou En-lai, Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0caff24f-8961-4608-b94b-93bf47315ea8'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c4f9c6-b160-4acb-8748-fe89eec73922'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Nixon in China: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e', 2, NULL, 'Act II', 'Nixon in China: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene II: Tropical Storm: There There, There There (Pat)', part.name_en = 'Nixon in China: Act II, Scene II: Tropical Storm: There There, There There (Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2ac86c68-a99a-458c-926e-76ac5fec2dc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ac86c68-a99a-458c-926e-76ac5fec2dc3', 1, NULL, 'Scene II: Tropical Storm: There There, There There (Pat)', 'Nixon in China: Act II, Scene II: Tropical Storm: There There, There There (Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac86c68-a99a-458c-926e-76ac5fec2dc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II. Opening (Chorus)', part.name_en = 'Nixon in China: Act II, Scene II. Opening (Chorus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:31ad8004-d391-4819-9bb3-2b99c6bf83e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31ad8004-d391-4819-9bb3-2b99c6bf83e6', 2, NULL, 'Scene II. Opening (Chorus)', 'Nixon in China: Act II, Scene II. Opening (Chorus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31ad8004-d391-4819-9bb3-2b99c6bf83e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Beginning - I Don''t Daydream and Don''t Look Back (Pat)', part.name_en = 'Nixon in China: Act II, Scene 1: Beginning - I Don''t Daydream and Don''t Look Back (Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:34f1d221-fce0-44a1-988a-a757c36c6fa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34f1d221-fce0-44a1-988a-a757c36c6fa9', 3, NULL, 'Scene 1: Beginning - I Don''t Daydream and Don''t Look Back (Pat)', 'Nixon in China: Act II, Scene 1: Beginning - I Don''t Daydream and Don''t Look Back (Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34f1d221-fce0-44a1-988a-a757c36c6fa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene II: I Have My Brief (Kissinger as Lao Szu, Nixon)', part.name_en = 'Nixon in China: Act II, Scene II: I Have My Brief (Kissinger as Lao Szu, Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6af26b8f-35cd-4c6c-8ace-34780c3f7e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6af26b8f-35cd-4c6c-8ace-34780c3f7e38', 4, NULL, 'Scene II: I Have My Brief (Kissinger as Lao Szu, Nixon)', 'Nixon in China: Act II, Scene II: I Have My Brief (Kissinger as Lao Szu, Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6af26b8f-35cd-4c6c-8ace-34780c3f7e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene II. "I am the wife of Mao Tse-tung" (Chiang Ch''ing)', part.name_en = 'Nixon in China: Act II, Scene II. "I am the wife of Mao Tse-tung" (Chiang Ch''ing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7b9eeaa6-0e26-4e6f-b970-4e1244e3f283' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b9eeaa6-0e26-4e6f-b970-4e1244e3f283', 5, NULL, 'Scene II. "I am the wife of Mao Tse-tung" (Chiang Ch''ing)', 'Nixon in China: Act II, Scene II. "I am the wife of Mao Tse-tung" (Chiang Ch''ing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b9eeaa6-0e26-4e6f-b970-4e1244e3f283'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Whip her to death!" (Kissinger (as Lao Szu), Pat Nixon, Nixon)', part.name_en = 'Nixon in China: Act II, Scene II. "Whip her to death!" (Kissinger (as Lao Szu), Pat Nixon, Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:7c8e1877-8153-493d-b9f7-1bb4e1c25253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c8e1877-8153-493d-b9f7-1bb4e1c25253', 6, NULL, 'Scene II. "Whip her to death!" (Kissinger (as Lao Szu), Pat Nixon, Nixon)', 'Nixon in China: Act II, Scene II. "Whip her to death!" (Kissinger (as Lao Szu), Pat Nixon, Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8e1877-8153-493d-b9f7-1bb4e1c25253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Oh what a day / I thought I''d die!" (Kissinger (as Lao Szu), Chorus (as Wu Ching-hua))', part.name_en = 'Nixon in China: Act II, Scene II. "Oh what a day / I thought I''d die!" (Kissinger (as Lao Szu), Chorus (as Wu Ching-hua))',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8912a83c-9190-47bc-93b0-51a2381efd91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8912a83c-9190-47bc-93b0-51a2381efd91', 7, NULL, 'Scene II. "Oh what a day / I thought I''d die!" (Kissinger (as Lao Szu), Chorus (as Wu Ching-hua))', 'Nixon in China: Act II, Scene II. "Oh what a day / I thought I''d die!" (Kissinger (as Lao Szu), Chorus (as Wu Ching-hua))', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8912a83c-9190-47bc-93b0-51a2381efd91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 1: At Last the Weather''s Warming Up (Pat)', part.name_en = 'Nixon in China: Act II, Scene 1: At Last the Weather''s Warming Up (Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a9311925-cbc4-47b5-9276-f5e326b970ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9311925-cbc4-47b5-9276-f5e326b970ed', 8, NULL, 'Scene 1: At Last the Weather''s Warming Up (Pat)', 'Nixon in China: Act II, Scene 1: At Last the Weather''s Warming Up (Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9311925-cbc4-47b5-9276-f5e326b970ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene II: It Seems So Strange (Chorus as Ching-hua, Chiang Ch''ing, Pat, Nixon, 3 Secretaries)', part.name_en = 'Nixon in China: Act II, Scene II: It Seems So Strange (Chorus as Ching-hua, Chiang Ch''ing, Pat, Nixon, 3 Secretaries)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ad3ab49f-4f22-4805-9926-be2982e10711' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad3ab49f-4f22-4805-9926-be2982e10711', 9, NULL, 'Scene II: It Seems So Strange (Chorus as Ching-hua, Chiang Ch''ing, Pat, Nixon, 3 Secretaries)', 'Nixon in China: Act II, Scene II: It Seems So Strange (Chorus as Ching-hua, Chiang Ch''ing, Pat, Nixon, 3 Secretaries)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3ab49f-4f22-4805-9926-be2982e10711'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II Scene 1: Look Down at the Earth (Chorus, Pat)', part.name_en = 'Nixon in China: Act II Scene 1: Look Down at the Earth (Chorus, Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e12fb465-a4c5-4ba9-8e93-488688c330ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e12fb465-a4c5-4ba9-8e93-488688c330ab', 10, NULL, 'Act II Scene 1: Look Down at the Earth (Chorus, Pat)', 'Nixon in China: Act II Scene 1: Look Down at the Earth (Chorus, Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e12fb465-a4c5-4ba9-8e93-488688c330ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene II: Flesh Rebels (Chorus as Militia)', part.name_en = 'Nixon in China: Act II, Scene II: Flesh Rebels (Chorus as Militia)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e5d069c3-9403-494c-95a4-bc0150cb66eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5d069c3-9403-494c-95a4-bc0150cb66eb', 11, NULL, 'Scene II: Flesh Rebels (Chorus as Militia)', 'Nixon in China: Act II, Scene II: Flesh Rebels (Chorus as Militia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5d069c3-9403-494c-95a4-bc0150cb66eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene I. "This is prophetic!" (Pat Nixon)', part.name_en = 'Nixon in China: Act II, Scene I. "This is prophetic!" (Pat Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e6a5227b-b674-482c-87b5-4117711af6a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6a5227b-b674-482c-87b5-4117711af6a8', 12, NULL, 'Scene I. "This is prophetic!" (Pat Nixon)', 'Nixon in China: Act II, Scene I. "This is prophetic!" (Pat Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:79c2091b-624c-4a80-996e-d3be8078979e'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6a5227b-b674-482c-87b5-4117711af6a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Nixon in China: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf', 3, NULL, 'Act III', 'Nixon in China: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. "Peking Watches the Stars," (Chiang Ch''ing, Mao)', part.name_en = 'Nixon in China: Act III. "Peking Watches the Stars," (Chiang Ch''ing, Mao)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0412d558-9e33-471a-b2b4-b108fbdc1590' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0412d558-9e33-471a-b2b4-b108fbdc1590', 1, NULL, 'Act III. "Peking Watches the Stars," (Chiang Ch''ing, Mao)', 'Nixon in China: Act III. "Peking Watches the Stars," (Chiang Ch''ing, Mao)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0412d558-9e33-471a-b2b4-b108fbdc1590'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. "After that - / The sweat / Had soaked my uniform" (Nixon, Pat Nixon, Mao, Chou En-lai)', part.name_en = 'Nixon in China: Act III. "After that - / The sweat / Had soaked my uniform" (Nixon, Pat Nixon, Mao, Chou En-lai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1140b753-121a-407c-99ad-e4d7e6b21e04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1140b753-121a-407c-99ad-e4d7e6b21e04', 2, NULL, 'Act III. "After that - / The sweat / Had soaked my uniform" (Nixon, Pat Nixon, Mao, Chou En-lai)', 'Nixon in China: Act III. "After that - / The sweat / Had soaked my uniform" (Nixon, Pat Nixon, Mao, Chou En-lai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1140b753-121a-407c-99ad-e4d7e6b21e04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. "You Won at Poker." (Pat Nixon, Nixon)', part.name_en = 'Nixon in China: Act III. "You Won at Poker." (Pat Nixon, Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:215cc9a3-6c89-4abd-ba1e-5193bbb15f8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:215cc9a3-6c89-4abd-ba1e-5193bbb15f8b', 3, NULL, 'Act III. "You Won at Poker." (Pat Nixon, Nixon)', 'Nixon in China: Act III. "You Won at Poker." (Pat Nixon, Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:215cc9a3-6c89-4abd-ba1e-5193bbb15f8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sitting Around the Radio (Nixon, Pat)', part.name_en = 'Nixon in China: Act III: Sitting Around the Radio (Nixon, Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3e4505ad-f673-4143-8ae7-1ab2306ac01a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e4505ad-f673-4143-8ae7-1ab2306ac01a', 4, NULL, 'Sitting Around the Radio (Nixon, Pat)', 'Nixon in China: Act III: Sitting Around the Radio (Nixon, Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e4505ad-f673-4143-8ae7-1ab2306ac01a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. "I am Old and I Cannot Sleep" (Chou En-lai)', part.name_en = 'Nixon in China: Act III. "I am Old and I Cannot Sleep" (Chou En-lai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:48c13fa5-6593-461a-810d-b3ef6283061c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48c13fa5-6593-461a-810d-b3ef6283061c', 5, NULL, 'Act III. "I am Old and I Cannot Sleep" (Chou En-lai)', 'Nixon in China: Act III. "I am Old and I Cannot Sleep" (Chou En-lai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c13fa5-6593-461a-810d-b3ef6283061c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Maos Dance (Chiang Ch''ing, Mao, Pat, Nixon, Chou)', part.name_en = 'Nixon in China: Act III: The Maos Dance (Chiang Ch''ing, Mao, Pat, Nixon, Chou)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:532761a2-4aaa-4dab-a080-82720b282e49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:532761a2-4aaa-4dab-a080-82720b282e49', 6, NULL, 'The Maos Dance (Chiang Ch''ing, Mao, Pat, Nixon, Chou)', 'Nixon in China: Act III: The Maos Dance (Chiang Ch''ing, Mao, Pat, Nixon, Chou)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:532761a2-4aaa-4dab-a080-82720b282e49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III. "I have no offspring." (Chou En-lai, Mao, Chiang Ch''ing)', part.name_en = 'Nixon in China: Act III. "I have no offspring." (Chou En-lai, Mao, Chiang Ch''ing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:55f74b5b-a0c6-4829-a6cb-9de93b8b1572' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55f74b5b-a0c6-4829-a6cb-9de93b8b1572', 7, NULL, 'Act III. "I have no offspring." (Chou En-lai, Mao, Chiang Ch''ing)', 'Nixon in China: Act III. "I have no offspring." (Chou En-lai, Mao, Chiang Ch''ing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f74b5b-a0c6-4829-a6cb-9de93b8b1572'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Beginning', part.name_en = 'Nixon in China: Act III: Beginning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:61de8261-c5c6-4af7-bfc2-e0b026e27093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61de8261-c5c6-4af7-bfc2-e0b026e27093', 8, NULL, 'Beginning', 'Nixon in China: Act III: Beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61de8261-c5c6-4af7-bfc2-e0b026e27093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Some Men You Cannot Satisfy (Kissinger, Nixon, Pat, Chou, Chiang Ch''ing)', part.name_en = 'Nixon in China: Act III: Some Men You Cannot Satisfy (Kissinger, Nixon, Pat, Chou, Chiang Ch''ing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6ab15c1a-d156-45d7-826e-590615044b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ab15c1a-d156-45d7-826e-590615044b0e', 9, NULL, 'Some Men You Cannot Satisfy (Kissinger, Nixon, Pat, Chou, Chiang Ch''ing)', 'Nixon in China: Act III: Some Men You Cannot Satisfy (Kissinger, Nixon, Pat, Chou, Chiang Ch''ing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ab15c1a-d156-45d7-826e-590615044b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III. "I Can Keep Still," (Chiang Ch''ing)', part.name_en = 'Nixon in China: Act III. "I Can Keep Still," (Chiang Ch''ing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8fabdfe3-a0df-4691-adf6-05d9c9e102d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8fabdfe3-a0df-4691-adf6-05d9c9e102d2', 10, NULL, 'Act III. "I Can Keep Still," (Chiang Ch''ing)', 'Nixon in China: Act III. "I Can Keep Still," (Chiang Ch''ing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fabdfe3-a0df-4691-adf6-05d9c9e102d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'When I Woke Up I Dimly Realized the Jap Bombers Had Given Us a Miss (Nixon, Pat)', part.name_en = 'Nixon in China: Act III: When I Woke Up I Dimly Realized the Jap Bombers Had Given Us a Miss (Nixon, Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:af204bf0-cd54-4e4f-9afc-8dd5342506cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af204bf0-cd54-4e4f-9afc-8dd5342506cf', 11, NULL, 'When I Woke Up I Dimly Realized the Jap Bombers Had Given Us a Miss (Nixon, Pat)', 'Nixon in China: Act III: When I Woke Up I Dimly Realized the Jap Bombers Had Given Us a Miss (Nixon, Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af204bf0-cd54-4e4f-9afc-8dd5342506cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'I Am No One (Mao, Chou, Kissinger, Chiang Ch''ing, Pat)', part.name_en = 'Nixon in China: Act III: I Am No One (Mao, Chou, Kissinger, Chiang Ch''ing, Pat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bef289eb-7433-43eb-a9af-f24e670f128b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bef289eb-7433-43eb-a9af-f24e670f128b', 12, NULL, 'I Am No One (Mao, Chou, Kissinger, Chiang Ch''ing, Pat)', 'Nixon in China: Act III: I Am No One (Mao, Chou, Kissinger, Chiang Ch''ing, Pat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bef289eb-7433-43eb-a9af-f24e670f128b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act III. "Let Us Examine What You Did." (Mao, Chiang Ch''ing, Chou En-lai)', part.name_en = 'Nixon in China: Act III. "Let Us Examine What You Did." (Mao, Chiang Ch''ing, Chou En-lai)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d1aaf2a5-63d8-4f34-9b10-fbe05dbd0286' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1aaf2a5-63d8-4f34-9b10-fbe05dbd0286', 13, NULL, 'Act III. "Let Us Examine What You Did." (Mao, Chiang Ch''ing, Chou En-lai)', 'Nixon in China: Act III. "Let Us Examine What You Did." (Mao, Chiang Ch''ing, Chou En-lai)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1aaf2a5-63d8-4f34-9b10-fbe05dbd0286'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act III. "When I Woke Up" (Nixon, Pat Nixon)', part.name_en = 'Nixon in China: Act III. "When I Woke Up" (Nixon, Pat Nixon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24602 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e9910a54-357e-4a64-8fb8-df58509b3ed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9910a54-357e-4a64-8fb8-df58509b3ed0', 14, NULL, 'Act III. "When I Woke Up" (Nixon, Pat Nixon)', 'Nixon in China: Act III. "When I Woke Up" (Nixon, Pat Nixon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d9a6c9d4-8cb0-4216-900c-3eb3745ccfdf'
WHERE p.id = 24602 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9910a54-357e-4a64-8fb8-df58509b3ed0'
);


-- None On the Transmigration of Souls

UPDATE pieces piece
SET piece.title = 'On the Transmigration of Souls', piece.title_en = 'On the Transmigration of Souls',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23069 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phrygian Gates and China Gates

UPDATE pieces piece
SET piece.title = 'Phrygian Gates and China Gates', piece.title_en = 'Phrygian Gates and China Gates',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23761 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Phrygian Gates', part.name_en = 'Phrygian Gates',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23761 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:91d237bb-c773-4f1e-a61e-9a8bf9c796c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91d237bb-c773-4f1e-a61e-9a8bf9c796c8', 1, NULL, 'Phrygian Gates', 'Phrygian Gates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23761 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d237bb-c773-4f1e-a61e-9a8bf9c796c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'China Gates', part.name_en = 'China Gates',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23761 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:97f69646-c2c1-4e9a-8238-a96f5e741c3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97f69646-c2c1-4e9a-8238-a96f5e741c3b', 2, NULL, 'China Gates', 'China Gates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23761 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f69646-c2c1-4e9a-8238-a96f5e741c3b'
);


-- None Road Movies

UPDATE pieces piece
SET piece.title = 'Road Movies', piece.title_en = 'Road Movies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24271 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Relaxed Groove', part.name_en = 'Road Movies: I. Relaxed Groove',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24271 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:eedef16a-3be2-4f49-88c2-bc2ab757bd86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eedef16a-3be2-4f49-88c2-bc2ab757bd86', 1, 'I', 'Relaxed Groove', 'Road Movies: I. Relaxed Groove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24271 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eedef16a-3be2-4f49-88c2-bc2ab757bd86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Meditative', part.name_en = 'Road Movies: II. Meditative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24271 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4872b87b-cd53-40e3-813d-4d11c255d885' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4872b87b-cd53-40e3-813d-4d11c255d885', 2, 'II', 'Meditative', 'Road Movies: II. Meditative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24271 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4872b87b-cd53-40e3-813d-4d11c255d885'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '40% Swing', part.name_en = 'Road Movies: III. 40% Swing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24271 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:af3c49a0-b7a8-4cba-a855-1cfe440e3eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af3c49a0-b7a8-4cba-a855-1cfe440e3eaa', 3, 'III', '40% Swing', 'Road Movies: III. 40% Swing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24271 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af3c49a0-b7a8-4cba-a855-1cfe440e3eaa'
);


-- None Saxophone Concerto

UPDATE pieces piece
SET piece.title = 'Saxophone Concerto', piece.title_en = 'Saxophone Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25419 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animato; tranquillo, suave', part.name_en = 'Saxophone Concerto: I. Animato; tranquillo, suave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25419 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2aa66c05-f84a-4781-96a9-fa3e7813007e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aa66c05-f84a-4781-96a9-fa3e7813007e', 1, 'I', 'Animato; tranquillo, suave', 'Saxophone Concerto: I. Animato; tranquillo, suave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25419 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aa66c05-f84a-4781-96a9-fa3e7813007e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto vivo (a hard driving pulse)', part.name_en = 'Saxophone Concerto: II. Molto vivo (a hard driving pulse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25419 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e1a19414-a270-4b63-bb15-ee6568800917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1a19414-a270-4b63-bb15-ee6568800917', 2, 'II', 'Molto vivo (a hard driving pulse)', 'Saxophone Concerto: II. Molto vivo (a hard driving pulse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25419 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a19414-a270-4b63-bb15-ee6568800917'
);


-- None Scheherazade.2

UPDATE pieces piece
SET piece.title = 'Scheherazade.2', piece.title_en = 'Scheherazade.2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24708 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tale of the Wise Young Woman; Pursuit by the True Believers', part.name_en = 'Scheherazade.2: I. Tale of the Wise Young Woman; Pursuit by the True Believers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24708 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:f4135bd1-1748-49f9-acfe-fb14316549dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4135bd1-1748-49f9-acfe-fb14316549dc', 1, 'I', 'Tale of the Wise Young Woman; Pursuit by the True Believers', 'Scheherazade.2: I. Tale of the Wise Young Woman; Pursuit by the True Believers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24708 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4135bd1-1748-49f9-acfe-fb14316549dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A Long Desire (Love Scene)', part.name_en = 'Scheherazade.2: II. A Long Desire (Love Scene)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24708 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:0344f5e1-5080-48a3-b45e-39e414514779' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0344f5e1-5080-48a3-b45e-39e414514779', 2, 'II', 'A Long Desire (Love Scene)', 'Scheherazade.2: II. A Long Desire (Love Scene)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24708 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0344f5e1-5080-48a3-b45e-39e414514779'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scheherazade and the Men with Beards', part.name_en = 'Scheherazade.2: III. Scheherazade and the Men with Beards',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24708 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:fe1aeee2-a3b2-4def-acfd-6ffb946411e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe1aeee2-a3b2-4def-acfd-6ffb946411e4', 3, 'III', 'Scheherazade and the Men with Beards', 'Scheherazade.2: III. Scheherazade and the Men with Beards', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24708 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe1aeee2-a3b2-4def-acfd-6ffb946411e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Escape, Flight, Sanctuary', part.name_en = 'Scheherazade.2: IV. Escape, Flight, Sanctuary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24708 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c795b8d9-a9c6-493c-992a-2493818471b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c795b8d9-a9c6-493c-992a-2493818471b4', 4, 'IV', 'Escape, Flight, Sanctuary', 'Scheherazade.2: IV. Escape, Flight, Sanctuary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24708 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c795b8d9-a9c6-493c-992a-2493818471b4'
);


-- None Scratchband

UPDATE pieces piece
SET piece.title = 'Scratchband', piece.title_en = 'Scratchband',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23285 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Short Ride in a Fast Machine

UPDATE pieces piece
SET piece.title = 'Short Ride in a Fast Machine', piece.title_en = 'Short Ride in a Fast Machine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26023 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Slonimsky's Earbox

UPDATE pieces piece
SET piece.title = 'Slonimsky''s Earbox', piece.title_en = 'Slonimsky''s Earbox',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23970 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Son of Chamber Symphony

UPDATE pieces piece
SET piece.title = 'Son of Chamber Symphony', piece.title_en = 'Son of Chamber Symphony',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25236 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Son of Chamber Symphony: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25236 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3da96055-f9d7-4844-9739-9905b8260b18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3da96055-f9d7-4844-9739-9905b8260b18', 1, NULL, 'I', 'Son of Chamber Symphony: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25236 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3da96055-f9d7-4844-9739-9905b8260b18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Son of Chamber Symphony: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25236 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:240130ba-cba7-4814-b0f3-18e68fe17d34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240130ba-cba7-4814-b0f3-18e68fe17d34', 2, NULL, 'II', 'Son of Chamber Symphony: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25236 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240130ba-cba7-4814-b0f3-18e68fe17d34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Son of Chamber Symphony: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25236 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:c4b74932-6035-4b67-ba9d-8cd5a1be976c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4b74932-6035-4b67-ba9d-8cd5a1be976c', 3, NULL, 'III', 'Son of Chamber Symphony: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25236 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4b74932-6035-4b67-ba9d-8cd5a1be976c'
);


-- None The Death of Klinghoffer

UPDATE pieces piece
SET piece.title = 'The Death of Klinghoffer', piece.title_en = 'The Death of Klinghoffer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24577 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chorus of Exiled Palestinians', part.name_en = 'The Death of Klinghoffer: Chorus of Exiled Palestinians',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24577 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:1a5cea68-4224-41af-a23d-28e6acb89fae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a5cea68-4224-41af-a23d-28e6acb89fae', 1, NULL, 'Chorus of Exiled Palestinians', 'The Death of Klinghoffer: Chorus of Exiled Palestinians', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24577 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a5cea68-4224-41af-a23d-28e6acb89fae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chorus of Exiled Jews', part.name_en = 'The Death of Klinghoffer: Chorus of Exiled Jews',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24577 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5a146007-5a1a-4b50-8284-1215a2d0f6c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a146007-5a1a-4b50-8284-1215a2d0f6c4', 2, NULL, 'Chorus of Exiled Jews', 'The Death of Klinghoffer: Chorus of Exiled Jews', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24577 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a146007-5a1a-4b50-8284-1215a2d0f6c4'
);


-- None The Dharma at Big Sur

UPDATE pieces piece
SET piece.title = 'The Dharma at Big Sur', piece.title_en = 'The Dharma at Big Sur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24385 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A New Day', part.name_en = 'The Dharma at Big Sur: I. A New Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24385 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:af9d65b4-2029-46ba-b387-7d31adb93c14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af9d65b4-2029-46ba-b387-7d31adb93c14', 1, 'I', 'A New Day', 'The Dharma at Big Sur: I. A New Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24385 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af9d65b4-2029-46ba-b387-7d31adb93c14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sri Moonshine', part.name_en = 'The Dharma at Big Sur: II. Sri Moonshine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24385 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:4f33f63f-0f5e-4920-8087-ce0394caa9ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f33f63f-0f5e-4920-8087-ce0394caa9ae', 2, 'II', 'Sri Moonshine', 'The Dharma at Big Sur: II. Sri Moonshine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24385 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f33f63f-0f5e-4920-8087-ce0394caa9ae'
);


-- None 오페라 <The Gospel According to the Other Mary>

UPDATE pieces piece
SET piece.title = '오페라 <The Gospel According to the Other Mary>', piece.title_en = 'The Gospel According to the Other Mary',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24503 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'The Gospel According to the Other Mary: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c', 1, NULL, 'Act I', 'The Gospel According to the Other Mary: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I. "The next day in the city jail we were searched for drugs"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene I. "The next day in the city jail we were searched for drugs"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5989a498-f1cf-423d-a87c-cc8dacab15a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5989a498-f1cf-423d-a87c-cc8dacab15a4', 1, NULL, 'Scene I. "The next day in the city jail we were searched for drugs"', 'The Gospel According to the Other Mary: Act I, Scene I. "The next day in the city jail we were searched for drugs"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5989a498-f1cf-423d-a87c-cc8dacab15a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Now a certain woman named Martha welcomed him Into her house"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene I. "Now a certain woman named Martha welcomed him Into her house"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3b2f52bc-77af-4856-b91b-354432c0fb25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b2f52bc-77af-4856-b91b-354432c0fb25', 2, NULL, 'Scene I. "Now a certain woman named Martha welcomed him Into her house"', 'The Gospel According to the Other Mary: Act I, Scene I. "Now a certain woman named Martha welcomed him Into her house"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b2f52bc-77af-4856-b91b-354432c0fb25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene II. "And she had a sister named mary"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene II. "And she had a sister named mary"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6d628ff1-220e-4c34-8a51-ad1a73a3a65b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d628ff1-220e-4c34-8a51-ad1a73a3a65b', 3, NULL, 'Scene II. "And she had a sister named mary"', 'The Gospel According to the Other Mary: Act I, Scene II. "And she had a sister named mary"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d628ff1-220e-4c34-8a51-ad1a73a3a65b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene II. "I am surprised that I am beginning to pray daily"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene II. "I am surprised that I am beginning to pray daily"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:02e69de6-d1ff-4bfa-a6a4-a75fac277629' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02e69de6-d1ff-4bfa-a6a4-a75fac277629', 4, NULL, 'Scene II. "I am surprised that I am beginning to pray daily"', 'The Gospel According to the Other Mary: Act I, Scene II. "I am surprised that I am beginning to pray daily"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e69de6-d1ff-4bfa-a6a4-a75fac277629'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene II. Chorus "En un día de amor"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene II. Chorus "En un día de amor"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bf258f78-a0ac-4a9b-ab2f-16dac5cdd1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf258f78-a0ac-4a9b-ab2f-16dac5cdd1ac', 5, NULL, 'Scene II. Chorus "En un día de amor"', 'The Gospel According to the Other Mary: Act I, Scene II. Chorus "En un día de amor"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf258f78-a0ac-4a9b-ab2f-16dac5cdd1ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Now a certain man was sick, named Lazarus"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "Now a certain man was sick, named Lazarus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e17749e6-c1ae-4afd-8e5f-81f1a589e9d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e17749e6-c1ae-4afd-8e5f-81f1a589e9d3', 6, NULL, 'Scene III. "Now a certain man was sick, named Lazarus"', 'The Gospel According to the Other Mary: Act I, Scene III. "Now a certain man was sick, named Lazarus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e17749e6-c1ae-4afd-8e5f-81f1a589e9d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene III. Lazarus Dies', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. Lazarus Dies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:77f8f201-234f-4f63-ac89-1a99d2c10c85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77f8f201-234f-4f63-ac89-1a99d2c10c85', 7, NULL, 'Scene III. Lazarus Dies', 'The Gospel According to the Other Mary: Act I, Scene III. Lazarus Dies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77f8f201-234f-4f63-ac89-1a99d2c10c85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Why standest thou afar off, lord?"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "Why standest thou afar off, lord?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ffdbc4e3-6d53-45b8-8ad1-164d380aa710' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffdbc4e3-6d53-45b8-8ad1-164d380aa710', 8, NULL, 'Scene III. "Why standest thou afar off, lord?"', 'The Gospel According to the Other Mary: Act I, Scene III. "Why standest thou afar off, lord?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffdbc4e3-6d53-45b8-8ad1-164d380aa710'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene III. "In my own quietly explosive here"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "In my own quietly explosive here"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9e000e5e-193a-4d4f-a320-92a006e3b7f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e000e5e-193a-4d4f-a320-92a006e3b7f3', 9, NULL, 'Scene III. "In my own quietly explosive here"', 'The Gospel According to the Other Mary: Act I, Scene III. "In my own quietly explosive here"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e000e5e-193a-4d4f-a320-92a006e3b7f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Don''t touch my left arm!"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "Don''t touch my left arm!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:8b18b973-54bb-4c04-8003-e52642ff4b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b18b973-54bb-4c04-8003-e52642ff4b7f', 10, NULL, 'Scene III. "Don''t touch my left arm!"', 'The Gospel According to the Other Mary: Act I, Scene III. "Don''t touch my left arm!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b18b973-54bb-4c04-8003-e52642ff4b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene III. "When Mary was come where Jesus was"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "When Mary was come where Jesus was"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9e72d22c-6841-489f-b932-4230ee8a37e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e72d22c-6841-489f-b932-4230ee8a37e6', 11, NULL, 'Scene III. "When Mary was come where Jesus was"', 'The Gospel According to the Other Mary: Act I, Scene III. "When Mary was come where Jesus was"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e72d22c-6841-489f-b932-4230ee8a37e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Jesus said, take ye away the stone"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. "Jesus said, take ye away the stone"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:5b8a984d-a153-4425-8bda-2763324bd459' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b8a984d-a153-4425-8bda-2763324bd459', 12, NULL, 'Scene III. "Jesus said, take ye away the stone"', 'The Gospel According to the Other Mary: Act I, Scene III. "Jesus said, take ye away the stone"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8a984d-a153-4425-8bda-2763324bd459'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene III. Chorus "Drop down, ye heavens"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. Chorus "Drop down, ye heavens"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9fdfd00f-dce4-4a46-af09-86a38e728cab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fdfd00f-dce4-4a46-af09-86a38e728cab', 13, NULL, 'Scene III. Chorus "Drop down, ye heavens"', 'The Gospel According to the Other Mary: Act I, Scene III. Chorus "Drop down, ye heavens"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fdfd00f-dce4-4a46-af09-86a38e728cab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene III. Lazarus Rises From the Dead', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene III. Lazarus Rises From the Dead',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a27e98a7-c217-487c-9789-222acc7064c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a27e98a7-c217-487c-9789-222acc7064c2', 14, NULL, 'Scene III. Lazarus Rises From the Dead', 'The Gospel According to the Other Mary: Act I, Scene III. Lazarus Rises From the Dead', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27e98a7-c217-487c-9789-222acc7064c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scene IV. "For the grave cannot praise thee"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene IV. "For the grave cannot praise thee"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:662b04ba-612a-4302-a703-dcb5cf9b207e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:662b04ba-612a-4302-a703-dcb5cf9b207e', 15, NULL, 'Scene IV. "For the grave cannot praise thee"', 'The Gospel According to the Other Mary: Act I, Scene IV. "For the grave cannot praise thee"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662b04ba-612a-4302-a703-dcb5cf9b207e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scene IV. Mary Washes the Feet of Jesus', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene IV. Mary Washes the Feet of Jesus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:18bf877b-2b62-467d-a26e-80ee889200c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18bf877b-2b62-467d-a26e-80ee889200c5', 16, NULL, 'Scene IV. Mary Washes the Feet of Jesus', 'The Gospel According to the Other Mary: Act I, Scene IV. Mary Washes the Feet of Jesus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18bf877b-2b62-467d-a26e-80ee889200c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Scene IV. Supper at Bethany', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene IV. Supper at Bethany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d10d9810-b071-4fbc-ab8c-2b8ce06e339a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d10d9810-b071-4fbc-ab8c-2b8ce06e339a', 17, NULL, 'Scene IV. Supper at Bethany', 'The Gospel According to the Other Mary: Act I, Scene IV. Supper at Bethany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10d9810-b071-4fbc-ab8c-2b8ce06e339a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Scene V. "And there were some who had indignation within themselves"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene V. "And there were some who had indignation within themselves"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ef5a35ba-309a-4442-8db1-58ed5fc7a923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef5a35ba-309a-4442-8db1-58ed5fc7a923', 18, NULL, 'Scene V. "And there were some who had indignation within themselves"', 'The Gospel According to the Other Mary: Act I, Scene V. "And there were some who had indignation within themselves"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5a35ba-309a-4442-8db1-58ed5fc7a923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Scene V. "Tell me: how is this night different from all other night?"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene V. "Tell me: how is this night different from all other night?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:bb40aaa9-63a8-4a1e-ba49-5c1cfa6446d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb40aaa9-63a8-4a1e-ba49-5c1cfa6446d4', 19, NULL, 'Scene V. "Tell me: how is this night different from all other night?"', 'The Gospel According to the Other Mary: Act I, Scene V. "Tell me: how is this night different from all other night?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb40aaa9-63a8-4a1e-ba49-5c1cfa6446d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Scene V. "We know there will be no utopias"', part.name_en = 'The Gospel According to the Other Mary: Act I, Scene V. "We know there will be no utopias"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ad0dd83f-903c-4530-8701-4c88f26ee82e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad0dd83f-903c-4530-8701-4c88f26ee82e', 20, NULL, 'Scene V. "We know there will be no utopias"', 'The Gospel According to the Other Mary: Act I, Scene V. "We know there will be no utopias"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad0dd83f-903c-4530-8701-4c88f26ee82e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Gospel According to the Other Mary, Act I Scene III. "And When He Thus Had Spoken"', part.name_en = 'The Gospel According to the Other Mary, Act I Scene III. "And When He Thus Had Spoken"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a4dacd04-7741-408d-a6f5-2bedf4779e3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4dacd04-7741-408d-a6f5-2bedf4779e3e', 21, NULL, 'The Gospel According to the Other Mary, Act I Scene III. "And When He Thus Had Spoken"', 'The Gospel According to the Other Mary, Act I Scene III. "And When He Thus Had Spoken"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a059a63e-59dd-499f-96c2-4308b082c44c'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4dacd04-7741-408d-a6f5-2bedf4779e3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Gospel According to the Other Mary: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb', 2, NULL, 'Act II', 'The Gospel According to the Other Mary: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene V. Mary Awakes at Dawn', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene V. Mary Awakes at Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2096c30c-9c89-4b93-8492-25b82fbf8802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2096c30c-9c89-4b93-8492-25b82fbf8802', 1, NULL, 'Scene V. Mary Awakes at Dawn', 'The Gospel According to the Other Mary: Act II, Scene V. Mary Awakes at Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2096c30c-9c89-4b93-8492-25b82fbf8802'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II. "The said defendants, on or about August 2nd"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene II. "The said defendants, on or about August 2nd"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2c7c16a6-d7e9-433f-86d2-831c76a457ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c7c16a6-d7e9-433f-86d2-831c76a457ba', 2, NULL, 'Scene II. "The said defendants, on or about August 2nd"', 'The Gospel According to the Other Mary: Act II, Scene II. "The said defendants, on or about August 2nd"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c7c16a6-d7e9-433f-86d2-831c76a457ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Daughters of Jerusalem, weep not for me"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene III. "Daughters of Jerusalem, weep not for me"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:2ed73918-f6b4-493b-b465-51d7f2184cf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ed73918-f6b4-493b-b465-51d7f2184cf5', 3, NULL, 'Scene III. "Daughters of Jerusalem, weep not for me"', 'The Gospel According to the Other Mary: Act II, Scene III. "Daughters of Jerusalem, weep not for me"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ed73918-f6b4-493b-b465-51d7f2184cf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene VI. Earthquake and Recognition', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene VI. Earthquake and Recognition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3276ed6f-0d62-4f44-97a3-723e49163a1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3276ed6f-0d62-4f44-97a3-723e49163a1c', 4, NULL, 'Scene VI. Earthquake and Recognition', 'The Gospel According to the Other Mary: Act II, Scene VI. Earthquake and Recognition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3276ed6f-0d62-4f44-97a3-723e49163a1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene I. Chorus "Who rips his flesh down the seams"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene I. Chorus "Who rips his flesh down the seams"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:3f00730d-19a4-4f8d-aa9e-e14656785e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f00730d-19a4-4f8d-aa9e-e14656785e71', 5, NULL, 'Scene I. Chorus "Who rips his flesh down the seams"', 'The Gospel According to the Other Mary: Act II, Scene I. Chorus "Who rips his flesh down the seams"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f00730d-19a4-4f8d-aa9e-e14656785e71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene II. Prayer of the Mexican Women', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene II. Prayer of the Mexican Women',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:463ddd35-87a9-4326-85e4-ce878449493c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:463ddd35-87a9-4326-85e4-ce878449493c', 6, NULL, 'Scene II. Prayer of the Mexican Women', 'The Gospel According to the Other Mary: Act II, Scene II. Prayer of the Mexican Women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:463ddd35-87a9-4326-85e4-ce878449493c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene III. Golgotha', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene III. Golgotha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:52536d02-ec1f-41bd-a7cf-daa68a646934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52536d02-ec1f-41bd-a7cf-daa68a646934', 7, NULL, 'Scene III. Golgotha', 'The Gospel According to the Other Mary: Act II, Scene III. Golgotha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52536d02-ec1f-41bd-a7cf-daa68a646934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Up at two A.M., picketed all day"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene II. "Up at two A.M., picketed all day"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6da1bf8f-2fc0-4096-90fa-332471554610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6da1bf8f-2fc0-4096-90fa-332471554610', 8, NULL, 'Scene II. "Up at two A.M., picketed all day"', 'The Gospel According to the Other Mary: Act II, Scene II. "Up at two A.M., picketed all day"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6da1bf8f-2fc0-4096-90fa-332471554610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene IV. Night', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene IV. Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6e5bf10b-1e36-401e-be07-c3e81d7dcbda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e5bf10b-1e36-401e-be07-c3e81d7dcbda', 9, NULL, 'Scene IV. Night', 'The Gospel According to the Other Mary: Act II, Scene IV. Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e5bf10b-1e36-401e-be07-c3e81d7dcbda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene I. Arrest of Jesus', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene I. Arrest of Jesus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:6ed0c3f1-e48e-4bd9-9e3b-d5a77bbaef2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ed0c3f1-e48e-4bd9-9e3b-d5a77bbaef2c', 10, NULL, 'Scene I. Arrest of Jesus', 'The Gospel According to the Other Mary: Act II, Scene I. Arrest of Jesus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ed0c3f1-e48e-4bd9-9e3b-d5a77bbaef2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene V. Chorus "It is spring"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene V. Chorus "It is spring"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:93d49404-ff82-4ce3-920f-c39ce6be039a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93d49404-ff82-4ce3-920f-c39ce6be039a', 11, NULL, 'Scene V. Chorus "It is spring"', 'The Gospel According to the Other Mary: Act II, Scene V. Chorus "It is spring"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93d49404-ff82-4ce3-920f-c39ce6be039a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene IV. "His son cried out to him"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene IV. "His son cried out to him"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:9663534d-555d-494c-9924-e550f506ca36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9663534d-555d-494c-9924-e550f506ca36', 12, NULL, 'Scene IV. "His son cried out to him"', 'The Gospel According to the Other Mary: Act II, Scene IV. "His son cried out to him"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9663534d-555d-494c-9924-e550f506ca36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene III. "Now there stood at the cross of Jesus"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene III. "Now there stood at the cross of Jesus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:96720aba-f272-4158-88eb-0eb537729f4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96720aba-f272-4158-88eb-0eb537729f4b', 13, NULL, 'Scene III. "Now there stood at the cross of Jesus"', 'The Gospel According to the Other Mary: Act II, Scene III. "Now there stood at the cross of Jesus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96720aba-f272-4158-88eb-0eb537729f4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene V. The Sepulchre; Mary''s Awakening', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene V. The Sepulchre; Mary''s Awakening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:a51a3d3f-c829-4eda-a6c6-ec8b2dd8b2df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a51a3d3f-c829-4eda-a6c6-ec8b2dd8b2df', 14, NULL, 'Scene V. The Sepulchre; Mary''s Awakening', 'The Gospel According to the Other Mary: Act II, Scene V. The Sepulchre; Mary''s Awakening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a51a3d3f-c829-4eda-a6c6-ec8b2dd8b2df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scene VI. "Why seek ye the living among the dead?"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene VI. "Why seek ye the living among the dead?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:b7803e20-3848-4a73-9476-ce81bf721703' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7803e20-3848-4a73-9476-ce81bf721703', 15, NULL, 'Scene VI. "Why seek ye the living among the dead?"', 'The Gospel According to the Other Mary: Act II, Scene VI. "Why seek ye the living among the dead?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7803e20-3848-4a73-9476-ce81bf721703'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scene II. Arrest of the Women', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene II. Arrest of the Women',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:d6728535-d5d6-4316-9574-bcbb1929e33d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6728535-d5d6-4316-9574-bcbb1929e33d', 16, NULL, 'Scene II. Arrest of the Women', 'The Gospel According to the Other Mary: Act II, Scene II. Arrest of the Women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6728535-d5d6-4316-9574-bcbb1929e33d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Scene III. "When Jesus saw his mother"', part.name_en = 'The Gospel According to the Other Mary: Act II, Scene III. "When Jesus saw his mother"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24503 AND p.composer_id = 441 AND part.part_key = 'musicbrainz:e845ab12-6cea-45d4-bead-9e9c1842e3af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e845ab12-6cea-45d4-bead-9e9c1842e3af', 17, NULL, 'Scene III. "When Jesus saw his mother"', 'The Gospel According to the Other Mary: Act II, Scene III. "When Jesus saw his mother"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed6faefd-8ecd-485c-b40e-4dcbd8f700eb'
WHERE p.id = 24503 AND p.composer_id = 441
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e845ab12-6cea-45d4-bead-9e9c1842e3af'
);


-- None The Wound-Dresser

UPDATE pieces piece
SET piece.title = 'The Wound-Dresser', piece.title_en = 'The Wound-Dresser',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25737 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tromba lontana

UPDATE pieces piece
SET piece.title = 'Tromba lontana', piece.title_en = 'Tromba lontana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24060 AND piece.composer_id = 441
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shaker Loops

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Shaker Loops', 'Shaker Loops', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 441
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Shaker Loops'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '288ff423-eda9-45bc-9775-8d61a83167ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '288ff423-eda9-45bc-9775-8d61a83167ed'
FROM pieces p
WHERE p.composer_id = 441 AND p.title = 'Shaker Loops' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '288ff423-eda9-45bc-9775-8d61a83167ed'
);


-- None 현악 4중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주', 'String Quartet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 441
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be6b313e-0ca5-43a9-bcdf-840cb36f1104'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be6b313e-0ca5-43a9-bcdf-840cb36f1104'
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '현악 4중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be6b313e-0ca5-43a9-bcdf-840cb36f1104'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662fc285-85ca-411e-9da5-8eaa9b373fd0', 1, 'I', 'Quietly animated; slow; scherzando; slow', 'String Quartet: I. Quietly animated; slow; scherzando; slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '현악 4중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662fc285-85ca-411e-9da5-8eaa9b373fd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b074afef-aca3-45fc-b2de-9638331e6192', 2, 'II', 'New tempo: brisk quarters', 'String Quartet: II. New tempo: brisk quarters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '현악 4중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b074afef-aca3-45fc-b2de-9638331e6192'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 441
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22e34161-c41e-4fb0-a3ab-c411d9d93c20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22e34161-c41e-4fb0-a3ab-c411d9d93c20'
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22e34161-c41e-4fb0-a3ab-c411d9d93c20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e024619-d64d-47a1-8fe8-b712d5007d16', 1, 'I', '♩ = 78', 'Violin Concerto: I. ♩ = 78', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e024619-d64d-47a1-8fe8-b712d5007d16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c57cad0b-21bd-4865-bcd7-4d90c91b1426', 2, 'II', 'Chaconne: Body Through Which the Dream Flows', 'Violin Concerto: II. Chaconne: Body Through Which the Dream Flows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c57cad0b-21bd-4865-bcd7-4d90c91b1426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510cc381-7f64-49d5-81ea-6dd7cabd515a', 3, 'III', 'Toccare', 'Violin Concerto: III. Toccare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 441 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510cc381-7f64-49d5-81ea-6dd7cabd515a'
);


-- 숨길 seed 작품 없음
