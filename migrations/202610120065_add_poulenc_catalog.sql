-- 풀랑크 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 147개(묶음 47, 다악장 43, 낱곡 57),
-- 새 작품 13개, part 444개, 그 아래 40개.
-- seed 155개 중 133개를 작품·part 에 잇고, 22개를 숨기고, 0개는 그대로 둔다.
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

-- None 가곡 <... mais mourir, FP 137>

UPDATE pieces piece
SET piece.title = '가곡 <... mais mourir, FP 137>', piece.title_en = '... mais mourir, FP 137',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10792 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3 Intermezzi, FP 71 & FP 118

UPDATE pieces piece
SET piece.title = '3 Intermezzi, FP 71 & FP 118', piece.title_en = '3 Intermezzi, FP 71 & FP 118',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10534 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Intermezzo no. 3 in A-flat major, FP 118', part.name_en = 'Intermezzo no. 3 in A-flat major, FP 118',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10534 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:34c26ea8-6270-4b3e-853b-63cce7795384' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34c26ea8-6270-4b3e-853b-63cce7795384', 1, NULL, 'Intermezzo no. 3 in A-flat major, FP 118', 'Intermezzo no. 3 in A-flat major, FP 118', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10534 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34c26ea8-6270-4b3e-853b-63cce7795384'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2 Intermezzi, FP 71', part.name_en = '2 Intermezzi, FP 71',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10534 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a', 2, NULL, '2 Intermezzi, FP 71', '2 Intermezzi, FP 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10534 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Intermezzo no. 1 for piano in C major, FP 71', part.name_en = 'Intermezzo no. 1 for piano in C major, FP 71',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10534 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:50a00ea1-ac2b-4670-b1dc-c50d5b94c61b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50a00ea1-ac2b-4670-b1dc-c50d5b94c61b', 1, NULL, 'Intermezzo no. 1 for piano in C major, FP 71', 'Intermezzo no. 1 for piano in C major, FP 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a'
WHERE p.id = 10534 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a00ea1-ac2b-4670-b1dc-c50d5b94c61b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'Intermezzo no. 2 in D-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10534 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2bb66d5d-775e-445d-a473-f5db1765d78e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bb66d5d-775e-445d-a473-f5db1765d78e', 2, NULL, 'D♭장조', 'Intermezzo no. 2 in D-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc778fe8-acf8-45a6-82ca-394be1d5846a'
WHERE p.id = 10534 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bb66d5d-775e-445d-a473-f5db1765d78e'
);


-- None 3개의 노벨레테

UPDATE pieces piece
SET piece.title = '3개의 노벨레테', piece.title_en = '3 Novelettes, FP 47/173',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7768 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '2 Novelettes, FP 47', part.name_en = '2 Novelettes, FP 47',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7768 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c', 1, NULL, '2 Novelettes, FP 47', '2 Novelettes, FP 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7768 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Novellette no. 1 in C major', part.name_en = 'Novellette no. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7768 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b065ddc3-3d40-4e77-bdeb-1970fee6e187' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b065ddc3-3d40-4e77-bdeb-1970fee6e187', 1, NULL, 'Novellette no. 1 in C major', 'Novellette no. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c'
WHERE p.id = 7768 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b065ddc3-3d40-4e77-bdeb-1970fee6e187'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Novellette no. 2 in B-flat minor', part.name_en = 'Novellette no. 2 in B-flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7768 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5ee08c22-37c9-4231-9cff-0d244bc6b907' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ee08c22-37c9-4231-9cff-0d244bc6b907', 2, NULL, 'Novellette no. 2 in B-flat minor', 'Novellette no. 2 in B-flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4908980c-6769-4390-8553-d44d03499f0c'
WHERE p.id = 7768 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ee08c22-37c9-4231-9cff-0d244bc6b907'
);


-- None 8개의 녹턴

UPDATE pieces piece
SET piece.title = '8개의 녹턴', piece.title_en = '8 Nocturnes, FP 56',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8440 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = 'Nocturne no. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d7e4153b-c78a-4576-a466-f81a674b527d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7e4153b-c78a-4576-a466-f81a674b527d', 1, NULL, 'C장조', 'Nocturne no. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7e4153b-c78a-4576-a466-f81a674b527d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nocturne No. 2 (Bal de jeunes filles)', part.name_en = 'Nocturne No. 2 (Bal de jeunes filles)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3a528b50-afc5-44d1-89e0-20338fe922a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a528b50-afc5-44d1-89e0-20338fe922a2', 2, NULL, 'Nocturne No. 2 (Bal de jeunes filles)', 'Nocturne No. 2 (Bal de jeunes filles)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a528b50-afc5-44d1-89e0-20338fe922a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nocturne No. 3 (Les cloches de Malines)', part.name_en = 'Nocturne No. 3 (Les cloches de Malines)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d44e07ea-3f6f-48be-88a6-d70e7b15f6e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d44e07ea-3f6f-48be-88a6-d70e7b15f6e6', 3, NULL, 'Nocturne No. 3 (Les cloches de Malines)', 'Nocturne No. 3 (Les cloches de Malines)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d44e07ea-3f6f-48be-88a6-d70e7b15f6e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nocturne no. 4 in C minor "Bal fantôme"', part.name_en = 'Nocturne no. 4 in C minor "Bal fantôme"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a902c511-204d-4287-939d-4e38f79e1a24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a902c511-204d-4287-939d-4e38f79e1a24', 4, NULL, 'Nocturne no. 4 in C minor "Bal fantôme"', 'Nocturne no. 4 in C minor "Bal fantôme"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a902c511-204d-4287-939d-4e38f79e1a24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nocturne No. 5 (Phalènes)', part.name_en = 'Nocturne No. 5 (Phalènes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:23f1c3ca-071a-464b-a6f9-95163cae716c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f1c3ca-071a-464b-a6f9-95163cae716c', 5, NULL, 'Nocturne No. 5 (Phalènes)', 'Nocturne No. 5 (Phalènes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f1c3ca-071a-464b-a6f9-95163cae716c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = 'Nocturne no. 6 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:51b2966f-cc45-4f8b-b733-60c9d44dfa21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51b2966f-cc45-4f8b-b733-60c9d44dfa21', 6, NULL, 'G장조', 'Nocturne no. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b2966f-cc45-4f8b-b733-60c9d44dfa21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'Nocturne no. 7 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ea2a692b-36d5-4869-8cc8-2792f95eb236' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea2a692b-36d5-4869-8cc8-2792f95eb236', 7, NULL, 'E♭장조', 'Nocturne no. 7 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea2a692b-36d5-4869-8cc8-2792f95eb236'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Nocturne No. 8 (pour servir de coda au cycle)', part.name_en = 'Nocturne No. 8 (pour servir de coda au cycle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8440 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2075b97b-9e4a-48cb-822d-244333573755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2075b97b-9e4a-48cb-822d-244333573755', 8, NULL, 'Nocturne No. 8 (pour servir de coda au cycle)', 'Nocturne No. 8 (pour servir de coda au cycle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8440 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2075b97b-9e4a-48cb-822d-244333573755'
);


-- None 연가곡집 <8 chansons françaises, FP 130>

UPDATE pieces piece
SET piece.title = '연가곡집 <8 chansons françaises, FP 130>', piece.title_en = '8 chansons françaises, FP 130',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7646 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La belle se sied au pied de la tour, op. 130 nº 2', part.name_en = 'La belle se sied au pied de la tour, op. 130 nº 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:976c123e-1927-4fa0-8a34-fe761c188c49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:976c123e-1927-4fa0-8a34-fe761c188c49', 1, NULL, 'La belle se sied au pied de la tour, op. 130 nº 2', 'La belle se sied au pied de la tour, op. 130 nº 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:976c123e-1927-4fa0-8a34-fe761c188c49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pilons l’orge, op. 130 nº 3', part.name_en = 'Pilons l’orge, op. 130 nº 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:60f6b374-52ea-406a-8870-0c7bd024362e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60f6b374-52ea-406a-8870-0c7bd024362e', 2, NULL, 'Pilons l’orge, op. 130 nº 3', 'Pilons l’orge, op. 130 nº 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f6b374-52ea-406a-8870-0c7bd024362e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Clic, clac, dansez sabots, op. 130 nº 4', part.name_en = 'Clic, clac, dansez sabots, op. 130 nº 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:72d61929-f164-4cc6-b941-d135a0e6d3e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d61929-f164-4cc6-b941-d135a0e6d3e0', 3, NULL, 'Clic, clac, dansez sabots, op. 130 nº 4', 'Clic, clac, dansez sabots, op. 130 nº 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d61929-f164-4cc6-b941-d135a0e6d3e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C’est la p’tit’ fill’ du prince, op. 130 nº 5', part.name_en = 'C’est la p’tit’ fill’ du prince, op. 130 nº 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:32346e5c-1f02-4928-adb5-d9c7014a2b9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32346e5c-1f02-4928-adb5-d9c7014a2b9c', 4, NULL, 'C’est la p’tit’ fill’ du prince, op. 130 nº 5', 'C’est la p’tit’ fill’ du prince, op. 130 nº 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32346e5c-1f02-4928-adb5-d9c7014a2b9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La belle si nous étions, op. 130 nº 6', part.name_en = 'La belle si nous étions, op. 130 nº 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e4f408d9-619b-4006-81d4-6d00ac223720' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4f408d9-619b-4006-81d4-6d00ac223720', 5, NULL, 'La belle si nous étions, op. 130 nº 6', 'La belle si nous étions, op. 130 nº 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4f408d9-619b-4006-81d4-6d00ac223720'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ah! mon beau laboureur, op. 130 nº 7', part.name_en = 'Ah! mon beau laboureur, op. 130 nº 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fb17a056-1f74-4725-9081-c9e106f83332' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb17a056-1f74-4725-9081-c9e106f83332', 6, NULL, 'Ah! mon beau laboureur, op. 130 nº 7', 'Ah! mon beau laboureur, op. 130 nº 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb17a056-1f74-4725-9081-c9e106f83332'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Les tisserands, op. 130 nº 8', part.name_en = 'Les tisserands, op. 130 nº 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7646 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c4ba7206-421a-4898-8852-268c5d34865f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4ba7206-421a-4898-8852-268c5d34865f', 7, NULL, 'Les tisserands, op. 130 nº 8', 'Les tisserands, op. 130 nº 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7646 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4ba7206-421a-4898-8852-268c5d34865f'
);


-- None Airs chantés, FP 46

UPDATE pieces piece
SET piece.title = 'Airs chantés, FP 46', piece.title_en = 'Airs chantés, FP 46',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10585 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Air romantique', part.name_en = 'Airs chantés, FP 46: 1. Air romantique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10585 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f8d13967-1c70-4e9a-b4a9-70b7fdd4576d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d13967-1c70-4e9a-b4a9-70b7fdd4576d', 1, NULL, 'Air romantique', 'Airs chantés, FP 46: 1. Air romantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10585 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d13967-1c70-4e9a-b4a9-70b7fdd4576d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Air champêtre', part.name_en = 'Airs chantés, FP 46: 2. Air champêtre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10585 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:89c921fa-d5a6-4da8-8693-bb40fd539723' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89c921fa-d5a6-4da8-8693-bb40fd539723', 2, NULL, 'Air champêtre', 'Airs chantés, FP 46: 2. Air champêtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10585 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c921fa-d5a6-4da8-8693-bb40fd539723'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Air grave', part.name_en = 'Airs chantés, FP 46: 3. Air grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10585 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:10813037-d99d-4d20-b25b-c400c2c068a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10813037-d99d-4d20-b25b-c400c2c068a1', 3, NULL, 'Air grave', 'Airs chantés, FP 46: 3. Air grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10585 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10813037-d99d-4d20-b25b-c400c2c068a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Air vif', part.name_en = 'Airs chantés, FP 46: 4. Air vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10585 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e1b7270d-46b0-4961-9942-c0be49c1d875' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1b7270d-46b0-4961-9942-c0be49c1d875', 4, NULL, 'Air vif', 'Airs chantés, FP 46: 4. Air vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10585 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1b7270d-46b0-4961-9942-c0be49c1d875'
);


-- None Aubade, FP 51

UPDATE pieces piece
SET piece.title = 'Aubade, FP 51', piece.title_en = 'Aubade, FP 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10849 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Toccata', part.name_en = 'Aubade, FP 51: I. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c9ae60e1-c65e-4466-bc67-6d2ef8d91290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9ae60e1-c65e-4466-bc67-6d2ef8d91290', 1, 'I', 'Toccata', 'Aubade, FP 51: I. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9ae60e1-c65e-4466-bc67-6d2ef8d91290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Recitatif: Les compagnes de Diane', part.name_en = 'Aubade, FP 51: II. Recitatif: Les compagnes de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d1ec3586-def1-48ff-b08f-90ead88655fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1ec3586-def1-48ff-b08f-90ead88655fb', 2, 'II', 'Recitatif: Les compagnes de Diane', 'Aubade, FP 51: II. Recitatif: Les compagnes de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ec3586-def1-48ff-b08f-90ead88655fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondeau: Diane et compagnes', part.name_en = 'Aubade, FP 51: III. Rondeau: Diane et compagnes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:66cd38de-5de1-455b-9933-0fcf3058075e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66cd38de-5de1-455b-9933-0fcf3058075e', 3, 'III', 'Rondeau: Diane et compagnes', 'Aubade, FP 51: III. Rondeau: Diane et compagnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66cd38de-5de1-455b-9933-0fcf3058075e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto: Toilette de Diane', part.name_en = 'Aubade, FP 51: IV. Presto: Toilette de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aad00a10-43ef-4918-a893-1b55a5d0a073' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aad00a10-43ef-4918-a893-1b55a5d0a073', 4, 'IV', 'Presto: Toilette de Diane', 'Aubade, FP 51: IV. Presto: Toilette de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad00a10-43ef-4918-a893-1b55a5d0a073'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Recitatif: Introduction a la variation de Diane', part.name_en = 'Aubade, FP 51: V. Recitatif: Introduction a la variation de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:129f016f-9497-4eb2-82bf-f90b523a48b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129f016f-9497-4eb2-82bf-f90b523a48b3', 5, 'V', 'Recitatif: Introduction a la variation de Diane', 'Aubade, FP 51: V. Recitatif: Introduction a la variation de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129f016f-9497-4eb2-82bf-f90b523a48b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Andante: Variation de Diane', part.name_en = 'Aubade, FP 51: VI. Andante: Variation de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a411302c-49f6-4abf-beb4-22b17645d9a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a411302c-49f6-4abf-beb4-22b17645d9a8', 6, 'VI', 'Andante: Variation de Diane', 'Aubade, FP 51: VI. Andante: Variation de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a411302c-49f6-4abf-beb4-22b17645d9a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegro feroce: Désespoir de Diane', part.name_en = 'Aubade, FP 51: VII. Allegro feroce: Désespoir de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:791f1f62-d458-481a-b713-d9186e406fb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:791f1f62-d458-481a-b713-d9186e406fb4', 7, 'VII', 'Allegro feroce: Désespoir de Diane', 'Aubade, FP 51: VII. Allegro feroce: Désespoir de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:791f1f62-d458-481a-b713-d9186e406fb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Conclusion: Adieux et départ de Diane', part.name_en = 'Aubade, FP 51: VIII. Conclusion: Adieux et départ de Diane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10849 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c07df2be-378f-4998-b5e2-bd59626bd829' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c07df2be-378f-4998-b5e2-bd59626bd829', 8, 'VIII', 'Conclusion: Adieux et départ de Diane', 'Aubade, FP 51: VIII. Conclusion: Adieux et départ de Diane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10849 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c07df2be-378f-4998-b5e2-bd59626bd829'
);


-- None Ave verum corpus, FP 154

UPDATE pieces piece
SET piece.title = 'Ave verum corpus, FP 154', piece.title_en = 'Ave verum corpus, FP 154',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7708 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Badinage, FP 73

UPDATE pieces piece
SET piece.title = 'Badinage, FP 73', piece.title_en = 'Badinage, FP 73',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9921 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Banalités, FP 107>

UPDATE pieces piece
SET piece.title = '연가곡집 <Banalités, FP 107>', piece.title_en = 'Banalités, FP 107',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10732 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson d''Orkenise', part.name_en = 'Banalités, FP 107: 1. Chanson d''Orkenise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10732 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:28184df3-212a-42f0-b3d8-453cd3f94aba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28184df3-212a-42f0-b3d8-453cd3f94aba', 1, NULL, 'Chanson d''Orkenise', 'Banalités, FP 107: 1. Chanson d''Orkenise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10732 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28184df3-212a-42f0-b3d8-453cd3f94aba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hôtel', part.name_en = 'Banalités, FP 107: 2. Hôtel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10732 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:11cb92ae-69e6-4934-9f97-a602a6ec85ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11cb92ae-69e6-4934-9f97-a602a6ec85ba', 2, NULL, 'Hôtel', 'Banalités, FP 107: 2. Hôtel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10732 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11cb92ae-69e6-4934-9f97-a602a6ec85ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fagnes de Wallonie', part.name_en = 'Banalités, FP 107: 3. Fagnes de Wallonie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10732 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:57ddee92-52be-4c82-9274-f2443dd194b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57ddee92-52be-4c82-9274-f2443dd194b2', 3, NULL, 'Fagnes de Wallonie', 'Banalités, FP 107: 3. Fagnes de Wallonie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10732 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ddee92-52be-4c82-9274-f2443dd194b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Voyage à Paris', part.name_en = 'Banalités, FP 107: 4. Voyage à Paris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10732 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a0e84a73-529f-4783-970d-a313e53cec2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0e84a73-529f-4783-970d-a313e53cec2a', 4, NULL, 'Voyage à Paris', 'Banalités, FP 107: 4. Voyage à Paris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10732 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0e84a73-529f-4783-970d-a313e53cec2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sanglots', part.name_en = 'Banalités, FP 107: 5. Sanglots',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10732 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:158d50ef-6415-471a-889c-ccaee3145a5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:158d50ef-6415-471a-889c-ccaee3145a5b', 5, NULL, 'Sanglots', 'Banalités, FP 107: 5. Sanglots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10732 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:158d50ef-6415-471a-889c-ccaee3145a5b'
);


-- None 가곡 <Bleuet, FP 102>

UPDATE pieces piece
SET piece.title = '가곡 <Bleuet, FP 102>', piece.title_en = 'Bleuet, FP 102',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9293 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bourrée au pavillon d'Auvergne, FP 87

UPDATE pieces piece
SET piece.title = 'Bourrée au pavillon d''Auvergne, FP 87', piece.title_en = 'Bourrée au pavillon d''Auvergne, FP 87',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7947 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Calligrammes, FP 140>

UPDATE pieces piece
SET piece.title = '연가곡집 <Calligrammes, FP 140>', piece.title_en = 'Calligrammes, FP 140',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9885 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L''espionne', part.name_en = 'Calligrammes, FP 140: 1. L''espionne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d27b511c-7c9a-46df-a090-61a87293a72a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d27b511c-7c9a-46df-a090-61a87293a72a', 1, NULL, 'L''espionne', 'Calligrammes, FP 140: 1. L''espionne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d27b511c-7c9a-46df-a090-61a87293a72a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mutation', part.name_en = 'Calligrammes, FP 140: 2. Mutation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2ede9fb3-a189-4a4b-a249-792fc2dac71b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ede9fb3-a189-4a4b-a249-792fc2dac71b', 2, NULL, 'Mutation', 'Calligrammes, FP 140: 2. Mutation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ede9fb3-a189-4a4b-a249-792fc2dac71b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vers le sud', part.name_en = 'Calligrammes, FP 140: 3. Vers le sud',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a419f8ea-914a-4bbf-aa87-592627a14bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a419f8ea-914a-4bbf-aa87-592627a14bef', 3, NULL, 'Vers le sud', 'Calligrammes, FP 140: 3. Vers le sud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a419f8ea-914a-4bbf-aa87-592627a14bef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Il pleut', part.name_en = 'Calligrammes, FP 140: 4. Il pleut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:afce3117-329f-468e-a485-e9600a6b1221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afce3117-329f-468e-a485-e9600a6b1221', 4, NULL, 'Il pleut', 'Calligrammes, FP 140: 4. Il pleut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afce3117-329f-468e-a485-e9600a6b1221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La grâce exilée', part.name_en = 'Calligrammes, FP 140: 5. La grâce exilée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:df163f3c-4bc6-46c7-a00f-e91cb1025571' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df163f3c-4bc6-46c7-a00f-e91cb1025571', 5, NULL, 'La grâce exilée', 'Calligrammes, FP 140: 5. La grâce exilée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df163f3c-4bc6-46c7-a00f-e91cb1025571'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Aussi bien que les cigales', part.name_en = 'Calligrammes, FP 140: 6. Aussi bien que les cigales',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c0c90c2c-1cdd-4924-9542-dbe60dc6f4f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0c90c2c-1cdd-4924-9542-dbe60dc6f4f9', 6, NULL, 'Aussi bien que les cigales', 'Calligrammes, FP 140: 6. Aussi bien que les cigales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0c90c2c-1cdd-4924-9542-dbe60dc6f4f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Voyage', part.name_en = 'Calligrammes, FP 140: 7. Voyage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9885 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:036fd8e1-d19d-4043-99cc-d670976dea11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:036fd8e1-d19d-4043-99cc-d670976dea11', 7, NULL, 'Voyage', 'Calligrammes, FP 140: 7. Voyage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9885 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:036fd8e1-d19d-4043-99cc-d670976dea11'
);


-- None Capriccio d’après Le Bal masqué, FP 155

UPDATE pieces piece
SET piece.title = 'Capriccio d’après Le Bal masqué, FP 155', piece.title_en = 'Capriccio d’après Le Bal masqué, FP 155',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9099 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ce doux petit visage, FP 99>

UPDATE pieces piece
SET piece.title = '가곡 <Ce doux petit visage, FP 99>', piece.title_en = 'Ce doux petit visage, FP 99',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10531 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chanson de marin>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson de marin>', piece.title_en = 'Chanson de marin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9505 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chanson à boire, FP 31>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson à boire, FP 31>', piece.title_en = 'Chanson à boire, FP 31',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10518 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Chansons gaillardes, FP 42>

UPDATE pieces piece
SET piece.title = '연가곡집 <Chansons gaillardes, FP 42>', piece.title_en = 'Chansons gaillardes, FP 42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7827 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La maîtresse volage', part.name_en = 'Chansons gaillardes, FP 42: 1. La maîtresse volage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:82d96513-2adc-4333-814b-7d6c8afceec6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d96513-2adc-4333-814b-7d6c8afceec6', 1, NULL, 'La maîtresse volage', 'Chansons gaillardes, FP 42: 1. La maîtresse volage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d96513-2adc-4333-814b-7d6c8afceec6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chanson à boire', part.name_en = 'Chansons gaillardes, FP 42: 2. Chanson à boire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:20fd0180-2a86-4be4-a234-96c4eb7c95f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20fd0180-2a86-4be4-a234-96c4eb7c95f0', 2, NULL, 'Chanson à boire', 'Chansons gaillardes, FP 42: 2. Chanson à boire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20fd0180-2a86-4be4-a234-96c4eb7c95f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Madrigal', part.name_en = 'Chansons gaillardes, FP 42: 3. Madrigal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:290433cb-85e6-425b-ac02-101949040739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:290433cb-85e6-425b-ac02-101949040739', 3, NULL, 'Madrigal', 'Chansons gaillardes, FP 42: 3. Madrigal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:290433cb-85e6-425b-ac02-101949040739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Invocation aux Parques', part.name_en = 'Chansons gaillardes, FP 42: 4. Invocation aux Parques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0f8e75ed-12f9-4594-b7c3-6f47753981ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f8e75ed-12f9-4594-b7c3-6f47753981ca', 4, NULL, 'Invocation aux Parques', 'Chansons gaillardes, FP 42: 4. Invocation aux Parques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f8e75ed-12f9-4594-b7c3-6f47753981ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Couplets bachiques', part.name_en = 'Chansons gaillardes, FP 42: 5. Couplets bachiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0689d2a0-0982-4ca1-8351-f0e58c7cf098' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0689d2a0-0982-4ca1-8351-f0e58c7cf098', 5, NULL, 'Couplets bachiques', 'Chansons gaillardes, FP 42: 5. Couplets bachiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0689d2a0-0982-4ca1-8351-f0e58c7cf098'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'L''offrande', part.name_en = 'Chansons gaillardes, FP 42: 6. L''offrande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fd7ec9e9-f09d-4859-bed2-79ba4b314fbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd7ec9e9-f09d-4859-bed2-79ba4b314fbf', 6, NULL, 'L''offrande', 'Chansons gaillardes, FP 42: 6. L''offrande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd7ec9e9-f09d-4859-bed2-79ba4b314fbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La belle jeunesse', part.name_en = 'Chansons gaillardes, FP 42: 7. La belle jeunesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:9f32fbc7-7622-48c1-b634-bc15d9542bb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f32fbc7-7622-48c1-b634-bc15d9542bb3', 7, NULL, 'La belle jeunesse', 'Chansons gaillardes, FP 42: 7. La belle jeunesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f32fbc7-7622-48c1-b634-bc15d9542bb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sérénade', part.name_en = 'Chansons gaillardes, FP 42: 8. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7827 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:105f5d39-1f09-41fc-b893-9b885ada8f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:105f5d39-1f09-41fc-b893-9b885ada8f65', 8, NULL, 'Sérénade', 'Chansons gaillardes, FP 42: 8. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7827 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105f5d39-1f09-41fc-b893-9b885ada8f65'
);


-- None 연가곡집 <Chansons villageoises, FP 117>

UPDATE pieces piece
SET piece.title = '연가곡집 <Chansons villageoises, FP 117>', piece.title_en = 'Chansons villageoises, FP 117',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11168 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chansons du clair-tamis', part.name_en = 'Chansons villageoises, FP 117: 1. Chansons du clair-tamis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f05ee340-285b-4993-a83c-c83c3e98b8d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05ee340-285b-4993-a83c-c83c3e98b8d5', 1, NULL, 'Chansons du clair-tamis', 'Chansons villageoises, FP 117: 1. Chansons du clair-tamis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05ee340-285b-4993-a83c-c83c3e98b8d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les gars qui vont à la fête', part.name_en = 'Chansons villageoises, FP 117: 2. Les gars qui vont à la fête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8a237a5c-3e2a-466a-af36-6bda0535a6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a237a5c-3e2a-466a-af36-6bda0535a6a2', 2, NULL, 'Les gars qui vont à la fête', 'Chansons villageoises, FP 117: 2. Les gars qui vont à la fête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a237a5c-3e2a-466a-af36-6bda0535a6a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C''est le joli printemps', part.name_en = 'Chansons villageoises, FP 117: 3. C''est le joli printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a272253e-bc94-4277-a672-3450031bb199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a272253e-bc94-4277-a672-3450031bb199', 3, NULL, 'C''est le joli printemps', 'Chansons villageoises, FP 117: 3. C''est le joli printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a272253e-bc94-4277-a672-3450031bb199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le mendiant', part.name_en = 'Chansons villageoises, FP 117: 4. Le mendiant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:42493f5d-7dfc-48e1-9e5c-4b135ae8d87b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42493f5d-7dfc-48e1-9e5c-4b135ae8d87b', 4, NULL, 'Le mendiant', 'Chansons villageoises, FP 117: 4. Le mendiant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42493f5d-7dfc-48e1-9e5c-4b135ae8d87b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Chanson de la fille frivole', part.name_en = 'Chansons villageoises, FP 117: 5. Chanson de la fille frivole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:653e68ff-e4c1-4485-acef-e3c48e368b82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:653e68ff-e4c1-4485-acef-e3c48e368b82', 5, NULL, 'Chanson de la fille frivole', 'Chansons villageoises, FP 117: 5. Chanson de la fille frivole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:653e68ff-e4c1-4485-acef-e3c48e368b82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le retour du sergent', part.name_en = 'Chansons villageoises, FP 117: 6. Le retour du sergent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11168 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6dac7c43-2c12-4f60-b6a6-524d0e3d02bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dac7c43-2c12-4f60-b6a6-524d0e3d02bb', 6, NULL, 'Le retour du sergent', 'Chansons villageoises, FP 117: 6. Le retour du sergent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11168 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dac7c43-2c12-4f60-b6a6-524d0e3d02bb'
);


-- None Cinq poèmes de Max Jacob, FP 59

UPDATE pieces piece
SET piece.title = 'Cinq poèmes de Max Jacob, FP 59', piece.title_en = 'Cinq poèmes de Max Jacob, FP 59',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7899 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson bretonne', part.name_en = 'Cinq poèmes de Max Jacob, FP 59: 1. Chanson bretonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:47171446-a896-49be-b5cc-0bc7273d1dd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47171446-a896-49be-b5cc-0bc7273d1dd1', 1, NULL, 'Chanson bretonne', 'Cinq poèmes de Max Jacob, FP 59: 1. Chanson bretonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47171446-a896-49be-b5cc-0bc7273d1dd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Cimetière', part.name_en = 'Cinq poèmes de Max Jacob, FP 59: 2. Cimetière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7a67aa85-54af-4bfb-b087-15fd30e26b40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a67aa85-54af-4bfb-b087-15fd30e26b40', 2, NULL, 'Cimetière', 'Cinq poèmes de Max Jacob, FP 59: 2. Cimetière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a67aa85-54af-4bfb-b087-15fd30e26b40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La petite servante', part.name_en = 'Cinq poèmes de Max Jacob, FP 59: 3. La petite servante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1ef26cf7-93e7-44a8-8bb7-10391f73a0fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ef26cf7-93e7-44a8-8bb7-10391f73a0fb', 3, NULL, 'La petite servante', 'Cinq poèmes de Max Jacob, FP 59: 3. La petite servante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ef26cf7-93e7-44a8-8bb7-10391f73a0fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Berceuse', part.name_en = 'Cinq poèmes de Max Jacob, FP 59: 4. Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:857b7b1d-2b1f-4890-90f5-b42173584c64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:857b7b1d-2b1f-4890-90f5-b42173584c64', 4, NULL, 'Berceuse', 'Cinq poèmes de Max Jacob, FP 59: 4. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:857b7b1d-2b1f-4890-90f5-b42173584c64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Souric et Mouric', part.name_en = 'Cinq poèmes de Max Jacob, FP 59: 5. Souric et Mouric',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:625349e4-c4e8-4d11-8b9d-deee419a84f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625349e4-c4e8-4d11-8b9d-deee419a84f8', 5, NULL, 'Souric et Mouric', 'Cinq poèmes de Max Jacob, FP 59: 5. Souric et Mouric', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625349e4-c4e8-4d11-8b9d-deee419a84f8'
);


-- None Cinq poèmes de Paul Éluard, FP 77

UPDATE pieces piece
SET piece.title = 'Cinq poèmes de Paul Éluard, FP 77', piece.title_en = 'Cinq poèmes de Paul Éluard, FP 77',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8467 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Peut-il se reposer', part.name_en = 'Cinq poèmes de Paul Éluard, FP 77: 1. Peut-il se reposer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8467 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1093a333-0fdd-45db-a212-5ca2591c2f30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1093a333-0fdd-45db-a212-5ca2591c2f30', 1, NULL, 'Peut-il se reposer', 'Cinq poèmes de Paul Éluard, FP 77: 1. Peut-il se reposer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8467 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1093a333-0fdd-45db-a212-5ca2591c2f30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Il la prend dans ses bras', part.name_en = 'Cinq poèmes de Paul Éluard, FP 77: 2. Il la prend dans ses bras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8467 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2dc2fe7a-f7ad-48fa-a675-acbcd301b058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dc2fe7a-f7ad-48fa-a675-acbcd301b058', 2, NULL, 'Il la prend dans ses bras', 'Cinq poèmes de Paul Éluard, FP 77: 2. Il la prend dans ses bras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8467 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc2fe7a-f7ad-48fa-a675-acbcd301b058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Plume d''eau claire', part.name_en = 'Cinq poèmes de Paul Éluard, FP 77: 3. Plume d''eau claire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8467 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:db72ddbc-7612-449c-af59-9cc13d8d54f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db72ddbc-7612-449c-af59-9cc13d8d54f6', 3, NULL, 'Plume d''eau claire', 'Cinq poèmes de Paul Éluard, FP 77: 3. Plume d''eau claire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8467 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db72ddbc-7612-449c-af59-9cc13d8d54f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rôdeuse au front de verre', part.name_en = 'Cinq poèmes de Paul Éluard, FP 77: 4. Rôdeuse au front de verre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8467 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:03aac595-f044-4b9f-adfe-e2a9370d9486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03aac595-f044-4b9f-adfe-e2a9370d9486', 4, NULL, 'Rôdeuse au front de verre', 'Cinq poèmes de Paul Éluard, FP 77: 4. Rôdeuse au front de verre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8467 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03aac595-f044-4b9f-adfe-e2a9370d9486'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Amoureuses', part.name_en = 'Cinq poèmes de Paul Éluard, FP 77: 5. Amoureuses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8467 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2bfe78f4-3583-425d-b1bd-f9f3acae0d37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bfe78f4-3583-425d-b1bd-f9f3acae0d37', 5, NULL, 'Amoureuses', 'Cinq poèmes de Paul Éluard, FP 77: 5. Amoureuses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8467 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bfe78f4-3583-425d-b1bd-f9f3acae0d37'
);


-- None 연가곡집 <Cocardes, FP 16a>

UPDATE pieces piece
SET piece.title = '연가곡집 <Cocardes, FP 16a>', piece.title_en = 'Cocardes, FP 16a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7918 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Miel de Narbonne', part.name_en = 'Cocardes, FP 16a: 1. Miel de Narbonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7918 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:19d7aab6-2593-468c-93aa-02a9c5c238c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d7aab6-2593-468c-93aa-02a9c5c238c7', 1, NULL, 'Miel de Narbonne', 'Cocardes, FP 16a: 1. Miel de Narbonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7918 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d7aab6-2593-468c-93aa-02a9c5c238c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bonne d''enfant', part.name_en = 'Cocardes, FP 16a: 2. Bonne d''enfant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7918 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c5d61b4b-29ef-4789-8d7b-f4b02cc6405c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5d61b4b-29ef-4789-8d7b-f4b02cc6405c', 2, NULL, 'Bonne d''enfant', 'Cocardes, FP 16a: 2. Bonne d''enfant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7918 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5d61b4b-29ef-4789-8d7b-f4b02cc6405c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Enfant de troupe', part.name_en = 'Cocardes, FP 16a: 3. Enfant de troupe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7918 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:86f6fdb5-67f3-4485-a913-74784255830c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86f6fdb5-67f3-4485-a913-74784255830c', 3, NULL, 'Enfant de troupe', 'Cocardes, FP 16a: 3. Enfant de troupe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7918 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86f6fdb5-67f3-4485-a913-74784255830c'
);


-- None 연가곡집 <Cocardes, FP 16b>

UPDATE pieces piece
SET piece.title = '연가곡집 <Cocardes, FP 16b>', piece.title_en = 'Cocardes, FP 16b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9014 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Miel de Narbonne', part.name_en = 'Cocardes, FP 16b: I. Miel de Narbonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9014 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d7a9465a-054d-450b-b152-5a7261282051' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a9465a-054d-450b-b152-5a7261282051', 1, 'I', 'Miel de Narbonne', 'Cocardes, FP 16b: I. Miel de Narbonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9014 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a9465a-054d-450b-b152-5a7261282051'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bonne d’enfant', part.name_en = 'Cocardes, FP 16b: II. Bonne d’enfant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9014 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:57c9ff72-898e-489a-ab45-1f6bafd4f392' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c9ff72-898e-489a-ab45-1f6bafd4f392', 2, 'II', 'Bonne d’enfant', 'Cocardes, FP 16b: II. Bonne d’enfant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9014 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c9ff72-898e-489a-ab45-1f6bafd4f392'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Enfant de troupe', part.name_en = 'Cocardes, FP 16b: III. Enfant de troupe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9014 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aba0bf92-012e-46ea-b39d-2bd14ec0136e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba0bf92-012e-46ea-b39d-2bd14ec0136e', 3, 'III', 'Enfant de troupe', 'Cocardes, FP 16b: III. Enfant de troupe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9014 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba0bf92-012e-46ea-b39d-2bd14ec0136e'
);


-- None 가곡 <Colloque, FP 108>

UPDATE pieces piece
SET piece.title = '가곡 <Colloque, FP 108>', piece.title_en = 'Colloque, FP 108',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9746 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 D단조

UPDATE pieces piece
SET piece.title = '협주곡 D단조', piece.title_en = 'Concerto for Two Pianos and Orchestra in D minor, FP 61',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10596 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Concerto for Two Pianos and Orchestra in D minor, FP 61: I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10596 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:81015210-f111-387e-8754-9e30a426abc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81015210-f111-387e-8754-9e30a426abc7', 1, 'I', 'Allegro ma non troppo', 'Concerto for Two Pianos and Orchestra in D minor, FP 61: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10596 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81015210-f111-387e-8754-9e30a426abc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'Concerto for Two Pianos and Orchestra in D minor, FP 61: II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10596 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:15d58784-cef7-3596-ae2f-f6f60795a032' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15d58784-cef7-3596-ae2f-f6f60795a032', 2, 'II', 'Larghetto', 'Concerto for Two Pianos and Orchestra in D minor, FP 61: II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10596 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15d58784-cef7-3596-ae2f-f6f60795a032'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale (Allegro molto)', part.name_en = 'Concerto for Two Pianos and Orchestra in D minor, FP 61: III. Finale (Allegro molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10596 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2ab22702-607c-3131-ab70-ff91b744b784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ab22702-607c-3131-ab70-ff91b744b784', 3, 'III', 'Finale (Allegro molto)', 'Concerto for Two Pianos and Orchestra in D minor, FP 61: III. Finale (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10596 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab22702-607c-3131-ab70-ff91b744b784'
);


-- None 협주곡 G단조

UPDATE pieces piece
SET piece.title = '협주곡 G단조', piece.title_en = 'Concerto in G minor for organ, strings and timpani, FP 93',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7543 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cf1a017e-3d08-4b2b-ba00-1079a8a45ed4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf1a017e-3d08-4b2b-ba00-1079a8a45ed4', 1, 'I', 'Andante', 'Concerto in G minor for organ, strings and timpani, FP 93: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf1a017e-3d08-4b2b-ba00-1079a8a45ed4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro giocoso', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: II. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d89b39d3-043c-4f74-b6dc-d36652bc9b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d89b39d3-043c-4f74-b6dc-d36652bc9b12', 2, 'II', 'Allegro giocoso', 'Concerto in G minor for organ, strings and timpani, FP 93: II. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89b39d3-043c-4f74-b6dc-d36652bc9b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Subito andante moderato', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: III. Subito andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:da5ddb7e-2688-4ea3-ac31-5dd322ddee99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da5ddb7e-2688-4ea3-ac31-5dd322ddee99', 3, 'III', 'Subito andante moderato', 'Concerto in G minor for organ, strings and timpani, FP 93: III. Subito andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da5ddb7e-2688-4ea3-ac31-5dd322ddee99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tempo allegro, molto agitato', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: IV. Tempo allegro, molto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0d4ba268-4564-4b07-a3cb-0bb9e3c2a5b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4ba268-4564-4b07-a3cb-0bb9e3c2a5b8', 4, 'IV', 'Tempo allegro, molto agitato', 'Concerto in G minor for organ, strings and timpani, FP 93: IV. Tempo allegro, molto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4ba268-4564-4b07-a3cb-0bb9e3c2a5b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Très calme. Lent', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: V. Très calme. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7ced6400-e8d3-4408-9e75-acc39a10ab1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ced6400-e8d3-4408-9e75-acc39a10ab1d', 5, 'V', 'Très calme. Lent', 'Concerto in G minor for organ, strings and timpani, FP 93: V. Très calme. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ced6400-e8d3-4408-9e75-acc39a10ab1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Tempo de l''allegro initial', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: VI. Tempo de l''allegro initial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3c5031de-1a33-4155-80a7-79e636a2de72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5031de-1a33-4155-80a7-79e636a2de72', 6, 'VI', 'Tempo de l''allegro initial', 'Concerto in G minor for organ, strings and timpani, FP 93: VI. Tempo de l''allegro initial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5031de-1a33-4155-80a7-79e636a2de72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Tempo introduction. Largo', part.name_en = 'Concerto in G minor for organ, strings and timpani, FP 93: VII. Tempo introduction. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7543 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:57941cf6-fec0-4df1-9606-b6f522c5f75b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57941cf6-fec0-4df1-9606-b6f522c5f75b', 7, 'VII', 'Tempo introduction. Largo', 'Concerto in G minor for organ, strings and timpani, FP 93: VII. Tempo introduction. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7543 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57941cf6-fec0-4df1-9606-b6f522c5f75b'
);


-- None 가곡 <Dernièr poème, FP 163>

UPDATE pieces piece
SET piece.title = '가곡 <Dernièr poème, FP 163>', piece.title_en = 'Dernièr poème, FP 163',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9789 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux marches et un intermède

UPDATE pieces piece
SET piece.title = 'Deux marches et un intermède', piece.title_en = 'Deux marches et un intermède',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10545 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Marche 1889', part.name_en = 'Deux marches et un intermède: I. Marche 1889',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10545 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0a47d924-380b-4e30-bcf2-83940989dfac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a47d924-380b-4e30-bcf2-83940989dfac', 1, 'I', 'Marche 1889', 'Deux marches et un intermède: I. Marche 1889', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10545 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a47d924-380b-4e30-bcf2-83940989dfac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermède champêtre', part.name_en = 'Deux marches et un intermède: II. Intermède champêtre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10545 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bb2d457a-3139-45e2-91e2-58ff3ba25936' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb2d457a-3139-45e2-91e2-58ff3ba25936', 2, 'II', 'Intermède champêtre', 'Deux marches et un intermède: II. Intermède champêtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10545 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb2d457a-3139-45e2-91e2-58ff3ba25936'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Marche 1937', part.name_en = 'Deux marches et un intermède: III. Marche 1937',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10545 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:113f2560-f19d-484b-acaf-b5b812fea247' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:113f2560-f19d-484b-acaf-b5b812fea247', 3, 'III', 'Marche 1937', 'Deux marches et un intermède: III. Marche 1937', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10545 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:113f2560-f19d-484b-acaf-b5b812fea247'
);


-- None Deux mélodies de Guillaume Apollinaire, FP 127

UPDATE pieces piece
SET piece.title = 'Deux mélodies de Guillaume Apollinaire, FP 127', piece.title_en = 'Deux mélodies de Guillaume Apollinaire, FP 127',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9378 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Montparnasse', part.name_en = 'Deux mélodies de Guillaume Apollinaire, FP 127: 1. Montparnasse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9378 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:49603c3b-b657-4975-af6f-2a1c04c2cd11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49603c3b-b657-4975-af6f-2a1c04c2cd11', 1, NULL, 'Montparnasse', 'Deux mélodies de Guillaume Apollinaire, FP 127: 1. Montparnasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9378 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49603c3b-b657-4975-af6f-2a1c04c2cd11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hyde Park', part.name_en = 'Deux mélodies de Guillaume Apollinaire, FP 127: 2. Hyde Park',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9378 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5bde3691-c49a-4199-aef1-d067c8f76a80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bde3691-c49a-4199-aef1-d067c8f76a80', 2, NULL, 'Hyde Park', 'Deux mélodies de Guillaume Apollinaire, FP 127: 2. Hyde Park', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9378 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bde3691-c49a-4199-aef1-d067c8f76a80'
);


-- None Deux mélodies inédites du bestiaire, FP 15b

UPDATE pieces piece
SET piece.title = 'Deux mélodies inédites du bestiaire, FP 15b', piece.title_en = 'Deux mélodies inédites du bestiaire, FP 15b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11164 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le serpent', part.name_en = 'Deux mélodies inédites du bestiaire, FP 15b: 1. Le serpent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11164 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8ce5614a-d6c4-4471-846e-0e07bdfb4dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce5614a-d6c4-4471-846e-0e07bdfb4dce', 1, NULL, 'Le serpent', 'Deux mélodies inédites du bestiaire, FP 15b: 1. Le serpent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11164 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce5614a-d6c4-4471-846e-0e07bdfb4dce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La colombe', part.name_en = 'Deux mélodies inédites du bestiaire, FP 15b: 2. La colombe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11164 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d6c54efb-2a77-4ff7-9eaf-c74716351277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6c54efb-2a77-4ff7-9eaf-c74716351277', 2, NULL, 'La colombe', 'Deux mélodies inédites du bestiaire, FP 15b: 2. La colombe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11164 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6c54efb-2a77-4ff7-9eaf-c74716351277'
);


-- None Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131

UPDATE pieces piece
SET piece.title = 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131', piece.title_en = 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10439 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le pont', part.name_en = 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131: 1. Le pont',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10439 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f9da092b-1ae2-4c41-9071-1d0678ceb9bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9da092b-1ae2-4c41-9071-1d0678ceb9bb', 1, NULL, 'Le pont', 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131: 1. Le pont', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10439 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9da092b-1ae2-4c41-9071-1d0678ceb9bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Un poème', part.name_en = 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131: 2. Un poème',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10439 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c6f8f9ba-6cda-48e0-ab91-3258ba116b09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6f8f9ba-6cda-48e0-ab91-3258ba116b09', 2, NULL, 'Un poème', 'Deux mélodies sur des poèmes de Guillaume Apollinaire, FP 131: 2. Un poème', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10439 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f8f9ba-6cda-48e0-ab91-3258ba116b09'
);


-- None Deux mélodies, FP 162

UPDATE pieces piece
SET piece.title = 'Deux mélodies, FP 162', piece.title_en = 'Deux mélodies, FP 162',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9995 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La souris', part.name_en = 'Deux mélodies, FP 162: 1. La souris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9995 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:537b9675-943c-49a0-bbdb-c670e9a5b077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:537b9675-943c-49a0-bbdb-c670e9a5b077', 1, NULL, 'La souris', 'Deux mélodies, FP 162: 1. La souris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9995 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:537b9675-943c-49a0-bbdb-c670e9a5b077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nuage', part.name_en = 'Deux mélodies, FP 162: 2. Nuage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9995 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4a33b517-9175-4298-8419-7e8aa1533232' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a33b517-9175-4298-8419-7e8aa1533232', 2, NULL, 'Nuage', 'Deux mélodies, FP 162: 2. Nuage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9995 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a33b517-9175-4298-8419-7e8aa1533232'
);


-- None Deux poèmes de Guillaume Apollinaire, FP 94

UPDATE pieces piece
SET piece.title = 'Deux poèmes de Guillaume Apollinaire, FP 94', piece.title_en = 'Deux poèmes de Guillaume Apollinaire, FP 94',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10252 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dans le jardin d''Anna', part.name_en = 'Deux poèmes de Guillaume Apollinaire, FP 94: 1. Dans le jardin d''Anna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10252 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:dff8949b-e17d-4ac0-b643-9cb1c6924a2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dff8949b-e17d-4ac0-b643-9cb1c6924a2e', 1, NULL, 'Dans le jardin d''Anna', 'Deux poèmes de Guillaume Apollinaire, FP 94: 1. Dans le jardin d''Anna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10252 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dff8949b-e17d-4ac0-b643-9cb1c6924a2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allons plus vite', part.name_en = 'Deux poèmes de Guillaume Apollinaire, FP 94: 2. Allons plus vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10252 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cfc27b27-f16d-42d9-aa28-87a4a2aba70e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfc27b27-f16d-42d9-aa28-87a4a2aba70e', 2, NULL, 'Allons plus vite', 'Deux poèmes de Guillaume Apollinaire, FP 94: 2. Allons plus vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10252 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfc27b27-f16d-42d9-aa28-87a4a2aba70e'
);


-- None 연가곡집 <Deux poèmes de Louis Aragon, FP 122>

UPDATE pieces piece
SET piece.title = '연가곡집 <Deux poèmes de Louis Aragon, FP 122>', piece.title_en = 'Deux poèmes de Louis Aragon, FP 122',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8612 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C', part.name_en = 'Deux poèmes de Louis Aragon, FP 122: Nº1. C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8612 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:dee9c3eb-11eb-42f5-8db1-64db390bee9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee9c3eb-11eb-42f5-8db1-64db390bee9a', 1, NULL, 'C', 'Deux poèmes de Louis Aragon, FP 122: Nº1. C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8612 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee9c3eb-11eb-42f5-8db1-64db390bee9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fêtes galantes', part.name_en = 'Deux poèmes de Louis Aragon, FP 122: Nº2. Fêtes galantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8612 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aabc594c-332e-4490-b5a5-d0db4fe3ee80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aabc594c-332e-4490-b5a5-d0db4fe3ee80', 2, NULL, 'Fêtes galantes', 'Deux poèmes de Louis Aragon, FP 122: Nº2. Fêtes galantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8612 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aabc594c-332e-4490-b5a5-d0db4fe3ee80'
);


-- None 오페라 <Dialogues des Carmélites>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Dialogues des Carmélites : Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e', 1, NULL, 'Acte I', 'Dialogues des Carmélites : Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 1', part.name_en = 'Dialogues des Carmélites : Acte I, Tableau 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8439b235-85a9-4b00-92d5-c9dbf83c608e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8439b235-85a9-4b00-92d5-c9dbf83c608e', 1, NULL, 'Tableau 1', 'Dialogues des Carmélites : Acte I, Tableau 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8439b235-85a9-4b00-92d5-c9dbf83c608e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte I, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7c04391b-ad1b-4b5a-8f48-173a42fcbc96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c04391b-ad1b-4b5a-8f48-173a42fcbc96', 2, NULL, 'Interlude', 'Dialogues des Carmélites : Acte I, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c04391b-ad1b-4b5a-8f48-173a42fcbc96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau 2', part.name_en = 'Dialogues des Carmélites : Acte I, Tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:183ce326-3caf-47ed-a8da-5e18db375e9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:183ce326-3caf-47ed-a8da-5e18db375e9b', 3, NULL, 'Tableau 2', 'Dialogues des Carmélites : Acte I, Tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183ce326-3caf-47ed-a8da-5e18db375e9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte I, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2b1d086d-e430-4c28-afdc-bb59436ec86c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b1d086d-e430-4c28-afdc-bb59436ec86c', 4, NULL, 'Interlude', 'Dialogues des Carmélites : Acte I, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b1d086d-e430-4c28-afdc-bb59436ec86c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tableau 3', part.name_en = 'Dialogues des Carmélites : Acte I, Tableau 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:175e1bcd-5bbd-4485-8a04-d6ec27a7f2f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:175e1bcd-5bbd-4485-8a04-d6ec27a7f2f4', 5, NULL, 'Tableau 3', 'Dialogues des Carmélites : Acte I, Tableau 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:175e1bcd-5bbd-4485-8a04-d6ec27a7f2f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte I, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cbd8a763-82fa-4cea-aa2e-fc43eecf7fba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbd8a763-82fa-4cea-aa2e-fc43eecf7fba', 6, NULL, 'Interlude', 'Dialogues des Carmélites : Acte I, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd8a763-82fa-4cea-aa2e-fc43eecf7fba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tableau 4', part.name_en = 'Dialogues des Carmélites : Acte I, Tableau 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cf76afe9-6d37-4ed0-a4f1-8eb647391fd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf76afe9-6d37-4ed0-a4f1-8eb647391fd2', 7, NULL, 'Tableau 4', 'Dialogues des Carmélites : Acte I, Tableau 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f731af0c-80ae-43f8-b3f0-a1fa873a729e'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf76afe9-6d37-4ed0-a4f1-8eb647391fd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II', part.name_en = 'Dialogues des Carmélites : Acte II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd', 2, NULL, 'Acte II', 'Dialogues des Carmélites : Acte II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 2', part.name_en = 'Dialogues des Carmélites : Acte II, Tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0d5ef42f-8b7d-4c76-b9e9-d63ad411a39e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d5ef42f-8b7d-4c76-b9e9-d63ad411a39e', 1, NULL, 'Tableau 2', 'Dialogues des Carmélites : Acte II, Tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d5ef42f-8b7d-4c76-b9e9-d63ad411a39e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tableau 4', part.name_en = 'Dialogues des Carmélites : Acte II, Tableau 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:537bd88d-0caa-4207-a15d-66ea5dec8c31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:537bd88d-0caa-4207-a15d-66ea5dec8c31', 2, NULL, 'Tableau 4', 'Dialogues des Carmélites : Acte II, Tableau 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:537bd88d-0caa-4207-a15d-66ea5dec8c31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tableau 3', part.name_en = 'Dialogues des Carmélites : Acte II, Tableau 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:56654f79-cc23-4e2d-8a3e-f618bed2bf78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56654f79-cc23-4e2d-8a3e-f618bed2bf78', 3, NULL, 'Tableau 3', 'Dialogues des Carmélites : Acte II, Tableau 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56654f79-cc23-4e2d-8a3e-f618bed2bf78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Interlude 1 (Le jardin du couvent). "Sœur Blanche, je trouve notre croix"', part.name_en = 'Dialogues des Carmélites : Acte II, Interlude 1 (Le jardin du couvent). "Sœur Blanche, je trouve notre croix"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:77066f54-7dc3-499c-85da-be9167f26234' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77066f54-7dc3-499c-85da-be9167f26234', 4, NULL, 'Interlude 1 (Le jardin du couvent). "Sœur Blanche, je trouve notre croix"', 'Dialogues des Carmélites : Acte II, Interlude 1 (Le jardin du couvent). "Sœur Blanche, je trouve notre croix"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77066f54-7dc3-499c-85da-be9167f26234'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte II, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a6af1547-db00-421e-8996-f8c8a8c09219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6af1547-db00-421e-8996-f8c8a8c09219', 5, NULL, 'Interlude', 'Dialogues des Carmélites : Acte II, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6af1547-db00-421e-8996-f8c8a8c09219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tableau 1', part.name_en = 'Dialogues des Carmélites : Acte II, Tableau 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ca13e735-59d2-44bf-9740-217bf9e99a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca13e735-59d2-44bf-9740-217bf9e99a0b', 6, NULL, 'Tableau 1', 'Dialogues des Carmélites : Acte II, Tableau 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca13e735-59d2-44bf-9740-217bf9e99a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Interlude 2 (Une salle du couvent). "Qe se passe-t-il?"', part.name_en = 'Dialogues des Carmélites : Acte II, Interlude 2 (Une salle du couvent). "Qe se passe-t-il?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cc7df46a-56f4-44a5-8705-4d855292b646' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc7df46a-56f4-44a5-8705-4d855292b646', 7, NULL, 'Interlude 2 (Une salle du couvent). "Qe se passe-t-il?"', 'Dialogues des Carmélites : Acte II, Interlude 2 (Une salle du couvent). "Qe se passe-t-il?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc7df46a-56f4-44a5-8705-4d855292b646'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Interlude 1 (Le jardin du couvent). "Pensez à la mort de notre chère mère"', part.name_en = 'Dialogues des Carmélites : Acte II, Interlude 1 (Le jardin du couvent). "Pensez à la mort de notre chère mère"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fe32ce83-8fe8-4721-a66b-8652b2078a6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe32ce83-8fe8-4721-a66b-8652b2078a6e', 8, NULL, 'Interlude 1 (Le jardin du couvent). "Pensez à la mort de notre chère mère"', 'Dialogues des Carmélites : Acte II, Interlude 1 (Le jardin du couvent). "Pensez à la mort de notre chère mère"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68ad7515-aff5-47d0-9909-e6bf9d60b4fd'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe32ce83-8fe8-4721-a66b-8652b2078a6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Dialogues des Carmélites : Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7', 3, NULL, 'Acte III', 'Dialogues des Carmélites : Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tableau 2', part.name_en = 'Dialogues des Carmélites : Acte III, Tableau 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1148d7d5-71d3-4fca-9ffa-187d51a1de52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1148d7d5-71d3-4fca-9ffa-187d51a1de52', 1, NULL, 'Tableau 2', 'Dialogues des Carmélites : Acte III, Tableau 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1148d7d5-71d3-4fca-9ffa-187d51a1de52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interlude 1 (Une rue devant le couvent). "Citoyennes, nous vous félicitons"', part.name_en = 'Dialogues des Carmélites : Acte III, Interlude 1 (Une rue devant le couvent). "Citoyennes, nous vous félicitons"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5927956b-bdbf-4ce0-b69e-a9024f1a809e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5927956b-bdbf-4ce0-b69e-a9024f1a809e', 2, NULL, 'Interlude 1 (Une rue devant le couvent). "Citoyennes, nous vous félicitons"', 'Dialogues des Carmélites : Acte III, Interlude 1 (Une rue devant le couvent). "Citoyennes, nous vous félicitons"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5927956b-bdbf-4ce0-b69e-a9024f1a809e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte III, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:69fc74bc-8c38-4af5-8b12-f31dfa491831' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69fc74bc-8c38-4af5-8b12-f31dfa491831', 3, NULL, 'Interlude', 'Dialogues des Carmélites : Acte III, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69fc74bc-8c38-4af5-8b12-f31dfa491831'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Dialogues des Carmélites : Acte III, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aab9b415-dc44-49ab-8fd8-aebb322759a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aab9b415-dc44-49ab-8fd8-aebb322759a1', 4, NULL, 'Interlude', 'Dialogues des Carmélites : Acte III, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab9b415-dc44-49ab-8fd8-aebb322759a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tableau 4', part.name_en = 'Dialogues des Carmélites : Acte III, Tableau 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:af55d492-9829-4a56-b6f7-b9276d3c6f8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af55d492-9829-4a56-b6f7-b9276d3c6f8c', 5, NULL, 'Tableau 4', 'Dialogues des Carmélites : Acte III, Tableau 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af55d492-9829-4a56-b6f7-b9276d3c6f8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tableau 3', part.name_en = 'Dialogues des Carmélites : Acte III, Tableau 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cf5bd453-2a24-4dcf-affd-7a81b3150c68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf5bd453-2a24-4dcf-affd-7a81b3150c68', 6, NULL, 'Tableau 3', 'Dialogues des Carmélites : Acte III, Tableau 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf5bd453-2a24-4dcf-affd-7a81b3150c68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Tableau 1', part.name_en = 'Dialogues des Carmélites : Acte III, Tableau 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 403 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fe975f72-04bd-445d-b649-7c400742c33b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe975f72-04bd-445d-b649-7c400742c33b', 7, NULL, 'Tableau 1', 'Dialogues des Carmélites : Acte III, Tableau 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:870bd1a1-57a5-40ff-82a4-a6546875b1d7'
WHERE p.id = 403 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe975f72-04bd-445d-b649-7c400742c33b'
);


-- None Exultate Deo, FP 109

UPDATE pieces piece
SET piece.title = 'Exultate Deo, FP 109', piece.title_en = 'Exultate Deo, FP 109',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8716 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fancy, FP 174>

UPDATE pieces piece
SET piece.title = '가곡 <Fancy, FP 174>', piece.title_en = 'Fancy, FP 174',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10556 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare, FP 25

UPDATE pieces piece
SET piece.title = 'Fanfare, FP 25', piece.title_en = 'Fanfare, FP 25',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9905 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Feuillets d'album, FP 68

UPDATE pieces piece
SET piece.title = 'Feuillets d''album, FP 68', piece.title_en = 'Feuillets d''album, FP 68',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9865 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ariette', part.name_en = 'Feuillets d''album: I. Ariette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9865 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e788c2d8-408c-492f-9a4c-69170d63d549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e788c2d8-408c-492f-9a4c-69170d63d549', 1, 'I', 'Ariette', 'Feuillets d''album: I. Ariette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9865 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e788c2d8-408c-492f-9a4c-69170d63d549'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rêve', part.name_en = 'Feuillets d''album: II. Rêve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9865 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:80a17f4b-5ac3-4683-8dbf-d9e0cf1334c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80a17f4b-5ac3-4683-8dbf-d9e0cf1334c7', 2, 'II', 'Rêve', 'Feuillets d''album: II. Rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9865 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a17f4b-5ac3-4683-8dbf-d9e0cf1334c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gigue', part.name_en = 'Feuillets d''album: III. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9865 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a5e3702c-613f-4d5e-8a4d-7b41b74ab5e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e3702c-613f-4d5e-8a4d-7b41b74ab5e4', 3, 'III', 'Gigue', 'Feuillets d''album: III. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9865 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e3702c-613f-4d5e-8a4d-7b41b74ab5e4'
);


-- None Fiançailles pour rire, FP 101

UPDATE pieces piece
SET piece.title = 'Fiançailles pour rire, FP 101', piece.title_en = 'Fiançailles pour rire, FP 101',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10156 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La dame d''André', part.name_en = 'Fiançailles pour rire, FP 101: 1. La dame d''André',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ccafd90a-7029-4d17-8342-9aa743ab087b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccafd90a-7029-4d17-8342-9aa743ab087b', 1, NULL, 'La dame d''André', 'Fiançailles pour rire, FP 101: 1. La dame d''André', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccafd90a-7029-4d17-8342-9aa743ab087b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dans l''herbe', part.name_en = 'Fiançailles pour rire, FP 101: 2. Dans l''herbe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:54d7b92e-1fd9-4f0b-aeb9-3291a92002cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d7b92e-1fd9-4f0b-aeb9-3291a92002cd', 2, NULL, 'Dans l''herbe', 'Fiançailles pour rire, FP 101: 2. Dans l''herbe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d7b92e-1fd9-4f0b-aeb9-3291a92002cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Il vole', part.name_en = 'Fiançailles pour rire, FP 101: 3. Il vole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:24ae5ea6-c46e-45bb-9068-f43854fdec7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24ae5ea6-c46e-45bb-9068-f43854fdec7b', 3, NULL, 'Il vole', 'Fiançailles pour rire, FP 101: 3. Il vole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24ae5ea6-c46e-45bb-9068-f43854fdec7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mon cadavre est doux comme un gant', part.name_en = 'Fiançailles pour rire, FP 101: 4. Mon cadavre est doux comme un gant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f86fcc04-cb8a-45ca-9cd5-c4939e60edb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f86fcc04-cb8a-45ca-9cd5-c4939e60edb0', 4, NULL, 'Mon cadavre est doux comme un gant', 'Fiançailles pour rire, FP 101: 4. Mon cadavre est doux comme un gant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86fcc04-cb8a-45ca-9cd5-c4939e60edb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Violon', part.name_en = 'Fiançailles pour rire, FP 101: 5. Violon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:24c5c76d-155b-44d2-8496-a44769af19ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c5c76d-155b-44d2-8496-a44769af19ce', 5, NULL, 'Violon', 'Fiançailles pour rire, FP 101: 5. Violon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c5c76d-155b-44d2-8496-a44769af19ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Fleurs', part.name_en = 'Fiançailles pour rire, FP 101: 6. Fleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10156 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:564e7594-e7e7-466d-9c42-d7c11257b3a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:564e7594-e7e7-466d-9c42-d7c11257b3a6', 6, NULL, 'Fleurs', 'Fiançailles pour rire, FP 101: 6. Fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10156 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:564e7594-e7e7-466d-9c42-d7c11257b3a6'
);


-- None 칸타타 <Figure humaine>

UPDATE pieces piece
SET piece.title = '칸타타 <Figure humaine>', piece.title_en = 'Figure humaine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7633 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'De tous les printemps du monde', part.name_en = 'Figure humaine: I. De tous les printemps du monde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:dac3b0f9-978e-4caa-b757-59e87742fc6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dac3b0f9-978e-4caa-b757-59e87742fc6b', 1, 'I', 'De tous les printemps du monde', 'Figure humaine: I. De tous les printemps du monde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dac3b0f9-978e-4caa-b757-59e87742fc6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'En chantant les servantes s''élancent', part.name_en = 'Figure humaine: II. En chantant les servantes s''élancent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:95cf5e4b-3f59-4e58-8f1b-872956ea0a3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95cf5e4b-3f59-4e58-8f1b-872956ea0a3a', 2, 'II', 'En chantant les servantes s''élancent', 'Figure humaine: II. En chantant les servantes s''élancent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95cf5e4b-3f59-4e58-8f1b-872956ea0a3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aussi bas que le silence', part.name_en = 'Figure humaine: III. Aussi bas que le silence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f25c2b1d-ebc5-46f0-a922-7e4b2c3bf04e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f25c2b1d-ebc5-46f0-a922-7e4b2c3bf04e', 3, 'III', 'Aussi bas que le silence', 'Figure humaine: III. Aussi bas que le silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f25c2b1d-ebc5-46f0-a922-7e4b2c3bf04e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Patience', part.name_en = 'Figure humaine: IV. Patience',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ab8fc87b-bdf4-40e5-98c9-e900491c06bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab8fc87b-bdf4-40e5-98c9-e900491c06bc', 4, 'IV', 'Patience', 'Figure humaine: IV. Patience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab8fc87b-bdf4-40e5-98c9-e900491c06bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Riant du ciel et des planètes', part.name_en = 'Figure humaine: V. Riant du ciel et des planètes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ec634702-4095-4d24-a299-5e782174984b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec634702-4095-4d24-a299-5e782174984b', 5, 'V', 'Riant du ciel et des planètes', 'Figure humaine: V. Riant du ciel et des planètes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec634702-4095-4d24-a299-5e782174984b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Le jour m''étonne et la nuit me fait peur', part.name_en = 'Figure humaine: VI. Le jour m''étonne et la nuit me fait peur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:76f8a6a1-4750-42dc-b1d0-f81989e3363f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76f8a6a1-4750-42dc-b1d0-f81989e3363f', 6, 'VI', 'Le jour m''étonne et la nuit me fait peur', 'Figure humaine: VI. Le jour m''étonne et la nuit me fait peur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76f8a6a1-4750-42dc-b1d0-f81989e3363f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'La menace sous le ciel rouge', part.name_en = 'Figure humaine: VII. La menace sous le ciel rouge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:841bfd33-4c1b-480d-b720-261cf7570499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:841bfd33-4c1b-480d-b720-261cf7570499', 7, 'VII', 'La menace sous le ciel rouge', 'Figure humaine: VII. La menace sous le ciel rouge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841bfd33-4c1b-480d-b720-261cf7570499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Liberté', part.name_en = 'Figure humaine: VIII. Liberté',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7633 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6171b0e2-e6fb-4024-9493-a9fbe09e13c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6171b0e2-e6fb-4024-9493-a9fbe09e13c1', 8, 'VIII', 'Liberté', 'Figure humaine: VIII. Liberté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7633 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6171b0e2-e6fb-4024-9493-a9fbe09e13c1'
);


-- None Française for Piano, FP 103

UPDATE pieces piece
SET piece.title = 'Française for Piano, FP 103', piece.title_en = 'Française for Piano, FP 103',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8011 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gloria, for Soprano, Chorus and Orchestra, FP 177

UPDATE pieces piece
SET piece.title = 'Gloria, for Soprano, Chorus and Orchestra, FP 177', piece.title_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7634 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gloria', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: I. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:dfde29b4-1d11-4747-9a5e-ef10eb61b754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfde29b4-1d11-4747-9a5e-ef10eb61b754', 1, 'I', 'Gloria', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: I. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfde29b4-1d11-4747-9a5e-ef10eb61b754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Laudamus te', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: II. Laudamus te',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:41ce54c5-a87d-411d-9abd-0efdda6e5bb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ce54c5-a87d-411d-9abd-0efdda6e5bb9', 2, 'II', 'Laudamus te', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: II. Laudamus te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ce54c5-a87d-411d-9abd-0efdda6e5bb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Domine Deus', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: III. Domine Deus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:280eb43e-24f0-4538-bd94-58690e0a6119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:280eb43e-24f0-4538-bd94-58690e0a6119', 3, 'III', 'Domine Deus', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: III. Domine Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:280eb43e-24f0-4538-bd94-58690e0a6119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Domine Fili unigenite', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: IV. Domine Fili unigenite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d5f5b05c-73b2-4dc2-b284-0aeba1b3f475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5f5b05c-73b2-4dc2-b284-0aeba1b3f475', 4, 'IV', 'Domine Fili unigenite', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: IV. Domine Fili unigenite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5f5b05c-73b2-4dc2-b284-0aeba1b3f475'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Domine Deus, Agnus Dei', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: V. Domine Deus, Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:201e17e0-6c87-4b8f-963f-6383129af4e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:201e17e0-6c87-4b8f-963f-6383129af4e5', 5, 'V', 'Domine Deus, Agnus Dei', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: V. Domine Deus, Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:201e17e0-6c87-4b8f-963f-6383129af4e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Qui sedes ad dexteram Patris', part.name_en = 'Gloria, for Soprano, Chorus and Orchestra, FP 177: VI. Qui sedes ad dexteram Patris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7634 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:25a3780e-36cc-4496-afec-b31cee06aa5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25a3780e-36cc-4496-afec-b31cee06aa5d', 6, 'VI', 'Qui sedes ad dexteram Patris', 'Gloria, for Soprano, Chorus and Orchestra, FP 177: VI. Qui sedes ad dexteram Patris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7634 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a3780e-36cc-4496-afec-b31cee06aa5d'
);


-- None Huit chansons polonaises, FP 69

UPDATE pieces piece
SET piece.title = 'Huit chansons polonaises, FP 69', piece.title_en = 'Huit chansons polonaises, FP 69',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10644 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wianek', part.name_en = 'Huit chansons polonaises, FP 69: 1. Wianek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c33cf826-3e1f-4ad0-872c-a3d298f11b8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c33cf826-3e1f-4ad0-872c-a3d298f11b8c', 1, NULL, 'Wianek', 'Huit chansons polonaises, FP 69: 1. Wianek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c33cf826-3e1f-4ad0-872c-a3d298f11b8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Odjazd', part.name_en = 'Huit chansons polonaises, FP 69: 2. Odjazd',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ecd69f8d-8e5c-4819-9813-593e12f9932a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecd69f8d-8e5c-4819-9813-593e12f9932a', 2, NULL, 'Odjazd', 'Huit chansons polonaises, FP 69: 2. Odjazd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecd69f8d-8e5c-4819-9813-593e12f9932a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Polska młodzież', part.name_en = 'Huit chansons polonaises, FP 69: 3. Polska młodzież',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2c9ad0b2-3922-44a7-911c-0caf6e7cb58e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9ad0b2-3922-44a7-911c-0caf6e7cb58e', 3, NULL, 'Polska młodzież', 'Huit chansons polonaises, FP 69: 3. Polska młodzież', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9ad0b2-3922-44a7-911c-0caf6e7cb58e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ostatni mazur', part.name_en = 'Huit chansons polonaises, FP 69: 4. Ostatni mazur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5f06daa2-78bf-4945-9b44-557208d36760' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f06daa2-78bf-4945-9b44-557208d36760', 4, NULL, 'Ostatni mazur', 'Huit chansons polonaises, FP 69: 4. Ostatni mazur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f06daa2-78bf-4945-9b44-557208d36760'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pożegnanie', part.name_en = 'Huit chansons polonaises, FP 69: 5. Pożegnanie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:04418d14-18b7-4ff8-b9e2-3c083f09ffda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04418d14-18b7-4ff8-b9e2-3c083f09ffda', 5, NULL, 'Pożegnanie', 'Huit chansons polonaises, FP 69: 5. Pożegnanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04418d14-18b7-4ff8-b9e2-3c083f09ffda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Biała chorągiewka', part.name_en = 'Huit chansons polonaises, FP 69: 6. Biała chorągiewka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7d90cb9c-4418-40c4-8e2d-bd36c8e0c1af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d90cb9c-4418-40c4-8e2d-bd36c8e0c1af', 6, NULL, 'Biała chorągiewka', 'Huit chansons polonaises, FP 69: 6. Biała chorągiewka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d90cb9c-4418-40c4-8e2d-bd36c8e0c1af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Wisła', part.name_en = 'Huit chansons polonaises, FP 69: 7. Wisła',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4adc03f4-8944-4138-9dc3-806b2f124b75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4adc03f4-8944-4138-9dc3-806b2f124b75', 7, NULL, 'Wisła', 'Huit chansons polonaises, FP 69: 7. Wisła', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4adc03f4-8944-4138-9dc3-806b2f124b75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Jezioro', part.name_en = 'Huit chansons polonaises, FP 69: 8. Jezioro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10644 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:59262ab4-351c-4cda-85ca-d6217a060348' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59262ab4-351c-4cda-85ca-d6217a060348', 8, NULL, 'Jezioro', 'Huit chansons polonaises, FP 69: 8. Jezioro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10644 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59262ab4-351c-4cda-85ca-d6217a060348'
);


-- None Humoresque for piano, FP 72

UPDATE pieces piece
SET piece.title = 'Humoresque for piano, FP 72', piece.title_en = 'Humoresque for piano, FP 72',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7745 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hymne, FP 144>

UPDATE pieces piece
SET piece.title = '가곡 <Hymne, FP 144>', piece.title_en = 'Hymne, FP 144',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10365 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvisations (15) for piano, FP 63, 113, 170, 176

UPDATE pieces piece
SET piece.title = 'Improvisations (15) for piano, FP 63, 113, 170, 176', piece.title_en = 'Improvisations (15) for piano, FP 63, 113, 170, 176',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10858 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '10 Improvisations, FP 63', part.name_en = '10 Improvisations, FP 63',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd', 1, NULL, '10 Improvisations, FP 63', '10 Improvisations, FP 63', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 1 in B minor', part.name_en = 'Improvisation no. 1 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ba34d021-56ce-4b22-8835-2b72bab61031' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba34d021-56ce-4b22-8835-2b72bab61031', 1, NULL, 'Improvisation no. 1 in B minor', 'Improvisation no. 1 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba34d021-56ce-4b22-8835-2b72bab61031'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 2 in A-flat major', part.name_en = 'Improvisation no. 2 in A-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:23ce53d3-6387-4982-9e09-cb5dc6ee9682' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23ce53d3-6387-4982-9e09-cb5dc6ee9682', 2, NULL, 'Improvisation no. 2 in A-flat major', 'Improvisation no. 2 in A-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ce53d3-6387-4982-9e09-cb5dc6ee9682'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 3 in B minor', part.name_en = 'Improvisation no. 3 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ef9c1f6d-4307-454a-929d-d31a31699b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef9c1f6d-4307-454a-929d-d31a31699b35', 3, NULL, 'Improvisation no. 3 in B minor', 'Improvisation no. 3 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9c1f6d-4307-454a-929d-d31a31699b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 4 in A-flat major', part.name_en = 'Improvisation no. 4 in A-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6957ad46-5828-4b6e-848e-a93f1179da4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6957ad46-5828-4b6e-848e-a93f1179da4e', 4, NULL, 'Improvisation no. 4 in A-flat major', 'Improvisation no. 4 in A-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6957ad46-5828-4b6e-848e-a93f1179da4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 5 in A minor', part.name_en = 'Improvisation no. 5 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7024e82d-4dd6-472a-83e0-3df5032d1ca7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7024e82d-4dd6-472a-83e0-3df5032d1ca7', 5, NULL, 'Improvisation no. 5 in A minor', 'Improvisation no. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7024e82d-4dd6-472a-83e0-3df5032d1ca7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 6 in B-flat major', part.name_en = 'Improvisation no. 6 in B-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1edb7a23-78eb-4d8e-955b-ebb6725e31ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1edb7a23-78eb-4d8e-955b-ebb6725e31ca', 6, NULL, 'Improvisation no. 6 in B-flat major', 'Improvisation no. 6 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1edb7a23-78eb-4d8e-955b-ebb6725e31ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 7 in C major', part.name_en = 'Improvisation no. 7 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:dce9b284-d420-4a5a-b671-fbfd4c1c06e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dce9b284-d420-4a5a-b671-fbfd4c1c06e8', 7, NULL, 'Improvisation no. 7 in C major', 'Improvisation no. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce9b284-d420-4a5a-b671-fbfd4c1c06e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 8 in A minor', part.name_en = 'Improvisation no. 8 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:46b6e233-424a-425e-b3d1-da0afaad5816' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46b6e233-424a-425e-b3d1-da0afaad5816', 8, NULL, 'Improvisation no. 8 in A minor', 'Improvisation no. 8 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b6e233-424a-425e-b3d1-da0afaad5816'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 9 in D major', part.name_en = 'Improvisation no. 9 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7179e03e-7ade-4bb3-9c9f-9696b7c1abaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7179e03e-7ade-4bb3-9c9f-9696b7c1abaf', 9, NULL, 'Improvisation no. 9 in D major', 'Improvisation no. 9 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7179e03e-7ade-4bb3-9c9f-9696b7c1abaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 10 in F major (Eloge des gammes)', part.name_en = 'Improvisation no. 10 in F major (Eloge des gammes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d52a0dcb-76d0-4341-b9c9-1d9867f7100b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d52a0dcb-76d0-4341-b9c9-1d9867f7100b', 10, NULL, 'Improvisation no. 10 in F major (Eloge des gammes)', 'Improvisation no. 10 in F major (Eloge des gammes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae73c1ae-b9b2-444b-8010-f698e07c2afd'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d52a0dcb-76d0-4341-b9c9-1d9867f7100b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 15 in C minor ("Hommage à Edith Piaf")', part.name_en = 'Improvisation no. 15 in C minor ("Hommage à Edith Piaf")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d00684fd-5c94-4919-a537-573423861046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d00684fd-5c94-4919-a537-573423861046', 2, NULL, 'Improvisation no. 15 in C minor ("Hommage à Edith Piaf")', 'Improvisation no. 15 in C minor ("Hommage à Edith Piaf")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d00684fd-5c94-4919-a537-573423861046'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '2 Improvisations, FP 113', part.name_en = '2 Improvisations, FP 113',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862', 3, NULL, '2 Improvisations, FP 113', '2 Improvisations, FP 113', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 11 in G minor', part.name_en = 'Improvisation no. 11 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bc1a6f9a-6602-485f-a20e-b85dd951d148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc1a6f9a-6602-485f-a20e-b85dd951d148', 1, NULL, 'Improvisation no. 11 in G minor', 'Improvisation no. 11 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc1a6f9a-6602-485f-a20e-b85dd951d148'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 12 in E-flat major ("Hommage à Schubert")', part.name_en = 'Improvisation no. 12 in E-flat major ("Hommage à Schubert")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e3626698-8327-47ed-9f80-a79a07218b05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3626698-8327-47ed-9f80-a79a07218b05', 2, NULL, 'Improvisation no. 12 in E-flat major ("Hommage à Schubert")', 'Improvisation no. 12 in E-flat major ("Hommage à Schubert")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e67cddad-4789-4deb-b927-daf84e128862'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3626698-8327-47ed-9f80-a79a07218b05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '2 Improvisations, FP 170', part.name_en = '2 Improvisations, FP 170',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859', 4, NULL, '2 Improvisations, FP 170', '2 Improvisations, FP 170', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 13 in A minor', part.name_en = 'Improvisation no. 13 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:89b4142a-24a7-4d17-acca-5c3954c00e41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89b4142a-24a7-4d17-acca-5c3954c00e41', 1, NULL, 'Improvisation no. 13 in A minor', 'Improvisation no. 13 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89b4142a-24a7-4d17-acca-5c3954c00e41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Improvisation no. 14 in D-flat major', part.name_en = 'Improvisation no. 14 in D-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10858 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d49ecc45-b454-422f-946b-93ef1cfbf953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d49ecc45-b454-422f-946b-93ef1cfbf953', 2, NULL, 'Improvisation no. 14 in D-flat major', 'Improvisation no. 14 in D-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f9eea7d9-082f-4d9f-b802-4a5225bcd859'
WHERE p.id = 10858 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d49ecc45-b454-422f-946b-93ef1cfbf953'
);


-- None L'Embarquement pour Cythère, FP 150

UPDATE pieces piece
SET piece.title = 'L''Embarquement pour Cythère, FP 150', piece.title_en = 'L''Embarquement pour Cythère, FP 150',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9245 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <L'Invitation au château, FP 138>

UPDATE pieces piece
SET piece.title = '부수음악 <L''Invitation au château, FP 138>', piece.title_en = 'L''Invitation au château, FP 138',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10954 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Follement vite et gai', part.name_en = 'L''invitation au château, FP. 138: XVI. Follement vite et gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:199e5067-f893-4a21-b29d-d673befc6358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:199e5067-f893-4a21-b29d-d673befc6358', 1, NULL, 'Follement vite et gai', 'L''invitation au château, FP. 138: XVI. Follement vite et gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199e5067-f893-4a21-b29d-d673befc6358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Très vite et très canaille', part.name_en = 'L''invitation au château, FP. 138: XII. Très vite et très canaille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:256e3089-2b42-4253-acea-ebdd0d57e594' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:256e3089-2b42-4253-acea-ebdd0d57e594', 2, NULL, 'Très vite et très canaille', 'L''invitation au château, FP. 138: XII. Très vite et très canaille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:256e3089-2b42-4253-acea-ebdd0d57e594'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tempo di Boston', part.name_en = 'L''invitation au château, FP. 138: VIII. Tempo di Boston',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:27d893c5-7e0a-481a-83cd-ecc8f2de5b84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27d893c5-7e0a-481a-83cd-ecc8f2de5b84', 3, NULL, 'Tempo di Boston', 'L''invitation au château, FP. 138: VIII. Tempo di Boston', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27d893c5-7e0a-481a-83cd-ecc8f2de5b84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mouvement de valse-hésitation', part.name_en = 'L''invitation au château, FP. 138: IV. Mouvement de valse-hésitation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ad359f20-bd9b-4b05-bd13-571eeb23e17c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad359f20-bd9b-4b05-bd13-571eeb23e17c', 4, NULL, 'Mouvement de valse-hésitation', 'L''invitation au château, FP. 138: IV. Mouvement de valse-hésitation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad359f20-bd9b-4b05-bd13-571eeb23e17c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tempo di Tarantella', part.name_en = 'L''invitation au château, FP. 138: XIII. Tempo di Tarantella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d0db26e1-771d-4afd-adf4-e6ed28b2075c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0db26e1-771d-4afd-adf4-e6ed28b2075c', 5, NULL, 'Tempo di Tarantella', 'L''invitation au château, FP. 138: XIII. Tempo di Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0db26e1-771d-4afd-adf4-e6ed28b2075c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tango', part.name_en = 'L''Invitation au Château : Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10954 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f9428ded-bf59-3c21-a934-a6c4fc30fd25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9428ded-bf59-3c21-a934-a6c4fc30fd25', 6, NULL, 'Tango', 'L''Invitation au Château : Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10954 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9428ded-bf59-3c21-a934-a6c4fc30fd25'
);


-- None 연가곡집 <La Courte Paille, FP 178>

UPDATE pieces piece
SET piece.title = '연가곡집 <La Courte Paille, FP 178>', piece.title_en = 'La Courte Paille, FP 178',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10969 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 1. Le Sommeil', part.name_en = 'La Courte Paille, FP 178. 1. Le Sommeil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b5511771-b4ad-42b3-a588-cc686b1c3f99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5511771-b4ad-42b3-a588-cc686b1c3f99', 1, NULL, 'La Courte Paille, FP 178. 1. Le Sommeil', 'La Courte Paille, FP 178. 1. Le Sommeil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5511771-b4ad-42b3-a588-cc686b1c3f99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 2. Quelle aventure !', part.name_en = 'La Courte Paille, FP 178. 2. Quelle aventure !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7e99e314-b411-470d-b5e5-237a8bf72914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e99e314-b411-470d-b5e5-237a8bf72914', 2, NULL, 'La Courte Paille, FP 178. 2. Quelle aventure !', 'La Courte Paille, FP 178. 2. Quelle aventure !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e99e314-b411-470d-b5e5-237a8bf72914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 3. La Reine de cœur', part.name_en = 'La Courte Paille, FP 178. 3. La Reine de cœur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fdb67a98-7443-4246-80ae-4f3327d016a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdb67a98-7443-4246-80ae-4f3327d016a3', 3, NULL, 'La Courte Paille, FP 178. 3. La Reine de cœur', 'La Courte Paille, FP 178. 3. La Reine de cœur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdb67a98-7443-4246-80ae-4f3327d016a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 4. Ba, be, bi, bo, bu', part.name_en = 'La Courte Paille, FP 178. 4. Ba, be, bi, bo, bu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:82b59429-2b34-420f-ade8-8b2f08267bb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b59429-2b34-420f-ade8-8b2f08267bb9', 4, NULL, 'La Courte Paille, FP 178. 4. Ba, be, bi, bo, bu', 'La Courte Paille, FP 178. 4. Ba, be, bi, bo, bu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b59429-2b34-420f-ade8-8b2f08267bb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 5. Les Anges musiciens', part.name_en = 'La Courte Paille, FP 178. 5. Les Anges musiciens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:760a2c4f-3b80-41a0-abb2-6e2b2b5fcf5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:760a2c4f-3b80-41a0-abb2-6e2b2b5fcf5c', 5, NULL, 'La Courte Paille, FP 178. 5. Les Anges musiciens', 'La Courte Paille, FP 178. 5. Les Anges musiciens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:760a2c4f-3b80-41a0-abb2-6e2b2b5fcf5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 6. Le Carafon', part.name_en = 'La Courte Paille, FP 178. 6. Le Carafon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1ca134d3-3476-4174-80d3-68b0d17ab61b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ca134d3-3476-4174-80d3-68b0d17ab61b', 6, NULL, 'La Courte Paille, FP 178. 6. Le Carafon', 'La Courte Paille, FP 178. 6. Le Carafon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca134d3-3476-4174-80d3-68b0d17ab61b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La Courte Paille, FP 178. 7. Lune d''avril', part.name_en = 'La Courte Paille, FP 178. 7. Lune d''avril',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10969 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a5e6e7d0-e29a-48f3-b54e-7ccae090f473' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e6e7d0-e29a-48f3-b54e-7ccae090f473', 7, NULL, 'La Courte Paille, FP 178. 7. Lune d''avril', 'La Courte Paille, FP 178. 7. Lune d''avril', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10969 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e6e7d0-e29a-48f3-b54e-7ccae090f473'
);


-- None 가곡 <La Reine de Saba>

UPDATE pieces piece
SET piece.title = '가곡 <La Reine de Saba>', piece.title_en = 'La Reine de Saba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8851 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <La fraîcheur et le feu, FP 147>

UPDATE pieces piece
SET piece.title = '연가곡집 <La fraîcheur et le feu, FP 147>', piece.title_en = 'La fraîcheur et le feu, FP 147',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10891 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rayons des yeux', part.name_en = 'La fraîcheur et le feu, FP 147: 1. Rayons des yeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bfab5cc3-83e1-462a-9265-6cae606ce1f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfab5cc3-83e1-462a-9265-6cae606ce1f3', 1, NULL, 'Rayons des yeux', 'La fraîcheur et le feu, FP 147: 1. Rayons des yeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfab5cc3-83e1-462a-9265-6cae606ce1f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le matin les branches attisent', part.name_en = 'La fraîcheur et le feu, FP 147: 2. Le matin les branches attisent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2429d942-10a2-4bcb-9d49-b1e0056b102f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2429d942-10a2-4bcb-9d49-b1e0056b102f', 2, NULL, 'Le matin les branches attisent', 'La fraîcheur et le feu, FP 147: 2. Le matin les branches attisent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2429d942-10a2-4bcb-9d49-b1e0056b102f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tout disparut', part.name_en = 'La fraîcheur et le feu, FP 147: 3. Tout disparut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:50521edd-2d5d-4dd7-a695-dcd3813b2289' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50521edd-2d5d-4dd7-a695-dcd3813b2289', 3, NULL, 'Tout disparut', 'La fraîcheur et le feu, FP 147: 3. Tout disparut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50521edd-2d5d-4dd7-a695-dcd3813b2289'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dans les ténèbres du jardin', part.name_en = 'La fraîcheur et le feu, FP 147: 4. Dans les ténèbres du jardin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:836111e6-83a1-4051-b779-3449bd7a0f4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:836111e6-83a1-4051-b779-3449bd7a0f4d', 4, NULL, 'Dans les ténèbres du jardin', 'La fraîcheur et le feu, FP 147: 4. Dans les ténèbres du jardin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:836111e6-83a1-4051-b779-3449bd7a0f4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Unis la fraîcheur et le feu', part.name_en = 'La fraîcheur et le feu, FP 147: 5. Unis la fraîcheur et le feu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e59c26b8-b3b8-480b-9184-25da17dc82af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e59c26b8-b3b8-480b-9184-25da17dc82af', 5, NULL, 'Unis la fraîcheur et le feu', 'La fraîcheur et le feu, FP 147: 5. Unis la fraîcheur et le feu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e59c26b8-b3b8-480b-9184-25da17dc82af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Homme au sourire tendre', part.name_en = 'La fraîcheur et le feu, FP 147: 6. Homme au sourire tendre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:18af5052-4d08-4431-9611-035e21e04d12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18af5052-4d08-4431-9611-035e21e04d12', 6, NULL, 'Homme au sourire tendre', 'La fraîcheur et le feu, FP 147: 6. Homme au sourire tendre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18af5052-4d08-4431-9611-035e21e04d12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La grande rivière qui va', part.name_en = 'La fraîcheur et le feu, FP 147: 7. La grande rivière qui va',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10891 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1dec9f57-80e8-401e-85f0-c66c716b8865' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dec9f57-80e8-401e-85f0-c66c716b8865', 7, NULL, 'La grande rivière qui va', 'La fraîcheur et le feu, FP 147: 7. La grande rivière qui va', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10891 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dec9f57-80e8-401e-85f0-c66c716b8865'
);


-- None 가곡 <La grenouillère, FP 96>

UPDATE pieces piece
SET piece.title = '가곡 <La grenouillère, FP 96>', piece.title_en = 'La grenouillère, FP 96',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8385 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La puce>

UPDATE pieces piece
SET piece.title = '가곡 <La puce>', piece.title_en = 'La puce',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10944 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laudes de Saint Antoine de Padoue, FP 172

UPDATE pieces piece
SET piece.title = 'Laudes de Saint Antoine de Padoue, FP 172', piece.title_en = 'Laudes de Saint Antoine de Padoue, FP 172',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10899 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O Jésu', part.name_en = 'Laudes de Saint Antoine de Padoue: I. O Jésu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a3b72e91-7113-4e34-9759-bc488cde9104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3b72e91-7113-4e34-9759-bc488cde9104', 1, 'I', 'O Jésu', 'Laudes de Saint Antoine de Padoue: I. O Jésu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b72e91-7113-4e34-9759-bc488cde9104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'O proles', part.name_en = 'Laudes de Saint Antoine de Padoue: II. O proles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:51241833-659a-413a-be00-056901b6b67c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51241833-659a-413a-be00-056901b6b67c', 2, 'II', 'O proles', 'Laudes de Saint Antoine de Padoue: II. O proles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51241833-659a-413a-be00-056901b6b67c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Laus regi', part.name_en = 'Laudes de Saint Antoine de Padoue: III. Laus regi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:eb4f1464-60d1-49c5-9e46-e03dc017991a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb4f1464-60d1-49c5-9e46-e03dc017991a', 3, 'III', 'Laus regi', 'Laudes de Saint Antoine de Padoue: III. Laus regi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb4f1464-60d1-49c5-9e46-e03dc017991a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Si quaeris', part.name_en = 'Laudes de Saint Antoine de Padoue: IV. Si quaeris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:132abe1d-a21d-4702-a880-5e307b2ba9a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:132abe1d-a21d-4702-a880-5e307b2ba9a3', 4, 'IV', 'Si quaeris', 'Laudes de Saint Antoine de Padoue: IV. Si quaeris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:132abe1d-a21d-4702-a880-5e307b2ba9a3'
);


-- None 가곡 <Le Disparu, FP 134>

UPDATE pieces piece
SET piece.title = '가곡 <Le Disparu, FP 134>', piece.title_en = 'Le Disparu, FP 134',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9228 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Gendarme incompris, FP 20a

UPDATE pieces piece
SET piece.title = 'Le Gendarme incompris, FP 20a', piece.title_en = 'Le Gendarme incompris, FP 20a',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9323 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Le Voyage en Amérique, Original Film Score FP 149>

UPDATE pieces piece
SET piece.title = '영화음악 <Le Voyage en Amérique, Original Film Score FP 149>', piece.title_en = 'Le Voyage en Amérique, Original Film Score FP 149',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9144 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Valse for Accordion', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: Valse for Accordion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6e971d18-f855-487a-9bbf-37687e0ab956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e971d18-f855-487a-9bbf-37687e0ab956', 1, NULL, 'Valse for Accordion', 'Le Voyage en Amérique, Original Film Score FP 149: Valse for Accordion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e971d18-f855-487a-9bbf-37687e0ab956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '8', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0abeb651-6c5f-43da-8499-272d03f4bd46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0abeb651-6c5f-43da-8499-272d03f4bd46', 2, NULL, '8', 'Le Voyage en Amérique, Original Film Score FP 149: 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0abeb651-6c5f-43da-8499-272d03f4bd46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '6', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:15f9be63-1b21-4ce3-a642-251cf9fb872d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f9be63-1b21-4ce3-a642-251cf9fb872d', 3, NULL, '6', 'Le Voyage en Amérique, Original Film Score FP 149: 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f9be63-1b21-4ce3-a642-251cf9fb872d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '7', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:162e4fc5-beea-4999-82a6-da1429a1a6bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:162e4fc5-beea-4999-82a6-da1429a1a6bd', 4, NULL, '7', 'Le Voyage en Amérique, Original Film Score FP 149: 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:162e4fc5-beea-4999-82a6-da1429a1a6bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '10', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:389c7cca-4306-41f1-a99a-5c8c4073c960' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389c7cca-4306-41f1-a99a-5c8c4073c960', 5, NULL, '10', 'Le Voyage en Amérique, Original Film Score FP 149: 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389c7cca-4306-41f1-a99a-5c8c4073c960'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '1b', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 1b',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4fe0fabc-07ff-4b31-b6d5-1a48e15ff2ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fe0fabc-07ff-4b31-b6d5-1a48e15ff2ce', 6, NULL, '1b', 'Le Voyage en Amérique, Original Film Score FP 149: 1b', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fe0fabc-07ff-4b31-b6d5-1a48e15ff2ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:59c3895b-7e02-4b25-bf4c-14c01811ae01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c3895b-7e02-4b25-bf4c-14c01811ae01', 7, NULL, '3', 'Le Voyage en Amérique, Original Film Score FP 149: 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c3895b-7e02-4b25-bf4c-14c01811ae01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:664129f5-e15d-46b9-856e-d9bf5da7a515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:664129f5-e15d-46b9-856e-d9bf5da7a515', 8, NULL, '2', 'Le Voyage en Amérique, Original Film Score FP 149: 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:664129f5-e15d-46b9-856e-d9bf5da7a515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '9', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6ccd2f27-5022-46cd-ac9d-a240771e9150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ccd2f27-5022-46cd-ac9d-a240771e9150', 9, NULL, '9', 'Le Voyage en Amérique, Original Film Score FP 149: 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ccd2f27-5022-46cd-ac9d-a240771e9150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '12', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6d05de4f-f91e-4315-9da4-fbc5d0438fdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d05de4f-f91e-4315-9da4-fbc5d0438fdc', 10, NULL, '12', 'Le Voyage en Amérique, Original Film Score FP 149: 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d05de4f-f91e-4315-9da4-fbc5d0438fdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:80e5c881-7aac-4419-b750-668d69b6a994' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80e5c881-7aac-4419-b750-668d69b6a994', 11, NULL, '5', 'Le Voyage en Amérique, Original Film Score FP 149: 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e5c881-7aac-4419-b750-668d69b6a994'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:831abd0c-2cb7-436f-ae7c-93375b65bc3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:831abd0c-2cb7-436f-ae7c-93375b65bc3e', 12, NULL, '4', 'Le Voyage en Amérique, Original Film Score FP 149: 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:831abd0c-2cb7-436f-ae7c-93375b65bc3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '11', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ac8e2785-15f1-4382-91e6-14a8d11c4ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac8e2785-15f1-4382-91e6-14a8d11c4ea1', 13, NULL, '11', 'Le Voyage en Amérique, Original Film Score FP 149: 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac8e2785-15f1-4382-91e6-14a8d11c4ea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '14', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b1fbf5fe-b052-4b0f-9c7e-ce82353336b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1fbf5fe-b052-4b0f-9c7e-ce82353336b5', 14, NULL, '14', 'Le Voyage en Amérique, Original Film Score FP 149: 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1fbf5fe-b052-4b0f-9c7e-ce82353336b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '13', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b328dfe0-e134-45d2-bb4a-4325db15b3ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b328dfe0-e134-45d2-bb4a-4325db15b3ab', 15, NULL, '13', 'Le Voyage en Amérique, Original Film Score FP 149: 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b328dfe0-e134-45d2-bb4a-4325db15b3ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '1a', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 1a',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bff0bf73-0af4-4933-94ec-370acec2dc67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff0bf73-0af4-4933-94ec-370acec2dc67', 16, NULL, '1a', 'Le Voyage en Amérique, Original Film Score FP 149: 1a', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff0bf73-0af4-4933-94ec-370acec2dc67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '15', part.name_en = 'Le Voyage en Amérique, Original Film Score FP 149: 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d19afd4b-b4d1-41e5-b1f1-ea94e8a7d69e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d19afd4b-b4d1-41e5-b1f1-ea94e8a7d69e', 17, NULL, '15', 'Le Voyage en Amérique, Original Film Score FP 149: 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d19afd4b-b4d1-41e5-b1f1-ea94e8a7d69e'
);


-- None 칸타타 <Le bal masqué, FP 60>

UPDATE pieces piece
SET piece.title = '칸타타 <Le bal masqué, FP 60>', piece.title_en = 'Le bal masqué, FP 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9922 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Préambule et air de bravoure', part.name_en = 'Le bal masqué: Préambule et air de bravoure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cbf4c40e-bf02-3eca-8e58-2110239e6737' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf4c40e-bf02-3eca-8e58-2110239e6737', 1, NULL, 'Préambule et air de bravoure', 'Le bal masqué: Préambule et air de bravoure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf4c40e-bf02-3eca-8e58-2110239e6737'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Intermède', part.name_en = 'Le bal masqué: Intermède',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d899ee05-6b80-36aa-9497-0c4ab468d602' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d899ee05-6b80-36aa-9497-0c4ab468d602', 2, NULL, 'Intermède', 'Le bal masqué: Intermède', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d899ee05-6b80-36aa-9497-0c4ab468d602'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Malvina', part.name_en = 'Le bal masqué: Malvina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ec01d36e-5a94-3851-ab7b-4f0664b25666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec01d36e-5a94-3851-ab7b-4f0664b25666', 3, NULL, 'Malvina', 'Le bal masqué: Malvina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec01d36e-5a94-3851-ab7b-4f0664b25666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Bagatelle', part.name_en = 'Le bal masqué: Bagatelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:00be1373-2aa6-3c87-9709-1da1fb054814' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00be1373-2aa6-3c87-9709-1da1fb054814', 4, NULL, 'Bagatelle', 'Le bal masqué: Bagatelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00be1373-2aa6-3c87-9709-1da1fb054814'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La dame aveugle', part.name_en = 'Le bal masqué: La dame aveugle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1f6f460b-05c7-37f7-8b11-e940caadf662' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f6f460b-05c7-37f7-8b11-e940caadf662', 5, NULL, 'La dame aveugle', 'Le bal masqué: La dame aveugle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f6f460b-05c7-37f7-8b11-e940caadf662'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Le bal masqué: Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9922 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c8ce2641-d53f-3976-a113-df655cb2a0cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ce2641-d53f-3976-a113-df655cb2a0cc', 6, NULL, 'Finale', 'Le bal masqué: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9922 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ce2641-d53f-3976-a113-df655cb2a0cc'
);


-- None 연가곡집 <Le bestiaire, ou Cortège d'Orphée, FP 15a>

UPDATE pieces piece
SET piece.title = '연가곡집 <Le bestiaire, ou Cortège d''Orphée, FP 15a>', piece.title_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11283 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le dromadaire', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 1. Le dromadaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0c568bce-94c0-4539-99f3-3f8547e1bad7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c568bce-94c0-4539-99f3-3f8547e1bad7', 1, NULL, 'Le dromadaire', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 1. Le dromadaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c568bce-94c0-4539-99f3-3f8547e1bad7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La chèvre du Thibet', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 2. La chèvre du Thibet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d6b84325-5c0e-454f-8ca7-ac4221d0e313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b84325-5c0e-454f-8ca7-ac4221d0e313', 2, NULL, 'La chèvre du Thibet', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 2. La chèvre du Thibet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b84325-5c0e-454f-8ca7-ac4221d0e313'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La sauterelle', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 3. La sauterelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3871a2ce-e537-499a-a241-5b19f646ce88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3871a2ce-e537-499a-a241-5b19f646ce88', 3, NULL, 'La sauterelle', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 3. La sauterelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3871a2ce-e537-499a-a241-5b19f646ce88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le dauphin', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 4. Le dauphin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bff4269d-e032-4bd9-a506-0144967df046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff4269d-e032-4bd9-a506-0144967df046', 4, NULL, 'Le dauphin', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 4. Le dauphin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff4269d-e032-4bd9-a506-0144967df046'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'L''écrevisse', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 5. L''écrevisse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8559172e-99aa-4b70-9ba6-026135ff80a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8559172e-99aa-4b70-9ba6-026135ff80a9', 5, NULL, 'L''écrevisse', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 5. L''écrevisse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8559172e-99aa-4b70-9ba6-026135ff80a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La carpe', part.name_en = 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 6. La carpe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11283 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3984f89a-3454-4608-8dd1-2f73741d9158' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3984f89a-3454-4608-8dd1-2f73741d9158', 6, NULL, 'La carpe', 'Le bestiaire, ou Cortège d''Orphée, FP 15a: 6. La carpe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11283 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3984f89a-3454-4608-8dd1-2f73741d9158'
);


-- None 가곡 <Le portrait, FP 92>

UPDATE pieces piece
SET piece.title = '가곡 <Le portrait, FP 92>', piece.title_en = 'Le portrait, FP 92',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9345 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Le travail du peintre, FP 161>

UPDATE pieces piece
SET piece.title = '연가곡집 <Le travail du peintre, FP 161>', piece.title_en = 'Le travail du peintre, FP 161',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9354 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pablo Picasso', part.name_en = 'Le travail du peintre, FP 161: 1. Pablo Picasso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3eab0cd2-51e0-4020-bf86-145366d7c868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eab0cd2-51e0-4020-bf86-145366d7c868', 1, NULL, 'Pablo Picasso', 'Le travail du peintre, FP 161: 1. Pablo Picasso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eab0cd2-51e0-4020-bf86-145366d7c868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marc Chagall', part.name_en = 'Le travail du peintre, FP 161: 2. Marc Chagall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d5df9a9b-1989-4c29-93da-0e8f1bc77e61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5df9a9b-1989-4c29-93da-0e8f1bc77e61', 2, NULL, 'Marc Chagall', 'Le travail du peintre, FP 161: 2. Marc Chagall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5df9a9b-1989-4c29-93da-0e8f1bc77e61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Georges Braque', part.name_en = 'Le travail du peintre, FP 161: 3. Georges Braque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:53402d4e-7a4e-4233-9f05-e1326940a125' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53402d4e-7a4e-4233-9f05-e1326940a125', 3, NULL, 'Georges Braque', 'Le travail du peintre, FP 161: 3. Georges Braque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53402d4e-7a4e-4233-9f05-e1326940a125'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Juan Gris', part.name_en = 'Le travail du peintre, FP 161: 4. Juan Gris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:330346db-895a-4e2d-8167-305a46890450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:330346db-895a-4e2d-8167-305a46890450', 4, NULL, 'Juan Gris', 'Le travail du peintre, FP 161: 4. Juan Gris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330346db-895a-4e2d-8167-305a46890450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Paul Klee', part.name_en = 'Le travail du peintre, FP 161: 5. Paul Klee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4b0772a3-6f26-40e6-9352-7a2e34462488' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0772a3-6f26-40e6-9352-7a2e34462488', 5, NULL, 'Paul Klee', 'Le travail du peintre, FP 161: 5. Paul Klee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0772a3-6f26-40e6-9352-7a2e34462488'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Joan Miró', part.name_en = 'Le travail du peintre, FP 161: 6. Joan Miró',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a631e5a2-69e8-4d83-a43b-d0d6c91e5df0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a631e5a2-69e8-4d83-a43b-d0d6c91e5df0', 6, NULL, 'Joan Miró', 'Le travail du peintre, FP 161: 6. Joan Miró', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a631e5a2-69e8-4d83-a43b-d0d6c91e5df0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jacques Villon', part.name_en = 'Le travail du peintre, FP 161: 7. Jacques Villon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9354 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:29280ea3-9450-457e-863a-72dea2049afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29280ea3-9450-457e-863a-72dea2049afd', 7, NULL, 'Jacques Villon', 'Le travail du peintre, FP 161: 7. Jacques Villon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9354 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29280ea3-9450-457e-863a-72dea2049afd'
);


-- None 발레 <Les Animaux modèles, FP 111>

UPDATE pieces piece
SET piece.title = '발레 <Les Animaux modèles, FP 111>', piece.title_en = 'Les Animaux modèles, FP 111',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11085 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le Petit Jour', part.name_en = 'Les Animaux modèles, FP 111: I. Le Petit Jour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:416a82e4-b5ee-4cb8-92be-e1a6113a16ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416a82e4-b5ee-4cb8-92be-e1a6113a16ea', 1, 'I', 'Le Petit Jour', 'Les Animaux modèles, FP 111: I. Le Petit Jour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416a82e4-b5ee-4cb8-92be-e1a6113a16ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'L''ours et les deux compagnons. Très animé', part.name_en = 'Les Animaux modèles, FP 111: II. L''ours et les deux compagnons. Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:309992d0-4d2f-454b-87f0-556039e42f74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:309992d0-4d2f-454b-87f0-556039e42f74', 2, 'II', 'L''ours et les deux compagnons. Très animé', 'Les Animaux modèles, FP 111: II. L''ours et les deux compagnons. Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:309992d0-4d2f-454b-87f0-556039e42f74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Cigale et la Fourmi', part.name_en = 'Les Animaux modèles, FP 111: III. La Cigale et la Fourmi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4aefdeab-4a0f-473a-9a92-dc99e7ade004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aefdeab-4a0f-473a-9a92-dc99e7ade004', 3, 'III', 'La Cigale et la Fourmi', 'Les Animaux modèles, FP 111: III. La Cigale et la Fourmi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aefdeab-4a0f-473a-9a92-dc99e7ade004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le Lion Amoureux', part.name_en = 'Les Animaux modèles, FP 111: IV. Le Lion Amoureux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e6ce3562-ea0f-4b43-87de-0ed381056b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6ce3562-ea0f-4b43-87de-0ed381056b42', 4, 'IV', 'Le Lion Amoureux', 'Les Animaux modèles, FP 111: IV. Le Lion Amoureux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6ce3562-ea0f-4b43-87de-0ed381056b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'L''Homme entre deux âges et ses deux maîtresses', part.name_en = 'Les Animaux modèles, FP 111: V. L''Homme entre deux âges et ses deux maîtresses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aec45f0b-11b9-4c85-8773-7e1d8fdcd511' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec45f0b-11b9-4c85-8773-7e1d8fdcd511', 5, 'V', 'L''Homme entre deux âges et ses deux maîtresses', 'Les Animaux modèles, FP 111: V. L''Homme entre deux âges et ses deux maîtresses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec45f0b-11b9-4c85-8773-7e1d8fdcd511'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'La Mort et le Bûcheron', part.name_en = 'Les Animaux modèles, FP 111: VI. La Mort et le Bûcheron',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3e5f2d84-4e27-46c2-a44d-457b468c6dbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e5f2d84-4e27-46c2-a44d-457b468c6dbc', 6, 'VI', 'La Mort et le Bûcheron', 'Les Animaux modèles, FP 111: VI. La Mort et le Bûcheron', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5f2d84-4e27-46c2-a44d-457b468c6dbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Les Deux Coqs', part.name_en = 'Les Animaux modèles, FP 111: VII. Les Deux Coqs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f9535a77-7a8b-4623-a811-7cff81b16081' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9535a77-7a8b-4623-a811-7cff81b16081', 7, 'VII', 'Les Deux Coqs', 'Les Animaux modèles, FP 111: VII. Les Deux Coqs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9535a77-7a8b-4623-a811-7cff81b16081'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Le Repas de Midi', part.name_en = 'Les Animaux modèles, FP 111: VIII. Le Repas de Midi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11085 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0386ea82-7551-4b64-9390-7277a7396412' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0386ea82-7551-4b64-9390-7277a7396412', 8, 'VIII', 'Le Repas de Midi', 'Les Animaux modèles, FP 111: VIII. Le Repas de Midi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11085 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0386ea82-7551-4b64-9390-7277a7396412'
);


-- None 가곡 <Les Chemins de l’amour, FP 106a>

UPDATE pieces piece
SET piece.title = '가곡 <Les Chemins de l’amour, FP 106a>', piece.title_en = 'Les Chemins de l’amour, FP 106a',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7611 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Soirées de Nazelles, FP 84

UPDATE pieces piece
SET piece.title = 'Les Soirées de Nazelles, FP 84', piece.title_en = 'Les Soirées de Nazelles, FP 84',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9924 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Préambule', part.name_en = 'Les Soirées de Nazelles: Préambule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2c5cfff9-4883-4b46-b24b-7e704889e2bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5cfff9-4883-4b46-b24b-7e704889e2bb', 1, NULL, 'Préambule', 'Les Soirées de Nazelles: Préambule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5cfff9-4883-4b46-b24b-7e704889e2bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I. Le Comble de la distinction', part.name_en = 'Les Soirées de Nazelles: Variation I. Le Comble de la distinction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a801ee6b-3904-4767-ae68-fd14c8e40c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a801ee6b-3904-4767-ae68-fd14c8e40c93', 2, NULL, 'Variation I. Le Comble de la distinction', 'Les Soirées de Nazelles: Variation I. Le Comble de la distinction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a801ee6b-3904-4767-ae68-fd14c8e40c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II. Le Cœur sur la main', part.name_en = 'Les Soirées de Nazelles: Variation II. Le Cœur sur la main',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f75018d2-605d-4c40-80d4-4adc7796f60b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f75018d2-605d-4c40-80d4-4adc7796f60b', 3, NULL, 'Variation II. Le Cœur sur la main', 'Les Soirées de Nazelles: Variation II. Le Cœur sur la main', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f75018d2-605d-4c40-80d4-4adc7796f60b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III. La Désinvolture et la discrétion', part.name_en = 'Les Soirées de Nazelles: Variation III. La Désinvolture et la discrétion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0b63dc05-0148-4c04-9403-161383b5c841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b63dc05-0148-4c04-9403-161383b5c841', 4, NULL, 'Variation III. La Désinvolture et la discrétion', 'Les Soirées de Nazelles: Variation III. La Désinvolture et la discrétion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b63dc05-0148-4c04-9403-161383b5c841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV. La Suite dans les idées', part.name_en = 'Les Soirées de Nazelles: Variation IV. La Suite dans les idées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:eba8642e-b391-4ba8-9091-d7a728cd9727' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eba8642e-b391-4ba8-9091-d7a728cd9727', 5, NULL, 'Variation IV. La Suite dans les idées', 'Les Soirées de Nazelles: Variation IV. La Suite dans les idées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eba8642e-b391-4ba8-9091-d7a728cd9727'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V. La Charme enjôleur', part.name_en = 'Les Soirées de Nazelles: Variation V. La Charme enjôleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3a715341-d32f-4384-a946-4acee142671d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a715341-d32f-4384-a946-4acee142671d', 6, NULL, 'Variation V. La Charme enjôleur', 'Les Soirées de Nazelles: Variation V. La Charme enjôleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a715341-d32f-4384-a946-4acee142671d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI. Le Contentement de soi', part.name_en = 'Les Soirées de Nazelles: Variation VI. Le Contentement de soi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3e0bfb60-f23b-4118-a3eb-d83f512bb71a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e0bfb60-f23b-4118-a3eb-d83f512bb71a', 7, NULL, 'Variation VI. Le Contentement de soi', 'Les Soirées de Nazelles: Variation VI. Le Contentement de soi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e0bfb60-f23b-4118-a3eb-d83f512bb71a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation VII. Le Goût du malheur', part.name_en = 'Les Soirées de Nazelles: Variation VII. Le Goût du malheur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0b960906-7d20-4e71-b3eb-e95b09f791fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b960906-7d20-4e71-b3eb-e95b09f791fb', 8, NULL, 'Variation VII. Le Goût du malheur', 'Les Soirées de Nazelles: Variation VII. Le Goût du malheur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b960906-7d20-4e71-b3eb-e95b09f791fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation VIII. L''Alerte Vieillesse', part.name_en = 'Les Soirées de Nazelles: Variation VIII. L''Alerte Vieillesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6f550372-fcb7-4461-875f-0256f56de33d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f550372-fcb7-4461-875f-0256f56de33d', 9, NULL, 'Variation VIII. L''Alerte Vieillesse', 'Les Soirées de Nazelles: Variation VIII. L''Alerte Vieillesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f550372-fcb7-4461-875f-0256f56de33d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Cadence', part.name_en = 'Les Soirées de Nazelles: Cadence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ed6ebb9a-d4c5-4682-9371-63dd18506ee9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed6ebb9a-d4c5-4682-9371-63dd18506ee9', 10, NULL, 'Cadence', 'Les Soirées de Nazelles: Cadence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6ebb9a-d4c5-4682-9371-63dd18506ee9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Final', part.name_en = 'Les Soirées de Nazelles: Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9924 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:119cd6b5-4d85-43e8-bf76-95f54d98b4f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:119cd6b5-4d85-43e8-bf76-95f54d98b4f0', 11, NULL, 'Final', 'Les Soirées de Nazelles: Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9924 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:119cd6b5-4d85-43e8-bf76-95f54d98b4f0'
);


-- None Les biches, suite pour piano, FP 36c

UPDATE pieces piece
SET piece.title = 'Les biches, suite pour piano, FP 36c', piece.title_en = 'Les biches, suite pour piano, FP 36c',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8047 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture', part.name_en = 'Les biches, suite pour piano, FP 36c : I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8047 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:753cf11c-ca4c-4291-9652-68cc6631a7ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:753cf11c-ca4c-4291-9652-68cc6631a7ea', 1, 'I', 'Ouverture', 'Les biches, suite pour piano, FP 36c : I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8047 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:753cf11c-ca4c-4291-9652-68cc6631a7ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chanson dansée', part.name_en = 'Les biches, suite pour piano, FP 36c : II. Chanson dansée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8047 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:274a413d-4d7b-4fe4-9383-e5586d837093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:274a413d-4d7b-4fe4-9383-e5586d837093', 2, 'II', 'Chanson dansée', 'Les biches, suite pour piano, FP 36c : II. Chanson dansée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8047 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:274a413d-4d7b-4fe4-9383-e5586d837093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagietto', part.name_en = 'Les biches, suite pour piano, FP 36c : III. Adagietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8047 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e02bcfe0-7024-45c5-a83c-a78c1fb39752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e02bcfe0-7024-45c5-a83c-a78c1fb39752', 3, 'III', 'Adagietto', 'Les biches, suite pour piano, FP 36c : III. Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8047 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e02bcfe0-7024-45c5-a83c-a78c1fb39752'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andantino', part.name_en = 'Les biches, suite pour piano, FP 36c : IV. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8047 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:9c7b447f-9948-4178-8a89-cb29eadd3725' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c7b447f-9948-4178-8a89-cb29eadd3725', 4, 'IV', 'Andantino', 'Les biches, suite pour piano, FP 36c : IV. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8047 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7b447f-9948-4178-8a89-cb29eadd3725'
);


-- None 부수음악 <Léocadia, FP 106>

UPDATE pieces piece
SET piece.title = '부수음악 <Léocadia, FP 106>', piece.title_en = 'Léocadia, FP 106',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10604 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Léocadia; Act 1: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:194fed6f-fa7e-4320-a421-24584ad75d61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:194fed6f-fa7e-4320-a421-24584ad75d61', 1, NULL, 'Ouverture', 'Léocadia; Act 1: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:194fed6f-fa7e-4320-a421-24584ad75d61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino; Langoureux', part.name_en = 'Léocadia; Act 5: II. Andantino; Langoureux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1ab8c831-5b53-467e-a71a-c0dfbe234f4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab8c831-5b53-467e-a71a-c0dfbe234f4b', 2, NULL, 'Andantino; Langoureux', 'Léocadia; Act 5: II. Andantino; Langoureux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab8c831-5b53-467e-a71a-c0dfbe234f4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Très calme', part.name_en = 'Léocadia; Act 4: II. Très calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:545e6c2d-cc4c-4e12-964f-5809e3196b57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:545e6c2d-cc4c-4e12-964f-5809e3196b57', 3, NULL, 'Très calme', 'Léocadia; Act 4: II. Très calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:545e6c2d-cc4c-4e12-964f-5809e3196b57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Final', part.name_en = 'Léocadia; Act 5: III. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:837db5eb-da15-4a2f-8d77-8158bf8d487f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:837db5eb-da15-4a2f-8d77-8158bf8d487f', 4, NULL, 'Final', 'Léocadia; Act 5: III. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837db5eb-da15-4a2f-8d77-8158bf8d487f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Très calme', part.name_en = 'Léocadia; Act 2: II. Très calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b5e2e8fa-81d9-489a-a2e6-562e89b734d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5e2e8fa-81d9-489a-a2e6-562e89b734d5', 5, NULL, 'Très calme', 'Léocadia; Act 2: II. Très calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5e2e8fa-81d9-489a-a2e6-562e89b734d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse des chemins de l''amour', part.name_en = 'Léocadia; Act 3: Valse des chemins de l''amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bf4364a2-caef-46af-abfd-e81a79e2fdca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf4364a2-caef-46af-abfd-e81a79e2fdca', 6, NULL, 'Valse des chemins de l''amour', 'Léocadia; Act 3: Valse des chemins de l''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf4364a2-caef-46af-abfd-e81a79e2fdca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ouverture : Valse', part.name_en = 'Léocadia; Act 4: I. Ouverture : Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c7558756-3674-4ceb-be43-7454540e130c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7558756-3674-4ceb-be43-7454540e130c', 7, NULL, 'Ouverture : Valse', 'Léocadia; Act 4: I. Ouverture : Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7558756-3674-4ceb-be43-7454540e130c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Léocadia; Act 2: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e685391f-d1e2-4b16-b2d4-fe95057f1410' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e685391f-d1e2-4b16-b2d4-fe95057f1410', 8, NULL, 'Ouverture', 'Léocadia; Act 2: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e685391f-d1e2-4b16-b2d4-fe95057f1410'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Léocadia; Act 5: I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10604 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e75fc1ce-7c7c-44c9-8c6a-a3f8541b2e0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75fc1ce-7c7c-44c9-8c6a-a3f8541b2e0d', 9, NULL, 'Ouverture', 'Léocadia; Act 5: I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10604 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75fc1ce-7c7c-44c9-8c6a-a3f8541b2e0d'
);


-- None 가곡 <Main dominée par le cœur, FP 135>

UPDATE pieces piece
SET piece.title = '가곡 <Main dominée par le cœur, FP 135>', piece.title_en = 'Main dominée par le cœur, FP 135',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9812 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Messe en sol majeur, FP 89

UPDATE pieces piece
SET piece.title = 'Messe en sol majeur, FP 89', piece.title_en = 'Messe en sol majeur, FP 89',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10637 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Messe en sol majeur, FP 89: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10637 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:766f5a52-40f0-471e-b405-4f39e02530e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766f5a52-40f0-471e-b405-4f39e02530e7', 1, 'I', 'Kyrie', 'Messe en sol majeur, FP 89: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10637 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766f5a52-40f0-471e-b405-4f39e02530e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Messe en sol majeur, FP 89: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10637 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f3ff1c60-dd19-4343-aae1-589b021ae5dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3ff1c60-dd19-4343-aae1-589b021ae5dc', 2, 'II', 'Gloria', 'Messe en sol majeur, FP 89: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10637 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ff1c60-dd19-4343-aae1-589b021ae5dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sanctus', part.name_en = 'Messe en sol majeur, FP 89: III. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10637 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:472e4d4d-38d1-4dd8-9f5a-ed0c82bdb562' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472e4d4d-38d1-4dd8-9f5a-ed0c82bdb562', 3, 'III', 'Sanctus', 'Messe en sol majeur, FP 89: III. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10637 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472e4d4d-38d1-4dd8-9f5a-ed0c82bdb562'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Benedictus', part.name_en = 'Messe en sol majeur, FP 89: IV. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10637 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6d8fd0c2-b7a2-403b-8872-da8f798453ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8fd0c2-b7a2-403b-8872-da8f798453ef', 4, 'IV', 'Benedictus', 'Messe en sol majeur, FP 89: IV. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10637 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8fd0c2-b7a2-403b-8872-da8f798453ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe en sol majeur, FP 89: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10637 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a476c0d1-1363-4dcb-ab5a-5835652001ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a476c0d1-1363-4dcb-ab5a-5835652001ea', 5, 'V', 'Agnus Dei', 'Messe en sol majeur, FP 89: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10637 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a476c0d1-1363-4dcb-ab5a-5835652001ea'
);


-- None Miroirs brûlants, FP 98

UPDATE pieces piece
SET piece.title = 'Miroirs brûlants, FP 98', piece.title_en = 'Miroirs brûlants, FP 98',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8846 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tu vois le feu du soir', part.name_en = 'Miroirs brûlants, FP 98: 1. Tu vois le feu du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8846 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c18908ba-fff2-4533-afe3-d3cf123cc80d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c18908ba-fff2-4533-afe3-d3cf123cc80d', 1, NULL, 'Tu vois le feu du soir', 'Miroirs brûlants, FP 98: 1. Tu vois le feu du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8846 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18908ba-fff2-4533-afe3-d3cf123cc80d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Je nommerai ton front', part.name_en = 'Miroirs brûlants, FP 98: 2. Je nommerai ton front',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8846 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:9a8a1552-8a88-4883-b81e-9b40adfcecf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a8a1552-8a88-4883-b81e-9b40adfcecf1', 2, NULL, 'Je nommerai ton front', 'Miroirs brûlants, FP 98: 2. Je nommerai ton front', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8846 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a8a1552-8a88-4883-b81e-9b40adfcecf1'
);


-- None Mélancolie

UPDATE pieces piece
SET piece.title = 'Mélancolie', piece.title_en = 'Mélancolie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8487 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Métamorphoses, FP 121

UPDATE pieces piece
SET piece.title = 'Métamorphoses, FP 121', piece.title_en = 'Métamorphoses, FP 121',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9049 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Reine des mouettes', part.name_en = 'Métamorphoses, FP 121: 1. Reine des mouettes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9049 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bb44e301-26dc-4e63-9e2c-f9e6a82d1afb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb44e301-26dc-4e63-9e2c-f9e6a82d1afb', 1, NULL, 'Reine des mouettes', 'Métamorphoses, FP 121: 1. Reine des mouettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9049 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb44e301-26dc-4e63-9e2c-f9e6a82d1afb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C''est ainsi que tu es', part.name_en = 'Métamorphoses, FP 121: 2. C''est ainsi que tu es',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9049 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3c3e996e-c7e2-4b23-89db-9852cff1ad4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3e996e-c7e2-4b23-89db-9852cff1ad4e', 2, NULL, 'C''est ainsi que tu es', 'Métamorphoses, FP 121: 2. C''est ainsi que tu es', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9049 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3e996e-c7e2-4b23-89db-9852cff1ad4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Paganini', part.name_en = 'Métamorphoses, FP 121: 3. Paganini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9049 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7e35e408-9a3b-42f2-a3ed-a33d54b87965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e35e408-9a3b-42f2-a3ed-a33d54b87965', 3, NULL, 'Paganini', 'Métamorphoses, FP 121: 3. Paganini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9049 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e35e408-9a3b-42f2-a3ed-a33d54b87965'
);


-- None Napoli, FP 40

UPDATE pieces piece
SET piece.title = 'Napoli, FP 40', piece.title_en = 'Napoli, FP 40',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11033 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Barcarolle. Assez animé', part.name_en = 'Napoli: I. Barcarolle. Assez animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11033 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:eb5208ff-39c1-4473-8d18-1e58df7d2fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb5208ff-39c1-4473-8d18-1e58df7d2fbd', 1, 'I', 'Barcarolle. Assez animé', 'Napoli: I. Barcarolle. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11033 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb5208ff-39c1-4473-8d18-1e58df7d2fbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne. Lent', part.name_en = 'Napoli: II. Nocturne. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11033 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d3f0ee57-3806-4b40-b50e-1d6460ffc84d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3f0ee57-3806-4b40-b50e-1d6460ffc84d', 2, 'II', 'Nocturne. Lent', 'Napoli: II. Nocturne. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11033 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3f0ee57-3806-4b40-b50e-1d6460ffc84d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Caprice italien. Presto', part.name_en = 'Napoli: III. Caprice italien. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11033 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7a4d1c19-9f66-49a5-9c30-eee67385af10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a4d1c19-9f66-49a5-9c30-eee67385af10', 3, 'III', 'Caprice italien. Presto', 'Napoli: III. Caprice italien. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11033 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4d1c19-9f66-49a5-9c30-eee67385af10'
);


-- None 가곡 <Nos souvenirs qui chantent, FP 182>

UPDATE pieces piece
SET piece.title = '가곡 <Nos souvenirs qui chantent, FP 182>', piece.title_en = 'Nos souvenirs qui chantent, FP 182',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8376 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Parisiana, FP 157

UPDATE pieces piece
SET piece.title = 'Parisiana, FP 157', piece.title_en = 'Parisiana, FP 157',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10963 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jouer du bugle', part.name_en = 'Parisiana, FP 157: 1. Jouer du bugle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10963 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a395096d-fafb-4c3e-8cda-3fbc25002ebb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a395096d-fafb-4c3e-8cda-3fbc25002ebb', 1, NULL, 'Jouer du bugle', 'Parisiana, FP 157: 1. Jouer du bugle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10963 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a395096d-fafb-4c3e-8cda-3fbc25002ebb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vous n''écrivez plus ?', part.name_en = 'Parisiana, FP 157: 2. Vous n''écrivez plus ?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10963 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d1a4e122-d12d-436a-b1e6-1ffe140424b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1a4e122-d12d-436a-b1e6-1ffe140424b3', 2, NULL, 'Vous n''écrivez plus ?', 'Parisiana, FP 157: 2. Vous n''écrivez plus ?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10963 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1a4e122-d12d-436a-b1e6-1ffe140424b3'
);


-- None 가곡 <Paul et Virginie, FP 132>

UPDATE pieces piece
SET piece.title = '가곡 <Paul et Virginie, FP 132>', piece.title_en = 'Paul et Virginie, FP 132',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11156 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Petite Complainte>

UPDATE pieces piece
SET piece.title = '가곡 <Petite Complainte>', piece.title_en = 'Petite Complainte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11124 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Petites voix, FP 83>

UPDATE pieces piece
SET piece.title = '연가곡집 <Petites voix, FP 83>', piece.title_en = 'Petites voix, FP 83',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9672 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La petite fille sage', part.name_en = 'Petites voix, FP 83: No. 1. La petite fille sage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9672 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:da3f4e67-f190-4729-9232-2dd99fe298ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da3f4e67-f190-4729-9232-2dd99fe298ec', 1, NULL, 'La petite fille sage', 'Petites voix, FP 83: No. 1. La petite fille sage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9672 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da3f4e67-f190-4729-9232-2dd99fe298ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le chien perdu', part.name_en = 'Petites voix, FP 83: No. 2. Le chien perdu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9672 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3ec2d214-1bdd-44fe-819f-689d9be1c2a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec2d214-1bdd-44fe-819f-689d9be1c2a6', 2, NULL, 'Le chien perdu', 'Petites voix, FP 83: No. 2. Le chien perdu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9672 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec2d214-1bdd-44fe-819f-689d9be1c2a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'En rentrant de l''ecole', part.name_en = 'Petites voix, FP 83: No. 3. En rentrant de l''ecole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9672 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:67bce2e4-0544-40c2-bd57-228f2e051fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67bce2e4-0544-40c2-bd57-228f2e051fed', 3, NULL, 'En rentrant de l''ecole', 'Petites voix, FP 83: No. 3. En rentrant de l''ecole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9672 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67bce2e4-0544-40c2-bd57-228f2e051fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La petite garçon', part.name_en = 'Petites voix, FP 83: No. 4. La petite garçon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9672 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:07f8a843-2df3-4bd1-be3f-8e13943757a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f8a843-2df3-4bd1-be3f-8e13943757a7', 4, NULL, 'La petite garçon', 'Petites voix, FP 83: No. 4. La petite garçon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9672 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f8a843-2df3-4bd1-be3f-8e13943757a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le hérisson', part.name_en = 'Petites voix, FP 83: No. 5. Le hérisson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9672 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8d86d9df-8d71-4cf2-b652-af6658eb3dcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d86d9df-8d71-4cf2-b652-af6658eb3dcb', 5, NULL, 'Le hérisson', 'Petites voix, FP 83: No. 5. Le hérisson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9672 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d86d9df-8d71-4cf2-b652-af6658eb3dcb'
);


-- None 피아노 협주곡 C♯단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 C♯단조', piece.title_en = 'Piano Concerto in C-sharp minor, FP 146',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10914 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Piano Concerto in C-sharp minor, FP 146: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:751336f1-95e9-4ca3-84ea-ba7ffd9b4ec2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:751336f1-95e9-4ca3-84ea-ba7ffd9b4ec2', 1, 'I', 'Allegretto', 'Piano Concerto in C-sharp minor, FP 146: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:751336f1-95e9-4ca3-84ea-ba7ffd9b4ec2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'Piano Concerto in C-sharp minor, FP 146: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1d0f079a-7641-4322-82e0-391bdfdbd7c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0f079a-7641-4322-82e0-391bdfdbd7c1', 2, 'II', 'Andante con moto', 'Piano Concerto in C-sharp minor, FP 146: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0f079a-7641-4322-82e0-391bdfdbd7c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo à la Française', part.name_en = 'Piano Concerto in C-sharp minor, FP 146: III. Rondo à la Française',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0dfcf622-a559-43c0-ac64-beea9c287fcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dfcf622-a559-43c0-ac64-beea9c287fcb', 3, 'III', 'Rondo à la Française', 'Piano Concerto in C-sharp minor, FP 146: III. Rondo à la Française', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dfcf622-a559-43c0-ac64-beea9c287fcb'
);


-- None 가곡 <Pierrot, FP 66>

UPDATE pieces piece
SET piece.title = '가곡 <Pierrot, FP 66>', piece.title_en = 'Pierrot, FP 66',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9353 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièce brève sur le nom d'Albert Roussel, FP 50

UPDATE pieces piece
SET piece.title = 'Pièce brève sur le nom d''Albert Roussel, FP 50', piece.title_en = 'Pièce brève sur le nom d''Albert Roussel, FP 50',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11004 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Poèmes de Ronsard, FP 38

UPDATE pieces piece
SET piece.title = 'Poèmes de Ronsard, FP 38', piece.title_en = 'Poèmes de Ronsard, FP 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8882 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Attributs', part.name_en = 'Poèmes de Ronsard, FP 38: 1. Attributs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8882 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e0f320b4-4fca-4001-9ae5-3a7cd6445953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0f320b4-4fca-4001-9ae5-3a7cd6445953', 1, NULL, 'Attributs', 'Poèmes de Ronsard, FP 38: 1. Attributs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8882 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f320b4-4fca-4001-9ae5-3a7cd6445953'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le tombeau', part.name_en = 'Poèmes de Ronsard, FP 38: 2. Le tombeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8882 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d34c56e6-ed60-4f04-9090-a3639ecde3d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d34c56e6-ed60-4f04-9090-a3639ecde3d9', 2, NULL, 'Le tombeau', 'Poèmes de Ronsard, FP 38: 2. Le tombeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8882 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34c56e6-ed60-4f04-9090-a3639ecde3d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ballet', part.name_en = 'Poèmes de Ronsard, FP 38: 3. Ballet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8882 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ce23f066-b349-4924-9cf7-7d4283b21c42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce23f066-b349-4924-9cf7-7d4283b21c42', 3, NULL, 'Ballet', 'Poèmes de Ronsard, FP 38: 3. Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8882 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce23f066-b349-4924-9cf7-7d4283b21c42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Je n''ai plus que les os', part.name_en = 'Poèmes de Ronsard, FP 38: 4. Je n''ai plus que les os',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8882 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b1f844f7-1089-43fa-817f-c8a3f518c225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f844f7-1089-43fa-817f-c8a3f518c225', 4, NULL, 'Je n''ai plus que les os', 'Poèmes de Ronsard, FP 38: 4. Je n''ai plus que les os', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8882 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f844f7-1089-43fa-817f-c8a3f518c225'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'À son page', part.name_en = 'Poèmes de Ronsard, FP 38: 5. À son page',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8882 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ca881a74-7540-4e44-aa0d-ec25bbc85266' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca881a74-7540-4e44-aa0d-ec25bbc85266', 5, NULL, 'À son page', 'Poèmes de Ronsard, FP 38: 5. À son page', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8882 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca881a74-7540-4e44-aa0d-ec25bbc85266'
);


-- None Presto for piano in B-flat major, FP 70

UPDATE pieces piece
SET piece.title = 'Presto for piano in B-flat major, FP 70', piece.title_en = 'Presto for piano in B-flat major, FP 70',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10281 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Priez pour paix, FP 95>

UPDATE pieces piece
SET piece.title = '가곡 <Priez pour paix, FP 95>', piece.title_en = 'Priez pour paix, FP 95',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9945 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Promenades, FP 24

UPDATE pieces piece
SET piece.title = 'Promenades, FP 24', piece.title_en = 'Promenades, FP 24',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9838 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'À pied', part.name_en = 'Promenades: I. À pied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8113a096-7ece-4bbf-aea6-f1621e275fdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8113a096-7ece-4bbf-aea6-f1621e275fdf', 1, 'I', 'À pied', 'Promenades: I. À pied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8113a096-7ece-4bbf-aea6-f1621e275fdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'En auto', part.name_en = 'Promenades: II. En auto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:05eb787f-f04e-46cb-9b9b-fff171948553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05eb787f-f04e-46cb-9b9b-fff171948553', 2, 'II', 'En auto', 'Promenades: II. En auto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05eb787f-f04e-46cb-9b9b-fff171948553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'À cheval', part.name_en = 'Promenades: III. À cheval',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:957fdcf9-a529-4d31-97fe-bae66f028b44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:957fdcf9-a529-4d31-97fe-bae66f028b44', 3, 'III', 'À cheval', 'Promenades: III. À cheval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:957fdcf9-a529-4d31-97fe-bae66f028b44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'En bateau', part.name_en = 'Promenades: IV. En bateau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1fbeabd4-60d4-4e8c-b7ff-519ffc457add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fbeabd4-60d4-4e8c-b7ff-519ffc457add', 4, 'IV', 'En bateau', 'Promenades: IV. En bateau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fbeabd4-60d4-4e8c-b7ff-519ffc457add'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'En avion', part.name_en = 'Promenades: V. En avion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a608e1de-408e-49ae-8105-a40a1ec9d07a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a608e1de-408e-49ae-8105-a40a1ec9d07a', 5, 'V', 'En avion', 'Promenades: V. En avion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a608e1de-408e-49ae-8105-a40a1ec9d07a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'En autobus', part.name_en = 'Promenades: VI. En autobus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:be4b3993-dd9e-477e-94d9-e233add258b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be4b3993-dd9e-477e-94d9-e233add258b1', 6, 'VI', 'En autobus', 'Promenades: VI. En autobus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be4b3993-dd9e-477e-94d9-e233add258b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'En voiture', part.name_en = 'Promenades: VII. En voiture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e28abd7c-f029-460f-bf86-5651a81ce764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e28abd7c-f029-460f-bf86-5651a81ce764', 7, 'VII', 'En voiture', 'Promenades: VII. En voiture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28abd7c-f029-460f-bf86-5651a81ce764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'En chemin de fer', part.name_en = 'Promenades: VIII. En chemin de fer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fdcf423e-20f2-4959-b09c-b9fe88dc5c8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdcf423e-20f2-4959-b09c-b9fe88dc5c8a', 8, 'VIII', 'En chemin de fer', 'Promenades: VIII. En chemin de fer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdcf423e-20f2-4959-b09c-b9fe88dc5c8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'À bicyclette', part.name_en = 'Promenades: IX. À bicyclette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:de68990b-41cc-45b9-ac5c-239dfaca7112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de68990b-41cc-45b9-ac5c-239dfaca7112', 9, 'IX', 'À bicyclette', 'Promenades: IX. À bicyclette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de68990b-41cc-45b9-ac5c-239dfaca7112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'En diligence', part.name_en = 'Promenades: X. En diligence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9838 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0e371276-a863-420a-92e3-609e6234331b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e371276-a863-420a-92e3-609e6234331b', 10, 'X', 'En diligence', 'Promenades: X. En diligence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9838 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e371276-a863-420a-92e3-609e6234331b'
);


-- None Quatre chansons pour enfants, FP 75

UPDATE pieces piece
SET piece.title = 'Quatre chansons pour enfants, FP 75', piece.title_en = 'Quatre chansons pour enfants, FP 75',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9829 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nous voulons une petite sœur', part.name_en = 'Quatre chansons pour enfants, FP 75: 1. Nous voulons une petite sœur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9829 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a4e8d080-aee0-4c9b-9ee3-c8aab4198d60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4e8d080-aee0-4c9b-9ee3-c8aab4198d60', 1, NULL, 'Nous voulons une petite sœur', 'Quatre chansons pour enfants, FP 75: 1. Nous voulons une petite sœur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9829 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4e8d080-aee0-4c9b-9ee3-c8aab4198d60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La tragique histoire du petit René', part.name_en = 'Quatre chansons pour enfants, FP 75: 2. La tragique histoire du petit René',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9829 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fa7ffeb4-954b-41c4-be64-6dd4e518875e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa7ffeb4-954b-41c4-be64-6dd4e518875e', 2, NULL, 'La tragique histoire du petit René', 'Quatre chansons pour enfants, FP 75: 2. La tragique histoire du petit René', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9829 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa7ffeb4-954b-41c4-be64-6dd4e518875e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le petit garçon trop bien portant', part.name_en = 'Quatre chansons pour enfants, FP 75: 3. Le petit garçon trop bien portant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9829 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c9ba3b8f-dace-4064-931e-942f303c7455' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9ba3b8f-dace-4064-931e-942f303c7455', 3, NULL, 'Le petit garçon trop bien portant', 'Quatre chansons pour enfants, FP 75: 3. Le petit garçon trop bien portant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9829 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9ba3b8f-dace-4064-931e-942f303c7455'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Monsieur Sans-Souci', part.name_en = 'Quatre chansons pour enfants, FP 75: 4. Monsieur Sans-Souci',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9829 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:51f0aeb4-46a2-4569-9a8b-650abfc4e5a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51f0aeb4-46a2-4569-9a8b-650abfc4e5a8', 4, NULL, 'Monsieur Sans-Souci', 'Quatre chansons pour enfants, FP 75: 4. Monsieur Sans-Souci', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9829 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f0aeb4-46a2-4569-9a8b-650abfc4e5a8'
);


-- None Quatre motets pour le temps de Noël, FP 152

UPDATE pieces piece
SET piece.title = 'Quatre motets pour le temps de Noël, FP 152', piece.title_en = 'Quatre motets pour le temps de Noël, FP 152',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7637 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre motets pour un temps de pénitence, FP 97

UPDATE pieces piece
SET piece.title = 'Quatre motets pour un temps de pénitence, FP 97', piece.title_en = 'Quatre motets pour un temps de pénitence, FP 97',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9435 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Timor et tremor', part.name_en = 'Quatre motets pour un temps de pénitence: No. 1. Timor et tremor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9435 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:61cabe4b-5c17-4966-b631-8f35a092255a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61cabe4b-5c17-4966-b631-8f35a092255a', 1, NULL, 'Timor et tremor', 'Quatre motets pour un temps de pénitence: No. 1. Timor et tremor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9435 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61cabe4b-5c17-4966-b631-8f35a092255a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vinea mea electa', part.name_en = 'Quatre motets pour un temps de pénitence: No. 2. Vinea mea electa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9435 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ac088751-b60d-4659-b361-536a31aac2fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac088751-b60d-4659-b361-536a31aac2fc', 2, NULL, 'Vinea mea electa', 'Quatre motets pour un temps de pénitence: No. 2. Vinea mea electa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9435 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac088751-b60d-4659-b361-536a31aac2fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tenebræ factæ sunt', part.name_en = 'Quatre motets pour un temps de pénitence: No. 3. Tenebræ factæ sunt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9435 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:75661b59-63d6-4378-a02c-16b7ba4ba351' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75661b59-63d6-4378-a02c-16b7ba4ba351', 3, NULL, 'Tenebræ factæ sunt', 'Quatre motets pour un temps de pénitence: No. 3. Tenebræ factæ sunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9435 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75661b59-63d6-4378-a02c-16b7ba4ba351'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tristis est anima mea', part.name_en = 'Quatre motets pour un temps de pénitence: No. 4. Tristis est anima mea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9435 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:87c0dc6a-50b2-439b-935b-3b8c978c21f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c0dc6a-50b2-439b-935b-3b8c978c21f8', 4, NULL, 'Tristis est anima mea', 'Quatre motets pour un temps de pénitence: No. 4. Tristis est anima mea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9435 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c0dc6a-50b2-439b-935b-3b8c978c21f8'
);


-- None Quatre petites prières de Saint François d’Assise, FP 142

UPDATE pieces piece
SET piece.title = 'Quatre petites prières de Saint François d’Assise, FP 142', piece.title_en = 'Quatre petites prières de Saint François d’Assise, FP 142',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10834 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Salut, dame Sainte', part.name_en = 'Quatre petites prières de Saint François d’Assise, FP 142: I. Salut, dame Sainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10834 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:bdcbbef6-c133-40c1-9652-da495b419692' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdcbbef6-c133-40c1-9652-da495b419692', 1, 'I', 'Salut, dame Sainte', 'Quatre petites prières de Saint François d’Assise, FP 142: I. Salut, dame Sainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10834 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdcbbef6-c133-40c1-9652-da495b419692'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tout puissant, très saint', part.name_en = 'Quatre petites prières de Saint François d’Assise, FP 142: II. Tout puissant, très saint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10834 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f54eed35-3f75-4b9a-bc40-28f1cd28d407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f54eed35-3f75-4b9a-bc40-28f1cd28d407', 2, 'II', 'Tout puissant, très saint', 'Quatre petites prières de Saint François d’Assise, FP 142: II. Tout puissant, très saint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10834 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f54eed35-3f75-4b9a-bc40-28f1cd28d407'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Seigneur, je vous en prie', part.name_en = 'Quatre petites prières de Saint François d’Assise, FP 142: III. Seigneur, je vous en prie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10834 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d7846fa3-aceb-4ad0-bef2-57c643e81112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7846fa3-aceb-4ad0-bef2-57c643e81112', 3, 'III', 'Seigneur, je vous en prie', 'Quatre petites prières de Saint François d’Assise, FP 142: III. Seigneur, je vous en prie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10834 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7846fa3-aceb-4ad0-bef2-57c643e81112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O mes très chers frères', part.name_en = 'Quatre petites prières de Saint François d’Assise, FP 142: IV. O mes très chers frères',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10834 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7a10c9c5-1cde-450c-bad6-4745088add17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a10c9c5-1cde-450c-bad6-4745088add17', 4, 'IV', 'O mes très chers frères', 'Quatre petites prières de Saint François d’Assise, FP 142: IV. O mes très chers frères', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10834 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a10c9c5-1cde-450c-bad6-4745088add17'
);


-- None 연가곡집 <Quatre poèmes de Guillaume Apollinaire, FP 58>

UPDATE pieces piece
SET piece.title = '연가곡집 <Quatre poèmes de Guillaume Apollinaire, FP 58>', piece.title_en = 'Quatre poèmes de Guillaume Apollinaire, FP 58',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7785 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L''anguille', part.name_en = 'Quatre poèmes de Guillaume Apollinaire, FP 58: 1. L''anguille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7785 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ab24d992-075f-49d9-92db-cba1f7bd6f68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab24d992-075f-49d9-92db-cba1f7bd6f68', 1, NULL, 'L''anguille', 'Quatre poèmes de Guillaume Apollinaire, FP 58: 1. L''anguille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7785 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab24d992-075f-49d9-92db-cba1f7bd6f68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Carte postale', part.name_en = 'Quatre poèmes de Guillaume Apollinaire, FP 58: 2. Carte postale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7785 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0cc8e171-00a3-4c8d-a087-ad24deb62da0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cc8e171-00a3-4c8d-a087-ad24deb62da0', 2, NULL, 'Carte postale', 'Quatre poèmes de Guillaume Apollinaire, FP 58: 2. Carte postale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7785 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cc8e171-00a3-4c8d-a087-ad24deb62da0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Avant le cinéma', part.name_en = 'Quatre poèmes de Guillaume Apollinaire, FP 58: 3. Avant le cinéma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7785 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c30e1340-f87f-4140-bcc8-d213395329f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c30e1340-f87f-4140-bcc8-d213395329f9', 3, NULL, 'Avant le cinéma', 'Quatre poèmes de Guillaume Apollinaire, FP 58: 3. Avant le cinéma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7785 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c30e1340-f87f-4140-bcc8-d213395329f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '1904', part.name_en = 'Quatre poèmes de Guillaume Apollinaire, FP 58: 4. 1904',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7785 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e024894a-332a-48db-bda7-287a37f488b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e024894a-332a-48db-bda7-287a37f488b2', 4, NULL, '1904', 'Quatre poèmes de Guillaume Apollinaire, FP 58: 4. 1904', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7785 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e024894a-332a-48db-bda7-287a37f488b2'
);


-- None Quatre poèmes de Max Jacob

UPDATE pieces piece
SET piece.title = 'Quatre poèmes de Max Jacob', piece.title_en = 'Quatre poèmes de Max Jacob',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8899 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Est-il un coin plus solitaire', part.name_en = 'Quatre poèmes de Max Jacob: I. Est-il un coin plus solitaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0cbd3d80-85cb-4f1a-9cb6-8b521ce3564f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cbd3d80-85cb-4f1a-9cb6-8b521ce3564f', 1, 'I', 'Est-il un coin plus solitaire', 'Quatre poèmes de Max Jacob: I. Est-il un coin plus solitaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cbd3d80-85cb-4f1a-9cb6-8b521ce3564f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'C''est pour aller au bal', part.name_en = 'Quatre poèmes de Max Jacob: II. C''est pour aller au bal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:837bf3d6-fe31-49bb-b351-d2e367694ca6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:837bf3d6-fe31-49bb-b351-d2e367694ca6', 2, 'II', 'C''est pour aller au bal', 'Quatre poèmes de Max Jacob: II. C''est pour aller au bal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837bf3d6-fe31-49bb-b351-d2e367694ca6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poète et ténor', part.name_en = 'Quatre poèmes de Max Jacob: III. Poète et ténor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d483145b-9733-48de-90e7-ca22761f5a7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d483145b-9733-48de-90e7-ca22761f5a7b', 3, 'III', 'Poète et ténor', 'Quatre poèmes de Max Jacob: III. Poète et ténor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d483145b-9733-48de-90e7-ca22761f5a7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dans le buisson de mimosa', part.name_en = 'Quatre poèmes de Max Jacob: IV. Dans le buisson de mimosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8899 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:38c7c0c8-d9f7-4d4e-86db-47fd777c0a38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38c7c0c8-d9f7-4d4e-86db-47fd777c0a38', 4, 'IV', 'Dans le buisson de mimosa', 'Quatre poèmes de Max Jacob: IV. Dans le buisson de mimosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8899 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c7c0c8-d9f7-4d4e-86db-47fd777c0a38'
);


-- None Rapsodie nègre

UPDATE pieces piece
SET piece.title = 'Rapsodie nègre', piece.title_en = 'Rapsodie nègre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8341 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Rapsodie nègre: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8341 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:add955da-d05b-4837-9a46-0f345867d722' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:add955da-d05b-4837-9a46-0f345867d722', 1, 'I', 'Prélude', 'Rapsodie nègre: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8341 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add955da-d05b-4837-9a46-0f345867d722'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rondo', part.name_en = 'Rapsodie nègre: II. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8341 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c97ecf06-0e94-4f61-8d6b-6a66586401be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97ecf06-0e94-4f61-8d6b-6a66586401be', 2, 'II', 'Rondo', 'Rapsodie nègre: II. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8341 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97ecf06-0e94-4f61-8d6b-6a66586401be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Honoloulou', part.name_en = 'Rapsodie nègre: III. Honoloulou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8341 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:96aa7f15-0417-480c-9fc6-9ec6b3448ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96aa7f15-0417-480c-9fc6-9ec6b3448ce9', 3, 'III', 'Honoloulou', 'Rapsodie nègre: III. Honoloulou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8341 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96aa7f15-0417-480c-9fc6-9ec6b3448ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pastorale', part.name_en = 'Rapsodie nègre: IV. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8341 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:96659eea-c5c1-4320-b76b-ca77d2afce68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96659eea-c5c1-4320-b76b-ca77d2afce68', 4, 'IV', 'Pastorale', 'Rapsodie nègre: IV. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8341 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96659eea-c5c1-4320-b76b-ca77d2afce68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale', part.name_en = 'Rapsodie nègre: V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8341 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fc4d73dc-cde2-4831-acbe-7bfe1ab6ea61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc4d73dc-cde2-4831-acbe-7bfe1ab6ea61', 5, 'V', 'Finale', 'Rapsodie nègre: V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8341 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc4d73dc-cde2-4831-acbe-7bfe1ab6ea61'
);


-- None 가곡 <Rosemonde, FP 158>

UPDATE pieces piece
SET piece.title = '가곡 <Rosemonde, FP 158>', piece.title_en = 'Rosemonde, FP 158',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10909 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salve Regina, FP 110

UPDATE pieces piece
SET piece.title = 'Salve Regina, FP 110', piece.title_en = 'Salve Regina, FP 110',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8002 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sarabande, FP 179

UPDATE pieces piece
SET piece.title = 'Sarabande, FP 179', piece.title_en = 'Sarabande, FP 179',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9285 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Sept chansons, FP 81>

UPDATE pieces piece
SET piece.title = '연가곡집 <Sept chansons, FP 81>', piece.title_en = 'Sept chansons, FP 81',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10730 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La blanche neige', part.name_en = 'Sept chansons: I. La blanche neige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0981dfdb-c835-455e-8399-4a972f6beef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0981dfdb-c835-455e-8399-4a972f6beef4', 1, 'I', 'La blanche neige', 'Sept chansons: I. La blanche neige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0981dfdb-c835-455e-8399-4a972f6beef4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'À peine défigurée', part.name_en = 'Sept chansons: II. À peine défigurée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:96ed514a-6052-4c45-acc4-6d86e1f6c19d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96ed514a-6052-4c45-acc4-6d86e1f6c19d', 2, 'II', 'À peine défigurée', 'Sept chansons: II. À peine défigurée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96ed514a-6052-4c45-acc4-6d86e1f6c19d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Par une nuit nouvelle', part.name_en = 'Sept chansons: III. Par une nuit nouvelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c4103c82-7c31-4d80-9940-173d1b4c5893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4103c82-7c31-4d80-9940-173d1b4c5893', 3, 'III', 'Par une nuit nouvelle', 'Sept chansons: III. Par une nuit nouvelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4103c82-7c31-4d80-9940-173d1b4c5893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tous les droits', part.name_en = 'Sept chansons: IV. Tous les droits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:53fb99fb-e06c-4d66-b7e0-4de5c4ff06db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53fb99fb-e06c-4d66-b7e0-4de5c4ff06db', 4, 'IV', 'Tous les droits', 'Sept chansons: IV. Tous les droits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53fb99fb-e06c-4d66-b7e0-4de5c4ff06db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Belle et ressemblante', part.name_en = 'Sept chansons: V. Belle et ressemblante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0450da01-1c7f-4f3e-90c8-1fa038990c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0450da01-1c7f-4f3e-90c8-1fa038990c82', 5, 'V', 'Belle et ressemblante', 'Sept chansons: V. Belle et ressemblante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0450da01-1c7f-4f3e-90c8-1fa038990c82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Marie', part.name_en = 'Sept chansons: VI. Marie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:57dac94a-fd7f-4bc5-b53c-37b85d708ae1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57dac94a-fd7f-4bc5-b53c-37b85d708ae1', 6, 'VI', 'Marie', 'Sept chansons: VI. Marie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57dac94a-fd7f-4bc5-b53c-37b85d708ae1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Luire', part.name_en = 'Sept chansons: VII. Luire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10730 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:17134d83-9665-479e-bb4d-6accd9c24d14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17134d83-9665-479e-bb4d-6accd9c24d14', 7, 'VII', 'Luire', 'Sept chansons: VII. Luire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10730 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17134d83-9665-479e-bb4d-6accd9c24d14'
);


-- None Sept répons des ténèbres, FP 181

UPDATE pieces piece
SET piece.title = 'Sept répons des ténèbres, FP 181', piece.title_en = 'Sept répons des ténèbres, FP 181',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8144 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Una hora non potuistis vigilate mecum', part.name_en = 'Sept Répons des Ténèbres: I. Una hora non potuistis vigilate mecum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:977e0426-8c7e-4434-b596-55be27ea585e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:977e0426-8c7e-4434-b596-55be27ea585e', 1, 'I', 'Una hora non potuistis vigilate mecum', 'Sept Répons des Ténèbres: I. Una hora non potuistis vigilate mecum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:977e0426-8c7e-4434-b596-55be27ea585e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Judas mercator pessimus', part.name_en = 'Sept Répons des Ténèbres: II. Judas mercator pessimus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:58313b18-9f07-4818-91f8-e5a774849be9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58313b18-9f07-4818-91f8-e5a774849be9', 2, 'II', 'Judas mercator pessimus', 'Sept Répons des Ténèbres: II. Judas mercator pessimus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58313b18-9f07-4818-91f8-e5a774849be9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Jesum tradidit impius', part.name_en = 'Sept Répons des Ténèbres: III. Jesum tradidit impius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:655526fa-11ac-46ba-9dff-f6fabb411944' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655526fa-11ac-46ba-9dff-f6fabb411944', 3, 'III', 'Jesum tradidit impius', 'Sept Répons des Ténèbres: III. Jesum tradidit impius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655526fa-11ac-46ba-9dff-f6fabb411944'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Caligaverunt oculi mei', part.name_en = 'Sept Répons des Ténèbres: IV. Caligaverunt oculi mei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:377cff77-ab98-4f97-9faa-eb82a1ad7883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:377cff77-ab98-4f97-9faa-eb82a1ad7883', 4, 'IV', 'Caligaverunt oculi mei', 'Sept Répons des Ténèbres: IV. Caligaverunt oculi mei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:377cff77-ab98-4f97-9faa-eb82a1ad7883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tenebrae factae sunt', part.name_en = 'Sept Répons des Ténèbres: V. Tenebrae factae sunt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7d7847be-a0eb-458c-acef-5a4778130027' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d7847be-a0eb-458c-acef-5a4778130027', 5, 'V', 'Tenebrae factae sunt', 'Sept Répons des Ténèbres: V. Tenebrae factae sunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d7847be-a0eb-458c-acef-5a4778130027'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sepulto Domino', part.name_en = 'Sept Répons des Ténèbres: VI. Sepulto Domino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5f1d8daf-01da-4b84-a1d4-ed87c34efade' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f1d8daf-01da-4b84-a1d4-ed87c34efade', 6, 'VI', 'Sepulto Domino', 'Sept Répons des Ténèbres: VI. Sepulto Domino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f1d8daf-01da-4b84-a1d4-ed87c34efade'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Ecce quomodo moritur justus', part.name_en = 'Sept Répons des Ténèbres: VII. Ecce quomodo moritur justus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8144 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a10df28c-1031-4211-9d1d-9027bb4b4c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a10df28c-1031-4211-9d1d-9027bb4b4c29', 7, 'VII', 'Ecce quomodo moritur justus', 'Sept Répons des Ténèbres: VII. Ecce quomodo moritur justus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8144 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10df28c-1031-4211-9d1d-9027bb4b4c29'
);


-- None Sextet for Piano and Wind Quintet, FP 100

UPDATE pieces piece
SET piece.title = 'Sextet for Piano and Wind Quintet, FP 100', piece.title_en = 'Sextet for Piano and Wind Quintet, FP 100',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7629 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Sextet for Piano and Wind Quintet, FP 100: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7629 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ebec0d11-4aa0-4d56-8500-ca94f7df6811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebec0d11-4aa0-4d56-8500-ca94f7df6811', 1, 'I', 'Allegro vivace', 'Sextet for Piano and Wind Quintet, FP 100: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7629 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebec0d11-4aa0-4d56-8500-ca94f7df6811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Divertissement. Andantino', part.name_en = 'Sextet for Piano and Wind Quintet, FP 100: II. Divertissement. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7629 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2413434b-3d1f-4270-9314-750a961d6179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2413434b-3d1f-4270-9314-750a961d6179', 2, 'II', 'Divertissement. Andantino', 'Sextet for Piano and Wind Quintet, FP 100: II. Divertissement. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7629 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2413434b-3d1f-4270-9314-750a961d6179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Prestissimo', part.name_en = 'Sextet for Piano and Wind Quintet, FP 100: III. Finale. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7629 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:62260426-3253-43eb-98c5-c7731d0810e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62260426-3253-43eb-98c5-c7731d0810e1', 3, 'III', 'Finale. Prestissimo', 'Sextet for Piano and Wind Quintet, FP 100: III. Finale. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7629 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62260426-3253-43eb-98c5-c7731d0810e1'
);


-- None Sinfonietta pour orchestre, FP 141

UPDATE pieces piece
SET piece.title = 'Sinfonietta pour orchestre, FP 141', piece.title_en = 'Sinfonietta pour orchestre, FP 141',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8828 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Sinfonietta pour orchestre, FP 141: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8828 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a5b0ef36-c5b8-41e5-82fe-4d74c0ffeb7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5b0ef36-c5b8-41e5-82fe-4d74c0ffeb7a', 1, 'I', 'Allegro con fuoco', 'Sinfonietta pour orchestre, FP 141: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8828 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5b0ef36-c5b8-41e5-82fe-4d74c0ffeb7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto vivace', part.name_en = 'Sinfonietta pour orchestre, FP 141: II. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8828 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e2ca966d-3d14-4a51-a5a8-a012629609ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2ca966d-3d14-4a51-a5a8-a012629609ec', 2, 'II', 'Molto vivace', 'Sinfonietta pour orchestre, FP 141: II. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8828 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2ca966d-3d14-4a51-a5a8-a012629609ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante cantabile', part.name_en = 'Sinfonietta pour orchestre, FP 141: III. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8828 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f05caab4-3a97-4ae8-ba24-d63a9840263f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05caab4-3a97-4ae8-ba24-d63a9840263f', 3, 'III', 'Andante cantabile', 'Sinfonietta pour orchestre, FP 141: III. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8828 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05caab4-3a97-4ae8-ba24-d63a9840263f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Prestissimo et très gai', part.name_en = 'Sinfonietta pour orchestre, FP 141: IV. Finale. Prestissimo et très gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8828 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c75608d7-3d07-4d8b-bdcb-3d24054d90bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c75608d7-3d07-4d8b-bdcb-3d24054d90bf', 4, 'IV', 'Finale. Prestissimo et très gai', 'Sinfonietta pour orchestre, FP 141: IV. Finale. Prestissimo et très gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8828 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75608d7-3d07-4d8b-bdcb-3d24054d90bf'
);


-- None 바이올린과 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타', piece.title_en = 'Sonata for Violin and Piano, FP 119',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7638 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'Sonata for Violin and Piano, op. 119: I. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7638 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cc24ba43-6977-4904-a942-b4cc4617b556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc24ba43-6977-4904-a942-b4cc4617b556', 1, 'I', 'Allegro con fuoco', 'Sonata for Violin and Piano, op. 119: I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7638 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc24ba43-6977-4904-a942-b4cc4617b556'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo: Très lent et calme', part.name_en = 'Sonata for Violin and Piano, op. 119: II. Intermezzo: Très lent et calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7638 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5b63c34f-8b77-4b5e-b01f-0306dccabdce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b63c34f-8b77-4b5e-b01f-0306dccabdce', 2, 'II', 'Intermezzo: Très lent et calme', 'Sonata for Violin and Piano, op. 119: II. Intermezzo: Très lent et calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7638 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b63c34f-8b77-4b5e-b01f-0306dccabdce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto tragico', part.name_en = 'Sonata for Violin and Piano, op. 119: III. Presto tragico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7638 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3ac01b63-8750-4516-a0ed-8b9be1e61bdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ac01b63-8750-4516-a0ed-8b9be1e61bdf', 3, 'III', 'Presto tragico', 'Sonata for Violin and Piano, op. 119: III. Presto tragico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7638 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac01b63-8750-4516-a0ed-8b9be1e61bdf'
);


-- None Sonata for two pianos, FP 156

UPDATE pieces piece
SET piece.title = 'Sonata for two pianos, FP 156', piece.title_en = 'Sonata for two pianos, FP 156',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9526 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue (Extremement lent et calme)', part.name_en = 'Sonata for two pianos, FP 156: I. Prologue (Extremement lent et calme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9526 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a45bbce3-d337-4b68-9aac-863fe2556b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a45bbce3-d337-4b68-9aac-863fe2556b4e', 1, 'I', 'Prologue (Extremement lent et calme)', 'Sonata for two pianos, FP 156: I. Prologue (Extremement lent et calme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9526 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a45bbce3-d337-4b68-9aac-863fe2556b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto (Très rythmé)', part.name_en = 'Sonata for two pianos, FP 156: II. Allegro molto (Très rythmé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9526 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fcc6e6f7-07e5-4072-8c8d-75a1ff784d80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc6e6f7-07e5-4072-8c8d-75a1ff784d80', 2, 'II', 'Allegro molto (Très rythmé)', 'Sonata for two pianos, FP 156: II. Allegro molto (Très rythmé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9526 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc6e6f7-07e5-4072-8c8d-75a1ff784d80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante lyrico (Lentement)', part.name_en = 'Sonata for two pianos, FP 156: III. Andante lyrico (Lentement)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9526 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4bbc687c-1c5c-49b8-84eb-5ff54b6f569f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bbc687c-1c5c-49b8-84eb-5ff54b6f569f', 3, 'III', 'Andante lyrico (Lentement)', 'Sonata for two pianos, FP 156: III. Andante lyrico (Lentement)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9526 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbc687c-1c5c-49b8-84eb-5ff54b6f569f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Epilogue (Allegro giocoso)', part.name_en = 'Sonata for two pianos, FP 156: IV. Epilogue (Allegro giocoso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9526 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:49625f6f-e177-4250-83bd-a0cdf78df96a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49625f6f-e177-4250-83bd-a0cdf78df96a', 4, 'IV', 'Epilogue (Allegro giocoso)', 'Sonata for two pianos, FP 156: IV. Epilogue (Allegro giocoso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9526 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49625f6f-e177-4250-83bd-a0cdf78df96a'
);


-- None Sonate pour clarinette et piano en si bémol majeur, FP 184

UPDATE pieces piece
SET piece.title = 'Sonate pour clarinette et piano en si bémol majeur, FP 184', piece.title_en = 'Sonate pour clarinette et piano en si bémol majeur, FP 184',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7460 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro tristamente (Allegretto - Très calme - Tempo allegretto)', part.name_en = 'Sonate pour clarinette et piano en si bémol majeur, FP 184: I. Allegro tristamente (Allegretto - Très calme - Tempo allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7460 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d05a0846-c4e4-4c05-bf48-ccb145c42e48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d05a0846-c4e4-4c05-bf48-ccb145c42e48', 1, 'I', 'Allegro tristamente (Allegretto - Très calme - Tempo allegretto)', 'Sonate pour clarinette et piano en si bémol majeur, FP 184: I. Allegro tristamente (Allegretto - Très calme - Tempo allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7460 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d05a0846-c4e4-4c05-bf48-ccb145c42e48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romanza (Très calme)', part.name_en = 'Sonate pour clarinette et piano en si bémol majeur, FP 184: II. Romanza (Très calme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7460 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:9b09e533-d6c0-40d1-aec0-ab3994e1a69e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b09e533-d6c0-40d1-aec0-ab3994e1a69e', 2, 'II', 'Romanza (Très calme)', 'Sonate pour clarinette et piano en si bémol majeur, FP 184: II. Romanza (Très calme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7460 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b09e533-d6c0-40d1-aec0-ab3994e1a69e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con fuoco (Très animé)', part.name_en = 'Sonate pour clarinette et piano en si bémol majeur, FP 184: III. Allegro con fuoco (Très animé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7460 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1423bcc3-4693-4443-9503-6de2be4975c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1423bcc3-4693-4443-9503-6de2be4975c6', 3, 'III', 'Allegro con fuoco (Très animé)', 'Sonate pour clarinette et piano en si bémol majeur, FP 184: III. Allegro con fuoco (Très animé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7460 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1423bcc3-4693-4443-9503-6de2be4975c6'
);


-- None Sonate pour hautbois et piano

UPDATE pieces piece
SET piece.title = 'Sonate pour hautbois et piano', piece.title_en = 'Sonate pour hautbois et piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7554 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Élégie. Paisiblement', part.name_en = 'Sonate pour hautbois et piano: I. Élégie. Paisiblement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7554 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f703f13c-1f62-485d-8a7c-2701728d8b51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f703f13c-1f62-485d-8a7c-2701728d8b51', 1, 'I', 'Élégie. Paisiblement', 'Sonate pour hautbois et piano: I. Élégie. Paisiblement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7554 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f703f13c-1f62-485d-8a7c-2701728d8b51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Très animé', part.name_en = 'Sonate pour hautbois et piano: II. Scherzo. Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7554 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:45ad4cbf-f19f-4b37-900f-0b7b3081d6ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45ad4cbf-f19f-4b37-900f-0b7b3081d6ed', 2, 'II', 'Scherzo. Très animé', 'Sonate pour hautbois et piano: II. Scherzo. Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7554 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45ad4cbf-f19f-4b37-900f-0b7b3081d6ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Déploration. Très calme', part.name_en = 'Sonate pour hautbois et piano: III. Déploration. Très calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7554 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b8d89875-682c-4b8c-adae-46900614bcd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d89875-682c-4b8c-adae-46900614bcd0', 3, 'III', 'Déploration. Très calme', 'Sonate pour hautbois et piano: III. Déploration. Très calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7554 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d89875-682c-4b8c-adae-46900614bcd0'
);


-- None Sonate pour piano à quatre mains, FP 8

UPDATE pieces piece
SET piece.title = 'Sonate pour piano à quatre mains, FP 8', piece.title_en = 'Sonate pour piano à quatre mains, FP 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7438 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude : Modéré', part.name_en = 'Sonate pour piano à quatre mains, FP 8: I. Prélude : Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7438 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7852d0c4-5dbe-476a-aaf4-90ccd3a80d64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7852d0c4-5dbe-476a-aaf4-90ccd3a80d64', 1, 'I', 'Prélude : Modéré', 'Sonate pour piano à quatre mains, FP 8: I. Prélude : Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7438 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7852d0c4-5dbe-476a-aaf4-90ccd3a80d64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rustique : Naïf et lent', part.name_en = 'Sonate pour piano à quatre mains, FP 8: II. Rustique : Naïf et lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7438 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:db61ef24-4c20-470b-a162-ddfc63728145' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db61ef24-4c20-470b-a162-ddfc63728145', 2, 'II', 'Rustique : Naïf et lent', 'Sonate pour piano à quatre mains, FP 8: II. Rustique : Naïf et lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7438 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db61ef24-4c20-470b-a162-ddfc63728145'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final : Très vite', part.name_en = 'Sonate pour piano à quatre mains, FP 8: III. Final : Très vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7438 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:f0b59a77-612d-47c9-8820-d6035e931d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0b59a77-612d-47c9-8820-d6035e931d95', 3, 'III', 'Final : Très vite', 'Sonate pour piano à quatre mains, FP 8: III. Final : Très vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7438 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0b59a77-612d-47c9-8820-d6035e931d95'
);


-- None Sonate pour violoncelle et piano, FP 143

UPDATE pieces piece
SET piece.title = 'Sonate pour violoncelle et piano, FP 143', piece.title_en = 'Sonate pour violoncelle et piano, FP 143',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11075 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro - Tempo di marcia', part.name_en = 'Sonate pour violoncelle et piano, op. 143 : I. Allegro - Tempo di marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11075 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e16f6f31-a8d3-4aca-b3c7-ad045719241e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e16f6f31-a8d3-4aca-b3c7-ad045719241e', 1, 'I', 'Allegro - Tempo di marcia', 'Sonate pour violoncelle et piano, op. 143 : I. Allegro - Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11075 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e16f6f31-a8d3-4aca-b3c7-ad045719241e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cavatine', part.name_en = 'Sonate pour violoncelle et piano, op. 143 : II. Cavatine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11075 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e8743f64-b0e8-4c0e-859c-724f0060d049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8743f64-b0e8-4c0e-859c-724f0060d049', 2, 'II', 'Cavatine', 'Sonate pour violoncelle et piano, op. 143 : II. Cavatine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11075 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8743f64-b0e8-4c0e-859c-724f0060d049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ballabile', part.name_en = 'Sonate pour violoncelle et piano, op. 143 : III. Ballabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11075 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:aee64dbe-a3c3-43a5-8406-c1d4e9ef1ff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aee64dbe-a3c3-43a5-8406-c1d4e9ef1ff6', 3, 'III', 'Ballabile', 'Sonate pour violoncelle et piano, op. 143 : III. Ballabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11075 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee64dbe-a3c3-43a5-8406-c1d4e9ef1ff6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Sonate pour violoncelle et piano, op. 143 : IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11075 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:355f663c-75bf-47a1-86ad-4c6b564f9d3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:355f663c-75bf-47a1-86ad-4c6b564f9d3b', 4, 'IV', 'Finale', 'Sonate pour violoncelle et piano, op. 143 : IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11075 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:355f663c-75bf-47a1-86ad-4c6b564f9d3b'
);


-- None Souvenirs

UPDATE pieces piece
SET piece.title = 'Souvenirs', piece.title_en = 'Souvenirs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9738 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stabat Mater, FP 148

UPDATE pieces piece
SET piece.title = 'Stabat Mater, FP 148', piece.title_en = 'Stabat Mater, FP 148',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10623 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Stabat Mater dolorosa', part.name_en = 'Stabat Mater, FP 148: I. Stabat Mater dolorosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7b4c0d49-24ce-437b-909e-5432e2ad006b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b4c0d49-24ce-437b-909e-5432e2ad006b', 1, 'I', 'Stabat Mater dolorosa', 'Stabat Mater, FP 148: I. Stabat Mater dolorosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b4c0d49-24ce-437b-909e-5432e2ad006b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cuius animam gementem', part.name_en = 'Stabat Mater, FP 148: II. Cuius animam gementem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ef5d371b-e9ba-49fd-b61a-ef1f32f18a93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef5d371b-e9ba-49fd-b61a-ef1f32f18a93', 2, 'II', 'Cuius animam gementem', 'Stabat Mater, FP 148: II. Cuius animam gementem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5d371b-e9ba-49fd-b61a-ef1f32f18a93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'O quam tristis', part.name_en = 'Stabat Mater, FP 148: III. O quam tristis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e0baa499-67ee-450b-868a-6f6545c26ba4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0baa499-67ee-450b-868a-6f6545c26ba4', 3, 'III', 'O quam tristis', 'Stabat Mater, FP 148: III. O quam tristis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0baa499-67ee-450b-868a-6f6545c26ba4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quae moerebat', part.name_en = 'Stabat Mater, FP 148: IV. Quae moerebat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5970fb63-2002-4fb0-af27-10e0f19d32a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5970fb63-2002-4fb0-af27-10e0f19d32a1', 4, 'IV', 'Quae moerebat', 'Stabat Mater, FP 148: IV. Quae moerebat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5970fb63-2002-4fb0-af27-10e0f19d32a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Quis est homo', part.name_en = 'Stabat Mater, FP 148: V. Quis est homo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:50cbc93e-7847-4ae7-a721-4cb858cfcbb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50cbc93e-7847-4ae7-a721-4cb858cfcbb1', 5, 'V', 'Quis est homo', 'Stabat Mater, FP 148: V. Quis est homo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50cbc93e-7847-4ae7-a721-4cb858cfcbb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Vidit suum', part.name_en = 'Stabat Mater, FP 148: VI. Vidit suum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:9fb51b45-7987-4fe5-b615-57b89754cdbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fb51b45-7987-4fe5-b615-57b89754cdbf', 6, 'VI', 'Vidit suum', 'Stabat Mater, FP 148: VI. Vidit suum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fb51b45-7987-4fe5-b615-57b89754cdbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Eia, Mater', part.name_en = 'Stabat Mater, FP 148: VII. Eia, Mater',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6a85f172-6709-41ae-a872-20af3b750820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a85f172-6709-41ae-a872-20af3b750820', 7, 'VII', 'Eia, Mater', 'Stabat Mater, FP 148: VII. Eia, Mater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a85f172-6709-41ae-a872-20af3b750820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Fac ut ardeat', part.name_en = 'Stabat Mater, FP 148: VIII. Fac ut ardeat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:865d6078-fdfd-4f33-8a41-416516794f71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:865d6078-fdfd-4f33-8a41-416516794f71', 8, 'VIII', 'Fac ut ardeat', 'Stabat Mater, FP 148: VIII. Fac ut ardeat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:865d6078-fdfd-4f33-8a41-416516794f71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Sancta Mater', part.name_en = 'Stabat Mater, FP 148: IX. Sancta Mater',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3142bc99-8d49-404c-8ec3-8bda36bfee6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3142bc99-8d49-404c-8ec3-8bda36bfee6d', 9, 'IX', 'Sancta Mater', 'Stabat Mater, FP 148: IX. Sancta Mater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3142bc99-8d49-404c-8ec3-8bda36bfee6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Fac ut portem', part.name_en = 'Stabat Mater, FP 148: X. Fac ut portem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a77181eb-d063-4e0c-8c20-70a706909a5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a77181eb-d063-4e0c-8c20-70a706909a5b', 10, 'X', 'Fac ut portem', 'Stabat Mater, FP 148: X. Fac ut portem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a77181eb-d063-4e0c-8c20-70a706909a5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Inflammatus et accensus', part.name_en = 'Stabat Mater, FP 148: XI. Inflammatus et accensus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:34169eee-272c-4c81-9e3c-a8d9aae1d62c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34169eee-272c-4c81-9e3c-a8d9aae1d62c', 11, 'XI', 'Inflammatus et accensus', 'Stabat Mater, FP 148: XI. Inflammatus et accensus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34169eee-272c-4c81-9e3c-a8d9aae1d62c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Quando corpus morietur', part.name_en = 'Stabat Mater, FP 148: XII. Quando corpus morietur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10623 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:7ba842cd-7ab4-433c-aac2-8600f8d6b8be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba842cd-7ab4-433c-aac2-8600f8d6b8be', 12, 'XII', 'Quando corpus morietur', 'Stabat Mater, FP 148: XII. Quando corpus morietur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10623 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba842cd-7ab4-433c-aac2-8600f8d6b8be'
);


-- None 피아노 모음곡 C장조

UPDATE pieces piece
SET piece.title = '피아노 모음곡 C장조', piece.title_en = 'Suite for piano in C major, FP 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7914 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Suite for piano in C major: I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:12b7a8be-89c0-498b-8e38-5da529730aa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b7a8be-89c0-498b-8e38-5da529730aa8', 1, 'I', 'Presto', 'Suite for piano in C major: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b7a8be-89c0-498b-8e38-5da529730aa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Suite for piano in C major: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:676c37ae-175b-44a9-9469-253462cede2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:676c37ae-175b-44a9-9469-253462cede2a', 2, 'II', 'Andante', 'Suite for piano in C major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676c37ae-175b-44a9-9469-253462cede2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vif', part.name_en = 'Suite for piano in C major: III. Vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7914 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fc03785a-5013-40c1-bed5-eb1b961d8795' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc03785a-5013-40c1-bed5-eb1b961d8795', 3, 'III', 'Vif', 'Suite for piano in C major: III. Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7914 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc03785a-5013-40c1-bed5-eb1b961d8795'
);


-- None 칸타타 <Sécheresses, FP 90>

UPDATE pieces piece
SET piece.title = '칸타타 <Sécheresses, FP 90>', piece.title_en = 'Sécheresses, FP 90',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10036 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Les sauterelles', part.name_en = 'Sécheresses : I. Les sauterelles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10036 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:600d7dcb-fdb4-4188-a1dc-d60020759df9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600d7dcb-fdb4-4188-a1dc-d60020759df9', 1, 'I', 'Les sauterelles', 'Sécheresses : I. Les sauterelles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10036 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600d7dcb-fdb4-4188-a1dc-d60020759df9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le village abandonné', part.name_en = 'Sécheresses : II. Le village abandonné',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10036 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6dbab7dc-844c-4de1-b78e-1a7c96120d0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbab7dc-844c-4de1-b78e-1a7c96120d0d', 2, 'II', 'Le village abandonné', 'Sécheresses : II. Le village abandonné', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10036 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbab7dc-844c-4de1-b78e-1a7c96120d0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le faux avenir', part.name_en = 'Sécheresses : III. Le faux avenir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10036 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:080164d0-a8be-40af-9e48-6455cbba95cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:080164d0-a8be-40af-9e48-6455cbba95cd', 3, 'III', 'Le faux avenir', 'Sécheresses : III. Le faux avenir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10036 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:080164d0-a8be-40af-9e48-6455cbba95cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le squelette de la mer', part.name_en = 'Sécheresses : IV. Le squelette de la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10036 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:506b314b-fca8-4d8d-abaa-de6b7110a729' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506b314b-fca8-4d8d-abaa-de6b7110a729', 4, 'IV', 'Le squelette de la mer', 'Sécheresses : IV. Le squelette de la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10036 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506b314b-fca8-4d8d-abaa-de6b7110a729'
);


-- None 연가곡집 <Tel jour telle nuit, FP 86>

UPDATE pieces piece
SET piece.title = '연가곡집 <Tel jour telle nuit, FP 86>', piece.title_en = 'Tel jour telle nuit, FP 86',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9270 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bonne journée', part.name_en = 'Tel jour telle nuit, FP 86: 1. Bonne journée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:23e7441b-e207-4338-a5fa-c37f215de728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23e7441b-e207-4338-a5fa-c37f215de728', 1, NULL, 'Bonne journée', 'Tel jour telle nuit, FP 86: 1. Bonne journée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23e7441b-e207-4338-a5fa-c37f215de728'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Une ruine coquille vide', part.name_en = 'Tel jour telle nuit, FP 86: 2. Une ruine coquille vide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2c8036c1-d2d0-424d-bb8d-97fd040ad00e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c8036c1-d2d0-424d-bb8d-97fd040ad00e', 2, NULL, 'Une ruine coquille vide', 'Tel jour telle nuit, FP 86: 2. Une ruine coquille vide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c8036c1-d2d0-424d-bb8d-97fd040ad00e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le front comme un drapeau perdu', part.name_en = 'Tel jour telle nuit, FP 86: 3. Le front comme un drapeau perdu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ff23d5ca-4dca-4b9b-bf07-0417a636780c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff23d5ca-4dca-4b9b-bf07-0417a636780c', 3, NULL, 'Le front comme un drapeau perdu', 'Tel jour telle nuit, FP 86: 3. Le front comme un drapeau perdu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff23d5ca-4dca-4b9b-bf07-0417a636780c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Une roulotte couverte en tuiles', part.name_en = 'Tel jour telle nuit, FP 86: 4. Une roulotte couverte en tuiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:e34dc8f2-1968-422a-9032-f92c8635da4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e34dc8f2-1968-422a-9032-f92c8635da4a', 4, NULL, 'Une roulotte couverte en tuiles', 'Tel jour telle nuit, FP 86: 4. Une roulotte couverte en tuiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34dc8f2-1968-422a-9032-f92c8635da4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'À toutes brides', part.name_en = 'Tel jour telle nuit, FP 86: 5. À toutes brides',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:13ae3dd8-7354-4697-b3c5-4590feb456aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ae3dd8-7354-4697-b3c5-4590feb456aa', 5, NULL, 'À toutes brides', 'Tel jour telle nuit, FP 86: 5. À toutes brides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ae3dd8-7354-4697-b3c5-4590feb456aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Une herbe pauvre', part.name_en = 'Tel jour telle nuit, FP 86: 6. Une herbe pauvre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8917de5f-8790-45e4-816d-88e58a834737' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8917de5f-8790-45e4-816d-88e58a834737', 6, NULL, 'Une herbe pauvre', 'Tel jour telle nuit, FP 86: 6. Une herbe pauvre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8917de5f-8790-45e4-816d-88e58a834737'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Je n''ai envie que de t''aimer', part.name_en = 'Tel jour telle nuit, FP 86: 7. Je n''ai envie que de t''aimer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:78c5e0e9-ff52-4bce-a139-119f2ff71805' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c5e0e9-ff52-4bce-a139-119f2ff71805', 7, NULL, 'Je n''ai envie que de t''aimer', 'Tel jour telle nuit, FP 86: 7. Je n''ai envie que de t''aimer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c5e0e9-ff52-4bce-a139-119f2ff71805'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Figure de force brûlante et farouche', part.name_en = 'Tel jour telle nuit, FP 86: 8. Figure de force brûlante et farouche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fb8a3dbc-24b7-4661-a67d-3d2d3e5207c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb8a3dbc-24b7-4661-a67d-3d2d3e5207c4', 8, NULL, 'Figure de force brûlante et farouche', 'Tel jour telle nuit, FP 86: 8. Figure de force brûlante et farouche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8a3dbc-24b7-4661-a67d-3d2d3e5207c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Nous avons fait la nuit', part.name_en = 'Tel jour telle nuit, FP 86: 9. Nous avons fait la nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9270 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:66a4b95e-57e7-4dca-a41c-cbce09582abc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66a4b95e-57e7-4dca-a41c-cbce09582abc', 9, NULL, 'Nous avons fait la nuit', 'Tel jour telle nuit, FP 86: 9. Nous avons fait la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9270 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66a4b95e-57e7-4dca-a41c-cbce09582abc'
);


-- None Thème varié, FP 151

UPDATE pieces piece
SET piece.title = 'Thème varié, FP 151', piece.title_en = 'Thème varié, FP 151',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10425 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme (Très calme et sans hâte)', part.name_en = 'Thème varié: Theme (Très calme et sans hâte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:543362e3-f69b-41f1-9326-ec7a68b77a13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:543362e3-f69b-41f1-9326-ec7a68b77a13', 1, NULL, 'Theme (Très calme et sans hâte)', 'Thème varié: Theme (Très calme et sans hâte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543362e3-f69b-41f1-9326-ec7a68b77a13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation 1: Joyeuse (Allegro molto)', part.name_en = 'Thème varié: Variation 1: Joyeuse (Allegro molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:fbe5ccd8-0439-4eda-8799-c2dc2f79771a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbe5ccd8-0439-4eda-8799-c2dc2f79771a', 2, NULL, 'Variation 1: Joyeuse (Allegro molto)', 'Thème varié: Variation 1: Joyeuse (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbe5ccd8-0439-4eda-8799-c2dc2f79771a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation 2: Noble (Lent)', part.name_en = 'Thème varié: Variation 2: Noble (Lent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:65c56edc-d82b-4f94-9b5a-052eec4dccf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65c56edc-d82b-4f94-9b5a-052eec4dccf3', 3, NULL, 'Variation 2: Noble (Lent)', 'Thème varié: Variation 2: Noble (Lent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65c56edc-d82b-4f94-9b5a-052eec4dccf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation 3: Pastorale (Allegretto)', part.name_en = 'Thème varié: Variation 3: Pastorale (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:89a5ccbe-c670-4650-a417-22aee231384f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89a5ccbe-c670-4650-a417-22aee231384f', 4, NULL, 'Variation 3: Pastorale (Allegretto)', 'Thème varié: Variation 3: Pastorale (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a5ccbe-c670-4650-a417-22aee231384f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation 4: Sarcastique (Allegro molto, très violent)', part.name_en = 'Thème varié: Variation 4: Sarcastique (Allegro molto, très violent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0ceb26fe-39a1-474d-a98e-c3b911384c72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ceb26fe-39a1-474d-a98e-c3b911384c72', 5, NULL, 'Variation 4: Sarcastique (Allegro molto, très violent)', 'Thème varié: Variation 4: Sarcastique (Allegro molto, très violent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ceb26fe-39a1-474d-a98e-c3b911384c72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation 5: Mélancolique (Très calme)', part.name_en = 'Thème varié: Variation 5: Mélancolique (Très calme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a9593641-fe9c-49fd-b77a-33983a457d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9593641-fe9c-49fd-b77a-33983a457d45', 6, NULL, 'Variation 5: Mélancolique (Très calme)', 'Thème varié: Variation 5: Mélancolique (Très calme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9593641-fe9c-49fd-b77a-33983a457d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation 6: Ironique (Allegretto)', part.name_en = 'Thème varié: Variation 6: Ironique (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5d622957-37b7-4553-9a38-a06be4009411' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d622957-37b7-4553-9a38-a06be4009411', 7, NULL, 'Variation 6: Ironique (Allegretto)', 'Thème varié: Variation 6: Ironique (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d622957-37b7-4553-9a38-a06be4009411'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation 7: Élégiaque (Excessivement)', part.name_en = 'Thème varié: Variation 7: Élégiaque (Excessivement)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5053fd63-91d2-48c0-9eca-9904d38efeee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5053fd63-91d2-48c0-9eca-9904d38efeee', 8, NULL, 'Variation 7: Élégiaque (Excessivement)', 'Thème varié: Variation 7: Élégiaque (Excessivement)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5053fd63-91d2-48c0-9eca-9904d38efeee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation 8: Volubile (Presto)', part.name_en = 'Thème varié: Variation 8: Volubile (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3c1a84cb-8edb-4918-8fdd-c38801e6c5ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c1a84cb-8edb-4918-8fdd-c38801e6c5ac', 9, NULL, 'Variation 8: Volubile (Presto)', 'Thème varié: Variation 8: Volubile (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c1a84cb-8edb-4918-8fdd-c38801e6c5ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variation 9: Fantasque (Allegretto molto)', part.name_en = 'Thème varié: Variation 9: Fantasque (Allegretto molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c57192f4-7600-4171-a46c-c14ba4f7c0ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c57192f4-7600-4171-a46c-c14ba4f7c0ec', 10, NULL, 'Variation 9: Fantasque (Allegretto molto)', 'Thème varié: Variation 9: Fantasque (Allegretto molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c57192f4-7600-4171-a46c-c14ba4f7c0ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Variation 10: Sybilline (Bien lent)', part.name_en = 'Thème varié: Variation 10: Sybilline (Bien lent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:5787bc83-c54b-426a-9682-fbf1c7af6d87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5787bc83-c54b-426a-9682-fbf1c7af6d87', 11, NULL, 'Variation 10: Sybilline (Bien lent)', 'Thème varié: Variation 10: Sybilline (Bien lent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5787bc83-c54b-426a-9682-fbf1c7af6d87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Variation 11: Finale (Allegro molto)', part.name_en = 'Thème varié: Variation 11: Finale (Allegro molto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10425 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:393f1b6c-8a18-47bd-a511-3ce1260087fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:393f1b6c-8a18-47bd-a511-3ce1260087fa', 12, NULL, 'Variation 11: Finale (Allegro molto)', 'Thème varié: Variation 11: Finale (Allegro molto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10425 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:393f1b6c-8a18-47bd-a511-3ce1260087fa'
);


-- None 가곡 <Toréador, FP 11>

UPDATE pieces piece
SET piece.title = '가곡 <Toréador, FP 11>', piece.title_en = 'Toréador, FP 11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10567 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio for flute, cello and piano

UPDATE pieces piece
SET piece.title = 'Trio for flute, cello and piano', piece.title_en = 'Trio for flute, cello and piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7973 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Trio for flute, cello and piano: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7973 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:25f2689b-89a3-46ea-80e9-f1d708996664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f2689b-89a3-46ea-80e9-f1d708996664', 1, NULL, 'I', 'Trio for flute, cello and piano: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7973 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f2689b-89a3-46ea-80e9-f1d708996664'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Trio for flute, cello and piano: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7973 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2a911235-a82a-4cd9-96c1-5778226535e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a911235-a82a-4cd9-96c1-5778226535e0', 2, NULL, 'Andante', 'Trio for flute, cello and piano: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7973 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a911235-a82a-4cd9-96c1-5778226535e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rondo', part.name_en = 'Trio for flute, cello and piano: III. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7973 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c9a7f5d6-de51-458e-865a-5c8e6ce481f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9a7f5d6-de51-458e-865a-5c8e6ce481f0', 3, NULL, 'Rondo', 'Trio for flute, cello and piano: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7973 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a7f5d6-de51-458e-865a-5c8e6ce481f0'
);


-- None Trio pour piano, hautbois et basson, FP 43

UPDATE pieces piece
SET piece.title = 'Trio pour piano, hautbois et basson, FP 43', piece.title_en = 'Trio pour piano, hautbois et basson, FP 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9601 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Presto', part.name_en = 'Trio pour piano, hautbois et basson: I. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9601 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:31d7b828-cd73-308e-9603-c0a080e0d5a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31d7b828-cd73-308e-9603-c0a080e0d5a9', 1, 'I', 'Presto', 'Trio pour piano, hautbois et basson: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9601 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31d7b828-cd73-308e-9603-c0a080e0d5a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Trio pour piano, hautbois et basson: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9601 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:04e8fccd-3cd8-39a9-871a-37c39eb7577f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e8fccd-3cd8-39a9-871a-37c39eb7577f', 2, 'II', 'Andante', 'Trio pour piano, hautbois et basson: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9601 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e8fccd-3cd8-39a9-871a-37c39eb7577f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo', part.name_en = 'Trio pour piano, hautbois et basson: III. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9601 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:b6b15403-059e-315b-be3d-7136d68f5c52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6b15403-059e-315b-be3d-7136d68f5c52', 3, 'III', 'Rondo', 'Trio pour piano, hautbois et basson: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9601 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6b15403-059e-315b-be3d-7136d68f5c52'
);


-- None Trois chansons de F. García Lorca, FP 136

UPDATE pieces piece
SET piece.title = 'Trois chansons de F. García Lorca, FP 136', piece.title_en = 'Trois chansons de F. García Lorca, FP 136',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10204 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L''enfant muet', part.name_en = 'Trois chansons de F. García Lorca, FP 136: 1. L''enfant muet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10204 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:09a283d9-a325-46ca-b06d-56ae5f5720a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09a283d9-a325-46ca-b06d-56ae5f5720a7', 1, NULL, 'L''enfant muet', 'Trois chansons de F. García Lorca, FP 136: 1. L''enfant muet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10204 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09a283d9-a325-46ca-b06d-56ae5f5720a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adelina à la promenade', part.name_en = 'Trois chansons de F. García Lorca, FP 136: 2. Adelina à la promenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10204 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2bcc8b98-f26c-415a-ab56-b1e4e1efec64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bcc8b98-f26c-415a-ab56-b1e4e1efec64', 2, NULL, 'Adelina à la promenade', 'Trois chansons de F. García Lorca, FP 136: 2. Adelina à la promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10204 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bcc8b98-f26c-415a-ab56-b1e4e1efec64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chanson de l''oranger sec', part.name_en = 'Trois chansons de F. García Lorca, FP 136: 3. Chanson de l''oranger sec',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10204 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:3f588eb1-92a2-42b7-aa30-6b361bd9acca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f588eb1-92a2-42b7-aa30-6b361bd9acca', 3, NULL, 'Chanson de l''oranger sec', 'Trois chansons de F. García Lorca, FP 136: 3. Chanson de l''oranger sec', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10204 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f588eb1-92a2-42b7-aa30-6b361bd9acca'
);


-- None Trois mouvements perpétuels, FP 14a

UPDATE pieces piece
SET piece.title = 'Trois mouvements perpétuels, FP 14a', piece.title_en = 'Trois mouvements perpétuels, FP 14a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10712 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Assez modéré', part.name_en = 'Trois mouvements perpétuels, FP 14a: I. Assez modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10712 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:6051a9c2-171f-44c7-a28e-5176e930204e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6051a9c2-171f-44c7-a28e-5176e930204e', 1, 'I', 'Assez modéré', 'Trois mouvements perpétuels, FP 14a: I. Assez modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10712 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6051a9c2-171f-44c7-a28e-5176e930204e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très modéré', part.name_en = 'Trois mouvements perpétuels, FP 14a: II. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10712 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:1c4faaf7-e987-4c6e-903c-05f0faeda9e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c4faaf7-e987-4c6e-903c-05f0faeda9e6', 2, 'II', 'Très modéré', 'Trois mouvements perpétuels, FP 14a: II. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10712 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4faaf7-e987-4c6e-903c-05f0faeda9e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alerte', part.name_en = 'Trois mouvements perpétuels, FP 14a: III. Alerte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10712 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:2104f6d5-f52f-4926-bc35-58d4b853e6d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2104f6d5-f52f-4926-bc35-58d4b853e6d5', 3, 'III', 'Alerte', 'Trois mouvements perpétuels, FP 14a: III. Alerte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10712 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2104f6d5-f52f-4926-bc35-58d4b853e6d5'
);


-- None Trois pastorales, FP 5

UPDATE pieces piece
SET piece.title = 'Trois pastorales, FP 5', piece.title_en = 'Trois pastorales, FP 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9796 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Très lent', part.name_en = 'Trois pastorales: II. Très lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9796 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:54a0225a-faf7-48f5-93a3-02b13310aff7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a0225a-faf7-48f5-93a3-02b13310aff7', 1, 'II', 'Très lent', 'Trois pastorales: II. Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9796 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a0225a-faf7-48f5-93a3-02b13310aff7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Très vite', part.name_en = 'Trois pastorales: I. Très vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9796 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ad37a5ac-1e71-4039-866e-f6be9692bd68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad37a5ac-1e71-4039-866e-f6be9692bd68', 2, 'I', 'Très vite', 'Trois pastorales: I. Très vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9796 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad37a5ac-1e71-4039-866e-f6be9692bd68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vite', part.name_en = 'Trois pastorales: III. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9796 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:c6cfcac5-224c-4f6d-8c91-cc2f6abceec5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6cfcac5-224c-4f6d-8c91-cc2f6abceec5', 3, 'III', 'Vite', 'Trois pastorales: III. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9796 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6cfcac5-224c-4f6d-8c91-cc2f6abceec5'
);


-- None Trois pièces, FP 48

UPDATE pieces piece
SET piece.title = 'Trois pièces, FP 48', piece.title_en = 'Trois pièces, FP 48',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8613 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pastorale', part.name_en = 'Trois pièces: I. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8613 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:11b7c66b-d852-4f5c-91fe-d411b3c313a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11b7c66b-d852-4f5c-91fe-d411b3c313a2', 1, 'I', 'Pastorale', 'Trois pièces: I. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8613 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11b7c66b-d852-4f5c-91fe-d411b3c313a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hymne', part.name_en = 'Trois pièces: II. Hymne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8613 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:55b3c69a-064c-4e13-8552-6b7d0d39ae96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55b3c69a-064c-4e13-8552-6b7d0d39ae96', 2, 'II', 'Hymne', 'Trois pièces: II. Hymne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8613 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55b3c69a-064c-4e13-8552-6b7d0d39ae96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata', part.name_en = 'Trois pièces: III. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8613 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0cc6e8eb-2b61-48b6-9448-ab351a9a5fd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cc6e8eb-2b61-48b6-9448-ab351a9a5fd7', 3, 'III', 'Toccata', 'Trois pièces: III. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8613 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cc6e8eb-2b61-48b6-9448-ab351a9a5fd7'
);


-- None Trois poèmes de Louise Lalanne, FP 57

UPDATE pieces piece
SET piece.title = 'Trois poèmes de Louise Lalanne, FP 57', piece.title_en = 'Trois poèmes de Louise Lalanne, FP 57',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9457 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le présent', part.name_en = 'Trois poèmes de Louise Lalanne, FP 57: 1. Le présent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9457 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:681dfd6b-805d-4fad-9ca3-760e90794194' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:681dfd6b-805d-4fad-9ca3-760e90794194', 1, NULL, 'Le présent', 'Trois poèmes de Louise Lalanne, FP 57: 1. Le présent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9457 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:681dfd6b-805d-4fad-9ca3-760e90794194'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chanson', part.name_en = 'Trois poèmes de Louise Lalanne, FP 57: 2. Chanson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9457 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:0d12cecc-0d2a-4e99-b038-d52dab6d414d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d12cecc-0d2a-4e99-b038-d52dab6d414d', 2, NULL, 'Chanson', 'Trois poèmes de Louise Lalanne, FP 57: 2. Chanson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9457 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d12cecc-0d2a-4e99-b038-d52dab6d414d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hier', part.name_en = 'Trois poèmes de Louise Lalanne, FP 57: 3. Hier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9457 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:ea5bf0c5-ae38-4acf-9b1c-81a99e93f4a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5bf0c5-ae38-4acf-9b1c-81a99e93f4a1', 3, NULL, 'Hier', 'Trois poèmes de Louise Lalanne, FP 57: 3. Hier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9457 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5bf0c5-ae38-4acf-9b1c-81a99e93f4a1'
);


-- None Trois poèmes de Louise de Vilmorin, FP 91

UPDATE pieces piece
SET piece.title = 'Trois poèmes de Louise de Vilmorin, FP 91', piece.title_en = 'Trois poèmes de Louise de Vilmorin, FP 91',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10368 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le garçon de Liège', part.name_en = 'Trois poèmes de Louise de Vilmorin, FP 91: 1. Le garçon de Liège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10368 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:a2ab0462-6b01-452a-be18-a7002dd12387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2ab0462-6b01-452a-be18-a7002dd12387', 1, NULL, 'Le garçon de Liège', 'Trois poèmes de Louise de Vilmorin, FP 91: 1. Le garçon de Liège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10368 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2ab0462-6b01-452a-be18-a7002dd12387'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Au-delà', part.name_en = 'Trois poèmes de Louise de Vilmorin, FP 91: 2. Au-delà',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10368 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8076484e-2485-45e2-ac31-d23a06c4aca7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8076484e-2485-45e2-ac31-d23a06c4aca7', 2, NULL, 'Au-delà', 'Trois poèmes de Louise de Vilmorin, FP 91: 2. Au-delà', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10368 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8076484e-2485-45e2-ac31-d23a06c4aca7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aux officiers de la Garde Blanche', part.name_en = 'Trois poèmes de Louise de Vilmorin, FP 91: 3. Aux officiers de la Garde Blanche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10368 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:8ac7710a-a320-4430-ab33-1701d3cd25c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ac7710a-a320-4430-ab33-1701d3cd25c7', 3, NULL, 'Aux officiers de la Garde Blanche', 'Trois poèmes de Louise de Vilmorin, FP 91: 3. Aux officiers de la Garde Blanche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10368 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ac7710a-a320-4430-ab33-1701d3cd25c7'
);


-- None Un joueur de flûte berce les ruines

UPDATE pieces piece
SET piece.title = 'Un joueur de flûte berce les ruines', piece.title_en = 'Un joueur de flûte berce les ruines',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9431 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Un soir de neige>

UPDATE pieces piece
SET piece.title = '칸타타 <Un soir de neige>', piece.title_en = 'Un soir de neige',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7649 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'De grandes cuillers de neige', part.name_en = 'Un soir de neige: I. De grandes cuillers de neige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7649 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:d4c80ec1-dd5f-4e32-b173-64d3585027d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4c80ec1-dd5f-4e32-b173-64d3585027d1', 1, 'I', 'De grandes cuillers de neige', 'Un soir de neige: I. De grandes cuillers de neige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7649 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4c80ec1-dd5f-4e32-b173-64d3585027d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La bonne neige', part.name_en = 'Un soir de neige: II. La bonne neige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7649 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:cee79545-5f42-4a87-8f17-a56f0713351a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee79545-5f42-4a87-8f17-a56f0713351a', 2, 'II', 'La bonne neige', 'Un soir de neige: II. La bonne neige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7649 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee79545-5f42-4a87-8f17-a56f0713351a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bois meurtri', part.name_en = 'Un soir de neige: III. Bois meurtri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7649 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:70a4cfa5-eeb8-4a21-994e-9ed0a0f1c7f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70a4cfa5-eeb8-4a21-994e-9ed0a0f1c7f9', 3, 'III', 'Bois meurtri', 'Un soir de neige: III. Bois meurtri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7649 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a4cfa5-eeb8-4a21-994e-9ed0a0f1c7f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La nuit le froid la solitude', part.name_en = 'Un soir de neige: IV. La nuit le froid la solitude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7649 AND p.composer_id = 107 AND part.part_key = 'musicbrainz:4062d1fc-f67e-4c44-b3f1-05d6abce6337' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4062d1fc-f67e-4c44-b3f1-05d6abce6337', 4, 'IV', 'La nuit le froid la solitude', 'Un soir de neige: IV. La nuit le froid la solitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7649 AND p.composer_id = 107
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4062d1fc-f67e-4c44-b3f1-05d6abce6337'
);


-- None 가곡 <Une chanson de porcelaine, FP 169>

UPDATE pieces piece
SET piece.title = '가곡 <Une chanson de porcelaine, FP 169>', piece.title_en = 'Une chanson de porcelaine, FP 169',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8844 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse des Musiques de soie

UPDATE pieces piece
SET piece.title = 'Valse des Musiques de soie', piece.title_en = 'Valse des Musiques de soie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9015 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse-improvisation sur le nom de Bach, for piano, FP 62

UPDATE pieces piece
SET piece.title = 'Valse-improvisation sur le nom de Bach, for piano, FP 62', piece.title_en = 'Valse-improvisation sur le nom de Bach, for piano, FP 62',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10168 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Videntes stellam

UPDATE pieces piece
SET piece.title = 'Videntes stellam', piece.title_en = 'Videntes stellam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10998 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Viens, une flûte invisible soupire>

UPDATE pieces piece
SET piece.title = '가곡 <Viens, une flûte invisible soupire>', piece.title_en = 'Viens, une flûte invisible soupire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8214 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Villanelle, FP 74

UPDATE pieces piece
SET piece.title = 'Villanelle, FP 74', piece.title_en = 'Villanelle, FP 74',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9844 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vive Nadia, FP 167>

UPDATE pieces piece
SET piece.title = '가곡 <Vive Nadia, FP 167>', piece.title_en = 'Vive Nadia, FP 167',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8318 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vocalise, FP 44>

UPDATE pieces piece
SET piece.title = '가곡 <Vocalise, FP 44>', piece.title_en = 'Vocalise, FP 44',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8176 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <À sa guitare, FP 79>

UPDATE pieces piece
SET piece.title = '가곡 <À sa guitare, FP 79>', piece.title_en = 'À sa guitare, FP 79',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11244 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Élégie (en accords alternés) pour deux pianos, FP 175

UPDATE pieces piece
SET piece.title = 'Élégie (en accords alternés) pour deux pianos, FP 175', piece.title_en = 'Élégie (en accords alternés) pour deux pianos, FP 175',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10357 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Élégie pour cor et piano, FP 168

UPDATE pieces piece
SET piece.title = 'Élégie pour cor et piano, FP 168', piece.title_en = 'Élégie pour cor et piano, FP 168',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10586 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Épitaphe, FP 55>

UPDATE pieces piece
SET piece.title = '가곡 <Épitaphe, FP 55>', piece.title_en = 'Épitaphe, FP 55',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8466 AND piece.composer_id = 107
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bucolique, FP 160

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bucolique, FP 160', 'Bucolique, FP 160', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bucolique, FP 160'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31215af1-eb03-4a75-9d2e-8f1daf83b548'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31215af1-eb03-4a75-9d2e-8f1daf83b548'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Bucolique, FP 160' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31215af1-eb03-4a75-9d2e-8f1daf83b548'
);


-- None Concert champêtre, FP 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concert champêtre, FP 49', 'Concert champêtre, FP 49', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concert champêtre, FP 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f82aed-6b16-4d15-803e-2d6c27d913e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4f82aed-6b16-4d15-803e-2d6c27d913e1'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Concert champêtre, FP 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4f82aed-6b16-4d15-803e-2d6c27d913e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66df6172-dfe9-3b72-ac62-cbb47dfc9a8f', 1, 'I', 'Allegro molto - Adagio - Allegro molto', 'Concert champêtre, FP 49 : I. Allegro molto - Adagio - Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Concert champêtre, FP 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66df6172-dfe9-3b72-ac62-cbb47dfc9a8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97020d2d-7416-31dd-8053-06147c3c384a', 2, 'II', 'Andante, Mouvement de Sicilienne', 'Concert champêtre, FP 49 : II. Andante, Mouvement de Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Concert champêtre, FP 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97020d2d-7416-31dd-8053-06147c3c384a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfaf257a-18c6-3936-a47c-532f3780d007', 3, 'III', 'Finale, Presto très gai', 'Concert champêtre, FP 49 : III. Finale, Presto très gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Concert champêtre, FP 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfaf257a-18c6-3936-a47c-532f3780d007'
);


-- None 가곡 <La dame de Monte-Carlo, FP 180>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La dame de Monte-Carlo, FP 180>', 'La dame de Monte-Carlo, FP 180', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La dame de Monte-Carlo, FP 180>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deb08f77-e339-430d-8c01-daac0b73ff7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'deb08f77-e339-430d-8c01-daac0b73ff7d'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '가곡 <La dame de Monte-Carlo, FP 180>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'deb08f77-e339-430d-8c01-daac0b73ff7d'
);


-- None Le Gendarme incompris, FP 20

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Le Gendarme incompris, FP 20', 'Le Gendarme incompris, FP 20', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Le Gendarme incompris, FP 20'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06312fb7-8d45-405c-8b04-65bdfb410098'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06312fb7-8d45-405c-8b04-65bdfb410098'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06312fb7-8d45-405c-8b04-65bdfb410098'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc19bfaa-90b4-4c77-a7de-c0461bb5b327', 1, 'I', 'Overture', 'Le Gendarme incompris, FP 20: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc19bfaa-90b4-4c77-a7de-c0461bb5b327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1a5bea2-4efd-44d9-a6a5-9a460a0c5b3f', 2, 'II', 'Scène I', 'Le Gendarme incompris, FP 20: II. Scène I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a5bea2-4efd-44d9-a6a5-9a460a0c5b3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6d32cd8-51ca-42ca-9911-83608ba5b0af', 3, 'III', 'Scène II', 'Le Gendarme incompris, FP 20: III. Scène II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6d32cd8-51ca-42ca-9911-83608ba5b0af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d362e81-6c9c-4818-b28d-ee7449023795', 4, 'IV', 'Impromptu de Monsieur Médor', 'Le Gendarme incompris, FP 20: IV. Impromptu de Monsieur Médor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d362e81-6c9c-4818-b28d-ee7449023795'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c7876b0-ad8b-4077-ab3b-2a2d7bd2c564', 5, 'V', 'Duo', 'Le Gendarme incompris, FP 20: V. Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c7876b0-ad8b-4077-ab3b-2a2d7bd2c564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9c50584-bab4-4422-9d31-db808ef9dcd0', 6, 'VI', 'Duo', 'Le Gendarme incompris, FP 20: VI. Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9c50584-bab4-4422-9d31-db808ef9dcd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e46de662-d805-4368-81ee-f3d57571eafb', 7, 'VII', 'Scène III', 'Le Gendarme incompris, FP 20: VII. Scène III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e46de662-d805-4368-81ee-f3d57571eafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e60aae4f-a5fb-4ca7-9c33-a783ff109da3', 8, 'VIII', 'Madrigal', 'Le Gendarme incompris, FP 20: VIII. Madrigal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e60aae4f-a5fb-4ca7-9c33-a783ff109da3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d49376a-10d8-4b94-8be8-4981164d6521', 9, 'IX', 'Scène IV (Final – Danse)', 'Le Gendarme incompris, FP 20: IX. Scène IV (Final – Danse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Le Gendarme incompris, FP 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d49376a-10d8-4b94-8be8-4981164d6521'
);


-- None 발레 <Les Biches, FP 36>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <Les Biches, FP 36>', 'Les Biches, FP 36', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <Les Biches, FP 36>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58dc9cb0-1f76-4dc7-9987-46bb0f93ce50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58dc9cb0-1f76-4dc7-9987-46bb0f93ce50'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58dc9cb0-1f76-4dc7-9987-46bb0f93ce50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92848b1a-beac-41f6-b190-4430aeab7c37', 1, NULL, 'Ouverture', 'Les Biches, FP 36: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92848b1a-beac-41f6-b190-4430aeab7c37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04b9eab9-9203-4c0f-993d-5c4caf952634', 2, NULL, 'Rondeau', 'Les Biches, FP 36: Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04b9eab9-9203-4c0f-993d-5c4caf952634'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510e4ab3-e76c-4330-9a6e-7de9be7ccc19', 3, NULL, 'Chanson dansée', 'Les Biches, FP 36: Chanson dansée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510e4ab3-e76c-4330-9a6e-7de9be7ccc19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00d7feb7-19da-443e-9ad8-779c5d166dc0', 4, NULL, 'Adagietto', 'Les Biches, FP 36: Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d7feb7-19da-443e-9ad8-779c5d166dc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:941d2adb-9e19-4351-b4c0-e4aee6f97cc2', 5, NULL, 'Jeu', 'Les Biches, FP 36: Jeu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941d2adb-9e19-4351-b4c0-e4aee6f97cc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21642eba-ad09-4dd0-9fda-a0d04ab9728c', 6, NULL, 'Rag-Mazurka', 'Les Biches, FP 36: Rag-Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21642eba-ad09-4dd0-9fda-a0d04ab9728c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dfa07e6-d5d5-4604-a024-dc0457621ccc', 7, NULL, 'Andantino', 'Les Biches, FP 36: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dfa07e6-d5d5-4604-a024-dc0457621ccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f934d68-2a6f-4c59-957c-1f48fd6d5cdb', 8, NULL, 'Petite chanson dansée', 'Les Biches, FP 36: Petite chanson dansée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f934d68-2a6f-4c59-957c-1f48fd6d5cdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f33c3228-ca1d-431f-b666-4950d625a890', 9, NULL, 'Final', 'Les Biches, FP 36: Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '발레 <Les Biches, FP 36>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33c3228-ca1d-431f-b666-4950d625a890'
);


-- None Litanies à la Vierge noire, FP 82

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Litanies à la Vierge noire, FP 82', 'Litanies à la Vierge noire, FP 82', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Litanies à la Vierge noire, FP 82'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3af37e6-2a4e-4fd3-ab27-e89c533ef5c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3af37e6-2a4e-4fd3-ab27-e89c533ef5c2'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Litanies à la Vierge noire, FP 82' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3af37e6-2a4e-4fd3-ab27-e89c533ef5c2'
);


-- None L’Histoire de Babar, le petit éléphant, FP 129

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'L’Histoire de Babar, le petit éléphant, FP 129', 'L’Histoire de Babar, le petit éléphant, FP 129', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'L’Histoire de Babar, le petit éléphant, FP 129'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5336821e-2f26-4bb9-973a-9e7d6dbea19c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5336821e-2f26-4bb9-973a-9e7d6dbea19c'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5336821e-2f26-4bb9-973a-9e7d6dbea19c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22cff1fa-d0e3-4665-8d5d-5a56c60547fa', 1, NULL, 'Retour en auto', 'La Véritable Histoire de Babar: Retour en auto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22cff1fa-d0e3-4665-8d5d-5a56c60547fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dfebc28-cb2b-41d3-aae3-9a2eec732e76', 2, NULL, 'La nuit est venue', 'La Véritable Histoire de Babar: La nuit est venue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dfebc28-cb2b-41d3-aae3-9a2eec732e76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e33dbe2-125e-454d-8996-edd1f2eef76e', 3, NULL, 'Arthur et Céleste', 'La Véritable Histoire de Babar: Arthur et Céleste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e33dbe2-125e-454d-8996-edd1f2eef76e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:952decbd-cf99-4ba5-a714-9296dfa3e715', 4, NULL, 'Babar et la Veille Dame', 'La Véritable Histoire de Babar: Babar et la Veille Dame', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952decbd-cf99-4ba5-a714-9296dfa3e715'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c33c1e54-f571-4f55-9e94-409a4d7fb363', 5, NULL, 'Mariage de Babar', 'La Véritable Histoire de Babar: Mariage de Babar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c33c1e54-f571-4f55-9e94-409a4d7fb363'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca9b3cfa-a155-4fed-87f1-8e60912e6b91', 6, NULL, 'Dans la grande fôret', 'La Véritable Histoire de Babar: Dans la grande fôret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'L’Histoire de Babar, le petit éléphant, FP 129' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca9b3cfa-a155-4fed-87f1-8e60912e6b91'
);


-- None Sonate pour clarinette et basson, FP 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonate pour clarinette et basson, FP 32', 'Sonate pour clarinette et basson, FP 32', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonate pour clarinette et basson, FP 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0006e9d7-0aca-4e72-85d9-4e787925a212'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0006e9d7-0aca-4e72-85d9-4e787925a212'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour clarinette et basson, FP 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0006e9d7-0aca-4e72-85d9-4e787925a212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd93bc1-6d58-419a-9378-e7f45803dabd', 1, 'I', 'Allegro : Très rythmé', 'Sonate pour clarinette et basson: I. Allegro : Très rythmé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour clarinette et basson, FP 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd93bc1-6d58-419a-9378-e7f45803dabd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d34b2d9-f6ee-4a12-b0d6-72096768a474', 2, 'II', 'Romance : Andante très doux', 'Sonate pour clarinette et basson: II. Romance : Andante très doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour clarinette et basson, FP 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d34b2d9-f6ee-4a12-b0d6-72096768a474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ded180e4-52c2-4e5c-978f-0c37838802df', 3, 'III', 'Final : Très animé', 'Sonate pour clarinette et basson: III. Final : Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour clarinette et basson, FP 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ded180e4-52c2-4e5c-978f-0c37838802df'
);


-- None Sonate pour cor, trompette et trombone, FP 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonate pour cor, trompette et trombone, FP 33', 'Sonate pour cor, trompette et trombone, FP 33', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonate pour cor, trompette et trombone, FP 33'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db25de4b-1299-48ab-93f7-7a1ccec0fc84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db25de4b-1299-48ab-93f7-7a1ccec0fc84'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour cor, trompette et trombone, FP 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db25de4b-1299-48ab-93f7-7a1ccec0fc84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ced1f5c-214f-4300-a7a8-4c519c8a4b95', 1, 'I', 'Allegro moderato : Grazioso', 'Sonate pour cor, trompette et trombone: I. Allegro moderato : Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour cor, trompette et trombone, FP 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ced1f5c-214f-4300-a7a8-4c519c8a4b95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:435ce49e-e4f9-4eda-b446-7f8749004208', 2, 'II', 'Andante : Très lent', 'Sonate pour cor, trompette et trombone: II. Andante : Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour cor, trompette et trombone, FP 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:435ce49e-e4f9-4eda-b446-7f8749004208'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32704cf6-e09c-4bb0-aa4f-c1a2ddc437ef', 3, 'III', 'Rondeau : Animé', 'Sonate pour cor, trompette et trombone: III. Rondeau : Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour cor, trompette et trombone, FP 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32704cf6-e09c-4bb0-aa4f-c1a2ddc437ef'
);


-- None Sonate pour deux clarinettes, FP 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonate pour deux clarinettes, FP 7', 'Sonate pour deux clarinettes, FP 7', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonate pour deux clarinettes, FP 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f892fd2-f03a-4964-81df-1e6e6bb20e1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f892fd2-f03a-4964-81df-1e6e6bb20e1a'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour deux clarinettes, FP 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f892fd2-f03a-4964-81df-1e6e6bb20e1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f606f66-7f07-4f09-85b6-90329e3a5f05', 1, 'I', 'Presto', 'Sonate pour deux clarinettes: I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour deux clarinettes, FP 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f606f66-7f07-4f09-85b6-90329e3a5f05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f5c98b4-fdee-49e4-898a-603c22d943ca', 2, 'II', 'Andante : Très lent', 'Sonate pour deux clarinettes: II. Andante : Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour deux clarinettes, FP 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f5c98b4-fdee-49e4-898a-603c22d943ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76eaff77-540b-4d2d-a32f-2104682f4074', 3, 'III', 'Vif : Vite, avec joie', 'Sonate pour deux clarinettes: III. Vif : Vite, avec joie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour deux clarinettes, FP 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76eaff77-540b-4d2d-a32f-2104682f4074'
);


-- None Sonate pour flûte et piano, FP 164

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonate pour flûte et piano, FP 164', 'Sonate pour flûte et piano, FP 164', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonate pour flûte et piano, FP 164'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea004e5-40c2-42a2-bfdd-7cfed58a8d2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ea004e5-40c2-42a2-bfdd-7cfed58a8d2b'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour flûte et piano, FP 164' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea004e5-40c2-42a2-bfdd-7cfed58a8d2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f5f0822-69bb-3306-9e88-51adac435209', 1, 'I', 'Allegro malincolico', 'Sonate pour flûte et piano, FP 164: I. Allegro malincolico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour flûte et piano, FP 164' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f5f0822-69bb-3306-9e88-51adac435209'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca367a58-8e43-3e39-a03a-36de5e6f26ad', 2, 'II', 'Cantilena', 'Sonate pour flûte et piano, FP 164: II. Cantilena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour flûte et piano, FP 164' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca367a58-8e43-3e39-a03a-36de5e6f26ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3d329bf-96a6-3862-a465-6d8b105f5c80', 3, 'III', 'Presto giocoso', 'Sonate pour flûte et piano, FP 164: III. Presto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Sonate pour flûte et piano, FP 164' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3d329bf-96a6-3862-a465-6d8b105f5c80'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Sérénade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb6b7acf-04eb-48ba-a64f-a3f616ed762d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb6b7acf-04eb-48ba-a64f-a3f616ed762d'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb6b7acf-04eb-48ba-a64f-a3f616ed762d'
);


-- None Villageoises, petites pièces infantines, for piano, FP 65

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Villageoises, petites pièces infantines, for piano, FP 65', 'Villageoises, petites pièces infantines, for piano, FP 65', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 107
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Villageoises, petites pièces infantines, for piano, FP 65'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7f4ce9e-fd3b-4807-9b59-58857521458b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7f4ce9e-fd3b-4807-9b59-58857521458b'
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7f4ce9e-fd3b-4807-9b59-58857521458b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad92b87-6332-4265-b7d2-2fba2db1e0f3', 1, 'I', 'Valse tyrolienne', 'Villageoises, petites pièces infantines: I. Valse tyrolienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad92b87-6332-4265-b7d2-2fba2db1e0f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc9f406-4f73-4525-9f65-a974d0edb385', 2, 'II', 'Staccato', 'Villageoises, petites pièces infantines: II. Staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc9f406-4f73-4525-9f65-a974d0edb385'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc94a2d-2054-4958-822a-2859f72f29cf', 3, 'III', 'Rustique', 'Villageoises, petites pièces infantines: III. Rustique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc94a2d-2054-4958-822a-2859f72f29cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:190d6c5f-6cbb-4226-aad8-aaae84bbe82c', 4, 'IV', 'Polka', 'Villageoises, petites pièces infantines: IV. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:190d6c5f-6cbb-4226-aad8-aaae84bbe82c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcb09b3a-b06f-439d-8612-2eaa88fcba62', 5, 'V', 'Petite ronde', 'Villageoises, petites pièces infantines: V. Petite ronde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb09b3a-b06f-439d-8612-2eaa88fcba62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33b282fd-77f2-4a0e-b0ae-ce2b882bb30b', 6, 'VI', 'Coda', 'Villageoises, petites pièces infantines: VI. Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 107 AND p.title = 'Villageoises, petites pièces infantines, for piano, FP 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b282fd-77f2-4a0e-b0ae-ce2b882bb30b'
);


-- 카탈로그에 대응이 없는 seed 작품 22개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 107 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7603, 7734, 7844, 7871, 7980, 8074, 8134, 8172, 8492, 8719, 9100, 9275, 9312, 9335, 9503, 9862, 9972, 10136, 10399, 10529,
    10736, 10934
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
